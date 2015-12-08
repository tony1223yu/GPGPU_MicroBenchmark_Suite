__kernel void MatrixMultiplication_int(__global int4 *matrixA, __global int *matrixB, __global int *output, int matrixSize, int matrixWidth)
{
    int4 sum;
    int y = get_global_id(0);
    int x = get_global_id(1);

    sum = (int4){0, 0, 0, 0};
    for (int i = 0 ; i < matrixWidth / 4 ; i ++)
    {
        sum += matrixA[x * matrixWidth / 4 + i] * (int4){matrixB[i * 4 * matrixSize + y], matrixB[(i * 4 + 1) * matrixSize + y], matrixB[(i * 4 + 2) * matrixSize + y], matrixB[(i * 4 + 3) * matrixSize + y]};
    }
    output[x * matrixSize + y] = sum.x + sum.y + sum.z + sum.w;
}

__kernel void MatrixMultiplication_float(__global float4 *matrixA, __global float *matrixB, __global float *output, int matrixSize, int matrixWidth)
{
    float4 sum;
    int y = get_global_id(0);
    int x = get_global_id(1);

    sum = (float4){0.0f, 0.0f, 0.0f, 0.0f};
    for (int i = 0 ; i < matrixWidth / 4 ; i ++)
    {
        sum += matrixA[x * matrixWidth / 4 + i] * (float4){matrixB[i * 4 * matrixSize + y], matrixB[(i * 4 + 1) * matrixSize + y], matrixB[(i * 4 + 2) * matrixSize + y], matrixB[(i * 4 + 3) * matrixSize + y]};
    }
    output[x * matrixSize + y] = sum.x + sum.y + sum.z + sum.w;
}

__kernel void MatrixMultiplication_double(__global double4 *matrixA, __global double *matrixB, __global double *output, int matrixSize, int matrixWidth)
{
    double4 sum;
    int y = get_global_id(0);
    int x = get_global_id(1);

    sum = (double4){0.0, 0.0, 0.0, 0.0};
    for (int i = 0 ; i < matrixWidth / 4; i ++)
    {
        sum += matrixA[x * matrixWidth / 4 + i] * (double4){matrixB[i * 4 * matrixSize + y], matrixB[(i * 4 + 1) * matrixSize + y], matrixB[(i * 4 + 2) * matrixSize + y], matrixB[(i * 4 + 3) * matrixSize + y]};
    }
    output[x * matrixSize + y] = sum.x + sum.y + sum.z + sum.w;
}
