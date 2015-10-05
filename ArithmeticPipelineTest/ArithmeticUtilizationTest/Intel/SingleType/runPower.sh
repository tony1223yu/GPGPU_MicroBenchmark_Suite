POWER_DIR=../../../../IntelPowerGadget
TEST_NAME=$1
TRACE_TIME=$2
ITERATION=$3
TYPE=$4
PREFIX=$5

${POWER_DIR}/PowerUsage -t 100 -T ${TRACE_TIME} -o ${POWER_DIR}'/'${PREFIX}'_PowerUsageOutput.log' &

# warm up temperature
for (( i = 1 ; i <= 2 ; i ++ ))
do
    ./arith_utilization -p 0 -d 0 -t 0 -k Integer_addition_0_10 -i 20000000000 -g 4 -l 1
done

for (( i = 1 ; i <= 5 ; i ++ ))
do
    ./arith_utilization -p 0 -d 0 -t ${TYPE} -k Float8_addition_0_10 -i 400000000 -o ${POWER_DIR}'/'${PREFIX}'_0_10_full_KernelExecution'${i}'.log' -g 4 -l 1 >> ${POWER_DIR}'/'${PREFIX}'_0_10_full_ExecutionTime.log'
done

for (( i = 1 ; i <= 5 ; i ++ ))
do
    ./arith_utilization -p 0 -d 0 -t ${TYPE} -k Float8_addition_2_10 -i 400000000 -o ${POWER_DIR}'/'${PREFIX}'_2_10_full_KernelExecution'${i}'.log' -g 4 -l 1 >> ${POWER_DIR}'/'${PREFIX}'_2_10_full_ExecutionTime.log'
done

for (( i = 1 ; i <= 5 ; i ++ ))
do
    ./arith_utilization -p 0 -d 0 -t ${TYPE} -k Float8_addition_5_10 -i 400000000 -o ${POWER_DIR}'/'${PREFIX}'_5_10_full_KernelExecution'${i}'.log' -g 4 -l 1 >> ${POWER_DIR}'/'${PREFIX}'_5_10_full_ExecutionTime.log'
done

for (( i = 1 ; i <= 5 ; i ++ ))
do
    ./arith_utilization -p 0 -d 0 -t ${TYPE} -k Float8_addition_7_10 -i 400000000 -o ${POWER_DIR}'/'${PREFIX}'_7_10_full_KernelExecution'${i}'.log' -g 4 -l 1 >> ${POWER_DIR}'/'${PREFIX}'_7_10_full_ExecutionTime.log'
done

for (( i = 1 ; i <= 5 ; i ++ ))
do
    ./arith_utilization -p 0 -d 0 -t ${TYPE} -k Float8_addition_10_10 -i 400000000 -o ${POWER_DIR}'/'${PREFIX}'_10_10_full_KernelExecution'${i}'.log' -g 4 -l 1 >> ${POWER_DIR}'/'${PREFIX}'_10_10_full_ExecutionTime.log'
done
