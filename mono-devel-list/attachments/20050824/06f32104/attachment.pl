Index: mcs/cs-parser.jay
===================================================================
--- mcs/cs-parser.jay	(revision 48738)
+++ mcs/cs-parser.jay	(working copy)
@@ -3843,6 +3843,7 @@
 		$$ = new If ((Expression) $3, (Statement) $5, l);
 
 		if (RootContext.WarningLevel >= 4){
+			// FIXME: location for warning should be loc property of $5.
 			if ($5 == EmptyStatement.Value)
 				Report.Warning (642, l, "Possible mistaken empty statement");
 		}
@@ -3854,6 +3855,14 @@
 		Location l = (Location) $1;
 
 		$$ = new If ((Expression) $3, (Statement) $5, (Statement) $7, l);
+
+		if (RootContext.WarningLevel >= 4){
+			// FIXME: location for warning should be loc property of $5 and $7.
+			if ($5 == EmptyStatement.Value)
+				Report.Warning (642, l, "Possible mistaken empty statement");
+			if ($7 == EmptyStatement.Value)
+				Report.Warning (642, l, "Possible mistaken empty statement");
+		}
 	  }
 	;
 
Index: errors/cs0642-7.cs
===================================================================
--- errors/cs0642-7.cs	(revision 0)
+++ errors/cs0642-7.cs	(revision 0)
@@ -0,0 +1,15 @@
+// cs0642-7.cs : Possible mistaken empty statement
+// Line: 11
+// Compiler options: /warnaserror /warn:4
+using System;
+public class C
+{
+	public static int p = 0;
+	public static void Foo ()
+	{
+		if (p < 5)
+			;
+		Console.WriteLine ();
+	}
+}
+

Property changes on: errors/cs0642-7.cs
___________________________________________________________________
Name: svn:eol-style
   + native

Index: errors/known-issues-mcs
===================================================================
--- errors/known-issues-mcs	(revision 48761)
+++ errors/known-issues-mcs	(working copy)
@@ -28,7 +28,6 @@
 cs0560.cs
 cs0567.cs
 cs0619-31.cs NO ERROR
-cs0642.cs NO ERROR
 cs0642-2.cs NO ERROR
 cs0642-3.cs
 cs0642-4.cs
Index: errors/cs0642-8.cs
===================================================================
--- errors/cs0642-8.cs	(revision 0)
+++ errors/cs0642-8.cs	(revision 0)
@@ -0,0 +1,17 @@
+// cs0642-7.cs : Possible mistaken empty statement
+// Line: 13
+// Compiler options: /warnaserror /warn:4
+using System;
+public class C
+{
+	public static int p = 0;
+	public static void Foo ()
+	{
+		if (p < 5)
+			Console.WriteLine ();
+		else
+			;
+		Console.WriteLine ();
+	}
+}
+

Property changes on: errors/cs0642-8.cs
___________________________________________________________________
Name: svn:eol-style
   + native
