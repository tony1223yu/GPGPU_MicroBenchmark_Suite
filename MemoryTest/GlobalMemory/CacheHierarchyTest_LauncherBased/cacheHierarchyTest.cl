__kernel void Process(__global ulong* dataArray, long iter, long offset, int interval)
{
    if (get_local_id(0) % DISPATCH_SIZE == 0)
    {
        __global ulong* currPtr = dataArray + get_group_id(0) * offset + (get_local_id(0) / DISPATCH_SIZE) * interval;
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
        dataArray[get_group_id(0) * offset + (get_local_id(0) / DISPATCH_SIZE) * interval] = (ulong)(currPtr);
    }
}

// 1D work-item
__kernel void GeneratePattern(__global ulong* dataArray, int num, int stride, int interval)
{
    if (get_local_id(0) % DISPATCH_SIZE == 0)
    {
        int idx = 0;
        __global ulong* currArray = dataArray + get_group_id(0) * stride * num + (get_local_id(0) / DISPATCH_SIZE) * interval;
        for (int i = 0 ; i < num - 1 ; i ++)
        {
            currArray[idx] = (ulong)(&currArray[idx + stride]);
            idx = idx + stride;
        }
        currArray[idx] = (ulong)currArray;
    }
}
