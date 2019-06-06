Index: Changelog
===================================================================
--- Changelog	(revision 144512)
+++ Changelog	(working copy)
@@ -1,3 +1,7 @@
+2009-10-21  Carlo Kok  <ck@remobjects.com>
+
+	* RuntimeLicenseContext.cs: Support for the resourceAssembly parameter.
+
 2009-10-12  Carlo Kok  <ck@remobjects.com>
 
 	* DesigntimeLicenseContextSerializer.cs: Properly serialize licenses.
Index: RuntimeLicenseContext.cs
===================================================================
--- RuntimeLicenseContext.cs	(revision 144512)
+++ RuntimeLicenseContext.cs	(working copy)
@@ -44,6 +44,7 @@
 {
 	internal class RuntimeLicenseContext : LicenseContext
 	{
+        private Hashtable extraassemblies;
 		private Hashtable keys;
 
 		public RuntimeLicenseContext () : base ()
@@ -58,17 +59,17 @@
 
 			Assembly asm = Assembly.GetEntryAssembly ();
 			if (asm != null)
-				LoadAssemblyLicenses (asm);
+				LoadAssemblyLicenses (keys, asm);
 			else {
 				foreach (Assembly asmnode in AppDomain.CurrentDomain.GetAssemblies ()) {
-					if (String.Compare (asmnode.GetName().Name, "App_Licenses", true) == 0)
-						LoadAssemblyLicenses (asmnode);
+						LoadAssemblyLicenses (keys, asmnode);
 				}
 			}
 		}
 
-		void LoadAssemblyLicenses (Assembly asm)
+		void LoadAssemblyLicenses (Hashtable targetkeys, Assembly asm)
 		{
+            if (asm is System.Reflection.Emit.AssemblyBuilder) return; 
 			string asmname = Path.GetFileName (asm.Location);
 			string resourcename = asmname + ".licenses";
 			try {
@@ -81,7 +82,7 @@
 						if (String.Compare ((string) res[0], asmname, true) == 0) {
 							Hashtable table = (Hashtable) res[1];
 							foreach (DictionaryEntry et in table)
-							keys.Add(et.Key, et.Value);
+                                targetkeys.Add (et.Key, et.Value);
 						}
 					}
 				}
@@ -94,6 +95,18 @@
 		{
 			if (type == null)
 				throw new ArgumentNullException ("type");
+            if (resourceAssembly != null)
+            {
+                if (extraassemblies == null) extraassemblies = new Hashtable ();
+                Hashtable ht = extraassemblies [resourceAssembly.FullName] as Hashtable;
+                if (ht == null)
+                {
+                    ht = new Hashtable ();
+                    LoadAssemblyLicenses (ht, resourceAssembly);
+                    extraassemblies [resourceAssembly.FullName] = ht;
+                }
+                return (string) ht [type.AssemblyQualifiedName];
+            }
 			LoadKeys ();
 			return (string) keys [type.AssemblyQualifiedName];
 		}