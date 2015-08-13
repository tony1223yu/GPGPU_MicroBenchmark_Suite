platform=$1;
device=$2;
testcase=$3
iteration=$4;
global=$5;
local=$6;

echo "${TEST_NAME}" | grep -q Integer
if [ $? == 0 ]; then
    TYPE=0;
else
    TYPE=1;
fi

for (( i = 1 ; i <= 10 ; i ++ ))
do
    ./arith_utilization -p ${platform} -d ${device} -t ${TYPE} -k ${testcase}_0_20 -i ${iteration} -g ${global} -l ${local} >> executionTime0.log
done

for (( i = 1 ; i <= 10 ; i ++ ))
do
    ./arith_utilization -p ${platform} -d ${device} -t ${TYPE} -k ${testcase}_5_20 -i ${iteration} -g ${global} -l ${local} >> executionTime5.log
done

for (( i = 1 ; i <= 10 ; i ++ ))
do
    ./arith_utilization -p ${platform} -d ${device} -t ${TYPE} -k ${testcase}_7_20 -i ${iteration} -g ${global} -l ${local} >> executionTime7.log
done

for (( i = 1 ; i <= 10 ; i ++ ))
do
    ./arith_utilization -p ${platform} -d ${device} -t ${TYPE} -k ${testcase}_10_20 -i ${iteration} -g ${global} -l ${local} >> executionTime10.log
done

for (( i = 1 ; i <= 10 ; i ++ ))
do
    ./arith_utilization -p ${platform} -d ${device} -t ${TYPE} -k ${testcase}_12_20 -i ${iteration} -g ${global} -l ${local} >> executionTime12.log
done

for (( i = 1 ; i <= 10 ; i ++ ))
do
    ./arith_utilization -p ${platform} -d ${device} -t ${TYPE} -k ${testcase}_15_20 -i ${iteration} -g ${global} -l ${local} >> executionTime15.log
done

for (( i = 1 ; i <= 10 ; i ++ ))
do
    ./arith_utilization -p ${platform} -d ${device} -t ${TYPE} -k ${testcase}_20_20 -i ${iteration} -g ${global} -l ${local} >> executionTime20.log
done
