NVML_DIR=../../NVML
TRACE_TIME=$1
DEVICE=$2
PREFIX=$3

${NVML_DIR}/PowerUsage -t 50 -T ${TRACE_TIME} -D ${DEVICE} -o ${NVML_DIR}'/'${PREFIX}'_PowerUsageOutput.log' &

sleep 5s
./cacheHierarchyTest -p 0 -d ${DEVICE} -s 1 -i 50000 -S 10240000
./cacheHierarchyTest -p 0 -d ${DEVICE} -s 1 -i 50000 -S 10240000


# 61440 to 71680
for (( i = 1, j = 61440 ; i <= 10240 ; i ++, j ++ ))
do
    ./cacheHierarchyTest -p 0 -d ${DEVICE} -s 1 -i 50000 -S ${j} -o ${NVML_DIR}'/'${PREFIX}'_1_KernelExecution_'${i}'.log' >> ${NVML_DIR}'/'${PREFIX}'_1_ExecutionTime_'${i}'.log'
done
