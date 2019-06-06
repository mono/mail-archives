Index: class/Microsoft.VisualBasic/Makefile
===================================================================
RCS file: /mono/mcs/class/Microsoft.VisualBasic/Makefile,v
retrieving revision 1.3
diff -u -r1.3 Makefile
--- class/Microsoft.VisualBasic/Makefile	22 Jun 2004 09:15:58 -0000	1.3
+++ class/Microsoft.VisualBasic/Makefile	27 Jun 2004 07:47:33 -0000
@@ -19,7 +19,7 @@
 $(the_lib): $(TXT_RESOURCES) $(RESX_RESOURCES)
 
 $(TXT_RESOURCES): %.resources: %.txt
-	MONO_PATH="$(topdir)/class/lib/$(PROFILE)$(PLATFORM_PATH_SEPARATOR)$$MONO_PATH" $(INTERNAL_RESGEN) $<
+	MONO_PATH="$(topdir)/class/lib/$(PROFILE)$(PLATFORM_PATH_SEPARATOR)$$MONO_PATH" $(RESGEN) $<
 
 $(RESX_RESOURCES): %.resources: %.resx
-	MONO_PATH="$(topdir)/class/lib/$(PROFILE)$(PLATFORM_PATH_SEPARATOR)$$MONO_PATH" $(INTERNAL_RESGEN) $<
+	MONO_PATH="$(topdir)/class/lib/$(PROFILE)$(PLATFORM_PATH_SEPARATOR)$$MONO_PATH" $(RESGEN) $<
Index: class/Mono.CSharp.Debugger/Makefile
===================================================================
RCS file: /mono/mcs/class/Mono.CSharp.Debugger/Makefile,v
retrieving revision 1.6
diff -u -r1.6 Makefile
--- class/Mono.CSharp.Debugger/Makefile	24 Jun 2004 05:59:44 -0000	1.6
+++ class/Mono.CSharp.Debugger/Makefile	27 Jun 2004 07:47:33 -0000
@@ -3,7 +3,7 @@
 include ../../build/rules.make
 
 LIBRARY = Mono.CSharp.Debugger.dll
-LIB_MCS_FLAGS = /r:$(corlib)
+LIB_MCS_FLAGS = /r:$(topdir)/class/lib/$(PROFILE)/$(corlib)
 NO_TEST = yes
 
 ifeq (win32, $(PLATFORM))
Index: class/Npgsql/Makefile
===================================================================
RCS file: /mono/mcs/class/Npgsql/Makefile,v
retrieving revision 1.17
diff -u -r1.17 Makefile
--- class/Npgsql/Makefile	22 Jun 2004 09:19:37 -0000	1.17
+++ class/Npgsql/Makefile	27 Jun 2004 07:47:37 -0000
@@ -39,7 +39,7 @@
 all: $(RESX_RES) $(the_lib)
 
 %.resources: %.resx
-	MONO_PATH="$(topdir)/class/lib/$(PROFILE)$(PLATFORM_PATH_SEPARATOR)$$MONO_PATH" $(INTERNAL_RESGEN) $<
+	MONO_PATH="$(topdir)/class/lib/$(PROFILE)$(PLATFORM_PATH_SEPARATOR)$$MONO_PATH" $(RESGEN) $<
 
 clean: clean-recursive clean-local
 

