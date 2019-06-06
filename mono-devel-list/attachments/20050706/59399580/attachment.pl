
Property changes on: 
___________________________________________________________________
Name: svn:ignore
   - semantic.cache

   + AllTestResult.xml
AllTestResult.log
FailedTestResult.xml
testsuite
xslt-reference-results.tar.gz
results
domresults
xslt-testsuite-03.ZIP
xslttest.dll
missing.lst
generate.exe
TestResult.xml


Index: XsltTestUtils.cs
===================================================================
--- XsltTestUtils.cs	(revision 0)
+++ XsltTestUtils.cs	(revision 0)
@@ -0,0 +1,244 @@
+using System.Xml;
+using System.Xml.Xsl;
+using System.Xml.XPath;
+using System.Collections;
+using System.IO;
+
+namespace MonoTests.oasis_xslt {
+	class EnvOptions {
+		static readonly bool useDomStyle;
+		static readonly bool useDomInstance;
+		static readonly string outputDir;
+		static readonly bool whitespaceStyle;
+		static readonly bool whitespaceInstance;
+		static readonly bool inverseResults;
+
+		public static bool UseDomStyle {
+			get {return useDomStyle;}
+		}
+		public static bool UseDomInstance {
+			get {return useDomInstance;}
+		}
+		public static string OutputDir {
+			get {return outputDir;}
+		}
+		public static bool WhitespaceStyle {
+			get {return whitespaceStyle;}
+		}
+		public static bool WhitespaceInstance {
+			get {return whitespaceInstance;}
+		}
+		public static bool InverseResults {
+			get {return inverseResults;}
+		}
+
+		static EnvOptions () {
+			IDictionary env = System.Environment.GetEnvironmentVariables();
+			if (env.Contains ("XSLTTEST_DOM")) {
+				useDomStyle = true;
+				useDomInstance = true;
+			}
+			if (env.Contains ("XSLTTEST_DOMXSL"))
+				useDomStyle = true;
+			if (env.Contains ("XSLTTEST_DOMINSTANCE"))
+				useDomInstance = true;
+			if (env.Contains ("XSLTTEST_WS")) {
+				whitespaceStyle = true;
+				whitespaceInstance = true;
+			}
+			if (env.Contains ("XSLTTEST_WSXSL"))
+				whitespaceStyle = true;
+			if (env.Contains ("XSLTTEST_WSSRC"))
+				whitespaceInstance = true;
+	
+			if (env.Contains ("XSLTTEST_INVERSE_RESULTS"))
+				inverseResults = true;
+
+			if (useDomStyle || useDomInstance)
+				outputDir = "domresults";
+			else
+				outputDir = "results";
+		}
+	}
+
+	class Helpers
+	{
+		public static void ReadStrings (ArrayList array, string filename)
+		{
+			if (!File.Exists (filename))
+				return;
+
+			using (StreamReader reader = new StreamReader (filename)) {
+				foreach (string s_ in reader.ReadToEnd ().Split ("\n".ToCharArray ())) {
+					string s = s_.Trim ();
+					if (s.Length > 0)
+						array.Add (s);
+				}
+			}
+		}
+	}
+
+	class CatalogTestCase
+	{
+		string _stylesheet;
+		string _srcxml;
+		string _outfile;
+		XmlElement _testCase;
+		string _outputDir;
+
+		public CatalogTestCase (string outputDir, XmlElement testCase)
+		{
+			_testCase = testCase;
+			_outputDir = outputDir;
+		}
+
+		public bool Process ()
+		{
+			string relPath = GetRelPath ();
+
+			string path = Path.Combine (Path.Combine ("testsuite", "TESTS"), relPath);
+			string outputPath = Path.Combine (_outputDir, relPath);
+			if (!Directory.Exists (outputPath))
+				Directory.CreateDirectory (outputPath);
+
+			//FIXME: this ignores negative tests. Read README if you want to fix it
+			XmlNode scenario = _testCase.SelectSingleNode ("scenario[@operation='standard']");
+			if (scenario == null)
+				return false;
+
+			ProcessScenario (path, outputPath, scenario);
+			return true;
+		}
+
+		string GetRelPath ()
+		{
+			string filePath = _testCase.SelectSingleNode ("file-path").InnerText;
+			string submitter = _testCase.SelectSingleNode ("./parent::test-catalog/@submitter").InnerText;
+			if (submitter == "Lotus")
+				return Path.Combine ("Xalan_Conformance_Tests", filePath);
+			else if (submitter == "Microsoft")
+				return Path.Combine ("MSFT_Conformance_Tests", filePath);
+			else
+				throw new System.Exception ("unknown submitter in the catalog");
+		}
+
+
+		void ProcessScenario (string path, string outputPath, XmlNode scenario)
+		{ 
+			string stylesheetBase = scenario.SelectSingleNode ("input-file[@role='principal-stylesheet']").InnerText;
+			_stylesheet = Path.Combine (path, stylesheetBase);
+			if (!File.Exists (_stylesheet)) {
+				using (StreamWriter wr = new StreamWriter ("missing.lst", true))
+					wr.WriteLine (_stylesheet);
+			}
+
+			_srcxml = Path.Combine (path, scenario.SelectSingleNode ("input-file[@role='principal-data']").InnerText);
+			XmlNode outputNode = scenario.SelectSingleNode ("output-file[@role='principal']");
+			if (outputNode != null) 
+				_outfile = Path.Combine (outputPath, outputNode.InnerText);
+			else
+				_outfile = null;
+		}
+
+		public string StyleSheet {
+			get {return _stylesheet;}
+		}
+
+		public string SrcXml {
+			get {return _srcxml;}
+		}
+
+		public string OutFile {
+			get {return _outfile;}
+		}
+	}
+
+	class SingleTestTransform
+	{
+		CatalogTestCase _testCase;
+
+		public SingleTestTransform (CatalogTestCase testCase)
+		{
+			_testCase = testCase;
+		}
+
+		string _result;
+		public string Result {
+			get {return _result;}
+		}
+
+		System.Exception _exception;
+		public System.Exception Exception {
+			get {return _exception;}
+		}
+
+		public bool Succeeded {
+			get {return this.Exception == null;}
+		}
+
+		public CatalogTestCase TestCase {
+			get {return _testCase;}
+		}
+
+		XslTransform LoadTransform ()
+		{
+			XslTransform trans = new XslTransform ();
+
+			if (EnvOptions.UseDomStyle) {
+				XmlDocument styledoc = new XmlDocument ();
+				if (EnvOptions.WhitespaceStyle)
+					styledoc.PreserveWhitespace = true;
+				styledoc.Load (_testCase.StyleSheet);
+				trans.Load (styledoc, null, null);
+			} else
+				trans.Load (new XPathDocument (
+					_testCase.StyleSheet,
+					EnvOptions.WhitespaceStyle ? XmlSpace.Preserve :
+					XmlSpace.Default),
+					null, null);
+			return trans;
+		}
+
+		IXPathNavigable LoadInput ()
+		{
+			XmlTextReader xtr=null;
+			try {
+				xtr = new XmlTextReader (_testCase.SrcXml);
+				XmlValidatingReader xvr = new XmlValidatingReader (xtr);
+				xvr.ValidationType = ValidationType.None;
+				IXPathNavigable input = null;
+				if (EnvOptions.UseDomInstance) {
+					XmlDocument dom = new XmlDocument ();
+					if (EnvOptions.WhitespaceInstance)
+						dom.PreserveWhitespace = true;
+					dom.Load (xvr);
+					input = dom;
+				} else {
+					input = new XPathDocument (xvr,
+						EnvOptions.WhitespaceStyle ? XmlSpace.Preserve :
+						XmlSpace.Default);
+				}
+				return input;
+			}
+			finally {
+				if (xtr!=null)
+					xtr.Close ();
+			}
+		}
+
+		public void RunTest ()
+		{
+			try {
+				XslTransform trans = LoadTransform ();
+				IXPathNavigable input = LoadInput ();
+				using (StringWriter sw = new StringWriter ()) {
+					trans.Transform (input, null, sw, null);
+					_result = sw.ToString ();
+				}
+			}
+			catch (System.Exception e) {
+				_exception = e;
+			}
+		}
+	}
+}
Index: ChangeLog
===================================================================
--- ChangeLog	(revision 46903)
+++ ChangeLog	(working copy)
@@ -1,3 +1,9 @@
+2004-07-06  Andrew Skiba  <andrews@mainsoft.com>
+
+	* Makefile, xslttest.cs: convert to be executed from NUnit
+	* XsltTestUtils.cs, generate.cs: added
+	* fixme.lst: update with currently failing tests
+
 2004-06-28  Andrew Skiba  <andrews@mainsoft.com>
 
 	* Makefile: touch file, not directory, doh!
Index: fixme.lst
===================================================================
--- fixme.lst	(revision 46903)
+++ fixme.lst	(working copy)
@@ -9,3 +9,5 @@
 Sorting__78191
 Sorting__78286
 XSLTFunctions_RoundTripNumber_UsingStringFn
+BVTs_bvt044
+attribset_attribset15 
Index: Makefile
===================================================================
--- Makefile	(revision 46903)
+++ Makefile	(working copy)
@@ -8,7 +8,7 @@
 #	is in failed.lst
 #
 
-.SUFFIXES: .cs .exe
+.SUFFIXES: .cs .exe .dll
 
 RUNTIME = mono
 CSCOMPILE = mcs
@@ -17,31 +17,47 @@
 CATALOG = testsuite/TESTS/catalog.xml
 FIXED_CATALOG = testsuite/TESTS/catalog-fixed.xml
 
-TEST_EXE = xslttest.exe
-TEST_FLAGS = --report:TestResult.xml --xml --details $(TEST_DOM) 
+nunit_MONO_PATH="../../../../../class/lib/default"
+mono_wrapper_PATH="../../../../../../mono/runtime/mono-wrapper"
+NUNIT_CONSOLE=$(mono_wrapper_PATH) --debug $(nunit_MONO_PATH)/nunit-console.exe
 
+FIXTURE=MonoTests.oasis_xslt.SuiteBuilder
+CLEAN_NUNIT_FLAGS=/fixture:$(FIXTURE) /xml=TestResult.xml /include=Clean
+FAILED_NUNIT_FLAGS=/fixture:$(FIXTURE) /xml=FailedTestResult.xml /include=KnownFailures
+ALL_NUNIT_FLAGS=/fixture:$(FIXTURE) /xml=AllTestResult.xml /out=AllTestResult.log /include=KnownFailures,Clean
+
+TEST_PROG=xslttest.dll
+GENERATE_EXE=generate.exe
+
 ifdef TEST_DOM
-REFERENCE_RESULTS_NAME = domresults
+REFERENCE_RESULTS_NAME=domresults
 else
-REFERENCE_RESULTS_NAME = results
+REFERENCE_RESULTS_NAME=results
 endif
-REFERENCE_RESULTS_ARCHIVE = xslt-reference-$(REFERENCE_RESULTS_NAME).tar.gz
-REFERENCE_RESULTS_URL = http://svn.myrealbox.com/source/trunk/release/test-ext/xslt-standalone/$(REFERENCE_RESULTS_ARCHIVE)
-REFERENCE_RESULTS = $(REFERENCE_RESULTS_NAME)/timestamp
+REFERENCE_RESULTS_ARCHIVE=xslt-reference-$(REFERENCE_RESULTS_NAME).tar.gz
+REFERENCE_RESULTS_URL=http://svn.myrealbox.com/source/trunk/release/test-ext/xslt-standalone/$(REFERENCE_RESULTS_ARCHIVE)
+REFERENCE_RESULTS=$(REFERENCE_RESULTS_NAME)/timestamp
 
-test : $(TEST_EXE) $(FIXED_CATALOG)
+test : $(TEST_PROG) $(FIXED_CATALOG) $(REFERENCE_RESULTS)
 
-# Redirect stdout to /dev/null because it has only xsl:message garbage
-run-test : $(TEST_EXE) $(FIXED_CATALOG) $(REFERENCE_RESULTS)
-	$(RUNTIME) $(RUNTIME_FLAGS) $(TEST_EXE) $(TEST_FLAGS) >/dev/null
+run-test : $(TEST_PROG) $(FIXED_CATALOG) $(REFERENCE_RESULTS)
+	MONO_PATH="$(nunit_MONO_PATH);$(MONO_PATH)" $(NUNIT_CONSOLE) $(TEST_PROG) $(CLEAN_NUNIT_FLAGS)
+	
+run-all-test : $(TEST_PROG) $(FIXED_CATALOG) $(REFERENCE_RESULTS)
+	MONO_PATH="$(nunit_MONO_PATH);$(MONO_PATH)" $(NUNIT_CONSOLE) $(TEST_PROG) $(ALL_NUNIT_FLAGS)
+	
+run-failed-test : $(TEST_PROG) $(FIXED_CATALOG) $(REFERENCE_RESULTS)
+	XSLTTEST_INVERSE_RESULTS="" MONO_PATH="$(nunit_MONO_PATH);$(MONO_PATH)" $(NUNIT_CONSOLE) $(TEST_PROG) $(FAILED_NUNIT_FLAGS)
+	
 
 clean :
-	rm -f TestResult.xml failed.lst missing.lst
-	rm -f $(TEST_EXE)
+	rm -f *TestResult.xml failed.lst missing.lst AllTestResult.log
+	rm -f $(TEST_PROG) $(GENERATE_EXE)
 
 # Be careful to use it!
 distclean : clean
 	rm -rf testsuite
+	rm -rf results domresults
 	rm -f $(TEST_ARCHIVE) $(REFERENCE_RESULTS_ARCHIVE) $(REFERENCE_LIST)
 
 # Check that we are running on MS.NET - otherwise the reference output can be
@@ -53,20 +69,22 @@
 	uname | grep CYGWIN || uname | grep Windows
 endif
 	
-create-reference-output : must-be-dotnet $(TEST_EXE)
+create-reference-output : must-be-dotnet $(GENERATE_EXE) $(FIXED_CATALOG)
 	rm -rf $(REFERENCE_RESULTS_NAME)
 ifdef GENERATE_REFERENCE_ON_MONO
-	$(RUNTIME) ./$(TEST_EXE) $(TEST_DOM) --generate
+	$(RUNTIME) ./$(GENERATE_EXE) $(TEST_DOM)
 else
-	./$(TEST_EXE) $(TEST_DOM) --generate
+	./generate.exe $(TEST_DOM)
 endif
 # Must cd to work with any path separator symbols
 	cd $(REFERENCE_RESULTS_NAME); echo "$(TEST_DOM)" > generate_options 
 	tar -c $(REFERENCE_RESULTS_NAME) | gzip > $(REFERENCE_RESULTS_ARCHIVE)
 	@echo "Now you can upload $(REFERENCE_RESULTS_ARCHIVE) to $(REFERENCE_RESULTS_URL)"
 
-.cs.exe :
-	$(CSCOMPILE) $<
+$(GENERATE_EXE) : generate.cs XsltTestUtils.cs
+	$(CSCOMPILE) generate.cs XsltTestUtils.cs -out:$@
+$(TEST_PROG) : xslttest.cs XsltTestUtils.cs
+	$(CSCOMPILE) xslttest.cs XsltTestUtils.cs -r:NUnit.core -r:NUnit.framework -out:$@ -t:library
 
 catalog-fixed : $(FIXED_CATALOG)
 
@@ -85,7 +103,7 @@
 
 $(REFERENCE_RESULTS) : $(REFERENCE_RESULTS_ARCHIVE)
 	tar -xzf $<
-	touch $@/reference_results
+	touch $@
 
 $(REFERENCE_RESULTS_ARCHIVE) :
 	wget $(REFERENCE_RESULTS_URL)
Index: README
===================================================================
--- README	(revision 46903)
+++ README	(working copy)
@@ -1,17 +1,40 @@
-
-Small XSLT test system::
-
-This is a small standalone test system using OASIS XSLT test suite
-(only Xalan tests as yet).
+This is a test system using OASIS XSLT test suite
 http://www.oasis-open.org/committees/tc_home.php?wg_abbrev=xslt
 
 "make" will do what you need (downloading test archive, expanding,
 compiling test runner.
 
-"make run-test" will do the actual tests.
+"make run-test" will run only clean tests (check for regressions).
+"make run-failed-test" will run only failed tests and inverse the
+test results (check for progressions).
+"make run-all-test" will run all tests.
 
-If you want to create reference output files by yourself, compile
-prepare.cs and run it on Microsoft.NET (it requires cygwin).
+knownFailures.lst and fixme.lst have the list of tests that are
+are considered known failures for  run-test and run-failed-test.
 
+If you want to create reference output files by yourself,
+run "make create-reference-output" on Microsoft.NET (it requires cygwin).
+
+Both generation and test phases read the following environment variables:
+
+XSLTTEST_DOMXSL		- use XmlDocument for xsl
+XSLTTEST_DOMINSTANCE	- use XmlDocument for xml
+XSLTTEST_DOM		- both of the above
+
+XSLTTEST_WSXSL		- significant whitespace in xsl
+XSLTTEST_WSSRC		- significant whitespace in xml
+XSLTTEST_WS		- both of the above
+
+TODO:
+This testsuite should not generate dotnet results. Instead, one should compare
+to oasis reference output. For testcases that fail on dotnet, one can skip
+checks, as it's done in W3C testsuite. This will allow to run negative tests,
+too.
+
+But before that, it's necessary to fix the comparison, instead of simple text
+compare, it should make compare as specified in each testcase - text, xml or
+html. There are open source tools to make xml compare, and html can be done
+by first converting html to xhtml and then running xml compare.
+
 Atsushi Eno <atsushi@ximian.com>
-
+Andrew Skiba <andrews@ximian.com>
Index: xslttest.cs
===================================================================
--- xslttest.cs	(revision 46903)
+++ xslttest.cs	(working copy)
@@ -5,505 +5,173 @@
 using System.Xml;
 using System.Xml.XPath;
 using System.Xml.Xsl;
+using NUnit.Core;
+using NUnit.Framework;
 
-namespace XsltTest
-{
-	public class XsltTest: IDisposable
-	{
-		#region Options Vars
-		bool noExclude;
-		bool reportDetails;
-		bool reportAsXml;
-		bool useDomStyle;
-		bool useDomInstance;
-		bool generateOutput;
-		string outputDir;
-		bool whitespaceStyle;
-		bool whitespaceInstance;
-		bool stopImmediately;
-		bool outputOnlyErrors;
-		bool runSlow = false;
-		#endregion
-
-		#region statistics fields
-		int totalCount = 0;
-		int performedCount = 0;
-		int passedCount = 0;
-		int failedCount = 0;
-		int differentCount = 0;
-		int exceptionCount = 0;
-		int regressionsCount = 0; //failures not listed in knownFailures.lst
-		int fixedCount = 0; //tested known to fail that passed
-		#endregion
-
+namespace MonoTests.oasis_xslt {
+	public class SuiteBuilder {
 		#region test list fields
-		ArrayList netExceptions = new ArrayList ();
+		IDictionary expectedExceptions = new Hashtable ();
 		ArrayList skipTargets = new ArrayList ();
-		ArrayList slowTests = new ArrayList ();
 		ArrayList knownFailures = new ArrayList ();
 		ArrayList fixmeList = new ArrayList ();
-		StreamWriter slowNewList;
-		StreamWriter missingFiles;
-		StreamWriter failedTests;
-		StreamWriter fixedTests;
-		StreamWriter netExceptionsWriter;
 		#endregion
-
-		#region IDisposable Members
-		public void Dispose() {
-			if (reportXmlWriter != null)
-				reportXmlWriter.Close ();
-			if (slowNewList != null)
-				slowNewList.Close();
-			if (missingFiles != null)
-				missingFiles.Close ();
-			if (failedTests != null)
-				failedTests.Close ();
-			if (fixedTests != null)
-				fixedTests.Close ();
-			if (netExceptionsWriter != null)
-				netExceptionsWriter.Close ();
-			reportXmlWriter = null;
-			slowNewList = null;
-			missingFiles = null;
-			failedTests = null;
-			fixedTests = null;
-			netExceptionsWriter = null;
-		}
-
-		#endregion
-
-		string explicitTarget;
-		TextWriter reportOutput = Console.Out;
-		XmlTextWriter reportXmlWriter;
-
-		#region ReadStrings ()
-		static void ReadStrings (ArrayList array, string filename) {
-			if (!File.Exists (filename))
-				return;
-
-			using (StreamReader reader = new StreamReader (filename)) {
-				foreach (string s_ in reader.ReadToEnd ().Split ("\n".ToCharArray ())) {
-					string s = s_.Trim ();
-					if (s.Length > 0)
-						array.Add (s);
-				}
-			}
-		}
-		#endregion
-
-		enum TestResult
+	
+		TestSuite _suite;
+		SuiteBuilder (TestSuite suite)
 		{
-			Crash,		//exception
-			Failure,	//no exception but output is different
-			Unknown,	//no exception but expected result is unknown
-			Success,	//no exception and output is as expected
-		};
-		
-		#region Options handling
-		static void Usage ()
-		{
-			Console.Error.WriteLine (@"
-mono xslttest.exe [options] [targetFileMatch] -report:reportfile
-
-Options:
-	--details	Output detailed output differences.
-	--dom		Use XmlDocument for both stylesheet and input source.
-	--domxsl	Use XmlDocument for stylesheet.
-	--domsrc	Use XmlDocument for input source.
-	--generate	Generate output files specified in catalog.
-			Use this feature only when you want to update
-			reference output.
-	--noExclude	Don't exclude meaningless comparison testcases.
-	--outErrors	Output only error results (don't print dots).
-	--stoponerror	Stops the test process and throw detailed
-			error if happened.
-	--ws		Preserve spaces for both stylesheet and input source.
-	--wsxsl		Preserve spaces for stylesheet.
-	--wssrc		Preserve spaces for input source.
-	--xml		Report into xml output.
-	--report	Write reports into specified file.
-	--run-slow	Run all tests, including slow ones.
-
-FileMatch:
-	arbitrary string that specifies part of file name.
-	(no * or ? available)
-");
+			_suite = suite;
 		}
 
-		void ParseOptions ()
+		void ReadLists ()
 		{
-			foreach (string arg in _args) {
-				switch (arg) {
-				case "-?":
-					Usage ();
-					return;
-				case "--dom":
-					useDomStyle = true;
-					useDomInstance = true;
-					break;
-				case "--domxsl":
-					useDomStyle = true;
-					break;
-				case "--domsrc":
-					useDomInstance = true;
-					break;
-				case "--details":
-					reportDetails = true;
-					break;
-				case "--generate":
-					generateOutput = true;
-					break;
-				case "--noExclude":
-					noExclude = true;
-					break;
-				case "--outErrors":
-					outputOnlyErrors = true;
-					break;
-				case "--stoponerror":
-					stopImmediately = true;
-					break;
-				case "--ws":
-					whitespaceStyle = true;
-					whitespaceInstance = true;
-					break;
-				case "--wsxsl":
-					whitespaceStyle = true;
-					break;
-				case "--wssrc":
-					whitespaceInstance = true;
-					break;
-				case "--xml":
-					reportAsXml = true;
-					break;
-				case "--run-slow":
-					runSlow = true;
-					break;
-				default:
-					if (arg.StartsWith ("--report:")) {
-						string reportFile = arg.Substring (9);
-						if (reportFile.Length < 0) {
-							Usage ();
-							Console.Error.WriteLine ("Error: --report option requires filename.");
-							return;
-						}
-						reportOutput = new StreamWriter (reportFile);
-						break;
-					}
-					if (arg.StartsWith ("--")) {
-						Usage ();
-						return;
-					}
-					explicitTarget = arg;
-					break;
-				}
+			string exceptionsFilename = Path.Combine (EnvOptions.OutputDir, "res-exceptions.lst");
+
+			Helpers.ReadStrings (skipTargets, "ignore.lst");
+			Helpers.ReadStrings (knownFailures, "knownFailures.lst");
+			Helpers.ReadStrings (fixmeList, "fixme.lst");
+			ArrayList exceptionsArray = new ArrayList();
+			Helpers.ReadStrings (exceptionsArray, exceptionsFilename);
+			foreach (string s in exceptionsArray) {
+				string [] halves = s.Split ('\t');
+				expectedExceptions [halves[0]] = halves[1];
 			}
-			if (useDomStyle || useDomInstance)
-				outputDir = "domresults";
-			else
-				outputDir = "results";
 		}
-		#endregion
-			
-		public static int Main (string [] args)
-		{
-			using (XsltTest test = new XsltTest(args)) {
-				if (!test.Run ())
-					return 1;
-				return 0;
-			}
-		}
 
-		string [] _args;
-
-		XsltTest (string [] args) 
+		public void Build ()
 		{
-			_args = args;
-		}
-
-		bool Run ()
-		{
-			ParseOptions ();
-			string netExceptionsFilename = Path.Combine (outputDir, "net-exceptions.lst");
-			if (!Directory.Exists (outputDir))
-				Directory.CreateDirectory (outputDir);
-
-			if (!noExclude) {
-				ReadStrings (slowTests, "slow.lst");
-				ReadStrings (skipTargets, "ignore.lst");
-                ReadStrings (knownFailures, "knownFailures.lst");
-				ReadStrings (fixmeList, "fixme.lst");
-				ReadStrings (netExceptions, netExceptionsFilename);
-			}
-
-			slowNewList = new StreamWriter ("new-slow.lst");
-			missingFiles = new StreamWriter ("missing.lst");
-			failedTests = new StreamWriter ("failed.lst");
-			fixedTests = new StreamWriter ("fixed.lst");
-
-			if (generateOutput)
-				netExceptionsWriter = new StreamWriter (netExceptionsFilename);
-
-			if (reportAsXml) {
-				reportXmlWriter = new XmlTextWriter (reportOutput);
-				reportXmlWriter.Formatting = Formatting.Indented;
-				reportXmlWriter.WriteStartElement ("test-results");
-			}
-
-			if (explicitTarget != null)
-				Console.Error.WriteLine ("The specified target is "
-					+ explicitTarget);
-
+//			if (Environment.GetEnvironmentVariables().Contains("START_DEBUG"))
+//				System.Diagnostics.Debugger.Launch ();
+			ReadLists ();
 			XmlDocument whole = new XmlDocument ();
 			whole.Load (@"testsuite/TESTS/catalog-fixed.xml");
-			bool res = true;
 
 			foreach (XmlElement testCase in whole.SelectNodes ("test-suite/test-catalog/test-case")) {
-				string testId = testCase.GetAttribute ("id");
-				totalCount ++;
-				DateTime start = DateTime.Now;
-				if (!ProcessTestCase (testCase))
-					res = false;
-				TimeSpan span = DateTime.Now - start;
-				if (span.TotalSeconds > 1) {
-					if (slowTests.Contains (testId))
-						continue;
-					slowNewList.WriteLine (testId);
-				}
-			}
-			if (reportAsXml)
-				reportXmlWriter.WriteEndElement (); // test-results
+				string testid = testCase.GetAttribute ("id");
 
-			Console.Error.WriteLine ("\n\n*********");
-			Console.Error.WriteLine ("Total:{0}", totalCount);
-			Console.Error.WriteLine (" Performed:{0}", performedCount);
-			Console.Error.WriteLine ("  Passed:{0}", passedCount);
-			Console.Error.WriteLine ("   Fixed:{0}\n", fixedCount);
-			Console.Error.WriteLine ("  Failed:{0}", failedCount);
-			Console.Error.WriteLine ("   Different:{0}", differentCount);
-			Console.Error.WriteLine ("   Exceptions:{0}", exceptionCount);
-			Console.Error.WriteLine ("   Regressions:{0}", regressionsCount);
+				if (skipTargets.Contains (testid))
+					continue;
 
-			if (fixedCount > 0)
-				Console.Error.WriteLine (@"
+				CatalogTestCase ctc = new CatalogTestCase(EnvOptions.OutputDir, testCase);
+				if (!ctc.Process ())
+					continue;
 
-ATTENTION!
-Delete the fixed tests (those listed in fixed.lst) from
-knownFailures.lst or fixme.lst, or we might miss
-regressions in the future.");
+				SingleTestTransform stt = new SingleTestTransform (ctc);
 
-			if (regressionsCount > 0)
-				Console.Error.WriteLine (@"
+				string expectedException = (string) expectedExceptions[testid];
+				bool isKnownFailure = knownFailures.Contains (testid) || fixmeList.Contains (testid);
 
-ERROR!!! New regressions!
-If you see this message for the first time, your last changes had
-introduced new bugs! Before you commit, consider one of the following:
-
-1. Find and fix the bugs, so tests will pass again.
-2. Open new bugs in bugzilla and temporily add the tests to fixme.lst
-3. Write to devlist and confirm adding the new tests to knownFailures.lst");
-
-			return res;
+				_suite.Add (new TestFromCatalog (testid, stt, expectedException,
+					EnvOptions.InverseResults, isKnownFailure));
+			}
 		}
-		
-		bool ProcessTestCase (XmlElement testCase)
-		{
-			string stylesheetBase = null;
-			string testid = testCase.GetAttribute ("id");
-			if (skipTargets.Contains (testid))
-				return true;
-			if (!runSlow && slowTests.Contains (testid))
-				return true;
-			bool res = true;
-			try {
-				performedCount ++;
-				string submitter = testCase.SelectSingleNode ("./parent::test-catalog/@submitter")
-					.InnerText;
-				string filePath = testCase.SelectSingleNode ("file-path").InnerText;
-				string testAuthorDir;
-				if (submitter == "Lotus")
-					testAuthorDir =  "Xalan_Conformance_Tests";
-				else if (submitter == "Microsoft")
-					testAuthorDir =  "MSFT_Conformance_Tests";
-				else
-					return true; //unknown directory
 
-				string relPath = Path.Combine (testAuthorDir, filePath);
-				string path = Path.Combine ("testsuite/TESTS", relPath);
-				string outputPath = Path.Combine (outputDir, relPath);
-				if (!Directory.Exists (outputPath))
-					Directory.CreateDirectory (outputPath);
-				foreach (XmlElement scenario in 
-						testCase.SelectNodes ("scenario[@operation='standard']")) {
-					if (!RunTest (testid, scenario, path, outputPath, stylesheetBase))
-						res = false;
-				}
-			} catch (Exception ex) {
-				if (stopImmediately)
-					throw;
-				if (!Report (TestResult.Crash, testid, "Exception: " + ex.Message))
-					res = false;
+		[Suite]
+		public static TestSuite Suite { 
+			get {
+				TestSuite suite = new TestSuite ("MonoTests.oasis_xslt.SuiteBuilder");
+				SuiteBuilder builder = new SuiteBuilder (suite);
+				builder.Build ();
+				return suite;
 			}
-			return res;
 		}
+	}
 
-		bool RunTest (string testid, XmlElement scenario, string path, string outputPath,
-				     string stylesheetBase)
+	class TestFromCatalog: NUnit.Core.TestCase {
+		bool _inverseResult;
+		string _testid;
+		string _expectedException;
+		SingleTestTransform _transform;
+
+		public TestFromCatalog (string testid, SingleTestTransform transform,
+			string expectedException, bool inverseResult, bool isKnownFailure)
+			:base (null, testid)
 		{
-			stylesheetBase = scenario.SelectSingleNode ("input-file[@role='principal-stylesheet']")
-				.InnerText;
-			string stylesheet = Path.Combine (path, stylesheetBase);
+			_testid = testid;
+			_expectedException = expectedException;
+			_transform = transform;
+			_inverseResult = inverseResult;
 			
-			if (!File.Exists (stylesheet)) {
-				missingFiles.WriteLine (stylesheet);
+			ArrayList arr = new ArrayList ();
+			if (isKnownFailure) {
+				arr.Add ("KnownFailures");
+				this.IsExplicit = true;
 			}
-			string srcxml = Path.Combine (path,
-				scenario.SelectSingleNode ("input-file[@role='principal-data']").InnerText);
-			XmlNode outputNode = scenario.SelectSingleNode ("output-file[@role='principal']");
-			string outfile = null;
-			if (outputNode != null) 
-				outfile = Path.Combine (outputPath, outputNode.InnerText);
+			else
+				arr.Add ("Clean");
+			Categories = arr;
+		}
 
-			XslTransform trans = new XslTransform ();
+		string CompareResult (string actual, string expected)
+		{
+			//TODO: add xml comparison
+			if (actual == expected)
+				return null;
+			else
+#if !FAILURE_DETAILED_MESSAGE
+				return "Different.";
+#else
+				return "Different.\nActual*****\n"+actual+"\nReference*****\n"+expected;
+#endif
+		}
 
-			if (explicitTarget != null && testid.IndexOf (explicitTarget) < 0)
-				return true;
-			if (skipTargets.Contains (stylesheetBase))
-				return true;
+		string CompareException (Exception actual, string testid)
+		{
+			if (_expectedException == null)
+				return "Unexpected exception: " + actual.ToString ();
 
-			if (useDomStyle) {
-				XmlDocument styledoc = new XmlDocument ();
-				if (whitespaceStyle)
-					styledoc.PreserveWhitespace = true;
-				styledoc.Load (stylesheet);
-				trans.Load (styledoc, null, null);
-			} else
-				trans.Load (new XPathDocument (
-							stylesheet,
-							whitespaceStyle ? XmlSpace.Preserve :
-							XmlSpace.Default),
-						null, null);
-			
-			string swString;
-			XmlTextReader xtr = new XmlTextReader (srcxml);
+			string actualType = actual.GetType ().ToString ();
+			if (actualType != _expectedException)
+				return "Different exception thrown.\nActual*****\n"+actualType+
+					"\nReference*****\n"+_expectedException;
 
-			try {
-				XmlValidatingReader xvr = new XmlValidatingReader (xtr);
-				xvr.ValidationType = ValidationType.None;
-				IXPathNavigable input = null;
-				if (useDomInstance) {
-					XmlDocument dom = new XmlDocument ();
-					if (whitespaceInstance)
-						dom.PreserveWhitespace = true;
-					dom.Load (xvr);
-					input = dom;
-				} else {
-					input = new XPathDocument (xvr,
-						whitespaceStyle ? XmlSpace.Preserve :
-						XmlSpace.Default);
-				}
-				using (StringWriter sw = new StringWriter ()) {
-					trans.Transform (input, null, sw, null);
-					swString = sw.ToString ();
-				}
-			}
-			finally {
-				xtr.Close ();
-			}
-			if (generateOutput) {
-				using (StreamWriter fw = new StreamWriter (outfile,
-						   false, Encoding.UTF8)) {
-					fw.Write (swString);
-					fw.Close ();
-				}
-				return Report (TestResult.Success, testid, "Created reference result");
-				// ... and don't run comparison
-			}
-
-			if (!File.Exists (outfile)) {
-				// Reference output file does not exist.
-				return Report (TestResult.Unknown, testid, "No reference file found");
-			}
-			string reference_out;
-			string actual_out;
-			using (StreamReader sr = new StreamReader (outfile)) {
-				reference_out = sr.ReadToEnd ().Replace ("\r\n","\n");
-				actual_out = swString.Replace ("\r\n","\n");
-			}
-			if (reference_out != actual_out)
-				return Report (TestResult.Failure, testid, reference_out, actual_out);
-			else if (!outputOnlyErrors)
-				return Report (TestResult.Success, testid, "OK");
-			else
-				return true;
+            return null;
 		}
 
-		bool Report (TestResult res, string testid, string message)
+		void ReportResult (string failureMessage, string stackTrace, TestCaseResult res)
 		{
-			if (TestResult.Success == res || TestResult.Unknown == res) {
-				passedCount ++;
-				if (fixmeList.Contains (testid) || knownFailures.Contains (testid)) {
-					fixedCount ++;
-					fixedTests.WriteLine (testid);
-					Console.Error.Write ("!");
-					return true;
-				}
-				if (netExceptions.Contains (testid))
-					Console.Error.Write (",");
-				else if (TestResult.Success == res)
-					Console.Error.Write (".");
+			if (_inverseResult) {
+				if (failureMessage != null)
+					res.Success ();
 				else
-					Console.Error.Write ("?");
-				return true;
+					res.Failure ("The following test was FIXED: "+_testid, null);
 			}
-
-			bool return_res = true;
-
-			failedCount ++;
-			if (TestResult.Crash == res)
-				exceptionCount ++;
-			else if (TestResult.Failure == res)
-				differentCount ++;
- 			
-			if (knownFailures.Contains (testid) || fixmeList.Contains (testid))
-				Console.Error.Write ("k");
-			else if (res == TestResult.Crash && netExceptions.Contains (testid))
-				Console.Error.Write ("K"); 
 			else {
-				regressionsCount ++;
-				if (reportAsXml) {
-					reportXmlWriter.WriteStartElement ("testcase");
-					reportXmlWriter.WriteAttributeString ("id", testid);
-					reportXmlWriter.WriteString (message);
-					reportXmlWriter.WriteEndElement ();
-				}
-				return_res = false;
-                failedTests.WriteLine (testid + "\t" + message);
-
-				if (TestResult.Crash == res) {
-					Console.Error.Write ("E");
-					if (generateOutput)
-						netExceptionsWriter.WriteLine (testid);
-				}
+				if (failureMessage != null)
+					res.Failure (failureMessage, stackTrace);
 				else
-					Console.Error.Write ("e");
+					res.Success ();
 			}
-			
-			return return_res;
 		}
 
-		bool Report (TestResult res, string testid, string reference_out, string actual_out)
+		public override void Run (TestCaseResult res)
 		{
-			string baseMessage = reportAsXml ? "Different." : "Different: " + testid;
-			if (!reportDetails)
-				return Report (res, testid, baseMessage);
-			else
-				return Report (res, testid, baseMessage +
-					"\n Actual*****\n" + 
-					actual_out + 
-					"\n-------------------\nReference*****\n" + 
-					reference_out + 
-					"\n");
+			_transform.RunTest ();
+
+			string failureMessage;
+			string stackTrace = null;
+			if (_transform.Succeeded) {
+				try {
+					using (StreamReader sr = new StreamReader (_transform.TestCase.OutFile))
+						failureMessage = CompareResult (_transform.Result, sr.ReadToEnd ());
+				}
+				catch {
+					//if there is no reference result because of expectedException, we
+					//are OK, otherwise, rethrow
+					if (_expectedException!=null)
+						failureMessage = null;
+					else {
+						Console.WriteLine ("ERROR: No reference result, and no expected exception.");
+						throw;
+					}
+				}
+			}
+			else {
+				failureMessage = CompareException (_transform.Exception, _testid);
+				stackTrace = _transform.Exception.StackTrace;
+			}
+
+			ReportResult (failureMessage, stackTrace, res);
 		}
 	}
 }
Index: generate.cs
===================================================================
--- generate.cs	(revision 0)
+++ generate.cs	(revision 0)
@@ -0,0 +1,79 @@
+using System;
+using System.Collections;
+using System.IO;
+using System.Text;
+using System.Xml;
+
+namespace MonoTests.oasis_xslt {
+	public class Generator: IDisposable
+	{
+		#region test list fields
+		ArrayList skipTargets = new ArrayList ();
+		StreamWriter resultExceptionsWriter;
+		#endregion
+
+		#region IDisposable Members
+		public void Dispose()
+		{
+			if (resultExceptionsWriter!=null)
+				resultExceptionsWriter.Close ();
+			resultExceptionsWriter = null;
+		}
+
+		#endregion
+
+		public static int Main (string [] args) {
+			using (Generator test = new Generator (args)) {
+				test.Run ();
+			}
+			return 0;
+		}
+
+		string [] _args;
+
+		Generator (string [] args)
+		{
+			_args = args;
+		}
+
+		void Run ()
+		{
+			string resultExceptionsFilename = Path.Combine (EnvOptions.OutputDir, "res-exceptions.lst");
+
+			if (Directory.Exists (EnvOptions.OutputDir))
+				Directory.Delete (EnvOptions.OutputDir, true);
+			Directory.CreateDirectory (EnvOptions.OutputDir);
+
+			Helpers.ReadStrings (skipTargets, "ignore.lst");
+
+			resultExceptionsWriter = new StreamWriter (resultExceptionsFilename);
+
+			XmlDocument catalog = new XmlDocument ();
+			catalog.Load (@"testsuite/TESTS/catalog-fixed.xml");
+
+			foreach (XmlElement testCase in catalog.SelectNodes ("test-suite/test-catalog/test-case")) {
+				ProcessTestCase (testCase);
+			}
+		}
+		
+		void ProcessTestCase (XmlElement testCase) {
+			string testid = testCase.GetAttribute ("id");
+			Console.Out.WriteLine (testid);
+			if (skipTargets.Contains (testid))
+				return;
+
+			CatalogTestCase ctc = new CatalogTestCase(EnvOptions.OutputDir, testCase);
+			if (!ctc.Process ())
+				return;
+
+			SingleTestTransform stt = new SingleTestTransform (ctc);
+			stt.RunTest ();
+			if (stt.Succeeded)
+				using (StreamWriter fw = new StreamWriter (ctc.OutFile, false, Encoding.UTF8))
+					fw.Write (stt.Result);
+			else
+				resultExceptionsWriter.WriteLine ("{0}\t{1}", testid, stt.Exception.GetType ().ToString ());
+		}
+
+	}
+}
\ No newline at end of file

Property changes on: generate.cs
___________________________________________________________________
Name: svn:executable
   + *

