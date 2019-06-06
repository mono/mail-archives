Index: Test/System.Windows.Forms/ApplicationTest.cs
===================================================================
--- Test/System.Windows.Forms/ApplicationTest.cs	(Revision 69666)
+++ Test/System.Windows.Forms/ApplicationTest.cs	(Arbeitskopie)
@@ -39,5 +39,12 @@
 
 			Assert.IsNull (ctx.MainForm, "2");
 		}
+
+		[Test]
+		[ExpectedException (typeof (NotSupportedException))]
+		public void RestartNotSupportedExceptionTest ()
+		{
+			Application.Restart ();
+		}
 	}
 }
Index: System.Windows.Forms/Application.cs
===================================================================
--- System.Windows.Forms/Application.cs	(Revision 69666)
+++ System.Windows.Forms/Application.cs	(Arbeitskopie)
@@ -21,6 +21,7 @@
 //
 // Authors:
 //	Peter Bartok	pbartok@novell.com
+//      Daniel Nauck    (dna(at)mono-project(dot)de)
 //
 
 // COMPLETE
@@ -39,6 +40,7 @@
 using System.Runtime.InteropServices;
 using System.Threading;
 #if NET_2_0
+using System.Text;
 using System.Windows.Forms.VisualStyles;
 #endif
 
@@ -374,6 +376,70 @@
 				return forms;
 			}
 		}
+
+		public static void Restart ()
+		{
+			//FIXME: ClickOnce stuff using the Update or UpdateAsync methods.
+			//FIXME: SecurityPermission: Restart () requires IsUnrestricted permission.
+
+			if (Assembly.GetEntryAssembly () == null)
+				throw new NotSupportedException ("The method 'Restart' is not supported by this application type.");
+
+			string mono_path = null;
+
+			//Get mono path
+			PropertyInfo gac = typeof (Environment).GetProperty ("GacPath", BindingFlags.Static | BindingFlags.NonPublic);
+			MethodInfo get_gac = null;
+			if (gac != null)
+				get_gac = gac.GetGetMethod (true);
+
+			if (get_gac != null) {
+				string gac_path = Path.GetDirectoryName ((string)get_gac.Invoke (null, null));
+				string mono_prefix = Path.GetDirectoryName (Path.GetDirectoryName (gac_path));
+
+				if (Environment.OSVersion.Platform == PlatformID.Unix) {
+					mono_path = Path.Combine (mono_prefix, "bin/mono");
+					if (!File.Exists (mono_path))
+						mono_path = "mono";
+				}
+				else {
+					mono_path = Path.Combine (mono_prefix, "bin\\mono.bat");
+
+					if (!File.Exists (mono_path))
+						mono_path = Path.Combine (mono_prefix, "bin\\mono.exe");
+
+					if (!File.Exists (mono_path))
+						mono_path = Path.Combine (mono_prefix, "mono\\mono\\mini\\mono.exe");
+
+					if (!File.Exists (mono_path))
+						throw new FileNotFoundException (string.Format ("Windows mono path not found: '{0}'", mono_path));
+				}
+			}
+
+			//Get command line arguments
+			StringBuilder argsBuilder = new StringBuilder ();
+			string[] args = Environment.GetCommandLineArgs ();
+			for (int i = 0; i < args.Length; i++)
+			{
+				argsBuilder.Append (string.Format ("\"{0}\" ", args[i]));
+			}
+			string arguments = argsBuilder.ToString ();
+			ProcessStartInfo procInfo = Process.GetCurrentProcess ().StartInfo;
+
+			if (mono_path == null) { //it is .NET on Windows
+				procInfo.FileName = args[0];
+				procInfo.Arguments = arguments.Remove (0, args[0].Length + 3); //1 space and 2 quotes
+			}
+			else {
+				procInfo.Arguments = arguments;
+				procInfo.FileName = mono_path;
+			}
+
+			procInfo.WorkingDirectory = Environment.CurrentDirectory;
+
+			Application.Exit ();
+			Process.Start (procInfo);
+		}
 #endif
 
 		public static void Exit() {
