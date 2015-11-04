PAPI_SRC_DIR = /home/tony/papi-5.4.1/src

all:
	/usr/local/cuda-6.5/bin/nvcc 2_Normal.cu -I ${PAPI_SRC_DIR} -I ${PAPI_SRC_DIR}/testlib -I /usr/local/cuda-6.5/include -I /usr/local/cuda-6.5/extras/CUPTI/include -L ${PAPI_SRC_DIR}/testlib -lpapi -ltestlib -o Normal

clean:
	rm Normal
