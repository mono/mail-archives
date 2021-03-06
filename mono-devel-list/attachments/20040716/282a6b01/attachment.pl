diff -U 3 -r orig/Constants.cs ./Constants.cs
--- orig/Constants.cs	2004-07-16 22:49:03.750000000 -0230
+++ ./Constants.cs	2004-07-16 22:49:59.359375000 -0230
@@ -38,10 +38,10 @@
 	sealed public class Constants {
 		// Declarations
 		public const System.Int32 vbObjectError = (System.Int32)(-2147221504);
-		public const System.String vbCrLf = "\n\r";
-		public const System.String vbNewLine = "\n\r";
-		public const System.String vbCr = "\n";
-		public const System.String vbLf = "\r";
+		public const System.String vbCrLf = "\r\n";
+		public const System.String vbNewLine = "\r\n";
+		public const System.String vbCr = "\r";
+		public const System.String vbLf = "\n";
 		public const System.String vbBack = "\b";
 		public const System.String vbFormFeed = "\f";
 		public const System.String vbTab = "\t";
diff -U 3 -r orig/ControlChars.cs ./ControlChars.cs
--- orig/ControlChars.cs	2004-07-16 22:49:03.750000000 -0230
+++ ./ControlChars.cs	2004-07-16 22:50:37.281250000 -0230
@@ -33,10 +33,10 @@
 namespace Microsoft.VisualBasic {
 	sealed public class ControlChars {
 		// Declarations
-		public const System.String CrLf = "\n\r";
-		public const System.String NewLine = "\n\r";
-		public const System.Char Cr = '\n';
-		public const System.Char Lf = '\r';
+		public const System.String CrLf = "\r\n";
+		public const System.String NewLine = "\r\n";
+		public const System.Char Cr = '\r';
+		public const System.Char Lf = '\n';
 		public const System.Char Back = '\b';
 		public const System.Char FormFeed = '\f';
 		public const System.Char Tab = '\t';
