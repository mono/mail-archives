#!/bin/sh
#
make clean
./autogen.sh --prefix=/usr  --enable-java=yes --enable-boo=yes --enable-monoextensions=yes --enable-versioncontrol=yes --enable-subversion=yes --enable-database=yes --enable-aspnet=yes --enable-aspnetedit=yes --enable-c =yes --enable-gtksourceview2=no --enable-nemerle=yes --enable-database=yes
make
make uninstall
make install