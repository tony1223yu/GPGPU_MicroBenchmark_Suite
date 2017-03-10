__kernel void LaunchOrderTest(__global int *input, __global int *output, int width)
{
    int idx0 = get_global_id(0);
    int idx1 = get_global_id(1);

    atomic_inc(input);

    for (int i = 0 ; i < 100000 ; i ++) {;}

    output[idx1 * width + idx0] = input[0];
}
