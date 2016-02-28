#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <nvml.h>
#include <sys/time.h>

#define MAX_FILE_LEN 200

typedef struct GlobalCtrl
{
    int intervalTime;
    int totalTime;
    int cudaDeviceNumber;
    char outputFile[MAX_FILE_LEN];

    GlobalCtrl(): cudaDeviceNumber(0), intervalTime(200), totalTime(10) {sprintf(outputFile, "PowerUsageOutput.log");}
} GlobalCtrl;

bool CommandParser(int argc, char *argv[], GlobalCtrl *ctrl)
{
    int cmd;
    while(1)
    {
        cmd = getopt(argc, argv, "t:o:T:D:");
        if (cmd == -1)
            break;

        switch (cmd)
        {
            case 'D':
                ctrl->cudaDeviceNumber = atoi(optarg);
                break;

            case 't':
                ctrl->intervalTime = atoi(optarg);
                break;

            case 'T':
                ctrl->totalTime = atoi(optarg);
                break;

            case 'o':
                printf("Output file: %s\n", optarg);
                memset(ctrl->outputFile, 0, MAX_FILE_LEN);
                sprintf(ctrl->outputFile, "%s", optarg);
                break;

            default:
                printf("Error: Unknown argument: %s\n", optarg);
                return false;
                break;
        }
    }
    return true;
}

inline void CheckNVMLError(nvmlReturn_t error, char *msg)
{
    if (NVML_SUCCESS != error)
    {
        printf("Error: %s: %s\n", msg, nvmlErrorString(error));
        free(msg);
        exit(1);
    }
    free(msg);
}

int main(int argc, char *argv[])
{
    GlobalCtrl ctrl;
    if (!CommandParser(argc, argv, &ctrl)) exit(1);
    else
    {
        nvmlReturn_t error;
        nvmlDevice_t device;

        // Init
        {
            error = nvmlInit();
            CheckNVMLError(error, strdup("Unable to initialize NVML"));
        }

        // Show all devices
        {
            unsigned int deviceNum, i;
            char name[NVML_DEVICE_NAME_BUFFER_SIZE];
            nvmlDevice_t currDevice;

            error = nvmlDeviceGetCount(&deviceNum);
            CheckNVMLError(error, strdup("Unable to get device count"));

            printf("====== SUPPORT DEVICES ======\n");
            for (i = 0 ; i < deviceNum ; i ++)
            {
                error = nvmlDeviceGetHandleByIndex(i, &currDevice);
                CheckNVMLError(error, strdup("Unable to get device handler"));

                error = nvmlDeviceGetName(currDevice, name, NVML_DEVICE_NAME_BUFFER_SIZE);
                CheckNVMLError(error, strdup("Unable to get device name"));

                printf("device %d: %s\n", i, name);
            }
            printf("=============================\n\n");

            if (ctrl.cudaDeviceNumber >= deviceNum)
            {
                printf("Invalid device number\n");
                exit(1);
            }

            printf("Select device %d\n", ctrl.cudaDeviceNumber);
            error = nvmlDeviceGetHandleByIndex(ctrl.cudaDeviceNumber, &device);
        }

#if 0
        // Check supported clock frequency
        {
            error = nvmlDeviceSetPersistenceMode(device, NVML_FEATURE_ENABLED);
            CheckNVMLError(error, strdup("Unable to change to persistence mode"));

            unsigned size = 10000;
            unsigned iterMemory, iterGraphic, memoryCount = size, graphicCount, memoryClock[size], graphicClock[size];
            error = nvmlDeviceGetSupportedMemoryClocks(device, &memoryCount, memoryClock);
            CheckNVMLError(error, strdup("Unable to get supported memory clock"));
            for (iterMemory = 0 ; iterMemory < memoryCount ; iterMemory ++)
            {
                graphicCount = size;
                error = nvmlDeviceGetSupportedGraphicsClocks(device, memoryClock[iterMemory], &graphicCount, graphicClock);
                CheckNVMLError(error, strdup("Unable to get supported graphics clock"));
                for (iterGraphic = 0 ; iterGraphic < graphicCount ; iterGraphic ++)
                {
                    printf("set memory clock: %5uMHz, graphics clock %5uMHz\n", memoryClock[iterMemory], graphicClock[iterGraphic]);

                    error = nvmlDeviceSetApplicationsClocks(device, memoryClock[iterMemory], graphicClock[iterGraphic]);
                    CheckNVMLError(error, strdup("Unable to set application clock"));
                    usleep(1000);

                }
            }
        }
#endif

#if 1
        // Power/Utilization polling
        {
            // Check power mode
            {
                nvmlEnableState_t powerMode = (nvmlEnableState_t)(0);
                error = nvmlDeviceGetPowerManagementMode(device, &powerMode);
                CheckNVMLError(error, strdup("Unable to get device power mode"));
                if (!powerMode)
                {
                    printf("Error: Power management mode is not enable in current device.\n");
                    exit(1);
                }
            }

            // Start grab power/utilization info
            {
                int sampleInterval = ctrl.intervalTime * 1000;
                struct timeval startTime, curTime;
                unsigned long long start_utime, cur_utime;
                unsigned int curPower, curFreq, curTemp;
                nvmlPstates_t perfState;
                nvmlUtilization_t curUtil;
                FILE *fp = fopen(ctrl.outputFile, "w");

                gettimeofday(&startTime, NULL);
                start_utime = startTime.tv_sec * 1000 + startTime.tv_usec / 1000;

                printf("start_time: %llu msec\n", start_utime);
                while (1)
                {
                    gettimeofday(&curTime, NULL);
                    cur_utime = curTime.tv_sec * 1000 + curTime.tv_usec / 1000;

                    // Sample

                    error = nvmlDeviceGetPowerUsage(device, &curPower);
                    CheckNVMLError(error, strdup("Unable to read current power"));

                    error = nvmlDeviceGetUtilizationRates(device, &curUtil);
                    CheckNVMLError(error, strdup("Unable to read current utilization"));

                    error = nvmlDeviceGetPerformanceState(device, &perfState);
                    CheckNVMLError(error, strdup("Unable to get performance state"));

                    error = nvmlDeviceGetClockInfo(device, NVML_CLOCK_SM, &curFreq);
                    CheckNVMLError(error, strdup("Unable to get clock frequency"));

                    error = nvmlDeviceGetTemperature(device, NVML_TEMPERATURE_GPU, &curTemp);
                    CheckNVMLError(error, strdup("Unable to get GPU temperature"));

                    fprintf(fp, "%llu %7u %3u %3u %3u %5u %3u\n", cur_utime, curPower, curUtil.gpu, curUtil.memory, perfState, curFreq, curTemp);

                    // Grab end
                    if ((cur_utime - start_utime) > (ctrl.totalTime * 1000))
                        break;
                    
                    usleep(sampleInterval);
                }
                printf("end_time: %llu msec\n", cur_utime);
                fclose(fp);
            }
        }
#endif

#if 0
        // get the power information using nvmlDeviceGetSamples
        {
            nvmlValueType_t sampleType;
            unsigned int sampleCount;
            nvmlSample_t *sample;
            unsigned int idx;

            error = nvmlDeviceGetSamples(device, NVML_TOTAL_POWER_SAMPLES, start_utime * 1000, &sampleType, &sampleCount, NULL);
            //error = nvmlDeviceGetSamples(device, NVML_GPU_UTILIZATION_SAMPLES, start_utime * 1000, &sampleType, &sampleCount, NULL);
            //error = nvmlDeviceGetSamples(device, NVML_MEMORY_UTILIZATION_SAMPLES, start_utime * 1000, &sampleType, &sampleCount, NULL);
            CheckNVMLError(error, strdup("Unable to get maximum sample size"));
            printf("total sample count %u, type %d\n", sampleCount, sampleType);

            sample = (nvmlSample_t *) (malloc(sizeof(nvmlSample_t) * sampleCount));
            error = nvmlDeviceGetSamples(device, NVML_TOTAL_POWER_SAMPLES, start_utime * 1000, &sampleType, &sampleCount, sample);
            //error = nvmlDeviceGetSamples(device, NVML_GPU_UTILIZATION_SAMPLES, start_utime * 1000, &sampleType, &sampleCount, sample);
            //error = nvmlDeviceGetSamples(device, NVML_MEMORY_UTILIZATION_SAMPLES, start_utime * 1000, &sampleType, &sampleCount, sample);
            CheckNVMLError(error, strdup("Unable to access sample buffer"));
            printf("total sample count %u, type %d\n", sampleCount, sampleType);

            for (idx = 0 ; idx < sampleCount ; idx ++)
            {
                printf("%llu (ns) %u\n", sample[idx].timeStamp, sample[idx].sampleValue.uiVal);
            }
            free (sample);
        }
#endif

    }
}

