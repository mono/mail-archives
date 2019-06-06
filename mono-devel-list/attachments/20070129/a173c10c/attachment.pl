Index: System.Net/HttpWebRequest.cs
===================================================================
--- System.Net/HttpWebRequest.cs	(revision 71778)
+++ System.Net/HttpWebRequest.cs	(working copy)
@@ -372,7 +372,23 @@
 				if (value == null || value.Trim () == "")
 					throw new ArgumentException ("not a valid method");
 
-				method = value;
+				// LAMESPEC: This class is not really case
+				// sensitive for those methods here, which
+				// would violate RFC 2616 (5.1.1).
+				string upper = value.ToUpperInvariant ();
+				switch (value.ToUpperInvariant ()) {
+				case "GET":
+				case "POST":
+				case "PUT":
+				case "HEAD":
+				case "CONNECT":
+				case "MKCOL":
+					method = upper; // case sensitive
+					break;
+				default:
+					method = value; // case insensitive
+					break;
+				}
 			}
 		}
 		