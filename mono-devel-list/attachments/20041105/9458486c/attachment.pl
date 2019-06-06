--- configure.in	2004-11-05 04:41:44.397106536 -0500
+++ configure.in.new	2004-11-05 04:41:25.762939360 -0500
@@ -97,11 +97,9 @@
 GLIB_MKENUMS="`$PKG_CONFIG --variable=glib_mkenums glib-2.0`"
 AC_SUBST(GLIB_MKENUMS)
 
-dnl find mono debugger
-dnl MONO_DEBUGGER_REQUIRED_VERSION=0.9
-dnl PKG_CHECK_MODULES(MONO_DEBUGGER, mono-debugger >= $MONO_DEBUGGER_REQUIRED_VERSION, enable_debugger=yes, enable_debugger=no)
-dnl AC_SUBST(MONO_DEBUGGER_LIBS)
-enable_debugger=no
+MONO_DEBUGGER_REQUIRED_VERSION=0.9
+PKG_CHECK_MODULES(MONO_DEBUGGER, mono-debugger >= $MONO_DEBUGGER_REQUIRED_VERSION, enable_debugger=yes, enable_debugger=no)
+AC_SUBST(MONO_DEBUGGER_LIBS)
 
 MOZILLA_HOME="`$PKG_CONFIG --variable=libdir mozilla-gtkmozembed`"
 AC_SUBST(MOZILLA_HOME)
@@ -218,8 +216,6 @@
 echo "   * GNOME prefix = $gnome_prefix"
 echo "   * C# compiler = $CSC"
 echo ""
-echo "   * mono-debugger: disabled in this release."
-echo ""
 echo "   NOTE: if any of the above say 'no' you may install the"
 echo "         corresponding development packages for them, and"
 echo "         rerun autogen.sh. If you are sure the proper"
