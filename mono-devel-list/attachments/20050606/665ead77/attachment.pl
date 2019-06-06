Index: Makefile
===================================================================
--- Makefile	(revision 45299)
+++ Makefile	(working copy)
@@ -18,7 +18,7 @@
 FIXED_CATALOG = testsuite/TESTS/catalog-fixed.xml
 
 TEST_EXE = xslttest.exe
-TEST_FLAGS = --report:TestResult.xml --xml --details --outall $(TEST_DOM) 
+TEST_FLAGS = --report:TestResult.xml --xml --details $(TEST_DOM) 
 
 ifdef TEST_DOM
 REFERENCE_RESULTS_NAME = domresults
Index: xslttest.cs
===================================================================
--- xslttest.cs	(revision 45299)
+++ xslttest.cs	(working copy)
@@ -8,29 +8,90 @@
 
 namespace XsltTest
 {
-	public class XsltTest
+	public class XsltTest: IDisposable
 	{
-		#region static Vars
-		static bool noExclude;
-		static bool reportDetails;
-		static bool reportAsXml;
-		static bool useDomStyle;
-		static bool useDomInstance;
-		static bool generateOutput;
-		static string outputDir;
-		static bool whitespaceStyle;
-		static bool whitespaceInstance;
-		static bool stopImmediately;
-		static bool outputAll;
-		static readonly ArrayList skipTargets;
-		static readonly ArrayList knownFailures = new ArrayList (new string [] { });
-		static string explicitTarget;
-		static TextWriter reportOutput = Console.Out;
-		static XmlTextWriter reportXmlWriter;
-		static StreamWriter missingFiles = new StreamWriter ("missing.lst");
-		static StreamWriter failedTests = new StreamWriter ("failed.lst");
+		#region Options Vars
+		bool noExclude;
+		bool reportDetails;
+		bool reportAsXml;
+		bool useDomStyle;
+		bool useDomInstance;
+		bool generateOutput;
+		string outputDir;
+		bool whitespaceStyle;
+		bool whitespaceInstance;
+		bool stopImmediately;
+		bool outputOnlyErrors;
+		bool runSlow = false;
 		#endregion
 
+		#region statistics fields
+		int totalCount = 0;
+		int performedCount = 0;
+		int passedCount = 0;
+		int failedCount = 0;
+		int differentCount = 0;
+		int exceptionCount = 0;
+		int regressionsCount = 0; //failures not listed in knownFailures.lst
+		int fixedCount = 0; //tested known to fail that passed
+		#endregion
+
+		#region test list fields
+		ArrayList netExceptions = new ArrayList ();
+		ArrayList skipTargets = new ArrayList ();
+		ArrayList slowTests = new ArrayList ();
+		ArrayList knownFailures = new ArrayList ();
+		ArrayList fixmeList = new ArrayList ();
+		StreamWriter slowNewList;
+		StreamWriter missingFiles;
+		StreamWriter failedTests;
+		StreamWriter fixedTests;
+		StreamWriter netExceptionsWriter;
+		#endregion
+
+		#region IDisposable Members
+		public void Dispose() {
+			if (reportXmlWriter != null)
+				reportXmlWriter.Close ();
+			if (slowNewList != null)
+				slowNewList.Close();
+			if (missingFiles != null)
+				missingFiles.Close ();
+			if (failedTests != null)
+				failedTests.Close ();
+			if (fixedTests != null)
+				fixedTests.Close ();
+			if (netExceptionsWriter != null)
+				netExceptionsWriter.Close ();
+			reportXmlWriter = null;
+			slowNewList = null;
+			missingFiles = null;
+			failedTests = null;
+			fixedTests = null;
+			netExceptionsWriter = null;
+		}
+
+		#endregion
+
+		string explicitTarget;
+		TextWriter reportOutput = Console.Out;
+		XmlTextWriter reportXmlWriter;
+
+		#region ReadStrings ()
+		static void ReadStrings (ArrayList array, string filename) {
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
+		#endregion
+
 		enum TestResult
 		{
 			Crash,		//exception
@@ -39,12 +100,6 @@
 			Success,	//no exception and output is as expected
 		};
 		
-		static XsltTest ()
-		{
-			skipTargets = new ArrayList (new string [] {
-			}); 
-		}
-		
 		#region Options handling
 		static void Usage ()
 		{
@@ -60,7 +115,7 @@
 			Use this feature only when you want to update
 			reference output.
 	--noExclude	Don't exclude meaningless comparison testcases.
-	--outall	Output fine results as OK (omitted by default).
+	--outErrors	Output only error results (don't print dots).
 	--stoponerror	Stops the test process and throw detailed
 			error if happened.
 	--ws		Preserve spaces for both stylesheet and input source.
@@ -68,6 +123,7 @@
 	--wssrc		Preserve spaces for input source.
 	--xml		Report into xml output.
 	--report	Write reports into specified file.
+	--run-slow	Run all tests, including slow ones.
 
 FileMatch:
 	arbitrary string that specifies part of file name.
@@ -75,9 +131,9 @@
 ");
 		}
 
-		static void ParseOptions (string [] args)
+		void ParseOptions ()
 		{
-			foreach (string arg in args) {
+			foreach (string arg in _args) {
 				switch (arg) {
 				case "-?":
 					Usage ();
@@ -101,8 +157,8 @@
 				case "--noExclude":
 					noExclude = true;
 					break;
-				case "--outall":
-					outputAll = true;
+				case "--outErrors":
+					outputOnlyErrors = true;
 					break;
 				case "--stoponerror":
 					stopImmediately = true;
@@ -120,6 +176,9 @@
 				case "--xml":
 					reportAsXml = true;
 					break;
+				case "--run-slow":
+					runSlow = true;
+					break;
 				default:
 					if (arg.StartsWith ("--report:")) {
 						string reportFile = arg.Substring (9);
@@ -146,39 +205,45 @@
 		}
 		#endregion
 			
-		public static void Main (string [] args)
+		public static int Main (string [] args)
 		{
-			try {
-				RunMain (args);
-			} catch (Exception ex) {
-				reportOutput.WriteLine (ex);
-			} finally {
-				reportOutput.Close ();
+			using (XsltTest test = new XsltTest(args)) {
+				if (!test.Run ())
+					return 1;
+				return 0;
 			}
 		}
 
-		static void RunMain (string [] args)
+		string [] _args;
+
+		XsltTest (string [] args) 
 		{
-			ParseOptions (args);
+			_args = args;
+		}
+
+		bool Run ()
+		{
+			ParseOptions ();
+			string netExceptionsFilename = Path.Combine (outputDir, "net-exceptions.lst");
+			if (!Directory.Exists (outputDir))
+				Directory.CreateDirectory (outputDir);
+
 			if (!noExclude) {
-				using (StreamReader ignoreReader = new StreamReader ("ignore.lst")) {
-					foreach (string s_ in ignoreReader.ReadToEnd ()
-						.Split ("\n".ToCharArray ())) {
-						string s = s_.Trim ();
-						if (s.Length > 0)
-							skipTargets.Add (s);
-					}
-				}
-				using (StreamReader knownReader = new StreamReader ("knownFailures.lst")) {
-					foreach (string s_ in knownReader.ReadToEnd ()
-						.Split ("\n".ToCharArray ())) {
-						string s = s_.Trim ();
-						if (s.Length > 0)
-							knownFailures.Add (s);
-					}
-				}
+				ReadStrings (slowTests, "slow.lst");
+				ReadStrings (skipTargets, "ignore.lst");
+                ReadStrings (knownFailures, "knownFailures.lst");
+				ReadStrings (fixmeList, "fixme.lst");
+				ReadStrings (netExceptions, netExceptionsFilename);
 			}
 
+			slowNewList = new StreamWriter ("new-slow.lst");
+			missingFiles = new StreamWriter ("missing.lst");
+			failedTests = new StreamWriter ("failed.lst");
+			fixedTests = new StreamWriter ("fixed.lst");
+
+			if (generateOutput)
+				netExceptionsWriter = new StreamWriter (netExceptionsFilename);
+
 			if (reportAsXml) {
 				reportXmlWriter = new XmlTextWriter (reportOutput);
 				reportXmlWriter.Formatting = Formatting.Indented;
@@ -191,21 +256,67 @@
 
 			XmlDocument whole = new XmlDocument ();
 			whole.Load (@"testsuite/TESTS/catalog-fixed.xml");
+			bool res = true;
 
-			foreach (XmlElement testCase in whole.SelectNodes ("test-suite/test-catalog/test-case"))
-				ProcessTestCase (testCase);
-
+			foreach (XmlElement testCase in whole.SelectNodes ("test-suite/test-catalog/test-case")) {
+				string testId = testCase.GetAttribute ("id");
+				totalCount ++;
+				DateTime start = DateTime.Now;
+				if (!ProcessTestCase (testCase))
+					res = false;
+				TimeSpan span = DateTime.Now - start;
+				if (span.TotalSeconds > 1) {
+					if (slowTests.Contains (testId))
+						continue;
+					slowNewList.WriteLine (testId);
+				}
+			}
 			if (reportAsXml)
 				reportXmlWriter.WriteEndElement (); // test-results
+
+			Console.Error.WriteLine ("\n\n*********");
+			Console.Error.WriteLine ("Total:{0}", totalCount);
+			Console.Error.WriteLine (" Performed:{0}", performedCount);
+			Console.Error.WriteLine ("  Passed:{0}", passedCount);
+			Console.Error.WriteLine ("   Fixed:{0}\n", fixedCount);
+			Console.Error.WriteLine ("  Failed:{0}", failedCount);
+			Console.Error.WriteLine ("   Different:{0}", differentCount);
+			Console.Error.WriteLine ("   Exceptions:{0}", exceptionCount);
+			Console.Error.WriteLine ("   Regressions:{0}", regressionsCount);
+
+			if (fixedCount > 0)
+				Console.Error.WriteLine (@"
+
+ATTENTION!
+You must delete the fixed tests (those listed in fixed.lst) from
+knownFailures.lst or fixme.lst. If you don't do it, you can miss
+regressions in the future.");
+
+			if (regressionsCount > 0)
+				Console.Error.WriteLine (@"
+
+ERROR!!! New regressions!
+If you see this message for the first time, your last changes had
+introduced new bugs! Before you commit, you must do one of the following:
+
+1. Find and fix the bugs, so tests will pass again.
+2. Open new bugs in bugzilla and temporily add the tests to fixme.lst
+3. Write to devlist and confirm adding the new tests to knownFailures.lst");
+
+			return res;
 		}
 		
-		static void ProcessTestCase (XmlElement testCase)
+		bool ProcessTestCase (XmlElement testCase)
 		{
 			string stylesheetBase = null;
 			string testid = testCase.GetAttribute ("id");
 			if (skipTargets.Contains (testid))
-				return;
+				return true;
+			if (!runSlow && slowTests.Contains (testid))
+				return true;
+			bool res = true;
 			try {
+				performedCount ++;
 				string submitter = testCase.SelectSingleNode ("./parent::test-catalog/@submitter")
 					.InnerText;
 				string filePath = testCase.SelectSingleNode ("file-path").InnerText;
@@ -215,7 +326,7 @@
 				else if (submitter == "Microsoft")
 					testAuthorDir =  "MSFT_Conformance_Tests";
 				else
-					return; //unknown directory
+					return true; //unknown directory
 
 				string relPath = Path.Combine (testAuthorDir, filePath);
 				string path = Path.Combine ("testsuite/TESTS", relPath);
@@ -224,16 +335,19 @@
 					Directory.CreateDirectory (outputPath);
 				foreach (XmlElement scenario in 
 						testCase.SelectNodes ("scenario[@operation='standard']")) {
-					RunTest (testid, scenario, path, outputPath, stylesheetBase);
+					if (!RunTest (testid, scenario, path, outputPath, stylesheetBase))
+						res = false;
 				}
 			} catch (Exception ex) {
 				if (stopImmediately)
 					throw;
-				Report (TestResult.Crash, testid, "Exception: " + ex.Message);
+				if (!Report (TestResult.Crash, testid, "Exception: " + ex.Message))
+					res = false;
 			}
+			return res;
 		}
 
-		static void RunTest (string testid, XmlElement scenario, string path, string outputPath,
+		bool RunTest (string testid, XmlElement scenario, string path, string outputPath,
 				     string stylesheetBase)
 		{
 			stylesheetBase = scenario.SelectSingleNode ("input-file[@role='principal-stylesheet']")
@@ -242,7 +356,6 @@
 			
 			if (!File.Exists (stylesheet)) {
 				missingFiles.WriteLine (stylesheet);
-				missingFiles.Flush ();
 			}
 			string srcxml = Path.Combine (path,
 				scenario.SelectSingleNode ("input-file[@role='principal-data']").InnerText);
@@ -254,9 +367,9 @@
 			XslTransform trans = new XslTransform ();
 
 			if (explicitTarget != null && testid.IndexOf (explicitTarget) < 0)
-				return;
+				return true;
 			if (skipTargets.Contains (stylesheetBase))
-				return;
+				return true;
 
 			if (useDomStyle) {
 				XmlDocument styledoc = new XmlDocument ();
@@ -270,26 +383,32 @@
 							whitespaceStyle ? XmlSpace.Preserve :
 							XmlSpace.Default),
 						null, null);
+			
+			string swString;
+			XmlTextReader xtr = new XmlTextReader (srcxml);
 
-			XmlTextReader xtr = new XmlTextReader (srcxml);
-			XmlValidatingReader xvr = new XmlValidatingReader (xtr);
-			xvr.ValidationType = ValidationType.None;
-			IXPathNavigable input = null;
-			if (useDomInstance) {
-				XmlDocument dom = new XmlDocument ();
-				if (whitespaceInstance)
-					dom.PreserveWhitespace = true;
-				dom.Load (xvr);
-				input = dom;
-			} else {
-				input = new XPathDocument (xvr,
-					whitespaceStyle ? XmlSpace.Preserve :
-					XmlSpace.Default);
+			try {
+				XmlValidatingReader xvr = new XmlValidatingReader (xtr);
+				xvr.ValidationType = ValidationType.None;
+				IXPathNavigable input = null;
+				if (useDomInstance) {
+					XmlDocument dom = new XmlDocument ();
+					if (whitespaceInstance)
+						dom.PreserveWhitespace = true;
+					dom.Load (xvr);
+					input = dom;
+				} else {
+					input = new XPathDocument (xvr,
+						whitespaceStyle ? XmlSpace.Preserve :
+						XmlSpace.Default);
+				}
+				using (StringWriter sw = new StringWriter ()) {
+					trans.Transform (input, null, sw, null);
+					swString = sw.ToString ();
+				}
 			}
-			string swString;
-			using (StringWriter sw = new StringWriter ()) {
-				trans.Transform (input, null, sw, null);
-				swString = sw.ToString ();
+			finally {
+				xtr.Close ();
 			}
 			if (generateOutput) {
 				using (StreamWriter fw = new StreamWriter (outfile,
@@ -297,15 +416,13 @@
 					fw.Write (swString);
 					fw.Close ();
 				}
-				Report (TestResult.Success, testid, "Created reference result");
+				return Report (TestResult.Success, testid, "Created reference result");
 				// ... and don't run comparison
-				return;
 			}
 
 			if (!File.Exists (outfile)) {
 				// Reference output file does not exist.
-				Report (TestResult.Unknown, testid, "No reference file found");
-				return;
+				return Report (TestResult.Unknown, testid, "No reference file found");
 			}
 			string reference_out;
 			string actual_out;
@@ -314,50 +431,74 @@
 				actual_out = swString.Replace ("\r\n","\n");
 			}
 			if (reference_out != actual_out)
-				Report (TestResult.Failure, testid, reference_out, actual_out);
-			else if (outputAll)
-				Report (TestResult.Success, testid, "OK");
+				return Report (TestResult.Failure, testid, reference_out, actual_out);
+			else if (!outputOnlyErrors)
+				return Report (TestResult.Success, testid, "OK");
+			else
+				return true;
 		}
 
-		static void Report (TestResult res, string testid, string message)
+		bool Report (TestResult res, string testid, string message)
 		{
-			if (TestResult.Success == res) {
-				Console.Error.Write (".");
-				return;
+			if (TestResult.Success == res || TestResult.Unknown == res) {
+				passedCount ++;
+				if (fixmeList.Contains (testid) || knownFailures.Contains (testid)) {
+					fixedCount ++;
+					fixedTests.WriteLine (testid);
+					Console.Error.Write ("!");
+					return true;
+				}
+				if (netExceptions.Contains (testid))
+					Console.Error.Write (",");
+				else if (TestResult.Success == res)
+					Console.Error.Write (".");
+				else
+					Console.Error.Write ("?");
+				return true;
 			}
-			else if (TestResult.Unknown == res) {
-				Console.Error.Write ("?");
-				return;
-			}
+
+			bool return_res = true;
+
+			failedCount ++;
+			if (TestResult.Crash == res)
+				exceptionCount ++;
+			else if (TestResult.Failure == res)
+				differentCount ++;
  			
-			if (knownFailures.Contains (testid))
+			if (knownFailures.Contains (testid) || fixmeList.Contains (testid))
 				Console.Error.Write ("k");
+			else if (res == TestResult.Crash && netExceptions.Contains (testid))
+				Console.Error.Write ("K"); 
 			else {
-				failedTests.WriteLine (testid + "\t" + message);
-				failedTests.Flush ();
+				regressionsCount ++;
+				if (reportAsXml) {
+					reportXmlWriter.WriteStartElement ("testcase");
+					reportXmlWriter.WriteAttributeString ("id", testid);
+					reportXmlWriter.WriteString (message);
+					reportXmlWriter.WriteEndElement ();
+				}
+				return_res = false;
+                failedTests.WriteLine (testid + "\t" + message);
 
-				if (TestResult.Crash == res)
-					   Console.Error.Write ("E");
+				if (TestResult.Crash == res) {
+					Console.Error.Write ("E");
+					if (generateOutput)
+						netExceptionsWriter.WriteLine (testid);
+				}
 				else
-					   Console.Error.Write ("e");
+					Console.Error.Write ("e");
 			}
 			
-			if (reportAsXml) {
-				reportXmlWriter.WriteStartElement ("testcase");
-				reportXmlWriter.WriteAttributeString ("id", testid);
-				reportXmlWriter.WriteString (message);
-				reportXmlWriter.WriteEndElement ();
-			}
-			
+			return return_res;
 		}
 
-		static void Report (TestResult res, string testid, string reference_out, string actual_out)
+		bool Report (TestResult res, string testid, string reference_out, string actual_out)
 		{
 			string baseMessage = reportAsXml ? "Different." : "Different: " + testid;
 			if (!reportDetails)
-				Report (res, testid, baseMessage);
+				return Report (res, testid, baseMessage);
 			else
-				Report (res, testid, baseMessage +
+				return Report (res, testid, baseMessage +
 					"\n Actual*****\n" + 
 					actual_out + 
 					"\n-------------------\nReference*****\n" + 
