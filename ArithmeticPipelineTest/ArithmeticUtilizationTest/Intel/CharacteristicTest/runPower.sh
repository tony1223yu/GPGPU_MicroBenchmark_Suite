POWER_DIR=../../../../IntelPowerGadget
TEST_NAME=$1
TRACE_TIME=$2
ITERATION=$3
TYPE=$4
PREFIX=$5

${POWER_DIR}/PowerUsage -t 100 -T ${TRACE_TIME} -o ${POWER_DIR}'/'${PREFIX}'_PowerUsageOutput.log' &

# warm up temperature
for (( i = 1 ; i <= 3 ; i ++ ))
do
    ./arith_utilization_source -p 0 -d 0 -t 0 -k Integer_addition_0_10 -i 20000000000 -g 4 -l 1
done

for (( i = 1, j = 16 ; i <= 40 ; i ++, j = j + 32 ))
do
    ./arith_utilization_source -p 0 -d 0 -t ${TYPE} -k Integer_addition_0_10 -i 1000000000 -o ${POWER_DIR}'/'${PREFIX}'_no_KernelExecution'${i}'.log' -g ${j} -l 4 >> ${POWER_DIR}'/'${PREFIX}'_no_ExecutionTime.log'
done

for (( i = 1, j = 16 ; i <= 40 ; i ++, j = j + 32 ))
do
    ./arith_utilization_source -p 0 -d 0 -t ${TYPE} -k Integer_addition_10_10 -i 500000000 -o ${POWER_DIR}'/'${PREFIX}'_full_KernelExecution'${i}'.log' -g ${j} -l 4 >> ${POWER_DIR}'/'${PREFIX}'_full_ExecutionTime.log'
done
