__kernel
void dia_spmv(__global float *A, __const int rows,
                __const int diags, __global int *offsets,
                __global float *x, __global float *y, __local int *l_offsets) 
{
    int local_id = get_local_id(0);
    int offset_id = local_id;
    while ((offset_id < 256) && (offset_id < diags))
    {
        l_offsets[offset_id] = offsets[offset_id];
        offset_id = offset_id + get_local_size(0);
    }
    barrier(CLK_LOCAL_MEM_FENCE);

    int row = get_global_id(0);
    float accumulator = 0;
    for(int diag = 0; diag < diags; diag++) 
    {
        int col = row + l_offsets[diag];
        if ((col >= 0) && (col < rows)) 
        {
            float m = A[diag*rows + row]; 
            float v = x[col];
            accumulator += m * v;
        }
    }
    y[row] = accumulator;
}
