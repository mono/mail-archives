Index: mcs/tools/Makefile
===================================================================
--- mcs/tools/Makefile	(revision 70045)
+++ mcs/tools/Makefile	(working copy)
@@ -8,7 +8,7 @@
 net_1_1_bootstrap_SUBDIRS = gacutil security resgen
 net_2_0_bootstrap_SUBDIRS = resgen
 
-net_2_0_SUBDIRS = corcompare wsdl compiler-tester monop xbuild resgen mono-service mkbundle sgen
+net_2_0_SUBDIRS = corcompare wsdl compiler-tester monop xbuild resgen mono-service mkbundle sgen al
 
 DIST_ONLY_SUBDIRS = xbuild sgen
 
Index: mcs/tools/al/Makefile
===================================================================
--- mcs/tools/al/Makefile	(revision 70045)
+++ mcs/tools/al/Makefile	(working copy)
@@ -3,6 +3,6 @@
 include ../../build/rules.make
 
 LOCAL_MCS_FLAGS = -r:Mono.Security.dll
-PROGRAM = al.exe
+PROGRAM = $(topdir)/class/lib/$(PROFILE)/al.exe
 
 include ../../build/executable.make
