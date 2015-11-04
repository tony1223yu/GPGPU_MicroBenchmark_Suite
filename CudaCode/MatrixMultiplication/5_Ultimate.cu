#include <cstdio>
#include <cstdlib>
#include <iostream>
#define TILE_W 16
#define Width 1600
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
	
	__shared__ int Mds_1[TILE_W][TILE_W];
	__shared__ int Mds_2[TILE_W][TILE_W];
        __shared__ int Nds_1[TILE_W][TILE_W];
	__shared__ int Nds_2[TILE_W][TILE_W];

	int Row = by*TILE_W + ty;
	int Col = bx*TILE_W + tx;
	
	int Pvalue_1 = 0;
	int Pvalue_2 = 0;
	int Pvalue_3 = 0;
	int Pvalue_4 = 0;

	for(int m=0 ; m<Width/TILE_W ; ++m)
	{
		int Mds_1_Index = Row*Width + m*TILE_W + tx;
		int Mds_2_Index = (Row+Width/2)*Width + m*TILE_W + tx;
		int Nds_1_Index = (m*TILE_W + ty)*Width + Col;
		int Nds_2_Index = (m*TILE_W + ty)*Width + Col + Width/2;
		
		Mds_1[ty][tx] = Md[Mds_1_Index];
		Mds_2[ty][tx] = Md[Mds_2_Index];
		Nds_1[ty][tx] = Nd[Nds_1_Index];
		Nds_2[ty][tx] = Nd[Nds_2_Index];

		//Synchronize to make sure the sub-matirces are loaded
		//before starting the computation
		__syncthreads();
		
		//Each thread computes one element of the block sub-matrix
		for(int k=0 ; k<TILE_W ; ++k)
		{
			Pvalue_1 += Mds_1[ty][k] * Nds_1[k][tx];
			Pvalue_2 += Mds_1[ty][k] * Nds_2[k][tx];
			Pvalue_3 += Mds_2[ty][k] * Nds_1[k][tx];
			Pvalue_4 += Mds_2[ty][k] * Nds_2[k][tx];
		}
	
		//Synchronize to make sure that the preceding
		//computation is done before loading two new
		//sub-matrices of M and N in the next iteration
		__syncthreads();
    }

	Pd[Row*Width + Col] = Pvalue_1;
	Pd[Row*Width + Col + Width/2] = Pvalue_2;
	Pd[(Row+Width/2)*Width + Col] = Pvalue_3;
	Pd[(Row+Width/2)*Width + Col + Width/2] = Pvalue_4;
}

int main()
{	
	cout << "----------------------------------------------Start" << endl;	
	cout << "This is Ultimate version" << endl;
	cout << "---------------------------------------------------" << endl;
	cout << "Grid  Dimension : " << (Width/TILE_W)/2 << "x" << (Width/TILE_W)/2 << endl;
	cout << "Block Dimension : " << TILE_W << "x" << TILE_W << endl;
	cout << "Dimension       : " << Width << "x" << Width << endl;
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

	//Print M
	/*
        cout << "M Matrix : " << endl;
        for(int i=0 ; i<Width ; i++)
        {
                for(int j=0 ; j<Width ; j++)
                        cout << M[i] << ", ";
                cout << endl;
        }
	cout << endl;
	//Print N
        cout << "N Matrix : " << endl;
        for(int i=0 ; i<Width ; i++)
        {
                for(int j=0 ; j<Width ; j++)
                        cout << N[i] << ", ";
                cout << endl;
        }*/
	
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

	dim3 dimGrid((Width/TILE_W)/2, (Width/TILE_W)/2);
	dim3 dimBlock(TILE_W, TILE_W);
	size_t SharedMemoryBytes = sizeof(int)*TILE_W*TILE_W*4;
	MatrixMulKernel_SharedMemory<<<dimGrid, dimBlock, SharedMemoryBytes>>>(Md, Nd, Pd);

	cudaEventRecord(end, 0);
	cudaEventSynchronize(end);
        float GPU_time;
        cudaEventElapsedTime(&GPU_time, start, end);

	cudaMemcpy(P, Pd, size, cudaMemcpyDeviceToHost);
 
        cout << "Matrix Multiplication by GPU : " << GPU_time/1000 << 's' << endl;
	cout << "---------------------------------------------------" << endl;	

	//Print GPU Result
	/*cout << "GPU Result : (With Tiling Algorithm)" << endl; 
	for(int i=0 ; i<Width ; i++)
	{
		for(int j=0 ; j<Width ; j++)
			cout << P[i*Width + j] << ", ";
		cout << endl;
	}
	
	//Print CPU Result
        cout << "CPU Result : " << endl;
        for(int i=0 ; i<Width ; i++)
	{
		for(int j=0 ; j<Width ; j++)
			cout << Temp_sum_array[i*Width + j] << ", ";
		cout << endl;
	}*/

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
