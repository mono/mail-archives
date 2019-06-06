#!/bin/sh
# 
make clean
./configure --prefix=/usr --enable-dependency-tracking --enable-nunit-tests --with-sigaltstack=yes --with-static_mono=yes --with-large-heap=yes --with-ikvm-native=yes --with-jit=yes --with-x --with-preview=yes --with-moonlight=yes
make 
make install