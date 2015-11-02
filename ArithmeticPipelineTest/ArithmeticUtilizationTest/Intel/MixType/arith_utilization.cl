__kernel void IA2_10_FA_5(__global int2* intArray, __global float* floatArray, __global double* doubleArray, long iteration, int interval)
{
    int offset = get_global_id(0) * interval;
	__global int2* curIntArray = intArray + offset;
	__global float* curFloatArray = floatArray + offset;
	
    int2 i0, i1, i2, i3, i4, i5, i6, i7, i8, i9;
    float f0, f1, f2, f3, f4;
    int2 iAddend;
    float fAddend;
    i0 = curIntArray[0];
    i1 = curIntArray[1];
    i2 = curIntArray[2];
    i3 = curIntArray[3];
    i4 = curIntArray[4];
    i5 = curIntArray[5];
    i6 = curIntArray[6];
    i7 = curIntArray[7];
    i8 = curIntArray[8];
    i9 = curIntArray[9];
    f0 = curFloatArray[0];
    f1 = curFloatArray[1];
    f2 = curFloatArray[2];
    f3 = curFloatArray[3];
    f4 = curFloatArray[4];
    iAddend = i0;
    fAddend = f0;
    while (iteration -- > 1)
    {
        f0 = f0 + fAddend;
        i1 = i0 + iAddend;
        i2 = i1 + iAddend;
        f1 = f1 + fAddend;
        i3 = i2 + iAddend;
        i4 = i3 + iAddend;
        f2 = f2 + fAddend;
        i5 = i4 + iAddend;
        i6 = i5 + iAddend;
        f3 = f3 + fAddend;
        i7 = i6 + iAddend;
        i8 = i7 + iAddend;
        f4 = f4 + fAddend;
        i9 = i8 + iAddend;
        i0 = i9 + iAddend;
        iAddend = iAddend + i0;
        fAddend = fAddend * -0.9999F;
        f0 = f0 + fAddend;
        i1 = i0 + iAddend;
        i2 = i1 + iAddend;
        f1 = f1 + fAddend;
        i3 = i2 + iAddend;
        i4 = i3 + iAddend;
        f2 = f2 + fAddend;
        i5 = i4 + iAddend;
        i6 = i5 + iAddend;
        f3 = f3 + fAddend;
        i7 = i6 + iAddend;
        i8 = i7 + iAddend;
        f4 = f4 + fAddend;
        i9 = i8 + iAddend;
        i0 = i9 + iAddend;
        iAddend = iAddend + i0;
        fAddend = fAddend * -0.9999F;
        f0 = f0 + fAddend;
        i1 = i0 + iAddend;
        i2 = i1 + iAddend;
        f1 = f1 + fAddend;
        i3 = i2 + iAddend;
        i4 = i3 + iAddend;
        f2 = f2 + fAddend;
        i5 = i4 + iAddend;
        i6 = i5 + iAddend;
        f3 = f3 + fAddend;
        i7 = i6 + iAddend;
        i8 = i7 + iAddend;
        f4 = f4 + fAddend;
        i9 = i8 + iAddend;
        i0 = i9 + iAddend;
        iAddend = iAddend + i0;
        fAddend = fAddend * -0.9999F;
        f0 = f0 + fAddend;
        i1 = i0 + iAddend;
        i2 = i1 + iAddend;
        f1 = f1 + fAddend;
        i3 = i2 + iAddend;
        i4 = i3 + iAddend;
        f2 = f2 + fAddend;
        i5 = i4 + iAddend;
        i6 = i5 + iAddend;
        f3 = f3 + fAddend;
        i7 = i6 + iAddend;
        i8 = i7 + iAddend;
        f4 = f4 + fAddend;
        i9 = i8 + iAddend;
        i0 = i9 + iAddend;
        iAddend = iAddend + i0;
        fAddend = fAddend * -0.9999F;
        f0 = f0 + fAddend;
        i1 = i0 + iAddend;
        i2 = i1 + iAddend;
        f1 = f1 + fAddend;
        i3 = i2 + iAddend;
        i4 = i3 + iAddend;
        f2 = f2 + fAddend;
        i5 = i4 + iAddend;
        i6 = i5 + iAddend;
        f3 = f3 + fAddend;
        i7 = i6 + iAddend;
        i8 = i7 + iAddend;
        f4 = f4 + fAddend;
        i9 = i8 + iAddend;
        i0 = i9 + iAddend;
        iAddend = iAddend + i0;
        fAddend = fAddend * -0.9999F;
        f0 = f0 + fAddend;
        i1 = i0 + iAddend;
        i2 = i1 + iAddend;
        f1 = f1 + fAddend;
        i3 = i2 + iAddend;
        i4 = i3 + iAddend;
        f2 = f2 + fAddend;
        i5 = i4 + iAddend;
        i6 = i5 + iAddend;
        f3 = f3 + fAddend;
        i7 = i6 + iAddend;
        i8 = i7 + iAddend;
        f4 = f4 + fAddend;
        i9 = i8 + iAddend;
        i0 = i9 + iAddend;
        iAddend = iAddend + i0;
        fAddend = fAddend * -0.9999F;
        f0 = f0 + fAddend;
        i1 = i0 + iAddend;
        i2 = i1 + iAddend;
        f1 = f1 + fAddend;
        i3 = i2 + iAddend;
        i4 = i3 + iAddend;
        f2 = f2 + fAddend;
        i5 = i4 + iAddend;
        i6 = i5 + iAddend;
        f3 = f3 + fAddend;
        i7 = i6 + iAddend;
        i8 = i7 + iAddend;
        f4 = f4 + fAddend;
        i9 = i8 + iAddend;
        i0 = i9 + iAddend;
        iAddend = iAddend + i0;
        fAddend = fAddend * -0.9999F;
    }
    curIntArray[0] = i0;
    curIntArray[1] = i1;
    curIntArray[2] = i2;
    curIntArray[3] = i3;
    curIntArray[4] = i4;
    curIntArray[5] = i5;
    curIntArray[6] = i6;
    curIntArray[7] = i7;
    curIntArray[8] = i8;
    curIntArray[9] = i9;
    curFloatArray[0] = f0;
    curFloatArray[1] = f1;
    curFloatArray[2] = f2;
    curFloatArray[3] = f3;
    curFloatArray[4] = f4;
}

__kernel void IA_10_FA2_5(__global int* intArray, __global float2* floatArray, __global double* doubleArray, long iteration, int interval)
{
    int offset = get_global_id(0) * interval;
	__global int* curIntArray = intArray + offset;
	__global float2* curFloatArray = floatArray + offset;
	
    int i0, i1, i2, i3, i4, i5, i6, i7, i8, i9;
    float2 f0, f1, f2, f3, f4;
    int iAddend;
    float2 fAddend;
    i0 = curIntArray[0];
    i1 = curIntArray[1];
    i2 = curIntArray[2];
    i3 = curIntArray[3];
    i4 = curIntArray[4];
    i5 = curIntArray[5];
    i6 = curIntArray[6];
    i7 = curIntArray[7];
    i8 = curIntArray[8];
    i9 = curIntArray[9];
    f0 = curFloatArray[0];
    f1 = curFloatArray[1];
    f2 = curFloatArray[2];
    f3 = curFloatArray[3];
    f4 = curFloatArray[4];
    iAddend = i0;
    fAddend = f0;
    while (iteration -- > 1)
    {
        f0 = f0 + fAddend;
        i1 = i1 + iAddend;
        i2 = i2 + i1;
        f1 = f1 + fAddend;
        i3 = i3 + i2;
        i4 = i4 + i3;
        f2 = f2 + fAddend;
        i5 = i5 + i4;
        i6 = i6 + i5;
        f3 = f3 + fAddend;
        i7 = i7 + i6;
        i8 = i8 + i7;
        f4 = f4 + fAddend;
        i9 = i9 + i8;
        i0 = i0 + i9;
        iAddend = iAddend + i0;
        fAddend = fAddend * -0.9999F;
        f0 = f0 + fAddend;
        i1 = i1 + iAddend;
        i2 = i2 + i1;
        f1 = f1 + fAddend;
        i3 = i3 + i2;
        i4 = i4 + i3;
        f2 = f2 + fAddend;
        i5 = i5 + i4;
        i6 = i6 + i5;
        f3 = f3 + fAddend;
        i7 = i7 + i6;
        i8 = i8 + i7;
        f4 = f4 + fAddend;
        i9 = i9 + i8;
        i0 = i0 + i9;
        iAddend = iAddend + i0;
        fAddend = fAddend * -0.9999F;
        f0 = f0 + fAddend;
        i1 = i1 + iAddend;
        i2 = i2 + i1;
        f1 = f1 + fAddend;
        i3 = i3 + i2;
        i4 = i4 + i3;
        f2 = f2 + fAddend;
        i5 = i5 + i4;
        i6 = i6 + i5;
        f3 = f3 + fAddend;
        i7 = i7 + i6;
        i8 = i8 + i7;
        f4 = f4 + fAddend;
        i9 = i9 + i8;
        i0 = i0 + i9;
        iAddend = iAddend + i0;
        fAddend = fAddend * -0.9999F;
        f0 = f0 + fAddend;
        i1 = i1 + iAddend;
        i2 = i2 + i1;
        f1 = f1 + fAddend;
        i3 = i3 + i2;
        i4 = i4 + i3;
        f2 = f2 + fAddend;
        i5 = i5 + i4;
        i6 = i6 + i5;
        f3 = f3 + fAddend;
        i7 = i7 + i6;
        i8 = i8 + i7;
        f4 = f4 + fAddend;
        i9 = i9 + i8;
        i0 = i0 + i9;
        iAddend = iAddend + i0;
        fAddend = fAddend * -0.9999F;
        f0 = f0 + fAddend;
        i1 = i1 + iAddend;
        i2 = i2 + i1;
        f1 = f1 + fAddend;
        i3 = i3 + i2;
        i4 = i4 + i3;
        f2 = f2 + fAddend;
        i5 = i5 + i4;
        i6 = i6 + i5;
        f3 = f3 + fAddend;
        i7 = i7 + i6;
        i8 = i8 + i7;
        f4 = f4 + fAddend;
        i9 = i9 + i8;
        i0 = i0 + i9;
        iAddend = iAddend + i0;
        fAddend = fAddend * -0.9999F;
        f0 = f0 + fAddend;
        i1 = i1 + iAddend;
        i2 = i2 + i1;
        f1 = f1 + fAddend;
        i3 = i3 + i2;
        i4 = i4 + i3;
        f2 = f2 + fAddend;
        i5 = i5 + i4;
        i6 = i6 + i5;
        f3 = f3 + fAddend;
        i7 = i7 + i6;
        i8 = i8 + i7;
        f4 = f4 + fAddend;
        i9 = i9 + i8;
        i0 = i0 + i9;
        iAddend = iAddend + i0;
        fAddend = fAddend * -0.9999F;
        f0 = f0 + fAddend;
        i1 = i1 + iAddend;
        i2 = i2 + i1;
        f1 = f1 + fAddend;
        i3 = i3 + i2;
        i4 = i4 + i3;
        f2 = f2 + fAddend;
        i5 = i5 + i4;
        i6 = i6 + i5;
        f3 = f3 + fAddend;
        i7 = i7 + i6;
        i8 = i8 + i7;
        f4 = f4 + fAddend;
        i9 = i9 + i8;
        i0 = i0 + i9;
        iAddend = iAddend + i0;
        fAddend = fAddend * -0.9999F;
    }
    curIntArray[0] = i0;
    curIntArray[1] = i1;
    curIntArray[2] = i2;
    curIntArray[3] = i3;
    curIntArray[4] = i4;
    curIntArray[5] = i5;
    curIntArray[6] = i6;
    curIntArray[7] = i7;
    curIntArray[8] = i8;
    curIntArray[9] = i9;
    curFloatArray[0] = f0;
    curFloatArray[1] = f1;
    curFloatArray[2] = f2;
    curFloatArray[3] = f3;
    curFloatArray[4] = f4;
}

__kernel void IA_10_FA_5_DA_5(__global int* intArray, __global float* floatArray, __global double* doubleArray, long iteration, int interval)
{
    int offset = get_global_id(0) * interval;
	__global int* curIntArray = intArray + offset;
	__global float* curFloatArray = floatArray + offset;
	__global double* curDoubleArray = doubleArray + offset;
	
    int i0, i1, i2, i3, i4, i5, i6, i7, i8, i9;
    float f0, f1, f2, f3, f4;
    double d0, d1, d2, d3, d4;
    int iAddend;
    float fAddend;
    double dAddend;
    i0 = curIntArray[0];
    i1 = curIntArray[1];
    i2 = curIntArray[2];
    i3 = curIntArray[3];
    i4 = curIntArray[4];
    i5 = curIntArray[5];
    i6 = curIntArray[6];
    i7 = curIntArray[7];
    i8 = curIntArray[8];
    i9 = curIntArray[9];
    f0 = curFloatArray[0];
    f1 = curFloatArray[1];
    f2 = curFloatArray[2];
    f3 = curFloatArray[3];
    f4 = curFloatArray[4];
    d0 = curDoubleArray[0];
    d1 = curDoubleArray[1];
    d2 = curDoubleArray[2];
    d3 = curDoubleArray[3];
    d4 = curDoubleArray[4];
    iAddend = i0;
    fAddend = f0;
    dAddend = d0;
    while (iteration -- > 1)
    {
        d1 = d0 + dAddend;
        f0 = f0 + fAddend;
        i1 = i1 + iAddend;
        i2 = i2 + i1;
        d2 = d1 + dAddend;
        f1 = f1 + fAddend;
        i3 = i3 + i2;
        i4 = i4 + i3;
        d3 = d2 + dAddend;
        f2 = f2 + fAddend;
        i5 = i5 + i4;
        i6 = i6 + i5;
        d4 = d3 + dAddend;
        f3 = f3 + fAddend;
        i7 = i7 + i6;
        i8 = i8 + i7;
        d0 = d4 + dAddend;
        f4 = f4 + fAddend;
        i9 = i9 + i8;
        i0 = i0 + i9;
        iAddend = iAddend + i0;
        fAddend = fAddend * -0.9999F;
        dAddend = dAddend * -0.999999;
        d1 = d0 + dAddend;
        f0 = f0 + fAddend;
        i1 = i1 + iAddend;
        i2 = i2 + i1;
        d2 = d1 + dAddend;
        f1 = f1 + fAddend;
        i3 = i3 + i2;
        i4 = i4 + i3;
        d3 = d2 + dAddend;
        f2 = f2 + fAddend;
        i5 = i5 + i4;
        i6 = i6 + i5;
        d4 = d3 + dAddend;
        f3 = f3 + fAddend;
        i7 = i7 + i6;
        i8 = i8 + i7;
        d0 = d4 + dAddend;
        f4 = f4 + fAddend;
        i9 = i9 + i8;
        i0 = i0 + i9;
        iAddend = iAddend + i0;
        fAddend = fAddend * -0.9999F;
        dAddend = dAddend * -0.999999;
        d1 = d0 + dAddend;
        f0 = f0 + fAddend;
        i1 = i1 + iAddend;
        i2 = i2 + i1;
        d2 = d1 + dAddend;
        f1 = f1 + fAddend;
        i3 = i3 + i2;
        i4 = i4 + i3;
        d3 = d2 + dAddend;
        f2 = f2 + fAddend;
        i5 = i5 + i4;
        i6 = i6 + i5;
        d4 = d3 + dAddend;
        f3 = f3 + fAddend;
        i7 = i7 + i6;
        i8 = i8 + i7;
        d0 = d4 + dAddend;
        f4 = f4 + fAddend;
        i9 = i9 + i8;
        i0 = i0 + i9;
        iAddend = iAddend + i0;
        fAddend = fAddend * -0.9999F;
        dAddend = dAddend * -0.999999;
        d1 = d0 + dAddend;
        f0 = f0 + fAddend;
        i1 = i1 + iAddend;
        i2 = i2 + i1;
        d2 = d1 + dAddend;
        f1 = f1 + fAddend;
        i3 = i3 + i2;
        i4 = i4 + i3;
        d3 = d2 + dAddend;
        f2 = f2 + fAddend;
        i5 = i5 + i4;
        i6 = i6 + i5;
        d4 = d3 + dAddend;
        f3 = f3 + fAddend;
        i7 = i7 + i6;
        i8 = i8 + i7;
        d0 = d4 + dAddend;
        f4 = f4 + fAddend;
        i9 = i9 + i8;
        i0 = i0 + i9;
        iAddend = iAddend + i0;
        fAddend = fAddend * -0.9999F;
        dAddend = dAddend * -0.999999;
        d1 = d0 + dAddend;
        f0 = f0 + fAddend;
        i1 = i1 + iAddend;
        i2 = i2 + i1;
        d2 = d1 + dAddend;
        f1 = f1 + fAddend;
        i3 = i3 + i2;
        i4 = i4 + i3;
        d3 = d2 + dAddend;
        f2 = f2 + fAddend;
        i5 = i5 + i4;
        i6 = i6 + i5;
        d4 = d3 + dAddend;
        f3 = f3 + fAddend;
        i7 = i7 + i6;
        i8 = i8 + i7;
        d0 = d4 + dAddend;
        f4 = f4 + fAddend;
        i9 = i9 + i8;
        i0 = i0 + i9;
        iAddend = iAddend + i0;
        fAddend = fAddend * -0.9999F;
        dAddend = dAddend * -0.999999;
    }
    curIntArray[0] = i0;
    curIntArray[1] = i1;
    curIntArray[2] = i2;
    curIntArray[3] = i3;
    curIntArray[4] = i4;
    curIntArray[5] = i5;
    curIntArray[6] = i6;
    curIntArray[7] = i7;
    curIntArray[8] = i8;
    curIntArray[9] = i9;
    curFloatArray[0] = f0;
    curFloatArray[1] = f1;
    curFloatArray[2] = f2;
    curFloatArray[3] = f3;
    curFloatArray[4] = f4;
    curDoubleArray[0] = d0;
    curDoubleArray[1] = d1;
    curDoubleArray[2] = d2;
    curDoubleArray[3] = d3;
    curDoubleArray[4] = d4;
}

__kernel void FA_10_DA2_5(__global int* intArray, __global float* floatArray, __global double2* doubleArray, long iteration, int interval)
{
    int offset = get_global_id(0) * interval;
	__global float* curFloatArray = floatArray + offset;
	__global double2* curDoubleArray = doubleArray + offset;
	
    float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9;
    double2 d0, d1, d2, d3, d4;
    float fAddend;
    double2 dAddend;
    f0 = curFloatArray[0];
    f1 = curFloatArray[1];
    f2 = curFloatArray[2];
    f3 = curFloatArray[3];
    f4 = curFloatArray[4];
    f5 = curFloatArray[5];
    f6 = curFloatArray[6];
    f7 = curFloatArray[7];
    f8 = curFloatArray[8];
    f9 = curFloatArray[9];
    d0 = curDoubleArray[0];
    d1 = curDoubleArray[1];
    d2 = curDoubleArray[2];
    d3 = curDoubleArray[3];
    d4 = curDoubleArray[4];
    fAddend = f0;
    dAddend = d0;
    while (iteration -- > 1)
    {
        d1 = d0 + dAddend;
        f2 = f0 + fAddend;
        f3 = f1 + fAddend;
        d2 = d1 + dAddend;
        f4 = f2 + fAddend;
        f5 = f3 + fAddend;
        d3 = d2 + dAddend;
        f6 = f4 + fAddend;
        f7 = f5 + fAddend;
        d4 = d3 + dAddend;
        f8 = f6 + fAddend;
        f9 = f7 + fAddend;
        d0 = d4 + dAddend;
        f0 = f8 + fAddend;
        f1 = f9 + fAddend;
        fAddend = fAddend * -0.9999F;
        dAddend = dAddend * -0.999999;
        d1 = d0 + dAddend;
        f2 = f0 + fAddend;
        f3 = f1 + fAddend;
        d2 = d1 + dAddend;
        f4 = f2 + fAddend;
        f5 = f3 + fAddend;
        d3 = d2 + dAddend;
        f6 = f4 + fAddend;
        f7 = f5 + fAddend;
        d4 = d3 + dAddend;
        f8 = f6 + fAddend;
        f9 = f7 + fAddend;
        d0 = d4 + dAddend;
        f0 = f8 + fAddend;
        f1 = f9 + fAddend;
        fAddend = fAddend * -0.9999F;
        dAddend = dAddend * -0.999999;
        d1 = d0 + dAddend;
        f2 = f0 + fAddend;
        f3 = f1 + fAddend;
        d2 = d1 + dAddend;
        f4 = f2 + fAddend;
        f5 = f3 + fAddend;
        d3 = d2 + dAddend;
        f6 = f4 + fAddend;
        f7 = f5 + fAddend;
        d4 = d3 + dAddend;
        f8 = f6 + fAddend;
        f9 = f7 + fAddend;
        d0 = d4 + dAddend;
        f0 = f8 + fAddend;
        f1 = f9 + fAddend;
        fAddend = fAddend * -0.9999F;
        dAddend = dAddend * -0.999999;
        d1 = d0 + dAddend;
        f2 = f0 + fAddend;
        f3 = f1 + fAddend;
        d2 = d1 + dAddend;
        f4 = f2 + fAddend;
        f5 = f3 + fAddend;
        d3 = d2 + dAddend;
        f6 = f4 + fAddend;
        f7 = f5 + fAddend;
        d4 = d3 + dAddend;
        f8 = f6 + fAddend;
        f9 = f7 + fAddend;
        d0 = d4 + dAddend;
        f0 = f8 + fAddend;
        f1 = f9 + fAddend;
        fAddend = fAddend * -0.9999F;
        dAddend = dAddend * -0.999999;
        d1 = d0 + dAddend;
        f2 = f0 + fAddend;
        f3 = f1 + fAddend;
        d2 = d1 + dAddend;
        f4 = f2 + fAddend;
        f5 = f3 + fAddend;
        d3 = d2 + dAddend;
        f6 = f4 + fAddend;
        f7 = f5 + fAddend;
        d4 = d3 + dAddend;
        f8 = f6 + fAddend;
        f9 = f7 + fAddend;
        d0 = d4 + dAddend;
        f0 = f8 + fAddend;
        f1 = f9 + fAddend;
        fAddend = fAddend * -0.9999F;
        dAddend = dAddend * -0.999999;
        d1 = d0 + dAddend;
        f2 = f0 + fAddend;
        f3 = f1 + fAddend;
        d2 = d1 + dAddend;
        f4 = f2 + fAddend;
        f5 = f3 + fAddend;
        d3 = d2 + dAddend;
        f6 = f4 + fAddend;
        f7 = f5 + fAddend;
        d4 = d3 + dAddend;
        f8 = f6 + fAddend;
        f9 = f7 + fAddend;
        d0 = d4 + dAddend;
        f0 = f8 + fAddend;
        f1 = f9 + fAddend;
        fAddend = fAddend * -0.9999F;
        dAddend = dAddend * -0.999999;
        d1 = d0 + dAddend;
        f2 = f0 + fAddend;
        f3 = f1 + fAddend;
        d2 = d1 + dAddend;
        f4 = f2 + fAddend;
        f5 = f3 + fAddend;
        d3 = d2 + dAddend;
        f6 = f4 + fAddend;
        f7 = f5 + fAddend;
        d4 = d3 + dAddend;
        f8 = f6 + fAddend;
        f9 = f7 + fAddend;
        d0 = d4 + dAddend;
        f0 = f8 + fAddend;
        f1 = f9 + fAddend;
        fAddend = fAddend * -0.9999F;
        dAddend = dAddend * -0.999999;
    }
    curFloatArray[0] = f0;
    curFloatArray[1] = f1;
    curFloatArray[2] = f2;
    curFloatArray[3] = f3;
    curFloatArray[4] = f4;
    curFloatArray[5] = f5;
    curFloatArray[6] = f6;
    curFloatArray[7] = f7;
    curFloatArray[8] = f8;
    curFloatArray[9] = f9;
    curDoubleArray[0] = d0;
    curDoubleArray[1] = d1;
    curDoubleArray[2] = d2;
    curDoubleArray[3] = d3;
    curDoubleArray[4] = d4;
}

__kernel void IA4_15_FA4_5(__global int4* intArray, __global float4* floatArray, __global double* doubleArray, long iteration, int interval)
{
    int offset = get_global_id(0) * interval;
	__global int4* curIntArray = intArray + offset;
	__global float4* curFloatArray = floatArray + offset;
	
    int4 i0, i1, i2, i3, i4;
    float4 f0, f1, f2, f3, f4;
    int4 iAddend;
    float4 fAddend;
    i0 = curIntArray[0];
    i1 = curIntArray[1];
    i2 = curIntArray[2];
    i3 = curIntArray[3];
    i4 = curIntArray[4];
    f0 = curFloatArray[0];
    f1 = curFloatArray[1];
    f2 = curFloatArray[2];
    f3 = curFloatArray[3];
    f4 = curFloatArray[4];
    fAddend = f0;
    iAddend = i0;
    while (iteration -- > 1)
    {
    	i0 = i0 + iAddend;
    	i1 = i1 + iAddend;
    	i2 = i2 + iAddend;
    	i3 = i3 + iAddend;
    	i4 = i4 + iAddend;
    	iAddend = iAddend + i0;
        f1 = f0 + fAddend;
        f2 = f1 + fAddend;
    	i0 = i0 + iAddend;
    	i1 = i1 + iAddend;
    	i2 = i2 + iAddend;
    	i3 = i3 + iAddend;
    	i4 = i4 + iAddend;
    	iAddend = iAddend + i1;
        f3 = f2 + fAddend;
        f4 = f3 + fAddend;
    	i0 = i0 + iAddend;
    	i1 = i1 + iAddend;
    	i2 = i2 + iAddend;
    	i3 = i3 + iAddend;
    	i4 = i4 + iAddend;
    	iAddend = iAddend + i2;
        f0 = f4 + fAddend;
        fAddend = fAddend * -0.9999F;
    	i0 = i0 + iAddend;
    	i1 = i1 + iAddend;
    	i2 = i2 + iAddend;
    	i3 = i3 + iAddend;
    	i4 = i4 + iAddend;
    	iAddend = iAddend + i3;
        f1 = f0 + fAddend;
        f2 = f1 + fAddend;
    	i0 = i0 + iAddend;
    	i1 = i1 + iAddend;
    	i2 = i2 + iAddend;
    	i3 = i3 + iAddend;
    	i4 = i4 + iAddend;
    	iAddend = iAddend + i4;
        f3 = f2 + fAddend;
        f4 = f3 + fAddend;
    	i0 = i0 + iAddend;
    	i1 = i1 + iAddend;
    	i2 = i2 + iAddend;
    	i3 = i3 + iAddend;
    	i4 = i4 + iAddend;
    	iAddend = iAddend + i0;
        f0 = f4 + fAddend;
        fAddend = fAddend * -0.9999F;
    	i0 = i0 + iAddend;
    	i1 = i1 + iAddend;
    	i2 = i2 + iAddend;
    	i3 = i3 + iAddend;
    	i4 = i4 + iAddend;
    	iAddend = iAddend + i1;
        f1 = f0 + fAddend;
        f2 = f1 + fAddend;
    	i0 = i0 + iAddend;
    	i1 = i1 + iAddend;
    	i2 = i2 + iAddend;
    	i3 = i3 + iAddend;
    	i4 = i4 + iAddend;
    	iAddend = iAddend + i2;
        f3 = f2 + fAddend;
        f4 = f3 + fAddend;
    	i0 = i0 + iAddend;
    	i1 = i1 + iAddend;
    	i2 = i2 + iAddend;
    	i3 = i3 + iAddend;
    	i4 = i4 + iAddend;
    	iAddend = iAddend + i3;
        f0 = f4 + fAddend;
        fAddend = fAddend * -0.9999F;
    	i0 = i0 + iAddend;
    	i1 = i1 + iAddend;
    	i2 = i2 + iAddend;
    	i3 = i3 + iAddend;
    	i4 = i4 + iAddend;
    	iAddend = iAddend + i4;
        f1 = f0 + fAddend;
        f2 = f1 + fAddend;
    	i0 = i0 + iAddend;
    	i1 = i1 + iAddend;
    	i2 = i2 + iAddend;
    	i3 = i3 + iAddend;
    	i4 = i4 + iAddend;
    	iAddend = iAddend + i0;
        f3 = f2 + fAddend;
        f4 = f3 + fAddend;
    	i0 = i0 + iAddend;
    	i1 = i1 + iAddend;
    	i2 = i2 + iAddend;
    	i3 = i3 + iAddend;
    	i4 = i4 + iAddend;
    	iAddend = iAddend + i1;
        f0 = f4 + fAddend;
        fAddend = fAddend * -0.9999F;
    	i0 = i0 + iAddend;
    	i1 = i1 + iAddend;
    	i2 = i2 + iAddend;
    	i3 = i3 + iAddend;
    	i4 = i4 + iAddend;
    	iAddend = iAddend + i2;
        f1 = f0 + fAddend;
        f2 = f1 + fAddend;
    	i0 = i0 + iAddend;
    	i1 = i1 + iAddend;
    	i2 = i2 + iAddend;
    	i3 = i3 + iAddend;
    	i4 = i4 + iAddend;
    	iAddend = iAddend + i3;
        f3 = f2 + fAddend;
        f4 = f3 + fAddend;
    	i0 = i0 + iAddend;
    	i1 = i1 + iAddend;
    	i2 = i2 + iAddend;
    	i3 = i3 + iAddend;
    	i4 = i4 + iAddend;
    	iAddend = iAddend + i4;
        f0 = f4 + fAddend;
        fAddend = fAddend * -0.9999F;
    }
    curIntArray[0] = i0;
    curIntArray[1] = i1;
    curIntArray[2] = i2;
    curIntArray[3] = i3;
    curIntArray[4] = i4;
    curFloatArray[0] = f0;
    curFloatArray[1] = f1;
    curFloatArray[2] = f2;
    curFloatArray[3] = f3;
    curFloatArray[4] = f4;
}

__kernel void IA4_5_DA_5(__global int4* intArray, __global float* floatArray, __global double* doubleArray, long iteration, int interval)
{
    int offset = get_global_id(0) * interval;
	__global int4* curIntArray = intArray + offset;
	__global double* curDoubleArray = doubleArray + offset;
	
    int4 i0, i1, i2, i3, i4;
    double d0, d1, d2, d3, d4;
    int4 iAddend;
    double dAddend;
    i0 = curIntArray[0];
    i1 = curIntArray[1];
    i2 = curIntArray[2];
    i3 = curIntArray[3];
    i4 = curIntArray[4];
    d0 = curDoubleArray[0];
    d1 = curDoubleArray[1];
    d2 = curDoubleArray[2];
    d3 = curDoubleArray[3];
    d4 = curDoubleArray[4];
    iAddend = i0;
    dAddend = d0;
    while (iteration -- > 1)
    {
    	i0 = i0 + iAddend;
        d0 = d0 + dAddend;
    	i1 = i1 + iAddend;
        d1 = d1 + dAddend;
    	i2 = i2 + iAddend;
        d2 = d2 + dAddend;
    	i3 = i3 + iAddend;
        d3 = d3 + dAddend;
    	i4 = i4 + iAddend;
        d4 = d4 + dAddend;
        iAddend = iAddend + i0;
        dAddend = dAddend * -0.999999;
    	i0 = i0 + iAddend;
        d0 = d0 + dAddend;
    	i1 = i1 + iAddend;
        d1 = d1 + dAddend;
    	i2 = i2 + iAddend;
        d2 = d2 + dAddend;
    	i3 = i3 + iAddend;
        d3 = d3 + dAddend;
    	i4 = i4 + iAddend;
        d4 = d4 + dAddend;
        iAddend = iAddend + i0;
        dAddend = dAddend * -0.999999;
    	i0 = i0 + iAddend;
        d0 = d0 + dAddend;
    	i1 = i1 + iAddend;
        d1 = d1 + dAddend;
    	i2 = i2 + iAddend;
        d2 = d2 + dAddend;
    	i3 = i3 + iAddend;
        d3 = d3 + dAddend;
    	i4 = i4 + iAddend;
        d4 = d4 + dAddend;
        iAddend = iAddend + i0;
        dAddend = dAddend * -0.999999;
    	i0 = i0 + iAddend;
        d0 = d0 + dAddend;
    	i1 = i1 + iAddend;
        d1 = d1 + dAddend;
    	i2 = i2 + iAddend;
        d2 = d2 + dAddend;
    	i3 = i3 + iAddend;
        d3 = d3 + dAddend;
    	i4 = i4 + iAddend;
        d4 = d4 + dAddend;
        iAddend = iAddend + i0;
        dAddend = dAddend * -0.999999;
    	i0 = i0 + iAddend;
        d0 = d0 + dAddend;
    	i1 = i1 + iAddend;
        d1 = d1 + dAddend;
    	i2 = i2 + iAddend;
        d2 = d2 + dAddend;
    	i3 = i3 + iAddend;
        d3 = d3 + dAddend;
    	i4 = i4 + iAddend;
        d4 = d4 + dAddend;
        iAddend = iAddend + i0;
        dAddend = dAddend * -0.999999;
    	i0 = i0 + iAddend;
        d0 = d0 + dAddend;
    	i1 = i1 + iAddend;
        d1 = d1 + dAddend;
    	i2 = i2 + iAddend;
        d2 = d2 + dAddend;
    	i3 = i3 + iAddend;
        d3 = d3 + dAddend;
    	i4 = i4 + iAddend;
        d4 = d4 + dAddend;
        iAddend = iAddend + i0;
        dAddend = dAddend * -0.999999;
    	i0 = i0 + iAddend;
        d0 = d0 + dAddend;
    	i1 = i1 + iAddend;
        d1 = d1 + dAddend;
    	i2 = i2 + iAddend;
        d2 = d2 + dAddend;
    	i3 = i3 + iAddend;
        d3 = d3 + dAddend;
    	i4 = i4 + iAddend;
        d4 = d4 + dAddend;
        iAddend = iAddend + i0;
        dAddend = dAddend * -0.999999;
    	i0 = i0 + iAddend;
        d0 = d0 + dAddend;
    	i1 = i1 + iAddend;
        d1 = d1 + dAddend;
    	i2 = i2 + iAddend;
        d2 = d2 + dAddend;
    	i3 = i3 + iAddend;
        d3 = d3 + dAddend;
    	i4 = i4 + iAddend;
        d4 = d4 + dAddend;
        iAddend = iAddend + i0;
        dAddend = dAddend * -0.999999;
    	i0 = i0 + iAddend;
        d0 = d0 + dAddend;
    	i1 = i1 + iAddend;
        d1 = d1 + dAddend;
    	i2 = i2 + iAddend;
        d2 = d2 + dAddend;
    	i3 = i3 + iAddend;
        d3 = d3 + dAddend;
    	i4 = i4 + iAddend;
        d4 = d4 + dAddend;
        iAddend = iAddend + i0;
        dAddend = dAddend * -0.999999;
    	i0 = i0 + iAddend;
        d0 = d0 + dAddend;
    	i1 = i1 + iAddend;
        d1 = d1 + dAddend;
    	i2 = i2 + iAddend;
        d2 = d2 + dAddend;
    	i3 = i3 + iAddend;
        d3 = d3 + dAddend;
    	i4 = i4 + iAddend;
        d4 = d4 + dAddend;
        iAddend = iAddend + i0;
        dAddend = dAddend * -0.999999;
    }
    curIntArray[0] = i0;
    curIntArray[1] = i1;
    curIntArray[2] = i2;
    curIntArray[3] = i3;
    curIntArray[4] = i4;
    curDoubleArray[0] = d0;
    curDoubleArray[1] = d1;
    curDoubleArray[2] = d2;
    curDoubleArray[3] = d3;
    curDoubleArray[4] = d4;
}

__kernel void IA_25_DA_5(__global int* intArray, __global float* floatArray, __global double* doubleArray, long iteration, int interval)
{
    int offset = get_global_id(0) * interval;
	__global int* curIntArray = intArray + offset;
	__global double* curDoubleArray = doubleArray + offset;
	
    int i0, i1, i2, i3, i4;
    double d0, d1, d2, d3, d4;
    int iAddend;
    double dAddend;
    i0 = curIntArray[0];
    i1 = curIntArray[1];
    i2 = curIntArray[2];
    i3 = curIntArray[3];
    i4 = curIntArray[4];
    d0 = curDoubleArray[0];
    d1 = curDoubleArray[1];
    d2 = curDoubleArray[2];
    d3 = curDoubleArray[3];
    d4 = curDoubleArray[4];
    iAddend = i0;
    dAddend = d0;
    while (iteration -- > 1)
    {
    	i0 = i0 + iAddend;
    	i1 = i1 + iAddend;
    	i2 = i2 + iAddend;
    	i3 = i3 + iAddend;
    	i4 = i4 + iAddend;
    	iAddend = iAddend + i0;
        d1 = d0 + dAddend;
        i0 = i0 + iAddend;
    	i1 = i1 + iAddend;
    	i2 = i2 + iAddend;
    	i3 = i3 + iAddend;
    	i4 = i4 + iAddend;
    	iAddend = iAddend + i1;
        d2 = d1 + dAddend;
        i0 = i0 + iAddend;
    	i1 = i1 + iAddend;
    	i2 = i2 + iAddend;
    	i3 = i3 + iAddend;
    	i4 = i4 + iAddend;
    	iAddend = iAddend + i2;
        d3 = d2 + dAddend;
        i0 = i0 + iAddend;
    	i1 = i1 + iAddend;
    	i2 = i2 + iAddend;
    	i3 = i3 + iAddend;
    	i4 = i4 + iAddend;
    	iAddend = iAddend + i3;
        d4 = d3 + dAddend;
        i0 = i0 + iAddend;
    	i1 = i1 + iAddend;
    	i2 = i2 + iAddend;
    	i3 = i3 + iAddend;
    	i4 = i4 + iAddend;
    	iAddend = iAddend + i4;
        d0 = d4 + dAddend;
        dAddend = dAddend * -0.999999;
    	i0 = i0 + iAddend;
    	i1 = i1 + iAddend;
    	i2 = i2 + iAddend;
    	i3 = i3 + iAddend;
    	i4 = i4 + iAddend;
    	iAddend = iAddend + i0;
        d1 = d0 + dAddend;
        i0 = i0 + iAddend;
    	i1 = i1 + iAddend;
    	i2 = i2 + iAddend;
    	i3 = i3 + iAddend;
    	i4 = i4 + iAddend;
    	iAddend = iAddend + i1;
        d2 = d1 + dAddend;
        i0 = i0 + iAddend;
    	i1 = i1 + iAddend;
    	i2 = i2 + iAddend;
    	i3 = i3 + iAddend;
    	i4 = i4 + iAddend;
    	iAddend = iAddend + i2;
        d3 = d2 + dAddend;
        i0 = i0 + iAddend;
    	i1 = i1 + iAddend;
    	i2 = i2 + iAddend;
    	i3 = i3 + iAddend;
    	i4 = i4 + iAddend;
    	iAddend = iAddend + i3;
        d4 = d3 + dAddend;
        i0 = i0 + iAddend;
    	i1 = i1 + iAddend;
    	i2 = i2 + iAddend;
    	i3 = i3 + iAddend;
    	i4 = i4 + iAddend;
    	iAddend = iAddend + i4;
        d0 = d4 + dAddend;
        dAddend = dAddend * -0.999999;
    	i0 = i0 + iAddend;
    	i1 = i1 + iAddend;
    	i2 = i2 + iAddend;
    	i3 = i3 + iAddend;
    	i4 = i4 + iAddend;
    	iAddend = iAddend + i0;
        d1 = d0 + dAddend;
        i0 = i0 + iAddend;
    	i1 = i1 + iAddend;
    	i2 = i2 + iAddend;
    	i3 = i3 + iAddend;
    	i4 = i4 + iAddend;
    	iAddend = iAddend + i1;
        d2 = d1 + dAddend;
        i0 = i0 + iAddend;
    	i1 = i1 + iAddend;
    	i2 = i2 + iAddend;
    	i3 = i3 + iAddend;
    	i4 = i4 + iAddend;
    	iAddend = iAddend + i2;
        d3 = d2 + dAddend;
        i0 = i0 + iAddend;
    	i1 = i1 + iAddend;
    	i2 = i2 + iAddend;
    	i3 = i3 + iAddend;
    	i4 = i4 + iAddend;
    	iAddend = iAddend + i3;
        d4 = d3 + dAddend;
        i0 = i0 + iAddend;
    	i1 = i1 + iAddend;
    	i2 = i2 + iAddend;
    	i3 = i3 + iAddend;
    	i4 = i4 + iAddend;
    	iAddend = iAddend + i4;
        d0 = d4 + dAddend;
        dAddend = dAddend * -0.999999;
    }
    curIntArray[0] = i0;
    curIntArray[1] = i1;
    curIntArray[2] = i2;
    curIntArray[3] = i3;
    curIntArray[4] = i4;
    curDoubleArray[0] = d0;
    curDoubleArray[1] = d1;
    curDoubleArray[2] = d2;
    curDoubleArray[3] = d3;
    curDoubleArray[4] = d4;
}