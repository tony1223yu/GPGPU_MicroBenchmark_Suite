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
#define CL_FILE_NAME "buffer_address.cl"
#define BINARY_FILE_NAME "buffer_address.bin"

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
    int dataByte;
    char *kernelName;

    OpenCL_Ctrl() : platform_id(0), device_id(0), kernelName(NULL) {} 
    ~OpenCL_Ctrl()
    {
        if (kernelName)
            free(kernelName);
    }

} g_opencl_ctrl;

void CommandParser(int argc, char *argv[])
{
    char* short_options = strdup("p:d:k:");
    struct option long_options[] =
    {
        {"platformID", required_argument, NULL, 'p'},
        {"deviceID", required_argument, NULL, 'd'},
        {"kernelName", required_argument, NULL, 'k'},
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
            case 'k':
                g_opencl_ctrl.kernelName = strdup(optarg);
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

    g_opencl_ctrl.dataByte = sizeof(cl_ulong) * 4;

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
    ((cl_ulong *)(data))[0] = 0x1234;
    ((cl_ulong *)(data))[1] = 0x5678;
    ((cl_ulong *)(data))[2] = 0x0000;
    ((cl_ulong *)(data))[3] = 0x0000;
}

int main(int argc, char *argv[])
{
    cl_platform_id platform;
    cl_device_id device;
    cl_context context;
    cl_command_queue command_queue;
    cl_program program;
    cl_kernel kernel;
    cl_kernel kernel2;
    cl_mem buffer;
    cl_int error;
    cl_event event;
    cl_ulong startTime, endTime;
    size_t globalSize[1], localSize[1], warpSize;

    void* hostData = NULL;

    /* Parse options */
    CommandParser(argc, argv);
    HostDataCreation(hostData);

    GetPlatformAndDevice(platform, device);

    /* Create context */
    context = clCreateContext(NULL, 1, &device, NULL, NULL, &error);
    CHECK_CL_ERROR(error);

    /* Create command queue */
    command_queue = clCreateCommandQueue(context, device, CL_QUEUE_PROFILING_ENABLE, &error);
    CHECK_CL_ERROR(error);

    /* Create program */
    CreateAndBuildProgram(program, context, device, strdup(CL_FILE_NAME));

    /* Create kernels */
    kernel = clCreateKernel(program, "getBufferAddress", &error);
    CHECK_CL_ERROR(error);
    kernel2 = clCreateKernel(program, "getBufferAddress2", &error);
    CHECK_CL_ERROR(error);

    error = clGetKernelWorkGroupInfo(kernel, device, CL_KERNEL_PREFERRED_WORK_GROUP_SIZE_MULTIPLE, sizeof(size_t), &warpSize, NULL);
    CHECK_CL_ERROR(error);

    /* Create buffers */
    buffer = clCreateBuffer(context, CL_MEM_READ_WRITE | CL_MEM_COPY_HOST_PTR, g_opencl_ctrl.dataByte, hostData, &error);
    CHECK_CL_ERROR(error);

    printf("buffer location %p\n", &buffer);
    
    /* Execute kernels */
    error = clSetKernelArg(kernel, 0, sizeof(cl_mem), &buffer);
    error |= clSetKernelArg(kernel, 1, 2 * sizeof(cl_ulong), NULL);
    CHECK_CL_ERROR(error);


    globalSize[0] = 1;
    localSize[0] = 1;
    error = clEnqueueNDRangeKernel(command_queue, kernel, 1, NULL, globalSize, localSize, 0, NULL, &event);
    CHECK_CL_ERROR(error);
    error = clFinish(command_queue);
    CHECK_CL_ERROR(error);

    error = clEnqueueReadBuffer(command_queue, buffer, CL_TRUE, 0, g_opencl_ctrl.dataByte, hostData, 0, NULL, NULL);
    CHECK_CL_ERROR(error);

    printf("In kernel location %p %p %p %p\n", (void *)(*(cl_ulong *)(hostData)), (void *)(*((cl_ulong*)(hostData)+1)), (void *)(*((cl_ulong *)(hostData)+2)), (void *)(*((cl_ulong*)(hostData)+3)));

    /* Event profiling */

    /* Read the output */

    /* Release object */
    clReleaseKernel(kernel);
    clReleaseMemObject(buffer);
    clReleaseEvent(event);
    clReleaseProgram(program);
    clReleaseCommandQueue(command_queue);
    clReleaseContext(context);
    free(hostData);

    return 0;
}
