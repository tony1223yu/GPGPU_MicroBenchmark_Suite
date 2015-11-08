#include <stdio.h>
#include <unistd.h>
#include <getopt.h>
#include <iostream>
#include "papi_wrapper.hpp"

using namespace std;

__global__ void Processing(long* dataArray, long iter, long offset, int interval)
{
    long* currArray = dataArray + blockIdx.x * offset + threadIdx.x * interval;
    while (iter -- > 0)
    {
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
        currArray = (long *)(*currArray);
    }
    dataArray[blockIdx.x * offset + threadIdx.x * interval] = (long)(currArray);
}
__global__ void GeneratePattern(long* dataArray, int size, int stride, int interval)
{
    int idx = 0;
    long* currArray = dataArray + blockIdx.x * stride * size + threadIdx.x * interval;
    for (int i = 0 ; i < size - 1 ; i ++)
    {
        currArray[idx] = (long)(&currArray[idx + stride]);
        idx = idx + stride;
    }
    currArray[idx] = (ulong)(currArray);
}


/* Control struct */
struct CUDA_Ctrl
{
    int platform_id;
    int device_id;
    long dataByte;
    long iteration;
    int size;
    int stride;
    int interval;
    long offset;
    int globalSize;
    int localSize;

    CUDA_Ctrl() : platform_id(0), device_id(0), size(1), stride(1), iteration(1), globalSize(1), localSize(1), offset(1), interval(1) {} 
    ~CUDA_Ctrl() {}

} g_cuda_ctrl;


void CommandParser(int argc, char *argv[])
{
    char* short_options = strdup("p:d:s:S:i:o:g:l:i:v:");
    struct option long_options[] =
    {
        {"platformID", required_argument, NULL, 'p'},
        {"deviceID", required_argument, NULL, 'd'},
        {"iteration", required_argument, NULL, 'i'},
        {"size", required_argument, NULL, 'S'},
        {"stride", required_argument, NULL, 's'},
        {"interval", required_argument, NULL, 'v'},
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
            case 'g':
                g_cuda_ctrl.globalSize = atoi(optarg);
                break;

            case 'l':
                g_cuda_ctrl.localSize = atoi(optarg);
                break;

            case 'v':
                g_cuda_ctrl.interval = atoi(optarg);
                break;

            case 'S':
                g_cuda_ctrl.size = atoi(optarg);
                break;

            case 's':
                g_cuda_ctrl.stride = atoi(optarg);
                break;

            case 'i':
                g_cuda_ctrl.iteration = atol(optarg);
                break;

            case 'p':
                g_cuda_ctrl.platform_id = atoi(optarg);
                break;

            case 'd':
                g_cuda_ctrl.device_id = atoi(optarg);
                break;

            case '?':
                fprintf(stderr, "Unknown option -%c\n", optopt);
                break;

            /* should not be here */
            default:
                break;
        }
    }

    g_cuda_ctrl.dataByte = sizeof(long) * (long)(g_cuda_ctrl.stride) * (long)(g_cuda_ctrl.size) * (long)(g_cuda_ctrl.globalSize) / (long)(g_cuda_ctrl.localSize);
    g_cuda_ctrl.offset = (long)(g_cuda_ctrl.stride) * (long)(g_cuda_ctrl.size);

    fprintf(stderr, "Total buffer size: %ld\n", g_cuda_ctrl.dataByte);

    free (short_options);
}

void HostDataCreation(long* &hostArray)
{
    hostArray = (long*) malloc (g_cuda_ctrl.dataByte);

    for (int i = 0 ; i < g_cuda_ctrl.size * g_cuda_ctrl.stride * g_cuda_ctrl.globalSize / g_cuda_ctrl.localSize ; i++)
        hostArray[i] = 0;
}

int main(int argc, char* argv[])
{
    long* hostArray = NULL;
    long* devArray;
	cudaEvent_t before, start, end;
 	float kernelTime;
    cudaDeviceProp devProp;
    //PAPIWrapper papi_ctrl;


    CommandParser(argc, argv);

    for (int i = 0 ; i < 1 ; i ++)
    {
        HostDataCreation(hostArray);
        cudaSetDevice(g_cuda_ctrl.device_id);
        cudaGetDeviceProperties(&devProp, g_cuda_ctrl.device_id);
        //cout << "Device selected: " << devProp.name << endl;

        //papi_ctrl.AddEvent(2, strdup("cuda:::device:1:inst_executed"), strdup("cuda:::device:1:uncached_global_load_transaction"));
        cudaEventCreate(&before);
        cudaEventCreate(&start);
        cudaEventCreate(&end);

        cudaMalloc((void **)&devArray, g_cuda_ctrl.dataByte);
        cudaMemcpy(devArray, hostArray, g_cuda_ctrl.dataByte, cudaMemcpyHostToDevice);

        dim3 dimGrid(g_cuda_ctrl.globalSize/g_cuda_ctrl.localSize);
        dim3 dimBlock(g_cuda_ctrl.localSize);

        GeneratePattern <<<dimGrid, dimBlock>>>(devArray, g_cuda_ctrl.size, g_cuda_ctrl.stride, g_cuda_ctrl.interval);
        cudaMemcpy(hostArray, devArray, g_cuda_ctrl.dataByte, cudaMemcpyDeviceToHost);

        ////cout << hex << hostArray[0] << endl;

        cudaEventRecord(before, 0);
        cudaEventSynchronize(before);

        //papi_ctrl.Start();
        cudaEventRecord(start, 0);

        Processing  <<<dimGrid, dimBlock>>>(devArray, g_cuda_ctrl.iteration, g_cuda_ctrl.offset, g_cuda_ctrl.interval);

        cudaEventRecord(end, 0);
        cudaEventSynchronize(end); 
        //papi_ctrl.Stop();

        cudaMemcpy(hostArray, devArray, g_cuda_ctrl.dataByte, cudaMemcpyDeviceToHost);

        cudaEventElapsedTime(&kernelTime, start, end);
        cout << "Execution Time (s): " << kernelTime / 1000 << endl;

        if (0)
        {
            long *currArray;
            for (int i = 0 ; i < g_cuda_ctrl.globalSize/g_cuda_ctrl.localSize ; i ++)
            {
                currArray = hostArray + i * g_cuda_ctrl.stride * g_cuda_ctrl.size;
                for (int j = 0 ; j < g_cuda_ctrl.stride * g_cuda_ctrl.size ; j ++)
                {
                    cout << currArray[j] << " ";
                }
                cout << endl;
            }
        }

        free(hostArray);
        cudaFree(devArray);
    }
    return 0;
}
