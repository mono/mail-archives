#!/bin/bash
if [ ! -f /usr/bin/libtool.orig ] ; then
	echo Already switched to Mac OS X libtool.
	exit 1
fi
sudo rm /usr/bin/libtool
if [ $? -eq 0 ] ; then
	sudo mv /usr/bin/libtool.orig /usr/bin/libtool
fi
if [ $? -eq 0 ] ; then
	echo Switched sucessfully to Mac OS X libtool.
	exit 0
else
	if [ ! -f /usr/bin/libtool ] ; then
		sudo cp /sw/bin/glibtool /usr/bin/libtool
	fi
	echo Unable to switch to Mac OS X libtool.
	exit 1
fi