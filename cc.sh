#!/bin/bash
echo $PATH
PATH=/opt/cross-pi-gcc/bin/:$PATH
echo $PATH
which arm-linux-gnueabihf-gcc
echo
cd test-cross-compiler
rm -f *.o gfortranhw
export CC=/opt/cross-pi-gcc/bin/arm-linux-gnueabihf-gcc
echo 'current value of $CC'
echo $CC
arm-linux-gnueabihf-gcc -c lifting.c
arm-linux-gnueabihf-gcc lifting.o pi_jpeg.c -o pi_jpeg
file pi_jpeg

$CC -c lifting.c
$CC lifting.o pi_jpeg.c -o pi_jpeg
file pi_jpeg
#note when the c++17 examples programs are cross compiled  
#The following 2 programs need on the RPi3B 
#< export PATH=/opt/gcc-9.1.0/bin:$PATH
#< export LD_LIBRARY_PATH=/opt/gcc-9.1.0/lib:$LD_LIBRARY_PATH
#links in /usr/include & /usr/lib
#and the gcc-9.1.0-armhf-raspbian.tar.tjz extracted in /opt
unset CC
export CC=/opt/cross-pi-gcc/bin/arm-linux-gnueabihf-g++
echo 'current value of $CC'
echo $CC  
arm-linux-gnueabihf-g++ -std=c++17 -Wall -pedantic if_test.cpp -o if_test
file if_test 

arm-linux-gnueabihf-g++ -std=c++17 -Wall -pedantic fs_test.cpp -o fs_test
file fs_test 

$CC -std=c++17 -Wall -pedantic if_test.cpp -o if_test
file if_test 

$CC -std=c++17 -Wall -pedantic fs_test.cpp -o fs_test
file fs_test 
arm-linux-gnueabihf-gfortran helloworld.f -o gfortranhw
file gfortranhw

unset CC
export CC=/opt/cross-pi-gcc/bin/arm-linux-gnueabihf-gfortran
echo 'current value of $CC'
echo $CC
$CC helloworld.f -o gfortranhw

