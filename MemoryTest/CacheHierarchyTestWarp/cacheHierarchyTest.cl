__kernel void Process(__global ulong* dataArray, long iter, int offset)
{
    __global ulong* currPtr = dataArray + get_global_id(0) * offset;
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

// 1D ork-item
__kernel void GeneratePattern(__global ulong* dataArray, int size, int stride)
{
    int idx = 0;
    __global ulong* currArray = dataArray + get_global_id(0) * size * stride;
    for (int i = 0 ; i < size - 1 ; i ++)
    {
        currArray[idx] = (ulong)(&currArray[idx + stride]);
        idx = idx + stride;
    }
    currArray[idx] = (ulong)currArray;
}
