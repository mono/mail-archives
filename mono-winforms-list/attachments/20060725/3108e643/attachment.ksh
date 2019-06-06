Index: ControlUpdateMode.cs
===================================================================
--- ControlUpdateMode.cs	(revision 62963)
+++ ControlUpdateMode.cs	(working copy)
@@ -32,7 +32,7 @@
 {
 	public enum ControlUpdateMode
 	{
-		OnPropertyChange = 0,
+		OnPropertyChanged = 0,
 		Never = 1
 	}
 }
Index: DataSourceUpdateMode.cs
===================================================================
--- DataSourceUpdateMode.cs	(revision 62963)
+++ DataSourceUpdateMode.cs	(working copy)
@@ -33,7 +33,7 @@
 	public enum DataSourceUpdateMode
 	{
 		OnValidation = 0,
-		OnPropertyChange = 1,
+		OnPropertyChanged = 1,
 		Never = 2
 	}
 }
Index: HelpNavigator.cs
===================================================================
--- HelpNavigator.cs	(revision 62963)
+++ HelpNavigator.cs	(working copy)
@@ -35,7 +35,7 @@
 		AssociateIndex	= -2147483643,
 		KeywordIndex	= -2147483642,
 #if NET_2_0
-		TopicID		= -2147483641
+		TopicId		= -2147483641
 #endif
 	}
 }
Index: WebBrowserEncryptionLevel.cs
===================================================================
--- WebBrowserEncryptionLevel.cs	(revision 62963)
+++ WebBrowserEncryptionLevel.cs	(working copy)
@@ -38,7 +38,7 @@
 		Bit40 = 3,
 		Bit56 = 4,
 		Fortezza = 5,
-		Bit126 = 6
+		Bit128 = 6
 	}
 }
 #endif
\ No newline at end of file
