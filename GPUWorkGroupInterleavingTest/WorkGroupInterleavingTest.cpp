#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <getopt.h>
#include <sys/time.h>
#include <time.h>
#include <math.h>
#include <limits.h>
#include <float.h>

#ifdef __APPLE__
#include <OpenCL/cl.h>
#else
#include <CL/cl.h>
#endif


/* Macros */
#define CL_FILE_NAME "WorkGroupInterleavingTest.cl"
#define PTX_FILE_NAME "WorkGroupInterleavingTest.ptx"
#define COMPUTE_KERNEL_NAME "ComputeTask"
#define MEMORY_KERNEL_NAME "MemoryTask"
#define COMPUTE_DATA_SIZE 10
#define MEMORY_DATA_SIZE 128
#define INTERVAL 10
#define POWER_LOG_FILE_LEN 200

#define CHECK_CL_ERROR(error)                                                                                                       \
        do                                                                                                                          \
        {                                                                                                                           \
            if ((error))                                                                                                            \
            {                                                                                                                       \
                fprintf(stderr, "OpenCL API error %d, in %s:%d, function '%s'\n", (error), __FILE__, __LINE__, __FUNCTION__);       \
                exit(1);                                                                                                            \
            }                                                                                                                       \
        } while(0)


enum ExecutionMode
{
    COMPUTE_ONLY = 0,
    MEMORY_ONLY,
    ALL
};

/* Control struct */
struct OpenCL_Ctrl
{
    int platform_id;
    int device_id;
    int global_size;
    int local_size;
    ExecutionMode executionMode;
    int computeIteration;
    int computeDataSize;
    int memoryDataSize;
    int memoryIteration;
    int interval;
    char powerFile[POWER_LOG_FILE_LEN];

    OpenCL_Ctrl() : platform_id(0), device_id(0), global_size(1024), local_size(32), computeIteration(1000), memoryIteration(1000), executionMode(ALL), interval(INTERVAL)
    {
        sprintf(powerFile, "KernelExecution.log");
    }

}  g_opencl_ctrl;

void PrintTimingInfo(FILE* fptr)
{
    struct timeval current;
    unsigned long long curr_time;

    gettimeofday(&current, NULL);
    curr_time = current.tv_sec * 1000 + current.tv_usec / 1000;

    fprintf(fptr, "%llu\n", curr_time);
}

void CommandParser(int argc, char *argv[])
{
    char* short_options = strdup("p:d:g:l:o:M:c:m:");
    struct option long_options[] =
    {
        {"platformID", required_argument, NULL, 'p'},
        {"deviceID", required_argument, NULL, 'd'},
        {"globalSize", required_argument, NULL, 'g'},
        {"localSize", required_argument, NULL, 'l'},
        {"executeMode", required_argument, NULL, 'M'},
        {"computeIteration", required_argument, NULL, 'c'},
        {"memoryIteration", required_argument, NULL, 'm'},
        {"powerLogFile", required_argument, NULL, 'o'},
        /* option end */
        {0, 0, 0, 0}
    };
    int cmd;
    int optionIdx;
    while(1)
    {
        cmd = getopt_long(argc, argv, short_options, long_options, &optionIdx);

        /* finish parsing */
        if (cmd == -1)
            break;

        switch (cmd)
        {
            case 'o':
                sprintf(g_opencl_ctrl.powerFile, "%s", optarg);
                break;

            case 'g':
                g_opencl_ctrl.global_size = atoi(optarg);
                break;

            case 'l':
                g_opencl_ctrl.local_size = atoi(optarg);
                break;

            case 'p':
                g_opencl_ctrl.platform_id = atoi(optarg);
                break;

            case 'd':
                g_opencl_ctrl.device_id = atoi(optarg);
                break;

            case 'M':
                g_opencl_ctrl.executionMode = (ExecutionMode)atoi(optarg);
                break;

            case 'c':
                g_opencl_ctrl.computeIteration = atoi(optarg);
                break;
            
            case 'm':
                g_opencl_ctrl.memoryIteration = atoi(optarg);
                break;

            case '?':
                fprintf(stderr, "Unknown option -%c\n", optopt);
                break;

            /* should not be here */
            default:
                break;
        }
    }

    g_opencl_ctrl.computeDataSize = COMPUTE_DATA_SIZE * g_opencl_ctrl.global_size;
    g_opencl_ctrl.memoryDataSize = MEMORY_DATA_SIZE * g_opencl_ctrl.global_size;
    free (short_options);
}

void GetPlatformAndDevice(cl_platform_id & target_platform, cl_device_id & target_device)
{
    cl_platform_id* platforms;
    cl_device_id* devices;
    cl_uint count;
    cl_int error;
    size_t length;

    char *queryString;

    /* Find platform */
    error = clGetPlatformIDs(0, NULL, &count);
    CHECK_CL_ERROR(error);

    platforms = (cl_platform_id *)malloc(sizeof(cl_platform_id) * count);
    clGetPlatformIDs(count, platforms, NULL);

    if (g_opencl_ctrl.platform_id >= count)
        {fprintf(stderr, "Error: Cannot find selected platform\n"); exit(1);}
    target_platform = platforms[g_opencl_ctrl.platform_id];

    /* Find device */
    error = clGetDeviceIDs(target_platform, CL_DEVICE_TYPE_ALL, 0, NULL, &count);
    CHECK_CL_ERROR(error);

    devices = (cl_device_id *)malloc(sizeof(cl_device_id) * count);
    clGetDeviceIDs(target_platform, CL_DEVICE_TYPE_ALL, count, devices, NULL);

    if (g_opencl_ctrl.device_id >= count)
        {fprintf(stderr, "Error: Cannot find selected device\n"); exit(1);}
    target_device = devices[g_opencl_ctrl.device_id];

    /* Get device name */
    error = clGetDeviceInfo(target_device, CL_DEVICE_NAME, 0, NULL, &length);
    CHECK_CL_ERROR(error);

    queryString = (char *)malloc(sizeof(char) * length);
    clGetDeviceInfo(target_device, CL_DEVICE_NAME, length, queryString, NULL);
    fprintf(stderr, "Device selected: '%s'\n", queryString);

    {
        cl_uint vectorSize;
        error = clGetDeviceInfo(target_device, CL_DEVICE_PREFERRED_VECTOR_WIDTH_CHAR, sizeof(vectorSize), &vectorSize, NULL);
        CHECK_CL_ERROR(error);
        fprintf(stderr, "Preferred char vector width : %u\n", vectorSize);

        error = clGetDeviceInfo(target_device, CL_DEVICE_PREFERRED_VECTOR_WIDTH_INT, sizeof(vectorSize), &vectorSize, NULL);
        CHECK_CL_ERROR(error);
        fprintf(stderr, "Preferred int vector width : %u\n", vectorSize);

        error = clGetDeviceInfo(target_device, CL_DEVICE_PREFERRED_VECTOR_WIDTH_FLOAT, sizeof(vectorSize), &vectorSize, NULL);
        CHECK_CL_ERROR(error);
        fprintf(stderr, "Preferred float vector width : %u\n", vectorSize);

        error = clGetDeviceInfo(target_device, CL_DEVICE_PREFERRED_VECTOR_WIDTH_DOUBLE, sizeof(vectorSize), &vectorSize, NULL);
        CHECK_CL_ERROR(error);
        fprintf(stderr, "Preferred double vector width : %u\n", vectorSize);
    }

    /* Free the space */
    free(platforms);
    free(devices);
    free(queryString);
}

void CreateAndBuildProgram(cl_program &target_program, cl_context context, cl_device_id device, char *fileName)
{
    FILE *fptr;
    size_t programSize;
    char *programSource;
    cl_int error, binaryError;

    fptr = fopen(fileName, "r");
    if (fptr == NULL)
    {
        fprintf(stderr, "No such file: '%s'\n", fileName);
        exit(1);
    }

    /* Read program source */
    fseek(fptr, 0, SEEK_END);
    programSize = ftell(fptr);
    rewind(fptr);

    programSource = (char *)malloc(sizeof(char) * (programSize + 1));
    programSource[programSize] = '\0';
    fread(programSource, sizeof(unsigned char), programSize, fptr);
    fclose(fptr);

    /* Create and build cl_program object */
    target_program = clCreateProgramWithSource(context, 1, (const char **)(&programSource), &programSize, &error);
    CHECK_CL_ERROR(error);
    free(programSource);

    error = clBuildProgram(target_program, 1, &device, "-D COMPUTE_DATA_SIZE=10", NULL, NULL);
    if (error < 0)
    {
        size_t logSize;
        char *programBuildLog;

        error = clGetProgramBuildInfo(target_program, device, CL_PROGRAM_BUILD_LOG, 0, NULL, &logSize);
        CHECK_CL_ERROR(error);
        programBuildLog = (char *)malloc(sizeof(char) * (logSize + 1));
        error = clGetProgramBuildInfo(target_program, device, CL_PROGRAM_BUILD_LOG, logSize + 1, programBuildLog, NULL);
        CHECK_CL_ERROR(error);

        fprintf(stderr, "%s\n", programBuildLog);
        free(programBuildLog);
        exit(1);
    }

#if 1
    {
        size_t binarySize;
        error = clGetProgramInfo(target_program, CL_PROGRAM_BINARY_SIZES, sizeof(size_t), &binarySize, NULL);
        CHECK_CL_ERROR(error);

        unsigned char *binary = (unsigned char *) malloc(sizeof(unsigned char) * binarySize);
        error = clGetProgramInfo(target_program, CL_PROGRAM_BINARIES, binarySize, &binary, NULL);
        CHECK_CL_ERROR(error);

        FILE *fptr = fopen(PTX_FILE_NAME, "w");
        fprintf(fptr, "%s", binary);
        fclose(fptr);
    }
#endif

    free(fileName);
}

void ComputeDataCreation(void* &computeData)
{
    computeData = malloc(g_opencl_ctrl.computeDataSize * sizeof(int));
    {
        int *tmp;
        tmp = (int *)computeData;
        for (int i = 0 ; i < COMPUTE_DATA_SIZE * g_opencl_ctrl.global_size ; i ++)
        {
            tmp[i] = (rand() % INT_MAX);
            tmp[i] += (tmp[i] % 2) + 1;
        }
    }
}

void MemoryDataCreation(void* &memoryData, cl_mem kernelBuffer)
{
    srand(time(NULL));
    memoryData = malloc(g_opencl_ctrl.memoryDataSize * sizeof(cl_ulong));
    {
        cl_ulong *tmp, *kernel;
        tmp = (cl_ulong *)memoryData;
        kernel = (cl_ulong *)kernelBuffer;
        for (int i = 0 ; i < g_opencl_ctrl.global_size ; i ++)
        {
            tmp[(MEMORY_DATA_SIZE - 1) * g_opencl_ctrl.global_size + i] = kernel[i];
        }
        for (int i = MEMORY_DATA_SIZE - 2 ; i >= 0 ; i -- )
        {
            for (int j = 0 ; j < g_opencl_ctrl.global_size ; j ++)
            {
                tmp[i * g_opencl_ctrl.global_size + j] = tmp[(i+1) * g_opencl_ctrl.global_size + j];
            }
        }
    }
}

int main(int argc, char *argv[])
{
    cl_platform_id platform;
    cl_device_id device;
    cl_context context;
    cl_command_queue command_queue;
    cl_program program;
    cl_kernel memoryKernel, computeKernel;
    cl_mem memoryBuffer, computeBuffer;
    cl_int error;
    cl_event computeEvent, memoryEvent;
    cl_ulong queueTime, submitTime, startTime, endTime;
    size_t globalSize[1], localSize[1], warpSize;
    //FILE* fptr;

    void* memoryData = NULL;
    void* computeData = NULL;
    srand(time(NULL));

    /* Parse options */
    CommandParser(argc, argv);
    ComputeDataCreation(computeData);

    GetPlatformAndDevice(platform, device);
    //fptr = fopen(g_opencl_ctrl.powerFile, "w");

    /* Create context */
    context = clCreateContext(NULL, 1, &device, NULL, NULL, &error);
    CHECK_CL_ERROR(error);

    /* Create command queue */
    command_queue = clCreateCommandQueue(context, device, CL_QUEUE_PROFILING_ENABLE, &error);
    CHECK_CL_ERROR(error);

    /* Create program */
    CreateAndBuildProgram(program, context, device, strdup(CL_FILE_NAME));

    /* Create kernels */
    computeKernel = clCreateKernel(program, COMPUTE_KERNEL_NAME, &error);
    CHECK_CL_ERROR(error);
    memoryKernel = clCreateKernel(program, MEMORY_KERNEL_NAME, &error);
    CHECK_CL_ERROR(error);

    /* Create buffers */
    computeBuffer = clCreateBuffer(context, CL_MEM_READ_WRITE | CL_MEM_COPY_HOST_PTR, g_opencl_ctrl.computeDataSize * sizeof(int), computeData, &error);
    CHECK_CL_ERROR(error);
    memoryBuffer = clCreateBuffer(context, CL_MEM_READ_WRITE, g_opencl_ctrl.memoryDataSize * sizeof(cl_ulong), NULL, &error);
    CHECK_CL_ERROR(error);
    //MemoryDataCreation(memoryData, memoryBuffer);
    
    /* Wrtie buffer */
    //error = clEnqueueWriteBuffer(command_queue, memoryBuffer, CL_TRUE, 0, g_opencl_ctrl.memoryDataSize * sizeof(cl_ulong), memoryData, 0, NULL, NULL);
    //CHECK_CL_ERROR(error);
    
    /* Execute kernels */
    error = clSetKernelArg(computeKernel, 0, sizeof(cl_mem), &computeBuffer);
    CHECK_CL_ERROR(error);
    error = clSetKernelArg(computeKernel, 1, sizeof(int), &g_opencl_ctrl.computeIteration);
    CHECK_CL_ERROR(error);

    error = clSetKernelArg(memoryKernel, 0, sizeof(cl_mem), &memoryBuffer);
    CHECK_CL_ERROR(error);
    error = clSetKernelArg(memoryKernel, 1, sizeof(int), &g_opencl_ctrl.memoryIteration);
    CHECK_CL_ERROR(error);

    //PrintTimingInfo(fptr);

    globalSize[0] = g_opencl_ctrl.global_size;
    localSize[0] = g_opencl_ctrl.local_size;
    
    if (g_opencl_ctrl.executionMode == ALL || g_opencl_ctrl.executionMode == COMPUTE_ONLY)
    {
        error = clEnqueueNDRangeKernel(command_queue, computeKernel, 1, NULL, globalSize, localSize, 0, NULL, &computeEvent);
        CHECK_CL_ERROR(error);
    }
     
    if (g_opencl_ctrl.executionMode == ALL || g_opencl_ctrl.executionMode == MEMORY_ONLY)
    {
        error = clEnqueueNDRangeKernel(command_queue, memoryKernel, 1, NULL, globalSize, localSize, 0, NULL, &memoryEvent);
        CHECK_CL_ERROR(error);
    }
    
    error = clFinish(command_queue);
    CHECK_CL_ERROR(error);

    //PrintTimingInfo(fptr);
    //fclose(fptr);
    
    /* Event profiling */
    if (g_opencl_ctrl.executionMode == ALL || g_opencl_ctrl.executionMode == COMPUTE_ONLY)
    {
        error = clGetEventProfilingInfo(computeEvent, CL_PROFILING_COMMAND_QUEUED, sizeof(queueTime), &queueTime, NULL);
        CHECK_CL_ERROR(error);
        error = clGetEventProfilingInfo(computeEvent, CL_PROFILING_COMMAND_SUBMIT, sizeof(submitTime), &submitTime, NULL);
        CHECK_CL_ERROR(error);
        error = clGetEventProfilingInfo(computeEvent, CL_PROFILING_COMMAND_START, sizeof(startTime), &startTime, NULL);
        CHECK_CL_ERROR(error);
        error = clGetEventProfilingInfo(computeEvent, CL_PROFILING_COMMAND_END, sizeof(endTime), &endTime, NULL);
        CHECK_CL_ERROR(error);
        fprintf(stderr, "compute queued @ %lu\n", queueTime);
        fprintf(stderr, "compute submit @ %lu\n", queueTime);
        fprintf(stderr, "compute start  @ %lu\n", startTime);
        fprintf(stderr, "compute end    @ %lu\n", endTime);
        fprintf(stderr, "compute duration %lu\n\n", endTime - startTime);
        clReleaseEvent(computeEvent);
    }
    
    if (g_opencl_ctrl.executionMode == ALL || g_opencl_ctrl.executionMode == MEMORY_ONLY)
    {
        error = clGetEventProfilingInfo(memoryEvent, CL_PROFILING_COMMAND_QUEUED, sizeof(queueTime), &queueTime, NULL);
        CHECK_CL_ERROR(error);
        error = clGetEventProfilingInfo(memoryEvent, CL_PROFILING_COMMAND_SUBMIT, sizeof(submitTime), &submitTime, NULL);
        CHECK_CL_ERROR(error);
        error = clGetEventProfilingInfo(memoryEvent, CL_PROFILING_COMMAND_START, sizeof(startTime), &startTime, NULL);
        CHECK_CL_ERROR(error);
        error = clGetEventProfilingInfo(memoryEvent, CL_PROFILING_COMMAND_END, sizeof(endTime), &endTime, NULL);
        CHECK_CL_ERROR(error);
        fprintf(stderr, "memory queued @ %lu\n", queueTime);
        fprintf(stderr, "memory submit @ %lu\n", queueTime);
        fprintf(stderr, "memory start  @ %lu\n", startTime);
        fprintf(stderr, "memory end    @ %lu\n", endTime);
        fprintf(stderr, "memory duration %lu\n\n", endTime - startTime);
        clReleaseEvent(memoryEvent);
    }

    /* Read the output */

    /* Release object */
    clReleaseKernel(computeKernel);
    clReleaseKernel(memoryKernel);
    clReleaseMemObject(computeBuffer);
    clReleaseMemObject(memoryBuffer);
    clReleaseProgram(program);
    clReleaseCommandQueue(command_queue);
    clReleaseContext(context);
    free(computeData);
    free(memoryData);

    return 0;
}
