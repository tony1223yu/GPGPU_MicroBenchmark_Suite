#ifndef _PAPI_WRAPPER_HPP_
#define _PAPI_WRAPPER_HPP_

#include "papi_test.h"
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>

#define CHECK_PAPI_ERROR(error, name)                                                                                       \
    do                                                                                                                      \
    {                                                                                                                       \
        if (error != PAPI_OK)                                                                                               \
        {                                                                                                                   \
            fprintf(stderr, "PAPI API '%s' error at line %d: %s (%d)\n", name, __LINE__, PAPI_strerror(error), error);      \
            exit(1);                                                                                                        \
        }                                                                                                                   \
    } while(0)


class PAPIWrapper
{
    private:
        int eventCount;
        int eventSet;
        int *eventCode;
        char **eventName;
        long long *eventValue;

        void initialize()
        {
            int ret;
            ret = PAPI_library_init(PAPI_VER_CURRENT);
            if (ret != PAPI_VER_CURRENT)
            {
                fprintf(stderr, "PAPI API 'PAPU_library_init' error !\n");
                exit(1);
            }
            fprintf(stdout, "PAPI_VERSION: %d.%d.%d\n",
		    	        PAPI_VERSION_MAJOR( PAPI_VERSION ),
			            PAPI_VERSION_MINOR( PAPI_VERSION ),
			            PAPI_VERSION_REVISION( PAPI_VERSION ) );

            ret = PAPI_create_eventset(&eventSet);
            CHECK_PAPI_ERROR(ret, "PAPI_create_eventset");
        }

        void destroy()
        {
            int ret;
            ret = PAPI_cleanup_eventset(eventSet);
            CHECK_PAPI_ERROR(ret, "PAPI_cleanup_eventset");

            ret = PAPI_destroy_eventset(&eventSet);
            CHECK_PAPI_ERROR(ret, "PAPI_destroy_eventset");

            PAPI_shutdown();
        }

    public:
        PAPIWrapper():
            eventCount(0),
            eventSet(PAPI_NULL),
            eventCode(NULL),
            eventName(NULL),
            eventValue(NULL)
        {
            initialize();
        }

        ~PAPIWrapper()
        {
            if (eventCode)
                free(eventCode);

            if (eventName)
            {
                for (int i = 0 ; i < eventCount ; i ++)
                    free(eventName[i]);
                free(eventName);
            }

            if (eventValue)
                free(eventValue);
        }

        void Start()
        {
            int ret;
            ret = PAPI_start(eventSet);
            CHECK_PAPI_ERROR(ret, "PAPI_start");
        }

        void Stop()
        {
            int ret;
            ret = PAPI_stop(eventSet, eventValue);
            CHECK_PAPI_ERROR(ret, "PAPI_stop");

            destroy();

            for (int i = 0 ; i < eventCount ; i ++)
                printf("%-40s --> %lld\n", eventName[i], eventValue[i]);
        }

        void PrintResult(char *fileName)
        {
            FILE *fptr = fopen(fileName, "w");

            for (int i = 0 ; i < eventCount ; i ++)
                fprintf(fptr, "%-40s %lld\n", eventName[i], eventValue[i]);

            fclose(fptr);
            free(fileName);
        }

        void AddEvent(int count, ...)
        {
            if (eventCount != 0)
            {
                fprintf(stderr, "PAPIWrapper::AddEvent() can only be called once\n");
                exit(1);
            }

            int ret;
            va_list argList;
            eventCount = count;
            eventName = (char **) malloc(sizeof(char *) * eventCount);
            eventCode = (int *) malloc(sizeof(int) * eventCount);
            eventValue = (long long *) malloc(sizeof(long long) * eventCount);

            va_start(argList, count);
            for (int i = 0; i < eventCount ; i ++)
            {
                eventName[i] = va_arg(argList, char*);
                ret = PAPI_event_name_to_code(eventName[i], &eventCode[i]);
                CHECK_PAPI_ERROR(ret, "PAPI_event_name_to_code");

                fprintf(stdout, "[papi_wrapper] Name %s --- Code %#x\n", eventName[i], eventCode[i]);
            }

            ret = PAPI_add_events(eventSet, eventCode, eventCount);
            CHECK_PAPI_ERROR(ret, "PAPI_add_events");

            va_end(argList);
        }
};

#endif

