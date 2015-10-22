NVML_DIR=../../NVML
TRACE_TIME=$1
DEVICE=$2
PREFIX=$3

${NVML_DIR}/PowerUsage -t 50 -T ${TRACE_TIME} -D ${DEVICE} -o ${NVML_DIR}'/'${PREFIX}'_PowerUsageOutput.log' &

sleep 5s
./cacheHierarchyTest -p 0 -d ${DEVICE} -s 1 -i 50000 -S 10240000
./cacheHierarchyTest -p 0 -d ${DEVICE} -s 1 -i 50000 -S 10240000

#for (( i = 100, j = 102400 ; i <= 1000 ; i ++, j += 1024 ))
#do
#    for (( k = 0 ; k < 5 ; k ++ ))
#    do
#        ./cacheHierarchyTest -p 0 -d ${DEVICE} -s 1 -i 50000 -S ${j} -o ${NVML_DIR}'/'${PREFIX}'_KernelExecution_'${i}'_'${k}'.log' >> ${NVML_DIR}'/'${PREFIX}'_ExecutionTime_'${i}'.log'
#    done
#done

#for (( i = 100, j = 51200 ; i <= 1000 ; i ++, j += 512 ))
#do
#    for (( k = 0 ; k < 5 ; k ++ ))
#    do
#        ./cacheHierarchyTest -p 0 -d ${DEVICE} -s 2 -i 50000 -S ${j} -o ${NVML_DIR}'/'${PREFIX}'_KernelExecution_'${i}'_'${k}'.log' >> ${NVML_DIR}'/'${PREFIX}'_ExecutionTime_'${i}'.log'
#    done
#done

for (( i = 100, j = 25600 ; i <= 1000 ; i ++, j += 256 ))
do
    for (( k = 0 ; k < 5 ; k ++ ))
    do
        ./cacheHierarchyTest -p 0 -d ${DEVICE} -s 4 -i 50000 -S ${j} -o ${NVML_DIR}'/'${PREFIX}'_KernelExecution_'${i}'_'${k}'.log' >> ${NVML_DIR}'/'${PREFIX}'_ExecutionTime_'${i}'.log'
    done
done
