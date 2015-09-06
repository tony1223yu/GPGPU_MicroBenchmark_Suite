mac:
	g++ arith_utilization_source.cpp -framework OpenCL -o arith_utilization_source
	g++ arith_utilization_binary.cpp -framework OpenCL -o arith_utilization_binary

linux:
	g++ arith_utilization_source.cpp -I /usr/local/cuda-6.5/include -lOpenCL -o arith_utilization_source
	g++ arith_utilization_binary.cpp -I /usr/local/cuda-6.5/include -lOpenCL -o arith_utilization_binary



clean:
	rm arith_utilization_source arith_utilization_binary
