#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/time.h>
#include <time.h>
#include <math.h>

#ifdef __APPLE__
#include <OpenCL/cl.h>
#else
#include <CL/cl.h>
#endif


/* Macros */
#define WORK_GROUP_SIZE 16
#define CL_FILE_NAME "matrix.cl"
#define BINARY_FILE_NAME "matrix.bin"
#define CL_KERNEL_INT "MatrixMultiplication_int"
#define CL_KERNEL_FLOAT "MatrixMultiplication_float"
#define CL_KERNEL_DOUBLE "MatrixMultiplication_double"
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


enum DATA_TYPE
{
    TYPE_INT = 0,
    TYPE_FLOAT,
    TYPE_DOUBLE
};

/* Control struct */
struct OpenCL_Ctrl
{
    int platform_id;
    int device_id;
    bool timing;
    int dataSizeM, dataSizeW, dataSizeH, inputByteA;
    int local_size1;
    int local_size2;
    int iteration;
    bool verify;
    char powerFile[POWER_LOG_FILE_LEN];

    OpenCL_Ctrl() : iteration(1000), local_size1(WORK_GROUP_SIZE), local_size2(WORK_GROUP_SIZE), platform_id(0), device_id(0), timing(false), dataSizeW(1024), dataSizeH(1024), dataSizeM(1024), verify(false) {sprintf(powerFile, "KernelExecution.log");}

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
    int cmd;
    while(1)
    {
        cmd = getopt(argc, argv, "P:D:Tt:W:H:VM:O:L:l:I:");

        /* finish parsing */
        if (cmd == -1)
            break;

        switch (cmd)
        {
            case 'L':
                g_opencl_ctrl.local_size1 = atoi(optarg);
                break;

            case 'l':
                g_opencl_ctrl.local_size2 = atoi(optarg);
                break;

            case 'O':
                sprintf(g_opencl_ctrl.powerFile, "%s", optarg);
                break;

            case 'P':
                g_opencl_ctrl.platform_id = atoi(optarg);
                break;

            case 'D':
                g_opencl_ctrl.device_id = atoi(optarg);
                break;

            case 'T':
                g_opencl_ctrl.timing = true;
                break;

            case 'H':
                {
                    int size = atoi(optarg);
                    g_opencl_ctrl.dataSizeH = size;
                }
                break;

            case 'I':
                g_opencl_ctrl.iteration = atoi(optarg);
                break;

            case 'W':
                {
                    int size = atoi(optarg);
                    g_opencl_ctrl.dataSizeW = size;
                }
                break;

            case '?':
                fprintf(stderr, "Unknown option -%c\n", optopt);
                break;

            /* should not be here */
            default:
                break;
        }
    }

    /* Print the setting */
    fprintf(stderr, "Matrix dimension: %d, %d\n", g_opencl_ctrl.dataSizeH, g_opencl_ctrl.dataSizeW);
    fprintf(stderr, "Matrix element type: ");
    g_opencl_ctrl.inputByteA = g_opencl_ctrl.dataSizeH * g_opencl_ctrl.dataSizeW * sizeof(unsigned long) * 16;
    fprintf(stderr, "%d Byte\n", g_opencl_ctrl.inputByteA);
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
    char *programSource;
    cl_int error;

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
    fread(programSource, sizeof(char), programSize, fptr);
    fclose(fptr);

    /* Create and build cl_program object */
    target_program = clCreateProgramWithSource(context, 1, (const char **)(&programSource), &programSize, &error);
    CHECK_CL_ERROR(error);
    free(programSource);

    //error = clBuildProgram(target_program, 1, &device, "-cl-opt-disable", NULL, NULL);
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

void HostDataCreation(void* &inputA)
{
    inputA = malloc(g_opencl_ctrl.inputByteA);
}

int main(int argc, char *argv[])
{
    FILE* g_fptr;
    cl_platform_id platform;
    cl_device_id device;
    cl_context context;
    cl_command_queue command_queue;
    cl_program program;
    cl_kernel kernel1, kernel2;
    cl_mem inputBufferA;
    cl_int error;
    size_t globalSize[2], localSize[2];

    struct timeval startTime, endTime;

    void* inputMatrixA = NULL;
    /* Parse options */
    CommandParser(argc, argv);

    g_fptr = fopen(g_opencl_ctrl.powerFile, "a");
    if (!g_fptr)
        exit(1);

    HostDataCreation(inputMatrixA);

    GetPlatformAndDevice(platform, device);

    /* Create context */
    context = clCreateContext(NULL, 1, &device, NULL, NULL, &error);
    CHECK_CL_ERROR(error);

    /* Create command queue */
    command_queue = clCreateCommandQueue(context, device, 0, &error);
    CHECK_CL_ERROR(error);

    /* Create program */
    CreateAndBuildProgram(program, context, device, strdup(CL_FILE_NAME));

    /* Create kernels */
    kernel1 = clCreateKernel(program, "Generate", &error);
    CHECK_CL_ERROR(error);
    kernel2 = clCreateKernel(program, "Access", &error);
    CHECK_CL_ERROR(error);

    /* Create buffers */
    inputBufferA = clCreateBuffer(context, CL_MEM_READ_WRITE | CL_MEM_COPY_HOST_PTR, g_opencl_ctrl.inputByteA, inputMatrixA, &error);
    CHECK_CL_ERROR(error);

    /* Execute kernels */
    error = clSetKernelArg(kernel1, 0, sizeof(cl_mem), &inputBufferA);
    CHECK_CL_ERROR(error);
    error = clSetKernelArg(kernel1, 1, sizeof(int), &g_opencl_ctrl.dataSizeW);
    CHECK_CL_ERROR(error);
    error = clSetKernelArg(kernel1, 2, sizeof(int), &g_opencl_ctrl.dataSizeH);
    CHECK_CL_ERROR(error);

    error = clSetKernelArg(kernel2, 0, sizeof(cl_mem), &inputBufferA);
    CHECK_CL_ERROR(error);
    error = clSetKernelArg(kernel2, 1, sizeof(int), &g_opencl_ctrl.dataSizeW);
    CHECK_CL_ERROR(error);
    error = clSetKernelArg(kernel2, 2, sizeof(int), &g_opencl_ctrl.iteration);
    CHECK_CL_ERROR(error);


    globalSize[0] = g_opencl_ctrl.dataSizeW;
    globalSize[1] = g_opencl_ctrl.dataSizeH;
    localSize[0] = g_opencl_ctrl.local_size1;
    localSize[1] = g_opencl_ctrl.local_size2;

    fprintf(stderr, "global size: %lu %lu\n", globalSize[0], globalSize[1]);
    fprintf(stderr, "local size: %lu %lu\n", localSize[0], localSize[1]);

    error = clEnqueueNDRangeKernel(command_queue, kernel1, 2, NULL, globalSize, localSize, 0, NULL, NULL);
    CHECK_CL_ERROR(error);
    error = clFinish(command_queue);
    CHECK_CL_ERROR(error);
 
    PrintTimingInfo(g_fptr);

    if (g_opencl_ctrl.timing)
        gettimeofday(&startTime, NULL);

    error = clEnqueueNDRangeKernel(command_queue, kernel2, 2, NULL, globalSize, localSize, 0, NULL, NULL);
    CHECK_CL_ERROR(error);
    error = clFinish(command_queue);
    CHECK_CL_ERROR(error);
    PrintTimingInfo(g_fptr);

    if (g_opencl_ctrl.timing)
        gettimeofday(&endTime, NULL);

    fclose(g_fptr);

    /* Read the output */
    error = clEnqueueReadBuffer(command_queue, inputBufferA, CL_TRUE, 0, g_opencl_ctrl.inputByteA, inputMatrixA, 0, NULL, NULL);
    CHECK_CL_ERROR(error);

    /* Release object */
    clReleaseKernel(kernel1);
    clReleaseKernel(kernel2);
    clReleaseMemObject(inputBufferA);
    clReleaseProgram(program);
    clReleaseCommandQueue(command_queue);
    clReleaseContext(context);
    free(inputMatrixA);

    if (g_opencl_ctrl.timing)
    {
        unsigned long long start, end;
        start = startTime.tv_sec * 1000000 + startTime.tv_usec;
        end = endTime.tv_sec * 1000000 + endTime.tv_usec;

        fprintf(stderr, "Kernel execution time: %llu ms\n", (end - start) / 1000);
        fprintf(stdout, "%llu\n", (end - start) * 1000);
    }

    fprintf(stderr, "DONE.\n");

    return 0;
}
