__kernel void getBufferAddress(__global ulong* dataArray, __local ulong* shareArray)
{
    dataArray[get_global_id(0)] = (ulong)(shareArray);
    dataArray[get_global_id(0) + 1] = (ulong)(shareArray+1);
    dataArray[get_global_id(0) + 2] = (ulong)(dataArray);
    dataArray[get_global_id(0) + 3] = (ulong)(dataArray+1);
}

__kernel void getBufferAddress2(__global ulong* dataArray)
{
    dataArray[get_global_id(0) + 2] = dataArray[get_global_id(0)];
    dataArray[get_global_id(0) + 3] = dataArray[get_global_id(0) + 1];
}
