NVML_DIR=../../../NVML
TEST_NAME=$1
TRACE_TIME=$2
PLATFORM=$3
DEVICE=$4
ITERATION=$5
TYPE=$6
GLOBAL_SIZE=$7
LOCAL_SIZE=$8

${NVML_DIR}/PowerUsage -t 10 -T ${TRACE_TIME} -D ${DEVICE} -o ${NVML_DIR}'/PowerUsageOutput.log' &
for (( i = 0 ; i < 20 ; i ++ ))
do
    sleep 5s
    ./arith_utilization -p ${PLATFORM} -d ${DEVICE} -t ${TYPE} -k ${TEST_NAME} -i ${ITERATION} -o ${NVML_DIR}'/KernelExecution'${i}'.log' -g ${GLOBAL_SIZE} -l ${LOCAL_SIZE}
done
