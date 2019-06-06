Index: System.Net/IPAddress.cs
===================================================================
--- System.Net/IPAddress.cs	(revision 39533)
+++ System.Net/IPAddress.cs	(working copy)
@@ -250,7 +250,7 @@
 		{
 			get {
 				if(_family != AddressFamily.InterNetwork)
-					throw new Exception("The attempted operation is not supported for the type of object referenced");
+					throw new SystemException("The attempted operation is not supported for the type of object referenced");
 
 				return address;
 			}
@@ -262,7 +262,7 @@
 				*/
 
 				if(_family != AddressFamily.InterNetwork)
-					throw new Exception("The attempted operation is not supported for the type of object referenced");
+					throw new SystemException("The attempted operation is not supported for the type of object referenced");
 
 				address = value;
 			}
@@ -276,13 +276,13 @@
 		public long ScopeId {
 			get {
 				if(_family != AddressFamily.InterNetworkV6)
-					throw new Exception("The attempted operation is not supported for the type of object referenced");
+					throw new SystemException("The attempted operation is not supported for the type of object referenced");
 
 				return _scopeId;
 			}
 			set {
 				if(_family != AddressFamily.InterNetworkV6)
-					throw new Exception("The attempted operation is not supported for the type of object referenced");
+					throw new SystemException("The attempted operation is not supported for the type of object referenced");
 
 				_scopeId = value;
 			}
Index: System.Net/WebConnection.cs
===================================================================
--- System.Net/WebConnection.cs	(revision 39533)
+++ System.Net/WebConnection.cs	(working copy)
@@ -217,11 +217,11 @@
 
 					int spaceidx = str.IndexOf (' ');
 					if (spaceidx == -1)
-						throw new Exception ();
+						throw new SystemException ();
 
 					int resultCode = Int32.Parse (str.Substring (spaceidx + 1, 3));
 					if (resultCode != 200)
-						throw new Exception ();
+						throw new SystemException ();
 
 					gotStatus = true;
 				}
@@ -275,7 +275,7 @@
 
 			if (e == null) { // At least we now where it comes from
 				try {
-					throw new Exception (new System.Diagnostics.StackTrace ().ToString ());
+					throw new SystemException (new System.Diagnostics.StackTrace ().ToString ());
 				} catch (Exception e2) {
 					e = e2;
 				}
Index: System/Uri.cs
===================================================================
--- System/Uri.cs	(revision 39533)
+++ System/Uri.cs	(working copy)
@@ -1100,7 +1100,7 @@
 					if (result.Count == 0) {
 						if (i == 1) // see bug 52599
 							continue;
-						throw new Exception ("Invalid path.");
+						throw new SystemException ("Invalid path.");
 					}
 
 					result.RemoveAt (result.Count - 1);