__kernel void LaunchOrderTest(__global int *input, __global int *output, int width)
{
    int gr_idx0 = get_group_id(0);
    int gr_idx1 = get_group_id(1);
    int n_gr0 = get_num_groups(0);
    int l_idx0 = get_local_id(0);
    int l_idx1 = get_local_id(1);
    int i, result;

    if ((l_idx0 | l_idx1) == 0)
        atomic_inc(input);

    for (i = 1 ; i < 10000 ; i ++);
    barrier(CLK_GLOBAL_MEM_FENCE);
    result = input[0];
    barrier(CLK_GLOBAL_MEM_FENCE);
    for (i = 1 ; i < 10000 ; i ++);

    if ((l_idx0 | l_idx1) == 0)
        output[gr_idx1 * n_gr0 + gr_idx0] = result;
}
