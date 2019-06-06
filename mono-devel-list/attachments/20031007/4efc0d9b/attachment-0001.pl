Index: output.c
===================================================================
RCS file: /cvs/public/mcs/jay/output.c,v
retrieving revision 1.2
diff -u -r1.2 output.c
--- output.c	9 Feb 2003 16:37:28 -0000	1.2
+++ output.c	7 Oct 2003 02:14:15 -0000
@@ -911,9 +911,9 @@
 	if (symbol_value[i] > max)
 	    max = symbol_value[i];
 
-	/* need yyName for yyExpecting() */
+	/* need yyNames for yyExpecting() */
 
-      printf("  protected static %s string [] yyName = {", csharp ? "" : "final");
+      printf("  protected static %s string [] yyNames = {", csharp ? "" : "final");
       symnam = (char **) MALLOC((max+1)*sizeof(char *));
       if (symnam == 0) no_space();
   
Index: skeleton
===================================================================
RCS file: /cvs/public/mcs/jay/skeleton,v
retrieving revision 1.1
diff -u -r1.1 skeleton
--- skeleton	14 Jul 2001 23:30:40 -0000	1.1
+++ skeleton	7 Oct 2003 02:14:15 -0000
@@ -71,14 +71,14 @@
 .
  debug			## tables for debugging support
 .
-.  /** index-checked interface to yyName[].
+.  /** index-checked interface to yyNames[].
 .      @param token single character or %token value.
 .      @return token name or [illegal] or [unknown].
 .    */
 t  public static final String yyname (int token) {
-t    if (token < 0 || token > yyName.length) return "[illegal]";
+t    if (token < 0 || token > yyNames.length) return "[illegal]";
 t    String name;
-t    if ((name = yyName[token]) != null) return name;
+t    if ((name = yyNames[token]) != null) return name;
 t    return "[unknown]";
 t  }
 .
@@ -88,26 +88,26 @@
 .    */
 .  protected String[] yyExpecting (int state) {
 .    int token, n, len = 0;
-.    boolean[] ok = new boolean[yyName.length];
+.    boolean[] ok = new boolean[yyNames.length];
 .
 .    if ((n = yySindex[state]) != 0)
 .      for (token = n < 0 ? -n : 0;
-.           token < yyName.length && n+token < yyTable.length; ++ token)
-.        if (yyCheck[n+token] == token && !ok[token] && yyName[token] != null) {
+.           token < yyNames.length && n+token < yyTable.length; ++ token)
+.        if (yyCheck[n+token] == token && !ok[token] && yyNames[token] != null) {
 .          ++ len;
 .          ok[token] = true;
 .        }
 .    if ((n = yyRindex[state]) != 0)
 .      for (token = n < 0 ? -n : 0;
-.           token < yyName.length && n+token < yyTable.length; ++ token)
-.        if (yyCheck[n+token] == token && !ok[token] && yyName[token] != null) {
+.           token < yyNames.length && n+token < yyTable.length; ++ token)
+.        if (yyCheck[n+token] == token && !ok[token] && yyNames[token] != null) {
 .          ++ len;
 .          ok[token] = true;
 .        }
 .
 .    String result[] = new String[len];
 .    for (n = token = 0; n < len;  ++ token)
-.      if (ok[token]) result[n++] = yyName[token];
+.      if (ok[token]) result[n++] = yyNames[token];
 .    return result;
 .  }
 .
Index: skeleton.cs
===================================================================
RCS file: /cvs/public/mcs/jay/skeleton.cs,v
retrieving revision 1.8
diff -u -r1.8 skeleton.cs
--- skeleton.cs	14 Jan 2003 06:35:26 -0000	1.8
+++ skeleton.cs	7 Oct 2003 02:14:15 -0000
@@ -40,14 +40,14 @@
 .
  debug			## tables for debugging support
 .
-.  /** index-checked interface to yyName[].
+.  /** index-checked interface to yyNames[].
 .      @param token single character or %token value.
 .      @return token name or [illegal] or [unknown].
 .    */
 t  public static string yyname (int token) {
-t    if ((token < 0) || (token > yyName.Length)) return "[illegal]";
+t    if ((token < 0) || (token > yyNames.Length)) return "[illegal]";
 t    string name;
-t    if ((name = yyName[token]) != null) return name;
+t    if ((name = yyNames[token]) != null) return name;
 t    return "[unknown]";
 t  }
 .
@@ -57,26 +57,26 @@
 .    */
 .  protected string[] yyExpecting (int state) {
 .    int token, n, len = 0;
-.    bool[] ok = new bool[yyName.Length];
+.    bool[] ok = new bool[yyNames.Length];
 .
 .    if ((n = yySindex[state]) != 0)
 .      for (token = n < 0 ? -n : 0;
-.           (token < yyName.Length) && (n+token < yyTable.Length); ++ token)
-.        if (yyCheck[n+token] == token && !ok[token] && yyName[token] != null) {
+.           (token < yyNames.Length) && (n+token < yyTable.Length); ++ token)
+.        if (yyCheck[n+token] == token && !ok[token] && yyNames[token] != null) {
 .          ++ len;
 .          ok[token] = true;
 .        }
 .    if ((n = yyRindex[state]) != 0)
 .      for (token = n < 0 ? -n : 0;
-.           (token < yyName.Length) && (n+token < yyTable.Length); ++ token)
-.        if (yyCheck[n+token] == token && !ok[token] && yyName[token] != null) {
+.           (token < yyNames.Length) && (n+token < yyTable.Length); ++ token)
+.        if (yyCheck[n+token] == token && !ok[token] && yyNames[token] != null) {
 .          ++ len;
 .          ok[token] = true;
 .        }
 .
 .    string [] result = new string[len];
 .    for (n = token = 0; n < len;  ++ token)
-.      if (ok[token]) result[n++] = yyName[token];
+.      if (ok[token]) result[n++] = yyNames[token];
 .    return result;
 .  }
 .