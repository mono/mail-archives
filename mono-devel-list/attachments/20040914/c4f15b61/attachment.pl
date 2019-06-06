Index: class/corlib/System/ChangeLog
===================================================================
RCS file: /cvs/public/mcs/class/corlib/System/ChangeLog,v
retrieving revision 1.933
diff -u -r1.933 ChangeLog
--- class/corlib/System/ChangeLog	13 Sep 2004 03:50:23 -0000	1.933
+++ class/corlib/System/ChangeLog	14 Sep 2004 09:57:32 -0000
@@ -1,3 +1,8 @@
+2004-09-14  Marek Safar  <marek.safar@seznam.cz>
+
+	* MonoCustomAttrs.cs: Implemented NET_2_0 extension.
+        Attributes are returned also for pseudo attributes.
+
 2004-09-13 Gonzalo Paniagua Javier <gonzalo@ximian.com>
 
 	* AppDomain.cs: added SetupInformationNoCopy property, since
Index: class/corlib/System/MonoCustomAttrs.cs
===================================================================
RCS file: /cvs/public/mcs/class/corlib/System/MonoCustomAttrs.cs,v
retrieving revision 1.19
diff -u -r1.19 MonoCustomAttrs.cs
--- class/corlib/System/MonoCustomAttrs.cs	5 Sep 2004 16:24:52 -0000	1.19
+++ class/corlib/System/MonoCustomAttrs.cs	14 Sep 2004 09:45:21 -0000
@@ -35,6 +35,7 @@
 using System.Reflection;
 using System.Collections;
 using System.Runtime.CompilerServices;
+using System.Runtime.InteropServices;
 
 namespace System
 {
@@ -62,52 +63,86 @@
 			return (Attribute) res[0];
 		}
 
+		[MonoTODO ("Missing MarshalAsAttribute")]
+		internal static object[] GetCustomAttributes (ParameterInfo parameterInfo, Type attributeType, bool inherit)
+		{
+#if NET_2_0
+			if ((parameterInfo.Attributes & (ParameterAttributes.In | ParameterAttributes.Out | ParameterAttributes.Optional)) != 0) {
+				ArrayList al = new ArrayList (2);
+
+				if (parameterInfo.IsIn && (attributeType == null || attributeType == typeof (InAttribute)))
+					al.Add (new InAttribute ());
+
+				if (parameterInfo.IsOut && (attributeType == null || attributeType == typeof (OutAttribute)))
+					al.Add (new OutAttribute ());
+
+				if (parameterInfo.IsOptional && (attributeType == null || attributeType == typeof (OptionalAttribute)))
+					al.Add (new OptionalAttribute ());
+
+				return GetCustomAttributes (parameterInfo, attributeType, inherit, null);
+			}
+#endif
+			return GetCustomAttributes (parameterInfo, attributeType, inherit, null);
+		}
+
+		internal static object[] GetCustomAttributes (MemberInfo mi, Type attributeType, bool inherit)
+		{
+#if NET_2_0
+			return GetCustomAttributes (mi, attributeType, inherit, mi.GetPseudoAttributes (attributeType));
+#else
+			return GetCustomAttributes (mi, attributeType, inherit, null);
+#endif
+		}
+
 		internal static object[] GetCustomAttributes (ICustomAttributeProvider obj, Type attributeType, bool inherit)
 		{
+			return GetCustomAttributes (obj, attributeType, inherit, null);
+		}
+
+		readonly static object[] empty_attrs = new object [0];
+
+		static object[] GetCustomAttributes (ICustomAttributeProvider obj, Type attributeType, bool inherit, ArrayList pseudoAttrs)
+		{
 			if (obj == null)
 				throw new ArgumentNullException ("obj");
 
 			object[] r;
 			object[] res = GetCustomAttributes (obj);
 			// shortcut
-			if (!inherit && res.Length == 1)
-			{
-				if (attributeType != null)
-				{
-					if (attributeType.IsAssignableFrom (res[0].GetType ()))
-					{
-						r = (object[]) Array.CreateInstance (attributeType, 1);
-						r[0] = res[0];
+			if (!inherit && res.Length < 2) {
+				if (pseudoAttrs == null) {
+					if (res.Length == 0) {
+						return empty_attrs;
 					}
-					else
-					{
-						r = (object[]) Array.CreateInstance (attributeType, 0);
+
+					if (attributeType != null) {
+						if (attributeType.IsAssignableFrom (res[0].GetType ())) {
+							r = (object[]) Array.CreateInstance (attributeType, 1);
+							r[0] = res[0];
+							return r;
+						}
+						return empty_attrs;
 					}
-				}
-				else
-				{
+
 					r = (object[]) Array.CreateInstance (res[0].GetType (), 1);
 					r[0] = res[0];
+					return r;
 				}
-				return r;
-			}
 
-			// if AttributeType is sealed, and Inherited is set to false, then 
-			// there's no use in scanning base types 
-			if ((attributeType != null && attributeType.IsSealed) && !inherit)
-			{
-				AttributeUsageAttribute usageAttribute = RetrieveAttributeUsage (
-					attributeType);
-				if (!usageAttribute.Inherited)
-				{
-					inherit = false;
+				if (attributeType == null) {
+					r = (object[]) Array.CreateInstance (typeof(Attribute), res.Length + pseudoAttrs.Count);
+					res.CopyTo (r, 0);
+					pseudoAttrs.CopyTo (r, res.Length);
+					return r;
 				}
+
+				return (object[]) pseudoAttrs.ToArray ();
 			}
 
 			int initialSize = res.Length < 16 ? res.Length : 16;
 
 			Hashtable attributeInfos = new Hashtable (initialSize);
-			ArrayList a = new ArrayList (initialSize);
+			ArrayList a = pseudoAttrs == null ? new ArrayList (initialSize) : pseudoAttrs;
 			ICustomAttributeProvider btype = obj;
 
 			int inheritanceLevel = 0;
@@ -166,31 +201,19 @@
 				}
 			} while (inherit && btype != null);
 
-			object[] array = null;
 			if (attributeType == null || attributeType.IsValueType)
 			{
-				array = (object[]) Array.CreateInstance (typeof(Attribute), a.Count);
+				r = (object[]) Array.CreateInstance (typeof(Attribute), a.Count);
 			}
 			else
 			{
-				array = Array.CreateInstance (attributeType, a.Count) as object[];
+				r = Array.CreateInstance (attributeType, a.Count) as object[];
 			}
 
 			// copy attributes to array
-			a.CopyTo (array, 0);
+			a.CopyTo (r, 0);
 
-			return array;
-		}
-
-		internal static object[] GetCustomAttributes (ICustomAttributeProvider obj, bool inherit)
-		{
-			if (obj == null)
-				throw new ArgumentNullException ("obj");
-
-			if (!inherit)
-				return (object[]) GetCustomAttributes (obj).Clone ();
-
-			return GetCustomAttributes (obj, null, inherit);
+			return r;
 		}
 
 		internal static bool IsDefined (ICustomAttributeProvider obj, Type attributeType, bool inherit)
@@ -316,4 +339,3 @@
 		}
 	}
 }
-
Index: class/corlib/System/MonoType.cs
===================================================================
RCS file: /cvs/public/mcs/class/corlib/System/MonoType.cs,v
retrieving revision 1.75
diff -u -r1.75 MonoType.cs
--- class/corlib/System/MonoType.cs	16 Aug 2004 21:50:37 -0000	1.75
+++ class/corlib/System/MonoType.cs	6 Sep 2004 16:18:45 -0000
@@ -473,7 +473,7 @@
 
 		public override object[] GetCustomAttributes (bool inherit)
 		{
-			return MonoCustomAttrs.GetCustomAttributes (this, inherit);
+			return MonoCustomAttrs.GetCustomAttributes (this, null, inherit);
 		}
 
 		public override object[] GetCustomAttributes (Type attributeType, bool inherit)
Index: class/corlib/System/Type.cs
===================================================================
RCS file: /cvs/public/mcs/class/corlib/System/Type.cs,v
retrieving revision 1.100
diff -u -r1.100 Type.cs
--- class/corlib/System/Type.cs	15 Jun 2004 12:34:47 -0000	1.100
+++ class/corlib/System/Type.cs	7 Sep 2004 20:43:06 -0000
@@ -1045,5 +1045,27 @@
 			return make_byref_type ();
 		}
 #endif
+
+#if NET_2_0
+		internal override ArrayList GetPseudoAttributes (Type aType)
+		{
+			if (!IsImport && !IsSerializable)
+				return null;
+
+			ArrayList al = new ArrayList (2);
+			if (IsImport)
+				if (aType == null || aType == typeof (ComImportAttribute))
+					al.Add (com_import_attr);
+
+			if (IsSerializable)
+				if (aType == null || aType == typeof (SerializableAttribute))
+					al.Add (serializable_attr);
+
+			return al;
+		}
+
+		static object serializable_attr = new SerializableAttribute ();
+		static object com_import_attr = new ComImportAttribute ();
+#endif
 	}
 }
Index: class/corlib/System.Reflection/Assembly.cs
===================================================================
RCS file: /cvs/public/mcs/class/corlib/System.Reflection/Assembly.cs,v
retrieving revision 1.75
diff -u -r1.75 Assembly.cs
--- class/corlib/System.Reflection/Assembly.cs	30 Aug 2004 19:13:12 -0000	1.75
+++ class/corlib/System.Reflection/Assembly.cs	6 Sep 2004 16:20:42 -0000
@@ -173,7 +173,7 @@
 
 		public virtual object [] GetCustomAttributes (bool inherit)
 		{
-			return MonoCustomAttrs.GetCustomAttributes (this, inherit);
+			return MonoCustomAttrs.GetCustomAttributes (this, null, inherit);
 		}
 
 		public virtual object [] GetCustomAttributes (Type attributeType, bool inherit)
Index: class/corlib/System.Reflection/EventInfo.cs
===================================================================
RCS file: /cvs/public/mcs/class/corlib/System.Reflection/EventInfo.cs,v
retrieving revision 1.9
diff -u -r1.9 EventInfo.cs
--- class/corlib/System.Reflection/EventInfo.cs	11 Jun 2004 02:02:54 -0000	1.9
+++ class/corlib/System.Reflection/EventInfo.cs	6 Sep 2004 16:21:13 -0000
@@ -106,7 +106,7 @@
 		}
 
 		public override object[] GetCustomAttributes( bool inherit) {
-			return MonoCustomAttrs.GetCustomAttributes (this, inherit);
+			return MonoCustomAttrs.GetCustomAttributes (this, null, inherit);
 		}
 		public override object[] GetCustomAttributes( Type attributeType, bool inherit) {
 			return MonoCustomAttrs.GetCustomAttributes (this, attributeType, inherit);
Index: class/corlib/System.Reflection/FieldInfo.cs
===================================================================
RCS file: /cvs/public/mcs/class/corlib/System.Reflection/FieldInfo.cs,v
retrieving revision 1.20
diff -u -r1.20 FieldInfo.cs
--- class/corlib/System.Reflection/FieldInfo.cs	11 Jun 2004 18:47:55 -0000	1.20
+++ class/corlib/System.Reflection/FieldInfo.cs	7 Sep 2004 20:42:48 -0000
@@ -39,6 +39,7 @@
 using System.Globalization;
 using System.Runtime.CompilerServices;
 using System.Runtime.InteropServices;
+using System.Collections;
 
 namespace System.Reflection {
 
@@ -168,6 +169,22 @@
 
 #if NET_2_0 || BOOTSTRAP_NET_2_0
 		public abstract FieldInfo Mono_GetGenericFieldDefinition ();
+#endif
+
+#if NET_2_0
+		[MonoTODO ("Missing MarshalAsAttribute, FieldOffsetAttribute")]
+		internal override ArrayList GetPseudoAttributes (Type aType)
+		{
+			if (!IsNotSerialized)
+				return null;
+			
+			ArrayList al = new ArrayList (1);
+			al.Add (not_serialized_attr);
+
+			return al;
+		}
+
+		static object not_serialized_attr = new NonSerializedAttribute ();
 #endif
 	}
 }
Index: class/corlib/System.Reflection/MemberInfo.cs
===================================================================
RCS file: /cvs/public/mcs/class/corlib/System.Reflection/MemberInfo.cs,v
retrieving revision 1.7
diff -u -r1.7 MemberInfo.cs
--- class/corlib/System.Reflection/MemberInfo.cs	15 Jun 2004 11:12:48 -0000	1.7
+++ class/corlib/System.Reflection/MemberInfo.cs	7 Sep 2004 20:43:15 -0000
@@ -63,5 +63,12 @@
 		public abstract object [] GetCustomAttributes (bool inherit);
 
 		public abstract object [] GetCustomAttributes (Type attribute_type, bool inherit);
+
+#if NET_2_0
+		internal virtual System.Collections.ArrayList GetPseudoAttributes (Type aType)
+		{
+			return null;
+		}
+#endif
 	}
 }
Index: class/corlib/System.Reflection/MethodBase.cs
===================================================================
RCS file: /cvs/public/mcs/class/corlib/System.Reflection/MethodBase.cs,v
retrieving revision 1.24
diff -u -r1.24 MethodBase.cs
--- class/corlib/System.Reflection/MethodBase.cs	30 Aug 2004 15:14:47 -0000	1.24
+++ class/corlib/System.Reflection/MethodBase.cs	7 Sep 2004 20:42:23 -0000
@@ -36,6 +36,7 @@
 using System.Reflection.Emit;
 using System.Runtime.CompilerServices;
 using System.Runtime.InteropServices;
+using System.Collections;
 
 namespace System.Reflection {
 
@@ -202,6 +203,40 @@
 				throw new NotSupportedException ();
 			}
 		}
+#endif
+
+#if NET_2_0
+		internal override ArrayList GetPseudoAttributes (Type aType)
+		{
+			if ((GetMethodImplementationFlags () & MethodImplAttributes.PreserveSig) == 0 &&
+		        (Attributes & MethodAttributes.PinvokeImpl) == 0)
+				return null;
+
+			ArrayList al = new ArrayList (2);
+			if ((GetMethodImplementationFlags () & MethodImplAttributes.PreserveSig) !=  0) {
+				if (aType == null || aType == typeof (PreserveSigAttribute))
+					al.Add (preservesig_attr);
+			}
+
+			if ((Attributes & MethodAttributes.PinvokeImpl) != 0) {
+				if (aType == null || aType == typeof (DllImportAttribute))
+					al.Add (ReconstructDllImportAttribute ());
+			}
+
+			return al;
+		}
+
+		[MonoTODO ("A lot of work here")]
+		object ReconstructDllImportAttribute ()
+		{
+			DllImportAttribute a = new DllImportAttribute ("");
+
+			// Reset all members here
+
+			return a;
+		}
+
+		static object preservesig_attr = new PreserveSigAttribute ();
 #endif
 	}
 }
Index: class/corlib/System.Reflection/Module.cs
===================================================================
RCS file: /cvs/public/mcs/class/corlib/System.Reflection/Module.cs,v
retrieving revision 1.19
diff -u -r1.19 Module.cs
--- class/corlib/System.Reflection/Module.cs	29 Jul 2004 16:10:05 -0000	1.19
+++ class/corlib/System.Reflection/Module.cs	6 Sep 2004 16:15:41 -0000
@@ -94,7 +94,7 @@
 	
 		public virtual object[] GetCustomAttributes(bool inherit) 
 		{
-			return MonoCustomAttrs.GetCustomAttributes (this, inherit);
+			return MonoCustomAttrs.GetCustomAttributes (this, null, inherit);
 		}
 	
 		public virtual object[] GetCustomAttributes(Type attributeType, bool inherit) 
Index: class/corlib/System.Reflection/MonoField.cs
===================================================================
RCS file: /cvs/public/mcs/class/corlib/System.Reflection/MonoField.cs,v
retrieving revision 1.15
diff -u -r1.15 MonoField.cs
--- class/corlib/System.Reflection/MonoField.cs	11 Jun 2004 18:47:55 -0000	1.15
+++ class/corlib/System.Reflection/MonoField.cs	6 Sep 2004 16:19:18 -0000
@@ -87,7 +87,7 @@
 		}
 
 		public override object[] GetCustomAttributes( bool inherit) {
-			return MonoCustomAttrs.GetCustomAttributes (this, inherit);
+			return MonoCustomAttrs.GetCustomAttributes (this, null, inherit);
 		}
 		public override object[] GetCustomAttributes( Type attributeType, bool inherit) {
 			return MonoCustomAttrs.GetCustomAttributes (this, attributeType, inherit);
Index: class/corlib/System.Reflection/MonoMethod.cs
===================================================================
RCS file: /cvs/public/mcs/class/corlib/System.Reflection/MonoMethod.cs,v
retrieving revision 1.32
diff -u -r1.32 MonoMethod.cs
--- class/corlib/System.Reflection/MonoMethod.cs	11 Jun 2004 02:02:54 -0000	1.32
+++ class/corlib/System.Reflection/MonoMethod.cs	6 Sep 2004 16:17:43 -0000
@@ -167,7 +167,7 @@
 		}
 
 		public override object[] GetCustomAttributes( bool inherit) {
-			return MonoCustomAttrs.GetCustomAttributes (this, inherit);
+			return MonoCustomAttrs.GetCustomAttributes (this, null, inherit);
 		}
 		public override object[] GetCustomAttributes( Type attributeType, bool inherit) {
 			return MonoCustomAttrs.GetCustomAttributes (this, attributeType, inherit);
@@ -330,7 +330,7 @@
 		}
 
 		public override object[] GetCustomAttributes( bool inherit) {
-			return MonoCustomAttrs.GetCustomAttributes (this, inherit);
+			return MonoCustomAttrs.GetCustomAttributes (this, null, inherit);
 		}
 
 		public override object[] GetCustomAttributes( Type attributeType, bool inherit) {
Index: class/corlib/System.Reflection/MonoProperty.cs
===================================================================
RCS file: /cvs/public/mcs/class/corlib/System.Reflection/MonoProperty.cs,v
retrieving revision 1.16
diff -u -r1.16 MonoProperty.cs
--- class/corlib/System.Reflection/MonoProperty.cs	11 Jun 2004 02:02:54 -0000	1.16
+++ class/corlib/System.Reflection/MonoProperty.cs	6 Sep 2004 16:16:56 -0000
@@ -185,7 +185,7 @@
 
 		public override object[] GetCustomAttributes (bool inherit)
 		{
-			return MonoCustomAttrs.GetCustomAttributes (this, inherit);
+			return MonoCustomAttrs.GetCustomAttributes (this, null, inherit);
 		}
 		
 		public override object[] GetCustomAttributes (Type attributeType, bool inherit)
Index: class/corlib/System.Reflection/ParameterInfo.cs
===================================================================
RCS file: /cvs/public/mcs/class/corlib/System.Reflection/ParameterInfo.cs,v
retrieving revision 1.12
diff -u -r1.12 ParameterInfo.cs
--- class/corlib/System.Reflection/ParameterInfo.cs	11 Jun 2004 02:02:54 -0000	1.12
+++ class/corlib/System.Reflection/ParameterInfo.cs	6 Sep 2004 16:16:15 -0000
@@ -111,7 +111,7 @@
 
 		public virtual object[] GetCustomAttributes (bool inherit)
 		{
-			return MonoCustomAttrs.GetCustomAttributes (this, inherit);
+			return MonoCustomAttrs.GetCustomAttributes (this, null, inherit);
 		}
 
 		public virtual object[] GetCustomAttributes (Type attributeType, bool inherit)
Index: class/corlib/System.Reflection.Emit/MonoArrayMethod.cs
===================================================================
RCS file: /cvs/public/mcs/class/corlib/System.Reflection.Emit/MonoArrayMethod.cs,v
retrieving revision 1.5
diff -u -r1.5 MonoArrayMethod.cs
--- class/corlib/System.Reflection.Emit/MonoArrayMethod.cs	11 Jun 2004 02:03:15 -0000	1.5
+++ class/corlib/System.Reflection.Emit/MonoArrayMethod.cs	6 Sep 2004 16:20:07 -0000
@@ -114,7 +114,7 @@
 		}
 
 		public override object[] GetCustomAttributes( bool inherit) {
-			return MonoCustomAttrs.GetCustomAttributes (this, inherit);
+			return MonoCustomAttrs.GetCustomAttributes (this, null, inherit);
 		}
 		public override object[] GetCustomAttributes( Type attributeType, bool inherit) {
 			return MonoCustomAttrs.GetCustomAttributes (this, attributeType, inherit);
