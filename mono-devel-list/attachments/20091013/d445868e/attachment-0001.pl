Index: Changelog
===================================================================
--- Changelog	(revision 144003)
+++ Changelog	(working copy)
@@ -1,3 +1,8 @@
+2009-10-12  Carlo Kok  <ck@remobjects.com>
+
+	* DesigntimeLicenseContextSerializer.cs: Properly serialize licenses.
+	* RuntimeLicenseContext.cs: Properly deserialize licenses.
+
 2008-06-18  Ivan N. Zlatev  <contact@i-nz.net>
 
 	* ServiceContainer.cs: Lazy initialize the services hashtable so that 
Index: DesigntimeLicenseContextSerializer.cs
===================================================================
--- DesigntimeLicenseContextSerializer.cs	(revision 144003)
+++ DesigntimeLicenseContextSerializer.cs	(working copy)
@@ -4,9 +4,11 @@
 // Authors:
 //   Martin Willemoes Hansen (mwh@sysrq.dk)
 //   Andreas Nahr (ClassDevelopment@A-SoftTech.com)
+//   Carlo Kok  (ck@remobjects.com)
 //
 // (C) 2003 Martin Willemoes Hansen
 // (C) 2003 Andreas Nahr
+// (C) 2009 Carlo Kok
 //
 
 //
@@ -31,6 +33,8 @@
 //
 
 using System.IO;
+using System.Runtime.Serialization.Formatters.Binary;
+using System.Collections;
 
 namespace System.ComponentModel.Design
 {
@@ -41,12 +45,23 @@
 		{
 		}
 
-		[MonoTODO]
 		public static void Serialize (Stream o,
 					      string cryptoKey,
 					      DesigntimeLicenseContext context)
 		{
-			throw new NotImplementedException();
+            Object[] lData = new Object [2];
+            lData [0] = cryptoKey;
+            Hashtable lNewTable = new Hashtable();
+            foreach (DictionaryEntry et in context.keys)
+            {
+                lNewTable.Add(((Type)et.Key).AssemblyQualifiedName, et.Value);
+            }
+            lData[1] = lNewTable;
+
+            BinaryFormatter lFormatter = new BinaryFormatter ();
+            lFormatter.Serialize (o, lData);
+
 		}
+	
 	}
 }
Index: RuntimeLicenseContext.cs
===================================================================
--- RuntimeLicenseContext.cs	(revision 144003)
+++ RuntimeLicenseContext.cs	(working copy)
@@ -5,10 +5,12 @@
 //   Ivan Hamilton (ivan@chimerical.com.au)
 //   Martin Willemoes Hansen (mwh@sysrq.dk)
 //   Andreas Nahr (ClassDevelopment@A-SoftTech.com)
+//   Carlo Kok  (ck@remobjects.com)
 //
 // (C) 2004 Ivan Hamilton
 // (C) 2003 Martin Willemoes Hansen
 // (C) 2003 Andreas Nahr
+// (C) 2009 Carlo Kok
 //
 
 //
@@ -35,26 +37,77 @@
 using System.ComponentModel;
 using System.Reflection;
 using System.Collections;
+using System.IO;
+using System.Runtime.Serialization.Formatters.Binary;
 
 namespace System.ComponentModel.Design
 {
 	internal class RuntimeLicenseContext : LicenseContext
 	{
-		private Hashtable keys = new Hashtable ();
+		private Hashtable keys;
 
-		public RuntimeLicenseContext () : base()
+		public RuntimeLicenseContext () : base ()
 		{
 		}
 
+        private void loadKeys ()
+        {
+            if (keys != null) return;
+            keys = new Hashtable ();
+
+            Assembly asm = Assembly.GetEntryAssembly ();
+            if (asm != null)
+                loadAssemblyLicenses (asm);
+            else {
+                foreach (Assembly asmnode in AppDomain.CurrentDomain.GetAssemblies ()) {
+                    if (String.Compare (asmnode.GetName().Name, "App_Licenses", true) == 0)
+                        loadAssemblyLicenses (asmnode);
+                }
+            }
+        }
+
+        private void loadAssemblyLicenses (Assembly asm)
+        {
+            string asmname = Path.GetFileName (asm.Location);
+            string resourcename = asmname + ".licenses";
+            try
+            {
+                foreach (string name in asm.GetManifestResourceNames ())
+                {
+                    if (name == resourcename) {
+                        using (Stream stream = asm.GetManifestResourceStream (name))
+                        {
+                            BinaryFormatter formatter = new BinaryFormatter ();
+                            object[] res = formatter.Deserialize (stream) as object[];
+                            if (String.Compare ((string) res[0], asmname, true) == 0)
+                            {
+                                Hashtable table = (Hashtable) res[1];
+                                foreach (DictionaryEntry et in table)
+                                    keys.Add(et.Key, et.Value);
+                            }
+                        }
+                    }
+                }
+
+            }
+            catch (InvalidCastException)
+            {
+            }
+        }
+
 		public override string GetSavedLicenseKey (Type type,
 							   Assembly resourceAssembly)
 		{
-			return (string) keys [type];
+            if (type == null) throw new ArgumentNullException ("type");
+            loadKeys ();
+			return (string) keys [type.AssemblyQualifiedName];
 		}
 
 		public override void SetSavedLicenseKey (Type type, string key)
 		{
-			keys [type] = key;
+            if (type == null) throw new ArgumentNullException ("type");
+            loadKeys ();
+            keys[type.AssemblyQualifiedName] = key;
 		}
 	}
 }