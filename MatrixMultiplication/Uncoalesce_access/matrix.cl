__kernel void MatrixMultiplication_int(__global int *matrixA, __global int *matrixB, __global int *output, int matrixSize, int matrixWidth)
{
    int sum;
    int y = get_global_id(1);
    int x = get_global_id(0);

    sum = 0;
    for (int i = 0 ; i < matrixWidth ; i ++)
    {
        sum += matrixA[x * matrixWidth + i] * matrixB[i * matrixSize + y];
    }
    output[x * matrixSize + y] = sum;
}

__kernel void MatrixMultiplication_float(__global float *matrixA, __global float *matrixB, __global float *output, int matrixSize, int matrixWidth)
{
    float sum;
    int y = get_global_id(1);
    int x = get_global_id(0);

    sum = 0.0f;
    for (int i = 0 ; i < matrixWidth ; i ++)
    {
        sum += matrixA[x * matrixWidth + i] * matrixB[i * matrixSize + y];
    }
    output[x * matrixSize + y] = sum;
}

__kernel void MatrixMultiplication_double(__global double *matrixA, __global double *matrixB, __global double *output, int matrixSize, int matrixWidth)
{
    double sum;
    int y = get_global_id(1);
    int x = get_global_id(0);

    sum = 0.0;
    for (int i = 0 ; i < matrixWidth ; i ++)
    {
        sum += matrixA[x * matrixWidth + i] * matrixB[i * matrixSize + y];
    }
    output[x * matrixSize + y] = sum;
}
