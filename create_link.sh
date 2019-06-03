#!/bin/bash
sudo ln -s /usr/include/arm-linux-gnueabihf/sys /usr/include/sys \
sudo ln -s /usr/include/arm-linux-gnueabihf/bits /usr/include/bits \
sudo ln -s /usr/include/arm-linux-gnueabihf/gnu /usr/include/gnu \
sudo ln -s /usr/include/arm-linux-gnueabihf/asm /usr/include/asm \
sudo ln -s /usr/lib/arm-linux-gnueabihf/crti.o /usr/lib/crti.o \
sudo ln -s /usr/lib/arm-linux-gnueabihf/crt1.o /usr/lib/crt1.o \
sudo ln -s /usr/lib/arm-linux-gnueabihf/crtn.o /usr/lib/crtn.o
This script did not needed to this from the command lineq
pi@mypi3-8:~/cross-compiler/test-cross-compiler $ ls -la /usr/include/sys
lrwxrwxrwx 1 root root 36 Jun  2 18:30 /usr/include/sys -> /usr/include/arm-linux-gnueabihf/sys
pi@mypi3-8:~/cross-compiler/test-cross-compiler $ less ../create_link.sh 
pi@mypi3-8:~/cross-compiler/test-cross-compiler $ ls -la /usr/include/sys
lrwxrwxrwx 1 root root 36 Jun  2 18:30 /usr/include/sys -> /usr/include/arm-linux-gnueabihf/sys
pi@mypi3-8:~/cross-compiler/test-cross-compiler $ ls -la /usr/include/bits
lrwxrwxrwx 1 root root 37 Jun  2 18:26 /usr/include/bits -> /usr/include/arm-linux-gnueabihf/bits
pi@mypi3-8:~/cross-compiler/test-cross-compiler $ ls -la /usr/include/gnu
lrwxrwxrwx 1 root root 36 Jun  2 18:33 /usr/include/gnu -> /usr/include/arm-linux-gnueabihf/gnu
pi@mypi3-8:~/cross-compiler/test-cross-compiler $ ls -la /usr/include/asm
lrwxrwxrwx 1 root root 36 Jun  2 18:34 /usr/include/asm -> /usr/include/arm-linux-gnueabihf/asm
