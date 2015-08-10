NVML_DIR=../../../NVML
TEST_NAME=$1
ITERATION=$2
TRACE_TIME=$3
GLOBAL_SIZE=$4
LOCAL_SIZE=$5

${NVML_DIR}/PowerUsage -t 5 -T ${TRACE_TIME} -o ${NVML_DIR}'/PowerUsageOutput.log' &
sleep 4s
./arith_utilization -p 1 -k ${TEST_NAME} -i ${ITERATION} -o ${NVML_DIR}'/KernelExecution.log' -g ${GLOBAL_SIZE} -l ${LOCAL_SIZE}
