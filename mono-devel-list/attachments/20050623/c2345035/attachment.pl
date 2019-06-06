Index: Test/System.Xml/XmlTextReaderTests.cs
===================================================================
--- Test/System.Xml/XmlTextReaderTests.cs	(revision 46370)
+++ Test/System.Xml/XmlTextReaderTests.cs	(working copy)
@@ -1100,5 +1100,20 @@
 			AssertEquals ("#1", 0xf090, (int) r.Value [0]);
 			AssertEquals ("#1", 0x8080, (int) r.Value [1]);
 		}
+
+		[Test]
+		[ExpectedException (typeof (XmlException))]
+		public void EntityDeclarationNotWF ()
+		{
+			string xml = @"<!DOCTYPE doc [
+				<!ELEMENT doc (#PCDATA)>
+				<!ENTITY e ''>
+				<!ENTITY e '<foo&>'>
+				]>
+				<doc>&e;</doc> ";
+			XmlTextReader xtr = new XmlTextReader (xml,
+				XmlNodeType.Document, null);
+			xtr.Read ();
+		}
 	}
 }
