__kernel void MatrixMultiplication_8(__global int *matrixA, __global int *matrixB, __global int *output, int matrixSize, int matrixWidth)
{
    int sum, tmpA, tmpB;
    int y = get_global_id(0);
    int x = get_global_id(1);

    sum = 0;
    for (int i = 0 ; i < matrixWidth ; i ++)
    {
        tmpA = matrixA[x * matrixWidth + i];
        tmpB = matrixB[i * matrixSize + y];
        sum += tmpA + tmpB;
        sum += tmpA - tmpB;
        sum += tmpA * tmpB;
        sum += tmpA / tmpB;
        sum += tmpA < tmpB;
        sum += tmpA > tmpB;
        sum += tmpA & tmpB;
        sum += tmpA | tmpB;
    }
    output[x * matrixSize + y] = sum;
}

__kernel void MatrixMultiplication_1(__global int *matrixA, __global int *matrixB, __global int *output, int matrixSize, int matrixWidth)
{
    int sum, tmpA, tmpB;
    int y = get_global_id(0);
    int x = get_global_id(1);

    sum = 0;
    for (int i = 0 ; i < matrixWidth ; i ++)
    {
        tmpA = matrixA[x * matrixWidth + i];
        tmpB = matrixB[i * matrixSize + y];
        sum += tmpA + tmpB;
    }
    output[x * matrixSize + y] = sum;
}
__kernel void MatrixMultiplication_4(__global int *matrixA, __global int *matrixB, __global int *output, int matrixSize, int matrixWidth)
{
    int sum, tmpA, tmpB;
    int y = get_global_id(0);
    int x = get_global_id(1);

    sum = 0;
    for (int i = 0 ; i < matrixWidth ; i ++)
    {
        tmpA = matrixA[x * matrixWidth + i];
        tmpB = matrixB[i * matrixSize + y];
        sum += tmpA + tmpB;
        sum += tmpA - tmpB;
        sum += tmpA * tmpB;
        sum += tmpA / tmpB;
    }
    output[x * matrixSize + y] = sum;
}
__kernel void MatrixMultiplication_2(__global int *matrixA, __global int *matrixB, __global int *output, int matrixSize, int matrixWidth)
{
    int sum, tmpA, tmpB;
    int y = get_global_id(0);
    int x = get_global_id(1);

    sum = 0;
    for (int i = 0 ; i < matrixWidth ; i ++)
    {
        tmpA = matrixA[x * matrixWidth + i];
        tmpB = matrixB[i * matrixSize + y];
        sum += tmpA + tmpB;
        sum += tmpA * tmpB;
    }
    output[x * matrixSize + y] = sum;
}
