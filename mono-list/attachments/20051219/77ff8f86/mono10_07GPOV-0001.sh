#!/bin/sh
# check script for the ATI Radeon drivers for Linux/x86(IA32) with XFree 4.x
date
make --version
gcc --version
cd /tpnetfrontend/1.1.10.1.src
rm -R binutils-2.16.1
tar -xvf binutils-2.16.1.tar
cd /tpnetfrontend/1.1.10.1.src/binutils-2.16.1
date
CC=gcc ./configure --prefix=/usr/local --disable-nls
echo CC=gcc ./configure --prefix=/usr/local --disable-nls ---------------------------------------
date
make
date
make install
date
cd /tpnetfrontend/1.1.10.1.src
date
rm -R pkg-config-0.20
tar -xvf pkg-config-0.20.tar
echo tar -xvf pkg-config-0.20.tar
cd /tpnetfrontend/1.1.10.1.src/pkg-config-0.20
sh ./configure --prefix=/usr/local
make
make install
cd /tpnetfrontend/1.1.10.1.src
date
rm -R bison-2.0
tar -xvf bison-2.0.tar
echo tar -xvf pkg-config-0.20.tar
cd /tpnetfrontend/1.1.10.1.src/bison-2.0
sh ./configure --prefix=/usr/local
make
make install
cd /tpnetfrontend/1.1.10.1.src
date
rm -R gettext-0.14.5
tar -xvf gettext-0.14.5.tar
echo tar -xvf gettext-0.14.5.tar
cd /tpnetfrontend/1.1.10.1.src/gettext-0.14.5
sh ./configure --prefix=/usr/local
make
make install
cd /tpnetfrontend/1.1.10.1.src
date
rm -R glib-2.9.0
tar -xvf glib-2.9.0.tar
echo tar -xvf glib-2.9.0.tar
cd /tpnetfrontend/1.1.10.1.src/glib-2.9.0
sh ./configure --prefix=/usr/local  --with-libiconv
make
rm -rf /usr/local/include/glib.h 
rm -rf /usr/local/include/gmodule.h
make install
cd /tpnetfrontend/1.1.10.1.src
rm -R mono-1.1.10.1
echo rm -R mono-1.1.10.1.tar
date
tar -xvf mono-1.1.10.1.tar
echo tar -xvf mono-1.1.10.1.tar
date
cd /tpnetfrontend/1.1.10.1.src/mono-1.1.10.1
sh ./configure --prefix=/usr/local
echo ./configure --prefix=/usr/local mono-1.1.10.1.tar ---------------------------------------
date
make -i
echo make -i
date
make -i install
echo make -i install
date



