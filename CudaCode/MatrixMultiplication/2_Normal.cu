#include <cstdio>
#include <cstdlib>
#include <iostream>

#include "papi_wrapper.hpp"

#define TILE_W 32
#define Width 512
#define Element Width*Width
using namespace std;

__global__ 
void MatrixMulKernel(int* Md, int* Nd, int* Pd)
{
	//Block Index
	int by = blockIdx.y;
	int bx = blockIdx.x;
	//Thread Index
	int ty = threadIdx.y; //Row
	int tx = threadIdx.x; //Col
	
	int Row = by*TILE_W + ty;
	int Col = bx*TILE_W + tx;
	
	if((Row<Width) && (Col<Width))
	{
		//Pvalue is used to store the element of the matrix
		//That is computed by the thread
		int Pvalue = 0;

		for(int k=0 ; k<Width ; ++k)
			Pvalue += Md[Row*Width+k]*Nd[k*Width+Col];
        Pd[Row*Width + Col] = Pvalue;
	}

}

int main()
{
	cout << "----------------------------------------------Start" << endl;
	cout << "This is Normal Matrix Multiplication version" << endl;
	cout << "---------------------------------------------------" << endl;
	cout << "Grid Dimension : " << Width/TILE_W << "x" << Width/TILE_W << endl;
	cout << "Block Dimension : " << TILE_W << "x" << TILE_W << endl;
    cout << "Dimension : " << Width << "x" << Width << endl;
	cout << "Total Elements	: " << Element << endl;
	cout << "---------------------------------------------------" << endl;

    cudaSetDevice(1);

	//Variables for Time
	cudaEvent_t start, end;
	cudaEventCreate(&start);
	cudaEventCreate(&end);
	PAPIWrapper papi_ctrl;
    //papi_ctrl.AddEvent(2, strdup("cuda:::device:1:inst_executed"), strdup("cuda:::device:1:gld_inst_32bit"));
    papi_ctrl.AddEvent(2, strdup("cuda:::device:1:inst_executed"), strdup("cuda:::device:1:uncached_global_load_transaction"));

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
		M[i] = rand()%100;
		N[i] = rand()%100;
		P[i] = 0;
	}
	
	cudaEventRecord(start, 0);	
	//CPU Matrix Multiplication
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
	////////						 CUDA							//////////
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
	cout << "Time of Processing Memory		: " << Memory_time/1000 << 's' << endl;

	cudaEventRecord(start, 0);

    papi_ctrl.Start();

	dim3 dimGrid(Width/TILE_W, Width/TILE_W);
	dim3 dimBlock(TILE_W, TILE_W);	
	MatrixMulKernel<<<dimGrid, dimBlock>>>(Md, Nd, Pd);

	cudaEventRecord(end, 0);
	cudaEventSynchronize(end);
	float GPU_time;
	cudaEventElapsedTime(&GPU_time, start, end);

	cudaMemcpy(P, Pd, size, cudaMemcpyDeviceToHost);

    papi_ctrl.Stop();
	
    cout << "Matrix Multiplication by GPU : " << GPU_time/1000 << 's' << endl;
	cout << "---------------------------------------------------" << endl;

	//Print CPU Result
	//cout << "CPU Result :" << endl;
	//for(int i=0 ; i<Element ; i++)
	//	cout << Temp_sum_array[i] << ", ";
	//cout << endl;
	
	//Print GPU Result
	//cout << "GPU Result :" << endl;
	//for(int i=0 ; i<Element ; i++)
	//	cout << P[i] << ", ";
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
    /*
	cudaFree(Md);
	cudaFree(Nd);
	cudaFree(Pd);
	cudaEventDestroy(start);
	cudaEventDestroy(end);
	*/
    return EXIT_SUCCESS;
}
