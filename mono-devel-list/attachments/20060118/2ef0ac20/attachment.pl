Index: Makefile
===================================================================
--- Makefile	(revision 55704)
+++ Makefile	(working copy)
@@ -36,7 +36,7 @@
 	Test/resources/AFile.txt			\
 	$(RESOURCE_FILES)
 
-CLEAN_FILES = $(cmplib) $(reslib) $(plattestlib) $(plattestlib).sources \
+CLEAN_FILES = $(cmplib) $(reslib) $(plattestverlib) $(plattestverlib).sources \
 	       $(cmp_response) $(cmp_makefrag) \
 	       $(res_response) $(res_makefrag) \
 	       $(cmppdb) $(respdb) $(plattestpdb)
@@ -51,16 +51,17 @@
 # run-monotest' or 'make run-plattest'.
 
 plattestlib = corlib_plattest.dll
-plattestpdb = $(patsubst %.dll,%.pdb,$(plattestlib))
-$(plattestlib).sources: corlib_test.dll.sources $(plattestlib).excludes
+plattestverlib = corlib_plattest_$(PROFILE).dll
+plattestpdb = $(patsubst %.dll,%.pdb,$(plattestverlib))
+$(plattestverlib).sources: corlib_test.dll.sources $(plattestlib).excludes
 	sort corlib_test.dll.sources $(plattestlib).excludes | uniq -u >$@
 
 TEST_MCS_FLAGS = -debug+ -debug:full -nowarn:168,219,618,672 -unsafe
 
 ifndef PLATFORM_MONO_NATIVE
-test_lib = $(plattestlib)
+test_lib = $(plattestverlib)
 test_against = $(PLATFORM_CORLIB)
-HAVE_CS_TESTS = $(plattestlib).sources
+HAVE_CS_TESTS = $(plattestverlib).sources
 
 ## for now, compiling the testsuite with CSC causes CS0583.  So compile with internal MCS
 TEST_COMPILE = MONO_PATH="$(topdir)/class/lib/$(PROFILE)$(PLATFORM_PATH_SEPARATOR)$$MONO_PATH" $(INTERNAL_MCS) $(USE_MCS_FLAGS)
@@ -74,7 +75,7 @@
 	$(MAKE) test_lib=corlib_test.dll test_against=$(reslib) run-test
 
 run-plattest:
-	$(MAKE) test_lib=$(plattestlib) test_against='$(PLATFORM_CORLIB)' run-test
+	$(MAKE) test_lib=$(plattestverlib) test_against='$(PLATFORM_CORLIB)' run-test
 
 else
 run-monotest: run-test