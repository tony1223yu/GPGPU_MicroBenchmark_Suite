// vim: ft=c

__kernel void Reduction_int(__global int* inputArray, int length, __global int* outputArray, __local int* localArray)
{
    int gid = get_global_id(0);
    int lid = get_local_id(0);

    localArray[lid] = inputArray[gid];
    barrier(CLK_LOCAL_MEM_FENCE);

    for (int offset = 1 ; offset < get_local_size(0) ; offset <<= 1)
    {
        int mask = (offset << 1) - 1;
        if ((lid & mask) == 0)
        {
            localArray[lid] = localArray[lid] + localArray[lid + offset];
        }
        barrier(CLK_LOCAL_MEM_FENCE);
    }

    if (lid == 0)
        outputArray[get_group_id(0)] = localArray[lid];
}

__kernel void Reduction_float(__global float* inputArray, int length, __global float* outputArray, __local float* localArray)
{
    int gid = get_global_id(0);
    int lid = get_local_id(0);

    localArray[lid] = inputArray[gid];
    barrier(CLK_LOCAL_MEM_FENCE);


    for (int offset = 1 ; offset < get_local_size(0) ; offset <<= 1)
    {
        int mask = (offset << 1) - 1;
        if ((lid & mask) == 0)
        {
            localArray[lid] = localArray[lid] + localArray[lid + offset];
        }
        barrier(CLK_LOCAL_MEM_FENCE);
    }

    if (lid == 0)
        outputArray[get_group_id(0)] = localArray[lid];
}

__kernel void Reduction_double(__global double* inputArray, int length, __global double* outputArray, __local double* localArray)
{
    int gid = get_global_id(0);
    int lid = get_local_id(0);

    localArray[lid] = inputArray[gid];
    barrier(CLK_LOCAL_MEM_FENCE);

    for (int offset = 1 ; offset < get_local_size(0) ; offset <<= 1)
    {
        int mask = (offset << 1) - 1;
        if ((lid & mask) == 0)
        {
            localArray[lid] = localArray[lid] + localArray[lid + offset];
        }
        barrier(CLK_LOCAL_MEM_FENCE);
    }

    if (lid == 0)
        outputArray[get_group_id(0)] = localArray[lid];
}
