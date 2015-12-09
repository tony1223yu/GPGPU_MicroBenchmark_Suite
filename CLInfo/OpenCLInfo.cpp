#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <iostream>

#ifdef __APPLE__
#include <OpenCL/cl.h>
#else
#include <CL/cl.h>
#endif

using namespace std;

template <typename T>
void ShowCLDeviceNumberInfo(cl_device_id device, cl_device_info param, const char *name)
{
    T *result;
    size_t num;
    cl_int err;

    err = clGetDeviceInfo(device, param, 0, NULL, &num);
    if (err < 0)
    {
        printf("Couldn't get platform info : %d\n", err);
        exit(1);
    }

    result = new T[ num/sizeof(T) ];

    err = clGetDeviceInfo(device, param, num, result, NULL);
    printf("\t%s: ", name);

    for (int i = 0 ; i < num / sizeof(T) ; i ++)
        printf("%llu ", (unsigned long long int)(result[i]));

    printf("\n");
    delete [] result;
}

void ShowCLDeviceStringInfo(cl_device_id device, cl_device_info param, const char *name)
{
    char *result;
    size_t len;

    cl_int err;

    err = clGetDeviceInfo(device, param, 0, NULL, &len);
    if (err < 0)
    {
        printf("Couldn't get platform info : %d\n", err);
        exit(1);
    }

    result = new char [len];

    clGetDeviceInfo(device, param, len, result, NULL);
    printf("\t%s : %s\n", name, result);

    delete [] result;

}

void ShowCLPlatformInfo(cl_platform_id platform, cl_platform_info param, const char *name)
{
    char *result;
    size_t len;

    cl_int err;

    err = clGetPlatformInfo(platform, param, 0, NULL, &len);
    if (err < 0)
    {
        printf("Couldn't get platform info : %d\n", err);
        exit(1);
    }

    result = new char [len];

    clGetPlatformInfo(platform, param, len, result, NULL);
    printf("%s : %s\n", name, result);

    delete [] result;
}

void GetCLDeviceInfo(cl_device_id device, int index)
{
    cl_device_type deviceType;

    printf("\n\tDevice %d\n", index);

    clGetDeviceInfo(device, CL_DEVICE_TYPE, sizeof(deviceType), &deviceType, NULL);
    printf("\tType : ");
    if (deviceType & CL_DEVICE_TYPE_DEFAULT)
        printf("Default ");
    if (deviceType & CL_DEVICE_TYPE_CPU)
        printf("CPU ");
    if (deviceType & CL_DEVICE_TYPE_GPU)
        printf("GPU ");
    if (deviceType & CL_DEVICE_TYPE_ACCELERATOR)
        printf("Accelerator ");
    printf("\n");

    ShowCLDeviceStringInfo(device, CL_DEVICE_NAME, "Name");
    ShowCLDeviceNumberInfo <cl_uint> (device, CL_DEVICE_MAX_WORK_ITEM_DIMENSIONS, "Work item dim");
    ShowCLDeviceNumberInfo <size_t> (device, CL_DEVICE_MAX_WORK_ITEM_SIZES, "Work item size");
    ShowCLDeviceNumberInfo <size_t> (device, CL_DEVICE_MAX_WORK_GROUP_SIZE, "Work group size");
    ShowCLDeviceStringInfo(device, CL_DEVICE_VENDOR, "Vendor");
    ShowCLDeviceStringInfo(device, CL_DEVICE_VERSION, "Device Version");
    ShowCLDeviceStringInfo(device, CL_DRIVER_VERSION, "Driver Version");
    ShowCLDeviceStringInfo(device, CL_DEVICE_EXTENSIONS, "Extensions");

}

void GetCLPlatformInfo(cl_platform_id platform, int index)
{
    cl_device_id *devices;
    cl_uint deviceNum;
    cl_int err;

    printf("\n================= Platform %d ==========================\n", index);

    ShowCLPlatformInfo(platform, CL_PLATFORM_NAME, "Name");
    ShowCLPlatformInfo(platform, CL_PLATFORM_VENDOR, "Vendor");
    ShowCLPlatformInfo(platform, CL_PLATFORM_VERSION, "Version");
    ShowCLPlatformInfo(platform, CL_PLATFORM_EXTENSIONS, "Extensions");


    err = clGetDeviceIDs(platform, CL_DEVICE_TYPE_ALL, 0, NULL, &deviceNum);
    if(err < 0)
    {
        printf("Couldn't identify a device : %d\n", err);
        exit(1);
    }

    devices = new cl_device_id [deviceNum];
    clGetDeviceIDs(platform, CL_DEVICE_TYPE_ALL, deviceNum, devices, NULL);

    for (int index = 0 ; index < deviceNum ; index ++)
        GetCLDeviceInfo(devices[index], index);

    delete [] devices;
    printf("\n");
}

int main()
{
    cl_platform_id *platforms;
    cl_uint platformNum;
    cl_int err;

    err = clGetPlatformIDs(0, NULL, &platformNum);
    if(err < 0)
    {
        printf("Couldn't identify a platform : %d\n", err);
        exit(1);
    }

    platforms = new cl_platform_id [platformNum];
    clGetPlatformIDs(platformNum, platforms, NULL);

    for (int index = 0 ; index < platformNum ; index ++)
        GetCLPlatformInfo(platforms[index], index);

    delete [] platforms;
}
