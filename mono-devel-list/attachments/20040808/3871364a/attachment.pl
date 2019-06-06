Index: ChangeLog
===================================================================
RCS file: /cvs/public/mcs/class/System/System.CodeDom.Compiler/ChangeLog,v
retrieving revision 1.31
diff -u -r1.31 ChangeLog
--- ChangeLog	16 Jul 2004 10:03:56 -0000	1.31
+++ ChangeLog	7 Aug 2004 18:26:02 -0000
@@ -1,3 +1,8 @@
+2004-08-07  Atsushi Enomoto  <atsushi@ximian.com>
+
+	* CodeGenerator.cs :
+	  Don't initialize output more than once. TextWriter is wrapped twice.
+
 2004-07-15  Peter Williams  <peter@newton.cx>
 
 	* CodeGenerator.cs: Have the basic generator create line pragmas
Index: CodeGenerator.cs
===================================================================
RCS file: /cvs/public/mcs/class/System/System.CodeDom.Compiler/CodeGenerator.cs,v
retrieving revision 1.22
diff -u -r1.22 CodeGenerator.cs
--- CodeGenerator.cs	16 Jul 2004 10:03:56 -0000	1.22
+++ CodeGenerator.cs	7 Aug 2004 18:26:02 -0000
@@ -1008,8 +1008,6 @@
 			CodeTypeDeclaration prevType = this.currentType;
 			this.currentType = type;
 
-			InitOutput (output, options);
-
 			foreach (CodeCommentStatement statement in type.Comments)
 				GenerateCommentStatement (statement);
 
@@ -1025,8 +1023,6 @@
 		{
 			CodeTypeDeclaration prevType = this.currentType;
 			this.currentType = type;
-
-			InitOutput (output, options);
 
 			foreach (CodeCommentStatement statement in type.Comments)
 				GenerateCommentStatement (statement);