PAPI_SRC_DIR=/home/tony/GPGPU_MicroBenchmark_Suite/PAPI/papi-5.4.1/src
PAPI_WRAPPER_DIR=/home/tony/GPGPU_MicroBenchmark_Suite/PAPI

all:
	/usr/local/cuda-6.5/bin/nvcc cacheHierarchyTest.cu -I ${PAPI_SRC_DIR} -I ${PAPI_SRC_DIR}/testlib -I ${PAPI_WRAPPER_DIR} -I /usr/local/cuda-6.5/include -I /usr/local/cuda-6.5/extras/CUPTI/include -L ${PAPI_SRC_DIR}/testlib -lpapi -ltestlib -o cacheHierarchyTest
	/usr/local/cuda-6.5/bin/nvcc InFlightAccessTest.cu -I ${PAPI_SRC_DIR} -I ${PAPI_SRC_DIR}/testlib -I ${PAPI_WRAPPER_DIR} -I /usr/local/cuda-6.5/include -I /usr/local/cuda-6.5/extras/CUPTI/include -L ${PAPI_SRC_DIR}/testlib -lpapi -ltestlib -o InFlightAccessTest
clean:
	rm cacheHierarchyTest InFlightAccessTest
