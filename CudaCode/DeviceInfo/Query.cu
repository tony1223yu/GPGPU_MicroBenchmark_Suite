#include <stdio.h>
 
// Print device properties
void printDevProp(cudaDeviceProp devProp)
{
	printf("%s\n", devProp.name);
	printf("Major Compute Capability:      %d\n",  devProp.major);
    	printf("Minor Compute Capability:      %d\n",  devProp.minor);
    	printf("Total global memory:           %u bytes\n",  devProp.totalGlobalMem);
	printf("Total constant memory:         %u bytes\n",  devProp.totalConstMem);
    	printf("Total shared memory per block: %u bytes\n",  devProp.sharedMemPerBlock);
    	printf("Total registers per block:     %d\n",  devProp.regsPerBlock);
    	printf("Warp size:                     %d\n",  devProp.warpSize);
	printf("Number of multiprocessors:     %d\n",  devProp.multiProcessorCount);
	printf("Threeads per multiprocessors:  %d\n",  devProp.maxThreadsPerMultiProcessor);
    	printf("Threads per block:             %d\n",  devProp.maxThreadsPerBlock);
    	printf("Dimension of block:            %d x %d x %d\n",  devProp.maxThreadsDim[0], devProp.maxThreadsDim[1], devProp.maxThreadsDim[2]);
    	printf("Dimension of grid:             %d x %d x %d\n",  devProp.maxGridSize[0], devProp.maxGridSize[1], devProp.maxGridSize[2]);
	printf("Memory pitch:                  %u bytes\n",  devProp.memPitch);
	printf("Texture alignment:             %u bytes\n",  devProp.textureAlignment);
   	printf("Clock rate:                    %d\n",  devProp.clockRate);
    	printf("Concurrent copy and execution: %s\n",  (devProp.deviceOverlap ? "Yes" : "No"));
    	printf("Kernel execution timeout:      %s\n",  (devProp.kernelExecTimeoutEnabled ? "Yes" : "No"));
}
 
int main()
{
  	// Number of CUDA devices
    	int devCount;
    	cudaGetDeviceCount(&devCount);
    	printf("CUDA Device Query...\n");
    	printf("There are %d CUDA devices.\n", devCount);
 
    	// Iterate through devices
    	for (int i = 0; i < devCount; ++i)
    	{
        	// Get device properties
        	printf("\nCUDA Device #%d : ", i);
        	cudaDeviceProp devProp;
        	cudaGetDeviceProperties(&devProp, i);
        	printDevProp(devProp);
    	}
	printf("\n");
 
    	return 0;
}
