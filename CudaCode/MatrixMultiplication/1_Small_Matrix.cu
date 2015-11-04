#include <cstdio>
#include <cstdlib>
#include <iostream>
#define Width 32
#define Element 1024
using namespace std;

__global__ 
void MatrixMulKernel(int* Md, int* Nd, int* Pd)
{
	//Thread Index
	int ty = threadIdx.y; //Row
	int tx = threadIdx.x; //Col
	
	//Pvalue is used to store the element of the matrix
        //That is computed by the thread
	int Pvalue = 0;

	if((ty<Width) && (tx<Width))
	{
		for(int k=0 ; k<Width ; ++k)
			Pvalue += Md[ty*Width+k]*Nd[k*Width+tx];
    }

    Pd[ty*Width + tx] = Pvalue;
}

int main()
{
	cout << "----------------------------------------------Start" << endl;	
	cout << "This is CPU faster than GPU Version" << endl;
	cout << "---------------------------------------------------" << endl;
	cout << "Grid  Dimension : " << "1" << endl;
	cout <<	"Block Dimension : " << Width << endl;
	cout << "Dimension       : " << Width << endl;
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

	dim3 dimGrid(1, 1);
	dim3 dimBlock(Width, Width);
	MatrixMulKernel<<<dimGrid, dimBlock>>>(Md, Nd, Pd);
	
        cudaEventRecord(end, 0);
        cudaEventSynchronize(end);
        float GPU_time;
        cudaEventElapsedTime(&GPU_time, start, end);

        cudaMemcpy(P, Pd, size, cudaMemcpyDeviceToHost);

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
                cout << "GPU is faster" << endl;
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
