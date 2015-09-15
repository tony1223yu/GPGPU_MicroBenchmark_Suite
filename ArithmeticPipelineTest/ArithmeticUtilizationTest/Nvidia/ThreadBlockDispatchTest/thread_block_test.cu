#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdint.h>

#define PTX_MODULE_FILE "arith_latency_kernel.ptx"
#define BLOCK_SIZE 1024
#define BLOCK_NUMBER 30

static __device__ __inline__ uint32_t __mysmid()
{
    uint32_t smid;
    asm volatile("mov.u32 %0, %%smid;" : "=r"(smid));
    return smid;
}

__global__
void WorkGroupCountTest(int *result, unsigned int *time)
{
    int iteration, a, b;
    int blockID;
    unsigned int *curTime;
    unsigned int start, end;
    
    blockID = blockIdx.y * blockDim.x + blockIdx.x;
    iteration = result[blockID];
    a = result[blockID];
    b = result[0];

    start = clock();
    for (int i = 0 ; i < iteration ; i ++)
    {
        a = a + b;
        b = b + a;
    }

    result[blockID] = b;
    end = clock();
   
    curTime = time + 5 * blockID;
    if (threadIdx.x == 0 && threadIdx.y == 0)
    {
        curTime[0] = __mysmid();
        curTime[1] = blockID;
        curTime[2] = start;
        curTime[3] = end;
        curTime[4] = iteration;
    }
}

int main(int argc, char *argv[])
{
    // smid, start, end, blockid, iteration
    unsigned int *host_time = new unsigned int[5 * BLOCK_NUMBER];
    unsigned int *device_time;
    // loop iteration
    int *host_result = new int[BLOCK_NUMBER];
    int *device_result;
    cudaSetDevice(1);

    srand(time(NULL));
    cudaMalloc( (void **)(&device_time), 5 * BLOCK_NUMBER * sizeof(unsigned));
    cudaMalloc( (void **)(&device_result), BLOCK_NUMBER * sizeof(int));

    for (int i = 0 ; i < BLOCK_NUMBER ; i ++)
    {
        host_result[i] = (rand() % 1000000 + 1);
        printf("%d\n", host_result[i]);
    }
    printf("\n");

    dim3 block(BLOCK_SIZE);
    dim3 grid(BLOCK_NUMBER);

    {
        cudaMemcpy(device_result, host_result, BLOCK_NUMBER * sizeof(int), cudaMemcpyHostToDevice);
        
        WorkGroupCountTest<<<grid, block>>>(device_result, device_time);
        
        cudaMemcpy(host_time, device_time, 5 * BLOCK_NUMBER * sizeof(unsigned int), cudaMemcpyDeviceToHost);
    
        for (int i = 0 ; i < BLOCK_NUMBER ; i ++)
        {
            printf("smid = %3u, blockID = %3u, start = %-10u, end = %-10u, iteration = %-8u, duration = %-10u\n",
                    host_time[i * 5], host_time[i * 5 + 1], host_time[i * 5 + 2], host_time[i * 5 + 3], host_time[i * 5 + 4], host_time[i * 5 + 3] - host_time[i * 5 + 2]);
        }
    }
    cudaFree(device_time);
    cudaFree(device_result);

    delete [] host_time;
    delete [] host_result;
    return 0;
}
