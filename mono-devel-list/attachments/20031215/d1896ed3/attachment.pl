? jay-error-control.patch
Index: skeleton.cs
===================================================================
RCS file: /cvs/public/mcs/jay/skeleton.cs,v
retrieving revision 1.9
diff -u -r1.9 skeleton.cs
--- skeleton.cs	8 Oct 2003 17:54:20 -0000	1.9
+++ skeleton.cs	15 Dec 2003 07:13:01 -0000
@@ -11,6 +11,11 @@
  prolog		## %{ ... %} prior to the first %%
 
 .
+.  /** error output stream.
+.      It should be changeable.
+.    */
+.  public System.IO.TextWriter ErrorOutput = System.Console.Out;
+.
 .  /** simplified error message.
 .      @see <a href="#yyerror(java.lang.String, java.lang.String[])">yyerror</a>
 .    */
@@ -25,12 +30,12 @@
 .    */
 .  public void yyerror (string message, string[] expected) {
 .    if ((expected != null) && (expected.Length  > 0)) {
-.      System.Console.Write (message+", expecting");
+.      ErrorOutput.Write (message+", expecting");
 .      for (int n = 0; n < expected.Length; ++ n)
-.        System.Console.Write (" "+expected[n]);
-.        System.Console.WriteLine ();
+.        ErrorOutput.Write (" "+expected[n]);
+.        ErrorOutput.WriteLine ();
 .    } else
-.      System.Console.WriteLine (message);
+.      ErrorOutput.WriteLine (message);
 .  }
 .
 .  /** debugging support, requires the package jay.yydebug.
@@ -261,7 +266,7 @@
 .	 
 .	 class yyDebugSimple : yyDebug {
 .		 void println (string s){
-.			 Console.WriteLine (s);
+.			 Console.Error.WriteLine (s);
 .		 }
 .		 
 .		 public void push (int state, Object value) {
