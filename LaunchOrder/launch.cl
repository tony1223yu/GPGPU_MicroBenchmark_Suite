__kernel void LaunchOrderTest(__global int *input, __global int *output, int width)
{
    int idx0 = get_global_id(0);
    int idx1 = get_global_id(1);
    int num;

    for (int i = 0 ; i < 1000 ; i ++)
    {;}
    num = atomic_inc(input);

    output[idx1 * width + idx0] = num;
}
