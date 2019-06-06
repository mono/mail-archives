Index: XmlTextReader.cs
===================================================================
RCS file: /cvs/public/mcs/class/System.XML/System.Xml/XmlTextReader.cs,v
retrieving revision 1.102
diff -u -r1.102 XmlTextReader.cs
--- XmlTextReader.cs	7 Jan 2004 14:46:43 -0000	1.102
+++ XmlTextReader.cs	11 Jan 2004 08:15:17 -0000
@@ -314,6 +314,8 @@
 			cursorToken.Clear ();
 			currentToken.Clear ();
 			attributeCount = 0;
+			if (reader != null)
+				reader.Close();
 		}
 
 		public override string GetAttribute (int i)
