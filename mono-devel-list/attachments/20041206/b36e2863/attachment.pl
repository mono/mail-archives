Index: TextWriter.cs
===================================================================
--- TextWriter.cs	(revision 37164)
+++ TextWriter.cs	(working copy)
@@ -38,15 +38,19 @@
 	public abstract class TextWriter : MarshalByRefObject, IDisposable {
                 
                 protected TextWriter() {
-			CoreNewLine = System.Environment.NewLine.ToCharArray ();
+			newLine = System.Environment.NewLine;
+			CoreNewLine = coreNewLineCache = newLine.ToCharArray ();
 		}
                 
                 protected TextWriter( IFormatProvider formatProvider ) {
-			CoreNewLine = System.Environment.NewLine.ToCharArray ();
+			newLine = System.Environment.NewLine;
+			CoreNewLine = coreNewLineCache = newLine.ToCharArray ();
                         internalFormatProvider = formatProvider;
                 }
 
-                protected char[] CoreNewLine;
+                protected char[] CoreNewLine = Environment.NewLine.ToCharArray ();
+		private string newLine;
+		private char [] coreNewLineCache;
 
                 internal IFormatProvider internalFormatProvider;
 
@@ -62,14 +66,20 @@
 
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
+				CoreNewLine = coreNewLineCache =
+					value.ToCharArray ();
                         }
                 }
 