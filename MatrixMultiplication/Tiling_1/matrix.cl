__kernel void MatrixMultiplication_int(__global int *matrixA, __global int *matrixB, __global int *output, int matrixSize, int matrixWidth, __local int* localB, int localSize)
{
    int sum;
    int y = get_global_id(0);
    int x = get_global_id(1);
    int ly = get_local_id(0);
    int lx = get_local_id(1);

    sum = 0;
    for (int i = 0 ; i < matrixWidth / localSize ; i ++)
    {
        localB[lx * localSize + ly] = matrixB[(i * localSize + lx) * matrixSize + y];
        barrier(CLK_GLOBAL_MEM_FENCE);

        for (int j = 0 ; j < localSize ; j ++)
        {
            sum += matrixA[x * matrixWidth + i * localSize + j] * localB[j * localSize + ly];
        }
        barrier(CLK_LOCAL_MEM_FENCE | CLK_GLOBAL_MEM_FENCE);
    }
    output[x * matrixSize + y] = sum;
}

__kernel void MatrixMultiplication_float(__global float *matrixA, __global float *matrixB, __global float *output, int matrixSize, int matrixWidth, __local int* localB, int localSize)
{
    float sum;
    int y = get_global_id(0);
    int x = get_global_id(1);
    int ly = get_local_id(0);
    int lx = get_local_id(1);

    sum = 0.0f;
    for (int i = 0 ; i < matrixWidth / localSize ; i ++)
    {
        localB[lx * localSize + ly] = matrixB[(i * localSize + lx) * matrixSize + y];
        barrier(CLK_LOCAL_MEM_FENCE | CLK_GLOBAL_MEM_FENCE);

        for (int j = 0 ; j < localSize ; j ++)
        {
            sum += matrixA[x * matrixWidth + i * localSize + j] * localB[j * localSize + ly];
        }
        barrier(CLK_LOCAL_MEM_FENCE | CLK_GLOBAL_MEM_FENCE);
    }
    output[x * matrixSize + y] = sum;
}

__kernel void MatrixMultiplication_double(__global double *matrixA, __global double *matrixB, __global double *output, int matrixSize, int matrixWidth, __local int* localB, int localSize)
{
    double sum;
    int y = get_global_id(0);
    int x = get_global_id(1);
    int ly = get_local_id(0);
    int lx = get_local_id(1);

    sum = 0.0;
    for (int i = 0 ; i < matrixWidth / localSize ; i ++)
    {
        localB[lx * localSize + ly] = matrixB[(i * localSize + lx) * matrixSize + y];
        barrier(CLK_LOCAL_MEM_FENCE | CLK_GLOBAL_MEM_FENCE);

        for (int j = 0 ; j < localSize ; j ++)
        {
            sum += matrixA[x * matrixWidth + i * localSize + j] * localB[j * localSize + ly];
        }
        barrier(CLK_LOCAL_MEM_FENCE | CLK_GLOBAL_MEM_FENCE);
    }
    output[x * matrixSize + y] = sum;
}
