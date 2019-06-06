--- System.Xml.XPath/Tokenizer.cs	2005-03-17 05:06:04.510723200 +0900
+++ System.Xml.XPath/PatternTokenizer.cs	2005-03-17 05:40:17.192334400 +0900
@@ -32,12 +32,12 @@
 using System.IO;
 using System.Text;
 using System.Collections;
+using System.Xml.XPath;
 using Mono.Xml.XPath;
-using Mono.Xml.XPath.yyParser;
 
-namespace System.Xml.XPath
+namespace System.Xml.Xsl
 {
-	internal class Tokenizer : Mono.Xml.XPath.yyParser.yyInput
+	internal class PatternTokenizer : yyParser.yyInput
 	{
 		private string m_rgchInput;
 		private int m_ich;
@@ -74,13 +74,13 @@
 		};
 		private const char EOL = '\0';
 
-		static Tokenizer ()
+		static PatternTokenizer ()
 		{
 			for (int i = 0; i < s_rgTokenMap.Length; i += 2)
 				s_mapTokens.Add (s_rgTokenMap [i + 1], s_rgTokenMap [i]);
 		}
 
-		public Tokenizer (string strInput)
+		public PatternTokenizer (string strInput)
 		{
 			//Console.WriteLine ("Tokenizing: " + strInput);
 			m_rgchInput = strInput;