Index: configure.in
===================================================================
--- configure.in	(revision 157801)
+++ configure.in	(working copy)
@@ -146,7 +146,7 @@
 AC_SUBST(BASE_DEPENDENCIES_LIBS)
 
 ## Versions of dependencies
-PKG_CHECK_MODULES(SERVER_DEPENDENCIES, mono >= $MONO_REQUIRED_VERSION glib-2.0 >= $GLIB_REQUIRED_VERSION $martin_deps)
+PKG_CHECK_MODULES(SERVER_DEPENDENCIES, mono-2 >= $MONO_REQUIRED_VERSION glib-2.0 >= $GLIB_REQUIRED_VERSION $martin_deps)
 AC_SUBST(SERVER_DEPENDENCIES_CFLAGS)
 AC_SUBST(SERVER_DEPENDENCIES_LIBS)
 
@@ -160,7 +160,7 @@
 CECIL_ASM=`pkg-config --variable=Libraries cecil`
 AC_SUBST(CECIL_ASM)
 
-PKG_CHECK_MODULES(WRAPPER, mono >= $MONO_REQUIRED_VERSION gthread-2.0 >= $GLIB_REQUIRED_VERSION)
+PKG_CHECK_MODULES(WRAPPER, mono-2 >= $MONO_REQUIRED_VERSION gthread-2.0 >= $GLIB_REQUIRED_VERSION)
 AC_SUBST(WRAPPER_CFLAGS)
 AC_SUBST(WRAPPER_LIBS)
 
@@ -174,7 +174,7 @@
 AC_SUBST(GACUTIL_FLAGS)
 AC_SUBST(CFLAGS)
 
-mono_prefix="`$PKG_CONFIG --variable=prefix mono`"
+mono_prefix="`$PKG_CONFIG --variable=prefix mono-2`"
 monodoc_prefix="`$PKG_CONFIG --variable=prefix monodoc`"
 AC_SUBST(mono_prefix)
 AC_SUBST(monodoc_prefix)
