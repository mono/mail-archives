Index: tools/compiler-tester/compiler-tester.cs
===================================================================
--- tools/compiler-tester/compiler-tester.cs	(revision 57938)
+++ tools/compiler-tester/compiler-tester.cs	(working copy)
@@ -803,13 +803,13 @@
 	class Tester {
 
 		static int Main(string[] args) {
-			if (args.Length != 5) {
+			if (args.Length != 5 || !args [1].StartsWith ("--pattern:")) {
 				Console.Error.WriteLine ("Usage: TestRunner [negative|positive] test-pattern compiler know-issues log-file");
 				return 1;
 			}
 
 			string mode = args[0].ToLower ();
-			string test_pattern = args [1];
+			string test_pattern = args [1].Substring (10);
 			string mcs = args [2];
 			string issue_file = args [3];
 			string log_fname = args [4];
Index: tests/Makefile
===================================================================
--- tests/Makefile	(revision 57938)
+++ tests/Makefile	(working copy)
@@ -64,7 +64,7 @@
 TEST_ILS := $(wildcard *-lib.il)
 
 run-test-local: $(TEST_ILS:.il=.dll)
-	MONO_RUNTIME='$(RUNTIME)' $(TEST_RUNTIME) $(RUNTIME_FLAGS) $(topdir)/class/lib/$(PROFILE)/compiler-tester.exe positive $(TEST_PATTERN) $(COMPILER) known-issues-$(COMPILER_NAME) $(COMPILER_NAME).log
+	MONO_RUNTIME='$(RUNTIME)' $(TEST_RUNTIME) $(RUNTIME_FLAGS) $(topdir)/class/lib/$(PROFILE)/compiler-tester.exe positive --pattern:$(TEST_PATTERN) $(COMPILER) known-issues-$(COMPILER_NAME) $(COMPILER_NAME).log
 
 # do nothing for this target
 run-test-ondotnet-local:
Index: errors/Makefile
===================================================================
--- errors/Makefile	(revision 57938)
+++ errors/Makefile	(working copy)
@@ -68,7 +68,7 @@
 run-mcs-tests: $(TEST_SUPPORT_FILES)
 
 run-mcs-tests:
-	MONO_RUNTIME='$(RUNTIME)' $(TEST_RUNTIME) $(RUNTIME_FLAGS) $(topdir)/class/lib/$(PROFILE)/compiler-tester.exe negative $(TEST_PATTERN) $(COMPILER) known-issues-$(COMPILER_NAME) $(COMPILER_NAME).log
+	MONO_RUNTIME='$(RUNTIME)' $(TEST_RUNTIME) $(RUNTIME_FLAGS) $(topdir)/class/lib/$(PROFILE)/compiler-tester.exe negative --pattern:$(TEST_PATTERN) $(COMPILER) known-issues-$(COMPILER_NAME) $(COMPILER_NAME).log
 
 clean-local:
 	rm -f *.exe *.dll *.log *.mdb dummy.xml *.junk