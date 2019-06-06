--- Al.cs.old	2005-03-02 00:04:04.000000000 +0530
+++ Al.cs	2005-06-29 17:34:48.000000000 +0530
@@ -14,6 +14,7 @@
using System.Reflection;
using System.Reflection.Emit;
using System.Text;
+using System.Configuration.Assemblies;

namespace Mono.AssemblyLinker
{
@@ -30,6 +31,7 @@
		public bool isPrivate;
	}

+
	enum Target {
		Dll,
		Exe,
@@ -47,6 +49,8 @@
		string entryPoint;
		string win32IconFile;
		string win32ResFile;
+		string templateFile;
+		bool isTemplateFile = false;
		Target target;

		public static int Main (String[] args) {
@@ -61,7 +65,22 @@
			return 0;
		}

-		private void ParseArgs (string[] args) {
+		static bool IsStrongNamed (Assembly assembly)
+		{
+			object[] attrs = assembly.GetCustomAttributes (true);
+			foreach (object o in attrs)
+			{
+				if (o is AssemblyKeyFileAttribute)
+					return true;
+				else if (o is AssemblyKeyNameAttribute)
+					return true;
+			}
+			return false;
+		}
+
+
+		private void ParseArgs (string[] args)
+		{

			ArrayList flat_args = new ArrayList ();

@@ -329,9 +348,10 @@
					break;

				case "template":
-					if (arg == null)
-						ReportMissingFileSpec (opt);
-					ReportNotImplemented (opt);
+                        		if (arg == null)
+                            			ReportMissingFileSpec (opt);
+					isTemplateFile = true;
+					templateFile = arg;
					break;

				case "title":
@@ -386,6 +406,8 @@

			if (target == Target.Exe && (entryPoint == null))
				Report (1036, "Entry point required for executable applications");
+
+
		}

		private string GetCommand (string str, out string command_arg) {
@@ -470,6 +492,8 @@
			Report (1010, String.Format ("Missing ':<text>' for '{0}' option", 
option));
		}

+
+
		private void DoIt () {
			AssemblyName aname = new AssemblyName ();
			aname.Name = Path.GetFileNameWithoutExtension (outFile);
@@ -477,6 +501,28 @@
			string fileName = Path.GetFileName (outFile);

			AssemblyBuilder ab;
+
+			/*
+			 * Emit Manifest
+			 * */
+
+			if(isTemplateFile) {
+
+				byte[] pk;
+				AssemblyName myAssm = new AssemblyName();
+				myAssm.Name = Path.GetFileNameWithoutExtension (templateFile);
+				Assembly assembly = Assembly.Load(myAssm);
+
+				if (!IsStrongNamed(assembly)){
+					Report (1055, String.Format ("Assembly specified does not have Strong 
Name '{0}'","template"));
+                      }
+				pk = assembly.GetName().GetPublicKey();
+
+				aname.SetPublicKey(pk);
+				aname.HashAlgorithm = assembly.GetName().HashAlgorithm;
+				aname.Version = assembly.GetName().Version;
+				aname.HashAlgorithm = assembly.GetName().HashAlgorithm;
+			}

			if (fileName != outFile)
				ab = AppDomain.CurrentDomain.DefineDynamicAssembly (aname, 
AssemblyBuilderAccess.Save, Path.GetDirectoryName (outFile));
@@ -591,6 +637,7 @@
				}
			}

+
			try {
				ab.Save (fileName);
			}

