for (( i = 1 ; i <= 34 ; i ++ ))
do
    for (( j = 0 ; j < 10 ; j ++ ))
    do
        ./arith_utilization -p 0 -d 0 -k Integer_addition_0_10 -t 0 -i 50000000 -g ${i} -l 1 >> execution_1_${i}.log
    done
done

sleep 30s

for (( i = 1, k = 2 ; i <= 34 ; i ++, k = k + 2 ))
do
    for (( j = 0 ; j < 10 ; j ++ ))
    do
        ./arith_utilization -p 0 -d 0 -k Integer_addition_0_10 -t 0 -i 50000000 -g ${k} -l 2 >> execution_2_${i}.log
    done
done

sleep 30s

for (( i = 1, k = 3 ; i <= 34 ; i ++, k = k + 3 ))
do
    for (( j = 0 ; j < 10 ; j ++ ))
    do
        ./arith_utilization -p 0 -d 0 -k Integer_addition_0_10 -t 0 -i 50000000 -g ${k} -l 3 >> execution_3_${i}.log
    done
done

sleep 30s

for (( i = 1, k = 4 ; i <= 34 ; i ++, k = k + 4 ))
do
    for (( j = 0 ; j < 10 ; j ++ ))
    do
        ./arith_utilization -p 0 -d 0 -k Integer_addition_0_10 -t 0 -i 50000000 -g ${k} -l 4 >> execution_4_${i}.log
    done
done
