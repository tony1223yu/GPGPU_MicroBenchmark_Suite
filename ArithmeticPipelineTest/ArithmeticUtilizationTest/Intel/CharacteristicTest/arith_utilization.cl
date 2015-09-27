__kernel void Integer_addition_0_10(__global int* dataArray, long iter, int interval)
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

__kernel void Integer2_addition_0_10(__global int2* dataArray, long iter, int interval)
{
	__global int2* curArray = dataArray + get_global_id(0) * interval;
    int2 a0, a1, a2, a3, a4, a5, a6, a7, a8, a9;
    int2 addend;
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

__kernel void Integer4_addition_0_10(__global int4* dataArray, long iter, int interval)
{
	__global int4* curArray = dataArray + get_global_id(0) * interval;
    int4 a0, a1, a2, a3, a4, a5, a6, a7, a8, a9;
    int4 addend;
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

__kernel void Integer8_addition_0_10(__global int8* dataArray, long iter, int interval)
{
	__global int8* curArray = dataArray + get_global_id(0) * interval;
    int8 a0, a1, a2, a3, a4, a5, a6, a7, a8, a9;
    int8 addend;
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

__kernel void Integer_addition_10_10(__global int* dataArray, long iter, int interval)
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

__kernel void Integer2_addition_10_10(__global int2* dataArray, long iter, int interval)
{
	__global int2* curArray = dataArray + get_global_id(0) * interval;
    int2 a0, a1, a2, a3, a4, a5, a6, a7, a8, a9;
    int2 addend;
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

__kernel void Integer4_addition_10_10(__global int4* dataArray, long iter, int interval)
{
	__global int4* curArray = dataArray + get_global_id(0) * interval;
    int4 a0, a1, a2, a3, a4, a5, a6, a7, a8, a9;
    int4 addend;
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

__kernel void Integer8_addition_merge(__global int8* dataArray, long iter, int interval)
{
	__global int8* curArray = dataArray + get_global_id(0) * interval;
    int8 a0, a1, a2, a3, a4, a5, a6, a7, a8, a9;
    int8 a10, a11, a12, a13, a14, a15, a16, a17, a18, a19;
    int8 addend1, addend2;
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
    addend1 = a0;
    addend2 = a1;
    while (iter -- > 1)
    {
        a2 = a0 + addend1;
        a3 = a1 + addend2;
        a4 = a2 + addend1;
        a5 = a3 + addend2;
        a6 = a4 + addend1;
        a7 = a5 + addend2;
        a8 = a6 + addend1;
        a9 = a7 + addend2;
        a10 = a8 + addend1;
        a11 = a9 + addend2;
        a12 = a10 + addend1;
        a13 = a11 + addend2;
        a14 = a12 + addend1;
        a15 = a13 + addend2;
        a16 = a14 + addend1;
        a17 = a15 + addend2;
        a18 = a16 + addend1;
        a19 = a17 + addend2;
        a0 = a18 + addend1;
        a1 = a19 + addend2;
        addend1 = addend1 + a0;
        addend2 = addend2 + a1;
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

__kernel void Integer8_addition_10_10(__global int8* dataArray, long iter, int interval)
{
	__global int8* curArray = dataArray + get_global_id(0) * interval;
    int8 a0, a1, a2, a3, a4, a5, a6, a7, a8, a9;
    int8 addend;
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

__kernel void Float_addition_0_10(__global float* dataArray, long iter, int interval)
{
	__global float* curArray = dataArray + get_global_id(0) * interval;
    float a0, a1, a2, a3, a4, a5, a6, a7, a8, a9;
    float addend;
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
        addend = addend * -0.9999F;
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

__kernel void Float2_addition_0_10(__global float2* dataArray, long iter, int interval)
{
	__global float2* curArray = dataArray + get_global_id(0) * interval;
    float2 a0, a1, a2, a3, a4, a5, a6, a7, a8, a9;
    float2 addend;
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
        addend = addend * -0.9999F;
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

__kernel void Float4_addition_0_10(__global float4* dataArray, long iter, int interval)
{
	__global float4* curArray = dataArray + get_global_id(0) * interval;
    float4 a0, a1, a2, a3, a4, a5, a6, a7, a8, a9;
    float4 addend;
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
        addend = addend * -0.9999F;
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

__kernel void Float8_addition_0_10(__global float8* dataArray, long iter, int interval)
{
	__global float8* curArray = dataArray + get_global_id(0) * interval;
    float8 a0, a1, a2, a3, a4, a5, a6, a7, a8, a9;
    float8 addend;
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
        addend = addend * -0.9999F;
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

__kernel void Double_addition_0_10(__global double* dataArray, long iter, int interval)
{
	__global double* curArray = dataArray + get_global_id(0) * interval;
    double a0, a1, a2, a3, a4, a5, a6, a7, a8, a9;
    double addend;
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
        addend = addend * -0.999999;
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

__kernel void Double2_addition_0_10(__global double2* dataArray, long iter, int interval)
{
	__global double2* curArray = dataArray + get_global_id(0) * interval;
    double2 a0, a1, a2, a3, a4, a5, a6, a7, a8, a9;
    double2 addend;
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
        addend = addend * -0.999999;
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

__kernel void Double4_addition_0_10(__global double4* dataArray, long iter, int interval)
{
	__global double4* curArray = dataArray + get_global_id(0) * interval;
    double4 a0, a1, a2, a3, a4, a5, a6, a7, a8, a9;
    double4 addend;
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
        addend = addend * -0.999999;
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

__kernel void Double8_addition_0_10(__global double8* dataArray, long iter, int interval)
{
	__global double8* curArray = dataArray + get_global_id(0) * interval;
    double8 a0, a1, a2, a3, a4, a5, a6, a7, a8, a9;
    double8 addend;
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
        addend = addend * -0.999999;
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
