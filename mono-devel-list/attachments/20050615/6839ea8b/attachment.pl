Index: System.Xml/ChangeLog
===================================================================
--- System.Xml/ChangeLog	(revision 45937)
+++ System.Xml/ChangeLog	(working copy)
@@ -1,3 +1,7 @@
+2005-06-15  Andrew Skiba  <andrews@mainsoft.com>
+
+	* DTDReader.cs : fix to pass valid-sa-086 test
+
 2005-06-14  Atsushi Enomoto <atsushi@ximian.com>
 
 	* DTDValidatingReader.cs : further text node fixes.
Index: System.Xml/DTDReader.cs
===================================================================
--- System.Xml/DTDReader.cs	(revision 45937)
+++ System.Xml/DTDReader.cs	(working copy)
@@ -838,7 +838,8 @@
 			else {
 				// literal entity
 				ReadEntityValueDecl (decl);
-				ResolveInternalEntityReplacementText (decl);
+				if (DTD.EntityDecls [decl.Name] == null)
+					ResolveInternalEntityReplacementText (decl);
 			}
 			SkipWhitespace ();
 			// This expanding is only allowed as a non-validating parser.
