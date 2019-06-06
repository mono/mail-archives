Index: harness.mk
===================================================================
--- harness.mk	(revision 36619)
+++ harness.mk	(working copy)
@@ -9,6 +9,8 @@
 MCS = MONO_PATH="$(topdir)/class/lib/$(PROFILE)$(PLATFORM_PATH_SEPARATOR)$$MONO_PATH" $(INTERNAL_MCS)
 endif
 
+XMLDOCDIFF = $(TEST_RUNTIME) ../xmldocdiff.exe
+
 all-local $(STD_TARGETS:=-local):
 
 %.res:
@@ -20,8 +22,17 @@
 	  if test -f $*.exe; then \
 	    echo '*** $(TEST_RUNTIME) ./$*.exe' >> $$testlogfile ; \
 	      if $(TEST_RUNTIME) -O=-all ./$*.exe >> $$testlogfile 2>&1 ; then \
-		echo "PASS: $*" > $@ ; \
-	        rm -f $$testlogfile ; \
+	        if test -f $*.xml; then \
+	          if $(XMLDOCDIFF) ../$*-ref.xml $*.xml >> $$testlogfile ; then \
+	            echo "PASS: $*: xml comparison" > $@ ; \
+	            rm -f $$testlogfile ; \
+	          else \
+	            echo "FAIL: $*: xml comparison" > $@ ; \
+	          fi \
+	        else \
+	          echo "PASS: $*" > $@ ; \
+	          rm -f $$testlogfile ; \
+	        fi \
 	      else \
 		echo "Exit code: $$?" >> $$testlogfile ; \
 		echo "FAIL: $*" > $@ ; \
Index: Makefile
===================================================================
--- Makefile	(revision 36620)
+++ Makefile	(working copy)
@@ -26,7 +26,8 @@
 # He may also move some to TEST_EXCLUDE_net_2_0 if some of the merges are inappropriate for GMCS.
 #
 NEW_TEST_SOURCES_common = test-294 test-304 test-305 test-306 test-307 test-318 mtest-5-dll mtest-5-exe \
-			test-319-dll test-319-exe test-320
+			test-319-dll test-319-exe test-320 \
+			$(TEST_SOURCES_XML)
 
 #
 # Please do _not_ add any tests here - all new tests should go into NEW_TEST_SOURCES_common
@@ -181,7 +182,7 @@
 endif
 
 .PHONY: test-harness test-harness-run
-test-harness:
+test-harness: xmldocdiff.exe
 	@$(MAKE) -s test-harness-run
 
 exe_tests := $(filter %-exe, $(TEST_SOURCES))
@@ -222,3 +223,22 @@
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
+xml-doc-tests := $(filter xml-%, $(TEST_SOURCES))
+
+xmldocdiff.exe:
+	$(CSCOMPILE) xmldocdiff.cs