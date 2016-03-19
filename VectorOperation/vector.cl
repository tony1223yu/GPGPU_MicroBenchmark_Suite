__kernel void Vector_int1_1(__global int *vectorA, __global int *vectorB, __global int *output, int dataSize)
{
    int idx = 0;

    for (idx ; idx < dataSize ; idx ++)
        output[idx] = vectorA[idx] + vectorB[idx];
}

__kernel void Vector_float1_1(__global float *vectorA, __global float *vectorB, __global float *output, int dataSize)
{
    int idx = 0;

    for (idx ; idx < dataSize ; idx ++)
        output[idx] = vectorA[idx] + vectorB[idx];
}

__kernel void Vector_double1_1(__global double *vectorA, __global double *vectorB, __global double *output, int dataSize)
{
    int idx = 0;

    for (idx ; idx < dataSize ; idx ++)
        output[idx] = vectorA[idx] + vectorB[idx];
}

__kernel void Vector_int2_1(__global int2 *vectorA, __global int2 *vectorB, __global int2 *output, int dataSize)
{
    int idx = 0;

    for (idx ; idx < dataSize ; idx ++)
        output[idx] = vectorA[idx] + vectorB[idx];
}

__kernel void Vector_float2_1(__global float2 *vectorA, __global float2 *vectorB, __global float2 *output, int dataSize)
{
    int idx = 0;

    for (idx ; idx < dataSize ; idx ++)
        output[idx] = vectorA[idx] + vectorB[idx];
}

__kernel void Vector_double2_1(__global double2 *vectorA, __global double2 *vectorB, __global double2 *output, int dataSize)
{
    int idx = 0;

    for (idx ; idx < dataSize ; idx ++)
        output[idx] = vectorA[idx] + vectorB[idx];
}

__kernel void Vector_int2_2(__global int *vectorA, __global int *vectorB, __global int *output, int dataSize)
{
    int idx1, idx2;
    int2 tmp;
    for (idx1 = 0 ; idx1 < dataSize ; idx1 += 2)
    {
        idx2 = idx1 + 1;
        tmp = (int2){vectorA[idx1], vectorA[idx2]} + (int2){vectorB[idx1], vectorB[idx2]};
        output[idx1] = tmp.x;
        output[idx2] = tmp.y;
    }
}

__kernel void Vector_float2_2(__global float *vectorA, __global float *vectorB, __global float *output, int dataSize)
{
    int idx1, idx2;
    float2 tmp;
    for (idx1 = 0 ; idx1 < dataSize ; idx1 += 2)
    {
        idx2 = idx1 + 1;
        tmp = (float2){vectorA[idx1], vectorA[idx2]} + (float2){vectorB[idx1], vectorB[idx2]};
        output[idx1] = tmp.x;
        output[idx2] = tmp.y;
    }
}

__kernel void Vector_double2_2(__global double *vectorA, __global double *vectorB, __global double *output, int dataSize)
{
    int idx1, idx2;
    double2 tmp;
    for (idx1 = 0 ; idx1 < dataSize ; idx1 += 2)
    {
        idx2 = idx1 + 1;
        tmp = (double2){vectorA[idx1], vectorA[idx2]} + (double2){vectorB[idx1], vectorB[idx2]};
        output[idx1] = tmp.x;
        output[idx2] = tmp.y;
    } 
}

__kernel void Vector_int4_1(__global int4 *vectorA, __global int4 *vectorB, __global int4 *output, int dataSize)
{
    int idx = 0;

    for (idx ; idx < dataSize ; idx ++)
        output[idx] = vectorA[idx] + vectorB[idx];
}

__kernel void Vector_float4_1(__global float4 *vectorA, __global float4 *vectorB, __global float4 *output, int dataSize)
{
    int idx = 0;

    for (idx ; idx < dataSize ; idx ++)
        output[idx] = vectorA[idx] + vectorB[idx];
}

__kernel void Vector_double4_1(__global double4 *vectorA, __global double4 *vectorB, __global double4 *output, int dataSize)
{
    int idx = 0;

    for (idx ; idx < dataSize ; idx ++)
        output[idx] = vectorA[idx] + vectorB[idx];
}

__kernel void Vector_int4_2(__global int *vectorA, __global int *vectorB, __global int *output, int dataSize)
{
    int idx1, idx2, idx3, idx4;
    int4 tmp;
    for (idx1 = 0 ; idx1 < dataSize ; idx1 += 4)
    {
        tmp = (int4){vectorA[idx1], vectorA[idx2], vectorA[idx3], vectorA[idx4]} + (int4){vectorB[idx1], vectorB[idx2], vectorB[idx3], vectorB[idx4]};
        output[idx1] = tmp.x;
        output[idx2] = tmp.y;
        output[idx3] = tmp.z;
        output[idx4] = tmp.w;
    }
}

__kernel void Vector_float4_2(__global float *vectorA, __global float *vectorB, __global float *output, int dataSize)
{
    int idx1, idx2, idx3, idx4;
    float4 tmp;
    for (idx1 = 0 ; idx1 < dataSize ; idx1 += 4)
    {
        tmp = (float4){vectorA[idx1], vectorA[idx2], vectorA[idx3], vectorA[idx4]} + (float4){vectorB[idx1], vectorB[idx2], vectorB[idx3], vectorB[idx4]};
        output[idx1] = tmp.x;
        output[idx2] = tmp.y;
        output[idx3] = tmp.z;
        output[idx4] = tmp.w;
    }
}

__kernel void Vector_double4_2(__global double *vectorA, __global double *vectorB, __global double *output, int dataSize)
{
    int idx1, idx2, idx3, idx4;
    double4 tmp;
    for (idx1 = 0 ; idx1 < dataSize ; idx1 += 4)
    {
        tmp = (double4){vectorA[idx1], vectorA[idx2], vectorA[idx3], vectorA[idx4]} + (double4){vectorB[idx1], vectorB[idx2], vectorB[idx3], vectorB[idx4]};
        output[idx1] = tmp.x;
        output[idx2] = tmp.y;
        output[idx3] = tmp.z;
        output[idx4] = tmp.w;
    }
}
