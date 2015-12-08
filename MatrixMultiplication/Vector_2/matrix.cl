__kernel void MatrixMultiplication_int(__global int2 *matrixA, __global int *matrixB, __global int *output, int matrixSize, int matrixWidth)
{
    int2 sum;
    int y = get_global_id(0);
    int x = get_global_id(1);

    sum = (int2){0, 0};
    for (int i = 0 ; i < matrixWidth / 2 ; i ++)
    {
        sum += matrixA[x * matrixWidth / 2 + i] * (int2){matrixB[i * 2 * matrixSize + y], matrixB[(i * 2 + 1) * matrixSize + y]};
    }
    output[x * matrixSize + y] = sum.x + sum.y;
}

__kernel void MatrixMultiplication_float(__global float2 *matrixA, __global float *matrixB, __global float *output, int matrixSize, int matrixWidth)
{
    float2 sum;
    int y = get_global_id(0);
    int x = get_global_id(1);

    sum = (float2){0.0f, 0.0f};
    for (int i = 0 ; i < matrixWidth / 2 ; i ++)
    {
        sum += matrixA[x * matrixWidth / 2 + i] * (float2){matrixB[i * 2 * matrixSize + y], matrixB[(i * 2 + 1) * matrixSize + y]};
    }
    output[x * matrixSize + y] = sum.x + sum.y;
}

__kernel void MatrixMultiplication_double(__global double2 *matrixA, __global double *matrixB, __global double *output, int matrixSize, int matrixWidth)
{
    double2 sum;
    int y = get_global_id(0);
    int x = get_global_id(1);

    sum = (double2){0.0, 0.0};
    for (int i = 0 ; i < matrixWidth / 2; i ++)
    {
        sum += matrixA[x * matrixWidth / 2 + i] * (double2){matrixB[i * 2 * matrixSize + y], matrixB[(i * 2 + 1) * matrixSize + y]};
    }
    output[x * matrixSize + y] = sum.x + sum.y;
}
