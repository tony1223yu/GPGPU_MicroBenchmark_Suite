__kernel void LaunchOrderTest(__global int *input, __global int *output, int width)
{
    int idx0 = get_group_id(0);
    int idx1 = get_group_id(1);
    int num;

    if ((get_local_id(0) | get_local_id(1)) == 0)
    {
        for (int i = 0 ; i < 100 ; i ++)
            num = atomic_inc(input);
    }

    for (int i = 0 ; i < 100000 ; i ++) {;}

    barrier (CLK_GLOBAL_MEM_FENCE);
    output[idx1 * width / get_local_size(0) + idx0] = input[0];

    barrier (CLK_GLOBAL_MEM_FENCE);

    for (int i = 0 ; i < 100000 ; i ++) {;}
}
