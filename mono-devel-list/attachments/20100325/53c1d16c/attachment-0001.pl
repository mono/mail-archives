Index: frontend/Interpreter.cs
===================================================================
--- frontend/Interpreter.cs	(revision 154213)
+++ frontend/Interpreter.cs	(working copy)
@@ -15,8 +15,6 @@
 using Mono.Debugger.Languages;
 using EE=Mono.Debugger.ExpressionEvaluator;
 
-using Mono.GetOptions;
-
 namespace Mono.Debugger.Frontend
 {
 	public class Interpreter : DebuggerMarshalByRefObject, IInterruptionHandler, IDisposable
Index: frontend/ScriptingContext.cs
===================================================================
--- frontend/ScriptingContext.cs	(revision 154213)
+++ frontend/ScriptingContext.cs	(working copy)
@@ -12,8 +12,6 @@
 using Mono.Debugger.Languages;
 using EE = Mono.Debugger.ExpressionEvaluator;
 
-using Mono.GetOptions;
-
 namespace Mono.Debugger.Frontend
 {
 	public class ScriptingException : Exception
Index: configure.in
===================================================================
--- configure.in	(revision 154213)
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
 
Index: build/Makefile.am
===================================================================
--- build/Makefile.am	(revision 154213)
+++ build/Makefile.am	(working copy)
@@ -95,7 +95,6 @@
 	AssemblyInfo.cs
 
 TEST_FRAMEWORK_DEPS = \
-	-r:Mono.GetOptions				\
 	-r:./Mono.Debugger.dll				\
 	-r:./Mono.Debugger.Frontend.dll			\
 	-r:System.Runtime.Remoting			\
@@ -115,25 +114,20 @@
 	$(top_builddir)/test/src/*.dll
 
 SYMBOL_WRITER_DEPS = \
-	-r:Mono.GetOptions				\
 	-r:./Mono.Cecil.dll
 
 SYMBOL_READER_DEPS = \
-	-r:Mono.GetOptions				\
 	-r:./Mono.Cecil.dll
 
 DEBUGGER_DEPS = \
-	-r:Mono.GetOptions				\
 	-r:Mono.Debugger.SymbolWriter			\
 	-r:System.Runtime.Serialization.Formatters.Soap	\
 	-r:./Mono.Cecil.dll
 
 MDB_DEPS = \
-	-r:Mono.GetOptions				\
 	-r:./Mono.Debugger.dll
 
 TEST_DEPS = \
-	-r:Mono.GetOptions				\
 	-r:./Mono.Debugger.dll				\
 	-r:./Mono.Debugger.Frontend.dll			\
 	-r:./Mono.Debugger.Test.Framework.dll		\
