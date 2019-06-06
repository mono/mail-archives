Index: mini-x86.c
===================================================================
RCS file: /cvs/public/mono/mono/mini/mini-x86.c,v
retrieving revision 1.61
diff -u -r1.61 mini-x86.c
--- mini-x86.c	14 Feb 2004 15:44:41 -0000	1.61
+++ mini-x86.c	15 Feb 2004 06:25:55 -0000
@@ -114,9 +114,11 @@
 static void indent (int diff) {
 	if (diff < 0)
 		indent_level += diff;
-	int v = indent_level;
-	while (v-- > 0) {
-		printf (". ");
+	{
+		int v = indent_level;
+		while (v-- > 0) {
+			printf (". ");
+		}
 	}
 	if (diff > 0)
 		indent_level += diff;
