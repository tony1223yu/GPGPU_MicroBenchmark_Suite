#include <stdio.h>
#include <stdlib.h>
#include <cuda.h>
#include "cudaTestHelper.h"
#include <sys/time.h>

int main(int argc, char *argv[])
{
    CUresult result;
    cudaError_t error;
    CUDATestHelper helper;
    InitialAndParseArgs(argc, argv, helper);
    int kernelIter = 2;
    double executionTime;

    printf("Run testcase for %d iterations\n", helper.testIteration);
    for (unsigned int idx = 0 ; idx < helper.ptxKernelName.size() ; idx ++)
    {
    	executionTime = 0;
    	for (int iter = 0 ; iter < helper.testIteration ; iter ++)
    	{
	        CUmodule ptxModule = 0;
	        CUfunction ptxFunction = 0;

	        error = cudaMalloc( (void **)(&helper.deviceTime), 2 * sizeof(unsigned));
	        CHECK_CUDA_ERROR(error);
	        error = cudaMalloc( (void **)(&helper.deviceData), helper.sizeOfData);
	        CHECK_CUDA_ERROR(error);

	        void *functionArgs[3] = {&helper.deviceData, &helper.deviceTime, &kernelIter};

	        result = cuModuleLoad(&ptxModule, helper.ptxFileName);
	        CHECK_CU_RESULT(result);

	        result = cuModuleGetFunction(&ptxFunction, ptxModule, helper.ptxKernelName[idx]);
	        CHECK_CU_RESULT(result);

	        error = cudaMemcpy(helper.deviceData, helper.hostData, helper.sizeOfData, cudaMemcpyHostToDevice);
	        CHECK_CUDA_ERROR(error);

	        result = cuLaunchKernel(ptxFunction, GRID_X, GRID_Y, GRID_Z, BLOCK_X, BLOCK_Y, BLOCK_Z, 0, 0, functionArgs, 0);
	        CHECK_CU_RESULT(result);

	        error = cudaMemcpy(helper.hostTime, helper.deviceTime, 2 * sizeof(unsigned int), cudaMemcpyDeviceToHost);
	        CHECK_CUDA_ERROR(error);

	        error = cudaFree(helper.deviceTime);
	        CHECK_CUDA_ERROR(error);
	        error = cudaFree(helper.deviceData);
	        CHECK_CUDA_ERROR(error);
		
	        executionTime += (helper.hostTime[1] - helper.hostTime[0]);
		}
		executionTime /= helper.testIteration;
        printf("%-50s %lf\n", helper.ptxKernelName[idx], executionTime);
    }

    return 0;
}
