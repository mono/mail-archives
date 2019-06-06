Index: mkbundle.cs
===================================================================
--- mkbundle.cs	(revision 54899)
+++ mkbundle.cs	(working copy)
@@ -9,6 +9,7 @@
 // (C) Novell, Inc 2004
 //
 using System;
+using System.Diagnostics;
 using System.Xml;
 using System.Collections;
 using System.Reflection;
@@ -35,6 +36,8 @@
 		ArrayList sources = new ArrayList ();
 		int top = args.Length;
 		link_paths.Add (".");
+
+		DetectOS ();
 		
 		for (int i = 0; i < top; i++){
 			switch (args [i]){
@@ -82,6 +85,10 @@
 				keeptemp = true;
 				break;
 			case "--static":
+				if (style == "windows") {
+					Console.Error.WriteLine ("The option `{0}' is not supported on this platform.", args [i]);
+					return 1;
+				}
 				static_link = true;
 				Console.WriteLine ("Note that statically linking the LGPL Mono runtime has more licensing restrictions than dynamically linking.");
 				Console.WriteLine ("See http://www.mono-project.com/Licensing for details on licensing.");
@@ -103,6 +110,10 @@
 				config_dir = args [++i];
 				break;
 			case "-z":
+				if (style == "windows") {
+					Console.Error.WriteLine ("The option `{0}' is not supported on this platform.", args [i]);
+					return 1;
+				}
 				compress = true;
 				break;
 			default:
@@ -111,8 +122,6 @@
 			}
 		}
 
-		DetectOS ();
-
 		Console.WriteLine ("Sources: {0} Auto-dependencies: {1}", sources.Count, autodeps);
 		if (sources.Count == 0 || output == null) {
 			Help ();
@@ -153,6 +162,14 @@
 				"_{0}:\n",
 				name, size);
 			break;
+		case "windows":
+			sw.WriteLine (
+				".globl _{0}\n" +
+				"\t.section .rdata,\"dr\"\n" +
+				"\t.align 32\n" +
+				"_{0}:\n",
+				name, size);
+			break;
 		}
 	}
 	
@@ -160,7 +177,7 @@
 	{
 		string temp_s = "temp.s"; // Path.GetTempFileName ();
 		string temp_c = "temp.c";
-		string temp_o = Path.GetTempFileName () + ".o";
+		string temp_o = "temp.o";
 
 		if (compile_only)
 			temp_c = output;
@@ -187,8 +204,8 @@
 			}
 
 			foreach (string url in files){
-				string fname = url.Substring (7);
-				string aname = fname.Substring (fname.LastIndexOf ("/") + 1);
+				string fname = new Uri (url).LocalPath;
+				string aname = Path.GetFileName (fname);
 				string encoded = aname.Replace ("-", "_").Replace (".", "_");
 
 				if (prog == null)
@@ -279,9 +296,8 @@
 			ts.Close ();
 			
 			Console.WriteLine ("Compiling:");
-			string cmd = String.Format ("as -o {0} {1} ", temp_o, temp_s);
-			Console.WriteLine (cmd);
-			int ret = system (cmd);
+			string cmd = String.Format ("{0} -o {1} {2} ", GetEnv ("AS", "as"), temp_o, temp_s);
+			int ret = Execute (cmd);
 			if (ret != 0){
 				Error ("[Fail]");
 				return;
@@ -328,6 +344,7 @@
 
 			string zlib = (compress ? "-lz" : "");
 			string debugging = "-g";
+			string cc = GetEnv ("CC", IsUnix ? "cc" : "gcc -mno-cygwin");
 
 			if (style == "linux")
 				debugging = "-ggdb";
@@ -337,18 +354,17 @@
 					smonolib = "`pkg-config --variable=libdir mono`/libmono.a ";
 				else
 					smonolib = "-Wl,-Bstatic -lmono -Wl,-Bdynamic ";
-				cmd = String.Format ("cc -o {2} -Wall `pkg-config --cflags mono` {0} {3}" +
+				cmd = String.Format ("{4} -o {2} -Wall `pkg-config --cflags mono` {0} {3} " +
 						     "`pkg-config --libs-only-L mono` " + smonolib +
 						     "`pkg-config --libs-only-l mono | sed -e \"s/\\-lmono //\"` {1}",
-						     temp_c, temp_o, output, zlib);
+						     temp_c, temp_o, output, zlib, cc);
 			} else {
 				
-				cmd = String.Format ("cc " + debugging + " -o {2} -Wall {0} `pkg-config --cflags --libs mono` {3} {1}",
-						     temp_c, temp_o, output, zlib);
+				cmd = String.Format ("{4} " + debugging + " -o {2} -Wall {0} `pkg-config --cflags --libs mono` {3} {1}",
+						     temp_c, temp_o, output, zlib, cc);
 			}
                             
-			Console.WriteLine (cmd);
-			ret = system (cmd);
+			ret = Execute (cmd);
 			if (ret != 0){
 				Error ("[Fail]");
 				return;
@@ -395,7 +411,7 @@
 			return;
 
 		files.Add (codebase);
-		Assembly a = Assembly.LoadFrom (codebase);
+		Assembly a = Assembly.LoadFrom (new Uri(codebase).LocalPath);
 
 		if (!autodeps)
 			return;
@@ -470,7 +486,7 @@
 				   "    --config F      Bundle system config file `F'\n" +
 				   "    --config-dir D  Set MONO_CFG_DIR to `D'\n" +
 				   "    --static        Statically link to mono libs\n" +
-				   "    -z		Compress the assemblies before embedding.\n");
+				   "    -z              Compress the assemblies before embedding.\n");
 	}
 
 	[DllImport ("libc")]
@@ -480,6 +496,12 @@
 		
 	static void DetectOS ()
 	{
+		if (!IsUnix) {
+			Console.WriteLine ("OS is: Windows");
+			style = "windows";
+			return;
+		}
+
 		IntPtr buf = UnixMarshal.AllocHeap(8192);
 		if (uname (buf) != 0){
 			Console.WriteLine ("Warning: Unable to detect OS");
@@ -492,6 +514,29 @@
 		
 		UnixMarshal.FreeHeap(buf);
 	}
-	
+
+	static bool IsUnix {
+		get {
+			int p = (int) Environment.OSVersion.Platform;
+			return ((p == 4) || (p == 128));
+		}
+	}
+
+	static int Execute (string cmdLine)
+	{
+		Console.WriteLine (cmdLine);
+		if (IsUnix) {
+			return system (cmdLine);
+		} else {
+			Process p = Process.Start ("sh", String.Format ("-c \"{0}\"", cmdLine));
+			p.WaitForExit ();
+			return p.ExitCode;
+		}
+	}
+
+	static string GetEnv (string name, string defaultValue) 
+	{
+		string s = Environment.GetEnvironmentVariable (name);
+		return s != null ? s : defaultValue;
+	}
 }
-
Index: template_z.c
===================================================================
--- template_z.c	(revision 54899)
+++ template_z.c	(working copy)
@@ -55,7 +55,7 @@
 	newargs [++i] = NULL;
 
 	if (config_dir != NULL && getenv ("MONO_CFG_DIR") == NULL)
-		setenv ("MONO_CFG_DIR", config_dir, 1);
+		mono_set_dirs (getenv ("MONO_PATH"), config_dir);
 
 	install_dll_config_files ();
 
Index: ChangeLog
===================================================================
--- ChangeLog	(revision 54899)
+++ ChangeLog	(working copy)
@@ -1,3 +1,7 @@
+2005-12-29  Robert Jordan  <robertj@gmx.net>
+
+	* mkbundle.cs, template.c, template_z.c: Added support for Windows.
+
 2005-12-18 Alexandre Rocha Lima e Marcondes
 <alexandre@psl-pr.softwarelivre.org>
 
Index: template.c
===================================================================
--- template.c	(revision 54899)
+++ template.c	(working copy)
@@ -14,7 +14,7 @@
 	newargs [++i] = NULL;
 
 	if (config_dir != NULL && getenv ("MONO_CFG_DIR") == NULL)
-		setenv ("MONO_CFG_DIR", config_dir, 1);
+		mono_set_dirs (getenv ("MONO_PATH"), config_dir);
 	
 	install_dll_config_files ();
 	mono_register_bundled_assemblies(bundled);
