__kernel void MatrixTranspose_int(__global int *matrixA, __global int *matrixB, int matrixWidth, int matrixHeight)
{
    int idx0 = get_global_id(0);
    int idx1 = get_global_id(1);

    matrixB[idx1 * matrixWidth + idx0] = matrixA[idx0 * matrixHeight + idx1];
    //matrixB[idx0 * matrixWidth + idx1] = matrixA[idx1 * matrixHeight + idx0]; // inv
}
