__kernel void Integer_addition_1_no(__global int* dataArray, long iter, int interval)
{
    __global int* curArray = dataArray + get_global_id(0) * interval;
	int a0;
    int addend;
    a0 = curArray[0];
    addend = a0;
    while (iter -- > 1)
    {
        a0 = a0 + addend;
        addend = addend + addend;
    }
    curArray[0] = a0;
}

__kernel void Integer_addition_2_no(__global int* dataArray, long iter, int interval)
{
    __global int* curArray = dataArray + get_global_id(0) * interval;
	int a0, a1;
    int addend;
    a0 = curArray[0];
    a1 = curArray[1];
    addend = a0;
    while (iter -- > 1)
    {
        a0 = a0 + addend;
        a1 = a1 + addend;
        addend = addend + addend;
    }
    curArray[0] = a0;
    curArray[1] = a1;
}

__kernel void Integer_addition_3_no(__global int* dataArray, long iter, int interval)
{
    __global int* curArray = dataArray + get_global_id(0) * interval;
	int a0, a1, a2;
    int addend;
    a0 = curArray[0];
    a1 = curArray[1];
    a2 = curArray[2];
    addend = a0;
    while (iter -- > 1)
    {
        a0 = a0 + addend;
        a1 = a1 + addend;
        a2 = a2 + addend;
        addend = addend + addend;
    }
    curArray[0] = a0;
    curArray[1] = a1;
    curArray[2] = a2;
}

__kernel void Integer_addition_4_no(__global int* dataArray, long iter, int interval)
{
    __global int* curArray = dataArray + get_global_id(0) * interval;
	int a0, a1, a2, a3;
    int addend;
    a0 = curArray[0];
    a1 = curArray[1];
    a2 = curArray[2];
    a3 = curArray[3];
    addend = a0;
    while (iter -- > 1)
    {
        a0 = a0 + addend;
        a1 = a1 + addend;
        a2 = a2 + addend;
        a3 = a3 + addend;
        addend = addend + addend;
    }
    curArray[0] = a0;
    curArray[1] = a1;
    curArray[2] = a2;
    curArray[3] = a3;
}

__kernel void Integer_addition_5_no(__global int* dataArray, long iter, int interval)
{
    __global int* curArray = dataArray + get_global_id(0) * interval;
	int a0, a1, a2, a3, a4;
    int addend;
    a0 = curArray[0];
    a1 = curArray[1];
    a2 = curArray[2];
    a3 = curArray[3];
    a4 = curArray[4];
    addend = a0;
    while (iter -- > 1)
    {
        a0 = a0 + addend;
        a1 = a1 + addend;
        a2 = a2 + addend;
        a3 = a3 + addend;
        a4 = a4 + addend;
        addend = addend + addend;
    }
    curArray[0] = a0;
    curArray[1] = a1;
    curArray[2] = a2;
    curArray[3] = a3;
    curArray[4] = a4;
}

__kernel void Integer_addition_6_no(__global int* dataArray, long iter, int interval)
{
    __global int* curArray = dataArray + get_global_id(0) * interval;
	int a0, a1, a2, a3, a4, a5;
    int addend;
    a0 = curArray[0];
    a1 = curArray[1];
    a2 = curArray[2];
    a3 = curArray[3];
    a4 = curArray[4];
    a5 = curArray[5];
    addend = a0;
    while (iter -- > 1)
    {
        a0 = a0 + addend;
        a1 = a1 + addend;
        a2 = a2 + addend;
        a3 = a3 + addend;
        a4 = a4 + addend;
        a5 = a5 + addend;
        addend = addend + addend;
    }
    curArray[0] = a0;
    curArray[1] = a1;
    curArray[2] = a2;
    curArray[3] = a3;
    curArray[4] = a4;
    curArray[5] = a5;
}

__kernel void Integer_addition_7_no(__global int* dataArray, long iter, int interval)
{
    __global int* curArray = dataArray + get_global_id(0) * interval;
	int a0, a1, a2, a3, a4, a5, a6;
    int addend;
    a0 = curArray[0];
    a1 = curArray[1];
    a2 = curArray[2];
    a3 = curArray[3];
    a4 = curArray[4];
    a5 = curArray[5];
    a6 = curArray[6];
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
        addend = addend + addend;
    }
    curArray[0] = a0;
    curArray[1] = a1;
    curArray[2] = a2;
    curArray[3] = a3;
    curArray[4] = a4;
    curArray[5] = a5;
    curArray[6] = a6;
}

__kernel void Integer_addition_8_no(__global int* dataArray, long iter, int interval)
{
    __global int* curArray = dataArray + get_global_id(0) * interval;
	int a0, a1, a2, a3, a4, a5, a6, a7;
    int addend;
    a0 = curArray[0];
    a1 = curArray[1];
    a2 = curArray[2];
    a3 = curArray[3];
    a4 = curArray[4];
    a5 = curArray[5];
    a6 = curArray[6];
    a7 = curArray[7];
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
        addend = addend + addend;
    }
    curArray[0] = a0;
    curArray[1] = a1;
    curArray[2] = a2;
    curArray[3] = a3;
    curArray[4] = a4;
    curArray[5] = a5;
    curArray[6] = a6;
    curArray[7] = a7;
}

__kernel void Integer_addition_9_no(__global int* dataArray, long iter, int interval)
{
    __global int* curArray = dataArray + get_global_id(0) * interval;
	int a0, a1, a2, a3, a4, a5, a6, a7, a8;
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
        addend = addend + addend;
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
}

__kernel void Integer_addition_10_no(__global int* dataArray, long iter, int interval)
{
    __global int* curArray = dataArray + get_global_id(0) * interval;
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
        addend = addend + addend;
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

__kernel void Integer_addition_11_no(__global int* dataArray, long iter, int interval)
{
    __global int* curArray = dataArray + get_global_id(0) * interval;
	int a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10;
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
    a10 = curArray[10];
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
       	a10 = a10 + addend;
        addend = addend + addend;
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
    curArray[10] = a10;
}

__kernel void Integer_addition_12_no(__global int* dataArray, long iter, int interval)
{
    __global int* curArray = dataArray + get_global_id(0) * interval;
	int a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11;
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
    a10 = curArray[10];
    a11 = curArray[11];
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
       	a10 = a10 + addend;
       	a11 = a11 + addend;
        addend = addend + addend;
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
    curArray[10] = a10;
    curArray[11] = a11;
}

__kernel void Integer_addition_13_no(__global int* dataArray, long iter, int interval)
{
    __global int* curArray = dataArray + get_global_id(0) * interval;
	int a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12;
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
    a10 = curArray[10];
    a11 = curArray[11];
    a12 = curArray[12];
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
       	a10 = a10 + addend;
       	a11 = a11 + addend;
       	a12 = a12 + addend;
        addend = addend + addend;
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
    curArray[10] = a10;
    curArray[11] = a11;
    curArray[12] = a12;
}

__kernel void Integer_addition_14_no(__global int* dataArray, long iter, int interval)
{
    __global int* curArray = dataArray + get_global_id(0) * interval;
	int a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13;
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
    a10 = curArray[10];
    a11 = curArray[11];
    a12 = curArray[12];
    a13 = curArray[13];
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
       	a10 = a10 + addend;
       	a11 = a11 + addend;
       	a12 = a12 + addend;
       	a13 = a13 + addend;
        addend = addend + addend;
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
    curArray[10] = a10;
    curArray[11] = a11;
    curArray[12] = a12;
    curArray[13] = a13;
}

__kernel void Integer_addition_15_no(__global int* dataArray, long iter, int interval)
{
    __global int* curArray = dataArray + get_global_id(0) * interval;
	int a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14;
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
    a10 = curArray[10];
    a11 = curArray[11];
    a12 = curArray[12];
    a13 = curArray[13];
    a14 = curArray[14];
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
       	a10 = a10 + addend;
       	a11 = a11 + addend;
       	a12 = a12 + addend;
       	a13 = a13 + addend;
       	a14 = a14 + addend;
        addend = addend + addend;
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
    curArray[10] = a10;
    curArray[11] = a11;
    curArray[12] = a12;
    curArray[13] = a13;
    curArray[14] = a14;
}

__kernel void Integer_addition_16_no(__global int* dataArray, long iter, int interval)
{
    __global int* curArray = dataArray + get_global_id(0) * interval;
	int a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15;
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
    a10 = curArray[10];
    a11 = curArray[11];
    a12 = curArray[12];
    a13 = curArray[13];
    a14 = curArray[14];
    a15 = curArray[15];
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
       	a10 = a10 + addend;
       	a11 = a11 + addend;
       	a12 = a12 + addend;
       	a13 = a13 + addend;
       	a14 = a14 + addend;
       	a15 = a15 + addend;
        addend = addend + addend;
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
    curArray[10] = a10;
    curArray[11] = a11;
    curArray[12] = a12;
    curArray[13] = a13;
    curArray[14] = a14;
    curArray[15] = a15;
}

__kernel void Integer_addition_17_no(__global int* dataArray, long iter, int interval)
{
    __global int* curArray = dataArray + get_global_id(0) * interval;
	int a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16;
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
    a10 = curArray[10];
    a11 = curArray[11];
    a12 = curArray[12];
    a13 = curArray[13];
    a14 = curArray[14];
    a15 = curArray[15];
    a16 = curArray[16];
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
       	a10 = a10 + addend;
       	a11 = a11 + addend;
       	a12 = a12 + addend;
       	a13 = a13 + addend;
       	a14 = a14 + addend;
       	a15 = a15 + addend;
       	a16 = a16 + addend;
        addend = addend + addend;
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
    curArray[10] = a10;
    curArray[11] = a11;
    curArray[12] = a12;
    curArray[13] = a13;
    curArray[14] = a14;
    curArray[15] = a15;
    curArray[16] = a16;
}

__kernel void Integer_addition_18_no(__global int* dataArray, long iter, int interval)
{
    __global int* curArray = dataArray + get_global_id(0) * interval;
	int a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17;
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
    a10 = curArray[10];
    a11 = curArray[11];
    a12 = curArray[12];
    a13 = curArray[13];
    a14 = curArray[14];
    a15 = curArray[15];
    a16 = curArray[16];
    a17 = curArray[17];
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
       	a10 = a10 + addend;
       	a11 = a11 + addend;
       	a12 = a12 + addend;
       	a13 = a13 + addend;
       	a14 = a14 + addend;
       	a15 = a15 + addend;
       	a16 = a16 + addend;
       	a17 = a17 + addend;
        addend = addend + addend;
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
    curArray[10] = a10;
    curArray[11] = a11;
    curArray[12] = a12;
    curArray[13] = a13;
    curArray[14] = a14;
    curArray[15] = a15;
    curArray[16] = a16;
    curArray[17] = a17;
}

__kernel void Integer_addition_19_no(__global int* dataArray, long iter, int interval)
{
    __global int* curArray = dataArray + get_global_id(0) * interval;
	int a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18;
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
    a10 = curArray[10];
    a11 = curArray[11];
    a12 = curArray[12];
    a13 = curArray[13];
    a14 = curArray[14];
    a15 = curArray[15];
    a16 = curArray[16];
    a17 = curArray[17];
    a18 = curArray[18];
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
       	a10 = a10 + addend;
       	a11 = a11 + addend;
       	a12 = a12 + addend;
       	a13 = a13 + addend;
       	a14 = a14 + addend;
       	a15 = a15 + addend;
       	a16 = a16 + addend;
       	a17 = a17 + addend;
       	a18 = a18 + addend;
        addend = addend + addend;
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
    curArray[10] = a10;
    curArray[11] = a11;
    curArray[12] = a12;
    curArray[13] = a13;
    curArray[14] = a14;
    curArray[15] = a15;
    curArray[16] = a16;
    curArray[17] = a17;
    curArray[18] = a18;
}

__kernel void Integer_addition_20_no(__global int* dataArray, long iter, int interval)
{
    __global int* curArray = dataArray + get_global_id(0) * interval;
	int a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19;
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
    a10 = curArray[10];
    a11 = curArray[11];
    a12 = curArray[12];
    a13 = curArray[13];
    a14 = curArray[14];
    a15 = curArray[15];
    a16 = curArray[16];
    a17 = curArray[17];
    a18 = curArray[18];
    a19 = curArray[19];
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
       	a10 = a10 + addend;
       	a11 = a11 + addend;
       	a12 = a12 + addend;
       	a13 = a13 + addend;
       	a14 = a14 + addend;
       	a15 = a15 + addend;
       	a16 = a16 + addend;
       	a17 = a17 + addend;
       	a18 = a18 + addend;
       	a19 = a19 + addend;
        addend = addend + addend;
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
    curArray[10] = a10;
    curArray[11] = a11;
    curArray[12] = a12;
    curArray[13] = a13;
    curArray[14] = a14;
    curArray[15] = a15;
    curArray[16] = a16;
    curArray[17] = a17;
    curArray[18] = a18;
    curArray[19] = a19;
}
__kernel void Integer_addition_1_full(__global int* dataArray, long iter, int interval)
{
    __global int* curArray = dataArray + get_global_id(0) * interval;
	int a0;
    int addend;
    a0 = curArray[0];
    addend = a0;
    while (iter -- > 1)
    {
        a0 = a0 + addend;
        addend = addend + addend;
    }
    curArray[0] = a0;
}

__kernel void Integer_addition_2_full(__global int* dataArray, long iter, int interval)
{
    __global int* curArray = dataArray + get_global_id(0) * interval;
	int a0, a1;
    int addend;
    a0 = curArray[0];
    a1 = curArray[1];
    addend = a0;
    while (iter -- > 1)
    {
        a1 = a0 + addend;
        a0 = a1 + addend;
        addend = addend + addend;
    }
    curArray[0] = a0;
    curArray[1] = a1;
}

__kernel void Integer_addition_3_full(__global int* dataArray, long iter, int interval)
{
    __global int* curArray = dataArray + get_global_id(0) * interval;
	int a0, a1, a2;
    int addend;
    a0 = curArray[0];
    a1 = curArray[1];
    a2 = curArray[2];
    addend = a0;
    while (iter -- > 1)
    {
        a1 = a0 + addend;
        a2 = a1 + addend;
        a0 = a2 + addend;
        addend = addend + addend;
    }
    curArray[0] = a0;
    curArray[1] = a1;
    curArray[2] = a2;
}

__kernel void Integer_addition_4_full(__global int* dataArray, long iter, int interval)
{
    __global int* curArray = dataArray + get_global_id(0) * interval;
	int a0, a1, a2, a3;
    int addend;
    a0 = curArray[0];
    a1 = curArray[1];
    a2 = curArray[2];
    a3 = curArray[3];
    addend = a0;
    while (iter -- > 1)
    {
        a1 = a0 + addend;
        a2 = a1 + addend;
        a3 = a2 + addend;
        a0 = a3 + addend;
        addend = addend + addend;
    }
    curArray[0] = a0;
    curArray[1] = a1;
    curArray[2] = a2;
    curArray[3] = a3;
}

__kernel void Integer_addition_5_full(__global int* dataArray, long iter, int interval)
{
    __global int* curArray = dataArray + get_global_id(0) * interval;
	int a0, a1, a2, a3, a4;
    int addend;
    a0 = curArray[0];
    a1 = curArray[1];
    a2 = curArray[2];
    a3 = curArray[3];
    a4 = curArray[4];
    addend = a0;
    while (iter -- > 1)
    {
        a1 = a0 + addend;
        a2 = a1 + addend;
        a3 = a2 + addend;
        a4 = a3 + addend;
        a0 = a4 + addend;
        addend = addend + addend;
    }
    curArray[0] = a0;
    curArray[1] = a1;
    curArray[2] = a2;
    curArray[3] = a3;
    curArray[4] = a4;
}

__kernel void Integer_addition_6_full(__global int* dataArray, long iter, int interval)
{
    __global int* curArray = dataArray + get_global_id(0) * interval;
	int a0, a1, a2, a3, a4, a5;
    int addend;
    a0 = curArray[0];
    a1 = curArray[1];
    a2 = curArray[2];
    a3 = curArray[3];
    a4 = curArray[4];
    a5 = curArray[5];
    addend = a0;
    while (iter -- > 1)
    {
        a1 = a0 + addend;
        a2 = a1 + addend;
        a3 = a2 + addend;
        a4 = a3 + addend;
        a5 = a4 + addend;
        a0 = a5 + addend;
        addend = addend + addend;
    }
    curArray[0] = a0;
    curArray[1] = a1;
    curArray[2] = a2;
    curArray[3] = a3;
    curArray[4] = a4;
    curArray[5] = a5;
}

__kernel void Integer_addition_7_full(__global int* dataArray, long iter, int interval)
{
    __global int* curArray = dataArray + get_global_id(0) * interval;
	int a0, a1, a2, a3, a4, a5, a6;
    int addend;
    a0 = curArray[0];
    a1 = curArray[1];
    a2 = curArray[2];
    a3 = curArray[3];
    a4 = curArray[4];
    a5 = curArray[5];
    a6 = curArray[6];
    addend = a0;
    while (iter -- > 1)
    {
        a1 = a0 + addend;
        a2 = a1 + addend;
        a3 = a2 + addend;
        a4 = a3 + addend;
        a5 = a4 + addend;
        a6 = a5 + addend;
        a0 = a6 + addend;
        addend = addend + addend;
    }
    curArray[0] = a0;
    curArray[1] = a1;
    curArray[2] = a2;
    curArray[3] = a3;
    curArray[4] = a4;
    curArray[5] = a5;
    curArray[6] = a6;
}

__kernel void Integer_addition_8_full(__global int* dataArray, long iter, int interval)
{
    __global int* curArray = dataArray + get_global_id(0) * interval;
	int a0, a1, a2, a3, a4, a5, a6, a7;
    int addend;
    a0 = curArray[0];
    a1 = curArray[1];
    a2 = curArray[2];
    a3 = curArray[3];
    a4 = curArray[4];
    a5 = curArray[5];
    a6 = curArray[6];
    a7 = curArray[7];
    addend = a0;
    while (iter -- > 1)
    {
        a1 = a0 + addend;
        a2 = a1 + addend;
        a3 = a2 + addend;
        a4 = a3 + addend;
        a5 = a4 + addend;
        a6 = a5 + addend;
        a7 = a6 + addend;
        a0 = a7 + addend;
        addend = addend + addend;
    }
    curArray[0] = a0;
    curArray[1] = a1;
    curArray[2] = a2;
    curArray[3] = a3;
    curArray[4] = a4;
    curArray[5] = a5;
    curArray[6] = a6;
    curArray[7] = a7;
}

__kernel void Integer_addition_9_full(__global int* dataArray, long iter, int interval)
{
    __global int* curArray = dataArray + get_global_id(0) * interval;
	int a0, a1, a2, a3, a4, a5, a6, a7, a8;
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
    addend = a0;
    while (iter -- > 1)
    {
        a1 = a0 + addend;
        a2 = a1 + addend;
        a3 = a2 + addend;
        a4 = a3 + addend;
        a5 = a4 + addend;
        a6 = a5 + addend;
        a7 = a6 + addend;
        a8 = a7 + addend;
        a0 = a8 + addend;
        addend = addend + addend;
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
}

__kernel void Integer_addition_10_full(__global int* dataArray, long iter, int interval)
{
    __global int* curArray = dataArray + get_global_id(0) * interval;
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
        a1 = a0 + addend;
        a2 = a1 + addend;
        a3 = a2 + addend;
        a4 = a3 + addend;
        a5 = a4 + addend;
        a6 = a5 + addend;
        a7 = a6 + addend;
        a8 = a7 + addend;
        a9 = a8 + addend;
        a0 = a9 + addend;
        addend = addend + addend;
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

__kernel void Integer_addition_11_full(__global int* dataArray, long iter, int interval)
{
    __global int* curArray = dataArray + get_global_id(0) * interval;
	int a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10;
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
    a10 = curArray[10];
    addend = a0;
    while (iter -- > 1)
    {
        a1 = a0 + addend;
        a2 = a1 + addend;
        a3 = a2 + addend;
        a4 = a3 + addend;
        a5 = a4 + addend;
        a6 = a5 + addend;
        a7 = a6 + addend;
        a8 = a7 + addend;
        a9 = a8 + addend;
        a10 = a9 + addend;
       	a0 = a10 + addend;
        addend = addend + addend;
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
    curArray[10] = a10;
}

__kernel void Integer_addition_12_full(__global int* dataArray, long iter, int interval)
{
    __global int* curArray = dataArray + get_global_id(0) * interval;
	int a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11;
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
    a10 = curArray[10];
    a11 = curArray[11];
    addend = a0;
    while (iter -- > 1)
    {
        a1 = a0 + addend;
        a2 = a1 + addend;
        a3 = a2 + addend;
        a4 = a3 + addend;
        a5 = a4 + addend;
        a6 = a5 + addend;
        a7 = a6 + addend;
        a8 = a7 + addend;
        a9 = a8 + addend;
        a10 = a9 + addend;
       	a11 = a10 + addend;
       	a0 = a11 + addend;
        addend = addend + addend;
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
    curArray[10] = a10;
    curArray[11] = a11;
}

__kernel void Integer_addition_13_full(__global int* dataArray, long iter, int interval)
{
    __global int* curArray = dataArray + get_global_id(0) * interval;
	int a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12;
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
    a10 = curArray[10];
    a11 = curArray[11];
    a12 = curArray[12];
    addend = a0;
    while (iter -- > 1)
    {
        a1 = a0 + addend;
        a2 = a1 + addend;
        a3 = a2 + addend;
        a4 = a3 + addend;
        a5 = a4 + addend;
        a6 = a5 + addend;
        a7 = a6 + addend;
        a8 = a7 + addend;
        a9 = a8 + addend;
        a10 = a9 + addend;
       	a11 = a10 + addend;
       	a12 = a11 + addend;
       	a0 = a12 + addend;
        addend = addend + addend;
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
    curArray[10] = a10;
    curArray[11] = a11;
    curArray[12] = a12;
}

__kernel void Integer_addition_14_full(__global int* dataArray, long iter, int interval)
{
    __global int* curArray = dataArray + get_global_id(0) * interval;
	int a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13;
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
    a10 = curArray[10];
    a11 = curArray[11];
    a12 = curArray[12];
    a13 = curArray[13];
    addend = a0;
    while (iter -- > 1)
    {
        a1 = a0 + addend;
        a2 = a1 + addend;
        a3 = a2 + addend;
        a4 = a3 + addend;
        a5 = a4 + addend;
        a6 = a5 + addend;
        a7 = a6 + addend;
        a8 = a7 + addend;
        a9 = a8 + addend;
        a10 = a9 + addend;
       	a11 = a10 + addend;
       	a12 = a11 + addend;
       	a13 = a12 + addend;
       	a0 = a13 + addend;
        addend = addend + addend;
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
    curArray[10] = a10;
    curArray[11] = a11;
    curArray[12] = a12;
    curArray[13] = a13;
}

__kernel void Integer_addition_15_full(__global int* dataArray, long iter, int interval)
{
    __global int* curArray = dataArray + get_global_id(0) * interval;
	int a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14;
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
    a10 = curArray[10];
    a11 = curArray[11];
    a12 = curArray[12];
    a13 = curArray[13];
    a14 = curArray[14];
    addend = a0;
    while (iter -- > 1)
    {
        a1 = a0 + addend;
        a2 = a1 + addend;
        a3 = a2 + addend;
        a4 = a3 + addend;
        a5 = a4 + addend;
        a6 = a5 + addend;
        a7 = a6 + addend;
        a8 = a7 + addend;
        a9 = a8 + addend;
        a10 = a9 + addend;
       	a11 = a10 + addend;
       	a12 = a11 + addend;
       	a13 = a12 + addend;
       	a14 = a13 + addend;
       	a0 = a14 + addend;
        addend = addend + addend;
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
    curArray[10] = a10;
    curArray[11] = a11;
    curArray[12] = a12;
    curArray[13] = a13;
    curArray[14] = a14;
}

__kernel void Integer_addition_16_full(__global int* dataArray, long iter, int interval)
{
    __global int* curArray = dataArray + get_global_id(0) * interval;
	int a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15;
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
    a10 = curArray[10];
    a11 = curArray[11];
    a12 = curArray[12];
    a13 = curArray[13];
    a14 = curArray[14];
    a15 = curArray[15];
    addend = a0;
    while (iter -- > 1)
    {
        a1 = a0 + addend;
        a2 = a1 + addend;
        a3 = a2 + addend;
        a4 = a3 + addend;
        a5 = a4 + addend;
        a6 = a5 + addend;
        a7 = a6 + addend;
        a8 = a7 + addend;
        a9 = a8 + addend;
        a10 = a9 + addend;
       	a11 = a10 + addend;
       	a12 = a11 + addend;
       	a13 = a12 + addend;
       	a14 = a13 + addend;
       	a15 = a14 + addend;
       	a0 = a15 + addend;
        addend = addend + addend;
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
    curArray[10] = a10;
    curArray[11] = a11;
    curArray[12] = a12;
    curArray[13] = a13;
    curArray[14] = a14;
    curArray[15] = a15;
}

__kernel void Integer_addition_17_full(__global int* dataArray, long iter, int interval)
{
    __global int* curArray = dataArray + get_global_id(0) * interval;
	int a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16;
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
    a10 = curArray[10];
    a11 = curArray[11];
    a12 = curArray[12];
    a13 = curArray[13];
    a14 = curArray[14];
    a15 = curArray[15];
    a16 = curArray[16];
    addend = a0;
    while (iter -- > 1)
    {
        a1 = a0 + addend;
        a2 = a1 + addend;
        a3 = a2 + addend;
        a4 = a3 + addend;
        a5 = a4 + addend;
        a6 = a5 + addend;
        a7 = a6 + addend;
        a8 = a7 + addend;
        a9 = a8 + addend;
        a10 = a9 + addend;
       	a11 = a10 + addend;
       	a12 = a11 + addend;
       	a13 = a12 + addend;
       	a14 = a13 + addend;
       	a15 = a14 + addend;
       	a16 = a15 + addend;
       	a0 = a16 + addend;
        addend = addend + addend;
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
    curArray[10] = a10;
    curArray[11] = a11;
    curArray[12] = a12;
    curArray[13] = a13;
    curArray[14] = a14;
    curArray[15] = a15;
    curArray[16] = a16;
}

__kernel void Integer_addition_18_full(__global int* dataArray, long iter, int interval)
{
    __global int* curArray = dataArray + get_global_id(0) * interval;
	int a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17;
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
    a10 = curArray[10];
    a11 = curArray[11];
    a12 = curArray[12];
    a13 = curArray[13];
    a14 = curArray[14];
    a15 = curArray[15];
    a16 = curArray[16];
    a17 = curArray[17];
    addend = a0;
    while (iter -- > 1)
    {
        a1 = a0 + addend;
        a2 = a1 + addend;
        a3 = a2 + addend;
        a4 = a3 + addend;
        a5 = a4 + addend;
        a6 = a5 + addend;
        a7 = a6 + addend;
        a8 = a7 + addend;
        a9 = a8 + addend;
        a10 = a9 + addend;
       	a11 = a10 + addend;
       	a12 = a11 + addend;
       	a13 = a12 + addend;
       	a14 = a13 + addend;
       	a15 = a14 + addend;
       	a16 = a15 + addend;
       	a17 = a16 + addend;
       	a0 = a17 + addend;
        addend = addend + addend;
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
    curArray[10] = a10;
    curArray[11] = a11;
    curArray[12] = a12;
    curArray[13] = a13;
    curArray[14] = a14;
    curArray[15] = a15;
    curArray[16] = a16;
    curArray[17] = a17;
}

__kernel void Integer_addition_19_full(__global int* dataArray, long iter, int interval)
{
    __global int* curArray = dataArray + get_global_id(0) * interval;
	int a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18;
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
    a10 = curArray[10];
    a11 = curArray[11];
    a12 = curArray[12];
    a13 = curArray[13];
    a14 = curArray[14];
    a15 = curArray[15];
    a16 = curArray[16];
    a17 = curArray[17];
    a18 = curArray[18];
    addend = a0;
    while (iter -- > 1)
    {
        a1 = a0 + addend;
        a2 = a1 + addend;
        a3 = a2 + addend;
        a4 = a3 + addend;
        a5 = a4 + addend;
        a6 = a5 + addend;
        a7 = a6 + addend;
        a8 = a7 + addend;
        a9 = a8 + addend;
        a10 = a9 + addend;
       	a11 = a10 + addend;
       	a12 = a11 + addend;
       	a13 = a12 + addend;
       	a14 = a13 + addend;
       	a15 = a14 + addend;
       	a16 = a15 + addend;
       	a17 = a16 + addend;
       	a18 = a17 + addend;
       	a0 = a18 + addend;
        addend = addend + addend;
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
    curArray[10] = a10;
    curArray[11] = a11;
    curArray[12] = a12;
    curArray[13] = a13;
    curArray[14] = a14;
    curArray[15] = a15;
    curArray[16] = a16;
    curArray[17] = a17;
    curArray[18] = a18;
}

__kernel void Integer_addition_20_full(__global int* dataArray, long iter, int interval)
{
    __global int* curArray = dataArray + get_global_id(0) * interval;
	int a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19;
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
    a10 = curArray[10];
    a11 = curArray[11];
    a12 = curArray[12];
    a13 = curArray[13];
    a14 = curArray[14];
    a15 = curArray[15];
    a16 = curArray[16];
    a17 = curArray[17];
    a18 = curArray[18];
    a19 = curArray[19];
    addend = a0;
    while (iter -- > 1)
    {
        a1 = a0 + addend;
        a2 = a1 + addend;
        a3 = a2 + addend;
        a4 = a3 + addend;
        a5 = a4 + addend;
        a6 = a5 + addend;
        a7 = a6 + addend;
        a8 = a7 + addend;
        a9 = a8 + addend;
        a10 = a9 + addend;
       	a11 = a10 + addend;
       	a12 = a11 + addend;
       	a13 = a12 + addend;
       	a14 = a13 + addend;
       	a15 = a14 + addend;
       	a16 = a15 + addend;
       	a17 = a16 + addend;
       	a18 = a17 + addend;
       	a19 = a18 + addend;
       	a0 = a19 + addend;
        addend = addend + addend;
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
    curArray[10] = a10;
    curArray[11] = a11;
    curArray[12] = a12;
    curArray[13] = a13;
    curArray[14] = a14;
    curArray[15] = a15;
    curArray[16] = a16;
    curArray[17] = a17;
    curArray[18] = a18;
    curArray[19] = a19;
}
