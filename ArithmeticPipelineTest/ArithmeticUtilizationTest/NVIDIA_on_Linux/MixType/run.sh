platform=$1
device=$2
testcase=$3
iteration=$4
global=$5
local=$6

for (( i = 1 ; i <= 10 ; i ++ ))
do
    ./arith_utilization -p ${platform} -d ${device} -k ${testcase} -i ${iteration} -g ${global} -l ${local} >> executionTime.log
done
