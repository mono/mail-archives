Index: xmlconf.cs
===================================================================
--- xmlconf.cs	(revision 45183)
+++ xmlconf.cs	(working copy)
@@ -24,6 +24,12 @@
 			public override string ToString() {
 				return _short.ToString();
 			}
+
+			public string Long {
+				get {
+					return _long;
+				}
+			}
 		}
 
 		static void PrintUsage () {
@@ -86,8 +92,11 @@
 		ArrayList slowTests = new ArrayList ();
 		ArrayList igroredTests = new ArrayList ();
 		ArrayList knownFailures = new ArrayList ();
+		ArrayList fixmeList = new ArrayList ();
+		ArrayList netFailures = new ArrayList ();
 		StreamWriter failedList;
 		StreamWriter fixedList;
+		StreamWriter slowNewList;
 		#endregion
 
 		#region command line option fields
@@ -129,9 +138,12 @@
 			_args = args;
 			failedList = new StreamWriter ("failed.lst", false);
 			fixedList = new StreamWriter ("fixed.lst", false);
+			slowNewList = new StreamWriter ("slow-new.lst", false);
 			ReadStrings (slowTests, "slow.lst");
 			ReadStrings (igroredTests, "ignored.lst");
 			ReadStrings (knownFailures, "knownFailures.lst");
+			ReadStrings (fixmeList, "fixme.lst");
+			ReadStrings (netFailures, "net-failed.lst");
 		}
 
 		bool Run ()
@@ -157,24 +169,39 @@
 				}
 
 				DateTime start = DateTime.Now;
-				res &= PerformTest (test);	
+				res = PerformTest (test) && res;
 				TimeSpan span = DateTime.Now - start;
 				if (span.TotalSeconds > 1) {
 					if (slowTests.Contains (testId))
 						continue;
-					using (StreamWriter wr = new StreamWriter("slow.lst", true))
-						wr.WriteLine (testId);
+					slowNewList.WriteLine (testId);
+					slowNewList.Flush ();
 				}
 			}
 
-			Console.Error.WriteLine ("\n*********");
+			Console.Error.WriteLine ("\n\n*********");
 			Console.Error.WriteLine ("Total:{0}", totalCount);
 			Console.Error.WriteLine ("Performed:{0}", performedCount);
 			Console.Error.WriteLine ("Passed:{0}", passedCount);
 			Console.Error.WriteLine ("Failed:{0}", failedCount);
 			Console.Error.WriteLine ("Regressions:{0}", regressionsCount);
-			Console.Error.WriteLine ("Fixed:{0}", fixedCount);
+			Console.Error.WriteLine ("Fixed:{0}\n", fixedCount);
 
+			if (fixedCount > 0)
+				Console.Error.WriteLine (@"ATTENTION!!! ATTENTION!!! ATTENTION!!!
+You must delete the fixed tests (those listed in fixed.lst) from
+knownFailures.lst or fixme.lst. If you don't do it, you can miss
+regressions in the future.");
+
+			if (regressionsCount > 0)
+				Console.Error.WriteLine (@"ERROR!!! New regressions!
+If you see this message for the first time, your last changes had
+introduced new bugs! Before you commit, you must do one of the following:
+
+1. Find and fix the bugs, so tests will pass again.
+2. Open new bugs in bugzilla and temporily add the tests to fixme.lst
+3. Write to devlist and confirm adding the new tests to knownFailures.lst");
+
 			return res;
 		}
 
@@ -209,8 +236,8 @@
 				validatingPassed = false;
 			}
 			bool res = isOK (type, nonValidatingPassed, validatingPassed);
-			Report (test, res, nonValidatingPassed, validatingPassed);
-			return res;
+			
+			return Report (test, res, nonValidatingPassed, validatingPassed);
 		}
 
 		bool isOK (string type, bool nonValidatingPassed, bool validatingPassed)
@@ -229,27 +256,41 @@
 			}
 		}
 
-		void Report (XmlElement test, bool isok, bool nonValidatingPassed, bool validatingPassed)
+		bool Report (XmlElement test, bool isok, bool nonValidatingPassed, bool validatingPassed)
 		{
 			string testId = test.GetAttribute ("ID");
 
 			if (isok) {
 				++passedCount;
-				if (knownFailures.Contains (testId)) {
+				if (fixmeList.Contains (testId) || knownFailures.Contains (testId)) {
 					++fixedCount;
 					fixedList.WriteLine (testId);
+					Console.Error.Write ("!");
+					return true;
 				}
+				if (netFailures.Contains (testId)) {
+					Console.Error.Write (",");
+					return true;
+				}
 
 				Console.Error.Write (".");
-				return;
+				return true;
 			}
 
 			++failedCount;
 
+			if (netFailures.Contains (testId)) {
+				Console.Error.Write ("K");
+				return true;
+			}
 			if (knownFailures.Contains (testId)) {
 				Console.Error.Write ("k");
-				return;
+				return true;
 			}
+			if (fixmeList.Contains (testId)) {
+				Console.Error.Write ("f");
+				return true;
+			}
 
 			++regressionsCount;
 			Console.Error.Write ("E");
@@ -257,6 +298,7 @@
 				testId, test.GetAttribute ("TYPE"), nonValidatingPassed, validatingPassed);
 			failedList.WriteLine (test.InnerXml);
 			failedList.Flush ();
+			return false;
 		}
 	}
 }
Index: README
===================================================================
--- README	(revision 45046)
+++ README	(working copy)
@@ -1 +1,34 @@
 This directory contains XML W3C Conformance Test Suite. See http://www.w3.org/XML/Test/ for more details
+
+1. Legend of the output.
+
+symbol	result	description
+---------------------
+.	pass	
+!	pass	test was fixed (was known as failing, now passed)
+K	fail	known as not working on dot net
+k	fail	known as not working on mono
+f	fail	listed in fixme.lst
+E	fail	ERROR: NEW REGRESSION(s)
+
+In case of E the xmlconf.exe exits with exit code 1 to signal regression(s).
+
+2. Special files.
+
+filename	in/out	description
+---------------------
+ignore.lst	in	tests to be ignored (please, add to README the reason for ignoring them)
+slow.lst	in	tests known to be slow (will be ignored if -s is not given)
+new-slow.lst	out	tests that took more than 1 sec to perform - consider adding them to slow.lst
+net-failed.lst	in	tests that known to fail on ms.net
+knownFailures.lst	in	known failures of mono
+fixme.lst	in	similar to knownFailures, but is not stored in svn (user-private list)
+failed.lst	out	new regressions list.
+fixed.lst	out	tests that should be deleted from knownFailures or fixme.lst
+
+3. Exit code
+
+0	Success - no new regressions
+1	new regressions
+2	invalid command line options
+
Index: Makefile
===================================================================
--- Makefile	(revision 45183)
+++ Makefile	(working copy)
@@ -1,6 +1,7 @@
 .SUFFIXES: .cs .exe
 
 RUNTIME=mono
+XMLCONF_OPTIONS=
 CSCOMPILE=mcs
 TEST_ARCHIVE=xmlts20031210.zip
 TEST_CATALOG=xmlconf/xmlconf.xml
@@ -9,7 +10,7 @@
 test: $(TEST_PROG)
 
 run-test: test
-	$(RUNTIME) $(TEST_PROG)
+	$(RUNTIME) $(TEST_PROG) $(XMLCONF_OPTIONS)
 
 test_archive: $(TEST_ARCHIVE)
 
