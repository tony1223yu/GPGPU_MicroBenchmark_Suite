NVML_DIR=../../NVML
TRACE_TIME=$1
DEVICE=$2
PREFIX=$3

${NVML_DIR}/PowerUsage -t 50 -T ${TRACE_TIME} -D ${DEVICE} -o ${NVML_DIR}'/'${PREFIX}'_PowerUsageOutput.log' &

sleep 5s
./cacheHierarchyTest -p 0 -d ${DEVICE} -s 1 -i 50000 -S 10240000
./cacheHierarchyTest -p 0 -d ${DEVICE} -s 1 -i 50000 -S 10240000


# 61440 to 71680
for (( i = 10, j = 10240 ; i < 100 ; i ++, j += 1024 ))
do
    for (( k = 0 ; k < 5 ; k ++ ))
    do
        ./cacheHierarchyTest -p 0 -d ${DEVICE} -s 1 -i 50000 -S ${j} -o ${NVML_DIR}'/'${PREFIX}'_1_KernelExecution_'${i}'_'${k}'.log' >> ${NVML_DIR}'/'${PREFIX}'_1_ExecutionTime_'${i}'.log'
    done
done

sleep 5s
for (( i = 10, j = 5120 ; i < 100 ; i ++, j += 512 ))
do
    for (( k = 0 ; k < 5 ; k ++ ))
    do
        ./cacheHierarchyTest -p 0 -d ${DEVICE} -s 2 -i 50000 -S ${j} -o ${NVML_DIR}'/'${PREFIX}'_2_KernelExecution_'${i}'_'${k}'.log' >> ${NVML_DIR}'/'${PREFIX}'_2_ExecutionTime_'${i}'.log'
    done
done

sleep 5s
for (( i = 10, j = 2560 ; i < 100 ; i ++, j += 256 ))
do
    for (( k = 0 ; k < 5 ; k ++ ))
    do
        ./cacheHierarchyTest -p 0 -d ${DEVICE} -s 4 -i 50000 -S ${j} -o ${NVML_DIR}'/'${PREFIX}'_4_KernelExecution_'${i}'_'${k}'.log' >> ${NVML_DIR}'/'${PREFIX}'_4_ExecutionTime_'${i}'.log'
    done
done

sleep 5s
for (( i = 10, j = 1280 ; i < 100 ; i ++, j += 128 ))
do
    for (( k = 0 ; k < 5 ; k ++ ))
    do
        ./cacheHierarchyTest -p 0 -d ${DEVICE} -s 8 -i 50000 -S ${j} -o ${NVML_DIR}'/'${PREFIX}'_8_KernelExecution_'${i}'_'${k}'.log' >> ${NVML_DIR}'/'${PREFIX}'_8_ExecutionTime_'${i}'.log'
    done
done

sleep 5s
for (( i = 10, j = 640 ; i < 100 ; i ++, j += 64 ))
do
    for (( k = 0 ; k < 5 ; k ++ ))
    do
        ./cacheHierarchyTest -p 0 -d ${DEVICE} -s 16 -i 50000 -S ${j} -o ${NVML_DIR}'/'${PREFIX}'_16_KernelExecution_'${i}'_'${k}'.log' >> ${NVML_DIR}'/'${PREFIX}'_16_ExecutionTime_'${i}'.log'
    done
done
