__kernel void Process(__global ulong* dataArray, long iter, int stride)
{
    __global ulong* currPtr = dataArray + get_global_id(0) * stride;
    while (iter -- > 0)
    {
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
        currPtr = (__global ulong *)(*currPtr);
    }
    dataArray[1] = (ulong)(currPtr);
}

// 1D work-item
__kernel void GeneratePattern(__global ulong* dataArray, int size, int stride)
{
    int idx = 0;
    __global ulong* currArray = dataArray + get_global_id(0) * stride;
    for (int i = 0 ; i < size - 1 ; i ++)
    {
        currArray[idx] = (ulong)(&currArray[idx + get_global_size(0) * stride]);
        idx = idx + get_global_size(0) * stride;
    }
    currArray[idx] = (ulong)currArray;
}
