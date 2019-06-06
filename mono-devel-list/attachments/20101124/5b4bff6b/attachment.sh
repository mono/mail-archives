#!/bin/bash

MONOMAJOR=2.8
MONOVER=2.8.1
TOPDIR=$(pwd)
BUILDDIR=$TOPDIR/mono-${MONOVER}
MONODIR=/opt/mono-${MONOVER}

export PATH
export PKG_CONFIG_PATH

if [[ ":$PATH:" != *":$MONODIR/bin:"* ]]
then
	echo "Adding $MONODIR to $PATH"
	echo "#!/bin/bash
PATH=$MONODIR/bin:$MONODIR/share:\$PATH
PKG_CONFIG_PATH=$MONODIR/lib/pkgconfig/:\$PKG_CONFIG_PATH
LD_LIBRARY_PATH=/opt/mono-2.8.1/lib:\$LD_LIBRARY_PATH
" >> /etc/profile.d/mono-path.sh
	PKG_CONFIG_PATH=$MONODIR/lib/pkgconfig/:$PKG_CONFIG_PATH
	PATH=$MONODIR/bin:$PATH
fi

function InstallFedoraPrereq {
	echo "Installing prerequisites..."
	yum install -y make automake glibc-devel gcc-c++ gcc glib2-devel pkgconfig \
		subversion bison gettext autoconf httpd httpd-devel libtool wget \
		libtiff-devel gtk2-devel atk-devel pango-devel giflib-devel \
		libglade2-devel libgnomecanvas-devel libgnomeui-devel libgnome-devel \
		gtkhtml2-devel gtksourceview-devel gtksourceview2-devel \
		gtksourceview3-devel libgnomeprint22-devel libgnomeprintui22-devel \
		libexif-devel libjpeg-turbo-devel nspr-devel nss-devel xulrunner-devel
}

function DownloadAndExtract {
	if [ ! -f $BUILDDIR/$2 ]
	then
		cd $BUILDDIR
		echo Downloading ${1}...
		wget -nc $1/$2
		echo Extracting...
		tar -jxf $2 || tar -zxf $2
	fi
}


function Build {
	echo -ne "Build $1? y/n: "
	read var
	if [ $var = "y" ]
	then
		cd $BUILDDIR
		cd $1*
		pwd
		if [ -f sample/gnomevfs/Makefile.am ]
		then
			# A sample in gnome-sharp is broken (requires Mono.GetOptions)
			# We patch the configure script to skip the samples
			
			echo Patching gnome-sharp...
			sed -i 's/ENABLE_MONOGETOPTIONS_TRUE=$/ENABLE_MONOGETOPTIONS_TRUE='\''\#'\''/g' configure
			sed -i 's/ENABLE_MONOGETOPTIONS_FALSE='\''\#'\''$/ENABLE_MONOGETOPTIONS_FALSE=/g' configure
		fi
		
		./configure --prefix=${MONODIR}

		if [ -f sample/PrintSample.cs ]
		then
			# A sample in gtksourceview fails to build
			# We patch the Makefile to skip the samples
			
			echo Patching gtksourceview-sharp...
			sed -i 's/SUBDIRS = gtksourceview sample doc/SUBDIRS = gtksourceview doc/g' Makefile
		fi
		
		echo "If configure was ok, press Return to make..."
		read
		nice -- make && make install
		echo
		echo
	fi
}

mkdir -p $BUILDDIR

InstallFedoraPrereq

DownloadAndExtract "http://ftp.novell.com/pub/mono/sources/xsp" "xsp-${MONOVER}.tar.bz2"
DownloadAndExtract "http://ftp.novell.com/pub/mono/sources/mod_mono" "mod_mono-2.8.tar.bz2"
DownloadAndExtract "http://ftp.novell.com/pub/mono/sources/mono" "mono-${MONOVER}.tar.bz2"
DownloadAndExtract "http://ftp.novell.com/pub/mono/sources/libgdiplus" "libgdiplus-${MONOVER}.tar.bz2"
DownloadAndExtract "http://ftp.novell.com/pub/mono/sources/gtk-sharp212" "gtk-sharp-2.12.10.tar.bz2"
DownloadAndExtract "http://ftp.novell.com/pub/mono/sources/gnome-sharp2" "gnome-sharp-2.24.1.tar.bz2"
DownloadAndExtract "http://ftp.novell.com/pub/mono/sources/gnome-desktop-sharp2" "gnome-desktop-sharp-2.24.0.tar.bz2"
DownloadAndExtract "http://ftp.novell.com/pub/mono/sources/mono-addins" "mono-addins-0.5.tar.bz2"
DownloadAndExtract "http://ftp.novell.com/pub/mono/sources/mono-tools" "mono-tools-2.8.tar.bz2"
DownloadAndExtract "http://ftp.novell.com/pub/mono/sources/gecko-sharp2" "gecko-sharp-2.0-0.13.tar.bz2"
DownloadAndExtract "http://ftp.novell.com/pub/mono/sources/gtksourceview-sharp-2.0" "gtksourceview-sharp-2.0-0.12.tar.bz2"
DownloadAndExtract "http://ftp.novell.com/pub/mono/sources/gtksourceview2-sharp" "gtksourceview2-sharp-89788.tar.bz2"
DownloadAndExtract "http://www.ndesk.org/archive/ndesk-options" "ndesk-options-0.2.1.tar.gz"
DownloadAndExtract "http://ftp.novell.com/pub/mono/sources/mono-debugger" "mono-debugger-2.8.1.tar.bz2"
DownloadAndExtract "http://ftp.novell.com/pub/mono/sources/monodevelop" "monodevelop-2.4.1.tar.bz2"
DownloadAndExtract "http://ftp.novell.com/pub/mono/sources/monodevelop-database" "monodevelop-database-2.4.tar.bz2"
DownloadAndExtract "http://ftp.novell.com/pub/mono/sources/monodevelop-debugger-gdb" "monodevelop-debugger-gdb-2.4.tar.bz2"
DownloadAndExtract "http://ftp.novell.com/pub/mono/sources/monodevelop-debugger-mdb" "monodevelop-debugger-mdb-2.4.tar.bz2"
DownloadAndExtract "http://ftp.novell.com/pub/mono/sources/gluezilla" "gluezilla-2.6.tar.bz2"

Build "libgdiplus-${MONOMAJORVER}*"
Build "mono-${MONOMAJORVER}*"
Build "ndesk-options-0.2.1"
Build "mono-debugger-${MONOMAJORVER}*"
Build "gluezilla-2.6*"
Build "gtk-sharp-2.*"
Build "gecko-sharp-2*"
Build "gnome-sharp-2*"
Build "gtksourceview-sharp-2*"
Build "gtksourceview2-sharp*"
Build "gnome-desktop-sharp-2*"
Build "mono-tools-${MONOMAJORVER}*"
Build "mono-addins-0.5"
Build "monodevelop-2.4*"
Build "monodevelop-debugger-gdb-2.4*"
Build "monodevelop-debugger-mdb-2.4*"
Build "xsp-${MONOMAJORVER}*"
Build "mod_mono-${MONOMAJORVER}*"

echo
echo "Done."
