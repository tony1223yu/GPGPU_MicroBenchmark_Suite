#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/time.h>
#include <AMDTDefinitions.h>
#include <AMDTPowerProfileApi.h>
#include <AMDTPowerProfileDataTypes.h>

#define MAX_FILE_LEN 200

// counterIDs
#define CPU_CU0_POWER 12
#define CPU_CU1_POWER 28
#define CPU_CORE0_FREQ 20
#define CPU_CORE1_FREQ 25
#define CPU_CORE2_FREQ 36
#define CPU_CORE3_FREQ 41
#define GPU_POWER 44
#define GPU_FREQ 47

typedef struct GlobalCtrl
{
    int intervalTime;
    int totalTime;
    char outputFile[MAX_FILE_LEN];

    GlobalCtrl(): intervalTime(200), totalTime(10) {sprintf(outputFile, "PowerUsageOutput.log");}
} GlobalCtrl;

bool CommandParser(int argc, char *argv[], GlobalCtrl *ctrl)
{
    int cmd;
    while(1)
    {
        cmd = getopt(argc, argv, "t:o:T:");
        if (cmd == -1)
            break;

        switch (cmd)
        {
            case 't':
                ctrl->intervalTime = atoi(optarg);
                break;

            case 'T':
                ctrl->totalTime = atoi(optarg);
                break;

            case 'o':
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

inline void CheckAMDTError(AMDTResult error, char *msg)
{
    if (AMDT_STATUS_OK != error)
    {
        printf("Error: %s: %u\n", msg, error);
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
        AMDTResult error;

        // Init
        {
            AMDTUInt32 nCounters;
            AMDTUInt32 minSampleTime;
            AMDTPwrCounterDesc *pCounters;
            AMDTPwrDeviceId deviceId = AMDT_PWR_ALL_DEVICES;
            
            error = AMDTPwrProfileInitialize(AMDT_PWR_PROFILE_MODE_ONLINE);
            CheckAMDTError(error, strdup("Unable to initialize AMDT driver"));

            error = AMDTPwrEnableAllCounters();
            CheckAMDTError(error, strdup("Unable to enable AMDT counter"));

            error = AMDTPwrGetMinimalTimerSamplingPeriod(&minSampleTime);
            CheckAMDTError(error, strdup("Unable to get minimal sampling period"));
            
            printf("minimal sampling period %d ms\n", minSampleTime);
        }

        // Power/Utilization polling
        {
            // Start grab power/utilization info
            {
                struct timeval startTime, curTime;
                unsigned long long start_utime, cur_utime;
                AMDTPwrSample* sampleResult;
                AMDTUInt32 nSamples;

                FILE *fp = fopen(ctrl.outputFile, "w");

                error = AMDTPwrSetTimerSamplingPeriod(ctrl.intervalTime);
                CheckAMDTError(error, strdup("Unable to set sampling rate"));

                error = AMDTPwrStartProfiling();
                CheckAMDTError(error, strdup("Unable to start profiling"));

                gettimeofday(&startTime, NULL);
                start_utime = startTime.tv_sec * 1000 + startTime.tv_usec / 1000;

                printf("start_time: %llu msec\n", start_utime);
                while (1)
                {
                    usleep(ctrl.intervalTime * 2000);
                    
                    gettimeofday(&curTime, NULL);
                    cur_utime = curTime.tv_sec * 1000 + curTime.tv_usec / 1000;

                    // Sample
                    error = AMDTPwrReadAllEnabledCounters(&nSamples, &sampleResult);
                    CheckAMDTError(error, strdup("Unable to read counters"));

                    //printf("nSample = %d\n", nSamples);
                    //printf("nValue = %d\n", sampleResult->m_numOfValues);

                    for (AMDTUInt32 idx = 0 ; idx < nSamples ; idx ++)
                    {
                        fprintf(fp, "%llu ", cur_utime);
                        for (unsigned int i = 0; i < sampleResult->m_numOfValues; i++)
                        {
                            AMDTPwrCounterDesc counter;
                            AMDTPwrGetCounterDesc(sampleResult->m_counterValues[i].m_counterID, &counter);
                            //fprintf(fp, "%s %f\n", counter.m_name, sampleResult->m_counterValues[i].m_counterValue);
                            fprintf(fp, "%f ", sampleResult->m_counterValues[i].m_counterValue);
                        }
                        fprintf(fp, "\n");
                        sampleResult ++;
                    }

                    // Grab end
                    if ((cur_utime - start_utime) > (ctrl.totalTime * 1000))
                        break;

                }
                printf("end_time: %llu msec\n", cur_utime);
                fclose(fp);
            }
        }
    }
}

