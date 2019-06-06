Index: ChangeLog
===================================================================
--- ChangeLog	(revision 45578)
+++ ChangeLog	(working copy)
@@ -1,3 +1,8 @@
+2004-06-09  Andrew Skiba  <andrews@mainsoft.com>
+
+	* Makefile, catalog-fixed.diff : Patch the fixed catalog to correct things 
+	I could not fix with sed script
+
 2005-06-06  Andrew Skiba  <andrews@mainsoft.com>
 
 	* xslttest.cs : change messages
Index: Makefile
===================================================================
--- Makefile	(revision 45578)
+++ Makefile	(working copy)
@@ -68,9 +68,14 @@
 .cs.exe :
 	$(CSCOMPILE) $<
 
-$(FIXED_CATALOG) : $(CATALOG) catalog.sed
+catalog-fixed : $(FIXED_CATALOG)
+
+$(FIXED_CATALOG) : $(CATALOG) catalog.sed catalog.diff
 	sed -f catalog.sed $(CATALOG) > $(FIXED_CATALOG)
+	patch -p0 $(FIXED_CATALOG) < catalog-fixed.diff
 
+catalog : $(CATALOG)
+
 $(CATALOG) : $(TEST_ARCHIVE)
 	unzip -un $(TEST_ARCHIVE)
 	touch $(CATALOG)
Index: catalog-fixed.diff
===================================================================
--- catalog-fixed.diff	(revision 0)
+++ catalog-fixed.diff	(revision 0)
@@ -0,0 +1,104 @@
+--- testsuite/TESTS/catalog-fixed.xml	2005-06-09 10:29:51.941937800 +0300
++++ catalog-fixed.xml	2005-06-09 10:11:58.629437800 +0300
+@@ -17155,14 +17155,14 @@
+ <output-file role="principal" compare="XML">string11.out</output-file>
+ </scenario>
+ </test-case>
+-<test-case category="XSLT-Result-Tree" id="string_string09">
++<test-case category="XSLT-Result-Tree" id="string_string12">
+ <file-path>string</file-path>
+ <purpose>Test of 'concat()'</purpose>
+ <spec-citation place="4.2" type="section" version="1.0" spec="xpath"/>
+ <scenario operation="standard">
+-<input-file role="principal-data">string09.xml</input-file>
+-<input-file role="principal-stylesheet">string09.xsl</input-file>
+-<output-file role="principal" compare="XML">string09.out</output-file>
++<input-file role="principal-data">string12.xml</input-file>
++<input-file role="principal-stylesheet">string12.xsl</input-file>
++<output-file role="principal" compare="XML">string12.out</output-file>
+ </scenario>
+ </test-case>
+ <test-case category="XSLT-Result-Tree" id="string_string13">
+@@ -17277,58 +17277,58 @@
+ <output-file role="principal" compare="XML">string30.out</output-file>
+ </scenario>
+ </test-case>
+-<test-case category="XSLT-Result-Tree" id="string_">
++<test-case category="XSLT-Result-Tree" id="string_string31">
+ <file-path>string</file-path>
+ <spec-citation place="" type="section" version="1.0" spec="ooops!"/>
+ <scenario operation="standard">
+-<input-file role="principal-data">.xml</input-file>
+-<input-file role="principal-stylesheet">.xsl</input-file>
+-<output-file role="principal" compare="XML">.out</output-file>
++<input-file role="principal-data">string31.xml</input-file>
++<input-file role="principal-stylesheet">string31.xsl</input-file>
++<output-file role="principal" compare="XML">string31.out</output-file>
+ </scenario>
+ </test-case>
+-<test-case category="XSLT-Result-Tree" id="string_">
++<test-case category="XSLT-Result-Tree" id="string_string32">
+ <file-path>string</file-path>
+ <spec-citation place="" type="section" version="1.0" spec="ooops!"/>
+ <scenario operation="standard">
+-<input-file role="principal-data">.xml</input-file>
+-<input-file role="principal-stylesheet">.xsl</input-file>
+-<output-file role="principal" compare="XML">.out</output-file>
++<input-file role="principal-data">string32.xml</input-file>
++<input-file role="principal-stylesheet">string32.xsl</input-file>
++<output-file role="principal" compare="XML">string32.out</output-file>
+ </scenario>
+ </test-case>
+-<test-case category="XSLT-Result-Tree" id="string_">
++<test-case category="XSLT-Result-Tree" id="string_string33">
+ <file-path>string</file-path>
+ <spec-citation place="" type="section" version="1.0" spec="ooops!"/>
+ <scenario operation="standard">
+-<input-file role="principal-data">.xml</input-file>
+-<input-file role="principal-stylesheet">.xsl</input-file>
+-<output-file role="principal" compare="XML">.out</output-file>
++<input-file role="principal-data">string33.xml</input-file>
++<input-file role="principal-stylesheet">string33.xsl</input-file>
++<output-file role="principal" compare="XML">string33.out</output-file>
+ </scenario>
+ </test-case>
+-<test-case category="XSLT-Result-Tree" id="string_">
++<test-case category="XSLT-Result-Tree" id="string_string34">
+ <file-path>string</file-path>
+ <spec-citation place="" type="section" version="1.0" spec="ooops!"/>
+ <scenario operation="standard">
+-<input-file role="principal-data">.xml</input-file>
+-<input-file role="principal-stylesheet">.xsl</input-file>
+-<output-file role="principal" compare="XML">.out</output-file>
++<input-file role="principal-data">string34.xml</input-file>
++<input-file role="principal-stylesheet">string34.xsl</input-file>
++<output-file role="principal" compare="XML">string34.out</output-file>
+ </scenario>
+ </test-case>
+-<test-case category="XSLT-Result-Tree" id="string_">
++<test-case category="XSLT-Result-Tree" id="string_string35">
+ <file-path>string</file-path>
+ <spec-citation place="" type="section" version="1.0" spec="ooops!"/>
+ <scenario operation="standard">
+-<input-file role="principal-data">.xml</input-file>
+-<input-file role="principal-stylesheet">.xsl</input-file>
+-<output-file role="principal" compare="XML">.out</output-file>
++<input-file role="principal-data">string35.xml</input-file>
++<input-file role="principal-stylesheet">string35.xsl</input-file>
++<output-file role="principal" compare="XML">string35.out</output-file>
+ </scenario>
+ </test-case>
+-<test-case category="XSLT-Result-Tree" id="string_">
++<test-case category="XSLT-Result-Tree" id="string_string36">
+ <file-path>string</file-path>
+ <spec-citation place="" type="section" version="1.0" spec="ooops!"/>
+ <scenario operation="standard">
+-<input-file role="principal-data">.xml</input-file>
+-<input-file role="principal-stylesheet">.xsl</input-file>
+-<output-file role="principal" compare="XML">.out</output-file>
++<input-file role="principal-data">string36.xml</input-file>
++<input-file role="principal-stylesheet">string36.xsl</input-file>
++<output-file role="principal" compare="XML">string36.out</output-file>
+ </scenario>
+ </test-case>
+ <test-case category="XSLT-Result-Tree" id="string_string37">
