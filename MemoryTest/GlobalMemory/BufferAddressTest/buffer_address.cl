__kernel void getBufferAddress(__global ulong* dataArray)
{
    dataArray[get_global_id(0)] = (ulong)(dataArray);
    dataArray[get_global_id(0) + 1] = (ulong)(dataArray+1);
}

__kernel void getBufferAddress2(__global ulong* dataArray)
{
    dataArray[get_global_id(0) + 2] = dataArray[get_global_id(0)];
    dataArray[get_global_id(0) + 3] = dataArray[get_global_id(0) + 1];
}
