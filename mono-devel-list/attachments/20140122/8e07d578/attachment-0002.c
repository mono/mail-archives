--- mono/dis/util.c.orig	2014-01-17 16:46:38.554823364 -0600
+++ mono/dis/util.c	2014-01-17 16:47:01.774755631 -0600
@@ -130,24 +130,7 @@
 int
 dis_isinf (double num)
 {
-#ifdef HAVE_ISINF
 	return isinf (num);
-#elif defined(HAVE_IEEEFP_H)
-	fpclass_t klass;
-
-	klass = fpclass (num);
-	if (klass == FP_NINF)
-		return -1;
-
-	if (klass == FP_PINF)
-		return 1;
-
-	return 0;
-#elif defined(HAVE__FINITE)
-	return _finite (num) ? 0 : 1;
-#else
-#error "Don't know how to implement isinf for this platform."
-#endif
 }
 
 int
