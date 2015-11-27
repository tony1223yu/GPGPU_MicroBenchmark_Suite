//=============================================================================
//
// Author: AMD Developer Tools
//         AMD, Inc.
//
// This is the only header file that must be included by an application or tool
// that wishes to use AMD CodeXL Power Profile APIs. It defines all the
// available power profiler APIs.
//
//=============================================================================
// Copyright (c) 2015 Advanced Micro Devices, Inc.  All rights reserved.
//=============================================================================

#ifndef _AMDTPOWERPROFILEAPI_H_
#define _AMDTPOWERPROFILEAPI_H_

/**
\file AMDTPowerProfileApi.h
\brief AMD Power Profiler APIs to configure, control and collect the power profile counters.

\defgroup profiling Power Profiling
\brief AMDT Power Profiler APIs.

\mainpage CodeXL Power Profiler API
The AMDTPwrProfileAPI is a powerful library to help analyze the energy efficiency of systems based on AMD CPUs, APUs and Discrete GPUs.

This API:
- Provides counters to read the power, thermal and frequency characteristics of APU/dGPU and their subcomponents.
- Supports AMD APUs (Kaveri, Temash, Mullins, Carrizo), Discrete GPUs (Tonga, Iceland, Bonaire, Hawaii and other newer graphics cards)
- Supports AMD FirePro discrete GPU cards (W9100, W8100, W7100, W5100 and other newer graphics cards).
- Supports Microsoft Windows as a dynamically loaded library or as a static library.
- Supports Linux as a shared library or as a static library.
- Manages memory automatically - no allocation and free required.

Using this API, counter values can be read at regular sampling interval. Before any profiling done, the \ref AMDTPwrProfileInitialize()
API must be called. When all the profiling is finished, the \ref AMDTPwrProfileClose() API must be called. Upon successful completion all
the APIs will return AMDT_STATUS_OK, otherwise they return appropriate error codes.
*/

/** \example CollectAllCounters.cpp
Example program to collect all the available counters.
*/

#include <AMDTDefinitions.h>
#include <AMDTPowerProfileDataTypes.h>

/** This API loads and initializes the AMDT Power Profile drivers. This API should be the first one to be called.

    \ingroup profiling
    @param[in] profileMode: Client should select any one of the predefined profile modes that are defined in \ref AMDTPwrProfileMode.
    \return The status of initialization request
    \retval AMDT_STATUS_OK: Success
    \retval AMDT_ERROR_INVALIDARG: An invalid profileMode parameter was passed
    \retval AMDT_ERROR_DRIVER_UNAVAILABLE: Driver not available
    \retval AMDT_ERROR_DRIVER_ALREADY_INITIALIZED: Already initialized
    \retval AMDT_DRIVER_VERSION_MISMATCH: Mismatch between the expected and installed driver versions
    \retval AMDT_ERROR_PLATFORM_NOT_SUPPORTED: Platform not supported
    \retval AMDT_WARN_SMU_DISABLED: SMU is disabled and hence power and thermal values provided by SMU will not be available
    \retval AMDT_WARN_IGPU_DISABLED: Internal GPU is disabled
    \retval AMDT_ERROR_FAIL: An internal error occurred
    \retval AMDT_ERROR_PREVIOUS_SESSION_NOT_CLOSED: Previous session was not closed.
*/
extern AMDTResult AMDTPwrProfileInitialize(AMDTPwrProfileMode profileMode);

/** This API provides device tree that represents the current system topology relevant to power profiler.
    The nodes (a processor package or a dGPU) and as well as their sub-components are considered as devices.
    Each device in the tree points to their siblings and children, if any.

    \ingroup profiling
    @param[out] ppTopology: Device tree
    \return The status of system topology request
    \retval AMDT_STATUS_OK: On Success
    \retval AMDT_ERROR_INVALIDARG: NULL pointer was passed as ppTopology parameter
    \retval AMDT_ERROR_DRIVER_UNINITIALIZED: \ref AMDTPwrProfileInitialize() function was neither called nor successful
    \retval AMDT_ERROR_OUTOFMEMORY: Failed to allocate required memory
    \retval AMDT_ERROR_FAIL: An internal error occurred
*/
extern AMDTResult AMDTPwrGetSystemTopology(AMDTPwrDevice** ppTopology);

/** This API provides the list of supported counters for the given device id.
    If the device id is \ref AMDT_PWR_ALL_DEVICES, then counters for all the available devices will be returned.
    The pointer returned will be valid till the client calls \ref AMDTPwrProfileClose() function.

    \ingroup profiling
    @param[in] deviceId: The deviceId provided by \ref AMDTPwrGetSystemTopology() function or AMDT_PWR_ALL_DEVICES to represent
                         all the devices returned by \ref AMDTPwrGetSystemTopology()
    @param[out] pNumCounters: Number of counters supported by the device
    @param[out] ppCounterDescs: Description of each counter supported by the device
    \return The status of device counter details request
    \retval AMDT_STATUS_OK: On Success
    \retval AMDT_ERROR_INVALIDARG: NULL pointer was passed as ppCounterDescs or pNumCounters parameters
    \retval AMDT_ERROR_DRIVER_UNINITIALIZED: \ref AMDTPwrProfileInitialize() function was neither called nor successful
    \retval AMDT_ERROR_INVALID_DEVICEID: invalid deviceId parameter was passed
    \retval AMDT_ERROR_OUTOFMEMORY: Failed to allocate required memory
    \retval AMDT_ERROR_FAIL: An internal error occurred
*/
extern AMDTResult AMDTPwrGetDeviceCounters(AMDTPwrDeviceId deviceId,
                                           AMDTUInt32* pNumCounters,
                                           AMDTPwrCounterDesc** ppCounterDescs);

/** This API provides the description for the given counter Index.

    \ingroup profiling
    @param[in] counterId: Counter index
    @param[out] pCounterDesc: Description of the counter which index is counterId
    \return The status of counter description request
    \retval AMDT_STATUS_OK: On Success
    \retval AMDT_ERROR_INVALIDARG:  NULL pointer was passed as pCounterDesc parameter
    \retval AMDT_ERROR_DRIVER_UNINITIALIZED: \ref AMDTPwrProfileInitialize() function was neither called nor successful
    \retval AMDT_ERROR_INVALID_COUNTERID: Invalid counterId parameter was passed
    \retval AMDT_ERROR_FAIL: An internal error occurred
*/
extern AMDTResult AMDTPwrGetCounterDesc(AMDTUInt32 counterId,
                                        AMDTPwrCounterDesc* pCounterDesc);

/** This API will enable the counter to be sampled. This API cannot be used once profile is started.
    - If histogram/cumulative counters are enabled along with simple counters, then it is expected that the
    AMDTPwrReadAllEnabledCounters() API is regularly called to read the simple counters value. Only then
    the values for histogram/cumulative counters will be aggregated and the AMDTPwrReadCounterHistogram()
    API will return the correct values.
    - If only the histogram/cumulative counters are enabled, calling AMDTPwrReadCounterHistogram() is
    sufficient to get the values for the enabled histogram/cumulative counters.

    \ingroup profiling
    @param[in] counterId: Counter index
    \return The status of counter enable request
    \retval AMDT_STATUS_OK: On Success
    \retval AMDT_ERROR_DRIVER_UNINITIALIZED: \ref AMDTPwrProfileInitialize() function was neither called nor successful
    \retval AMDT_ERROR_INVALID_COUNTERID: Invalid counterId parameter was passed
    \retval AMDT_ERROR_COUNTER_ALREADY_ENABLED: Specified counter is already enabled
    \retval AMDT_ERROR_PROFILE_ALREADY_STARTED: Counters cannot be enabled on the fly when the profile is already started
    \retval AMDT_ERROR_PREVIOUS_SESSION_NOT_CLOSED: Previous session was not closed
    \retval AMDT_ERROR_COUNTER_NOT_ACCESSIBLE: Counter is not accessible
    \retval AMDT_ERROR_FAIL: An internal error occurred
*/
extern AMDTResult AMDTPwrEnableCounter(AMDTUInt32 counterId);


/** This API will disable the counter to be sampled from the active list. This API cannot be used once profile is started.

    \ingroup profiling
    @param[in] counterId: Counter index
    \return The status of counter disable request
    \retval AMDT_STATUS_OK: On Success
    \retval AMDT_ERROR_DRIVER_UNINITIALIZED: \ref AMDTPwrProfileInitialize() function was neither called nor successful
    \retval AMDT_ERROR_INVALID_COUNTERID: Invalid counterId parameter was passed
    \retval AMDT_ERROR_COUNTER_NOT_ENABLED: Specified counter is not enabled
    \retval AMDT_ERROR_PROFILE_ALREADY_STARTED: Counters cannot be disabled on the fly when the profile run is already started
    \retval AMDT_ERROR_PREVIOUS_SESSION_NOT_CLOSED: Previous session was not closed
    \retval AMDT_ERROR_FAIL: An internal error occurred
*/
extern AMDTResult AMDTPwrDisableCounter(AMDTUInt32 counterId);

/** This API will enable all the simple counters. This will NOT enable the histogram counters.
    This API cannot be used once profile is started.

    \ingroup profiling
    \return The status of enabling all the supported counters request
    \retval AMDT_STATUS_OK: On Success
    \retval AMDT_ERROR_FAIL: An internal error occurred
    \retval AMDT_ERROR_DRIVER_UNINITIALIZED: \ref AMDTPwrProfileInitialize() function was neither called nor successful
    \retval AMDT_ERROR_COUNTER_ALREADY_ENABLED: Some of the counters are already enabled
    \retval AMDT_ERROR_PROFILE_ALREADY_STARTED: Counters cannot be enabled on the fly when the profile is already started
    \retval AMDT_ERROR_PREVIOUS_SESSION_NOT_CLOSED: Previous session was not closed
*/
extern AMDTResult AMDTPwrEnableAllCounters();

/** This API provides the minimum sampling interval which can be set by the client.

    \ingroup profiling
    @param[out] pIntervalMilliSec: The sampling interval in milli-second
    \return The status of retrieving the minimum supported sampling interval request
    \retval AMDT_STATUS_OK: On Success
    \retval AMDT_ERROR_INVALIDARG: NULL pointer was passed as pIntervalMilliSec parameter
    \retval AMDT_ERROR_DRIVER_UNINITIALIZED: \ref AMDTPwrProfileInitialize() function was neither called nor successful
    \retval AMDT_ERROR_FAIL: An internal error occurred
*/
extern AMDTResult AMDTPwrGetMinimalTimerSamplingPeriod(AMDTUInt32* pIntervalMilliSec);

/** This API will set the driver to periodically sample the counter values and store them in a buffer.
    This cannot be called once the profile run is started.

    \ingroup profiling
    @param[in] interval: sampling period in millisecond
    \return The status of sampling time set request
    \retval AMDT_STATUS_OK: On Success
    \retval AMDT_ERROR_INVALIDARG: Invalid interval value was passed as IntervalMilliSec parameter
    \retval AMDT_ERROR_DRIVER_UNINITIALIZED: \ref AMDTPwrProfileInitialize() function was neither called nor successful
    \retval AMDT_ERROR_PROFILE_ALREADY_STARTED: Timer interval cannot be changed when the profile is already started
    \retval AMDT_ERROR_PREVIOUS_SESSION_NOT_CLOSED: Previous session was not closed
    \retval AMDT_ERROR_FAIL: An internal error occurred
*/
extern AMDTResult AMDTPwrSetTimerSamplingPeriod(AMDTUInt32 interval);

/** This API will start the profiling and the driver will collect the data at regular interval
    specified by \ref AMDTPwrSetTimerSamplingPeriod(). This has to be called after enabling the required counters
    by using \ref AMDTPwrEnableCounter() or \ref AMDTPwrEnableAllCounters().

    \ingroup profiling
    \return The status of starting the profile
    \retval AMDT_STATUS_OK: On Success
    \retval AMDT_ERROR_DRIVER_UNINITIALIZED: \ref AMDTPwrProfileInitialize function was neither called nor successful
    \retval AMDT_ERROR_TIMER_NOT_SET: Sampling timer was not set
    \retval AMDT_ERROR_COUNTERS_NOT_ENABLED: No counters are enabled for collecting profile data
    \retval AMDT_ERROR_PROFILE_ALREADY_STARTED: Profile is already started
    \retval AMDT_ERROR_PREVIOUS_SESSION_NOT_CLOSED: Previous session was not closed
    \retval AMDT_ERROR_BIOS_VERSION_NOT_SUPPORTED: BIOS needs to be upgraded
    \retval AMDT_ERROR_FAIL: An internal error occurred
    \retval AMDT_ERROR_ACCESSDENIED: Profiler is busy, currently not accessible
*/
extern AMDTResult AMDTPwrStartProfiling();

/** This APIs will stop the profiling run which was started by \ref AMDTPwrStartProfiling() function call.

    \ingroup profiling
    \return The status of stopping the profile
    \retval AMDT_STATUS_OK: On Success
    \retval AMDT_ERROR_DRIVER_UNINITIALIZED: \ref AMDTPwrProfileInitialize() function was neither called nor successful
    \retval AMDT_ERROR_PROFILE_NOT_STARTED: Profile is not started
    \retval AMDT_ERROR_FAIL: An internal error occurred
*/
extern AMDTResult AMDTPwrStopProfiling();

/** This API will pause the profiling. The driver and the backend will retain the profile configuration
    details provided by the client.

    \ingroup profiling
    \return The status of pausing the profile
    \retval AMDT_STATUS_OK: On Success
    \retval AMDT_ERROR_FAIL: An internal error occurred
    \retval AMDT_ERROR_DRIVER_UNINITIALIZED: \ref AMDTPwrProfileInitialize() function was neither
            called nor successful
    \retval AMDT_ERROR_PROFILE_NOT_STARTED: Profile not started
*/
extern AMDTResult AMDTPwrPauseProfiling();

/** This API will resume the profiling which is in paused state.

    \ingroup profiling
    \return The status of resuming the profile
    \retval AMDT_STATUS_OK: On Success
    \retval AMDT_ERROR_FAIL: An internal error occurred
    \retval AMDT_ERROR_DRIVER_UNINITIALIZED: \ref AMDTPwrProfileInitialize() function was neither called nor successful
    \retval AMDT_ERROR_PROFILE_NOT_PAUSED: Profile is not in paused state
*/
extern AMDTResult AMDTPwrResumeProfiling();

/** This API provides the current state of the profile.

    \ingroup profiling
    @param[out] pState Current profile state
    \return The status of getting the profile state
    \retval AMDT_STATUS_OK: On Success
    \retval AMDT_ERROR_FAIL: An internal error occurred
    \retval AMDT_ERROR_INVALIDARG: NULL pointer was passed as pState parameter
*/
extern AMDTResult  AMDTPwrGetProfilingState(AMDTPwrProfileState* pState);

/** This API will close the power profiler and unregister driver and cleanup all memory allocated
    during AMDTPwrProfileInitialize().

    \ingroup profiling
    \return The status of closing the profiler
    \retval AMDT_STATUS_OK: On Success
    \retval AMDT_ERROR_FAIL: An internal error occurred
    \retval AMDT_ERROR_DRIVER_UNINITIALIZED: \ref AMDTPwrProfileInitialize() function was neither called nor successful
*/
extern AMDTResult AMDTPwrProfileClose();

/** API to set the sample value options to be returned by the \ref AMDTPwrReadAllEnabledCounters() function.

    \ingroup profiling
    @param[in] opt: One of the output value options defined in AMDTSampleValueOption
    \return The status of setting the output value option
    \retval AMDT_STATUS_OK: On Success
    \retval AMDT_ERROR_FAIL: An internal error occurred
    \retval AMDT_ERROR_INVALIDARG: An invalid opt was specified as parameter
    \retval AMDT_ERROR_DRIVER_UNINITIALIZED: \ref AMDTPwrProfileInitialize() function was neither called nor successful
    \retval AMDT_ERROR_PROFILE_ALREADY_STARTED: Cannot set the sample value option when the profile is running
*/
extern AMDTResult AMDTPwrSetSampleValueOption(AMDTSampleValueOption opt);

/** API to get the sample value option set for the current profile session.

    \ingroup profiling
    @param[out] pOpt: One of the output value options defined in AMDTSampleValueOption
    \return The status of setting the output value option
    \retval AMDT_STATUS_OK: On Success
    \retval AMDT_ERROR_FAIL: An internal error occurred
    \retval AMDT_ERROR_INVALIDARG: An invalid opt was specified as parameter
    \retval AMDT_ERROR_DRIVER_UNINITIALIZED: \ref AMDTPwrProfileInitialize() function was neither called nor successful
*/
extern AMDTResult AMDTPwrGetSampleValueOption(AMDTSampleValueOption* pOpt);

/** API to read all the counters that are enabled. This will NOT read the histogram counters.
    This can return an array of {CounterID, Float-Value}. If there are no new samples, this API will
    return AMDTResult NO_NEW_DATA and pNumOfSamples will point to value of zero. If there
    are new samples, this API will return AMDT_STATUS_OK and pNumOfSamples will point
    to value greater than zero.

    \ingroup profiling
    @param[out] ppData: Processed profile data. No need to allocate or free the memory data is valid till we call this API next time
    @param[out] pNumOfSamples: Number of sample based on the AMDTPwrSetSampleValueOption() set
    \return The status reading all enabled counters
    \retval AMDT_STATUS_OK: On Success
    \retval AMDT_ERROR_INVALIDARG: NULL pointer was passed as pNumSamples or ppData parameters
    \retval AMDT_ERROR_DRIVER_UNINITIALIZED: \ref AMDTPwrProfileInitialize() function was neither called nor successful
    \retval AMDT_ERROR_PROFILE_NOT_STARTED: Profile is not started
    \retval AMDT_ERROR_PROFILE_DATA_NOT_AVAILABLE: Profile data is not yet available
    \retval AMDT_ERROR_OUTOFMEMORY: Memory not available
    \retval AMDT_ERROR_SMU_ACCESS_FAILED: One of the configured SMU data access has problem it is advisable to stop the profiling session
    \retval AMDT_ERROR_FAIL: An internal error occurred
*/
extern AMDTResult AMDTPwrReadAllEnabledCounters(AMDTUInt32* pNumOfSamples,
                                                AMDTPwrSample** ppData);

/** API to read one of the derived counters generate histograms from the raw counter values.
    Since the histogram may contain multiple entries and according to the counter values, a derived
    histogram counter type specific will be used to provide the output data.

    \ingroup profiling
    @param[in] counterId: Histogram type counter id
    @param[out] pNumEntries: Number of entries in the histogram
    @param[out] ppData: Compute histogram data for the given counter id
    \return The status of reading histogram data
    \retval AMDT_STATUS_OK: On Success
    \retval AMDT_ERROR_INVALIDARG: NULL pointer was passed as pNumEntries or ppData parameters
    \retval AMDT_ERROR_DRIVER_UNINITIALIZED: \ref AMDTPwrProfileInitialize() function was neither called nor successful
    \retval AMDT_ERROR_INVALID_COUNTERID: An invalid counterId was passed
    \retval AMDT_ERROR_PROFILE_NOT_STARTED: Profile is not started
    \retval AMDT_ERROR_PROFILE_DATA_NOT_AVAILABLE: Profile data is not yet available
    \retval AMDT_ERROR_OUTOFMEMORY: Memory not available
    \retval AMDT_ERROR_FAIL: An internal error occurred
*/
extern AMDTResult AMDTPwrReadCounterHistogram(AMDTUInt32 counterId,
                                              AMDTUInt32* pNumEntries,
                                              AMDTPwrHistogram** ppData);

//Helper functions

/** This API will get the timer sampling period at which the samples are collected by the driver.

    \ingroup profiling
    @param[out] pIntervalMilliSec: sampling period in millisecond
    \return The status of the get sampling interval request
    \retval AMDT_STATUS_OK: On Success
    \retval AMDT_ERROR_INVALIDARG: NULL pointer was passed as pIntervalMilliSec parameter
    \retval AMDT_ERROR_DRIVER_UNINITIALIZED: \ref AMDTPwrProfileInitialize() function was neither called nor successful
    \retval AMDT_ERROR_FAIL: An internal error occurred
*/
extern AMDTResult AMDTPwrGetTimerSamplingPeriod(AMDTUInt32* pIntervalMilliSec);

/** This query API is to check whether a counter is enabled for profiling or not.

    \ingroup profiling
    @param[in] counterId: Counter index
    \return The status of query request.
    \retval AMDT_STATUS_OK: On Success; Counter is enabled
    \retval AMDT_ERROR_DRIVER_UNINITIALIZED: \ref AMDTPwrProfileInitialize() function was neither called nor successful
    \retval AMDT_ERROR_INVALID_COUNTERID: An invalid counterId was passed
    \retval AMDT_ERROR_COUNTER_NOT_ENABLED: Counter is not enabled already
    \retval AMDT_ERROR_FAIL: An internal error occurred
*/
extern AMDTResult AMDTPwrIsCounterEnabled(AMDTUInt32 counterId);

/** This query API is to get the number of counters that are enabled for profiling.

    \ingroup profiling
    @param[out] pCount: Number of enabled counters
    \return The status of query request
    \retval AMDT_STATUS_OK: On Success; Counter is enabled
    \retval AMDT_ERROR_INVALIDARG: NULL pointer is passed as an argument
    \retval AMDT_ERROR_DRIVER_UNINITIALIZED: \ref AMDTPwrProfileInitialize() function was neither called nor successful
    \retval AMDT_ERROR_FAIL: An internal error occurred
*/
extern AMDTResult AMDTPwrGetNumEnabledCounters(AMDTUInt32* pCount);

/** API to get the list of pstate supported by the target APU, where power profile is running. List
    contains both hardware and software P-States with their corresponding frequencies.

    \ingroup profiling
    @param[out] pList: List of P-States
    \return The status reading the pstate list for the platform
    \retval AMDT_STATUS_OK: On Success
    \retval AMDT_ERROR_INVALIDARG: NULL pointer was passed as argument
    \retval AMDT_ERROR_DRIVER_UNINITIALIZED: AMDTPwrProfileInitialize() function was neither called nor successful
    \retval AMDT_ERROR_PLATFORM_NOT_SUPPORTED: Platform not supported
    \retval AMDT_ERROR_FAIL: An internal error occurred
*/
extern AMDTResult AMDTPwrGetApuPstateInfo(AMDTPwrApuPstateList* pList);

/** This API provides the relationship with other counters for the given counter id. For the given
    counter id, this API provides the parent counter and as well the child counters list.

    \ingroup profiling
    @param[in] counterId: The counter id for which the dependent counters information is requested
    @param[out] pInfo: Provides hierarchical relationship for the given counterId
    \return The status retrieving hierarchical information for the given counters
    \retval AMDT_STATUS_OK: On Success
    \retval AMDT_ERROR_INVALIDARG: NULL pointer was passed as argument
    \retval AMDT_ERROR_DRIVER_UNINITIALIZED: AMDTPwrProfileInitialize() function was neither called nor successful
    \retval AMDT_ERROR_INVALID_COUNTERID: Invalid counterId parameter was passed
    \retval AMDT_ERROR_COUNTER_NOHIERARCHY: Counter does not have any hierarchical relationship
    \retval AMDT_ERROR_FAIL: An internal error occurred
*/
extern AMDTResult AMDTPwrGetCounterHierarchy(AMDTUInt32 counterId,
                                             AMDTPwrCounterHierarchy* pInfo);

#endif //_AMDTPOWERPROFILEAPI_H_