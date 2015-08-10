iteration=$1;

./arith_utilization -p 1 -k Integer_addition_20_Double_addition_10_pattern_1 -i ${iteration} -g 1024 -l 128
./arith_utilization -p 1 -k Integer_addition_20_Double_addition_10_pattern_2 -i ${iteration} -g 1024 -l 128

./arith_utilization -p 1 -k Integer_addition_40_Double_addition_10_pattern_1 -i ${iteration} -g 1024 -l 128
./arith_utilization -p 1 -k Integer_addition_40_Double_addition_10_pattern_2 -i ${iteration} -g 1024 -l 128

./arith_utilization -p 1 -k Integer_addition_40_Double_addition_5_pattern_1 -i ${iteration} -g 1024 -l 128

./arith_utilization -p 1 -k Integer_multiplication_20_Double_multiplication_10_pattern_1 -i ${iteration} -g 1024 -l 128
./arith_utilization -p 1 -k Integer_multiplication_20_Double_multiplication_10_pattern_2 -i ${iteration} -g 1024 -l 128
