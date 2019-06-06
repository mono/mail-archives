Index: simplify.xsl
===================================================================
--- simplify.xsl	(revision 44028)
+++ simplify.xsl	(working copy)
@@ -1,34 +0,0 @@
-<?xml version='1.0' ?>
-<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
-<xsl:output indent="yes"/>
-	<xsl:template match="/">
-		<tests>
-			<xsl:for-each select="test-suite/test-catalog/test-case[scenario/@operation='standard']">
-				<xsl:element name="test">
-					<xsl:attribute name="id">
-						<xsl:value-of select="@id"/>
-					</xsl:attribute>
-					<path>
-						<!-- quick fix -->
-						<xsl:choose>
-						<xsl:when test="file-path = 'Value-of'">
-							<xsl:text>Valueof</xsl:text>
-						</xsl:when>
-						<xsl:otherwise>
-						<xsl:value-of select="file-path"/>
-						</xsl:otherwise>
-						</xsl:choose>
-					</path>
-					<data>
-						<xsl:value-of select="scenario/input-file[@role='principal-data']"/>
-					</data>
-					<stylesheet>
-						<xsl:value-of select="scenario/input-file[@role='principal-stylesheet']"/>					</stylesheet>
-					<output>
-						<xsl:value-of select="scenario/output-file"/>
-					</output>
-				</xsl:element>
-			</xsl:for-each>
-		</tests>
-	</xsl:template>
-</xsl:stylesheet>
Index: catalog.sed
===================================================================
--- catalog.sed	(revision 44214)
+++ catalog.sed	(working copy)
@@ -1,3 +1,4 @@
 s/outp\([0-9]+\)/output\1/g
 s/str\([0-9]+\)/string\1/g
 s/expr\([0-9]+\)/expression\1/g
+s/<file-path>Value-of<\/file-path>/<file-path>Valueof<\/file-path>/
Index: ChangeLog
===================================================================
--- ChangeLog	(revision 44214)
+++ ChangeLog	(working copy)
@@ -1,5 +1,12 @@
 2005-05-08  Andrew Skiba  <andrews@mainsoft.com>
 
+	* catalog.sed : fix a bad dirname for Value-of tests
+	* Makefile, alltests.cs : make alltests.cs use the same catalog as
+	xslttest.cs and output '.' and 'E' for test results
+	* simplify.xsl : deleted
+
+2005-05-08  Andrew Skiba  <andrews@mainsoft.com>
+
 	* catalog.sed : fix a typo
 
 2005-05-08  Andrew Skiba  <andrews@mainsoft.com>
Index: alltest.cs
===================================================================
--- alltest.cs	(revision 44028)
+++ alltest.cs	(working copy)
@@ -12,7 +12,7 @@
 		static ArrayList excludedTests = new ArrayList (new string [] {
 });
 
-		static void Process (string id, string path, string data,
+		static void Process (string submitter, string id, string path, string data,
 			string stylesheet, string output, string resDirName)
 		{
 			string dirToCheck = Path.Combine(resDirName, path);
@@ -21,11 +21,12 @@
 
 			string resFileName = Path.Combine ("../..", Path.Combine(dirToCheck, id + ".rst"));
 
-			// hacky!
-			if (path [0] >= 'a')
+ 			if (submitter == "Lotus")
 				Directory.SetCurrentDirectory (Path.Combine ("Xalan_Conformance_Tests", path));
-			else
+ 			else if (submitter == "Microsoft")
 				Directory.SetCurrentDirectory (Path.Combine ("MSFT_Conformance_Tests", path));
+  			else
+ 				return; //unknown directory
 
 #if NET_2_0
 			XslCompiledTransform xslt = new XslCompiledTransform();
@@ -34,6 +35,7 @@
 #endif
 			StreamWriter strWr = new StreamWriter (resFileName, false, System.Text.Encoding.UTF8);
 			XmlTextWriter wr = new XmlTextWriter (strWr);
+			bool success = true;
 			try {
 				XmlDocument xml = new XmlDocument();
 				xml.Load (data);
@@ -47,9 +49,14 @@
 				strWr.Close();
 				strWr = new StreamWriter (resFileName, false, System.Text.Encoding.UTF8);
 				strWr.Write("<exception>{0}</exception>", x.GetType().ToString());
+				success = false;
 			}
 			strWr.Flush();
 			strWr.Close();
+			if (success)
+				Console.Write (".");
+			else
+				Console.Write ("E");
 
 			Directory.SetCurrentDirectory ("../..");
 		}
@@ -76,28 +83,27 @@
 						excludedTests.Add (s);
 				}
 			}
+			Directory.SetCurrentDirectory ("testsuite/TESTS/");
 
-			string pathPrefix = "testsuite/TESTS";
-			Directory.SetCurrentDirectory (pathPrefix);
 
 			XmlDocument catalog = new XmlDocument ();
-			catalog.Load ("catalog-out.xml");
-			XmlNodeList list = catalog.SelectNodes ("//tests/test");
-			foreach (XmlNode node in list) {
-				if (node.SelectSingleNode ("@ignore")!=null)
-					continue;
-				string id = node.SelectSingleNode ("@id").InnerText;
+			catalog.Load ("catalog-fixed.xml");
+			foreach (XmlElement testCase in catalog.SelectNodes ("test-suite/test-catalog/test-case[scenario/@operation='standard']")) {
+				string id = testCase.GetAttribute ("id");
 				// check if the test is excluded.
-				if (excludedTests.Contains (id))
+				if (excludedTests.Contains (id)) {
+					Console.Write ("N");
 					continue;
-				string path = node.SelectSingleNode ("path").InnerText;
-				string data = node.SelectSingleNode ("data").InnerText;
-				string stylesheet = node.SelectSingleNode ("stylesheet").InnerText;
-				string output = node.SelectSingleNode ("output").InnerText;
+				}
+				string submitter = testCase.SelectSingleNode ("./parent::test-catalog/@submitter").InnerText;
+				string path = testCase.SelectSingleNode ("file-path").InnerText;
+				string data = testCase.SelectSingleNode ("scenario/input-file[@role='principal-data']")
+					.InnerText;
+				string stylesheet = testCase.SelectSingleNode ("scenario/input-file[@role='principal-stylesheet']")
+					.InnerText;
+				string output = testCase.SelectSingleNode ("scenario/output-file").InnerText;
 
-				Console.Write ("Processing {0} ...", id);
-				Process (id, path, data, stylesheet, output, topdir);
-				Console.WriteLine ();
+				Process (submitter, id, path, data, stylesheet, output, topdir);
 			}
 		}
 	}
Index: Makefile
===================================================================
--- Makefile	(revision 44213)
+++ Makefile	(working copy)
@@ -24,7 +24,7 @@
 
 prepare-xslt : xslttest.exe $(XSLTTEST_RESULTS) testsuite/TESTS/catalog-fixed.xml
 
-prepare-mstest : alltest.exe $(MSTEST_RESULTS) testsuite/TESTS/catalog-out.xml
+prepare-mstest : alltest.exe $(MSTEST_RESULTS) testsuite/TESTS/catalog-fixed.xml
 
 xslttest.exe : xslttest.cs
 	$(CSCOMPILE) xslttest.cs
@@ -42,9 +42,6 @@
 	unzip -un $(TEST_ARCHIVE)
 	touch $(TESTS)
 
-testsuite/TESTS/catalog-out.xml : testsuite/TESTS/catalog-fixed.xml simplify.xsl
-	xsltproc simplify.xsl testsuite/TESTS/catalog-fixed.xml > testsuite/TESTS/catalog-out.xml
-
 $(XSLTTEST_RESULTS) : $(XSLTTEST_RESULTS_ARCHIVE)
 	unzip -n -d $(XSLTTEST_RESULTS_ARCHIVE)
 	touch $(XSLTTEST_RESULTS)
@@ -67,7 +64,7 @@
 run-test-xslt : xslttest.exe testsuite/TESTS/catalog-fixed.xml
 	$(RUNTIME) $(RUNTIME_FLAGS) xslttest.exe --report:TestResult.xml --xml --details --outall
 
-run-test-ms : alltest.exe xmlnorm.exe testsuite/TESTS/catalog-out.xml
+run-test-ms : alltest.exe xmlnorm.exe testsuite/TESTS/catalog-fixed.xml
 	$(RUNTIME) $(RUNTIME_FLAGS) ./alltest.exe $(TARGET_RESULTS)
 	mono ./xmlnorm.exe -s testsuite/TESTS/$(TARGET_RESULTS) testsuite/TESTS/norm-tmp
 	rm -rf testsuite/TESTS/$(TARGET_RESULTS)
