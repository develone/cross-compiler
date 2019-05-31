#!/bin/bash
#need the patched file ubsan.c in /home/vidal
#need the patched file asan_linux.cc in /home/vidal
#The gcc_all folder will be created in ~/testbuilds
#The /opt/cross-pi-compiler will be created

mkdir -p ~/testbuilds/gcc_all
cd ~/testbuilds/gcc_all/

date > build.log
pwd >> build.log
cat "start of build process" >> build.log

mkdir build-binutils
mkdir build-gcc
mkdir build-glibc
mkdir build-gcc9
ls >> build.log

#Let’s download the software that we’ll use for building the cross compiler:
git clone --depth=1 https://github.com/raspberrypi/linux

wget https://ftpmirror.gnu.org/binutils/binutils-2.28.tar.bz2
wget https://ftpmirror.gnu.org/gcc/gcc-6.3.0/gcc-6.3.0.tar.gz
wget https://ftpmirror.gnu.org/gcc/gcc-9.1.0/gcc-9.1.0.tar.gz
wget https://ftpmirror.gnu.org/glibc/glibc-2.24.tar.bz2

tar xf binutils-2.28.tar.bz2
tar xf glibc-2.24.tar.bz2
tar xf gcc-6.3.0.tar.gz
tar xf gcc-9.1.0.tar.gz

rm *.tar.*
ls >> build.log
cat "required software downloaded"  >> build.log

#GCC also needs some prerequisites which we can download inside the source folder:
cd gcc-6.3.0/
contrib/download_prerequisites
rm *.tar.*

#This needs a better way to patch ubsan.c
#vidal@ws010:~/testbuilds/gcc_all_old/gcc-6.3.0/gcc$ diff ubsan.c ubsan.c.orig 
#1474c1474
#<       || xloc.file[0] == '\0' || xloc.file[0] == '\xff'
#---
#>       || xloc.file == '\0' || xloc.file[0] == '\xff'

cp gcc/ubsan.c gcc/ubsan.c.orig
cp ~/ubsan.c  ~/testbuilds/gcc_all/gcc-6.3.0/gcc
diff gcc/ubsan.c gcc/ubsan.c.orig > ../diffubsan.txt
cat "patched ubsan.c " >> ../build.log

cd ../gcc-9.1.0/
contrib/download_prerequisites
rm *.tar.*

#This needs a better way to patch asan_linux.cc
#These steps getting ready to build gcc-9.1.0
cp libsanitizer/asan/asan_linux.cc libsanitizer/asan/asan_linux.cc.orig
cp ~/asan_linux.cc libsanitizer/asan/
#78,80d77
#< #ifndef PATH_MAX
#< #define PATH_MAX 4096
#< #endif

diff libsanitizer/asan/asan_linux.cc libsanitizer/asan/asan_linux.cc.orig > ../diffasan_linux.txt
cat "patched asan_linux.cc " >> ../build.log

cd ../



#Next, create a folder in which we’ll put the cross compiler and add it to the path:

sudo mkdir -p /opt/cross-pi-gcc
sudo chown $USER /opt/cross-pi-gcc
export PATH=/opt/cross-pi-gcc/bin:$PATH
cat "created folder for built gcc" >> build.log

#Copy the kernel headers in the above folder, see Raspbian documentation for more info about the kernel:
cd linux/
KERNEL=kernel7
make ARCH=arm INSTALL_HDR_PATH=/opt/cross-pi-gcc/arm-linux-gnueabihf headers_install
cd ../
cat "created linux headers" >> build.log
#Biuld the binutils-2.28


cd build-binutils/
../binutils-2.28/configure --prefix=/opt/cross-pi-gcc --target=arm-linux-gnueabihf --with-arch=armv6 --with-fpu=vfp --with-float=hard --disable-multilib
make -j4
make install
pwd >> ../build.log
cat "binultils installed" >> ../build.log

#GCC and Glibc are interdependent, you can’t fully build one without the other, so we are going 
#to do a partial build of GCC, a partial build of Glibc and finally build GCC and Glibc.
#You can read more about this in Preshing’s article.

cd ../build-gcc
../gcc-6.3.0/configure --prefix=/opt/cross-pi-gcc --target=arm-linux-gnueabihf --enable-languages=c,c++,fortran --with-arch=armv6 --with-fpu=vfp --with-float=hard --disable-multilib
make -j4 all-gcc
make install-all
cat "all-gcc installed" >> ../build.log

#Now, let’s partially build Glibc:

cd ../build-glibc/
../glibc-2.24/configure --prefix=/opt/cross-pi-gcc/arm-linux-gnueabihf --build=$MACHTYPE --host=arm-linux-gnueabihf --target=arm-linux-gnueabihf --with-arch=armv6 --with-fpu=vfp --with-float=hard --with-headers=/opt/cross-pi-gcc/arm-linux-gnueabihf/include --disable-multilib libc_cv_forced_unwind=yes
make install-bootstrap-headers=yes install-headers
make -j4 csu/subdir_lib
install csu/crt1.o csu/crti.o csu/crtn.o /opt/cross-pi-gcc/arm-linux-gnueabihf/lib
arm-linux-gnueabihf-gcc -nostdlib -nostartfiles -shared -x c /dev/null -o /opt/cross-pi-gcc/arm-linux-gnueabihf/lib/libc.so
touch /opt/cross-pi-gcc/arm-linux-gnueabihf/include/gnu/stubs.h

cat "partial glibc built" >> build.log
date >> ../build.log

#Back to GCC:
cd ../build-gcc
make -j4 all-target-libgcc
make install-target-libgcc
cat "target libgcc installed " >> build.log
date >> ../build.log

#Finish building Glibc:
cd ../build-glibc/
make -j4
make install
cat "finished glibc" >> ../build.log
date >> ../build.log

#Finish building GCC 6.3.0:
cd ../build-gcc/
make -j 4
make install
cat "finished gcc installed" >> ../build.log
cat "wc of old 4027" >> ../build.log
tree /opt/cross-pi-gcc | wc >> ../build.log
date >> ../build.log

cd ../build-gcc9
../gcc-9.1.0/configure --prefix=/opt/cross-pi-gcc --target=arm-linux-gnueabihf --enable-languages=c,c++,fortran --with-arch=armv6 --with-fpu=vfp --with-float=hard --disable-multilib
make -j4
#make install
cd ../
