Index: UnixRegistryApi.cs
===================================================================
--- UnixRegistryApi.cs	(revision 57482)
+++ UnixRegistryApi.cs	(working copy)
@@ -366,18 +366,14 @@
 			return self.values.Keys.Count;
 		}
 		
-		public void DeleteValue (RegistryKey rkey, string value, bool throw_if_missing)
+		public void DeleteValue (RegistryKey rkey, string name, bool throw_if_missing)
 		{
 			KeyHandler self = KeyHandler.Lookup (rkey);
 
-			foreach (DictionaryEntry de in self.values){
-				if ((string)de.Value == value){
-					self.values.Remove (de.Key);
-					return;
-				}
-			}
-			if (throw_if_missing)
-				throw new ArgumentException ("the given value does not exist", "value");
+			if (throw_if_missing && !self.values.Contains (name))
+				throw new ArgumentException ("the given value does not exist", "name");
+
+			self.values.Remove (name);
 		}
 		
 		public void DeleteKey (RegistryKey rkey, string keyname, bool throw_if_missing)
