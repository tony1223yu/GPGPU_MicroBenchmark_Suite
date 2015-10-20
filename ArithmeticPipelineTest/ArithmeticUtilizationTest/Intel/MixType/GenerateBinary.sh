/System/Library/Frameworks/OpenCL.framework/Libraries/openclc -arch x86_64 -emit-llvm-bc arith_utilization.cl -o arith_utilization.ptx # for OS X
/opt/intel/opencl-1.2-sdk-4.6.0.178/bin/ioc64 -input=arith_utilization.cl -ir=arith_utilization.bin -device=cpu -simd=avx2  # for Linux
