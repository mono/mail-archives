Index: Makefile
===================================================================
--- Makefile	(revision 41902)
+++ Makefile	(working copy)
@@ -40,6 +40,7 @@
 	$(wildcard System.Xml.Serialization/standalone_tests/*.cs) \
 	$(wildcard System.Xml.Serialization/standalone_tests/*.output) \
 	System.Xml.XPath/Parser.jay	\
+	System.Xml.XPath/PatternParser.jay	\
 	System.Xml.Query/XQueryParser.jay	\
 	System.Xml.Query/skeleton-2.0.cs	\
 	Test/Microsoft.Test.csproj	\
@@ -54,10 +55,15 @@
 System.Xml.XPath/Parser.cs: System.Xml.XPath/Parser.jay $(topdir)/jay/skeleton.cs
 	$(topdir)/jay/jay -ct < $(topdir)/jay/skeleton.cs $< >$@
 
+System.Xml.XPath/PatternParser.cs: System.Xml.XPath/PatternParser.jay $(topdir)/jay/skeleton.cs
+	$(topdir)/jay/jay -ct < $(topdir)/jay/skeleton.cs $< >$@
+
 System.Xml.Query/XQueryParser.cs: System.Xml.Query/XQueryParser.jay System.Xml.Query/skeleton-2.0.cs
 	$(topdir)/jay/jay -ct < System.Xml.Query/skeleton-2.0.cs $< >$@
 
-BUILT_SOURCES = System.Xml.XPath/Parser.cs #System.Xml.Query/XQueryParser.cs
+BUILT_SOURCES = System.Xml.XPath/Parser.cs \
+	System.Xml.XPath/PatternParser.cs
+	#System.Xml.Query/XQueryParser.cs
 CLEAN_FILES = Test/XmlFiles/xsl/result.xml System.Xml.Query/XQueryParser.cs
 
 include ../../build/library.make
Index: Mono.Xml.XPath/Pattern.cs
===================================================================
--- Mono.Xml.XPath/Pattern.cs	(revision 41902)
+++ Mono.Xml.XPath/Pattern.cs	(working copy)
@@ -43,7 +43,7 @@
 	{
 		internal static Pattern Compile (string s, Compiler comp)
 		{		
-			return Compile (comp.parser.Compile (s));
+			return Compile (comp.patternParser.Compile (s));
 		}
 		
 		internal static Pattern Compile (Expression e)
Index: Mono.Xml.Xsl/Compiler.cs
===================================================================
--- Mono.Xml.Xsl/Compiler.cs	(revision 41902)
+++ Mono.Xml.Xsl/Compiler.cs	(working copy)
@@ -127,7 +127,8 @@
 	
 		public CompiledStylesheet Compile (XPathNavigator nav, XmlResolver res, Evidence evidence)
 		{
-			this.parser = new XPathParser (this);
+			this.xpathParser = new XPathParser (this);
+			this.patternParser = new XsltPatternParser (this);
 			this.res = res;
 			if (res == null)
 				this.res = new XmlUrlResolver ();
@@ -350,7 +351,8 @@
 			return p;
 		}
 
-		internal XPathParser parser;
+		internal XPathParser xpathParser;
+		internal XsltPatternParser patternParser;
 		internal CompiledExpression CompileExpression (string expression)
 		{
 			return CompileExpression (expression, false);
@@ -360,7 +362,7 @@
 		{
 			if (expression == null || expression == "") return null;
 
-			Expression expr = parser.Compile (expression);
+			Expression expr = xpathParser.Compile (expression);
 			if (isKey)
 				expr = new ExprKeyContainer (expr);
 			CompiledExpression e = new CompiledExpression (expression, expr);