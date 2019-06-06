Index: Mono.TextEditor.Highlighting/SyntaxModeService.cs
===================================================================
--- Mono.TextEditor.Highlighting/SyntaxModeService.cs	(revision 107132)
+++ Mono.TextEditor.Highlighting/SyntaxModeService.cs	(working copy)
@@ -26,6 +26,7 @@
 //
 
 using System;
+using System.IO;
 using System.Collections.Generic;
 using System.Collections.ObjectModel;
 using System.Reflection;
@@ -69,19 +70,27 @@
 		
 		static void LoadStyle (string name)
 		{
-			XmlTextReader reader = new XmlTextReader (typeof (SyntaxModeService).Assembly.GetManifestResourceStream (styleLookup [name]));
+			using (XmlTextReader reader = new XmlTextReader (typeof (SyntaxModeService).Assembly.GetManifestResourceStream (styleLookup [name]))) 
+				LoadStyle (name, reader);
+		}
+		
+		static void LoadStyle (string name, XmlTextReader reader)
+		{
 			styles [name] = Style.Read (reader);
-			reader.Close ();
 		}
 		
 		static void LoadSyntaxMode (string mimeType)
 		{
-			XmlTextReader reader = new XmlTextReader (typeof (SyntaxModeService).Assembly.GetManifestResourceStream (syntaxModeLookup [mimeType]));
+			using (XmlTextReader reader = new XmlTextReader (typeof (SyntaxModeService).Assembly.GetManifestResourceStream (syntaxModeLookup [mimeType])))
+				LoadSyntaxMode (reader);
+		}
+
+		static void LoadSyntaxMode (XmlTextReader reader)
+		{
 			SyntaxMode mode = SyntaxMode.Read (reader);
 			foreach (string mime in mode.MimeType.Split (';')) {
-				syntaxModes [mime] = mode;
+                                syntaxModes [mime] = mode;
 			}
-			reader.Close ();
 		}
 					
 		public static SyntaxMode GetSyntaxMode (string mimeType)
@@ -347,6 +356,19 @@
 			return reader.GetAttribute (attribute);
 		}
 		
+		public static void RegisterStyle (Stream style)
+		{
+			XmlTextReader reader =  new XmlTextReader (style);
+			string styleName = Scan (reader, Style.NameAttribute);
+			LoadStyle (styleName, reader);
+		}
+
+		public static void RegisterSyntaxMode (Stream syntaxMode)
+		{
+			XmlTextReader reader =  new XmlTextReader (syntaxMode);
+			LoadSyntaxMode (reader);
+		}
+		
 		static SyntaxModeService ()
 		{
 			Assembly thisAssembly = typeof (SyntaxModeService).Assembly;
@@ -370,4 +392,4 @@
 			SyntaxModeService.GetSyntaxMode ("text/x-csharp").AddSemanticRule ("String", new HighlightUrlSemanticRule ("literal"));
 		}
 	}
-}
\ No newline at end of file
+}
