Index: System.Reflection/AssemblyName.cs
===================================================================
--- System.Reflection/AssemblyName.cs	(revision 64207)
+++ System.Reflection/AssemblyName.cs	(working copy)
@@ -169,16 +169,13 @@
 					else
 						fname.Append (cultureinfo.Name);
 				}
-				byte[] pub_tok = GetPublicKeyToken ();
-				if (pub_tok != null) {
-					if (pub_tok.Length == 0)
-						fname.Append (", PublicKeyToken=null");
-					else {
-						fname.Append (", PublicKeyToken=");
-						for (int i = 0; i < pub_tok.Length; i++)
-							fname.Append (pub_tok[i].ToString ("x2"));
-					}
-				}
+				byte [] pub_tok = GetPublicKeyToken ();
+				fname.Append (", PublicKeyToken=");
+				if (pub_tok == null || pub_tok.Length == 0)
+					fname.Append ("null");
+				else
+					for (int i = 0; i < pub_tok.Length; i++)
+						fname.Append (pub_tok [i].ToString ("x2"));
 				return fname.ToString ();
 			}
 		}
