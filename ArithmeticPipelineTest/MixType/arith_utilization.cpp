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
#define CL_FILE_NAME "arith_utilization.cl"
#define BINARY_FILE_NAME "arith_utilization.bin"
#define DATA_SIZE 160
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


enum DATA_TYPE
{
    TYPE_INT = 0,
    TYPE_DOUBLE
};

/* Control struct */
struct OpenCL_Ctrl
{
    int platform_id;
    int device_id;
    int dataByteInt;
    int dataByteFloat;
    int dataByteDouble;
    int global_size;
    int local_size;
    int interval;
    long iteration;
    char *kernelName;
    char powerFile[POWER_LOG_FILE_LEN];

    OpenCL_Ctrl() : platform_id(0), device_id(0), global_size(1024), local_size(32), iteration(1000), kernelName(NULL), interval(INTERVAL) {sprintf(powerFile, "KernelExecution.log");}
    ~OpenCL_Ctrl()
    {
        if (kernelName)
            free(kernelName);
    }

} g_opencl_ctrl;

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
    char* short_options = strdup("p:d:i:g:l:k:o:");
    struct option long_options[] =
    {
        {"platformID", required_argument, NULL, 'p'},
        {"deviceID", required_argument, NULL, 'd'},
        {"iteration", required_argument, NULL, 'i'},
        {"globalSize", required_argument, NULL, 'g'},
        {"localSize", required_argument, NULL, 'l'},
        {"kernelName", required_argument, NULL, 'k'},
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

            case 'k':
                g_opencl_ctrl.kernelName = strdup(optarg);
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

            case 'i':
                g_opencl_ctrl.iteration = atol(optarg);
                break;

            case '?':
                fprintf(stderr, "Unknown option -%c\n", optopt);
                break;

            /* should not be here */
            default:
                break;
        }
    }

    if (g_opencl_ctrl.kernelName == NULL)
    {
        fprintf(stderr, "executable -k <kernelName> -t <dataType> [...]\n");
        exit(1);
    }

    g_opencl_ctrl.dataByteInt = DATA_SIZE * sizeof(int) * g_opencl_ctrl.global_size;
    g_opencl_ctrl.dataByteFloat = DATA_SIZE * sizeof(float) * g_opencl_ctrl.global_size;
    g_opencl_ctrl.dataByteDouble = DATA_SIZE * sizeof(double) * g_opencl_ctrl.global_size;

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
    unsigned char *programSource;
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

    programSource = (unsigned char *)malloc(sizeof(unsigned char) * (programSize + 1));
    programSource[programSize] = '\0';
    fread(programSource, sizeof(unsigned char), programSize, fptr);
    fclose(fptr);

    /* Create and build cl_program object */
    target_program = clCreateProgramWithSource(context, 1, (const char **)(&programSource), &programSize, &error);
    CHECK_CL_ERROR(error);
    free(programSource);

    error = clBuildProgram(target_program, 1, &device, NULL, NULL, NULL);
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

#if 0
    {
        size_t binarySize;
        error = clGetProgramInfo(target_program, CL_PROGRAM_BINARY_SIZES, sizeof(size_t), &binarySize, NULL);
        CHECK_CL_ERROR(error);

        unsigned char *binary = (unsigned char *) malloc(sizeof(unsigned char) * binarySize);
        error = clGetProgramInfo(target_program, CL_PROGRAM_BINARIES, binarySize, &binary, NULL);
        CHECK_CL_ERROR(error);

        FILE *fptr = fopen(BINARY_FILE_NAME, "w");
        fprintf(fptr, "%s", binary);
        fclose(fptr);
    }
#endif

    free(fileName);
}

void HostDataCreation(void* &dataInt, void* &dataFloat, void* &dataDouble)
{
    srand(time(NULL));
    dataInt = malloc(g_opencl_ctrl.dataByteInt);
    dataFloat = malloc(g_opencl_ctrl.dataByteFloat);
    dataDouble = malloc(g_opencl_ctrl.dataByteDouble);
    {
        int *tmp;
        tmp = (int *)dataInt;
        for (int i = 0 ; i < DATA_SIZE * g_opencl_ctrl.global_size ; i ++)
        {
            tmp[i] = (rand() % INT_MAX);
            tmp[i] += (tmp[i] % 2) + 1;
        }
    }
    {
        float *tmp;
        tmp = (float *)dataFloat;
        for (int i = 0 ; i < DATA_SIZE * g_opencl_ctrl.global_size ; i ++)
        {
            tmp[i] = ((float)(rand()) / RAND_MAX) * 1e5;
            if (i % 2 == 0)
                tmp[i] *= -1;
        }
    }
    {
        double *tmp;
        tmp = (double *)dataDouble;
        for (int i = 0 ; i < DATA_SIZE * g_opencl_ctrl.global_size ; i ++)
        {
            tmp[i] = ((double)(rand()) / RAND_MAX) * 1e100;
            if (i % 2 == 0)
                tmp[i] *= -1;
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
    cl_kernel kernel;
    cl_mem bufferInt, bufferFloat, bufferDouble;
    cl_int error;
    cl_event event;
    cl_ulong startTime, endTime;
    size_t globalSize[1], localSize[1], warpSize;
    FILE* fptr;
    unsigned long long start, end;

    void* hostDataInt = NULL;
    void* hostDataFloat = NULL;
    void* hostDataDouble = NULL;

    /* Parse options */
    CommandParser(argc, argv);
    HostDataCreation(hostDataInt, hostDataFloat, hostDataDouble);

    GetPlatformAndDevice(platform, device);
    fptr = fopen(g_opencl_ctrl.powerFile, "w");

    /* Create context */
    context = clCreateContext(NULL, 1, &device, NULL, NULL, &error);
    CHECK_CL_ERROR(error);

    /* Create command queue */
#ifdef USE_CL_2_0_API
    {
        cl_queue_properties property[] = {CL_QUEUE_PROPERTIES, CL_QUEUE_PROFILING_ENABLE, 0};
        command_queue = clCreateCommandQueueWithProperties(context, device, property, &error);
    }
#else
    {
        command_queue = clCreateCommandQueue(context, device, CL_QUEUE_PROFILING_ENABLE, &error);
    }
#endif
    CHECK_CL_ERROR(error);

    /* Create program */
    CreateAndBuildProgram(program, context, device, strdup(CL_FILE_NAME));

    /* Create kernels */
    kernel = clCreateKernel(program, g_opencl_ctrl.kernelName, &error);
    CHECK_CL_ERROR(error);

    error = clGetKernelWorkGroupInfo(kernel, device, CL_KERNEL_PREFERRED_WORK_GROUP_SIZE_MULTIPLE, sizeof(size_t), &warpSize, NULL);
    CHECK_CL_ERROR(error);

#if 0
    fprintf(stderr, "\nData before process:\n");
    {
        int *intptr = (int *)(hostDataInt);
        for (int i = 0 ; i < DATA_SIZE * g_opencl_ctrl.global_size ; i ++)
            fprintf(stderr, "%d ", intptr[i]);
        fprintf(stderr, "\n");
    }
    {
        float *fltptr = (float *)(hostDataFloat);
        for (int i = 0 ; i < DATA_SIZE * g_opencl_ctrl.global_size ; i ++)
            fprintf(stderr, "%f ", fltptr[i]);
        fprintf(stderr, "\n");
    }
    {
        double *dblptr = (double *)(hostDataDouble);
        for (int i = 0 ; i < DATA_SIZE * g_opencl_ctrl.global_size ; i ++)
            fprintf(stderr, "%lf ", dblptr[i]);
        fprintf(stderr, "\n");
    }
#endif

    /* Create buffers */
    bufferInt = clCreateBuffer(context, CL_MEM_READ_WRITE | CL_MEM_COPY_HOST_PTR, g_opencl_ctrl.dataByteInt, hostDataInt, &error);
    CHECK_CL_ERROR(error);
    bufferFloat = clCreateBuffer(context, CL_MEM_READ_WRITE | CL_MEM_COPY_HOST_PTR, g_opencl_ctrl.dataByteFloat, hostDataFloat, &error);
    CHECK_CL_ERROR(error);
    bufferDouble = clCreateBuffer(context, CL_MEM_READ_WRITE | CL_MEM_COPY_HOST_PTR, g_opencl_ctrl.dataByteDouble, hostDataDouble, &error);
    CHECK_CL_ERROR(error);

    /* Execute kernels */
    error = clSetKernelArg(kernel, 0, sizeof(cl_mem), &bufferInt);
    CHECK_CL_ERROR(error);
    error = clSetKernelArg(kernel, 1, sizeof(cl_mem), &bufferFloat);
    CHECK_CL_ERROR(error);
    error = clSetKernelArg(kernel, 2, sizeof(cl_mem), &bufferDouble);
    CHECK_CL_ERROR(error);
    error = clSetKernelArg(kernel, 3, sizeof(long), &g_opencl_ctrl.iteration);
    CHECK_CL_ERROR(error);
    error = clSetKernelArg(kernel, 4, sizeof(int), &g_opencl_ctrl.interval);
    CHECK_CL_ERROR(error);

    start = PrintTimingInfo(fptr);

    globalSize[0] = g_opencl_ctrl.global_size;
    localSize[0] = g_opencl_ctrl.local_size;
    error = clEnqueueNDRangeKernel(command_queue, kernel, 1, NULL, globalSize, localSize, 0, NULL, &event);
    CHECK_CL_ERROR(error);
    error = clFinish(command_queue);
    CHECK_CL_ERROR(error);

    end = PrintTimingInfo(fptr);
    fclose(fptr);

    error = clEnqueueReadBuffer(command_queue, bufferInt, CL_TRUE, 0, g_opencl_ctrl.dataByteInt, hostDataInt, 0, NULL, NULL);
    CHECK_CL_ERROR(error);
    error = clEnqueueReadBuffer(command_queue, bufferFloat, CL_TRUE, 0, g_opencl_ctrl.dataByteFloat, hostDataFloat, 0, NULL, NULL);
    CHECK_CL_ERROR(error);
    error = clEnqueueReadBuffer(command_queue, bufferDouble, CL_TRUE, 0, g_opencl_ctrl.dataByteDouble, hostDataDouble, 0, NULL, NULL);
    CHECK_CL_ERROR(error);

#if 0
    fprintf(stderr, "\nData after process:\n");
    {
        int *intptr = (int *)(hostDataInt);
        for (int i = 0 ; i < DATA_SIZE * g_opencl_ctrl.global_size ; i ++)
            fprintf(stderr, "%d ", intptr[i]);
        fprintf(stderr, "\n");
    }
    {
        float *fltptr = (float *)(hostDataFloat);
        for (int i = 0 ; i < DATA_SIZE * g_opencl_ctrl.global_size ; i ++)
            fprintf(stderr, "%f ", fltptr[i]);
        fprintf(stderr, "\n");
    }
    {
        double *dblptr = (double *)(hostDataDouble);
        for (int i = 0 ; i < DATA_SIZE * g_opencl_ctrl.global_size ; i ++)
            fprintf(stderr, "%lf ", dblptr[i]);
        fprintf(stderr, "\n");
    }
#endif
    
    /* Event profiling */
    error = clGetEventProfilingInfo(event, CL_PROFILING_COMMAND_START, sizeof(startTime), &startTime, NULL);
    CHECK_CL_ERROR(error);
    error = clGetEventProfilingInfo(event, CL_PROFILING_COMMAND_END, sizeof(endTime), &endTime, NULL);
    CHECK_CL_ERROR(error);
    fprintf(stderr, "\n['%s' execution time] %llu ns\n", g_opencl_ctrl.kernelName, (end - start) * 1000);
    fprintf(stdout, "%llu\n", (end - start) * 1000);

    /* Read the output */

    /* Release object */
    clReleaseKernel(kernel);
    clReleaseMemObject(bufferInt);
    clReleaseMemObject(bufferFloat);
    clReleaseMemObject(bufferDouble);
    clReleaseEvent(event);
    clReleaseProgram(program);
    clReleaseCommandQueue(command_queue);
    clReleaseContext(context);
    free(hostDataInt);
    free(hostDataFloat);
    free(hostDataDouble);

    return 0;
}
