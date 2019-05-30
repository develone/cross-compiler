#/bin/bash
rm -f *.o pi_jpeg.txt 
arm-linux-gnueabihf-gcc -I/opt/cross-pi-gcc/include -g -c lifting.c -o lifting.o
arm-linux-gnueabihf-gcc -I/opt/cross-pi-gcc/include -g -c pi_jpeg.c -o pi_jpeg.o
arm-linux-gnueabihf-gcc -I/opt/cross-pi-gcc/include -g pi_jpeg.o lifting.o -o pi_jpeg
arm-linux-gnueabihf-objdump -d pi_jpeg > pi_jpeg.txt
