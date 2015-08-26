__kernel void Integer_addition_1(__global int* dataArray, int iter)
{
    int a0;
    int addend;
    a0 = dataArray[0];
    addend = a0;
    while (iter -- > 1)
    {
        a0 = a0 + a0;
        addend = addend + a0;
    }
    dataArray[0] = a0;
}

__kernel void Integer_addition_2(__global int* dataArray, int iter)
{
    int a0, a1;
    int addend;
    a0 = dataArray[0];
    a1 = dataArray[1];
    addend = a0;
    while (iter -- > 1)
    {
        a1 = a0 + addend;
        a0 = a1 + a0;
        addend = addend + a0;
    }
    dataArray[0] = a0;
    dataArray[1] = a1;
}

__kernel void Integer_addition_3(__global int* dataArray, int iter)
{
    int a0, a1, a2;
    int addend;
    a0 = dataArray[0];
    a1 = dataArray[1];
    a2 = dataArray[2];
    addend = a0;
    while (iter -- > 1)
    {
        a1 = a0 + addend;
        a2 = a1 + a2;
        a0 = a2 + a0;
        addend = addend + a0;
    }
    dataArray[0] = a0;
    dataArray[1] = a1;
    dataArray[2] = a2;
}

__kernel void Integer_addition_4(__global int* dataArray, int iter)
{
    int a0, a1, a2, a3;
    int addend;
    a0 = dataArray[0];
    a1 = dataArray[1];
    a2 = dataArray[2];
    a3 = dataArray[3];
    addend = a0;
    while (iter -- > 1)
    {
        a1 = a0 + addend;
        a2 = a1 + a2;
        a3 = a2 + a3;
        a0 = a3 + a0;
        addend = addend + a0;
    }
    dataArray[0] = a0;
    dataArray[1] = a1;
    dataArray[2] = a2;
    dataArray[3] = a3;
}

__kernel void Integer_addition_5(__global int* dataArray, int iter)
{
    int a0, a1, a2, a3, a4;
    int addend;
    a0 = dataArray[0];
    a1 = dataArray[1];
    a2 = dataArray[2];
    a3 = dataArray[3];
    a4 = dataArray[4];
    addend = a0;
    while (iter -- > 1)
    {
        a1 = a0 + addend;
        a2 = a1 + a2;
        a3 = a2 + a3;
        a4 = a3 + a4;
        a0 = a4 + a0;
        addend = addend + a0;
    }
    dataArray[0] = a0;
    dataArray[1] = a1;
    dataArray[2] = a2;
    dataArray[3] = a3;
    dataArray[4] = a4;
}

__kernel void Integer_addition_6(__global int* dataArray, int iter)
{
    int a0, a1, a2, a3, a4, a5;
    int addend;
    a0 = dataArray[0];
    a1 = dataArray[1];
    a2 = dataArray[2];
    a3 = dataArray[3];
    a4 = dataArray[4];
    a5 = dataArray[5];
    addend = a0;
    while (iter -- > 1)
    {
        a1 = a0 + addend;
        a2 = a1 + a2;
        a3 = a2 + a3;
        a4 = a3 + a4;
        a5 = a4 + a5;
        a0 = a5 + a0;
        addend = addend + a0;
    }
    dataArray[0] = a0;
    dataArray[1] = a1;
    dataArray[2] = a2;
    dataArray[3] = a3;
    dataArray[4] = a4;
    dataArray[5] = a5;
}

__kernel void Integer_addition_7(__global int* dataArray, int iter)
{
    int a0, a1, a2, a3, a4, a5, a6;
    int addend;
    a0 = dataArray[0];
    a1 = dataArray[1];
    a2 = dataArray[2];
    a3 = dataArray[3];
    a4 = dataArray[4];
    a5 = dataArray[5];
    a6 = dataArray[6];
    addend = a0;
    while (iter -- > 1)
    {
        a1 = a0 + addend;
        a2 = a1 + a2;
        a3 = a2 + a3;
        a4 = a3 + a4;
        a5 = a4 + a5;
        a6 = a5 + a6;
        a0 = a6 + a0;
        addend = addend + a0;
    }
    dataArray[0] = a0;
    dataArray[1] = a1;
    dataArray[2] = a2;
    dataArray[3] = a3;
    dataArray[4] = a4;
    dataArray[5] = a5;
    dataArray[6] = a6;
}

__kernel void Integer_addition_8(__global int* dataArray, int iter)
{
    int a0, a1, a2, a3, a4, a5, a6, a7;
    int addend;
    a0 = dataArray[0];
    a1 = dataArray[1];
    a2 = dataArray[2];
    a3 = dataArray[3];
    a4 = dataArray[4];
    a5 = dataArray[5];
    a6 = dataArray[6];
    a7 = dataArray[7];
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
        a0 = a7 + a0;
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
}

__kernel void Integer_addition_9(__global int* dataArray, int iter)
{
    int a0, a1, a2, a3, a4, a5, a6, a7, a8;
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
        a0 = a8 + a0;
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
}

__kernel void Integer_addition_10(__global int* dataArray, int iter)
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

__kernel void Integer_addition_11(__global int* dataArray, int iter)
{
    int a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10;
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
        a10 = a9 + a10;
       	a0 = a10 + a0;
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
}

__kernel void Integer_addition_12(__global int* dataArray, int iter)
{
    int a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11;
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
        a10 = a9 + a10;
       	a11 = a10 + a11;
       	a0 = a11 + a0;
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
}

__kernel void Integer_addition_13(__global int* dataArray, int iter)
{
    int a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12;
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
        a10 = a9 + a10;
       	a11 = a10 + a11;
       	a12 = a11 + a12;
       	a0 = a12 + a0;
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
}

__kernel void Integer_addition_14(__global int* dataArray, int iter)
{
    int a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13;
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
        a10 = a9 + a10;
       	a11 = a10 + a11;
       	a12 = a11 + a12;
       	a13 = a12 + a13;
       	a0 = a13 + a0;
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
}

__kernel void Integer_addition_15(__global int* dataArray, int iter)
{
    int a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14;
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
        a10 = a9 + a10;
       	a11 = a10 + a11;
       	a12 = a11 + a12;
       	a13 = a12 + a13;
       	a14 = a13 + a14;
       	a0 = a14 + a0;
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
}

__kernel void Integer_addition_16(__global int* dataArray, int iter)
{
    int a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15;
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
        a10 = a9 + a10;
       	a11 = a10 + a11;
       	a12 = a11 + a12;
       	a13 = a12 + a13;
       	a14 = a13 + a14;
       	a15 = a14 + a15;
       	a0 = a15 + a0;
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
}

__kernel void Integer_addition_17(__global int* dataArray, int iter)
{
    int a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16;
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
        a10 = a9 + a10;
       	a11 = a10 + a11;
       	a12 = a11 + a12;
       	a13 = a12 + a13;
       	a14 = a13 + a14;
       	a15 = a14 + a15;
       	a16 = a15 + a16;
       	a0 = a16 + a0;
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
}

__kernel void Integer_addition_18(__global int* dataArray, int iter)
{
    int a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17;
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
        a10 = a9 + a10;
       	a11 = a10 + a11;
       	a12 = a11 + a12;
       	a13 = a12 + a13;
       	a14 = a13 + a14;
       	a15 = a14 + a15;
       	a16 = a15 + a16;
       	a17 = a16 + a17;
       	a0 = a17 + a0;
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
}

__kernel void Integer_addition_19(__global int* dataArray, int iter)
{
    int a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18;
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
        a10 = a9 + a10;
       	a11 = a10 + a11;
       	a12 = a11 + a12;
       	a13 = a12 + a13;
       	a14 = a13 + a14;
       	a15 = a14 + a15;
       	a16 = a15 + a16;
       	a17 = a16 + a17;
       	a18 = a17 + a18;
       	a0 = a18 + a0;
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
}

__kernel void Integer_addition_20(__global int* dataArray, int iter)
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
        a1 = a0 + addend;
        a2 = a1 + a2;
        a3 = a2 + a3;
        a4 = a3 + a4;
        a5 = a4 + a5;
        a6 = a5 + a6;
        a7 = a6 + a7;
        a8 = a7 + a8;
        a9 = a8 + a9;
        a10 = a9 + a10;
       	a11 = a10 + a11;
       	a12 = a11 + a12;
       	a13 = a12 + a13;
       	a14 = a13 + a14;
       	a15 = a14 + a15;
       	a16 = a15 + a16;
       	a17 = a16 + a17;
       	a18 = a17 + a18;
       	a19 = a18 + a19;
       	a0 = a19 + a0;
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
