DEVICE=$1
PREFIX=$2

./cacheHierarchyTest -p 0 -d ${DEVICE} -s 1 -i 50000 -S 10240000
./cacheHierarchyTest -p 0 -d ${DEVICE} -s 1 -i 50000 -S 10240000


# 61440 to 71680
for (( i = 0, j = 66560 ; i <= 1024 ; i ++, j ++ ))
do
    for (( k = 0 ; k < 10 ; k ++ ))
    do
        ./cacheHierarchyTest -p 0 -d ${DEVICE} -s 1 -i 50000 -S ${j} >> ${PREFIX}'_ExecutionTime.log'
    done
done
