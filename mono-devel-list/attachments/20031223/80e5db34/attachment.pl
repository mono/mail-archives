? profiler-fix.patch
Index: profiler.c
===================================================================
RCS file: /cvs/public/mono/mono/metadata/profiler.c,v
retrieving revision 1.17
diff -u -r1.17 profiler.c
--- profiler.c	11 Sep 2003 12:44:38 -0000	1.17
+++ profiler.c	22 Dec 2003 16:09:59 -0000
@@ -654,8 +654,12 @@
 		if (!(gint)(p->total*1000))
 			continue;
 		m = method_get_name (p->method);
-		printf ("########################\n% 8.3f %7llu % 8.3f  %s\n",
-			(double)(p->total*1000), p->count, (double)(p->total*1000)/(double)p->count, m);
+		printf ("########################\n");
+		printf ("% 8.3f ", (double) (p->total * 1000));
+		printf ("%7llu ", p->count);
+		printf ("% 8.3f ", (double) (p->total * 1000)/(double)p->count);
+		printf ("  %s\n", m);
+
 		g_free (m);
 		/* callers */
 		output_callers (p);
