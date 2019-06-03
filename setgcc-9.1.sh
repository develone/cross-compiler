#!/bin/bash
echo $PATH
echo $LD_LIBRARY_PATH
export PATH=/opt/gcc-9.1.0/bin:$PATH
export LD_LIBRARY_PATH=/opt/gcc-9.1.0/lib:$LD_LIBRARY_PATH
echo $PATH
echo $LD_LIBRARY_PATH
