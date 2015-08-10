all:
	g++ -I /usr/src/gdk/nvml/include -I /usr/include/nvidia/gdk -c -o PowerUsage.o PowerUsage.cpp
	g++ PowerUsage.o -lnvidia-ml -L /usr/src/gdk/nvml/lib/ -o PowerUsage
	rm PowerUsage.o

clean:
	rm PowerUsage
