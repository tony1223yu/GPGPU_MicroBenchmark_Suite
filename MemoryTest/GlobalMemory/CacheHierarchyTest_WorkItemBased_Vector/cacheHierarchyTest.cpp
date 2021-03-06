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
//#define USE_CL_2_0_API
#define CL_FILE_NAME "cacheHierarchyTest.cl"
#define BINARY_FILE_NAME "cacheHierarchyTest.bin"
#define KERNEL_1 "GeneratePattern"
#define KERNEL_2 "Process"
#define POWER_LOG_FILE_LEN 300

#define CHECK_CL_ERROR(error)                                                                                                       \
        do                                                                                                                          \
        {                                                                                                                           \
            if ((error))                                                                                                            \
            {                                                                                                                       \
                fprintf(stderr, "OpenCL API error %d, in %s:%d, function '%s'\n", (error), __FILE__, __LINE__, __FUNCTION__);       \
                exit(1);                                                                                                            \
            }                                                                                                                       \
        } while(0)


/* Control struct */
struct OpenCL_Ctrl
{
    int platform_id;
    int device_id;
    long dataByte;
    long iteration;
    int size;
    int stride;
    long offset;
    int globalSize;
    int localSize;
    int vector;
    char powerFile[POWER_LOG_FILE_LEN];

    OpenCL_Ctrl() : vector(1), platform_id(0), device_id(0), size(1), stride(1), iteration(1), globalSize(1), localSize(1), offset(1) {sprintf(powerFile, "KernelExecution.log");} 
    ~OpenCL_Ctrl() {}

} g_opencl_ctrl;

unsigned long long PrintTimingInfo(FILE* fptr)
{
    struct timeval current;
    unsigned long long curr_time;

    gettimeofday(&current, NULL);
    curr_time = current.tv_sec * 1000 + current.tv_usec / 1000;

    fprintf(fptr, "%llu\n", curr_time);
    return (current.tv_sec * 1000000 + current.tv_usec);
}


void CommandParser(int argc, char *argv[])
{
    char* short_options = strdup("p:d:s:n:i:o:g:l:V:");
    struct option long_options[] =
    {
        {"platformID", required_argument, NULL, 'p'},
        {"deviceID", required_argument, NULL, 'd'},
        {"iteration", required_argument, NULL, 'i'},
        {"number", required_argument, NULL, 'n'},
        {"stride", required_argument, NULL, 's'},
        {"powerLogFile", required_argument, NULL, 'o'},
        {"globalSize", required_argument, NULL, 'g'},
        {"localSize", required_argument, NULL, 'l'},
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
            case 'V':
                g_opencl_ctrl.vector = atoi(optarg);
                break;

            case 'g':
                g_opencl_ctrl.globalSize = atoi(optarg);
                break;

            case 'l':
                g_opencl_ctrl.localSize = atoi(optarg);
                break;

            case 'o':
                sprintf(g_opencl_ctrl.powerFile, "%s", optarg);
                break;
            
            case 'n':
                g_opencl_ctrl.size = atoi(optarg);
                break;

            case 's':
                g_opencl_ctrl.stride = atoi(optarg);
                break;

            case 'i':
                g_opencl_ctrl.iteration = atol(optarg);
                break;

            case 'p':
                g_opencl_ctrl.platform_id = atoi(optarg);
                break;

            case 'd':
                g_opencl_ctrl.device_id = atoi(optarg);
                break;

            case '?':
                fprintf(stderr, "Unknown option -%c\n", optopt);
                break;

            /* should not be here */
            default:
                break;
        }
    }

    g_opencl_ctrl.dataByte = sizeof(cl_ulong) * (long)(g_opencl_ctrl.stride) * (long)(g_opencl_ctrl.size) * (long)(g_opencl_ctrl.globalSize) * g_opencl_ctrl.vector;
    g_opencl_ctrl.offset = (long)(g_opencl_ctrl.stride) * (long)(g_opencl_ctrl.size);

    fprintf(stderr, "Total buffer size: %ld\n", g_opencl_ctrl.dataByte);

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
    error = clGetDeviceInfo(target_device, CL_DEVICE_NAME, length, queryString, NULL);
    CHECK_CL_ERROR(error);
    fprintf(stderr, "Device selected: '%s'\n", queryString);

#if 1
    {
        cl_ulong global_cache_size;
        cl_device_mem_cache_type global_cache_type;
        cl_uint global_cache_line_size;
        cl_ulong global_memory_size;
        
        error = clGetDeviceInfo(target_device, CL_DEVICE_GLOBAL_MEM_SIZE, sizeof(global_memory_size), &global_memory_size, NULL);
        CHECK_CL_ERROR(error);
        error = clGetDeviceInfo(target_device, CL_DEVICE_GLOBAL_MEM_CACHE_SIZE, sizeof(global_cache_size), &global_cache_size, NULL);
        CHECK_CL_ERROR(error);
        error = clGetDeviceInfo(target_device, CL_DEVICE_GLOBAL_MEM_CACHELINE_SIZE, sizeof(global_cache_line_size), &global_cache_line_size, NULL);
        CHECK_CL_ERROR(error);
        error = clGetDeviceInfo(target_device, CL_DEVICE_GLOBAL_MEM_CACHE_TYPE, sizeof(global_cache_type), &global_cache_type, NULL);
        CHECK_CL_ERROR(error);

        fprintf(stderr, "Global memory size:            %lu B\n", global_memory_size);
        fprintf(stderr, "Global memory cache size:      %lu B\n", global_cache_size);
        fprintf(stderr, "Global memory cache line size: %u B\n", global_cache_line_size);
        fprintf(stderr, "Global memory cache type:      ");
        if (global_cache_type == CL_READ_ONLY_CACHE)
            fprintf(stderr, "Read Only\n");
        else if (global_cache_type == CL_READ_WRITE_CACHE)
            fprintf(stderr, "Read Write\n");
    }
#endif

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

    error = clBuildProgram(target_program, 1, &device, "-cl-opt-disable", NULL, NULL);
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

void HostDataCreation(void* &data)
{
    srand(time(NULL));
    data = malloc(g_opencl_ctrl.dataByte);
    
    for (int i = 0 ; i < g_opencl_ctrl.size * g_opencl_ctrl.stride * g_opencl_ctrl.globalSize ; i ++)
        ((long *)(data))[i] = 0;
}

int main(int argc, char *argv[])
{
    cl_platform_id platform;
    cl_device_id device;
    cl_context context;
    cl_command_queue command_queue;
    cl_program program;
    cl_kernel kernel1, kernel2;
    cl_mem buffer;
    cl_int error;
    cl_event event;
    cl_ulong startTime, endTime;
    size_t globalSize[1], localSize[1], warpSize;
    char fileName[100];
    unsigned long long start, end;
    FILE* fptr;

    void* hostData = NULL;

    /* Parse options */
    CommandParser(argc, argv);
    HostDataCreation(hostData);

    GetPlatformAndDevice(platform, device);
    fptr = fopen(g_opencl_ctrl.powerFile, "a");

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
    sprintf(fileName, "cacheHierarchyTest_%d.cl", g_opencl_ctrl.vector);
    CreateAndBuildProgram(program, context, device, strdup(fileName));

    /* Create kernels */
    kernel1 = clCreateKernel(program, KERNEL_1, &error);
    CHECK_CL_ERROR(error);
    kernel2 = clCreateKernel(program, KERNEL_2, &error);
    CHECK_CL_ERROR(error);

    error = clGetKernelWorkGroupInfo(kernel1, device, CL_KERNEL_PREFERRED_WORK_GROUP_SIZE_MULTIPLE, sizeof(size_t), &warpSize, NULL);
    CHECK_CL_ERROR(error);

    /* Create buffers */
    buffer = clCreateBuffer(context, CL_MEM_READ_WRITE | CL_MEM_COPY_HOST_PTR, g_opencl_ctrl.dataByte, hostData, &error);
    CHECK_CL_ERROR(error);

    /* Execute kernels */
    error = clSetKernelArg(kernel1, 0, sizeof(cl_mem), &buffer);
    CHECK_CL_ERROR(error);
    error = clSetKernelArg(kernel1, 1, sizeof(int), &g_opencl_ctrl.size);
    CHECK_CL_ERROR(error);
    error = clSetKernelArg(kernel1, 2, sizeof(int), &g_opencl_ctrl.stride);
    CHECK_CL_ERROR(error);
    
    error = clSetKernelArg(kernel2, 0, sizeof(cl_mem), &buffer);
    CHECK_CL_ERROR(error);
    error = clSetKernelArg(kernel2, 1, sizeof(long), &g_opencl_ctrl.iteration);
    CHECK_CL_ERROR(error);
    error = clSetKernelArg(kernel2, 2, sizeof(long), &g_opencl_ctrl.offset);
    CHECK_CL_ERROR(error);

    globalSize[0] = g_opencl_ctrl.globalSize;
    localSize[0] = g_opencl_ctrl.localSize;
    
    error = clEnqueueNDRangeKernel(command_queue, kernel1, 1, NULL, globalSize, localSize, 0, NULL, NULL);
    CHECK_CL_ERROR(error);
    error = clFinish(command_queue);
    CHECK_CL_ERROR(error);
    
    start = PrintTimingInfo(fptr);

    error = clEnqueueNDRangeKernel(command_queue, kernel2, 1, NULL, globalSize, localSize, 0, NULL, &event);
    CHECK_CL_ERROR(error);
    error = clFinish(command_queue);
    CHECK_CL_ERROR(error);

    end = PrintTimingInfo(fptr);
    fclose(fptr);

    error = clEnqueueReadBuffer(command_queue, buffer, CL_TRUE, 0, g_opencl_ctrl.dataByte, hostData, 0, NULL, NULL);
    CHECK_CL_ERROR(error);

#if 0
    long *currData;
    for (int i = 0 ; i < g_opencl_ctrl.globalSize ; i ++)
    {
        currData = ((long *)(hostData)) + i * g_opencl_ctrl.stride * g_opencl_ctrl.size;
        for (int id = 0 ; id < g_opencl_ctrl.stride * g_opencl_ctrl.size ; id ++)
            printf("%lu ", ((long *)(currData))[id]);
        printf("\n");
    }
#endif

    /* Event profiling */
    error = clGetEventProfilingInfo(event, CL_PROFILING_COMMAND_START, sizeof(startTime), &startTime, NULL);
    CHECK_CL_ERROR(error);
    error = clGetEventProfilingInfo(event, CL_PROFILING_COMMAND_END, sizeof(endTime), &endTime, NULL);
    CHECK_CL_ERROR(error);
    fprintf(stderr, "\n['Process' execution time] %llu ns\n", (end - start) * 1000);
    fprintf(stdout, "%llu\n", (end - start) * 1000);

    /* Read the output */

    /* Release object */
    clReleaseKernel(kernel1);
    clReleaseKernel(kernel2);
    clReleaseMemObject(buffer);
    clReleaseEvent(event);
    clReleaseProgram(program);
    clReleaseCommandQueue(command_queue);
    clReleaseContext(context);
    free(hostData);

    return 0;
}
