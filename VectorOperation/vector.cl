__kernel void Vector_int1(__global int *vectorA, __global int *vectorB, __global int *output, int dataSize)
{
    int idx = 0;

    for (idx ; idx < dataSize ; idx ++)
        output[idx] = vectorA[idx] * vectorB[idx];
}

__kernel void Vector_float1(__global float *vectorA, __global float *vectorB, __global float *output, int dataSize)
{
    int idx = 0;

    for (idx ; idx < dataSize ; idx ++)
        output[idx] = vectorA[idx] * vectorB[idx];
}

__kernel void Vector_double1(__global double *vectorA, __global double *vectorB, __global double *output, int dataSize)
{
    int idx = 0;

    for (idx ; idx < dataSize ; idx ++)
        output[idx] = vectorA[idx] * vectorB[idx];
}

__kernel void Vector_int2(__global int2 *vectorA, __global int2 *vectorB, __global int2 *output, int dataSize)
{
    int idx = 0;

    for (idx ; idx < dataSize ; idx ++)
        output[idx] = vectorA[idx] * vectorB[idx];
}

__kernel void Vector_float2(__global float2 *vectorA, __global float2 *vectorB, __global float2 *output, int dataSize)
{
    int idx = 0;

    for (idx ; idx < dataSize ; idx ++)
        output[idx] = vectorA[idx] * vectorB[idx];
}

__kernel void Vector_double2(__global double2 *vectorA, __global double2 *vectorB, __global double2 *output, int dataSize)
{
    int idx = 0;

    for (idx ; idx < dataSize ; idx ++)
        output[idx] = vectorA[idx] * vectorB[idx];
}

__kernel void Vector_int4(__global int4 *vectorA, __global int4 *vectorB, __global int4 *output, int dataSize)
{
    int idx = 0;

    for (idx ; idx < dataSize ; idx ++)
        output[idx] = vectorA[idx] * vectorB[idx];
}

__kernel void Vector_float4(__global float4 *vectorA, __global float4 *vectorB, __global float4 *output, int dataSize)
{
    int idx = 0;

    for (idx ; idx < dataSize ; idx ++)
        output[idx] = vectorA[idx] * vectorB[idx];
}

__kernel void Vector_double4(__global double4 *vectorA, __global double4 *vectorB, __global double4 *output, int dataSize)
{
    int idx = 0;

    for (idx ; idx < dataSize ; idx ++)
        output[idx] = vectorA[idx] * vectorB[idx];
}
