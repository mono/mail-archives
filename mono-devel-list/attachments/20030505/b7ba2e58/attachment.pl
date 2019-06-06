Index: Uri.cs
===================================================================
RCS file: /mono/mcs/class/System/System/Uri.cs,v
retrieving revision 1.17
diff -u -r1.17 Uri.cs
--- Uri.cs	20 Mar 2003 03:43:58 -0000	1.17
+++ Uri.cs	5 May 2003 07:57:09 -0000
@@ -725,8 +725,11 @@
 					
 				scheme = uriString.Substring (0, pos).ToLower ();
 				uriString = uriString.Remove (0, pos + 1);
-			} else 
-				scheme = "file";			
+			} else if ((c == '/') && (pos == 0)) {
+				// unix bare filepath
+				scheme = "file";
+				uriString = @"//" + uriString;				
+			}
 						
 			// 3
 			if ((uriString.Length >= 2) && 
