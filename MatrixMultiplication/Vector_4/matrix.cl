__kernel void MatrixMultiplication_int_O3(__global int4 *matrixA, __global int4 *matrixB, __global int4 *output, int matrixSize, int matrixWidth)
{
    int y = get_global_id(0);
    int x = get_global_id(1);
    int widthA = matrixSize/4;
    int widthB = matrixWidth/4;

    int4 sum0 = (int4){0, 0, 0, 0};
    int4 sum1 = (int4){0, 0, 0, 0};
    int4 sum2 = (int4){0, 0, 0, 0};
    int4 sum3 = (int4){0, 0, 0, 0};

    int idxA = x * 4 * widthA;

    for (int i = 0 ; i < widthA ; i ++)
    {
        int4 tempA0 = matrixA[idxA + i];
        int4 tempA1 = matrixA[idxA + 1 * widthA + i];
        int4 tempA2 = matrixA[idxA + 2 * widthA + i];
        int4 tempA3 = matrixA[idxA + 3 * widthA + i];
        int4 tempB0 = matrixB[i * 4 * widthB + y];
        int4 tempB1 = matrixB[(i * 4 + 1) * widthB + y];
        int4 tempB2 = matrixB[(i * 4 + 2) * widthB + y];
        int4 tempB3 = matrixB[(i * 4 + 3) * widthB + y];

        sum0.x += tempA0.x * tempB0.x + tempA0.y * tempB1.x + tempA0.z * tempB2.x + tempA0.w * tempB3.x;
        sum0.y += tempA0.x * tempB0.y + tempA0.y * tempB1.y + tempA0.z * tempB2.y + tempA0.w * tempB3.y;
        sum0.z += tempA0.x * tempB0.z + tempA0.y * tempB1.z + tempA0.z * tempB2.z + tempA0.w * tempB3.z;
        sum0.w += tempA0.x * tempB0.w + tempA0.y * tempB1.w + tempA0.z * tempB2.w + tempA0.w * tempB3.w;

        sum1.x += tempA1.x * tempB0.x + tempA1.y * tempB1.x + tempA1.z * tempB2.x + tempA1.w * tempB3.x;
        sum1.y += tempA1.x * tempB0.y + tempA1.y * tempB1.y + tempA1.z * tempB2.y + tempA1.w * tempB3.y;
        sum1.z += tempA1.x * tempB0.z + tempA1.y * tempB1.z + tempA1.z * tempB2.z + tempA1.w * tempB3.z;
        sum1.w += tempA1.x * tempB0.w + tempA1.y * tempB1.w + tempA1.z * tempB2.w + tempA1.w * tempB3.w;

        sum2.x += tempA2.x * tempB0.x + tempA2.y * tempB1.x + tempA2.z * tempB2.x + tempA2.w * tempB3.x;
        sum2.y += tempA2.x * tempB0.y + tempA2.y * tempB1.y + tempA2.z * tempB2.y + tempA2.w * tempB3.y;
        sum2.z += tempA2.x * tempB0.z + tempA2.y * tempB1.z + tempA2.z * tempB2.z + tempA2.w * tempB3.z;
        sum2.w += tempA2.x * tempB0.w + tempA2.y * tempB1.w + tempA2.z * tempB2.w + tempA2.w * tempB3.w;

        sum3.x += tempA3.x * tempB0.x + tempA3.y * tempB1.x + tempA3.z * tempB2.x + tempA3.w * tempB3.x;
        sum3.y += tempA3.x * tempB0.y + tempA3.y * tempB1.y + tempA3.z * tempB2.y + tempA3.w * tempB3.y;
        sum3.z += tempA3.x * tempB0.z + tempA3.y * tempB1.z + tempA3.z * tempB2.z + tempA3.w * tempB3.z;
        sum3.w += tempA3.x * tempB0.w + tempA3.y * tempB1.w + tempA3.z * tempB2.w + tempA3.w * tempB3.w;
    }
    output[x * 4 * widthB + y] = sum0;
    output[(x * 4 + 1) * widthB + y] = sum1;
    output[(x * 4 + 2) * widthB + y] = sum2;
    output[(x * 4 + 3) * widthB + y] = sum3;
}

__kernel void MatrixMultiplication_int_O2(__global int4 *matrixA, __global int *matrixB, __global int *output, int matrixSize, int matrixWidth)
{
    int y = get_global_id(0);
    int x = get_global_id(1);
    int widthA = matrixSize/4;

    int4 sum1 = (int4){0, 0, 0, 0};
    int4 sum2 = (int4){0, 0, 0, 0};
    int4 sum3 = (int4){0, 0, 0, 0};
    int4 sum4 = (int4){0, 0, 0, 0};
    int4 sum5 = (int4){0, 0, 0, 0};
    int4 sum6 = (int4){0, 0, 0, 0};
    int4 sum7 = (int4){0, 0, 0, 0};
    int4 sum8 = (int4){0, 0, 0, 0};
    int4 sum9 = (int4){0, 0, 0, 0};
    int4 sum10 = (int4){0, 0, 0, 0};
    int4 sum11 = (int4){0, 0, 0, 0};
    int4 sum12 = (int4){0, 0, 0, 0};
    int4 sum13 = (int4){0, 0, 0, 0};
    int4 sum14 = (int4){0, 0, 0, 0};
    int4 sum15 = (int4){0, 0, 0, 0};
    int4 sum16 = (int4){0, 0, 0, 0};

    int idxA = x * 4 * widthA;
    int idxO;

    for (int i = 0 ; i < widthA ; i ++)
    {
        int idxB = i * 4 * matrixWidth + y * 4;
        int4 tmpA1 = matrixA[idxA + i];
        int4 tmpA2 = matrixA[idxA + 1 * widthA + i];
        int4 tmpA3 = matrixA[idxA + 2 * widthA + i];
        int4 tmpA4 = matrixA[idxA + 3 * widthA + i];
        int4 tmpB1 = (int4){matrixB[idxB], matrixB[idxB + 1 * matrixSize], matrixB[idxB + 2 * matrixSize], matrixB[idxB + 3 * matrixSize]};
        int4 tmpB2 = (int4){matrixB[idxB + 1], matrixB[idxB + 1 * matrixSize + 1], matrixB[idxB + 2 * matrixSize + 1], matrixB[idxB + 3 * matrixSize + 1]};
        int4 tmpB3 = (int4){matrixB[idxB + 2], matrixB[idxB + 1 * matrixSize + 2], matrixB[idxB + 2 * matrixSize + 2], matrixB[idxB + 3 * matrixSize + 2]};
        int4 tmpB4 = (int4){matrixB[idxB + 3], matrixB[idxB + 1 * matrixSize + 3], matrixB[idxB + 2 * matrixSize + 3], matrixB[idxB + 3 * matrixSize + 3]};

        sum1 += tmpA1 * tmpB1;
        sum2 += tmpA1 * tmpB2;
        sum3 += tmpA1 * tmpB3;
        sum4 += tmpA1 * tmpB4;
        sum5 += tmpA2 * tmpB1;
        sum6 += tmpA2 * tmpB2;
        sum7 += tmpA2 * tmpB3;
        sum8 += tmpA2 * tmpB4;
        sum9 += tmpA3 * tmpB1;
        sum10 += tmpA3 * tmpB2;
        sum11 += tmpA3 * tmpB3;
        sum12 += tmpA3 * tmpB4;
        sum13 += tmpA4 * tmpB1;
        sum14 += tmpA4 * tmpB2;
        sum15 += tmpA4 * tmpB3;
        sum16 += tmpA4 * tmpB4;
    }
    idxO = x * 4 * matrixWidth + y * 4;
    output[idxO] = sum1.x + sum1.y + sum1.z + sum1.w;
    output[idxO + 1] = sum2.x + sum2.y + sum2.z + sum2.w;
    output[idxO + 2] = sum3.x + sum3.y + sum3.z + sum3.w;
    output[idxO + 3] = sum4.x + sum4.y + sum4.z + sum4.w;
    idxO += matrixWidth;
    output[idxO] = sum5.x + sum5.y + sum5.z + sum5.w;
    output[idxO + 1] = sum6.x + sum6.y + sum6.z + sum6.w;
    output[idxO + 2] = sum7.x + sum7.y + sum7.z + sum7.w;
    output[idxO + 3] = sum8.x + sum8.y + sum8.z + sum8.w;
    idxO += matrixWidth;
    output[idxO] = sum9.x + sum9.y + sum9.z + sum9.w;
    output[idxO + 1] = sum10.x + sum10.y + sum10.z + sum10.w;
    output[idxO + 2] = sum11.x + sum11.y + sum11.z + sum11.w;
    output[idxO + 3] = sum12.x + sum12.y + sum12.z + sum12.w;
    idxO += matrixWidth;
    output[idxO] = sum13.x + sum13.y + sum13.z + sum13.w;
    output[idxO + 1] = sum14.x + sum14.y + sum14.z + sum14.w;
    output[idxO + 2] = sum15.x + sum15.y + sum15.z + sum15.w;
    output[idxO + 3] = sum16.x + sum16.y + sum16.z + sum16.w;
}

__kernel void MatrixMultiplication_int_O1(__global int4 *matrixA, __global int *matrixB, __global int *output, int matrixSize, int matrixWidth)
{
    int4 sum1, sum2, sum3, sum4;
    int y = get_global_id(0);
    int x = get_global_id(1);

    sum1 = (int4){0, 0, 0, 0};
    sum2 = (int4){0, 0, 0, 0};
    sum3 = (int4){0, 0, 0, 0};
    sum4 = (int4){0, 0, 0, 0};
    for (int i = 0 ; i < matrixWidth / 4 ; i ++)
    {
        int4 tmpA = matrixA[x * matrixWidth / 4 + i];
        int idx = i * 4 * matrixSize + y * 4;
        sum1 += tmpA * (int4){matrixB[idx], matrixB[idx + 1 * matrixSize], matrixB[idx + 2 * matrixSize], matrixB[idx + 3 * matrixSize]};
        sum2 += tmpA * (int4){matrixB[idx + 1], matrixB[idx + 1 * matrixSize + 1], matrixB[idx + 2 * matrixSize + 1], matrixB[idx + 3 * matrixSize + 1]};
        sum3 += tmpA * (int4){matrixB[idx + 2], matrixB[idx + 1 * matrixSize + 2], matrixB[idx + 2 * matrixSize + 2], matrixB[idx + 3 * matrixSize + 2]};
        sum4 += tmpA * (int4){matrixB[idx + 3], matrixB[idx + 1 * matrixSize + 3], matrixB[idx + 2 * matrixSize + 3], matrixB[idx + 3 * matrixSize + 3]};
    }
    output[x * matrixSize + y * 4] = sum1.x + sum1.y + sum1.z + sum1.w;
    output[x * matrixSize + y * 4 + 1] = sum2.x + sum2.y + sum2.z + sum2.w;
    output[x * matrixSize + y * 4 + 2] = sum3.x + sum3.y + sum3.z + sum3.w;
    output[x * matrixSize + y * 4 + 3] = sum4.x + sum4.y + sum4.z + sum4.w;
}

__kernel void MatrixMultiplication_int_O0(__global int4 *matrixA, __global int *matrixB, __global int *output, int matrixSize, int matrixWidth)
{
    int4 sum;
    int y = get_global_id(0);
    int x = get_global_id(1);

    sum = (int4){0, 0, 0, 0};
    for (int i = 0 ; i < matrixWidth / 4 ; i ++)
    {
        int idx = i * 4 * matrixSize + y;
        sum += matrixA[x * matrixWidth / 4 + i] * (int4){matrixB[idx], matrixB[idx + 1 * matrixSize], matrixB[idx + 2 * matrixSize], matrixB[idx + 3 * matrixSize]};
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
