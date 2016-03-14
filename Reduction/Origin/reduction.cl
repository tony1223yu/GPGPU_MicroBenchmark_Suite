// vim: ft=c

__kernel void Reduction_int(__global int* inputArray, int length, __global int* outputArray)
{
    int gid = get_global_id(0);
    int lid = get_local_id(0);

    for (int offset = 1 ; offset < get_local_size(0) ; offset <<= 1)
    {
        int mask = (offset << 1) - 1;
        if ((lid & mask) == 0)
        {
            inputArray[gid] = inputArray[gid] + inputArray[gid + offset];
        }
        barrier(CLK_GLOBAL_MEM_FENCE);
    }

    if (lid == 0)
        outputArray[get_group_id(0)] = inputArray[gid];
}

__kernel void Reduction_float(__global float* inputArray, int length, __global float* outputArray)
{
    int gid = get_global_id(0);
    int lid = get_local_id(0);

    for (int offset = 1 ; offset < get_local_size(0) ; offset <<= 1)
    {
        int mask = (offset << 1) - 1;
        if ((lid & mask) == 0)
        {
            inputArray[gid] = inputArray[gid] + inputArray[gid + offset];
        }
        barrier(CLK_GLOBAL_MEM_FENCE);
    }

    if (lid == 0)
        outputArray[get_group_id(0)] = inputArray[gid];
}

__kernel void Reduction_double(__global double* inputArray, int length, __global double* outputArray)
{
    int gid = get_global_id(0);
    int lid = get_local_id(0);

    for (int offset = 1 ; offset < get_local_size(0) ; offset <<= 1)
    {
        int mask = (offset << 1) - 1;
        if ((lid & mask) == 0)
        {
            inputArray[gid] = inputArray[gid] + inputArray[gid + offset];
        }
        barrier(CLK_GLOBAL_MEM_FENCE);
    }

    if (lid == 0)
        outputArray[get_group_id(0)] = inputArray[gid];
}
