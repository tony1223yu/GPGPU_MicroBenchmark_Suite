__kernel void MatrixMultiplication_8(__global int *matrixA, __global int *matrixB, __global int *output, int matrixSize, int matrixWidth, __local int* localA, __local int* localB, int localSize)
{
    int sum, tmpA, tmpB;
    int y = get_global_id(0);
    int x = get_global_id(1);
    int ly = get_local_id(0);
    int lx = get_local_id(1);

    sum = 0;
    for (int i = 0 ; i < matrixWidth / localSize ; i ++)
    {
        localA[lx * localSize + ly] = matrixA[x * matrixSize + i * localSize + ly];
        localB[lx * localSize + ly] = matrixB[(i * localSize + lx) * matrixSize + y];
        barrier(CLK_LOCAL_MEM_FENCE);

        for (int j = 0 ; j < localSize ; j ++)
        {
            tmpA = localA[lx * localSize + j];
            tmpB = localB[j * localSize + ly];
            sum += tmpA + tmpB;
            sum += tmpA - tmpB;
            sum += tmpA * tmpB;
            sum += tmpA / tmpB;
            sum += tmpA < tmpB;
            sum += tmpA > tmpB;
            sum += tmpA & tmpB;
            sum += tmpA | tmpB;
        }
        barrier(CLK_LOCAL_MEM_FENCE);
    }
    output[x * matrixSize + y] = sum;
}
__kernel void MatrixMultiplication_1(__global int *matrixA, __global int *matrixB, __global int *output, int matrixSize, int matrixWidth, __local int* localA, __local int* localB, int localSize)
{
    int sum, tmpA, tmpB;
    int y = get_global_id(0);
    int x = get_global_id(1);
    int ly = get_local_id(0);
    int lx = get_local_id(1);

    sum = 0;
    for (int i = 0 ; i < matrixWidth / localSize ; i ++)
    {
        localA[lx * localSize + ly] = matrixA[x * matrixSize + i * localSize + ly];
        localB[lx * localSize + ly] = matrixB[(i * localSize + lx) * matrixSize + y];
        barrier(CLK_LOCAL_MEM_FENCE);

        for (int j = 0 ; j < localSize ; j ++)
        {
            tmpA = localA[lx * localSize + j];
            tmpB = localB[j * localSize + ly];
            sum += tmpA + tmpB;
        }
        barrier(CLK_LOCAL_MEM_FENCE);
    }
    output[x * matrixSize + y] = sum;
}
__kernel void MatrixMultiplication_4(__global int *matrixA, __global int *matrixB, __global int *output, int matrixSize, int matrixWidth, __local int* localA, __local int* localB, int localSize)
{
    int sum, tmpA, tmpB;
    int y = get_global_id(0);
    int x = get_global_id(1);
    int ly = get_local_id(0);
    int lx = get_local_id(1);

    sum = 0;
    for (int i = 0 ; i < matrixWidth / localSize ; i ++)
    {
        localA[lx * localSize + ly] = matrixA[x * matrixSize + i * localSize + ly];
        localB[lx * localSize + ly] = matrixB[(i * localSize + lx) * matrixSize + y];
        barrier(CLK_LOCAL_MEM_FENCE);

        for (int j = 0 ; j < localSize ; j ++)
        {
            tmpA = localA[lx * localSize + j];
            tmpB = localB[j * localSize + ly];
            sum += tmpA + tmpB;
            sum += tmpA - tmpB;
            sum += tmpA * tmpB;
            sum += tmpA / tmpB;
        }
        barrier(CLK_LOCAL_MEM_FENCE);
    }
    output[x * matrixSize + y] = sum;
}
__kernel void MatrixMultiplication_2(__global int *matrixA, __global int *matrixB, __global int *output, int matrixSize, int matrixWidth, __local int* localA, __local int* localB, int localSize)
{
    int sum, tmpA, tmpB;
    int y = get_global_id(0);
    int x = get_global_id(1);
    int ly = get_local_id(0);
    int lx = get_local_id(1);

    sum = 0;
    for (int i = 0 ; i < matrixWidth / localSize ; i ++)
    {
        localA[lx * localSize + ly] = matrixA[x * matrixSize + i * localSize + ly];
        localB[lx * localSize + ly] = matrixB[(i * localSize + lx) * matrixSize + y];
        barrier(CLK_LOCAL_MEM_FENCE);

        for (int j = 0 ; j < localSize ; j ++)
        {
            tmpA = localA[lx * localSize + j];
            tmpB = localB[j * localSize + ly];
            sum += tmpA + tmpB;
            sum += tmpA * tmpB;
        }
        barrier(CLK_LOCAL_MEM_FENCE);
    }
    output[x * matrixSize + y] = sum;
}
