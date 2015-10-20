sleep 10s
for (( i = 1, WGCount = 1 ; i <= 40 ; i ++, WGCount = WGCount + 8 ))
do
    for (( j = 0 ; j < 10 ; j ++ ))
    do
        ./arith_utilization_source -p 0 -d 0 -k Integer_addition_10_10 -t 0 -i 10000000 -g ${WGCount} -l 1 >> phy_execution_${i}.log
        sleep 1s
    done
done

for (( i = 1, WGCount = 5 ; i <= 40 ; i ++, WGCount = WGCount + 8 ))
do
    for (( j = 0 ; j < 10 ; j ++ ))
    do
        ./arith_utilization_source -p 0 -d 0 -k Integer_addition_10_10 -t 0 -i 100000000 -g ${WGCount} -l 1 >> hyp1_execution_${i}.log
        sleep 1s
    done
done

for (( i = 1, WGCount = 6 ; i <= 40 ; i ++, WGCount = WGCount + 8 ))
do
    for (( j = 0 ; j < 10 ; j ++ ))
    do
        ./arith_utilization_source -p 0 -d 0 -k Integer_addition_10_10 -t 0 -i 100000000 -g ${WGCount} -l 1 >> hyp2_execution_${i}.log
        sleep 1s
    done
done

for (( i = 1, WGCount = 7 ; i <= 40 ; i ++, WGCount = WGCount + 8 ))
do
    for (( j = 0 ; j < 10 ; j ++ ))
    do
        ./arith_utilization_source -p 0 -d 0 -k Integer_addition_10_10 -t 0 -i 100000000 -g ${WGCount} -l 1 >> hyp3_execution_${i}.log
        sleep 1s
    done
done

for (( i = 1, WGCount = 8 ; i <= 40 ; i ++, WGCount = WGCount + 8 ))
do
    for (( j = 0 ; j < 10 ; j ++ ))
    do
        ./arith_utilization_source -p 0 -d 0 -k Integer_addition_10_10 -t 0 -i 100000000 -g ${WGCount} -l 1 >> hyp4_execution_${i}.log
        sleep 1s
    done
done
