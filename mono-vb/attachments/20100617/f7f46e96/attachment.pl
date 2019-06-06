diff -r c2e0ac4fd663 vbnc/cecil/Makefile
--- a/vbnc/cecil/Makefile	Fri Jun 11 07:39:41 2010 -0500
+++ b/vbnc/cecil/Makefile	Thu Jun 17 13:02:13 2010 -0500
@@ -4,7 +4,7 @@
 include ../../build/rules.make
 
 LIBRARY = Mono.Cecil.VB.dll
-LIBRARY_COMPILE = mcs -keyfile:$(topdir)/$(thisdir)/mono.snk -d:CECIL -debug
+LIBRARY_COMPILE = gmcs -keyfile:$(topdir)/$(thisdir)/mono.snk -d:CECIL -debug
 #LIBRARY_SNK = $(topdir)/$(thisdir)/mono.snk
 
 include ../../build/library.make
diff -r c2e0ac4fd663 vbnc/cecil/symbols/mdb/Makefile
--- a/vbnc/cecil/symbols/mdb/Makefile	Fri Jun 11 07:39:41 2010 -0500
+++ b/vbnc/cecil/symbols/mdb/Makefile	Thu Jun 17 13:02:13 2010 -0500
@@ -4,7 +4,7 @@
 include ../../../../build/rules.make
 
 LIBRARY = Mono.Cecil.VB.Mdb.dll
-LIBRARY_COMPILE = mcs -keyfile:$(topdir)/vbnc/cecil/mono.snk -r:$(topdir)/class/lib/$(PROFILE)/Mono.Cecil.VB.dll -d:CECIL -debug
+LIBRARY_COMPILE = gmcs -keyfile:$(topdir)/vbnc/cecil/mono.snk -r:$(topdir)/class/lib/$(PROFILE)/Mono.Cecil.VB.dll -d:CECIL -debug
 BUILT_FILES = $(topdir)/class/lib/$(PROFILE)/Mono.Cecil.VB.dll
 
 include ../../../../build/library.make
diff -r c2e0ac4fd663 vbnc/cecil/symbols/pdb/Makefile
--- a/vbnc/cecil/symbols/pdb/Makefile	Fri Jun 11 07:39:41 2010 -0500
+++ b/vbnc/cecil/symbols/pdb/Makefile	Thu Jun 17 13:02:13 2010 -0500
@@ -4,7 +4,7 @@
 include ../../../../build/rules.make
 
 LIBRARY = Mono.Cecil.VB.Pdb.dll
-LIBRARY_COMPILE = mcs -keyfile:$(topdir)/vbnc/cecil/mono.snk -r:$(topdir)/class/lib/$(PROFILE)/Mono.Cecil.VB.dll -d:CECIL -debug
+LIBRARY_COMPILE = gmcs -keyfile:$(topdir)/vbnc/cecil/mono.snk -r:$(topdir)/class/lib/$(PROFILE)/Mono.Cecil.VB.dll -d:CECIL -debug
 
 BUILT_FILES = $(topdir)/class/lib/$(PROFILE)/Mono.Cecil.VB.dll
 
