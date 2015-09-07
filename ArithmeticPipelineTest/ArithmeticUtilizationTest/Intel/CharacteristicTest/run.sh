for (( i = 1 ; i <= 34 ; i ++ ))
do
    for (( j = 0 ; j < 10 ; j ++ ))
    do
        ./arith_utilization -p 0 -d 0 -k Double_addition_0_10 -t 2 -i 20000000 -g ${i} -l ${i} >> double_execution_${i}.log
    done
done

sleep 30s

for (( i = 1 ; i <= 34 ; i ++ ))
do
    for (( j = 0 ; j < 10 ; j ++ ))
    do
        ./arith_utilization -p 0 -d 0 -k Double2_addition_0_10 -t 2 -i 20000000 -g ${i} -l ${i} >> double2_execution_${i}.log
    done
done

sleep 30s

for (( i = 1 ; i <= 34 ; i ++ ))
do
    for (( j = 0 ; j < 10 ; j ++ ))
    do
        ./arith_utilization -p 0 -d 0 -k Double4_addition_0_10 -t 2 -i 20000000 -g ${i} -l ${i} >> double4_execution_${i}.log
    done
done

sleep 30s

for (( i = 1 ; i <= 34 ; i ++ ))
do
    for (( j = 0 ; j < 10 ; j ++ ))
    do
        ./arith_utilization -p 0 -d 0 -k Double8_addition_0_10 -t 2 -i 20000000 -g ${i} -l ${i} >> double8_execution_${i}.log
    done
done