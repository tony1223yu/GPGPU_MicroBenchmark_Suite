__kernel void Process(__global ulong4* dataArray, long iter, long offset)
{
    __global ulong4* currPtr = dataArray + get_global_id(0) * offset;
    while (iter -- > 0)
    {
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
        currPtr = (__global ulong4 *)((*currPtr).x);
    }
    dataArray[get_global_id(0) * offset] = (ulong)(currPtr);
}

// 1D work-item
__kernel void GeneratePattern(__global ulong4* dataArray, int num, int stride)
{
    int idx = 0;
    __global ulong4* currArray = dataArray + get_global_id(0) * stride * num;
    for (int i = 0 ; i < num - 1 ; i ++)
    {
        currArray[idx].x = (ulong)(&currArray[idx + stride]);
        idx = idx + stride;
    }
    currArray[idx].x = (ulong)currArray;
}
