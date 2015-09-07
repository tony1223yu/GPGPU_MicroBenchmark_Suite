__kernel void ComputeTask(__global int* dataArray, int iter)
{
	__global int* curArray = dataArray + get_global_id(0) * COMPUTE_DATA_SIZE;
    int a0, a1, a2, a3, a4, a5, a6, a7, a8, a9;
    int addend;
    a0 = curArray[0];
    a1 = curArray[1];
    a2 = curArray[2];
    a3 = curArray[3];
    a4 = curArray[4];
    a5 = curArray[5];
    a6 = curArray[6];
    a7 = curArray[7];
    a8 = curArray[8];
    a9 = curArray[9];
    addend = a0;
    while (iter -- > 1)
    {
        a0 = a0 + addend;
        a1 = a1 + addend;
        a2 = a2 + addend;
        a3 = a3 + addend;
        a4 = a4 + addend;
        a5 = a5 + addend;
        a6 = a6 + addend;
        a7 = a7 + addend;
        a8 = a8 + addend;
        a9 = a9 + addend;
        addend = addend + a0;
    }
    curArray[0] = a0;
    curArray[1] = a1;
    curArray[2] = a2;
    curArray[3] = a3;
    curArray[4] = a4;
    curArray[5] = a5;
    curArray[6] = a6;
    curArray[7] = a7;
    curArray[8] = a8;
    curArray[9] = a9;
}

__kernel void MemoryTask(__global long* dataArray, int iter)
{
    __global long* tmpPtr;
    dataArray[9 * get_global_size(0) + get_global_id(0)] = (long) (dataArray + get_global_id(0));
    for (int i = 0 ; i < 9 ; i ++)
    {
        dataArray[i * get_global_size(0) + get_global_id(0)] = (long) (dataArray + (i + 1) * get_global_size(0) + get_global_id(0));
    }

    tmpPtr = (__global long *) dataArray[get_global_id(0)];
    while (iter -- > 1)
    {
        tmpPtr = (__global long *)(*tmpPtr);
        tmpPtr = (__global long *)(*tmpPtr);
        tmpPtr = (__global long *)(*tmpPtr);
        tmpPtr = (__global long *)(*tmpPtr);
        tmpPtr = (__global long *)(*tmpPtr);
        tmpPtr = (__global long *)(*tmpPtr);
        tmpPtr = (__global long *)(*tmpPtr);
        tmpPtr = (__global long *)(*tmpPtr);
        tmpPtr = (__global long *)(*tmpPtr);
        tmpPtr = (__global long *)(*tmpPtr);
    }
    dataArray[get_global_id(0)] = *tmpPtr;

}
