Index: C:/CVSROOT/mcs/class/corlib/System/String.cs
===================================================================
--- C:/CVSROOT/mcs/class/corlib/System/String.cs	(revision 57019)
+++ C:/CVSROOT/mcs/class/corlib/System/String.cs	(working copy)
@@ -72,28 +72,42 @@
 			if (len != b.length)
 				return false;
 
-			if (len == 0)
-				return true;
+			fixed (char* s1 = &a.start_char, s2 = &b.start_char) {
+				char* s1_ptr = s1;
+				char* s2_ptr = s2;
 
-			fixed (char * s1 = &a.start_char, s2 = &b.start_char) {
-				// it must be one char, because 0 len is done above
-				if (len < 2)
-					return *s1 == *s2;
+				while (len >= 8) {
+					if (((int*)s1_ptr)[0] != ((int*)s2_ptr)[0] ||
+						((int*)s1_ptr)[1] != ((int*)s2_ptr)[1] ||
+						((int*)s1_ptr)[2] != ((int*)s2_ptr)[2] ||
+						((int*)s1_ptr)[3] != ((int*)s2_ptr)[3])
+						return false;
 
-				// check by twos
-				int * sint1 = (int *) s1, sint2 = (int *) s2;
-				int n2 = len >> 1;
-				do {
-					if (*sint1++ != *sint2++)
+					s1_ptr += 8;
+					s2_ptr += 8;
+					len -= 8;
+				}
+
+				if (len >= 4) {
+					if (((int*)s1_ptr)[0] != ((int*)s2_ptr)[0] ||
+						((int*)s1_ptr)[1] != ((int*)s2_ptr)[1])
 						return false;
-				} while (--n2 != 0);
 
-				// nothing left
-				if ((len & 1) == 0)
-					return true;
+					s1_ptr += 4;
+					s2_ptr += 4;
+					len -= 4;
+				}
 
-				// check the last one
-				return *(char *) sint1 == *(char *) sint2;
+				if (len > 1) {
+					if (((int*)s1_ptr)[0] != ((int*)s2_ptr)[0])
+						return false;
+
+					s1_ptr += 2;
+					s2_ptr += 2;
+					len -= 2;
+				}
+
+				return len == 0 || *s1_ptr == *s2_ptr;
 			}
 		}
 