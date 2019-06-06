Index: mono-api-info.cs
===================================================================
--- mono-api-info.cs	(revision 52122)
+++ mono-api-info.cs	(working copy)
@@ -699,6 +699,28 @@
 			MethodBase method = (MethodBase) member;
 			string name = method.Name;
 			string parms = Parameters.GetSignature (method.GetParameters ());
+			MethodInfo mi = method as MethodInfo;
+#if NET_2_0
+			Type [] genArgs = mi == null ? Type.EmptyTypes :
+				mi.GetGenericArguments ();
+			if (genArgs.Length > 0) {
+				string [] genArgNames = new string [genArgs.Length];
+				for (int i = 0; i < genArgs.Length; i++) {
+					genArgNames [i] = genArgs [i].Name;
+					Type [] gcs = genArgs [i].GetGenericParameterConstraints ();
+					if (gcs.Length > 0) {
+						string [] gcNames = new string [gcs.Length];
+						for (int g = 0; g < gcs.Length; g++)
+							gcNames [g] = gcs [g].FullName;
+						genArgNames [i] += String.Concat (
+							"(",
+							string.Join(", ", gcNames),
+							")");
+					}
+				}
+				return String.Format ("{0}[{2}]({1})", name, parms, string.Join (",", genArgNames));
+			}
+#endif
 			return String.Format ("{0}({1})", name, parms);
 		}
 