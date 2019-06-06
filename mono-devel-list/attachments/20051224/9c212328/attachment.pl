Index: XsltTestUtils.cs
===================================================================
--- XsltTestUtils.cs	(リビジョン 54783)
+++ XsltTestUtils.cs	(作業コピー)
@@ -257,7 +257,7 @@
 				IXPathNavigable input = LoadInput ();
 				using (StringWriter sw = new StringWriter ()) {
 					trans.Transform (input, null, sw, null);
-					_result = sw.ToString ();
+					_result = sw.ToString ().Replace ("\r\n", "\n");
 				}
 			}
 			catch (System.Exception e) {
Index: catalog.sed
===================================================================
--- catalog.sed	(リビジョン 54783)
+++ catalog.sed	(作業コピー)
@@ -5,3 +5,4 @@
 s/str\([0-9]\+\)/string\1/g
 s/expr\([0-9]\+\)/expression\1/g
 s/<file-path>Value-of<\/file-path>/<file-path>Valueof<\/file-path>/
+s/\r//g
Index: xslttest.cs
===================================================================
--- xslttest.cs	(リビジョン 54783)
+++ xslttest.cs	(作業コピー)
@@ -183,7 +183,7 @@
 			if (_transform.Succeeded) {
 				try {
 					using (StreamReader sr = new StreamReader (_transform.TestCase.OutFile))
-						failureMessage = CompareResult (_transform.Result, sr.ReadToEnd (), _transform.TestCase.Compare);
+						failureMessage = CompareResult (_transform.Result, sr.ReadToEnd ().Replace ("\r\n", "\n"), _transform.TestCase.Compare);
 				}
 				catch {
 					//if there is no reference result because of expectedException, we
Index: Makefile
===================================================================
--- Makefile	(リビジョン 54783)
+++ Makefile	(作業コピー)
@@ -84,13 +84,13 @@
 $(GENERATE_EXE) : generate.cs XsltTestUtils.cs
 	$(CSCOMPILE) generate.cs XsltTestUtils.cs -out:$@
 $(TEST_PROG) : xslttest.cs XsltTestUtils.cs
-	$(CSCOMPILE) xslttest.cs XsltTestUtils.cs XmlCompare.cs -r:NUnit.core -r:NUnit.framework -out:$@ -t:library
+	$(CSCOMPILE) xslttest.cs XsltTestUtils.cs XmlCompare.cs -r:nunit.core -r:nunit.framework -out:$@ -t:library
 
 catalog-fixed : $(FIXED_CATALOG)
 
 $(FIXED_CATALOG) : $(CATALOG) catalog.sed catalog-fixed.diff
 	sed -f catalog.sed $(CATALOG) > $(FIXED_CATALOG)
-	patch -p0 $(FIXED_CATALOG) < catalog-fixed.diff
+	patch -p0 -i catalog-fixed.diff
 
 catalog : $(CATALOG)
 
