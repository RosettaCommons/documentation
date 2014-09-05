Compiling RosettaHoles on mac:

CPU=macgcc
NAMEFUL1=$(DIR)/$(NAME1).$(CPU)
FC = /usr/local/bin/gfortran-4.9
FFLAGS = -c -O3 -x f77-cpp-input -fsecond-underscore
CC = /usr/local/bin/gcc-4.9
LD = /usr/local/bin/gcc-4.9
CFLAGS = -c -O3
LDFLAGS = -O3
LIBRARIES= -lgmp  -lm -lgfortran
INCS= -I/usr/local/include
LIBS= -L/usr/local/lib