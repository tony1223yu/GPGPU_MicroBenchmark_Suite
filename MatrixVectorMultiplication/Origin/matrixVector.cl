__kernel void dia_spmv(__global float *A, __const int rows,
                __const int diags, __global int *offsets,
                __global float *x, __global float *y) 
{
    int row = get_global_id(0);
    float accumulator = 0;
    for(int diag = 0; diag < diags; diag++) 
    {
        int col = row + offsets[diag];
        if ((col >= 0) && (col < rows)) 
        {
            float m = A[diag*rows + row]; 
            float v = x[col];
            accumulator += m * v;
        }
    }
    y[row] = accumulator;
}
