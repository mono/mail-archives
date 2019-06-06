Index: main/src/addins/MonoDevelop.RegexToolkit/MonoDevelop.RegexToolkit/RegexLibraryWindow.cs
===================================================================
--- main/src/addins/MonoDevelop.RegexToolkit/MonoDevelop.RegexToolkit/RegexLibraryWindow.cs	(revision 134691)
+++ main/src/addins/MonoDevelop.RegexToolkit/MonoDevelop.RegexToolkit/RegexLibraryWindow.cs	(working copy)
@@ -132,8 +132,8 @@
 		}
 		
 #region I/O
-		const string version         = "1.0";
-		const string libraryFileName = "MonoDevelop.RegexToolkit.library.xml";
+		const string version         = "1.0";
+		const string libraryFileName = "MonoDevelop.RegexToolkit.library.xml";
 		
 		static string LibraryLocation {
 			get {
@@ -193,7 +193,10 @@
 		void WriteRegexes ()
 		{
 			Stream stream = new FileStream (LibraryLocation, FileMode.Create);
-			XmlWriter writer = new XmlTextWriter (stream, Encoding.UTF8);
+			XmlWriterSettings settings = new XmlWriterSettings ();
+			settings.Encoding = System.Text.Encoding.UTF8;
+			settings.Indent = true;
+			XmlWriter writer = XmlTextWriter.Create (stream, settings);
 			try {
 				writer.Settings.Indent = true;
 				writer.WriteStartElement (Node);
Index: main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.ExternalTools/ExternalToolService.cs
===================================================================
--- main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.ExternalTools/ExternalToolService.cs	(revision 134691)
+++ main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.ExternalTools/ExternalToolService.cs	(working copy)
@@ -68,8 +68,10 @@
 		
 		static void SaveTools (string fileName)
 		{
-			XmlTextWriter writer = new XmlTextWriter (fileName, System.Text.Encoding.UTF8);
-			writer.Settings.Indent = true;
+			XmlWriterSettings settings = new XmlWriterSettings ();
+			settings.Encoding = System.Text.Encoding.UTF8;
+			settings.Indent = true;
+			XmlWriter writer = XmlTextWriter.Create (fileName, settings);
 			try {
 				writer.WriteStartDocument ();
 				writer.WriteStartElement (Node);