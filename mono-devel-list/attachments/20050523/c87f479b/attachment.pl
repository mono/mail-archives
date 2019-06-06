Index: xslttest.cs
===================================================================
--- xslttest.cs	(revision 44904)
+++ xslttest.cs	(working copy)
@@ -10,7 +10,7 @@
 {
 	public class XsltTest
 	{
-#region static Vars
+		#region static Vars
 		static bool noExclude;
 		static bool reportDetails;
 		static bool reportAsXml;
@@ -29,7 +29,7 @@
 		static XmlTextWriter reportXmlWriter;
 		static StreamWriter missingFiles = new StreamWriter ("missing.lst");
 		static StreamWriter failedTests = new StreamWriter ("failed.lst");
-#endregion
+		#endregion
 
 		enum TestResult
 		{
@@ -45,6 +45,7 @@
 			}); 
 		}
 		
+		#region Options handling
 		static void Usage ()
 		{
 			Console.Error.WriteLine (@"
@@ -74,17 +75,6 @@
 ");
 		}
 
-		public static void Main (string [] args)
-		{
-			try {
-				RunMain (args);
-			} catch (Exception ex) {
-				reportOutput.WriteLine (ex);
-			} finally {
-				reportOutput.Close ();
-			}
-		}
-
 		static void ParseOptions (string [] args)
 		{
 			foreach (string arg in args) {
@@ -154,17 +144,39 @@
 			else
 				outputDir = "results";
 		}
+		#endregion
 			
+		public static void Main (string [] args)
+		{
+			try {
+				RunMain (args);
+			} catch (Exception ex) {
+				reportOutput.WriteLine (ex);
+			} finally {
+				reportOutput.Close ();
+			}
+		}
+
 		static void RunMain (string [] args)
 		{
 			ParseOptions (args);
 			if (!noExclude) {
-				foreach (string s_ in new StreamReader ("ignore.lst").ReadToEnd ()
+				using (StreamReader ignoreReader = new StreamReader ("ignore.lst")) {
+					foreach (string s_ in ignoreReader.ReadToEnd ()
 						.Split ("\n".ToCharArray ())) {
-					string s = s_.Trim ();
-					if (s.Length > 0)
-						skipTargets.Add (s);
+						string s = s_.Trim ();
+						if (s.Length > 0)
+							skipTargets.Add (s);
+					}
 				}
+				using (StreamReader knownReader = new StreamReader ("knownFailures.lst")) {
+					foreach (string s_ in knownReader.ReadToEnd ()
+						.Split ("\n".ToCharArray ())) {
+						string s = s_.Trim ();
+						if (s.Length > 0)
+							knownFailures.Add (s);
+					}
+				}
 			}
 
 			if (reportAsXml) {
@@ -274,13 +286,17 @@
 					whitespaceStyle ? XmlSpace.Preserve :
 					XmlSpace.Default);
 			}
-			StringWriter sw = new StringWriter ();
-			trans.Transform (input, null, sw, null);
+			string swString;
+			using (StringWriter sw = new StringWriter ()) {
+				trans.Transform (input, null, sw, null);
+				swString = sw.ToString ();
+			}
 			if (generateOutput) {
-				StreamWriter fw = new StreamWriter (outfile,
-					false, Encoding.UTF8);
-				fw.Write (sw.ToString ());
-				fw.Close ();
+				using (StreamWriter fw = new StreamWriter (outfile,
+						   false, Encoding.UTF8)) {
+					fw.Write (swString);
+					fw.Close ();
+				}
 				Report (TestResult.Success, testid, "Created reference result");
 				// ... and don't run comparison
 				return;
@@ -291,10 +307,12 @@
 				Report (TestResult.Unknown, testid, "No reference file found");
 				return;
 			}
-			StreamReader sr = new StreamReader (outfile);
-			string reference_out = sr.ReadToEnd ().Replace ("\r\n","\n");
-			string actual_out = sw.ToString ().Replace ("\r\n","\n");
-
+			string reference_out;
+			string actual_out;
+			using (StreamReader sr = new StreamReader (outfile)) {
+				reference_out = sr.ReadToEnd ().Replace ("\r\n","\n");
+				actual_out = swString.Replace ("\r\n","\n");
+			}
 			if (reference_out != actual_out)
 				Report (TestResult.Failure, testid, reference_out, actual_out);
 			else if (outputAll)
@@ -312,8 +330,17 @@
 				return;
 			}
  			
-			failedTests.WriteLine (testid + "\t" + message);
- 			failedTests.Flush ();
+			if (knownFailures.Contains (testid))
+				Console.Error.Write ("k");
+			else {
+				failedTests.WriteLine (testid + "\t" + message);
+				failedTests.Flush ();
+
+				if (TestResult.Crash == res)
+					   Console.Error.Write ("E");
+				else
+					   Console.Error.Write ("e");
+			}
 			
 			if (reportAsXml) {
 				reportXmlWriter.WriteStartElement ("testcase");
@@ -322,12 +349,6 @@
 				reportXmlWriter.WriteEndElement ();
 			}
 			
-			if (knownFailures.Contains (testid))
-				Console.Error.Write ("k");
-			else if (TestResult.Crash == res)
-				Console.Error.Write ("E");
-			else
-				Console.Error.Write ("e");
 		}
 
 		static void Report (TestResult res, string testid, string reference_out, string actual_out)
