--- driverold.cs	2006-03-14 16:40:24.000000000 +0530
+++ ./mono/mono-1.1.13.4/mcs/mcs/driver.cs	2006-03-14 16:36:47.000000000 
+0530
@@ -89,7 +89,13 @@
		// Output file
		//
		static string output_file = null;
-
+
+		//
+		// Bugreport file
+		//
+		static string bugreport_file = null;
+		public static string bugerr_msg = null;
+
		//
		// Last time we took the time
		//
@@ -113,6 +119,7 @@
			win32ResourceFile = win32IconFile = null;
			defines = null;
			output_file = null;
+			bugreport_file = null;
			encoding = null;
			first_source = null;
		}
@@ -227,6 +234,7 @@
				"mcs [options] source-files\n" +
				"   --about            About the Mono C# compiler\n" +
				"   -addmodule:MODULE  Adds the module to the generated assembly\n" +
+				"   -bugreport:	       Creates a 'Bug Report' file\n" +
				"   -checked[+|-]      Set default context to checked\n" +
				"   -codepage:ID       Sets code page to the one in ID (number, utf8, 
reset)\n" +
				"   -clscheck[+|-]     Disables CLS Compliance verifications" + 
Environment.NewLine +
@@ -287,8 +295,12 @@
		{
			Location.InEmacs = Environment.GetEnvironmentVariable ("EMACS") == "t";

+
			bool ok = MainDriver (args);
-
+			//Sri
+			if(bugreport_file != null)
+				CreateBugReportFile(args);
+
			if (ok && Report.Errors == 0) {
				if (Report.Warnings > 0) {
					Console.WriteLine ("Compilation succeeded - {0} warning(s)", 
Report.Warnings);
@@ -565,6 +577,7 @@
				return;
			}
			foreach (string f in files) {
+				Console.WriteLine("Files:  {0}", f);
				ProcessFile (f);
			}

@@ -634,6 +647,15 @@
				return Path.GetFileName (output_file);
			}
		}
+		public static string BugreportFile
+		{
+			set {
+				bugreport_file = value;
+			}
+		/*	get {
+				//return Path.GetFilename (bugreport_file);
+			}*/
+		}

		static void SetWarningLevel (string s)
		{
@@ -1025,8 +1047,13 @@
				//
				// We should collect data, runtime, etc and store in the file specified
				//
-				Console.WriteLine ("To file bug reports, please visit: 
http://www.mono-project.com/Bugs");
+				if (value == ""){
+					Usage ();
+					Environment.Exit (1);
+				}
+				BugreportFile = value;
				return true;
+			//	Console.WriteLine ("To file bug reports, please visit: 
http://www.mono-project.com/Bugs");

			case "/pkg": {
				string packages;
@@ -1426,7 +1453,66 @@

			return true;
		}
+		//Sri
+
+		static void CreateBugReportFile(string[] args)
+		{
+			try
+			{
+				TextReader tr = null;
+				string version = Assembly.GetExecutingAssembly ().GetName 
().Version.ToString ();
+				TextWriter tw = new StreamWriter (bugreport_file);
+				tw.WriteLine ("### Mono C# compiler version {0} " + "Defect Report 
Created on {1} " , version, DateTime.Now);
+				tw.WriteLine ("### Operating System " + Environment.OSVersion);
+				tw.WriteLine ("### Compiler Commandline: ");
+				tw.Write(Assembly.GetExecutingAssembly().GetName().Name.ToString());
+				foreach (string arg in args) {
+					tw.Write(" ");
+					tw.Write(arg);
+				}
+				tw.WriteLine(" ");
+
+				tw.WriteLine(" ");
+
+				foreach (SourceFile file in Location.SourceFiles)
+				{
+					tw.WriteLine("### Source File:  {0}", file.Path);
+					tr = new StreamReader(file.Path);
+					tw.WriteLine(tr.ReadToEnd());
+					tr.Close();
+				}

+
+
+				tw.WriteLine(" ");
+				tw.WriteLine("### Compiler Output:");
+				tw.WriteLine(" ");
+				tw.WriteLine(bugerr_msg);
+				tw.WriteLine(" ");
+
+				Console.WriteLine("A file is being created with information needed to 
reproduce your compiler problem. This information includes: software 
versions, the pathnames and contents of source code files, referenced 
assemblies, and modules, compiler options, compiler output, and any 
additional information you provide in the following prompts.");
+				Console.WriteLine();
+				Console.WriteLine("Please describe the compiler problem (press Enter 
twice to finish):");
+				tw.WriteLine("### User Description:");
+				tw.WriteLine(Console.ReadLine()); //This should read the problem 
descripption from the command line
+				Console.ReadLine();
+
+				tw.WriteLine ("### User sugested correct behavior:");
+				Console.WriteLine("what you think should have happened (press Enter 
twice to finish):");
+				tw.WriteLine(Console.ReadLine()); //This should read the user sugested 
correct behavior
+				Console.ReadLine();
+
+
+				tw.Close();
+
+			}
+			catch (Exception ex)
+			{
+				Console.WriteLine(ex.Message);
+
+			}
+
+		}
		/// <summary>
		///    Parses the arguments, and drives the compilation
		///    process.
@@ -1824,12 +1910,16 @@
				return false;
			}

+
+
#if DEBUGME
			Console.WriteLine ("Size of strings held: " + DeclSpace.length);
			Console.WriteLine ("Size of strings short: " + DeclSpace.small);
#endif
			return (Report.Errors == 0);
		}
+
+
	}

	class Resources

