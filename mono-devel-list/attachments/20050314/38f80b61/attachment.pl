Index: DirectoryEntry.cs
===================================================================
--- DirectoryEntry.cs	(revision 41792)
+++ DirectoryEntry.cs	(working copy)
@@ -54,8 +54,8 @@
 		private string _Path="";
 		private string _Name=null;
 		private DirectoryEntry _Parent=null;
-		private string _Username="";
-		private string _Password="";
+		private string _Username=null;
+		private string _Password=null;
 		//private string _Nativeguid;
 		private PropertyCollection _Properties = null;
 		private string _SchemaClassName=null;
