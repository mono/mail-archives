Index: output.c
===================================================================
--- output.c	(revision 41902)
+++ output.c	(working copy)
@@ -57,6 +57,7 @@
 static int lowzero;
 static int high;
 extern int csharp;
+extern char* cmdline_def;
 
 output () {
   int lno = 0;
@@ -66,6 +67,9 @@
   free_shifts();
   free_reductions();
 
+  if (cmdline_def)
+	output_cmdline_def();
+
   while (fgets(buf, sizeof buf, stdin) != NULL) {
     char * cp;
     ++ lno;
@@ -98,6 +102,11 @@
   free_parser();
 }
 
+output_cmdline_def()
+{
+	printf ("#define %s\n", cmdline_def);
+}
+
 output_rule_data()
 {
     register int i;
Index: main.c
===================================================================
--- main.c	(revision 41902)
+++ main.c	(working copy)
@@ -50,6 +50,7 @@
 char tflag;
 char vflag;
 int csharp = 0;
+char *cmdline_def;
 
 char *file_prefix = "y";
 char *myname = "yacc";
@@ -135,7 +136,7 @@
 
 usage()
 {
-    fprintf(stderr, "usage: %s [-tvcp] [-b file_prefix] filename\n", myname);
+    fprintf(stderr, "usage: %s [-tvcp] [-b file_prefix] [-d condition] filename\n", myname);
     exit(1);
 }
 
@@ -178,6 +179,15 @@
 		usage();
 	    continue;
 
+	case 'd':
+	    if (*++s)
+		cmdline_def = s;
+	    else if (++i < argc)
+		cmdline_def = argv[i];
+	    else
+		usage();
+	    continue;
+
         case 't':
             tflag = 1;
             break;