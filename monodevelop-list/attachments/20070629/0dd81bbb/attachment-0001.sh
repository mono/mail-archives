#!/bin/bash
# from http://www.all-the-johnsons.co.uk/mono/mono-extras.shtml
# http://bugzilla.ximian.com/show_bug.cgi?id=81734
# http://www.mono-project.com/Compiling_Mono

# svn checkout (co) or update the items in the variable checkout, below.
# build the items in builder, below.
# install 'em.

# Paul's easy to use script for mono
# For more details on compiling after using this, please see
# http://www.all-the-johnsons.co.uk/mono/mono-compiling.html

# Version 0.91e - Sing the song of peas

# There have been many changes to the script now. Many, many, many
# changes. You can now have multiple options, compile deliberately for
# 64 bit. There are some fixes, it no longer asks if you want to compile
# the alpha version, you get that by default.

# 0.91d - bugfix, mcs was included in the make install
# 0.91e - new command - download

# The checkout modules are now held in an array at the start of the script 
# instead of multiple copies dotted around the show

# new commands

# lib64 - compiles to $PREFIX/lib64 instead of $PREFIX/lib
# makegood - performs a make distclean and the exits
# debug - compile with debugging by default
# local - compile to /usr/local rather than /usr (default)
# download - downloads the source only

checkout=( mono mcs gtk-sharp libgdiplus monodevelop gtksourceview-sharp gtkmozembed-sharp monodoc )
builder=( libgdiplus mono gtk-sharp gtksourceview-sharp gtkmozembed-sharp monodoc monodevelop )
debug=""
libs64=""
uselocal="--prefix=/usr"
version="0.91e - 28th Dec 2005"

function displayhelp()
{
   cat <<EOF
    monoupdater script. (c) Paul F. Johnson 2004-2005 
    version ${version}
    Released under the GPL vsn 2 or newer
    
    Usage: monoupdater <options>
    
    options:   clean   - performs a make clean prior to compile
             rebuild   - performs a make distclean prior to build
               build   - performs a make without checkout
          noldconfig   - don't run ldconfig twice
               local   - use PREFIX=/usr/local
           uninstall   - uninstall the packages
            makegood   - performs a make distclean without a rebuild
               lib64   - compile libraries to /usr[/local]/lib64 for 64 bit
               debug   - compile with debugging switched on
                help   - displays this message
            download   - does the checkout/update but doesn't build
                       - checks out and builds the updated files
                         (uses options originally selected when first built)

    Examples:

       monoupdater build noldconfig - build without the second pass of 
                                      ldconfig
       monoupdater local lib64 debug clean - builds to /usr/local, for 64 bit, 
                                             debug enabled and make clean prior
                                             to build

    Please report bugs to paul@all-the-johnsons.co.uk or to the
    mono-develop mailing lists

    IMPORTANT - unless you specify "local" as an option, all software will be
                installed to /usr
EOF
    exit 1
}

function bomb()
{
  echo "$0:failed ($*)" >&2
  exit 1
}

# genmakefile generates makefiles if none exists within the source directory.
# for mono, it also asks if you want the preview code.

function genmakefile()
{
  local bootstrap
  local minor
  local package="gtk2"

  if [ "$1" != 'gtk-sharp' ];
  then
    echo ./autogen.sh "$uselocal" "$debug" "$libs64"
    ./autogen.sh "$uselocal" "$debug" "$libs64"
  fi

  if [ "$1" = 'gtk-sharp' ];
  then
    minor=`rpm -q --queryformat '${R}' $package`
    case "$minor" in
    0|1|2|3|4|5) bootstrap="bootstrap-2.4" ;;
    6) bootstrap="bootstrap" ;;
    *) bootstrap="bootstrap-2.10" ;;
    #*) bootstrap="bootstrap-2.8" ;;
    esac
    echo ./"$bootstrap" "$uselocal" "$debug" "$libs64"
    ./"$bootstrap" "$uselocal" "$debug" "$libs64"
  fi
}  

# This part makes and then does a make install. If you have yourself set as 
# sudo for make, alter the su -c make install to sudo make install
# I've added on MonoDevelop to the end of this list. You may need to alter
# where ldconfig is!

# mcs is not needed in here as it is installed when mono is installed

function build()
{
    for u in "${builder[@]}"
      do
	echo Build $u
        cd $u
        if [ "$rebuild" != '' ]
         then
	   echo make "$rebuild"
           make "$rebuild" || bomb "unable to make $rebuild"
        fi
        if [ ! -f "Makefile" ] ||  [ "$debug" != '' ];
         then
	  echo genmakefile "$u" 
  	  genmakefile "$u" || bomb "unable to generate make file"
        fi
        if make ; then
 	  echo su -c "make install"
	  su -c "make install" || bomb "can't 'make install'"
          if [ "$ldcon" != 'no' ]
	   then
	    echo "su -c /sbin/ldconfig"
	    su -c "/sbin/ldconfig" || bomb "can't 'make ldconfig'"
          fi
	  cd ..
        else
	  exit 1
      fi
    done
    exit 1
}

function makeclean()
{
    for u in "${builder[@]}"
     do
       cd $u
       echo make "distclean"
       make "distclean"
     done
    exit 1
}

function uninstall()
{
    for u in "${builder[@]}"
      do
        cd $u
        echo su -c "make uninstall"
        su -c "make uninstall" || bomb "can't 'make uninstall;"
      done
    exit 1
}

function checkout()
{
    for u in "${checkout[@]}"
    do
    if [ ! -f "./$u" ]
     then
      m="co"
     else
      m="update"
    fi

    echo svn $m svn://anonsvn.mono-project.com/source/trunk/$u
    svn $m svn://anonsvn.mono-project.com/source/trunk/$u
    done

    if [ "$n" != '' ]
    then
     exit 1
   fi 
}

# non-function parts come here. The first iterprets the command line
# parameters and acts accordingly

m=""
n=""
rebuild=""
optargs=("$@")
args=()
ldcon=""

for ((i=0; i<${#optargs[@]};++i));
  do case "${optargs[$i]}" in
    clean) if [ "$rebuild" = '' ] 
           then
            rebuild=clean
	   else
	    bomb "Unable to do a clean and rebuild (1)."
           fi ;;
    rebuild) if [ "$rebuild" = '' ] 
              then
              rebuild=distclean
	     else
	      bomb "Unable to do a clean and rebuild (2)."
             fi ;;
    noldconfig) if [ "$ldcon" = '' ]
                then
                  ldcon="no"
                fi ;;
    local) if [ "$uselocal" = '']
           then
            uselocal="--prefix=/usr/local"
           fi ;;
    lib64) if [ "$uselocal" = '/usr/local' ]
            then
              libs64="--libdir=/usr/local/lib64"
            else
              libs64="--libdir=/usr/lib64"
           fi ;;
    debug) if [ "$debug" = '' ]
           then
            debug="--with-debug"
           fi ;;
    uninstall) if [ "$rebuild" = '' && "$build" = '' ]
               then
                uninstall
	       else
		bomb "Unable to uninstall and build."
               fi ;;
   makegood) makeclean ;; 
   build) if [ "$rebuild" = '' ] 
           then
             build
	   else
	     bomb "I do not know how to build *and* rebuild."
           fi ;;
    download) n="." 
              checkout ;;
    help) displayhelp ;;
  esac
done 

# svn checkout/update. The line below can be altered to include any of the 
# mono modules available

checkout

# as the old version would start the build process and that's been moved to a
# function, I need to call the function here.

build
