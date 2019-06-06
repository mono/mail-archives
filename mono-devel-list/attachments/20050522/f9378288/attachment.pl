Index: ChangeLog
===================================================================
--- ChangeLog	(revision 44748)
+++ ChangeLog	(working copy)
@@ -1,3 +1,10 @@
+2005-05-22  Andrew Skiba  <andrews@mainsoft.com>
+
+	* Makefile : permit to create reference results on Mono; change
+	comments in Makefile, so they are not printed during the
+	build
+	* xslttest.cs : forgot to write the generated results
+
 2005-05-19  Andrew Skiba  <andrews@mainsoft.com>
 
 	* ignore.lst : ignore 2 performance tests, as we don't time them
Index: Makefile
===================================================================
--- Makefile	(revision 44748)
+++ Makefile	(working copy)
@@ -29,10 +29,10 @@
 REFERENCE_RESULTS_URL = http://svn.myrealbox.com/source/trunk/release/$(REFERENCE_RESULTS_ARCHIVE)
 REFERENCE_RESULTS = $(REFERENCE_RESULTS_NAME)/timestamp
 
-test : $(TEST_EXE) $(FIXED_CATALOG) $(REFERENCE_RESULTS)
+test : $(TEST_EXE) $(FIXED_CATALOG)
 
-run-test : $(TEST_EXE) $(FIXED_CATALOG)
-	# Redirect stdout to /dev/null because it has only xsl:message garbage
+# Redirect stdout to /dev/null because it has only xsl:message garbage
+run-test : $(TEST_EXE) $(FIXED_CATALOG) $(REFERENCE_RESULTS)
 	$(RUNTIME) $(RUNTIME_FLAGS) $(TEST_EXE) $(TEST_FLAGS) >/dev/null
 
 clean :
@@ -47,13 +47,23 @@
 # Check that we are running on MS.NET - otherwise the reference output can be
 # created on mono - and we will compare mono with mono
 must-be-dotnet:
+ifdef GENERATE_REFERENCE_ON_MONO
+	true
+else
 	uname | grep CYGWIN || uname | grep Windows
+endif
 	
 create-reference-output : must-be-dotnet $(TEST_EXE)
+	rm -rf $(REFERENCE_RESULTS_NAME)
+ifdef GENERATE_REFERENCE_ON_MONO
+	$(RUNTIME) ./$(TEST_EXE) $(TEST_DOM) --generate
+else
 	./$(TEST_EXE) $(TEST_DOM) --generate
-	cd $(REFERENCE_RESULTS_NAME); echo "$(TEST_DOM)" > generate_options # Must cd to work with any path separator
+endif
+# Must cd to work with any path separator symbols
+	cd $(REFERENCE_RESULTS_NAME); echo "$(TEST_DOM)" > generate_options 
 	tar -c $(REFERENCE_RESULTS_NAME) | gzip > $(REFERENCE_RESULTS_ARCHIVE)
-	echo "Now you can upload $(REFERENCE_RESULTS_ARCHIVE) to $(REFERENCE_RESULTS_URL)"
+	@echo "Now you can upload $(REFERENCE_RESULTS_ARCHIVE) to $(REFERENCE_RESULTS_URL)"
 
 .cs.exe :
 	$(CSCOMPILE) $<
Index: xslttest.cs
===================================================================
--- xslttest.cs	(revision 44748)
+++ xslttest.cs	(working copy)
@@ -279,6 +279,7 @@
 			if (generateOutput) {
 				StreamWriter fw = new StreamWriter (outfile,
 					false, Encoding.UTF8);
+				fw.Write (sw.ToString ());
 				fw.Close ();
 				Report (TestResult.Success, testid, "Created reference result");
 				// ... and don't run comparison
