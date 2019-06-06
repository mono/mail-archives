Index: class.cs
===================================================================
--- class.cs	(revision 107417)
+++ class.cs	(working copy)
@@ -3821,14 +3821,6 @@
 			if (!DoDefineBase ())
 				return false;
 
-#if GMCS_SOURCE
-			if (GenericMethod != null) {
-				MethodBuilder = Parent.TypeBuilder.DefineMethod (GetFullName (MemberName), flags);
-				if (!GenericMethod.Define (MethodBuilder, block))
-					return false;
-			}
-#endif
-
 			return true;
 		}
 
@@ -5169,33 +5161,36 @@
 		/// </summary>
 		void DefineMethodBuilder (TypeContainer container, string method_name, Type[] ParameterTypes)
 		{
-			if (builder == null) {
-				builder = container.TypeBuilder.DefineMethod (
-					method_name, flags, method.CallingConventions,
-					method.ReturnType, ParameterTypes);
-				return;
-			}
-
+            if (builder == null)
+            {
+                builder = container.TypeBuilder.DefineMethod(
+                    method_name, flags, method.CallingConventions,
+                    method.ReturnType, ParameterTypes);
 #if GMCS_SOURCE
-			//
-			// Generic method has been already defined to resolve method parameters
-			// correctly when they use type parameters
-			//
-			builder.SetParameters (ParameterTypes);
-			builder.SetReturnType (method.ReturnType);
+                if (GenericMethod != null)
+                {
+                    //MethodBuilder = Parent.TypeBuilder.DefineMethod(GetFullName(MemberName), flags);
+                    GenericMethod.Define(MethodBuilder, null);
+                }
 
-			if (builder.Attributes != flags) {
-				try {
-					if (methodbuilder_attrs_field == null)
-						methodbuilder_attrs_field = typeof (MethodBuilder).GetField ("attrs", BindingFlags.NonPublic | BindingFlags.Instance);
-					methodbuilder_attrs_field.SetValue (builder, flags);
-				} catch {
-					Report.RuntimeMissingSupport (method.Location, "Generic method MethodAttributes");
-				}
-			}
-#else
-			throw new InternalErrorException ();
+                if (builder.Attributes != flags)
+                {
+                    try
+                    {
+                        if (methodbuilder_attrs_field == null)
+                            methodbuilder_attrs_field = typeof(MethodBuilder).GetField("attrs", BindingFlags.NonPublic | BindingFlags.Instance);
+                        methodbuilder_attrs_field.SetValue(builder, flags);
+                    }
+                    catch
+                    {
+                        Report.RuntimeMissingSupport(method.Location, "Generic method MethodAttributes");
+                    }
+                }
 #endif
+
+                return;
+            }
+
 		}
 
 		//