Index: TextWriter.cs
===================================================================
--- TextWriter.cs	(revision 37164)
+++ TextWriter.cs	(working copy)
@@ -38,15 +38,17 @@
 	public abstract class TextWriter : MarshalByRefObject, IDisposable {
                 
                 protected TextWriter() {
-			CoreNewLine = System.Environment.NewLine.ToCharArray ();
+			NewLine = System.Environment.NewLine;
 		}
                 
                 protected TextWriter( IFormatProvider formatProvider ) {
-			CoreNewLine = System.Environment.NewLine.ToCharArray ();
+			NewLine = System.Environment.NewLine;
                         internalFormatProvider = formatProvider;
                 }
 
                 protected char[] CoreNewLine;
+		private string newLine;
+		private char [] coreNewLineCache;
 
                 internal IFormatProvider internalFormatProvider;
 
@@ -62,14 +64,20 @@
 
                 public virtual string NewLine { 
                         get {
-                                return new string(CoreNewLine);
+				if (coreNewLineCache != CoreNewLine) {
+					coreNewLineCache = CoreNewLine;
+					newLine = new string (CoreNewLine);
+				}
+                                return newLine;
                         }
                         
                         set {
 				if (value == null)
 					value = Environment.NewLine;
 
-				CoreNewLine = value.ToCharArray();
+				newLine = value;
+				coreNewLineCache = CoreNewLine =
+					value.ToCharArray ();
                         }
                 }
 