#include <cstdio>
#include <cstdlib>
#include <iostream>
#include <sys/time.h>
#define TILE_W 32
#define Width 1024
#define Element Width*Width
using namespace std;

__global__
void MatrixMulKernel_SharedMemory(int* Md, int* Nd, int* Pd)
{	
	//Block Index
	int bx = blockIdx.x;
	int by = blockIdx.y;
	//Thread Index
	int tx = threadIdx.x;
	int ty = threadIdx.y;
	
	__shared__ int Mds[TILE_W][TILE_W];
  __shared__ int Nds[TILE_W][TILE_W];

	int Row = by*TILE_W + ty;
	int Col = bx*TILE_W + tx;
	
	int Pvalue = 0;

	for(int m=0 ; m<Width/TILE_W ; ++m)
	{
		Mds[ty][tx] = Md[Row*Width + m*TILE_W + tx];
		Nds[ty][tx] = Nd[(m*TILE_W + ty)*Width + Col];

		//Synchronize to make sure the sub-matirces are loaded
		//before starting the computation
		__syncthreads();
		
		//Each thread computes one element of the block sub-matrix
		for(int k=0 ; k<TILE_W ; ++k)
			Pvalue += Mds[ty][k] * Nds[k][tx];
	
		//Synchronize to make sure that the preceding
		//computation is done before loading two new
		//sub-matrices of M and N in the next iteration
		__syncthreads();
  }	
	
  Pd[Row*Width + Col] = Pvalue;
}

int main()
{	
	cout << "----------------------------------------------Start" << endl;
        cout << "This is Tiling version" << endl;
        cout << "---------------------------------------------------" << endl;
        cout << "Grid  Dimension : " << Width/TILE_W << "x" << Width/TILE_W << endl;
        cout << "Block Dimension : " << TILE_W << "x" << TILE_W << endl;
        cout << "Dimension       : " << Width << "x" << Width <<endl;
        cout << "Total Elements  : " << Element << endl;
        cout << "---------------------------------------------------" << endl;
	
	//Variables for Time
	cudaEvent_t start, end;
        cudaEventCreate(&start);
        cudaEventCreate(&end);

        int size = Element*sizeof(int);
        int* M = (int*)malloc(size);
        int* N = (int*)malloc(size);
        int* P = (int*)malloc(size);
        int* Temp_sum_array = (int*)malloc(size);
        int* Md;
        int* Nd;
        int* Pd;

	srand(time(0));
	for(int i=0 ; i<Element ; i++)
	{
		M[i] = rand()%1000;
		N[i] = rand()%1000;
		P[i] = 0;
	}
	
	cudaEventRecord(start, 0);
	//CPU Matirx Multiplication
	int Temp_sum = 0;
	for(int row=0 ; row<Width ; row++)
	{
		for(int col=0 ; col<Width ; col++)
		{
			Temp_sum = 0;
			for(int n=0 ; n<Width ; n++)
			{
				Temp_sum += M[row*Width+n]*N[n*Width+col];
			}
			Temp_sum_array[row*Width+col] = Temp_sum;
		}
	}
	cudaEventRecord(end, 0);
        cudaEventSynchronize(end);
        float CPU_time;
        cudaEventElapsedTime(&CPU_time, start, end);
        cout << "Matrix Multiplication by CPU : " << CPU_time/1000 << 's' << endl;
	//Finish
	
	/////////////////////////////////////////////////
	////////             CUDA              //////////
	/////////////////////////////////////////////////
	cudaEventRecord(start, 0);

        cudaMalloc((void**)&Md, size);
        cudaMemcpy(Md, M, size, cudaMemcpyHostToDevice);
        cudaMalloc((void**)&Nd, size);
        cudaMemcpy(Nd, N, size, cudaMemcpyHostToDevice);
        cudaMalloc((void**)&Pd, size);

        cudaEventRecord(end, 0);
        cudaEventSynchronize(end);
        float Memory_time;
        cudaEventElapsedTime(&Memory_time, start, end);
        cout << "Time of Processing Memory    : " << Memory_time/1000 << 's' << endl;

        cudaEventRecord(start, 0);

	dim3 dimGrid(Width/TILE_W, Width/TILE_W);
	dim3 dimBlock(TILE_W, TILE_W);
	size_t SharedMemoryBytes = sizeof(int)*TILE_W*TILE_W*2;
	MatrixMulKernel_SharedMemory<<<dimGrid, dimBlock, SharedMemoryBytes>>>(Md, Nd, Pd);

	cudaEventRecord(end, 0);
        cudaEventSynchronize(end);
        float GPU_time;
        cudaEventElapsedTime(&GPU_time, start, end);

	cudaMemcpy(P, Pd, size, cudaMemcpyDeviceToHost);

        cout << "Matrix Multiplication by GPU : " << GPU_time/1000 << 's' << endl;
	cout << "---------------------------------------------------" << endl;	

	//Print GPU Result
	//cout << "GPU Result : (With Tiling Algorithm)" << endl; 
	//for(int i=0 ; i<Element ; i++)
	//	cout << P[i] << ", ";
	//cout << endl;
	
	//Print CPU Result
        //cout << "CPU Result : " << endl;
        //for(int i=0 ; i<Element ; i++)
        //      cout << Temp_sum_array[i] << ", ";
        //cout << endl;

	//Check Multiplication Result
	int check_flag = 0;
        for(int i=0 ; i<Element ; i++)
                if(Temp_sum_array[i] != P[i])
                {
                        cout << "Wrong Point at : " << i << endl;
                        cout << "CPU Results is : " << Temp_sum_array[i] << endl;
                        cout << "GPU Results is : " << P[i] << endl;
                        check_flag = 1;
                        break;
                }
        if(check_flag == 1)
                cout << "Wrong Result" << endl;
        else if(check_flag == 0)
                cout << "Correct Result" << endl;
	//Finish

	//Compare CPU_time and GPU_time
	if(CPU_time > GPU_time)
        {
                cout << "GPU is faster" << endl;
                float SpeedUp = CPU_time/GPU_time;
                cout << "Speedup : " << SpeedUp << "x" << endl;
        }
	else
		cout << "CPU is faster" << endl;	
	//Finish
	cout << "------------------------------------------------End" << endl;
	
	free(M);
	free(N);
	free(P);
	free(Temp_sum_array);
	cudaFree(Md);
	cudaFree(Nd);
	cudaFree(Pd);
	cudaEventDestroy(start);
        cudaEventDestroy(end);
	
	return EXIT_SUCCESS;
}
