Index: Test/System.Security.Cryptography.Xml/XmlDsigC14NTransformTest.cs
===================================================================
--- Test/System.Security.Cryptography.Xml/XmlDsigC14NTransformTest.cs	(revision 42309)
+++ Test/System.Security.Cryptography.Xml/XmlDsigC14NTransformTest.cs	(working copy)
@@ -104,13 +104,15 @@
 			return sb.ToString ();
 		}
 
-		static string xml = "<Test  attrib='at ' xmlns=\"http://www.go-mono.com/\" > \r\n <Toto/> text &amp; </Test   >";
-		// BAD (framework 1.0 result)
-		static string c14xml1 = "<Test xmlns=\"http://www.go-mono.com/\" attrib=\"at \"> \r\n <Toto></Toto> text &amp; </Test>";
-		// BAD (framework 1.1 result for Stream)
-		static string c14xml2 = "<Test xmlns=\"http://www.go-mono.com/\" attrib=\"at \"> \n <Toto></Toto> text &amp; </Test>";
-		// GOOD (framework 1.1 for XmlDocument and Mono::)
-		static string c14xml3 = "<Test xmlns=\"http://www.go-mono.com/\" attrib=\"at \"> &#xD;\n <Toto></Toto> text &amp; </Test>";
+		static string xml = "<Test  attrib='at ' xmlns=\"http://www.go-mono.com/\" > \r\n &#xD; <Toto/> text &amp; </Test   >";
+		// BAD for XmlDocument input (framework 1.0 result)
+		static string c14xml1 = "<Test xmlns=\"http://www.go-mono.com/\" attrib=\"at \"> \r\n \r <Toto></Toto> text &amp; </Test>";
+		// GOOD for Stream input
+		static string c14xml2 = "<Test xmlns=\"http://www.go-mono.com/\" attrib=\"at \"> \n &#xD; <Toto></Toto> text &amp; </Test>";
+		// GOOD for XmlDocument input. The difference is because once
+		// xml string is loaded to XmlDocument, there is no difference
+		// between \r and &#xD;, so every \r must be handled as &#xD;.
+		static string c14xml3 = "<Test xmlns=\"http://www.go-mono.com/\" attrib=\"at \"> &#xD;\n &#xD; <Toto></Toto> text &amp; </Test>";
 
 		private XmlDocument GetDoc () 
 		{
@@ -127,11 +129,11 @@
 			transform.LoadInput (doc);
 			Stream s = (Stream) transform.GetOutput ();
 			string output = Stream2String (s);
-#if NET_1_0
+#if NET_1_1
+			AssertEquals("XmlDocument", c14xml3, output);
+#else
 			// .NET 1.0 keeps the \r\n (0x0D, 0x0A) - bug
 			AssertEquals("XmlDocument", c14xml1, output);
-#else
-			AssertEquals("XmlDocument", c14xml3, output);
 #endif
 		}
 
@@ -147,13 +149,17 @@
 		}
 
 		[Test]
+		[Category ("NotDotNet")]
+		// MS has a bug that those namespace declaration nodes in
+		// the node-set are written to output. Related spec section is:
+		// http://www.w3.org/TR/2001/REC-xml-c14n-20010315#ProcessingModel
 		public void LoadInputAsXmlNodeList2 () 
 		{
 			XmlDocument doc = GetDoc ();
 			transform.LoadInput (doc.SelectNodes ("//*"));
 			Stream s = (Stream) transform.GetOutput ();
 			string output = Stream2String (s);
-			string expected = @"<Test><Toto xmlns=""http://www.go-mono.com/""></Toto></Test>";
+			string expected = @"<Test><Toto></Toto></Test>";
 			AssertEquals ("XmlChildNodes", expected, output);
 		}
 
@@ -167,10 +173,7 @@
 			transform.LoadInput (ms);
 			Stream s = (Stream) transform.GetOutput ();
 			string output = Stream2String (s);
-			// ARGH! HOW CAN MS RETURN SOMETHING DIFFERENT IF A 
-			// STREAM IS USED THAN IF A XMLDOCUMENT IS USED :-(
-			bool result = ((output == c14xml2) || (output == c14xml3));
-			Assert ("MemoryStream", result);
+			AssertEquals ("MemoryStream", c14xml2, output);
 		}
 
 		[Test]
Index: Test/System.Security.Cryptography.Xml/XmlDsigXPathTransformTest.cs
===================================================================
--- Test/System.Security.Cryptography.Xml/XmlDsigXPathTransformTest.cs	(revision 42309)
+++ Test/System.Security.Cryptography.Xml/XmlDsigXPathTransformTest.cs	(working copy)
@@ -126,9 +126,9 @@
 		public void LoadInputAsXmlDocument () 
 		{
 			XmlDocument doc = GetDoc ();
-			transform.LoadInput (doc);
 			XmlNodeList inner = InnerXml ("//*/title");
 			transform.LoadInnerXml (inner);
+			transform.LoadInput (doc);
 			XmlNodeList xnl = (XmlNodeList) transform.GetOutput ();
 			AssertEquals (47, xnl.Count);
 		}
Index: Test/standalone_tests/xmldsig.cs
===================================================================
--- Test/standalone_tests/xmldsig.cs	(revision 42309)
+++ Test/standalone_tests/xmldsig.cs	(working copy)
@@ -12,6 +12,7 @@
 using System.Collections;
 using System.IO;
 using System.Reflection;
+using System.Runtime.InteropServices;
 using System.Security.Cryptography;
 using System.Security.Cryptography.X509Certificates;
 using System.Security.Cryptography.Xml;
@@ -30,8 +31,13 @@
 	static bool exc14n;
 	static bool hmacmd5;
 
-	public static void Main() 
+	static bool useDecentReader;
+
+	public static void Main(string [] args) 
 	{
+		foreach (string arg in args)
+			if (arg == "--decent-reader")
+				useDecentReader = true;
 		try {
 			// automagically ajust tests to run depending on system config
 			exc14n = (CryptoConfig.CreateFromName ("http://www.w3.org/2001/10/xml-exc-c14n#WithComments") != null);
@@ -80,13 +86,27 @@
 		return path;
 	}
 
+	static TextReader GetReader (string filename)
+	{
+		XmlResolver resolver = new XmlUrlResolver ();
+		Stream stream = resolver.GetEntity (resolver.ResolveUri (null, filename), null, typeof (Stream)) as Stream;
+		if (useDecentReader)
+			return new XmlSignatureStreamReader (
+				new StreamReader (stream));
+		else
+			return new StreamReader (stream);
+	}
+
 	static void Symmetric (string filename, byte[] key) 
 	{
 		string shortName = Path.GetFileName (filename);
 
 		XmlDocument doc = new XmlDocument ();
 		doc.PreserveWhitespace = true;
-		doc.Load (filename);
+		XmlTextReader xtr = new XmlTextReader (GetReader (filename));
+		XmlValidatingReader xvr = new XmlValidatingReader (xtr);
+		xtr.Normalization = true;
+		doc.Load (xvr);
                 
 		try {
 			XmlNodeList nodeList = doc.GetElementsByTagName ("Signature", SignedXml.XmlDsigNamespaceUrl);
@@ -116,8 +136,11 @@
 		string shortName = Path.GetFileName (filename);
 
 		XmlDocument doc = new XmlDocument ();
+		XmlTextReader xtr = new XmlTextReader (GetReader (filename));
+		XmlValidatingReader xvr = new XmlValidatingReader (xtr);
+		xtr.Normalization = true;
 		doc.PreserveWhitespace = true;
-		doc.Load (filename);
+		doc.Load (xvr);
 
 		try {
 			SignedXml s = null;
@@ -332,3 +355,89 @@
 	}
 }
 
+// below is a copy from our System.Security.dll source.
+	internal class XmlSignatureStreamReader : TextReader
+	{
+		TextReader source;
+		int cache = int.MinValue;
+
+		public XmlSignatureStreamReader (TextReader input)
+		{
+			source =input;
+		}
+
+		public override void Close ()
+		{
+			source.Close ();
+		}
+
+		public override int Peek ()
+		{
+			if (cache != int.MinValue)
+				return cache;
+			cache = source.Read ();
+			if (cache != '\r')
+				return cache;
+			// cache must be '\r' here.
+			if (source.Peek () != '\n')
+				return '\r';
+			// Now Peek() returns '\n', so clear cache.
+			cache = int.MinValue;
+			return '\n';
+		}
+
+		public override int Read ()
+		{
+			if (cache != int.MinValue) {
+				int ret = cache;
+				cache = int.MinValue;
+				return ret;
+			}
+			int i = source.Read ();
+			if (i != '\r')
+				return i;
+			// read one more char (after '\r')
+			cache = source.Read ();
+			if (cache != '\n')
+				return '\r';
+			cache = int.MinValue;
+			return '\n';
+		}
+
+		public override int ReadBlock (
+			[In, Out] char [] buffer, int index, int count)
+		{
+			char [] tmp = new char [count];
+			source.ReadBlock (tmp, 0, count);
+			int j = index;
+			for (int i = 0; i < count; j++) {
+				if (tmp [i] == '\r') {
+					if (++i < tmp.Length && tmp [i] == '\n')
+						buffer [j] = tmp [i++];
+					else
+						buffer [j] = '\r';
+				}
+				else
+					buffer [j] = tmp [i];
+			}
+			while (j < count) {
+				int d = Read ();
+				if (d < 0)
+					break;
+				buffer [j++] = (char) d;
+			}
+			return j;
+		}
+
+		public override string ReadLine ()
+		{
+			return source.ReadLine ().Replace ("\r\n", "\n");
+		}
+
+		public override string ReadToEnd ()
+		{
+			return source.ReadToEnd ().Replace ("\r\n", "\n");
+		}
+
+	}
+
Index: Test/standalone_tests/Makefile
===================================================================
--- Test/standalone_tests/Makefile	(revision 42309)
+++ Test/standalone_tests/Makefile	(working copy)
@@ -1,5 +1,8 @@
 RUNTIME = mono --debug 
 CSCOMPILE = mcs --debug
+PROFILE = default
+#XMLDSIG_EXE_OPTIONS =
+XMLDSIG_EXE_OPTIONS = --decent-reader
 
 run-test: c14n.exe xmldsig.exe merlin-xmldsig-twenty-three
 	$(RUNTIME) c14n.exe merlin-xmldsig-twenty-three/signature-enveloped-dsa.xml SignedInfo | cmp merlin-xmldsig-twenty-three/signature-enveloped-dsa-c14n-1.txt
@@ -10,10 +13,10 @@
 	$(RUNTIME) c14n.exe merlin-xmldsig-twenty-three/signature-enveloping-rsa.xml SignedInfo | cmp merlin-xmldsig-twenty-three/signature-enveloping-rsa-c14n-1.txt
 	$(RUNTIME) c14n.exe merlin-xmldsig-twenty-three/signature-external-b64-dsa.xml SignedInfo | cmp merlin-xmldsig-twenty-three/signature-external-b64-dsa-c14n-0.txt
 	$(RUNTIME) c14n.exe merlin-xmldsig-twenty-three/signature-external-dsa.xml SignedInfo | cmp merlin-xmldsig-twenty-three/signature-external-dsa-c14n-0.txt
-	$(RUNTIME) xmldsig.exe
+	$(RUNTIME) xmldsig.exe $(XMLDSIG_EXE_OPTIONS)
 
 ms-test: c14n.exe xmldsig.exe merlin-xmldsig-twenty-three
-	cp ../../../lib/Mono.Security.dll .
+	cp ../../../lib/$(PROFILE)/Mono.Security.dll .
 	./c14n.exe merlin-xmldsig-twenty-three/signature-enveloped-dsa.xml SignedInfo | cmp merlin-xmldsig-twenty-three/signature-enveloped-dsa-c14n-1.txt
 	./c14n.exe merlin-xmldsig-twenty-three/signature-enveloping-b64-dsa.xml SignedInfo | cmp merlin-xmldsig-twenty-three/signature-enveloping-b64-dsa-c14n-0.txt
 	./c14n.exe merlin-xmldsig-twenty-three/signature-enveloping-dsa.xml SignedInfo | cmp merlin-xmldsig-twenty-three/signature-enveloping-dsa-c14n-1.txt
@@ -22,7 +25,7 @@
 	./c14n.exe merlin-xmldsig-twenty-three/signature-enveloping-rsa.xml SignedInfo | cmp merlin-xmldsig-twenty-three/signature-enveloping-rsa-c14n-1.txt
 	./c14n.exe merlin-xmldsig-twenty-three/signature-external-b64-dsa.xml SignedInfo | cmp merlin-xmldsig-twenty-three/signature-external-b64-dsa-c14n-0.txt
 	./c14n.exe merlin-xmldsig-twenty-three/signature-external-dsa.xml SignedInfo | cmp merlin-xmldsig-twenty-three/signature-external-dsa-c14n-0.txt
-	./xmldsig.exe
+	./xmldsig.exe $(XMLDSIG_EXE_OPTIONS)
 	rm Mono.Security.dll
 
 clean:
@@ -32,7 +35,7 @@
 	$(CSCOMPILE) c14n.cs -r:System.Security
 
 xmldsig.exe: xmldsig.cs
-	$(CSCOMPILE) xmldsig.cs -r:System.Security -r:../../../lib/Mono.Security.dll
+	$(CSCOMPILE) xmldsig.cs -r:System.Security -r:Mono.Security.dll
 
 phaos-xmldsig-three: phaos-xmldsig-three.zip
 	unzip -u phaos-xmldsig-three.zip
Index: System.Security.Cryptography.Xml/XmlDsigXsltTransform.cs
===================================================================
--- System.Security.Cryptography.Xml/XmlDsigXsltTransform.cs	(revision 42309)
+++ System.Security.Cryptography.Xml/XmlDsigXsltTransform.cs	(working copy)
@@ -144,7 +144,9 @@
 #if NET_1_1
 				inputDoc.XmlResolver = GetResolver ();
 #endif
-				inputDoc.Load (obj as Stream);
+//				inputDoc.Load (obj as Stream);
+				inputDoc.Load (new XmlSignatureStreamReader (
+					new StreamReader (obj as Stream)));
 			}
 			else if (obj is XmlDocument) {
 				inputDoc= obj as XmlDocument;
Index: System.Security.Cryptography.Xml/XmlSignatureStreamReader.cs
===================================================================
--- System.Security.Cryptography.Xml/XmlSignatureStreamReader.cs	(revision 0)
+++ System.Security.Cryptography.Xml/XmlSignatureStreamReader.cs	(revision 0)
@@ -0,0 +1,131 @@
+//
+// XmlSignatureStreamReader.cs: Wrap TextReader and eliminate \r
+//
+// Author:
+//	Atsushi Enomoto (atsushi@ximian.com)
+//
+// (C) 2005 Novell Inc.
+//
+
+//
+// Permission is hereby granted, free of charge, to any person obtaining
+// a copy of this software and associated documentation files (the
+// "Software"), to deal in the Software without restriction, including
+// without limitation the rights to use, copy, modify, merge, publish,
+// distribute, sublicense, and/or sell copies of the Software, and to
+// permit persons to whom the Software is furnished to do so, subject to
+// the following conditions:
+// 
+// The above copyright notice and this permission notice shall be
+// included in all copies or substantial portions of the Software.
+// 
+// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
+// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
+// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
+// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+//
+//
+// Use it to distinguish &#xD; and \r. \r is removed, while &#xD; is not.
+//
+//
+
+using System;
+using System.IO;
+using System.Runtime.InteropServices;
+
+namespace System.Security.Cryptography.Xml
+{
+	internal class XmlSignatureStreamReader : TextReader
+	{
+		TextReader source;
+		int cache = int.MinValue;
+
+		public XmlSignatureStreamReader (TextReader input)
+		{
+			source =input;
+		}
+
+		public override void Close ()
+		{
+			source.Close ();
+		}
+
+		public override int Peek ()
+		{
+			// If source TextReader does not support Peek(),
+			// it does not support too. Or it just returns EOF.
+			if (source.Peek () == -1)
+				return -1;
+
+			if (cache != int.MinValue)
+				return cache;
+			cache = source.Read ();
+			if (cache != '\r')
+				return cache;
+			// cache must be '\r' here.
+			if (source.Peek () != '\n')
+				return '\r';
+			// Now Peek() returns '\n', so clear cache.
+			cache = int.MinValue;
+			return '\n';
+		}
+
+		public override int Read ()
+		{
+			if (cache != int.MinValue) {
+				int ret = cache;
+				cache = int.MinValue;
+				return ret;
+			}
+			int i = source.Read ();
+			if (i != '\r')
+				return i;
+			// read one more char (after '\r')
+			cache = source.Read ();
+			if (cache != '\n')
+				return '\r';
+			cache = int.MinValue;
+			return '\n';
+		}
+
+		public override int ReadBlock (
+			[In, Out] char [] buffer, int index, int count)
+		{
+			char [] tmp = new char [count];
+			source.ReadBlock (tmp, 0, count);
+			int j = index;
+			for (int i = 0; i < count; j++) {
+				if (tmp [i] == '\r') {
+					if (++i < tmp.Length && tmp [i] == '\n')
+						buffer [j] = tmp [i++];
+					else
+						buffer [j] = '\r';
+				}
+				else
+					buffer [j] = tmp [i];
+			}
+			while (j < count) {
+				int d = Read ();
+				if (d < 0)
+					break;
+				buffer [j++] = (char) d;
+			}
+			return j;
+		}
+
+		// I have no idea what to do here, but I don't think it 
+		// makes sense.
+		public override string ReadLine ()
+		{
+			return source.ReadLine ();
+		}
+
+		public override string ReadToEnd ()
+		{
+			return source.ReadToEnd ().Replace ("\r\n", "\n");
+		}
+	}
+}
Index: System.Security.Cryptography.Xml/XmlDsigEnvelopedSignatureTransform.cs
===================================================================
--- System.Security.Cryptography.Xml/XmlDsigEnvelopedSignatureTransform.cs	(revision 42309)
+++ System.Security.Cryptography.Xml/XmlDsigEnvelopedSignatureTransform.cs	(working copy)
@@ -104,7 +104,8 @@
 #if NET_1_1
 				doc.XmlResolver = GetResolver ();
 #endif
-				doc.Load (inputObj as Stream);
+				doc.Load (new XmlSignatureStreamReader (
+					new StreamReader (inputObj as Stream)));
 				return GetOutputFromNode (doc, GetNamespaceManager (doc), true);
 			}
 			else if (inputObj is XmlDocument) {
Index: System.Security.Cryptography.Xml/XmlDsigC14NTransform.cs
===================================================================
--- System.Security.Cryptography.Xml/XmlDsigC14NTransform.cs	(revision 42309)
+++ System.Security.Cryptography.Xml/XmlDsigC14NTransform.cs	(working copy)
@@ -124,7 +124,12 @@
 				s = (obj as Stream);
 				XmlDocument doc = new XmlDocument ();
 				doc.PreserveWhitespace = true;	// REALLY IMPORTANT
-				doc.Load (obj as Stream);
+#if NET_1_1
+				doc.XmlResolver = GetResolver ();
+#endif
+				doc.Load (new XmlSignatureStreamReader (
+					new StreamReader ((Stream) obj)));
+//				doc.Load ((Stream) obj);
 				s = canonicalizer.Canonicalize (doc);
 			} else if (obj is XmlDocument)
 				s = canonicalizer.Canonicalize ((obj as XmlDocument));
Index: System.Security.Cryptography.Xml/XmlDecryptionTransform.cs
===================================================================
--- System.Security.Cryptography.Xml/XmlDecryptionTransform.cs	(revision 42309)
+++ System.Security.Cryptography.Xml/XmlDecryptionTransform.cs	(working copy)
@@ -129,10 +129,9 @@
 			if (inputObj is Stream) {
 				document = new XmlDocument ();
 				document.PreserveWhitespace = true;
-#if NET_1_1
 				document.XmlResolver = GetResolver ();
-#endif
-				document.Load (inputObj as Stream);
+				document.Load (new XmlSignatureStreamReader (
+					new StreamReader (inputObj as Stream)));
 			}
 			else if (inputObj is XmlDocument) {
 				document = inputObj as XmlDocument;
Index: System.Security.Cryptography.Xml/XmlDsigXPathTransform.cs
===================================================================
--- System.Security.Cryptography.Xml/XmlDsigXPathTransform.cs	(revision 42309)
+++ System.Security.Cryptography.Xml/XmlDsigXPathTransform.cs	(working copy)
@@ -192,17 +192,19 @@
 			// possible input: Stream, XmlDocument, and XmlNodeList
 			if (obj is Stream) {
 				doc = new XmlDocument ();
-#if ! NET_1_0
+				doc.PreserveWhitespace = true;
+#if NET_1_1
 				doc.XmlResolver = GetResolver ();
 #endif
-				doc.Load (obj as Stream);
+				doc.Load (new XmlSignatureStreamReader (
+					new StreamReader ((Stream) obj)));
 			}
 			else if (obj is XmlDocument) {
 				doc = (obj as XmlDocument);
 			}
 			else if (obj is XmlNodeList) {
 				doc = new XmlDocument ();
-#if ! NET_1_0
+#if NET_1_1
 				doc.XmlResolver = GetResolver ();
 #endif
 				foreach (XmlNode xn in (obj as XmlNodeList))  {
Index: System.Security.dll.sources
===================================================================
--- System.Security.dll.sources	(revision 42309)
+++ System.Security.dll.sources	(working copy)
@@ -120,6 +120,7 @@
 System.Security.Cryptography.Xml/XmlDsigXsltTransform.cs
 System.Security.Cryptography.Xml/XmlEncryption.cs
 System.Security.Cryptography.Xml/XmlSignature.cs
+System.Security.Cryptography.Xml/XmlSignatureStreamReader.cs
 System.Security.Cryptography.Xml/TODOAttribute.cs
 System.Security.Permissions/DataProtectionPermission.cs
 System.Security.Permissions/DataProtectionPermissionAttribute.cs
Index: Mono.Xml/XmlCanonicalizer.cs
===================================================================
--- Mono.Xml/XmlCanonicalizer.cs	(revision 42309)
+++ Mono.Xml/XmlCanonicalizer.cs	(working copy)
@@ -514,13 +514,8 @@
 					sb.Append ("&#x9;");
 				else if (ch == '\x0A' && type == XmlNodeType.Attribute)
 					sb.Append ("&#xA;");
-				else if (ch == '\x0D' && (type == XmlNodeType.Attribute ||
-							  IsTextNode (type) && type != XmlNodeType.Whitespace ||
-							  type == XmlNodeType.Comment ||
-							  type == XmlNodeType.ProcessingInstruction))
-					sb.Append ("&#xD;");
 				else if (ch == '\x0D')
-					continue;
+					sb.Append ("&#xD;");
 				else
 					sb.Append (ch);
 			}