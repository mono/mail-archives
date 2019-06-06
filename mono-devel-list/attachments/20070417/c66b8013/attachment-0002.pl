Index: System.Configuration/ConfigurationSectionCollection.cs
===================================================================
--- System.Configuration/ConfigurationSectionCollection.cs	(revision 75741)
+++ System.Configuration/ConfigurationSectionCollection.cs	(working copy)
@@ -109,7 +109,8 @@
 		
 		public override IEnumerator GetEnumerator()
 		{
-			return group.Sections.AllKeys.GetEnumerator ();
+			foreach (string key in group.Sections.AllKeys)
+				yield return this [key];
 		}
 		
 		public string GetKey (int index)