//=============================================================================
//
// Author: AMD Developer Tools
//         AMD, Inc.
//
// This header file contains the data type and the structure definitions
// used by the AMD CodeXL Power Profiler APIs.
//
//=============================================================================
// Copyright (c) 2015 Advanced Micro Devices, Inc.  All rights reserved.
//=============================================================================

#ifndef _AMDTPOWERPROFILEDATATYPES_H_
#define _AMDTPOWERPROFILEDATATYPES_H_

/** \file AMDTPowerProfileDataTypes.h
\brief Data types and structure definitions used by AMD CodeXL Power Profiler APIs.
*/

#include <AMDTDefinitions.h>

/** HW Components for which power counters are supported are called devices.
Following are such components:
    - AMD APUs and its subcomponents like CPU Compute-units, CPU Cores, integrated GPUs
    - AMD discrete GPUs
This macro denotes all the devices that are relevant to power profiling.
*/
#define AMDT_PWR_ALL_DEVICES 0xFFFFFFFFUL

/** Maximum number of available APU P-States
*/
#define AMDT_MAX_PSTATES 8

/** Device Id
*/
typedef AMDTUInt32 AMDTPwrDeviceId;

/** Following power profile modes are supported.
\ingroup profiling
*/
typedef enum
{
    AMDT_PWR_PROFILE_MODE_ONLINE,       /**< Power profile mode is online */
} AMDTPwrProfileMode;

/** Each package (processor node) and its sub-components and dGPUs are considered as devices here.
Following are the various types of devices supported by power profiler.
\ingroup profiling
*/
typedef enum
{
    AMDT_PWR_DEVICE_SYSTEM,                 /**< Dummy root node. All the top-level devices like CPU,APU,dGPU are its children */
    AMDT_PWR_DEVICE_PACKAGE,                /**< In a multi-node system, each node will be a separate package */
    AMDT_PWR_DEVICE_CPU_COMPUTE_UNIT,       /**< Each CPU Compute-Unit within a package */
    AMDT_PWR_DEVICE_CPU_CORE,               /**< Each CPU core within a CPU Compute-Unit */
    AMDT_PWR_DEVICE_INTERNAL_GPU,           /**< Integrated GPU within a AMD APU */
    AMDT_PWR_DEVICE_EXTERNAL_GPU,           /**< Each AMD dGPU connected in the system */
    AMDT_PWR_DEVICE_SVI2,                   /**< Serial Voltage Interface 2 */
    AMDT_PWR_DEVICE_CNT                     /**< Total device count */
} AMDTDeviceType;

/** Following is the list of counter category supported by power profiler.
\ingroup profiling
*/
typedef enum
{
    AMDT_PWR_CATEGORY_POWER,              /**< Instantaneous power */
    AMDT_PWR_CATEGORY_FREQUENCY,          /**< Frequency  */
    AMDT_PWR_CATEGORY_TEMPERATURE,        /**< Temperature in centigrade */
    AMDT_PWR_CATEGORY_VOLTAGE,            /**< Voltage */
    AMDT_PWR_CATEGORY_CURRENT,            /**< Current */
    AMDT_PWR_CATEGORY_DVFS,               /**< P-State, C-State */
    AMDT_PWR_CATEGORY_PROCESS,            /**< PID, TID */
    AMDT_PWR_CATEGORY_TIME,               /**< Time */
    AMDT_PWR_CATEGORY_COUNT,              /**< Generic count value */
    AMDT_PWR_CATEGORY_CNT                 /**< Total category count */
} AMDTPwrCategory;

/** Following is the list of aggregation types supported by power profiler.
\ingroup profiling
*/
typedef enum
{
    AMDT_PWR_VALUE_SINGLE,                  /**< Single instantaneous value */
    AMDT_PWR_VALUE_CUMULATIVE,              /**< Cumulative value */
    AMDT_PWR_VALUE_HISTOGRAM,               /**< Histogram value */
    AMDT_PWR_VALUE_CNT                      /**< Total power value */
} AMDTPwrAggregation;

/** Various unit types for the output values for the counter types.
\ingroup profiling
*/
typedef enum
{
    AMDT_PWR_UNIT_TYPE_COUNT,             /**< Count index */
    AMDT_PWR_UNIT_TYPE_PERCENT,           /**< Percentage */
    AMDT_PWR_UNIT_TYPE_RATIO,             /**< Ratio */
    AMDT_PWR_UNIT_TYPE_MILLI_SECOND,      /**< Time in milli seconds*/
    AMDT_PWR_UNIT_TYPE_JOULE,             /**< Energy consumption */
    AMDT_PWR_UNIT_TYPE_WATT,              /**< Power consumption */
    AMDT_PWR_UNIT_TYPE_VOLT,              /**< Voltage */
    AMDT_PWR_UNIT_TYPE_MILLI_AMPERE,      /**< Current */
    AMDT_PWR_UNIT_TYPE_MEGA_HERTZ,        /**< Frequency type unit */
    AMDT_PWR_UNIT_TYPE_CENTIGRADE,        /**< Temperature type unit */
    AMDT_PWR_UNIT_TYPE_CNT                /**< Total power unit */
} AMDTPwrUnit;

/** States of Power profiler.
\ingroup profiling
*/
typedef enum
{
    AMDT_PWR_PROFILE_STATE_UNINITIALIZED,          /**< Profiler is not initialized */
    AMDT_PWR_PROFILE_STATE_IDLE,                   /**< Profiler is initialized */
    AMDT_PWR_PROFILE_STATE_RUNNING,                /**< Profiler is running */
    AMDT_PWR_PROFILE_STATE_PAUSED,                 /**< Profiler is paused */
    AMDT_PWR_PROFILE_STATE_STOPPED,                /**< Profiler is Stopped */
    AMDT_PWR_PROFILE_STATE_ABORTED,                /**< Profiler is aborted */
    AMDT_PWR_PROFILE_STATE_CNT                     /**< Total number of profiler states */
} AMDTPwrProfileState;

/** Options to retrieve the profiled counter data using AMDTPwrReadAllEnabledCounters function
\ingroup profiling
*/
typedef enum
{
    AMDT_PWR_SAMPLE_VALUE_INSTANTANEOUS,     /**< Default. The latest/instantaneous */
    AMDT_PWR_SAMPLE_VALUE_LIST,              /**< List of sampled counter values */
    AMDT_PWR_SAMPLE_VALUE_AVERAGE,           /**< Average of the sampled counter */
    AMDT_PWR_SAMPLE_VALUE_CNT                /**< Maximum Sample value count */
} AMDTSampleValueOption;

/** P-States can be either hardware or software P-States. Hardware P-States are also known as
Boosted P-States. These are defined as AMDT_PWR_PSTATES_PBx. The Software P-States are defined
as AMDT_PWR_PSTATES_Px, where x is the P-State number. Hardware(Boosted) P-States are not 
software visible.
\ingroup profiling
*/
typedef enum
{
    AMDT_PWR_PSTATE_PB0,  /**< Boosted P-State 0 */
    AMDT_PWR_PSTATE_PB1,  /**< Boosted P-State 1*/
    AMDT_PWR_PSTATE_PB2,  /**< Boosted P-State 2*/
    AMDT_PWR_PSTATE_PB3,  /**< Boosted P-State 3*/
    AMDT_PWR_PSTATE_PB4,  /**< Boosted P-State 4*/
    AMDT_PWR_PSTATE_PB5,  /**< Boosted P-State 5*/
    AMDT_PWR_PSTATE_PB6,  /**< Boosted P-State 6*/
    AMDT_PWR_PSTATE_P0,   /**< Software P-State 0 */
    AMDT_PWR_PSTATE_P1,   /**< Software P-State 1 */
    AMDT_PWR_PSTATE_P2,   /**< Software P-State 2 */
    AMDT_PWR_PSTATE_P3,   /**< Software P-State 3 */
    AMDT_PWR_PSTATE_P4,   /**< Software P-State 4 */
    AMDT_PWR_PSTATE_P5,   /**< Software P-State 5 */
    AMDT_PWR_PSTATE_P6,   /**< Software P-State 6 */
    AMDT_PWR_PSTATE_P7,   /**< Software P-State 7 */
} AMDTApuPStates;

/**  Following structure represents the device tree of the target system. Nodes will be
available for components for which power counters are supported. Following are such components -
AMD APUs and its subcomponents like CPU Compute-units, CPU Cores, integrated GPUs & AMD discrete GPUs.
\ingroup profiling
*/
typedef struct AMDTPwrDevice
{
    AMDTDeviceType      m_type;           /**< Device type- compute unit/Core/ package/ dGPU */
    AMDTPwrDeviceId     m_deviceID;       /**< Device Id */
    char*               m_pName;          /**< Name of the device */
    char*               m_pDescription;   /**< Description about the device */
    bool                m_isAccessible;   /**< If counters are accessible */
    AMDTPwrDevice*      m_pFirstChild;    /**< Points to the sub-devices of this device */
    AMDTPwrDevice*      m_pNextDevice;    /**< Points to the next device at the same hierarchy */
} AMDTPwrDevice;

/** Details of a supported power counter and its associated device.
Following counter types are supported:
    - Simple Counters has m_aggregation type as AMDT_PWR_VALUE_SINGLE.
    - Histogram Counters has m_aggregation type as AMDT_PWR_VALUE_HISTOGRAM.
    - Cumulative Counters has m_aggregation type as AMDT_PWR_VALUE_CUMULATIVE.
\ingroup profiling
*/
typedef struct AMDTPwrCounterDesc
{
    AMDTUInt32           m_counterID;       /**< Counter index */
    AMDTUInt32           m_deviceId;        /**< Device Id */
    char*                m_name;            /**< Name of the counter */
    char*                m_description;     /**< Description of the counter */
    AMDTPwrCategory      m_category;        /**< Power/Freq/Temperature */
    AMDTPwrAggregation   m_aggregation;     /**< Single/Histogram/Cumulative */
    AMDTFloat64          m_minValue;        /**< Minimum possible counter value */
    AMDTFloat64          m_maxValue;        /**< Maximum possible counter value */
    AMDTPwrUnit          m_units;           /**< Seconds/MHz/Joules/Watts/Volt/Ampere */
} AMDTPwrCounterDesc;

/** Structure represents a counter ID and its value
\ingroup profiling
*/
typedef struct
{
    AMDTUInt32      m_counterID;       /**< Counter index */
    AMDTFloat32     m_counterValue;    /**< Counter value */
} AMDTPwrCounterValue;

/** This structure represents the system time in second and milliseconds
\ingroup profiling
*/
typedef struct
{
    AMDTUInt64   m_second;           /**< Seconds */
    AMDTUInt64   m_microSecond;      /**< Milliseconds */
} AMDTPwrSystemTime;

/** Output sample with timestamp and the counter values for all the enabled counters.
\ingroup profiling
*/
typedef struct AMDTPwrSample
{
    AMDTPwrSystemTime      m_systemTime;          /**< Start time of Profiling */
    AMDTUInt64             m_elapsedTimeMs;       /**< Elapsed time in milliseconds - relative to the start time of the profile */
    AMDTUInt64             m_recordId;            /**< Record id */
    AMDTUInt32             m_numOfValues;         /**< Number of counter values available */
    AMDTPwrCounterValue*   m_counterValues;       /**< list of counter values */
} AMDTPwrSample;

/** Provides various P-States and their corresponding frequencies.
\ingroup profiling
*/
typedef struct AMDTPwrApuPstate
{
    AMDTApuPStates  m_state;            /**< P-State number */
    bool            m_isBoosted;        /**< Boosted P-State flag */
    AMDTUInt32      m_frequency;        /**< P-State frequency */
} AMDTPwrApuPstate;

/** List of the supported APU P-States details
\ingroup profiling
*/
typedef struct AMDTPwrApuPstateList
{
    AMDTUInt32        m_cnt;                             /**< Number of P-States */
    AMDTPwrApuPstate  m_stateInfo[AMDT_MAX_PSTATES];     /**< P-States list */
} AMDTPwrApuPstateList;

/** Provides hierarchical relationship details of a power counter. Both the parent and children
counter details will be provided.
\ingroup profiling
*/
typedef struct AMDTPwrCounterHierarchy
{
    AMDTUInt32  m_counter;           /**< Counter Id */
    AMDTUInt32  m_parent;            /**< Parent counter Id */
    AMDTUInt32  m_childCnt;          /**< Number of child counters */
    AMDTUInt32* m_pChildList;        /**< List of child counters */
} AMDTPwrCounterHierarchy;

/** Represents a generic histogram.
\ingroup profiling
*/
typedef struct
{
    AMDTUInt32      m_counterId;    /**< Counter being aggregated */
    AMDTUInt32      m_numOfBins;    /**< This is the number of histogram bins */
    AMDTFloat32*    m_pRange;       /**< The ranges of the bins are stored in an array of n + 1 elements pointed to by range */
    AMDTFloat32*    m_pBins;        /**< The counts for each bin are stored in an array of n elements pointed to by bin */
} AMDTPwrHistogram;

#endif //_AMDTPOWERPROFILEDATATYPES_H_