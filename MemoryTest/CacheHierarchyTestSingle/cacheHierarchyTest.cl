__kernel void Process(__global ulong* dataArray, long iter)
{
    __global ulong* currPtr = dataArray;
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

// only one single work-item
__kernel void GeneratePattern(__global ulong* dataArray, int size, int stride)
{
    int idx = 0;
    for (int i = 0 ; i < size - 1 ; i ++)
    {
        dataArray[idx] = (ulong)(&dataArray[idx + stride]);
        idx = idx + stride;
    }
    dataArray[idx] = (ulong)dataArray;
}
