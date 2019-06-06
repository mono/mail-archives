Index: ChangeLog
===================================================================
--- ChangeLog	(revision 46515)
+++ ChangeLog	(working copy)
@@ -1,3 +1,9 @@
+2005-06-26  Andrew Skiba  <andrews@mainsoft.com>
+
+	* xmlconf.cs, Makefile: add nunit support
+	* knownFailures.lst: remove fixed testcases
+	* ignored.lst: add a test which causes mono runtime to hang
+
 2005-06-14  Andrew Skiba  <andrews@mainsoft.com>
 
 	* fixme.lst : remove testcases fixed by r45935
Index: knownFailures.lst
===================================================================
--- knownFailures.lst	(revision 46515)
+++ knownFailures.lst	(working copy)
@@ -1,14 +1,11 @@
 not-wf-sa-031
 not-wf-sa-072
-not-wf-sa-077
-not-wf-sa-115
 not-wf-sa-116
 not-wf-sa-142
 not-wf-sa-143
 not-wf-sa-146
 not-wf-sa-153
 not-wf-sa-162
-not-wf-sa-170
 not-wf-sa-172
 not-wf-sa-173
 not-wf-sa-174
@@ -25,12 +22,10 @@
 not-sa03
 not-sa04
 sa02
-sa03
 sa04
 ibm-invalid-P49-ibm49i01.xml
 ibm-invalid-P50-ibm50i01.xml
 ibm-invalid-P51-ibm51i01.xml
-ibm-not-wf-P66-ibm66n03.xml
 ibm-not-wf-P77-ibm77n01.xml
 rmt-e2e-14
 rmt-e2e-15a
@@ -40,10 +35,6 @@
 rmt-e2e-18
 rmt-ns10-015
 rmt-ns10-023
-rmt-ns10-029
-rmt-ns10-031
-rmt-ns10-032
-rmt-ns10-033
 rmt-ns10-042
 rmt-ns10-043
 rmt-ns10-044
Index: ignored.lst
===================================================================
--- ignored.lst	(revision 0)
+++ ignored.lst	(revision 0)
@@ -0,0 +1 @@
+rmt-ns10-011
Index: xmlconf.cs
===================================================================
--- xmlconf.cs	(revision 46515)
+++ xmlconf.cs	(working copy)
@@ -4,9 +4,15 @@
 using System.Collections;
 using System.ComponentModel;
 using System.Reflection;
+using System.Text;
 
-namespace XmlConfTest {
-	class XmlConfTest: IDisposable {
+namespace MonoTests.stand_alone {
+#if NUNIT_SUPPORT
+	using NUnit.Core;
+	using NUnit.Framework;
+#endif
+
+	class AllTests: IDisposable {
 		
 		#region Command Line Options Handling
 
@@ -35,14 +41,14 @@
 		static void PrintUsage () {
 			Console.Error.WriteLine("Usage: xmlconf <flags>");
 			Console.Error.WriteLine("\tFlags:");
-			foreach (DictionaryEntry de in XmlConfTest.GetOptions())
+			foreach (DictionaryEntry de in AllTests.GetOptions())
 				Console.Error.WriteLine ("\t{0}\t{1}", de.Key, de.Value);
 		}
 
 		public static Hashtable GetOptions() {
 			Hashtable h = new Hashtable();
 
-			foreach (FieldInfo i in typeof (XmlConfTest).GetFields()) {
+			foreach (FieldInfo i in typeof (AllTests).GetFields()) {
 				//FIXME: handle long options, too
 				string option = "-" + i.GetCustomAttributes(typeof(CommandLineOptionAttribute),
 					true)[0].ToString();
@@ -54,14 +60,14 @@
 		}
 
 		public bool ParseOptions () {
-			if (_args.Length < 1)
+			if (_args == null || _args.Length == 0)
 				return true;
 			if(_args[0].Length < 2 || _args[0][0] != '-') {
 				PrintUsage();
 				return false;
 			}
 			string options = _args[0].Substring(1); //FIXME: handle long options
-			foreach (FieldInfo i in typeof (XmlConfTest).GetFields (BindingFlags.NonPublic
+			foreach (FieldInfo i in typeof (AllTests).GetFields (BindingFlags.NonPublic
 				| BindingFlags.Instance)) {
 				//FIXME: report if unknown options were passed
 				object [] attrs = i.GetCustomAttributes(typeof(CommandLineOptionAttribute),true);
@@ -129,14 +135,39 @@
 
 		static int Main (string[] args)
 		{
-			using (XmlConfTest test = new XmlConfTest (args)) {
-				if (!test.Run ())
+			using (AllTests tests = new AllTests (args)) {
+				if (!tests.Run ())
 					return 1;
 				else
 					return 0;
 			}		
 		}
 
+#if NUNIT_SUPPORT
+		TestSuite _suite;
+
+		[Suite]
+		static public TestSuite Suite {
+			get {
+				TestSuite suite = new TestSuite ("W3C_xmlconf");
+				using (AllTests tests = new AllTests (suite)) {
+					tests.Run ();
+				}
+				return suite;
+			}
+		}
+
+		AllTests (TestSuite suite)
+			: this () {
+			_suite = suite;
+		}
+#endif
+
+		AllTests (string [] args)
+			: this () {
+			_args = args;
+		}
+
 		#region ReadStrings ()
 		static void ReadStrings (ArrayList array, string filename)
 		{
@@ -153,9 +184,8 @@
 		}
 		#endregion
 
-		XmlConfTest (string [] args)
+		private AllTests ()
 		{
-			_args = args;
 			failedListWriter = new StreamWriter ("failed.lst", false);
 			fixedListWriter = new StreamWriter ("fixed.lst", false);
 			slowNewListWriter = new StreamWriter ("slow-new.lst", false);
@@ -241,8 +271,6 @@
 			Uri baseUri = new Uri (test.BaseURI);
 			Uri testUri = new Uri (baseUri, test.GetAttribute ("URI"));
 
-			totalListWriter.Write (testUri.ToString () + "\t");
-
 			bool validatingPassed;
 			bool nonValidatingPassed;
 			try {
@@ -265,7 +293,7 @@
 			}
 			bool res = isOK (type, nonValidatingPassed, validatingPassed);
 			
-			return Report (test, res, nonValidatingPassed, validatingPassed);
+			return Report (testUri, test, res, nonValidatingPassed, validatingPassed);
 		}
 
 		bool isOK (string type, bool nonValidatingPassed, bool validatingPassed)
@@ -284,9 +312,21 @@
 			}
 		}
 
-		bool Report (XmlElement test, bool isok, bool nonValidatingPassed, bool validatingPassed)
+		bool Report (Uri testUri, XmlElement test, bool isok, bool nonValidatingPassed, bool validatingPassed)
 		{
 			string testId = test.GetAttribute ("ID");
+
+#if NUNIT_SUPPORT
+			if (_suite != null) {
+				StringBuilder sb = new StringBuilder();
+				sb.Append (testUri.ToString ());
+				sb.Append (test.InnerXml);
+				_suite.Add (new PredefinedTest (testId, isok, sb.ToString ()));
+				return true;
+			}
+#endif
+
+			totalListWriter.Write (testUri.ToString () + "\t");
 			totalListWriter.Write (testId + "\t");
 
 			if (isok) {
@@ -336,4 +376,20 @@
 			return false;
 		}
 	}
+
+	public class PredefinedTest: NUnit.Core.TestCase {
+		bool _res;
+		string _message;
+		public PredefinedTest (string name, bool res, string message):base (null, name) {
+			_res = res;
+			_message = message;
+		}
+
+		public override void Run (TestCaseResult res) {
+			if (_res)
+				res.Success ();
+			else
+				res.Failure (_message, null);
+		}
+	}
 }
Index: Makefile
===================================================================
--- Makefile	(revision 46515)
+++ Makefile	(working copy)
@@ -3,6 +3,9 @@
 RUNTIME=mono
 XMLCONF_OPTIONS=
 CSCOMPILE=mcs
+ifndef NO_NUNIT
+REFERENCES=-d:NUNIT_SUPPORT -r:NUnit.Core -r:NUnit.Framework
+endif
 TEST_ARCHIVE=xmlts20031210.zip
 TEST_CATALOG=xmlconf/xmlconf.xml
 TEST_PROG=xmlconf.exe
@@ -12,6 +15,9 @@
 run-test: test
 	$(RUNTIME) $(TEST_PROG) $(XMLCONF_OPTIONS)
 
+run-nunit-test: test
+	MONO_PATH="../../../../../class/lib/default;;$(MONO_PATH)" /monobuild/mono/runtime/mono-wrapper --debug ../../../../../class/lib/default/nunit-console.exe $(TEST_PROG) /fixture:MonoTests.stand_alone.AllTests /xml=TestResult.xml /out=TestResult.log
+
 test_archive: $(TEST_ARCHIVE)
 
 test_catalog: $(TEST_CATALOG)
@@ -24,5 +30,5 @@
 	touch $(TEST_CATALOG)
 
 .cs.exe :
-	$(CSCOMPILE) $<
+	$(CSCOMPILE) $< $(REFERENCES)
 
