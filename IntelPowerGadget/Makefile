CFLAGS=-g

all: rapl_lib_shared rapl_lib_static PowerUsage_static
#all: rapl_lib_shared PowerUsage

rapl_lib_shared: 
	gcc $(CFLAGS) -fpic -c msr.c cpuid.c rapl.c -lm
	gcc $(CFLAGS) -shared -o librapl.so msr.o cpuid.o rapl.o

rapl_lib_static: 
	gcc $(CFLAGS) -c msr.c cpuid.c rapl.c -lm
	ar rcs librapl.a msr.o cpuid.o rapl.o

PowerUsage_static: 
	gcc $(CFLAGS) PowerUsage.c -I. -L. -o PowerUsage ./librapl.a -lm

PowerUsage: 
	gcc $(CFLAGS) PowerUsage.c -I. -L. -lrapl -lm -o PowerUsage 

gprof: CFLAGS = -pg
gprof: all
	./PowerUsage -e 100 -d 60 >/dev/null 2>&1
	gprof PowerUsage > PowerUsage.gprof
	rm -f gmon.out
	make clean

clean: 
	rm -f PowerUsage librapl.so librapl.a msr.o cpuid.o rapl.o 
