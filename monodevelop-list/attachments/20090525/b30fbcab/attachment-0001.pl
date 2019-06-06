Index: main/src/core/Mono.Texteditor/Mono.TextEditor/Platform.cs
===================================================================
--- main/src/core/Mono.Texteditor/Mono.TextEditor/Platform.cs	(revision 134437)
+++ main/src/core/Mono.Texteditor/Mono.TextEditor/Platform.cs	(working copy)
@@ -40,9 +40,9 @@
 
 		static Platform ()
 		{
-			IsMac = IsRunningOnMac ();
+			IsWindows = System.IO.Path.DirectorySeparatorChar == '\\';
+			IsMac = !IsWindows && IsRunningOnMac();
 			IsX11 = !IsMac && System.Environment.OSVersion.Platform == PlatformID.Unix;
-			IsWindows = System.IO.Path.PathSeparator == '\\';
 		}
 		
 		public static bool IsMac { get; private set; }
Index: main/src/core/MonoDevelop.Core/MonoDevelop.Core.Serialization/GenericCollectionHandler.cs
===================================================================
--- main/src/core/MonoDevelop.Core/MonoDevelop.Core.Serialization/GenericCollectionHandler.cs	(revision 134437)
+++ main/src/core/MonoDevelop.Core/MonoDevelop.Core.Serialization/GenericCollectionHandler.cs	(working copy)
@@ -52,7 +52,8 @@
 		public static ICollectionHandler CreateHandler (Type t)
 		{
 			Type elemType;
-
+			if (!typeof(IList).IsAssignableFrom (t))
+				return null;
 			MethodInfo addMethod = null;
 			try {
 				addMethod = t.GetMethod ("Add");
Index: main/src/core/MonoDevelop.Core/MonoDevelop.Core/PropertyService.cs
===================================================================
--- main/src/core/MonoDevelop.Core/MonoDevelop.Core/PropertyService.cs	(revision 134437)
+++ main/src/core/MonoDevelop.Core/MonoDevelop.Core/PropertyService.cs	(working copy)
@@ -37,11 +37,11 @@
 	public static class PropertyService
 	{
 		readonly static string FileName = "MonoDevelopProperties.xml";
-		static Properties properties;
-
-		public readonly static bool IsWindows;
-		public readonly static bool IsMac;
-
+		static Properties properties;
+
+		public readonly static bool IsWindows;
+		public readonly static bool IsMac;
+
 		public static Properties GlobalInstance {
 			get { return properties; }
 		}
@@ -94,9 +94,9 @@
 		static extern int uname (IntPtr buf);
 		
 		static PropertyService ()
-		{
-			IsWindows = Path.DirectorySeparatorChar == '\\';
-
+		{
+			IsWindows = Path.DirectorySeparatorChar == '\\';
+
 			if (!LoadProperties (Path.Combine (ConfigPath, FileName))) {
 				if (!LoadProperties (Path.Combine (DataPath, FileName))) {
 					properties = new Properties ();
@@ -107,7 +107,7 @@
 				if (PropertyChanged != null)
 					PropertyChanged (sender, args);
 			};
-			IsMac = IsRunningOnMac ();
+			IsMac = !IsWindows && IsRunningOnMac();
 		}
 		
 		static bool LoadProperties (string fileName)
Index: main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui.Pads/ErrorListPad.cs
===================================================================
--- main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui.Pads/ErrorListPad.cs	(revision 134437)
+++ main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui.Pads/ErrorListPad.cs	(working copy)
@@ -604,13 +604,16 @@
 			string path     = tmpPath;
 			
 			try {
-				fileName = Path.GetFileName(tmpPath);
+				fileName = Path.GetFileName (tmpPath);
 			} catch (Exception) {}
-			
-			try {
-				path = Path.GetDirectoryName(tmpPath);
-			} catch (Exception) {}
-			
+
+			if (tmpPath != null && tmpPath.Contains (Path.DirectorySeparatorChar.ToString ()))
+			{
+				try{
+					path = Path.GetDirectoryName (tmpPath);
+				}
+				catch (Exception) { }
+			}	
 			string project;
 			if (t.OwnerItem is SolutionItem)
 				project = ((SolutionItem)t.OwnerItem).Name;
Index: main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Policies/PolicySet.cs
===================================================================
--- main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Policies/PolicySet.cs	(revision 134437)
+++ main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Policies/PolicySet.cs	(working copy)
@@ -122,9 +122,9 @@
 		
 		internal void SaveToFile (StreamWriter writer)
 		{
-			using (XmlWriter xw = new XmlTextWriter (writer)) {
-				xw.Settings.Indent = true;
-				xw.WriteStartDocument ();
+			XmlWriterSettings xws = new XmlWriterSettings ();
+			xws.Indent = true;
+			using (XmlWriter xw = XmlTextWriter.Create(writer, xws)) {
 				xw.WriteStartElement ("PolicySet");
 				foreach (object o in policies.Values)
 					XmlConfigurationWriter.DefaultWriter.Write (xw, PolicyService.DiffSerialize (o));