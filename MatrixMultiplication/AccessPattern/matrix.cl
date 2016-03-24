__kernel void Access(__global ulong *matrix, int width, int iteration)
{
    int y = get_global_id(1) * 16;
    int x = get_global_id(0) * 16;
    //__global ulong* curr = (__global ulong*)(matrix[x * width + y]);
    __global ulong* curr = (__global ulong*)(matrix[y * width + x]);

    for (int i = 0 ; i < iteration ; i ++)
    {
        curr = (__global ulong*) (*curr);
        curr = (__global ulong*) (*curr);
        curr = (__global ulong*) (*curr);
        curr = (__global ulong*) (*curr);
        curr = (__global ulong*) (*curr);
        curr = (__global ulong*) (*curr);
        curr = (__global ulong*) (*curr);
        curr = (__global ulong*) (*curr);
        curr = (__global ulong*) (*curr);
        curr = (__global ulong*) (*curr);
        curr = (__global ulong*) (*curr);
        curr = (__global ulong*) (*curr);
        curr = (__global ulong*) (*curr);
        curr = (__global ulong*) (*curr);
        curr = (__global ulong*) (*curr);
        curr = (__global ulong*) (*curr);
        curr = (__global ulong*) (*curr);
        curr = (__global ulong*) (*curr);
        curr = (__global ulong*) (*curr);
    }
    matrix[y * width + x] = curr;
}

__kernel void Generate(__global ulong* matrix, int width, int height)
{
    int id = get_global_id(1) * 16 * width + get_global_id(0) * 16;
    matrix[id] = (ulong)(&(matrix[id]));
}
