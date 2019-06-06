diff -Naur mcsBeta2/driver.cs mcs/driver.cs
--- mcsBeta2/driver.cs	2004-05-14 14:32:19.000000000 +0000
+++ mcs/driver.cs	2004-06-11 06:25:38.033011200 +0000
@@ -65,6 +65,7 @@
 		static bool pause = false;
 		static bool show_counters = false;
 		public static bool parser_verbose = false;
+		static bool quiet = false;
 		
 		//
 		// Whether to load the initial config file (what CSC.RSP has by default)
@@ -231,6 +232,7 @@
 				"   -out:FNAME         Specifies output file\n" +
 				"   -pkg:P1[,Pn]       References packages P1..Pn\n" + 
 				"   --expect-error X   Expect that error X will be encountered\n" +
+				"   -quiet             Enables quiet mode\n" +
 				"   -recurse:SPEC      Recursively compiles the files in SPEC ([dir]/file)\n" + 
 				"   -reference:ASS     References the specified assembly (-r:ASS)\n" +
 				"   -target:KIND       Specifies the target (KIND is one of: exe, winexe,\n" +
@@ -274,7 +276,8 @@
 			bool ok = MainDriver (args);
 			
 			if (ok && Report.Errors == 0) {
-				Console.Write("Compilation succeeded");
+				if (!quiet)
+					Console.Write("Compilation succeeded");
 				if (Report.Warnings > 0) {
 					Console.Write(" - {0} warning(s)", Report.Warnings);
 				}
@@ -898,6 +901,10 @@
 			case "--noconfig":
 				load_default_config = false;
 				return true;
+
+			case "--quiet":
+				quiet = true;
+				return true;
 			}
 
 			return false;
@@ -1208,6 +1215,10 @@
 				load_default_config = false;
 				return true;
 
+			case "/quiet":
+				quiet = true;
+				return true;
+
 			case "/help2":
 				OtherFlags ();
 				Environment.Exit(0);
