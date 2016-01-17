__kernel void Process(__global ulong* dataArray, __local ulong* localArray, long iter, int stride, int num, int interval)
{
    if (get_local_id(0) % DISPATCH_SIZE == 0)
    {
        __local ulong* localPtr = localArray + (get_local_id(0) / DISPATCH_SIZE) * interval;
        int idx = 0; 
        for (int i = 0; i < num - 1 ; i ++) 
         {
             localPtr[idx] = (ulong)(&localPtr[idx + stride]);
            idx = idx + stride;
         }
            localPtr[idx] = (ulong)localPtr;

         while (iter -- > 0)
         {
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
             localPtr = (__local ulong *)(*localPtr);
        }
        dataArray[get_global_id(0)] = (ulong)(localPtr);
    }
}
