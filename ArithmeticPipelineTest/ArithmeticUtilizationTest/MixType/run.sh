platform=$1;
device=$2;
iteration=$3;

./arith_utilization -p ${platform} -d ${device} -t 0 -k Integer_addition_0_20 -i ${iteration} -g 1024 -l 128
./arith_utilization -p ${platform} -d ${device} -t 0 -k Integer_addition_5_20 -i ${iteration} -g 1024 -l 128
./arith_utilization -p ${platform} -d ${device} -t 0 -k Integer_addition_7_20 -i ${iteration} -g 1024 -l 128
./arith_utilization -p ${platform} -d ${device} -t 0 -k Integer_addition_10_20 -i ${iteration} -g 1024 -l 128
./arith_utilization -p ${platform} -d ${device} -t 0 -k Integer_addition_12_20 -i ${iteration} -g 1024 -l 128
./arith_utilization -p ${platform} -d ${device} -t 0 -k Integer_addition_15_20 -i ${iteration} -g 1024 -l 128
./arith_utilization -p ${platform} -d ${device} -t 0 -k Integer_addition_20_20 -i ${iteration} -g 1024 -l 128

./arith_utilization -p ${platform} -d ${device} -t 0 -k Integer_multiplication_0_20 -i ${iteration} -g 1024 -l 128
./arith_utilization -p ${platform} -d ${device} -t 0 -k Integer_multiplication_5_20 -i ${iteration} -g 1024 -l 128
./arith_utilization -p ${platform} -d ${device} -t 0 -k Integer_multiplication_7_20 -i ${iteration} -g 1024 -l 128
./arith_utilization -p ${platform} -d ${device} -t 0 -k Integer_multiplication_10_20 -i ${iteration} -g 1024 -l 128
./arith_utilization -p ${platform} -d ${device} -t 0 -k Integer_multiplication_12_20 -i ${iteration} -g 1024 -l 128
./arith_utilization -p ${platform} -d ${device} -t 0 -k Integer_multiplication_15_20 -i ${iteration} -g 1024 -l 128
./arith_utilization -p ${platform} -d ${device} -t 0 -k Integer_multiplication_20_20 -i ${iteration} -g 1024 -l 128

./arith_utilization -p ${platform} -d ${device} -t 1 -k Double_addition_0_20 -i ${iteration} -g 1024 -l 128
./arith_utilization -p ${platform} -d ${device} -t 1 -k Double_addition_5_20 -i ${iteration} -g 1024 -l 128
./arith_utilization -p ${platform} -d ${device} -t 1 -k Double_addition_7_20 -i ${iteration} -g 1024 -l 128
./arith_utilization -p ${platform} -d ${device} -t 1 -k Double_addition_10_20 -i ${iteration} -g 1024 -l 128
./arith_utilization -p ${platform} -d ${device} -t 1 -k Double_addition_12_20 -i ${iteration} -g 1024 -l 128
./arith_utilization -p ${platform} -d ${device} -t 1 -k Double_addition_15_20 -i ${iteration} -g 1024 -l 128
./arith_utilization -p ${platform} -d ${device} -t 1 -k Double_addition_20_20 -i ${iteration} -g 1024 -l 128

./arith_utilization -p ${platform} -d ${device} -t 1 -k Double_multiplication_0_20 -i ${iteration} -g 1024 -l 128
./arith_utilization -p ${platform} -d ${device} -t 1 -k Double_multiplication_5_20 -i ${iteration} -g 1024 -l 128
./arith_utilization -p ${platform} -d ${device} -t 1 -k Double_multiplication_7_20 -i ${iteration} -g 1024 -l 128
./arith_utilization -p ${platform} -d ${device} -t 1 -k Double_multiplication_10_20 -i ${iteration} -g 1024 -l 128
./arith_utilization -p ${platform} -d ${device} -t 1 -k Double_multiplication_12_20 -i ${iteration} -g 1024 -l 128
./arith_utilization -p ${platform} -d ${device} -t 1 -k Double_multiplication_15_20 -i ${iteration} -g 1024 -l 128
./arith_utilization -p ${platform} -d ${device} -t 1 -k Double_multiplication_20_20 -i ${iteration} -g 1024 -l 128
