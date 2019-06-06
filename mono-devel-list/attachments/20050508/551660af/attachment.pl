Index: Test/System.Xml.Schema/standalone_tests/xsdtest.cs
===================================================================
--- xsdtest.cs	(revision 44028)
+++ xsdtest.cs	(working copy)
@@ -100,7 +100,7 @@
 	
 	void RunTest (string subdir)
 	{
-		string basePath = @"Xsd-Test-Suite" + SEP;
+		string basePath = @"xsd-test-suite" + SEP;
 		XmlDocument doc = new XmlDocument ();
 		doc.Load (basePath + subdir + SEP + "tests-all.xml");
 
Index: Test/System.Xml.Schema/standalone_tests/ChangeLog
===================================================================
--- ChangeLog	(revision 44028)
+++ ChangeLog	(working copy)
@@ -1,3 +1,9 @@
+2005-05-08  Andrew Skiba  <andrews@mainsoft.com>
+
+	* Makefile : track the timestamp so tar does not run when not
+	needed
+	* xsdtest.cs : fix the case of the directory name
+
 2004-01-17  Atsushi Enomoto  <atsushi@ximian.com>
 
 	* Makefile : report details.
Index: Test/System.Xml.Schema/standalone_tests/Makefile
===================================================================
--- Makefile	(revision 44028)
+++ Makefile	(working copy)
@@ -12,18 +12,19 @@
 xs-psci-compare.exe : xs-psci-compare.cs
 	$(MCS_RUNTIME) $(MCS) xs-psci-compare.cs
 
-$(MASTERS) : $(MASTER_ARCHIVE) xsd-test-suite
-	cd xsd-test-suite; tar zxvf ../$(MASTER_ARCHIVE); cd ..
+$(MASTERS) : $(MASTER_ARCHIVE)
+	mkdir xsd-test-suite 2>/dev/null; true
+	cd xsd-test-suite && tar zxvf ../$(MASTER_ARCHIVE)
+	touch $(MASTERS)
 
-$(TESTS) : $(TEST_ARCHIVE) $(MASTERS) xsd-test-suite
-	cd xsd-test-suite; tar zxvf ../$(TEST_ARCHIVE); cd ..
+$(TESTS) : $(TEST_ARCHIVE) $(MASTERS) 
+	mkdir xsd-test-suite 2>/dev/null; true
+	cd xsd-test-suite && tar zxvf ../$(TEST_ARCHIVE)
+	touch $(TESTS)
 
 $(TEST_ARCHIVE) :
 	wget http://www.w3.org/2001/05/xmlschema-test-collection/XSTC-20020116.tar.gz
 
-xsd-test-suite:
-	mkdir xsd-test-suite
-
 run-test :
 	$(RUNTIME) $(RUNTIME_FLAGS) xsdtest.exe --xml --reportsuccess --testall --details --report:TestResult.xml $(XSD_TEST_FLAGS)
 	@echo "SUCCESS: `grep -c \"OK\" TestResult.xml` NORMAL FAILURE: `grep -c should TestResult.xml` UNEXPECTED `grep -c unexpected TestResult.xml`"
