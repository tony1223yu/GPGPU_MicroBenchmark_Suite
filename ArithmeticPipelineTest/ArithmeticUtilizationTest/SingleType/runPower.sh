NVML_DIR=../../../NVML
TEST_NAME=$1
TRACE_TIME=$2
PLATFORM=$3
DEVICE=$4
ITERATION=$5
GLOBAL_SIZE=$6
LOCAL_SIZE=$7

echo "${TEST_NAME}" | grep -q Integer
if [ $? == 0 ]; then
    TYPE=0;
else
    TYPE=1;
fi

${NVML_DIR}/PowerUsage -t 5 -T ${TRACE_TIME} -D ${DEVICE} -o ${NVML_DIR}'/PowerUsageOutput.log' &
for (( i = 0 ; i < 10 ; i ++ ))
do
    sleep 5s
    ./arith_utilization -p ${PLATFORM} -d ${DEVICE} -t ${TYPE} -k ${TEST_NAME} -i ${ITERATION} -o ${NVML_DIR}'/KernelExecution'${i}'.log' -g ${GLOBAL_SIZE} -l ${LOCAL_SIZE}
done
