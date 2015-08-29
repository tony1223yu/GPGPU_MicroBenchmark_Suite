for (( i = 1 ; i <= 34 ; i ++ ))
do
    for (( j = 0 ; j < 10 ; j ++ ))
    do
        ./arith_utilization -p 0 -d 0 -k Integer4_addition_0_10 -t 0 -i 100000000 -g ${i} -l ${i} >> int_execution_4_${i}.log
    done
done

sleep 30s

for (( i = 1 ; i <= 34 ; i ++ ))
do
    for (( j = 0 ; j < 10 ; j ++ ))
    do
        ./arith_utilization -p 0 -d 0 -k Integer4_addition_0_10_f -t 0 -i 100000000 -g ${i} -l ${i} >> int_execution_4_f_${i}.log
    done
done

for (( i = 1 ; i <= 34 ; i ++ ))
do
    for (( j = 0 ; j < 10 ; j ++ ))
    do
        ./arith_utilization -p 0 -d 0 -k Float_addition_0_10 -t 1 -i 5000000 -g ${i} -l ${i} >> float_execution_1_${i}.log
    done
done

sleep 30s

for (( i = 1 ; i <= 34 ; i ++ ))
do
    for (( j = 0 ; j < 10 ; j ++ ))
    do
        ./arith_utilization -p 0 -d 0 -k Float2_addition_0_10 -t 1 -i 5000000 -g ${i} -l ${i} >> float_execution_2_${i}.log
    done
done

sleep 30s

for (( i = 1 ; i <= 34 ; i ++ ))
do
    for (( j = 0 ; j < 10 ; j ++ ))
    do
        ./arith_utilization -p 0 -d 0 -k Float4_addition_0_10 -t 1 -i 5000000 -g ${i} -l ${i} >> float_execution_4_${i}.log
    done
done
