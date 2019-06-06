Index: eglib/test/driver.c
===================================================================
--- eglib/test/driver.c	(revision 121616)
+++ eglib/test/driver.c	(working copy)
@@ -238,7 +238,7 @@
 		string_array_free(tests_to_run);
 	}
 
-	return 0;
+	return global_tests - global_passed;
 }
 
 