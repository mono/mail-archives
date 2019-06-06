Index: TextWriter.cs
===================================================================
--- TextWriter.cs	(revision 37086)
+++ TextWriter.cs	(working copy)
@@ -38,7 +38,8 @@
 	public abstract class TextWriter : MarshalByRefObject, IDisposable {
                 
                 protected TextWriter() {
-			CoreNewLine = System.Environment.NewLine.ToCharArray ();
+			newLine = System.Environment.NewLine;
+			CoreNewLine = newLine.ToCharArray ();
 		}
                 
                 protected TextWriter( IFormatProvider formatProvider ) {
@@ -46,6 +47,7 @@
                 }
 
                 protected char[] CoreNewLine;
+		private string newLine;
 
                 internal IFormatProvider internalFormatProvider;
 
@@ -61,13 +63,14 @@
 
                 public virtual string NewLine { 
                         get {
-                                return new string(CoreNewLine);
+                                return newLine;
                         }
                         
                         set {
 				if (value == null)
 					value = Environment.NewLine;
 
+				newLine = value;
 				CoreNewLine = value.ToCharArray();
                         }
                 }
Index: ChangeLog
===================================================================
--- ChangeLog	(revision 37086)
+++ ChangeLog	(working copy)
@@ -1,3 +1,7 @@
+2004-12-06  Atsushi Enomoto  <atsushi@ximian.com>
+
+	* TextWriter.cs : don't create string for every call to NewLine.
+
 2004-11-19  Dick Porter  <dick@ximian.com>
 
 	* MonoIOError.cs: 