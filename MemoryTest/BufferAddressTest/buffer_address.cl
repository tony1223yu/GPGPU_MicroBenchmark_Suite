__kernel void getBufferAddress(__global ulong* dataArray)
{
    dataArray[get_global_id(0)] = (ulong)(dataArray);
    dataArray[get_global_id(0)+1] = (ulong)(dataArray+1);
}
