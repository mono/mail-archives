Index: ChangeLog
===================================================================
--- ChangeLog	(revision 46756)
+++ ChangeLog	(working copy)
@@ -1,3 +1,9 @@
+2005-06-30  Andrew Skiba  <andrews@mainsoft.com>
+
+	* Makefile: change targets for nunit based tests
+	* xmlconf.cs: remove support for standalone test, add few modes
+	for nunit.
+ 
 2005-06-28  Andrew Skiba  <andrews@mainsoft.com>
 
 	* Makefile, xmlconf.cs: add nunit support
Index: xmlconf.cs
===================================================================
--- xmlconf.cs	(revision 46756)
+++ xmlconf.cs	(working copy)
@@ -1,395 +1,252 @@
-using System;
-using System.Xml;
-using System.IO;
-using System.Collections;
-using System.ComponentModel;
-using System.Reflection;
-using System.Text;
-
-namespace MonoTests.stand_alone {
-#if NUNIT_SUPPORT
-	using NUnit.Core;
-	using NUnit.Framework;
-#endif
-
-	class AllTests: IDisposable {
-		
-		#region Command Line Options Handling
-
-		class CommandLineOptionAttribute:Attribute{
-			char _short;
-			string _long; //FIXME: use long form, too
-			public CommandLineOptionAttribute (char a_short, string a_long):base() {
-				_short = a_short;
-				_long = a_long;
-			}
-			
-			public CommandLineOptionAttribute (char a_short):this (a_short, null) {
-			}
-
-			public override string ToString() {
-				return _short.ToString();
-			}
-
-			public string Long {
-				get {
-					return _long;
-				}
-			}
-		}
-
-		static void PrintUsage () {
-			Console.Error.WriteLine("Usage: xmlconf <flags>");
-			Console.Error.WriteLine("\tFlags:");
-			foreach (DictionaryEntry de in AllTests.GetOptions())
-				Console.Error.WriteLine ("\t{0}\t{1}", de.Key, de.Value);
-		}
-
-		public static Hashtable GetOptions() {
-			Hashtable h = new Hashtable();
-
-			foreach (FieldInfo i in typeof (AllTests).GetFields()) {
-				//FIXME: handle long options, too
-				string option = "-" + i.GetCustomAttributes(typeof(CommandLineOptionAttribute),
-					true)[0].ToString();
-				string descr = (i.GetCustomAttributes(typeof(DescriptionAttribute),
-					true)[0] as DescriptionAttribute).Description;
-				h[option] = descr;
-			}
-			return h;
-		}
-
-		public bool ParseOptions () {
-			if (_args == null || _args.Length == 0)
-				return true;
-			if(_args[0].Length < 2 || _args[0][0] != '-') {
-				PrintUsage();
-				return false;
-			}
-			string options = _args[0].Substring(1); //FIXME: handle long options
-			foreach (FieldInfo i in typeof (AllTests).GetFields (BindingFlags.NonPublic
-				| BindingFlags.Instance)) {
-				//FIXME: report if unknown options were passed
-				object [] attrs = i.GetCustomAttributes(typeof(CommandLineOptionAttribute),true);
-				if (attrs.Length == 0)
-					continue;
-				string option = attrs[0].ToString();
-				if (options.IndexOf(option) == -1)
-					continue;
-				i.SetValue (this, true);
-			}
-			return true;
-		}
-		#endregion
-
-		string [] _args;
-
-		#region statistics fields
-		int totalCount = 0;
-		int performedCount = 0;
-		int passedCount = 0;
-		int failedCount = 0;
-		int regressionsCount = 0; //failures not listed in knownFailures.lst
-		int fixedCount = 0; //tested known to fail that passed
-		#endregion
-
-		#region test list fields
-		ArrayList slowTests = new ArrayList ();
-		ArrayList igroredTests = new ArrayList ();
-		ArrayList knownFailures = new ArrayList ();
-		ArrayList fixmeList = new ArrayList ();
-		ArrayList netFailures = new ArrayList ();
-		StreamWriter failedListWriter;
-		StreamWriter fixedListWriter;
-		StreamWriter slowNewListWriter;
-		StreamWriter totalListWriter;
-		#endregion
+using System;
+using System.Xml;
+using System.IO;
+using System.Collections;
+using System.Text;
 
+namespace MonoTests.W3C_xmlconf {
+	using NUnit.Core;
+	using NUnit.Framework;
+
+	abstract class BaseTests: IDisposable
+	{
+		TestSuite _suite;
+
 		#region IDisposable Members
-		public void Dispose()
-		{
-			if (failedListWriter != null)
-				failedListWriter.Close ();
-			if (fixedListWriter != null)
-				fixedListWriter.Close ();
-			if (slowNewListWriter != null)
-				slowNewListWriter.Close ();
-			if (totalListWriter != null)
-				totalListWriter.Close ();
-			failedListWriter = null;
-			fixedListWriter = null;
-			slowNewListWriter = null;
-			totalListWriter = null;
+		public void Dispose() {
 		}
 		#endregion
-
-		#region command line option fields
-		[CommandLineOption ('s')]
-		[Description ("do run slow tests (skipped by default)")]
-		bool runSlow = false;
-
-		[CommandLineOption ('i')]
-		[Description ("do run tests being ignored by default")]
-		bool runIgnored = false;
-		#endregion
-
-		static int Main (string[] args)
-		{
-			using (AllTests tests = new AllTests (args)) {
-				if (!tests.Run ())
-					return 1;
-				else
-					return 0;
-			}		
-		}
-
-#if NUNIT_SUPPORT
-		TestSuite _suite;
-
-		[Suite]
-		static public TestSuite Suite {
-			get {
-				TestSuite suite = new TestSuite ("W3C_xmlconf");
-				using (AllTests tests = new AllTests (suite)) {
-					tests.Run ();
-				}
-				return suite;
-			}
-		}
-
-		AllTests (TestSuite suite)
-			: this () {
-			_suite = suite;
-		}
-#endif
-
-		AllTests (string [] args)
-			: this () {
-			_args = args;
-		}
-
-		#region ReadStrings ()
-		static void ReadStrings (ArrayList array, string filename)
-		{
-			if (!File.Exists (filename))
-				return;
-
-			using (StreamReader reader = new StreamReader (filename)) {
+
+		#region test list fields
+		protected readonly ArrayList igroredTests = new ArrayList ();
+		protected readonly ArrayList knownFailures = new ArrayList ();
+		protected readonly ArrayList fixmeList = new ArrayList ();
+		protected readonly ArrayList netFailures = new ArrayList ();
+		#endregion
+
+		#region ReadStrings ()
+		static void ReadStrings (ArrayList array, string filename) {
+			if (!File.Exists (filename))
+				return;
+
+			using (StreamReader reader = new StreamReader (filename)) {
 				foreach (string s_ in reader.ReadToEnd ().Split ("\n".ToCharArray ())) {
 					string s = s_.Trim ();
 					if (s.Length > 0)
 						array.Add (s);
-				}
-			}
-		}
-		#endregion
-
-		private AllTests ()
-		{
-			failedListWriter = new StreamWriter ("failed.lst", false);
-			fixedListWriter = new StreamWriter ("fixed.lst", false);
-			slowNewListWriter = new StreamWriter ("slow-new.lst", false);
-			totalListWriter = new StreamWriter ("total.lst", false);
-			ReadStrings (slowTests, "slow.lst");
-			ReadStrings (igroredTests, "ignored.lst");
-			ReadStrings (knownFailures, "knownFailures.lst");
-			ReadStrings (fixmeList, "fixme.lst");
-			ReadStrings (netFailures, "net-failed.lst");
-		}
-
-		bool Run ()
-		{
-			bool res = true;
-			if (!ParseOptions ())
-				return false;
-
-			XmlDocument catalog = new XmlDocument ();
-			catalog.Load ("xmlconf/xmlconf.xml");
-			
-			foreach (XmlElement test in catalog.SelectNodes ("//TEST")) {
-				++totalCount;
-
-				string testId = test.GetAttribute ("ID");
-				
-				if (!runSlow && slowTests.Contains (testId)) {
-					continue;
-				}
-
-				if (!runIgnored && igroredTests.Contains (testId)) {
-					continue;
-				}
-
-				DateTime start = DateTime.Now;
-				if (!PerformTest (test))
-					res = false;
-				TimeSpan span = DateTime.Now - start;
-				if (span.TotalSeconds > 1) {
-					if (slowTests.Contains (testId))
-						continue;
-					slowNewListWriter.WriteLine (testId);
-				}
-			}
-
-			Console.Error.WriteLine ("\n\n*********");
-			Console.Error.WriteLine ("Total:{0}", totalCount);
-			Console.Error.WriteLine ("Performed:{0}", performedCount);
-			Console.Error.WriteLine ("Passed:{0}", passedCount);
-			Console.Error.WriteLine ("Failed:{0}", failedCount);
-			Console.Error.WriteLine ("Regressions:{0}", regressionsCount);
-			Console.Error.WriteLine ("Fixed:{0}\n", fixedCount);
-
-			if (fixedCount > 0)
-				Console.Error.WriteLine (@"
-
-ATTENTION!
-Delete the fixed tests (those listed in fixed.lst) from
-knownFailures.lst or fixme.lst, or we might miss
-regressions in the future.");
-
-			if (regressionsCount > 0)
-				Console.Error.WriteLine (@"
-
-ERROR!!! New regressions!
-If you see this message for the first time, your last changes had
-introduced new bugs! Before you commit, consider one of the following:
-
-1. Find and fix the bugs, so tests will pass again.
-2. Open new bugs in bugzilla and temporily add the tests to fixme.lst
-3. Write to devlist and confirm adding the new tests to knownFailures.lst");
-
-			return res;
-		}
-
-		bool PerformTest (XmlElement test)
-		{
-			++performedCount;
-
-			string type = test.GetAttribute ("TYPE");
-			if (type == "error")
-				return true; //save time
-
-			Uri baseUri = new Uri (test.BaseURI);
-			Uri testUri = new Uri (baseUri, test.GetAttribute ("URI"));
-
-			bool validatingPassed;
-			bool nonValidatingPassed;
-			try {
-				XmlTextReader trd = new XmlTextReader (testUri.ToString ());
-				new XmlDocument ().Load (trd);
-				nonValidatingPassed = true;
-			}
-			catch (Exception) {
-				nonValidatingPassed = false;
-			}
-
-			try {
-				XmlTextReader rd = new XmlTextReader (testUri.ToString ());
-				XmlValidatingReader vrd = new XmlValidatingReader (rd);
-				new XmlDocument ().Load (vrd);
-				validatingPassed = true;
-			}
-			catch (Exception) {
-				validatingPassed = false;
-			}
-			bool res = isOK (type, nonValidatingPassed, validatingPassed);
-			
-			return Report (testUri, test, res, nonValidatingPassed, validatingPassed);
-		}
-
-		bool isOK (string type, bool nonValidatingPassed, bool validatingPassed)
-		{
-			switch (type) {
-			case "valid":
-				return nonValidatingPassed && validatingPassed;
-			case "invalid":
-				return nonValidatingPassed && !validatingPassed;
-			case "not-wf":
-				return !nonValidatingPassed && !validatingPassed;
-			case "error":
-				return true; //readers can optionally accept or reject errors
-			default:
-				throw new ArgumentException ("Bad test type", "type");
-			}
-		}
-
-		bool Report (Uri testUri, XmlElement test, bool isok, bool nonValidatingPassed, bool validatingPassed)
-		{
-			string testId = test.GetAttribute ("ID");
-
-#if NUNIT_SUPPORT
-			if (_suite != null) {
-				StringBuilder sb = new StringBuilder();
-				sb.Append (testUri.ToString ());
-				sb.Append (test.InnerXml);
-				_suite.Add (new PredefinedTest (testId, isok, sb.ToString ()));
-				return true;
-			}
-#endif
-
-			totalListWriter.Write (testUri.ToString () + "\t");
-			totalListWriter.Write (testId + "\t");
-
-			if (isok) {
-				++passedCount;
-				if (fixmeList.Contains (testId) || knownFailures.Contains (testId)) {
-					++fixedCount;
-					fixedListWriter.WriteLine (testId);
-					Console.Error.Write ("!");
-					totalListWriter.WriteLine ("fixed");
-					return true;
-				}
-				if (netFailures.Contains (testId)) {
-					Console.Error.Write (",");
-					totalListWriter.WriteLine (",");
-					return true;
-				}
-
-				Console.Error.Write (".");
-				totalListWriter.WriteLine (".");
-				return true;
-			}
-
-			++failedCount;
-
-			if (netFailures.Contains (testId)) {
-				Console.Error.Write ("K");
-				totalListWriter.WriteLine ("dot net known failure");
-				return true;
-			}
-			if (knownFailures.Contains (testId)) {
-				Console.Error.Write ("k");
-				totalListWriter.WriteLine ("known failure");
-				return true;
-			}
-			if (fixmeList.Contains (testId)) {
-				Console.Error.Write ("f");
-				totalListWriter.WriteLine ("fixme");
-				return true;
-			}
-
-			++regressionsCount;
-			Console.Error.Write ("E");
-			totalListWriter.WriteLine ("regression");
-			failedListWriter.Write ("*** Test failed:\t{0}\ttype:{1}\tnonValidatingPassed:{2},validatingPassed:{3}\t",
-				testId, test.GetAttribute ("TYPE"), nonValidatingPassed, validatingPassed);
-			failedListWriter.WriteLine (test.InnerXml);
-			return false;
-		}
-	}
-
-	public class PredefinedTest: NUnit.Core.TestCase {
-		bool _res;
-		string _message;
-		public PredefinedTest (string name, bool res, string message):base (null, name) {
-			_res = res;
-			_message = message;
-		}
-
-		public override void Run (TestCaseResult res) {
-			if (_res)
-				res.Success ();
-			else
-				res.Failure (_message, null);
-		}
-	}
-}
+				}
+			}
+		}
+		#endregion
+
+		protected BaseTests (TestSuite suite)
+			:this ()
+		{
+			_suite = suite;
+		}
+
+		private BaseTests ()
+		{
+			ReadStrings (igroredTests, "ignored.lst");
+			ReadStrings (knownFailures, "knownFailures.lst");
+			ReadStrings (fixmeList, "fixme.lst");
+			ReadStrings (netFailures, "net-failed.lst");
+		}
+
+		protected void BuildSuite ()
+		{
+			XmlDocument catalog = new XmlDocument ();
+			catalog.Load ("xmlconf/xmlconf.xml");
+			
+			foreach (XmlElement test in catalog.SelectNodes ("//TEST")) {
+				string testId = test.GetAttribute ("ID");
+				
+				ProcessTest (testId, test);
+			}
+		}
+
+		protected virtual bool InverseResult {
+			get {return false;}
+		}
+
+		protected virtual void ProcessTest (string testId, XmlElement test)
+		{
+			if (igroredTests.Contains (testId))
+				return;
+
+			if (netFailures.Contains (testId))
+				return;
+
+			//				DateTime start = DateTime.Now;
+			_suite.Add (new TestFromCatalog (testId, test, InverseResult));
+			//				TimeSpan span = DateTime.Now - start;
+			//				if (span.TotalSeconds > 1) {
+			//					if (slowTests.Contains (testId))
+			//						continue;
+			//					slowNewListWriter.WriteLine (testId);
+			//				}
+		}
+	}
+
+	class AllTests: BaseTests
+	{
+		[Suite]
+		static public TestSuite Suite{
+			get {
+				TestSuite suite = new TestSuite ("W3C_xmlconf.Clean");
+				using (AllTests tests = new AllTests (suite)) {
+					tests.BuildSuite ();
+				}
+				return suite;
+			}
+		}
+
+		AllTests (TestSuite suite)
+			: base (suite)
+		{
+		}
+	}
+
+	class CleanTests: BaseTests {
+		[Suite]
+		static public TestSuite Suite{
+			get {
+				TestSuite suite = new TestSuite ("W3C_xmlconf.Clean");
+				using (CleanTests tests = new CleanTests (suite)) {
+					tests.BuildSuite ();
+				}
+				return suite;
+			}
+		}
+
+		CleanTests (TestSuite suite)
+			: base (suite)
+		{
+		}
+
+		protected override void ProcessTest(string testId, XmlElement test)
+		{
+			if (knownFailures.Contains (testId) || fixmeList.Contains (testId))
+				return;
+
+			base.ProcessTest (testId, test);
+		}
+	}
+
+	class KnownFailureTests: BaseTests {
+		[Suite]
+		static public TestSuite Suite{
+			get {
+				TestSuite suite = new TestSuite ("W3C_xmlconf.Clean");
+				using (KnownFailureTests tests = new KnownFailureTests (suite)) {
+					tests.BuildSuite ();
+				}
+				return suite;
+			}
+		}
+
+		KnownFailureTests (TestSuite suite)
+			: base (suite)
+		{
+		}
+
+		protected override bool InverseResult {
+			get {return true;}
+		}
+
+		protected override void ProcessTest(string testId, XmlElement test)
+		{
+			if (!knownFailures.Contains (testId) && !fixmeList.Contains (testId))
+				return;
+
+			base.ProcessTest (testId, test);
+		}
+	}
+
+	class TestFromCatalog: NUnit.Core.TestCase
+	{
+		XmlElement _test;
+		string _stackTrace;
+		bool _inverseResult;
+
+		public TestFromCatalog (string testId, XmlElement test, bool inverseResult)
+			:base (null, testId)
+		{
+			_test=test;
+			_inverseResult=inverseResult;
+		}
+
+		bool TestNonValidating (string uri)
+		{
+			try {
+				XmlTextReader trd = new XmlTextReader (uri);
+				new XmlDocument ().Load (trd);
+				return true;
+			}
+			catch (Exception e) {
+				_stackTrace = e.StackTrace;
+				return false;
+			}
+		}
+
+		bool TestValidating (string uri)
+		{
+			try {
+				XmlTextReader rd = new XmlTextReader (uri);
+				XmlValidatingReader vrd = new XmlValidatingReader (rd);
+				new XmlDocument ().Load (vrd);
+				return true;
+			}
+			catch (Exception e) {
+				_stackTrace = e.StackTrace; //rewrites existing, possibly, but it's ok
+				return false;
+			}
+		}
+
+		public override void Run (TestCaseResult res)
+		{
+			string type = _test.GetAttribute ("TYPE");
+			if (type == "error")
+				res.Success ();
+
+			Uri baseUri = new Uri (_test.BaseURI);
+			Uri testUri = new Uri (baseUri, _test.GetAttribute ("URI"));
+
+			bool nonValidatingPassed = TestNonValidating (testUri.ToString ());
+			bool validatingPassed = TestValidating (testUri.ToString ());
+		
+			bool isok = isOK (type, nonValidatingPassed, validatingPassed);
+			string message="";
+			if (_inverseResult) {
+				isok = !isok;
+				message = "The following test was FIXED:\n";
+			}
+
+			if (isok)
+				res.Success ();
+			else {
+				message += "type:"+type;
+				message += " non-validating passed:"+nonValidatingPassed.ToString();
+				message += " validating passed:"+validatingPassed.ToString();
+				message += " description:"+_test.InnerText;
+				res.Failure (message, _stackTrace);
+			}
+		}
+
+		static bool isOK (string type, bool nonValidatingPassed, bool validatingPassed)
+		{
+			switch (type) {
+			case "valid":
+				return nonValidatingPassed && validatingPassed;
+			case "invalid":
+				return nonValidatingPassed && !validatingPassed;
+			case "not-wf":
+				return !nonValidatingPassed && !validatingPassed;
+			case "error":
+				return true; //readers can optionally accept or reject errors
+			default:
+				throw new ArgumentException ("Bad test type", "type");
+			}
+		}
+	}
+}
Index: Makefile
===================================================================
--- Makefile	(revision 46756)
+++ Makefile	(working copy)
@@ -1,23 +1,37 @@
-.SUFFIXES: .cs .exe
+.SUFFIXES: .cs .exe .dll
 
 RUNTIME=mono
 XMLCONF_OPTIONS=
 CSCOMPILE=mcs
-ifndef NO_NUNIT
 REFERENCES=-d:NUNIT_SUPPORT -r:NUnit.Core -r:NUnit.Framework
-endif
 TEST_ARCHIVE=xmlts20031210.zip
 TEST_CATALOG=xmlconf/xmlconf.xml
-TEST_PROG=xmlconf.exe
+TEST_PROG=xmlconf.dll
+nunit_MONO_PATH="../../../../../class/lib/default"
+NUNIT_CONSOLE=/monobuild/mono/runtime/mono-wrapper --debug $(nunit_MONO_PATH)/nunit-console.exe
+
+CLEAN_FIXTURE=MonoTests.W3C_xmlconf.CleanTests
+CLEAN_NUNIT_FLAGS=/fixture:$(CLEAN_FIXTURE) /xml=TestsResult.xml
+
+FAILING_FIXTURE=MonoTests.W3C_xmlconf.KnownFailureTests
+FAILING_NUNIT_FLAGS=/fixture:$(FAILING_FIXTURE) /xml=FailingTestsResult.xml
+
+ALL_FIXTURE=MonoTests.W3C_xmlconf.AllTests
+ALL_NUNIT_FLAGS=/fixture:$(ALL_FIXTURE) /xml=AllTestsResult.xml /out=AllTestsResult.log
+
+
 
 test: $(TEST_PROG) $(TEST_CATALOG)
 
-run-test: test
-	$(RUNTIME) $(TEST_PROG) $(XMLCONF_OPTIONS)
-
-run-nunit-test: test
-	MONO_PATH="../../../../../class/lib/default;;$(MONO_PATH)" /monobuild/mono/runtime/mono-wrapper --debug ../../../../../class/lib/default/nunit-console.exe $(TEST_PROG) /fixture:MonoTests.stand_alone.AllTests /xml=TestResult.xml /out=TestResult.log
+run-test: test
+	MONO_PATH="$(nunit_MONO_PATH);$(MONO_PATH)" $(NUNIT_CONSOLE) $(TEST_PROG) $(CLEAN_NUNIT_FLAGS)
 
+run-failing-test: test
+	MONO_PATH="$(nunit_MONO_PATH);$(MONO_PATH)" $(NUNIT_CONSOLE) $(TEST_PROG) $(FAILING_NUNIT_FLAGS)
+
+run-all-test: test
+	MONO_PATH="$(nunit_MONO_PATH);$(MONO_PATH)" $(NUNIT_CONSOLE) $(TEST_PROG) $(ALL_NUNIT_FLAGS)
+
 test_archive: $(TEST_ARCHIVE)
 
 test_catalog: $(TEST_CATALOG)
@@ -29,6 +43,6 @@
 	mkdir xmlconf; unzip -un $(TEST_ARCHIVE)
 	touch $(TEST_CATALOG)
 
-.cs.exe :
-	$(CSCOMPILE) $< $(REFERENCES)
+.cs.dll:
+	$(CSCOMPILE) /t:library $< $(REFERENCES)
 
