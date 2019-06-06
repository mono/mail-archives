--- monoresgen.cs
+++ monoresgen.cs
@@ -42,13 +42,19 @@
 	}
 
 	static void Usage () {
-		Console.WriteLine ("Mono Resource Generator version 0.1");
-		Console.WriteLine ("Usage:");
-		Console.WriteLine ("\tmonoresgen source.ext [dest.ext]");
-		Console.WriteLine ();
-		Console.WriteLine ("Convert a resource file from one format to another.");
-		Console.WriteLine ("The currently supported formats are: '.txt' '.resources' '.resx'.");
-		Console.WriteLine ("If the destination file is not specified, source.resources will be used.");
+		string Usage = @"Mono Resource Generator version 0.1
+Usage:
+		monoresgen source.ext [dest.ext]
+		monoresgen /compile source.ext[,dest.resources] [...]
+
+Convert a resource file from one format to another.
+The currently supported formats are: '.txt' '.resources' '.resx'.
+If the destination file is not specified, source.resources will be used.
+The /compile option takes a list of .resX or .txt files to convert to
+.resources files in one bulk operation, replacing .ext with .resources for
+the output file name.
+";
+		Console.WriteLine( Usage );
 	}
 	
 	static IResourceReader GetReader (Stream stream, string name) {
@@ -83,46 +89,81 @@
 		}
 	}
 	
-	static int Main (string[] args) {
+	static int CompileResourceFile(string sname, string dname ) {
+		try {
 		FileStream source, dest;
-		string sname, dname;
 		IResourceReader reader;
 		IResourceWriter writer;
 
-		if (args.Length == 1) {
-			sname = args [0];
-			dname = Path.ChangeExtension (sname, "resources");
-		} else if (args.Length != 2) {
-			Usage ();
-			return 1;
-		} else {
-			sname = args [0];
-			dname = args [1];
-		}
-
-		try {
 			source = new FileStream (sname, FileMode.Open, FileAccess.Read);
 			dest = new FileStream (dname, FileMode.OpenOrCreate, FileAccess.Write);
 
 			reader = GetReader (source, sname);
 			writer = GetWriter (dest, dname);
 
+			int rescount = 0;
 			foreach (DictionaryEntry e in reader) {
+				rescount++;
 				object val = e.Value;
 				if (val is string)
 					writer.AddResource ((string)e.Key, (string)e.Value);
 				else
 					writer.AddResource ((string)e.Key, e.Value);
 			}
+			Console.WriteLine( "Read in {0} resources from '{1}'", rescount, sname );
 
 			reader.Close ();
 			writer.Close ();
+			Console.WriteLine("Writing resource file...  Done.");
 		} catch (Exception e) {
 			Console.WriteLine ("Error: {0}", e.Message);
 			return 1;
 		}
 		return 0;
 	}
+	
+	static int Main (string[] args) {
+		string sname = "", dname = ""; 
+		if ((int) args.Length < 1 || args[0] == "-h" || args[0] == "-?" || args[0] == "/h" || args[0] == "/?") {
+			  Usage();
+			  return 1;
+		}		
+		if (args[0] == "/compile" || args[0] == "-compile") {
+			for ( int i=1; i< args.Length; i++ ) {				
+				if ( args[i].IndexOf(",") != -1 ){
+					string[] pair =  args[i].Split(',');
+					sname = pair[0]; 
+					dname = pair[1];
+					if (dname == ""){
+						Console.WriteLine(@"error: You must specify an input & outfile file name like this:");
+						Console.WriteLine("inFile.txt,outFile.resources." );
+						Console.WriteLine("You passed in '{0}'.", args[i] );
+						return 1;
+					}
+				} else {
+					sname = args[i]; 
+					dname = Path.ChangeExtension (sname, "resources");
+				}
+				int ret = CompileResourceFile( sname, dname );
+				if (ret != 0 ) {
+					return ret;
+				}
+			}
+			return 0;
+		
+		}
+		else if (args.Length == 1) {
+			sname = args [0];
+			dname = Path.ChangeExtension (sname, "resources");
+		} else if (args.Length != 2) {
+			Usage ();
+			return 1;
+		} else {
+			sname = args [0];
+			dname = args [1];			
+		}		
+		return CompileResourceFile( sname, dname );
+	}
 }
 
 class TxtResourceWriter : IResourceWriter {

