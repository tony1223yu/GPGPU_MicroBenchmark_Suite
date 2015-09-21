#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/time.h>

#include <IntelPowerGadget/EnergyLib.h>

/**
 * Option value should be tightly stick to the character
 *
 * -t<time>  : power usage query interval in msec
 * -T<time>  : total time in sec
 * -o<file>  : output file name
 * -u        : show power usage
 * -l        : show power limit
 */

#define MAX_FILE_LEN 200

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


int main(int argc, char* argv[])
{
    GlobalCtrl ctrl;
    if (!CommandParser(argc, argv, &ctrl))  exit(1);
    else
    {
        int numMsrs = 0;

        IntelEnergyLibInitialize();
        GetNumMsrs(&numMsrs);

        // print the order
        {
            int funcID;
            char szName[1024];

            printf("TimeStamp (ms)");
            for (int j = 0; j < numMsrs; j++)
            {
                GetMsrFunc(j, &funcID);
                GetMsrName(j, szName);

                // Power
                if (funcID == MSR_FUNC_POWER) {
                    printf(", %s Power (mW)", szName);
                }

                else if (funcID == MSR_FUNC_FREQ) {
                    printf(", %s (MHz)", szName);
                }

                // Temperature
                else if (funcID == MSR_FUNC_TEMP) {
                    printf(", %s Temp (C)", szName);
                }
            }
            printf("\n");
        }

        // start sampling
        {
            int sampleIter = ctrl.totalTime * 1000 / ctrl.intervalTime;
            int sampleInterval = ctrl.intervalTime * 1000;
            struct timeval startTime, curTime;
            unsigned long long start_utime, cur_utime, pre_utime;
            FILE *fp = fopen(ctrl.outputFile, "w");
            
            int funcID;
            char szName[1024];
            int nData;
            double data[3];
            
            while (sampleIter -- > 0)
            {
                gettimeofday(&curTime, NULL);
                cur_utime = curTime.tv_sec * 1000 + curTime.tv_usec / 1000;

                ReadSample();
                fprintf(fp, "%llu", cur_utime);
                for (int j = 0; j < numMsrs; j++)
                {
                    GetMsrFunc(j, &funcID);

                    GetPowerData(0, j, data, &nData);

                    // Power
                    if (funcID == MSR_FUNC_POWER) {
                        fprintf(fp, " %11.3f", data[0] * 1000);
                    }

                    else if (funcID == MSR_FUNC_FREQ) {
                        fprintf(fp, " %4.0f", data[0]);
                    }

                    // Temperature
                    else if (funcID == MSR_FUNC_TEMP) {
                        fprintf(fp, " %7.3f", data[0]);
                    }
                    data[0] = 0;
                }
                fprintf(fp, "\n");

                usleep(sampleInterval);
            }
        }
    }
}
