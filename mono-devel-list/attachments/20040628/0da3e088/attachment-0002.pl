Index: mono-build-w32.sh
===================================================================
RCS file: /mono/mono/web/mono-build-w32.sh,v
retrieving revision 1.13
diff -u -r1.13 mono-build-w32.sh
--- mono-build-w32.sh	19 Mar 2004 18:14:04 -0000	1.13
+++ mono-build-w32.sh	27 Jun 2004 14:45:59 -0000
@@ -47,7 +47,7 @@
     fi
 fi
 
-cvs checkout mono || exit -1
+cvs checkout mono mcs || exit -1
 
 echo "Checking automake version"
 automake_required="1.6.2"
@@ -191,7 +191,8 @@
 # Build and install mono
 echo "Building and installing mono"
 
-(cd $here/mono; ./autogen.sh --prefix=$prefix || exit -1; make || exit -1; make install || exit -1) || exit -1
+# (cd $here/mono; ./autogen.sh --prefix=$prefix || exit -1; make || exit -1; make install || exit -1) || exit -1
+(cd $here/mcs; ./configure --prefix=$prefix || exit -1; make || exit -1; cd ../mono; ./autogen.sh --prefix=$prefix || exit -1; make || exit -1; make install || exit -1; cd ../mcs || exit -1; make install || exit -1) || exit -1
 
 
 echo ""
