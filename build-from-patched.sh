#246	binutils
#741	all-gcc
#1651	linux hdrs
#2049	partial glibc
#2061	target-libgcc
#3133	finish glibc
#4027	finish gcc
#5407	9.1.0
#06/01/19
-rw-rw-r--  1 vidal vidal  28054929 May 31 20:03 binutils-2.28.tjz
-rw-rw-r--  1 vidal vidal 590856458 Jun  1 08:54 cross-pi-gcc.tjz
-rw-rw-r--  1 vidal vidal 104957532 May 31 20:06 gcc-6.3.0.tjz
-rw-rw-r--  1 vidal vidal 102244175 May 31 20:11 gcc-9.1.0.tjz
-rw-rw-r--  1 vidal vidal  22002565 May 31 20:04 glibc-2.24.tjz
-rw-rw-r--  1 vidal vidal 317494562 May 31 20:14 linux.tjz
-rw-rw-r--  1 vidal vidal 306592681 May 31 19:58 patchedgcc6.3-binutils2.28-glibc2.24.tjz
vidal@ws010:~/ubuntu-cross-compiler$ md5sum *.tjz
7bb811e10fde772aa6188d6d00815aed  binutils-2.28.tjz
74582dfbc6d7225e7dda2752b4ff0f84  cross-pi-gcc.tjz
d0bc9008a92f0817330cecd685e4d092  gcc-6.3.0.tjz
f839b6ba3f790c6a99114e1f5a09b536  gcc-9.1.0.tjz
de2f4fdcb3f396bef4a1c95c2a0eaebb  glibc-2.24.tjz
1ca4ecd9f27f61abbb501b3033f20172  linux.tjz
9c9c6a9c332bf63d57a2e2340ba78014  patchedgcc6.3-binutils2.28-glibc2.24.tjz
#05/31/19
pi@mypi3-8:~/cross-compiler/test-cross-compiler $ scp vidal@w010:~/cross-compiler/test-cross-compiler/pi_jpeg .
pi@mypi3-8:~/cross-compiler/test-cross-compiler $ ./pi_jpeg 0 1
buf_red = 0x76d4f008
fwd_inv = 0x1adf008
spliting red sub band
fwd lifting step only
x = 0xe22247c sp = 0xe2 z = 0xe200000
x = 0xde22083 sp = 0xde z = 0xde00000
x = 0xe221475 sp = 0xe2 z = 0xe200000
x = 0xe32207b sp = 0xe3 z = 0xe300000
x = 0xa812055 sp = 0xa8 z = 0xa800000
x = 0xb210c4c sp = 0xb2 z = 0xb200000
w = 0x100 buf_red wptr = 0x76d4f008 alt =  0x76d8f008 fwd_inverse =  0x1adf008 fwd_inverse =  0x1 
starting red dwt
in singlelift 
in singlelift 
in singlelift 
in singlelift 
in singlelift 
in singlelift 
testing test_fwd 
finished ted dwt
 1998  cd ~/testbuilds/gcc_all/
 1999  export PATH=/opt/cross-pi-gcc/bin:$PATH
 2000  mkdir build-binutils && cd build-binutils
 2001  ../binutils-2.28/configure --prefix=/opt/cross-pi-gcc --target=arm-linux-gnueabihf --with-arch=armv6 --with-fpu=vfp --with-float=hard --disable-multilib
 2002  make -j 4
 2003  make install
 2004  cd ../
 2005  mkdir build-gcc && cd build-gcc
 2006  ../gcc-6.3.0/configure --prefix=/opt/cross-pi-gcc --target=arm-linux-gnueabihf --enable-languages=c,c++,fortran --with-arch=armv6 --with-fpu=vfp --with-float=hard --disable-multilib
 2007  make -j 4 all-gcc
 2008  make install-gcc
 2009  cd ../
 2010  cd linux
 2011  KERNEL=kernel7
 2012  make ARCH=arm INSTALL_HDR_PATH=/opt/cross-pi-gcc/arm-linux-gnueabihf headers_install
 2013  cd ../
 2014  mkdir build-glibc && cd build-glibc
 2015  ../glibc-2.24/configure --prefix=/opt/cross-pi-gcc/arm-linux-gnueabihf --build=$MACHTYPE --host=arm-linux-gnueabihf --target=arm-linux-gnueabihf --with-arch=armv6 --with-fpu=vfp --with-float=hard --with-headers=/opt/cross-pi-gcc/arm-linux-gnueabihf/include --disable-multilib libc_cv_forced_unwind=yes
 2016  make install-bootstrap-headers=yes install-headers
 2017  make -j 4 csu/subdir_lib
 2018  install csu/crt1.o csu/crti.o csu/crtn.o /opt/cross-pi-gcc/arm-linux-gnueabihf/lib
 2019  arm-linux-gnueabihf-gcc -nostdlib -nostartfiles -shared -x c /dev/null -o /opt/cross-pi-gcc/arm-linux-gnueabihf/lib/libc.so
 2020  touch /opt/cross-pi-gcc/arm-linux-gnueabihf/include/gnu/stubs.h
 2021  cd ..
 2022  cd build-gcc
 2023  make -j 4 all-target-libgcc
 2024  make install-target-libgcc
 2025  cd ../
 2026  cd build-gcc/
 2027  cd ../
 2028  cd build-glibc/
 2029  make -j 4
 2030  make install
 2031  cd ../
 2032  cd build-gcc
 2033  make -j 4

