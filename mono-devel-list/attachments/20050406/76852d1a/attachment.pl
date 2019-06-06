Index: Mono.Xml.Xsl/XslDecimalFormat.cs
===================================================================
--- Mono.Xml.Xsl/XslDecimalFormat.cs	(revision 42600)
+++ Mono.Xml.Xsl/XslDecimalFormat.cs	(working copy)
@@ -29,18 +29,133 @@
 //
 
 using System;
-using System.Collections;
-using System.Globalization;
-using System.Text;
 using System.Xml;
 using System.Xml.XPath;
 using System.Xml.Xsl;
 
 using QName = System.Xml.XmlQualifiedName;
 
+#if TARGET_JVM
+ namespace Mono.Xml.Xsl {
+ 	internal class XslDecimalFormat {
+ 		
+		java.text.DecimalFormatSymbols javaFormat;
+		string baseUri;
+		int lineNumber;
+		int linePosition;
+
+		public static readonly XslDecimalFormat Default = new XslDecimalFormat ();
+		
+		XslDecimalFormat ()
+		{
+			javaFormat = new java.text.DecimalFormatSymbols ();
+		}
+
+		public XslDecimalFormat (Compiler c)
+			:this ()
+		{
+			Initialize(c); 
+		}
+
+		private void Initialize(Compiler c)
+		{
+			XPathNavigator n = c.Input;
+
+			IXmlLineInfo li = n as IXmlLineInfo;
+			if (li != null) {
+				lineNumber = li.LineNumber;
+				linePosition = li.LinePosition;
+			}
+			baseUri = n.BaseURI;
+
+			if (n.MoveToFirstAttribute ()) {
+				do {
+					if (n.NamespaceURI != String.Empty)
+						continue;
+					
+					switch (n.LocalName) {
+					case "name": break; // already handled
+					case "decimal-separator":
+						if (n.Value.Length != 1)
+							throw new XsltCompileException ("XSLT decimal-separator value must be exact one character.", null, n);
+						javaFormat.setDecimalSeparator (n.Value[0]);
+						break;
+						
+					case "grouping-separator":
+						if (n.Value.Length != 1)
+							throw new XsltCompileException ("XSLT grouping-separator value must be exact one character.", null, n);
+						javaFormat.setGroupingSeparator (n.Value[0]);
+						break;
+						
+					case "infinity":
+						javaFormat.setInfinity (n.Value);
+						break;
+					case "minus-sign":
+						if (n.Value.Length != 1)
+							throw new XsltCompileException ("XSLT minus-sign value must be exact one character.", null, n);
+						javaFormat.setMinusSign (n.Value[0]);
+						break;
+					case "NaN":
+						javaFormat.setNaN (n.Value);
+						break;
+					case "percent":
+						if (n.Value.Length != 1)
+							throw new XsltCompileException ("XSLT percent value must be exact one character.", null, n);
+						javaFormat.setPercent (n.Value[0]);
+						break;
+					case "per-mille":
+						if (n.Value.Length != 1)
+							throw new XsltCompileException ("XSLT per-mille value must be exact one character.", null, n);
+						javaFormat.setPerMill (n.Value[0]);
+						break;
+					case "digit":
+						if (n.Value.Length != 1)
+							throw new XsltCompileException ("XSLT digit value must be exact one character.", null, n);
+						javaFormat.setDigit (n.Value[0]);
+						break;
+					case "zero-digit":
+						if (n.Value.Length != 1)
+							throw new XsltCompileException ("XSLT zero-digit value must be exact one character.", null, n);
+						javaFormat.setZeroDigit (n.Value [0]);
+						break;
+					case "pattern-separator":
+						if (n.Value.Length != 1)
+							throw new XsltCompileException ("XSLT pattern-separator value must be exact one character.", null, n);
+						javaFormat.setPatternSeparator (n.Value [0]);
+						break;
+					}
+				} while (n.MoveToNextAttribute ());
+				n.MoveToParent ();
+			}
+		}
+
+		public void CheckSameAs (XslDecimalFormat other)
+		{
+			if (! this.javaFormat.equals (other.javaFormat))
+				throw new XsltCompileException (null, other.baseUri, other.lineNumber, other.linePosition);
+		}
+
+		public string FormatNumber (double number, string pattern)
+		{
+			java.text.DecimalFormat frm = new java.text.DecimalFormat("", javaFormat);
+
+			frm.applyLocalizedPattern (pattern);
+			java.lang.StringBuffer buffer= new java.lang.StringBuffer ();
+			java.text.FieldPosition fld = new java.text.FieldPosition (0);
+
+			frm.format (number, buffer, fld);
+			return buffer.ToString();
+		}
+	}
+}
+#else
+using System.Collections;
+using System.Globalization;
+using System.Text;
+
namespace Mono.Xml.Xsl {
	internal class XslDecimalFormat {
		
 		NumberFormatInfo info = new NumberFormatInfo ();
 		char digit = '#', zeroDigit = '0', patternSeparator = ';';
 		string baseUri;
@@ -336,4 +447,5 @@
 			return builder.ToString ();
 		}
 	}
-}
\ No newline at end of file
+}
+#endif
