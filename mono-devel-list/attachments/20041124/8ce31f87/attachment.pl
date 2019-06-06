Index: Makefile
===================================================================
--- Makefile	(revision 36457)
+++ Makefile	(working copy)
@@ -13,7 +13,7 @@
 # force this, we don't case if CSC is broken. This also
 # means we can use --options, yay.
 
-MCS = MONO_PATH="$(topdir)/class/lib/$(PROFILE)$(PLATFORM_PATH_SEPARATOR)$$MONO_PATH" $(INTERNAL_MCS)
+MCS = MONO_PATH="$(topdir)/class/lib/$(PROFILE) $(PLATFORM_PATH_SEPARATOR) $$MONO_PATH" $(INTERNAL_MCS)
 endif
 
 # We don't want debugging info :-)
@@ -26,7 +26,8 @@
 # He may also move some to TEST_EXCLUDE_net_2_0 if some of the merges are inappropriate for GMCS.
 #
 NEW_TEST_SOURCES_common = test-294 test-304 test-305 test-306 test-307 test-318 mtest-5-dll mtest-5-exe \
-			test-319-dll test-319-exe
+			test-319-dll test-319-exe \
+			$(TEST_SOURCES_XML)
 
 #
 # Please do _not_ add any tests here - all new tests should go into NEW_TEST_SOURCES_common
@@ -110,14 +111,14 @@
 	$(TEST_SOURCES_common) $(TEST_SOURCES_$(PROFILE)) $(TEST_SOURCES_$(PLATFORM)))
 
 # These tests load User32.dll and/or Kernel32.dll
-TEST_SOURCES_win32 = test-50 test-67
+TEST_SOURCES_win32 = test-67
 
 ## FIXME: Need to audit.  Maybe move to 'TEST_EXCLUDES_linux' and 'TEST_EXCLUDES_win32' as approprate
 # A test is a 'no pass' if it fails on either windows or linux
 # Test 120 does not pass because the MS.NET runtime is buggy.
 
 TEST_NOPASS = test-120 test-132 test-133 a-parameter4.cs 
-#	test-28 test-45 test-53 test-91 test-102 test-106 test-107 test-122 test-66 test-177
+#	test-28 test-45 test-50 test-53 test-91 test-102 test-106 test-107 test-122 test-66 test-177
 
 # The test harness supports running the testcases in parallel.  However, we still need to
 # provide test-ordering rules to support multi-file testcases.  By default, any test named
@@ -155,7 +156,7 @@
 
 test-local: 
 
-run-test-local: multi test-harness test-casts
+run-test-local: multi test-harness test-casts xmldocdiff.exe xml-doc
 
 test-everything:
 	$(MAKE) PROFILE=default run-test
@@ -222,3 +223,30 @@
 	$(INTERNAL_ILASM) /dll property-il.il
 	$(CSCOMPILE) /r:property-il.dll property-main.cs /out:property-main.exe
 	$(TEST_RUNTIME) property-main.exe
+
+
+#
+# Test for /doc option; need to compare result documentation files.
+#
+
+TEST_SOURCES_XML = \
+	xml-001 xml-002 xml-003 xml-004 xml-005 xml-006 xml-007 xml-008 xml-009 xml-010 \
+	xml-011 xml-012 xml-013 xml-014 xml-015 xml-016 xml-017 xml-018 xml-019 xml-020 \
+	xml-021 xml-022 xml-023 xml-024 xml-025 xml-026
+
+# currently no formalization on 'cref' attribute was found, so there are some
+# differences between MS.NET and mono.
+TEST_SOURCES_XML_PENDING = xml-027
+
+xmldocdiff.exe:
+	$(CSCOMPILE) xmldocdiff.cs
+
+xml-doc:
+	@$(MAKE) -s xml-doc-run
+
+xml-doc-tests := $(filter xml-%, $(TEST_SOURCES))
+
+xml-doc-run:
+	@echo "Testing /doc outputs..."
+	@test -z "$(xml-doc-tests)" || for i in ''$(xml-doc-tests); do $(TEST_RUNTIME) xmldocdiff.exe $$i-ref.xml dir-$(TEST_TAG)/$$i.xml; done
+