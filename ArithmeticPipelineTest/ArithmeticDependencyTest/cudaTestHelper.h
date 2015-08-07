#ifndef __CUDA_TEST_HELPER__
#define __CUDA_TEST_HELPER__

#include <vector>
#include <unistd.h>
#include <getopt.h>

#define BLOCK_X 1
#define BLOCK_Y 1
#define BLOCK_Z 1
#define GRID_X 1
#define GRID_Y 1
#define GRID_Z 1
#define DATA_SIZE 20
#define PTX_KERNEL_MAX_LEN 200

#define CHECK_CUDA_ERROR(err)                                                           \
    do                                                                                  \
    {                                                                                   \
        if (err != cudaSuccess)                                                         \
        {                                                                               \
            printf("CUDA error: %d at %s:%d\n", err, __FILE__, __LINE__);               \
            exit(1);                                                                    \
        }                                                                               \
    } while (0)


#define CHECK_CU_RESULT(err)                                                            \
    do                                                                                  \
    {                                                                                   \
        if (err != CUDA_SUCCESS)                                                        \
        {                                                                               \
            printf("CUResult error: %d at %s:%d\n", err, __FILE__, __LINE__);           \
            exit(1);                                                                    \
        }                                                                               \
    } while (0)

using namespace std;

enum Type
{
    TYPE_INT = 0,
    TYPE_DBL
};

class CUDATestHelper
{
public:
    Type dataType;
    char *ptxFileName;
    vector <char *> ptxKernelName;

    unsigned int *hostTime;
    unsigned int *deviceTime;

    void *hostData;
    int *hostData_int;
    double *hostData_dbl;
    void *deviceData;
    size_t sizeOfData;

    int cudaDeviceNumber;

    bool useOriginKernel;

    CUDATestHelper():
        ptxFileName(NULL),
        hostTime(NULL),
        hostData(NULL),
        hostData_int(NULL),
        hostData_dbl(NULL),
        cudaDeviceNumber(0),
        sizeOfData(0) {}

    ~CUDATestHelper()
    {
        /* use strdup */
        if (ptxFileName)
            free(ptxFileName);

        /* use strdup */
        for (unsigned int i = 0 ; i < ptxKernelName.size(); i ++)
            free(ptxKernelName[i]);

        if (hostTime)
            delete [] hostTime;

        if (hostData_int)
            delete [] hostData_int;

        if (hostData_dbl)
            delete [] hostData_dbl;

        ptxKernelName.clear();
    }

};

void InitialAndParseArgs(int argc, char* argv[], CUDATestHelper &helper)
{
    char* short_options = strdup("f:k:t:d:");
    struct option long_options[] =
    {
        {"ptxFile", required_argument, NULL, 'f'},
        {"ptxKernelFile", required_argument, NULL, 'k'},
        {"type", required_argument, NULL, 't'},
        {"cudaDevice", required_argument, NULL, 'd'},
        /* option end */
        {0, 0, 0, 0}
    };
    int optionIdx = 0;
    int optGet;
    while ((optGet = getopt_long(argc, argv, short_options, long_options, &optionIdx)) != -1)
    {
        switch (optGet)
        {
            case 'd':
                helper.cudaDeviceNumber = atoi(optarg);
                break;

            case 'f':
                helper.ptxFileName = strdup(optarg);
                break;

            case 'k':
                {
                    char tmpFileName[PTX_KERNEL_MAX_LEN];
                    FILE* fptr = fopen(optarg, "r");
                    while(fscanf(fptr, "%s\n", tmpFileName) != EOF)
                    {
                        helper.ptxKernelName.push_back(strdup(tmpFileName));
                    }

                    fclose(fptr);
                }
                break;

            case 't':
                {
                    int type = atoi(optarg);
                    switch(type)
                    {
                        case TYPE_INT:
                            helper.hostData_int = new int[DATA_SIZE];
                            helper.dataType = TYPE_INT;
                            helper.sizeOfData = DATA_SIZE * sizeof(int);
                            helper.hostData = helper.hostData_int;
                            break;

                        case TYPE_DBL:
                            helper.hostData_dbl = new double[DATA_SIZE];
                            helper.dataType = TYPE_DBL;
                            helper.sizeOfData = DATA_SIZE * sizeof(double);
                            helper.hostData = helper.hostData_dbl;
                            break;
                    }
                }
                break;

            case '?':
                fprintf(stderr, "Unknown option -%c\n", optopt);
                break;

            default:
                break;
        }
    }

    if (helper.hostData == NULL || helper.ptxFileName == NULL || helper.ptxKernelName.size() == 0)
    {
        fprintf(stderr, "executable -f <ptx_file> -k <test_case_file> -t <0:INT, 1:DBL> [-d <device_numver>]\n");
        exit(1);
    }

    free(short_options);
    helper.hostTime = new unsigned int[2];
    helper.hostTime[0] = 0;
    helper.hostTime[1] = 0;

    // Get selected device name
    {
        cudaError_t error;
        cudaDeviceProp properties;
        error = cudaGetDeviceProperties(&properties, helper.cudaDeviceNumber);
        CHECK_CUDA_ERROR(error);
        fprintf(stderr, "Select device: %s\n\n", properties.name);
    }
    cudaSetDevice(helper.cudaDeviceNumber);
}

#endif
