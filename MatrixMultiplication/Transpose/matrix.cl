__kernel void MatrixTranspose_int(__global int *matrixA, __global int *matrixB, int matrixWidth, int matrixHeight)
{
    int sum;
    int y = get_global_id(0);
    int x = get_global_id(1);
 
    matrixB[y * matrixHeight + x] = matrixA[x * matrixWidth + y];
}
