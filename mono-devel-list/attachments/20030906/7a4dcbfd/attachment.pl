#!/bin/bash
if [ -f /usr/bin/libtool.orig ] ; then
	echo Already switched to GNU libtool.
	exit 1
fi
sudo mv /usr/bin/libtool /usr/bin/libtool.orig
if [ $? -eq 0 ] ; then
	sudo cp /sw/bin/glibtool /usr/bin/libtool
fi
if [ $? -eq 0 ] ; then
	echo Switched sucessfully to GNU libtool.
	exit 0
else
	if [ ! -f /usr/bin/libtool ] ; then
		sudo mv /usr/bin/libtool.orig /usr/bin/libtool
	fi
	echo Unable to switch to GNU libtool.
	exit 1
fi