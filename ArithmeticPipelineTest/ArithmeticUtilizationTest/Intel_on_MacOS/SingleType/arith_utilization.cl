__kernel void Integer_addition_0_10(__global int* dataArray, int iter)
{
    int a0, a1, a2, a3, a4, a5, a6, a7, a8, a9;
    int addend;
    a0 = dataArray[0];
    a1 = dataArray[1];
    a2 = dataArray[2];
    a3 = dataArray[3];
    a4 = dataArray[4];
    a5 = dataArray[5];
    a6 = dataArray[6];
    a7 = dataArray[7];
    a8 = dataArray[8];
    a9 = dataArray[9];
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
    dataArray[0] = a0;
    dataArray[1] = a1;
    dataArray[2] = a2;
    dataArray[3] = a3;
    dataArray[4] = a4;
    dataArray[5] = a5;
    dataArray[6] = a6;
    dataArray[7] = a7;
    dataArray[8] = a8;
    dataArray[9] = a9;
}

__kernel void Integer2_addition_0_10(__global int2* dataArray, int iter)
{
    int2 a0, a1, a2, a3, a4, a5, a6, a7, a8, a9;
    int2 addend;
    a0 = dataArray[0];
    a1 = dataArray[1];
    a2 = dataArray[2];
    a3 = dataArray[3];
    a4 = dataArray[4];
    a5 = dataArray[5];
    a6 = dataArray[6];
    a7 = dataArray[7];
    a8 = dataArray[8];
    a9 = dataArray[9];
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
    dataArray[0] = a0;
    dataArray[1] = a1;
    dataArray[2] = a2;
    dataArray[3] = a3;
    dataArray[4] = a4;
    dataArray[5] = a5;
    dataArray[6] = a6;
    dataArray[7] = a7;
    dataArray[8] = a8;
    dataArray[9] = a9;
}


__kernel void Integer4_addition_0_10(__global int4* dataArray, int iter)
{
    int4 a0, a1, a2, a3, a4, a5, a6, a7, a8, a9;
    int4 addend;
    a0 = dataArray[0];
    a1 = dataArray[1];
    a2 = dataArray[2];
    a3 = dataArray[3];
    a4 = dataArray[4];
    a5 = dataArray[5];
    a6 = dataArray[6];
    a7 = dataArray[7];
    a8 = dataArray[8];
    a9 = dataArray[9];
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
    dataArray[0] = a0;
    dataArray[1] = a1;
    dataArray[2] = a2;
    dataArray[3] = a3;
    dataArray[4] = a4;
    dataArray[5] = a5;
    dataArray[6] = a6;
    dataArray[7] = a7;
    dataArray[8] = a8;
    dataArray[9] = a9;
}

__kernel void Integer_addition_0_10_f(__global int* dataArray, int iter)
{
    int a0, a1, a2, a3, a4, a5, a6, a7, a8, a9;
    int addend;
    a0 = dataArray[0];
    a1 = dataArray[1];
    a2 = dataArray[2];
    a3 = dataArray[3];
    a4 = dataArray[4];
    a5 = dataArray[5];
    a6 = dataArray[6];
    a7 = dataArray[7];
    a8 = dataArray[8];
    a9 = dataArray[9];
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
    dataArray[0] = a0;
    dataArray[1] = a1;
    dataArray[2] = a2;
    dataArray[3] = a3;
    dataArray[4] = a4;
    dataArray[5] = a5;
    dataArray[6] = a6;
    dataArray[7] = a7;
    dataArray[8] = a8;
    dataArray[9] = a9;
}

__kernel void Integer2_addition_0_10_f(__global int2* dataArray, int iter)
{
    int2 a0, a1, a2, a3, a4, a5, a6, a7, a8, a9;
    int2 addend;
    a0 = dataArray[0];
    a1 = dataArray[1];
    a2 = dataArray[2];
    a3 = dataArray[3];
    a4 = dataArray[4];
    a5 = dataArray[5];
    a6 = dataArray[6];
    a7 = dataArray[7];
    a8 = dataArray[8];
    a9 = dataArray[9];
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
    dataArray[0] = a0;
    dataArray[1] = a1;
    dataArray[2] = a2;
    dataArray[3] = a3;
    dataArray[4] = a4;
    dataArray[5] = a5;
    dataArray[6] = a6;
    dataArray[7] = a7;
    dataArray[8] = a8;
    dataArray[9] = a9;
}

__kernel void Integer4_addition_0_10_f(__global int4* dataArray, int iter)
{
    int4 a0, a1, a2, a3, a4, a5, a6, a7, a8, a9;
    int4 addend;
    a0 = dataArray[0];
    a1 = dataArray[1];
    a2 = dataArray[2];
    a3 = dataArray[3];
    a4 = dataArray[4];
    a5 = dataArray[5];
    a6 = dataArray[6];
    a7 = dataArray[7];
    a8 = dataArray[8];
    a9 = dataArray[9];
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
    dataArray[0] = a0;
    dataArray[1] = a1;
    dataArray[2] = a2;
    dataArray[3] = a3;
    dataArray[4] = a4;
    dataArray[5] = a5;
    dataArray[6] = a6;
    dataArray[7] = a7;
    dataArray[8] = a8;
    dataArray[9] = a9;
}

__kernel void Float_addition_0_10(__global float* dataArray, int iter)
{
    float a0, a1, a2, a3, a4, a5, a6, a7, a8, a9;
    float addend;
    a0 = dataArray[0];
    a1 = dataArray[1];
    a2 = dataArray[2];
    a3 = dataArray[3];
    a4 = dataArray[4];
    a5 = dataArray[5];
    a6 = dataArray[6];
    a7 = dataArray[7];
    a8 = dataArray[8];
    a9 = dataArray[9];
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
    dataArray[0] = a0;
    dataArray[1] = a1;
    dataArray[2] = a2;
    dataArray[3] = a3;
    dataArray[4] = a4;
    dataArray[5] = a5;
    dataArray[6] = a6;
    dataArray[7] = a7;
    dataArray[8] = a8;
    dataArray[9] = a9;
}

__kernel void Float2_addition_0_10(__global float2* dataArray, int iter)
{
    float2 a0, a1, a2, a3, a4, a5, a6, a7, a8, a9;
    float2 addend;
    a0 = dataArray[0];
    a1 = dataArray[1];
    a2 = dataArray[2];
    a3 = dataArray[3];
    a4 = dataArray[4];
    a5 = dataArray[5];
    a6 = dataArray[6];
    a7 = dataArray[7];
    a8 = dataArray[8];
    a9 = dataArray[9];
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
    dataArray[0] = a0;
    dataArray[1] = a1;
    dataArray[2] = a2;
    dataArray[3] = a3;
    dataArray[4] = a4;
    dataArray[5] = a5;
    dataArray[6] = a6;
    dataArray[7] = a7;
    dataArray[8] = a8;
    dataArray[9] = a9;
}

__kernel void Float4_addition_0_10(__global float4* dataArray, int iter)
{
    float4 a0, a1, a2, a3, a4, a5, a6, a7, a8, a9;
    float4 addend;
    a0 = dataArray[0];
    a1 = dataArray[1];
    a2 = dataArray[2];
    a3 = dataArray[3];
    a4 = dataArray[4];
    a5 = dataArray[5];
    a6 = dataArray[6];
    a7 = dataArray[7];
    a8 = dataArray[8];
    a9 = dataArray[9];
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
    dataArray[0] = a0;
    dataArray[1] = a1;
    dataArray[2] = a2;
    dataArray[3] = a3;
    dataArray[4] = a4;
    dataArray[5] = a5;
    dataArray[6] = a6;
    dataArray[7] = a7;
    dataArray[8] = a8;
    dataArray[9] = a9;
}

__kernel void Double_addition_0_10(__global double* dataArray, int iter)
{
    double a0, a1, a2, a3, a4, a5, a6, a7, a8, a9;
    double addend;
    a0 = dataArray[0];
    a1 = dataArray[1];
    a2 = dataArray[2];
    a3 = dataArray[3];
    a4 = dataArray[4];
    a5 = dataArray[5];
    a6 = dataArray[6];
    a7 = dataArray[7];
    a8 = dataArray[8];
    a9 = dataArray[9];
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
    dataArray[0] = a0;
    dataArray[1] = a1;
    dataArray[2] = a2;
    dataArray[3] = a3;
    dataArray[4] = a4;
    dataArray[5] = a5;
    dataArray[6] = a6;
    dataArray[7] = a7;
    dataArray[8] = a8;
    dataArray[9] = a9;
}

__kernel void Double2_addition_0_10(__global double2* dataArray, int iter)
{
    double2 a0, a1, a2, a3, a4, a5, a6, a7, a8, a9;
    double2 addend;
    a0 = dataArray[0];
    a1 = dataArray[1];
    a2 = dataArray[2];
    a3 = dataArray[3];
    a4 = dataArray[4];
    a5 = dataArray[5];
    a6 = dataArray[6];
    a7 = dataArray[7];
    a8 = dataArray[8];
    a9 = dataArray[9];
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
    dataArray[0] = a0;
    dataArray[1] = a1;
    dataArray[2] = a2;
    dataArray[3] = a3;
    dataArray[4] = a4;
    dataArray[5] = a5;
    dataArray[6] = a6;
    dataArray[7] = a7;
    dataArray[8] = a8;
    dataArray[9] = a9;
}

__kernel void Double4_addition_0_10(__global double4* dataArray, int iter)
{
    double4 a0, a1, a2, a3, a4, a5, a6, a7, a8, a9;
    double4 addend;
    a0 = dataArray[0];
    a1 = dataArray[1];
    a2 = dataArray[2];
    a3 = dataArray[3];
    a4 = dataArray[4];
    a5 = dataArray[5];
    a6 = dataArray[6];
    a7 = dataArray[7];
    a8 = dataArray[8];
    a9 = dataArray[9];
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
    dataArray[0] = a0;
    dataArray[1] = a1;
    dataArray[2] = a2;
    dataArray[3] = a3;
    dataArray[4] = a4;
    dataArray[5] = a5;
    dataArray[6] = a6;
    dataArray[7] = a7;
    dataArray[8] = a8;
    dataArray[9] = a9;
}

__kernel void Integer_addition_10_10(__global int* dataArray, int iter)
{
    int a0, a1, a2, a3, a4, a5, a6, a7, a8, a9;
    int addend;
    a0 = dataArray[0];
    a1 = dataArray[1];
    a2 = dataArray[2];
    a3 = dataArray[3];
    a4 = dataArray[4];
    a5 = dataArray[5];
    a6 = dataArray[6];
    a7 = dataArray[7];
    a8 = dataArray[8];
    a9 = dataArray[9];
    addend = a0;
    while (iter -- > 1)
    {
        a1 = a0 + addend;
        a2 = a1 + a2;
        a3 = a2 + a3;
        a4 = a3 + a4;
        a5 = a4 + a5;
        a6 = a5 + a6;
        a7 = a6 + a7;
        a8 = a7 + a8;
        a9 = a8 + a9;
        a0 = a9 + a0;
        addend = addend + a0;
    }
    dataArray[0] = a0;
    dataArray[1] = a1;
    dataArray[2] = a2;
    dataArray[3] = a3;
    dataArray[4] = a4;
    dataArray[5] = a5;
    dataArray[6] = a6;
    dataArray[7] = a7;
    dataArray[8] = a8;
    dataArray[9] = a9;
}

__kernel void Integer_multiplication_0_10(__global int* dataArray, int iter)
{
    int a0, a1, a2, a3, a4, a5, a6, a7, a8, a9;
    int addend;
    a0 = dataArray[0];
    a1 = dataArray[1];
    a2 = dataArray[2];
    a3 = dataArray[3];
    a4 = dataArray[4];
    a5 = dataArray[5];
    a6 = dataArray[6];
    a7 = dataArray[7];
    a8 = dataArray[8];
    a9 = dataArray[9];
    addend = a0;
    while (iter -- > 1)
    {
        a0 = a0 * addend;
        a1 = a1 * addend;
        a2 = a2 * addend;
        a3 = a3 * addend;
        a4 = a4 * addend;
        a5 = a5 * addend;
        a6 = a6 * addend;
        a7 = a7 * addend;
        a8 = a8 * addend;
        a9 = a9 * addend;
        addend = addend + 123456;
    }
    dataArray[0] = a0;
    dataArray[1] = a1;
    dataArray[2] = a2;
    dataArray[3] = a3;
    dataArray[4] = a4;
    dataArray[5] = a5;
    dataArray[6] = a6;
    dataArray[7] = a7;
    dataArray[8] = a8;
    dataArray[9] = a9;
}

__kernel void Integer_multiplication_10_10(__global int* dataArray, int iter)
{
    int a0, a1, a2, a3, a4, a5, a6, a7, a8, a9;
    int addend;
    a0 = dataArray[0];
    a1 = dataArray[1];
    a2 = dataArray[2];
    a3 = dataArray[3];
    a4 = dataArray[4];
    a5 = dataArray[5];
    a6 = dataArray[6];
    a7 = dataArray[7];
    a8 = dataArray[8];
    a9 = dataArray[9];
    addend = a0;
    while (iter -- > 1)
    {
        a1 = a0 * addend;
        a2 = a1 * a2;
        a3 = a2 * a3;
        a4 = a3 * a4;
        a5 = a4 * a5;
        a6 = a5 * a6;
        a7 = a6 * a7;
        a8 = a7 * a8;
        a9 = a8 * a9;
        a0 = a9 * a0;
        addend = addend + 123456;
    }
    dataArray[0] = a0;
    dataArray[1] = a1;
    dataArray[2] = a2;
    dataArray[3] = a3;
    dataArray[4] = a4;
    dataArray[5] = a5;
    dataArray[6] = a6;
    dataArray[7] = a7;
    dataArray[8] = a8;
    dataArray[9] = a9;
}

__kernel void Integer_addition_0_20(__global int* dataArray, int iter)
{
    int a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19;
    int addend;
    a0 = dataArray[0];
    a1 = dataArray[1];
    a2 = dataArray[2];
    a3 = dataArray[3];
    a4 = dataArray[4];
    a5 = dataArray[5];
    a6 = dataArray[6];
    a7 = dataArray[7];
    a8 = dataArray[8];
    a9 = dataArray[9];
    a10 = dataArray[10];
    a11 = dataArray[11];
    a12 = dataArray[12];
    a13 = dataArray[13];
    a14 = dataArray[14];
    a15 = dataArray[15];
    a16 = dataArray[16];
    a17 = dataArray[17];
    a18 = dataArray[18];
    a19 = dataArray[19];
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
        addend = addend + a0;
    }
    dataArray[0] = a0;
    dataArray[1] = a1;
    dataArray[2] = a2;
    dataArray[3] = a3;
    dataArray[4] = a4;
    dataArray[5] = a5;
    dataArray[6] = a6;
    dataArray[7] = a7;
    dataArray[8] = a8;
    dataArray[9] = a9;
    dataArray[10] = a10;
    dataArray[11] = a11;
    dataArray[12] = a12;
    dataArray[13] = a13;
    dataArray[14] = a14;
    dataArray[15] = a15;
    dataArray[16] = a16;
    dataArray[17] = a17;
    dataArray[18] = a18;
    dataArray[19] = a19;
}
