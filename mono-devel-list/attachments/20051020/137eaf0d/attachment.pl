Index: generic.cs
===================================================================
--- generic.cs	(revision 51926)
+++ generic.cs	(working copy)
@@ -1395,7 +1395,22 @@
 			if (TypeManager.IsBuiltinType (atype) || atype.IsValueType)
 				return true;
 
+			if (HasDefaultConstructor (ec, atype))
+				return true;
+
+			Report.Error (310, loc, "The type `{0}' must have a public " +
+				      "parameterless constructor in order to use it " +
+				      "as parameter `{1}' in the generic type or " +
+				      "method `{2}'", atype, ptype, DeclarationName);
+			return false;
+		}
+
+		bool HasDefaultConstructor (EmitContext ec, Type atype)
+		{
 			if (atype is TypeBuilder) {
+				if (atype.IsAbstract)
+					return false;
+
 				TypeContainer tc = TypeManager.LookupTypeContainer (atype);
 				foreach (Constructor c in tc.InstanceConstructors) {
 					if ((c.ModFlags & Modifiers.PUBLIC) == 0)
@@ -1425,10 +1440,6 @@
 				}
 			}
 
-			Report.Error (310, loc, "The type `{0}' must have a public " +
-				      "parameterless constructor in order to use it " +
-				      "as parameter `{1}' in the generic type or " +
-				      "method `{2}'", atype, ptype, DeclarationName);
 			return false;
 		}
 
Index: ChangeLog
===================================================================
--- ChangeLog	(revision 51926)
+++ ChangeLog	(working copy)
@@ -1,3 +1,10 @@
+2005-10-19  Atsushi Enomoto  <atsushi@ximian.com>
+
+	* generic.cs : (ConstructedType.CheckConstraints) warn CS0310 when
+	  1) "new()" is specified as generic parameter constraint and 2) the
+	  type is TypeBuilder and 3) the type is abstract even if it has a
+	  default .ctor(). Now errors/gcs0310-3.cs is correctly rejected.
+
 2005-10-19  Martin Baulig  <martin@ximian.com>
 
 	* class.cs (TypeContainer.DefineType): Only use ResolveAsTypeStep(),