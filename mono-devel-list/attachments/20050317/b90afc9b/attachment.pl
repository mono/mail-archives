--- System.Xml.XPath/Parser.jay	2005-03-17 06:18:09.720068800 +0900
+++ System.Xml.XPath/PatternParser.jay	2005-03-17 06:15:04.253380800 +0900
@@ -1,7 +1,9 @@
 %{
-// XPath parser
+// XSLT Pattern parser
 //
-// Author - Piers Haken <piersh@friskit.com>
+// Author: Atsushi Enomoto  <atsushi@ximian.com>
+//
+// mostly copied from XPath Parser.jay by Piers Haken <piersh@friskit.com>
 //
 
 using System;
@@ -9,15 +11,15 @@
 using System.Xml;
 using System.Xml.XPath;
 
-namespace Mono.Xml.XPath
+namespace System.Xml.Xsl
 {
-	internal class XPathParser
+	internal class XsltPatternParser
 	{
 	
 		internal System.Xml.Xsl.IStaticXsltContext Context;
 		
-		public XPathParser () : this (null) {}
-		internal XPathParser (System.Xml.Xsl.IStaticXsltContext context)
+		public XsltPatternParser () : this (null) {}
+		internal XsltPatternParser (System.Xml.Xsl.IStaticXsltContext context)
 		{
 			Context = context;
 			ErrorOutput = System.IO.TextWriter.Null;
@@ -27,12 +29,12 @@
 		internal Expression Compile (string xpath)
 		{
 			try {
-				Tokenizer tokenizer = new Tokenizer (xpath);
+				PatternTokenizer tokenizer = new PatternTokenizer (xpath);
 				return (Expression) yyparse (tokenizer);
 			} catch (XPathException e) {
 				throw;
-			} catch (Exception e) {
-				throw new XPathException ("Error during parse of " + xpath, e);
+//			} catch (Exception e) {
+//				throw new XPathException ("Error during parse of " + xpath, e);
 			}
 		}
 		static int yacc_verbose_flag;
@@ -125,7 +127,7 @@
 %token QName
 
 
-%start Expr
+%start Pattern
 
 
 %left AND
@@ -144,6 +146,115 @@
 
 %%
 
+/* XSLT Pattern */
+
+Pattern
+	: LocationPathPattern
+	| Pattern BAR LocationPathPattern
+	{
+		$$ = new ExprUNION ((NodeSet) $1, (NodeSet) $3);
+	}
+	;
+
+LocationPathPattern
+	: SLASH
+	{
+		$$ = new ExprRoot ();
+	}
+	| SLASH RelativePathPattern
+	{
+		$$ = new ExprSLASH (new ExprRoot (), (NodeSet) $2);
+	}
+	| IdKeyPattern
+	| IdKeyPattern SLASH RelativePathPattern
+	{
+		$$ = new ExprSLASH ((Expression) $1, (NodeSet) $3);
+	}
+	| IdKeyPattern SLASH2 RelativePathPattern
+	{
+		$$ = new ExprSLASH2 ((Expression) $1, (NodeSet) $3);
+	}
+	| SLASH2 RelativePathPattern
+	{
+		$$ = new ExprSLASH2 (new ExprRoot (), (NodeSet) $2);
+	}
+	| RelativePathPattern
+	;
+
+// to avoid context-sensitive tokenizer, I just reuse FUNCTION_NAME
+IdKeyPattern
+	: FUNCTION_NAME PAREN_OPEN LITERAL PAREN_CLOSE
+	{
+		XmlQualifiedName name = (XmlQualifiedName) $1;
+		if (name.Name != "id" || name.Namespace != String.Empty)
+			throw new XPathException (String.Format ("Expected 'id' but got '{0}'", name));
+		$$ = ExprFunctionCall.Factory (name,
+			new FunctionArguments (
+				new ExprLiteral ((string) $3),
+				null),
+			Context);
+	}
+	| FUNCTION_NAME PAREN_OPEN LITERAL COMMA LITERAL PAREN_CLOSE
+	{
+		XmlQualifiedName name = (XmlQualifiedName) $1;
+		if (name.Name != "key" || name.Namespace != String.Empty)
+			throw new XPathException (String.Format ("Expected 'key' but got '{0}'", name));
+		$$ = Context.TryGetFunction (name,
+			new FunctionArguments (
+				new ExprLiteral ((string) $3),
+				new FunctionArguments (
+					new ExprLiteral ((string) $5),
+					null)));
+	}
+	;
+
+RelativePathPattern
+	: StepPattern
+	| RelativePathPattern SLASH StepPattern
+	{
+		$$ = new ExprSLASH ((Expression) $1, (NodeSet) $3);
+	}
+	| RelativePathPattern SLASH2 StepPattern
+	{
+		$$ = new ExprSLASH2 ((Expression) $1, (NodeSet) $3);
+	}
+	;
+
+StepPattern
+	: ChildOrAttributeAxisSpecifier NodeTest Predicates
+	{
+		$$ = CreateNodeTest ((Axes) $1, $2, (ArrayList) $3);
+	}
+	;
+
+ChildOrAttributeAxisSpecifier
+	: AbbreviatedAxisSpecifier
+	| CHILD COLON2
+	{
+		$$ = Axes.Child;
+	}
+	| ATTRIBUTE COLON2
+	{
+		$$ = Axes.Attribute;
+	}
+	;
+
+Predicates
+	: // empty
+	{
+		$$ = null;
+	}
+	| Predicates Predicate
+	{
+		ArrayList al = (ArrayList) $1;
+		if (al == null)
+			al = new ArrayList ();
+		al.Add ((Expression) $2);
+		$$ = al;
+	}
+	;
+
+/* ---- end of XSLT Pattern ---- */
 
 
 Expr