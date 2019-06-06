Index: mono-api-diff.cs
===================================================================
--- mono-api-diff.cs	(revision 55970)
+++ mono-api-diff.cs	(working copy)
@@ -1280,9 +1280,6 @@
 				}
 			}
 
-			if (!CheckAttributes)
-				return;
-
 			XMLMember member = (XMLMember) other;
 			string acc = access [name] as string;
 			if (acc == null)
@@ -1305,12 +1302,6 @@
 		{
 			return null;
 		}
-
-		protected virtual bool CheckAttributes {
-			get {
-				return true;
-			}
-		}
 	}
 	
 	class XMLFields : XMLMember
@@ -1369,14 +1360,6 @@
 			return fa.ToString ();
 		}
 
-		protected override bool CheckAttributes {
-			get {
-				// FIXME: set this to true once bugs #60086 and 
-				// #60090 are fixed
-				return false;
-			}
-		}
-
 		public override string GroupName {
 			get { return "fields"; }
 		}
@@ -1715,6 +1698,10 @@
 		protected override string ConvertToString (int att)
 		{
 			MethodAttributes ma = (MethodAttributes) att;
+			// ignore ReservedMasks
+			ma &= ~ MethodAttributes.ReservedMask;
+			ma &= ~ MethodAttributes.VtableLayoutMask;
+
 			// ignore the HasSecurity attribute for now
 			if ((ma & MethodAttributes.HasSecurity) != 0)
 				ma = (MethodAttributes) (att - (int) MethodAttributes.HasSecurity);
@@ -1730,14 +1717,6 @@
 			return ma.ToString ();
 		}
 
-		protected override  bool CheckAttributes {
-			get {
-				// FIXME: set this to true once bugs #60086 and 
-				// #60090 are fixed
-				return false;
-			}
-		}
-
 		public override string GroupName {
 			get { return "methods"; }
 		}
Index: mono-api-info.cs
===================================================================
--- mono-api-info.cs	(revision 55970)
+++ mono-api-info.cs	(working copy)
@@ -633,7 +633,7 @@
 			AddAttribute (p, "params", parms);
 
 			MethodData data = new MethodData (document, p, methods);
-			data.NoMemberAttributes = true;
+			//data.NoMemberAttributes = true;
 			data.DoOutput ();
 		}
 