__kernel void MatrixMultiplication_8(__global int4 *matrixA, __global int *matrixB, __global int *output, int matrixSize, int matrixWidth)
{
    int4 sum, tmpA, tmpB;
    int y = get_global_id(0);
    int x = get_global_id(1);

    sum = (int4){0, 0, 0, 0};
    for (int i = 0 ; i < matrixWidth / 4 ; i ++)
    {
        tmpA = matrixA[x * matrixWidth / 4 + i];
        tmpB = (int4){matrixB[i * 4 * matrixSize + y], matrixB[(i * 4 + 1) * matrixSize + y], matrixB[(i * 4 + 2) * matrixSize + y], matrixB[(i * 4 + 3) * matrixSize + y]};
        sum += tmpA + tmpB;
        sum += tmpA - tmpB;
        sum += tmpA * tmpB;
        sum += tmpA / tmpB;
        sum += tmpA < tmpB;
        sum += tmpA > tmpB;
        sum += tmpA & tmpB;
        sum += tmpA | tmpB;
    }
    output[x * matrixSize + y] = sum.x + sum.y + sum.z + sum.w;
}

__kernel void MatrixMultiplication_1(__global int4 *matrixA, __global int *matrixB, __global int *output, int matrixSize, int matrixWidth)
{
    int4 sum, tmpA, tmpB;
    int y = get_global_id(0);
    int x = get_global_id(1);

    sum = (int4){0, 0, 0, 0};
    for (int i = 0 ; i < matrixWidth / 4 ; i ++)
    {
        tmpA = matrixA[x * matrixWidth / 4 + i];
        tmpB = (int4){matrixB[i * 4 * matrixSize + y], matrixB[(i * 4 + 1) * matrixSize + y], matrixB[(i * 4 + 2) * matrixSize + y], matrixB[(i * 4 + 3) * matrixSize + y]};
        sum += tmpA + tmpB;
    }
    output[x * matrixSize + y] = sum.x + sum.y + sum.z + sum.w;
}

__kernel void MatrixMultiplication_4(__global int4 *matrixA, __global int *matrixB, __global int *output, int matrixSize, int matrixWidth)
{
    int4 sum, tmpA, tmpB;
    int y = get_global_id(0);
    int x = get_global_id(1);

    sum = (int4){0, 0, 0, 0};
    for (int i = 0 ; i < matrixWidth / 4 ; i ++)
    {
        tmpA = matrixA[x * matrixWidth / 4 + i];
        tmpB = (int4){matrixB[i * 4 * matrixSize + y], matrixB[(i * 4 + 1) * matrixSize + y], matrixB[(i * 4 + 2) * matrixSize + y], matrixB[(i * 4 + 3) * matrixSize + y]};
        sum += tmpA + tmpB;
        sum += tmpA - tmpB;
        sum += tmpA * tmpB;
        sum += tmpA / tmpB;
    }
    output[x * matrixSize + y] = sum.x + sum.y + sum.z + sum.w;
}

__kernel void MatrixMultiplication_2(__global int4 *matrixA, __global int *matrixB, __global int *output, int matrixSize, int matrixWidth)
{
    int4 sum, tmpA, tmpB;
    int y = get_global_id(0);
    int x = get_global_id(1);

    sum = (int4){0, 0, 0, 0};
    for (int i = 0 ; i < matrixWidth / 4 ; i ++)
    {
        tmpA = matrixA[x * matrixWidth / 4 + i];
        tmpB = (int4){matrixB[i * 4 * matrixSize + y], matrixB[(i * 4 + 1) * matrixSize + y], matrixB[(i * 4 + 2) * matrixSize + y], matrixB[(i * 4 + 3) * matrixSize + y]};
        sum += tmpA + tmpB;
        sum += tmpA * tmpB;
    }
    output[x * matrixSize + y] = sum.x + sum.y + sum.z + sum.w;
}

