Index: ChangeLog
===================================================================
--- ChangeLog	(revision 44028)
+++ ChangeLog	(working copy)
@@ -1,3 +1,7 @@
+2005-05-08  Andrew Skiba  <andrews@mainsoft.com>
+
+	* Makefile : care of timestamps to make a minimal build
+
 2004-11-08  Atsushi Enomoto  <atsushi@ximian.com>
 
 	* xmltest.cs : reformat; easier to check.
Index: Makefile
===================================================================
--- Makefile	(revision 44028)
+++ Makefile	(working copy)
@@ -11,15 +11,14 @@
 	$(MCS_RUNTIME) $(MCS) domdump.cs
 	$(MCS_RUNTIME) $(MCS) eventdump.cs
 
-$(TESTS) : $(TEST_ARCHIVE) xml-test-suite
-	cd xml-test-suite; unzip -n ../$(TEST_ARCHIVE); cd ..
+$(TESTS) : $(TEST_ARCHIVE)
+	mkdir xml-test-suite 2>/dev/null; true
+	cd xml-test-suite && unzip -n ../$(TEST_ARCHIVE)
+	touch $(TESTS)
 
 $(TEST_ARCHIVE) :
 	wget http://www.w3.org/XML/Test/xmlts20031210.zip
 
-xml-test-suite:
-	mkdir xml-test-suite
-
 test :
 	$(RUNTIME) $(RUNTIME_FLAGS) xmltest.exe
 
@@ -37,6 +36,7 @@
 
 xmlreader-result-ms.txt dom-result-ms.txt event-result-ms.txt :
 	unzip -n $(DUMP_RESULTS_ARCHIVE)
+	touch $@
 
 # be careful to use it. This removes ALL files in xml-test-suite!
 # clean:
