Index: mono-api-diff.cs
===================================================================
--- mono-api-diff.cs	(revision 52436)
+++ mono-api-diff.cs	(working copy)
@@ -1607,7 +1607,7 @@
 		{
 			None = 0,
 			Abstract = 1,
-			Virtual = 2,
+			Overridable = 2,
 			Static = 4
 		}
 
@@ -1626,8 +1626,8 @@
 				flags |= SignatureFlags.Abstract;
 			if (((XmlElement) node).GetAttribute ("static") == "true")
 				flags |= SignatureFlags.Static;
-			if (((XmlElement) node).GetAttribute ("virtual") == "true")
-				flags |= SignatureFlags.Virtual;
+			if (((XmlElement) node).GetAttribute ("overridable") == "true")
+				flags |= SignatureFlags.Overridable;
 			if (flags != SignatureFlags.None) {
 				if (signatureFlags == null)
 					signatureFlags = new Hashtable ();
Index: mono-api-info.cs
===================================================================
--- mono-api-info.cs	(revision 52436)
+++ mono-api-info.cs	(working copy)
@@ -759,8 +759,8 @@
 
 			if (mbase.IsAbstract)
 				AddAttribute (p, "abstract", "true");
-			if (mbase.IsVirtual)
-				AddAttribute (p, "virtual", "true");
+			if (mbase.IsVirtual && !mbase.IsFinal)
+				AddAttribute (p, "overridable", "true");
 			if (mbase.IsStatic)
 				AddAttribute (p, "static", "true");
 