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
    ./arith_utilization -p 0 -d 0 -k IA2_10_FA_5 -i 80000000 -g 4 -l 1
done

#for (( i = 0 ; i < 10 ; i ++ ))
#do
    #./arith_utilization -p 0 -d 0 -i 80000000 -k IA2_10_FA_5 -o ${POWER_DIR}'/'${PREFIX}'_KernelExecution'${i}'.log' -g 4 -l 1 >> ${POWER_DIR}'/'${PREFIX}'_ExecutionTime.log'
    #./arith_utilization -p 0 -d 0 -i 80000000 -k IA_10_FA2_5 -o ${POWER_DIR}'/'${PREFIX}'_KernelExecution'${i}'.log' -g 4 -l 1 >> ${POWER_DIR}'/'${PREFIX}'_ExecutionTime.log'
    #./arith_utilization -p 0 -d 0 -i 60000000 -k IA_10_FA_5_DA_5 -o ${POWER_DIR}'/'${PREFIX}'_KernelExecution'${i}'.log' -g 4 -l 1 >> ${POWER_DIR}'/'${PREFIX}'_ExecutionTime.log'
    #./arith_utilization -p 0 -d 0 -i 40000000 -k FA_10_DA2_5 -o ${POWER_DIR}'/'${PREFIX}'_KernelExecution'${i}'.log' -g 4 -l 1 >> ${POWER_DIR}'/'${PREFIX}'_ExecutionTime.log'
    #./arith_utilization -p 0 -d 0 -i 120000000 -k IA4_15_FA4_5 -o ${POWER_DIR}'/'${PREFIX}'_KernelExecution'${i}'.log' -g 4 -l 1 >> ${POWER_DIR}'/'${PREFIX}'_ExecutionTime.log'
    #./arith_utilization -p 0 -d 0 -i 90000000 -k IA4_5_DA_5 -o ${POWER_DIR}'/'${PREFIX}'_KernelExecution'${i}'.log' -g 4 -l 1 >> ${POWER_DIR}'/'${PREFIX}'_ExecutionTime.log'
    #./arith_utilization -p 0 -d 0 -i 300000000 -k IA_25_DA_5 -o ${POWER_DIR}'/'${PREFIX}'_KernelExecution'${i}'.log' -g 4 -l 1 >> ${POWER_DIR}'/'${PREFIX}'_ExecutionTime.log'
#done


for (( x = 1 ; x <= 8 ; x ++ ))
do
    for (( i = 0 ; i < 10 ; i ++ ))
    do
        ./arith_utilization -p 0 -d 0 -i 300000000 -k IA_25_DA_5 -o ${POWER_DIR}'/'${PREFIX}'_KernelExecution'${x}'_'${i}'.log' -g ${x} -l 1 >> ${POWER_DIR}'/'${PREFIX}'_ExecutionTime'${x}'.log'
    done
done
