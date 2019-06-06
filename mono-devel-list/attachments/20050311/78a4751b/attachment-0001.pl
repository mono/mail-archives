Index: mcs/class.cs
===================================================================
--- mcs/class.cs	(revision 41656)
+++ mcs/class.cs	(working copy)
@@ -2118,7 +2118,15 @@
 
 			try {
 				caching_flags |= Flags.CloseTypeCreated;
-				TypeBuilder.CreateType ();
+#if NET_2_0
+				if (!TypeBuilder.IsCreated ())
+					TypeBuilder.CreateType ();
+#else
+				try {
+					TypeBuilder.CreateType ();
+				} catch (InvalidOperationException) {
+				}
+#endif
 			} catch (TypeLoadException){
 				//
 				// This is fine, the code still created the type
Index: class/corlib/System.Reflection.Emit/TypeBuilder.cs
===================================================================
--- class/corlib/System.Reflection.Emit/TypeBuilder.cs	(revision 41656)
+++ class/corlib/System.Reflection.Emit/TypeBuilder.cs	(working copy)
@@ -623,7 +623,20 @@
 			return false;
 		}
 		
-		public Type CreateType() {
+		public Type CreateType ()
+		{
+			if (created != null)
+#if NET_2_0
+				return created;
+#else
+				throw new InvalidOperationException ("Unable to change after type has been created.");
+#endif
+
+			return CreateTypeInternal ();
+		}
+
+		private Type CreateTypeInternal ()
+		{
 			/* handle nesting_type */
 			if (created != null)
 				return created;
@@ -1258,7 +1271,7 @@
 			TypeBuilder datablobtype = DefineNestedType (s,
 				TypeAttributes.NestedPrivate|TypeAttributes.ExplicitLayout|TypeAttributes.Sealed,
 				pmodule.assemblyb.corlib_value_type, null, PackingSize.Size1, size);
-			datablobtype.CreateType ();
+			datablobtype.CreateTypeInternal ();
 			return DefineField (name, datablobtype, attributes|FieldAttributes.Static|FieldAttributes.HasFieldRVA);
 		}
 