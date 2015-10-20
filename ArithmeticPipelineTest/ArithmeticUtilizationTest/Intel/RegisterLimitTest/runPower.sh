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
    ./arith_utilization -p 0 -d 0 -k Integer_addition_20_full -i 4000000000 -g 4 -l 1
done

for (( i = 1 ; i <= 20 ; i ++ ))
do
    ./arith_utilization -p 0 -d 0 -i 4000000000 -t 0 -k Integer_addition_${i}_full -o ${POWER_DIR}'/'${PREFIX}'_full_KernelExecution'${i}'.log' -g 4 -l 1 >> ${POWER_DIR}'/'${PREFIX}'_full_ExecutionTime.log'
done

for (( i = 1 ; i <= 20 ; i ++ ))
do
    ./arith_utilization -p 0 -d 0 -i 4000000000 -t 0 -k Integer_addition_${i}_no -o ${POWER_DIR}'/'${PREFIX}'_no_KernelExecution'${i}'.log' -g 4 -l 1 >> ${POWER_DIR}'/'${PREFIX}'_no_ExecutionTime.log'
done
