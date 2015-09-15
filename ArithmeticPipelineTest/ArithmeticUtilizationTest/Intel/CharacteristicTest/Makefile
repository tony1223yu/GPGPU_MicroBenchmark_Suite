include ../../../../common/make.config

all:
	g++ arith_utilization_source.cpp ${OPENCL_LIB} -o arith_utilization_source
	g++ arith_utilization_binary.cpp ${OPENCL_LIB} -o arith_utilization_binary

clean:
	rm arith_utilization_source arith_utilization_binary
