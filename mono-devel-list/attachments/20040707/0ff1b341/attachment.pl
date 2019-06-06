? test-74.diff
Index: test-74.cs
===================================================================
RCS file: /cvs/public/mcs/tests/test-74.cs,v
retrieving revision 1.4
diff -u -r1.4 test-74.cs
--- test-74.cs	26 May 2004 11:07:30 -0000	1.4
+++ test-74.cs	6 Jul 2004 17:46:36 -0000
@@ -18,7 +18,7 @@
 		if (e != f)
 			return 2;
 
-		string g = "Hello" + System.Environment.NewLine + "world";
+		string g = "Hello\nworld";
 		string h = @"Hello
 world";
 		if (g != h) 