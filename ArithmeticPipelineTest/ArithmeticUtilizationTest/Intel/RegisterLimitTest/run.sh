for (( i = 1 ; i <= 20 ; i ++ ))
do
    for (( j = 1 ; j <= 20 ; j ++ ))
    do
        ./arith_utilization -p 0 -d 0 -k Integer_addition_${i}_no -t 0 -i 100000000 -g 1 -l 1 >> executionTime${i}.log
    done
done
