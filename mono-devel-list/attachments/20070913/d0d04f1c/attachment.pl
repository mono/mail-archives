Index: System/Activator.cs
===================================================================
--- System/Activator.cs	(revision 85725)
+++ System/Activator.cs	(working copy)
@@ -30,11 +30,13 @@
 //
 
 using System.Globalization;
+using System.IO;
 using System.Reflection;
 using System.Runtime.Remoting;
 using System.Runtime.Remoting.Activation;
 using System.Runtime.CompilerServices;
 using System.Runtime.InteropServices;
+using System.Runtime.Serialization.Formatters.Binary;
 using System.Security.Permissions;
 using System.Security.Policy;
 using System.Configuration.Assemblies;
@@ -150,6 +152,65 @@
 		}
 
 #if NET_2_0
+		[MonoNotSupported ("no ClickOnce in mono")]
+		public static ObjectHandle CreateInstance (ActivationContext activationContext)
+		{
+			throw new NotImplementedException ();
+		}
+
+		[MonoNotSupported ("no ClickOnce in mono")]
+		public static ObjectHandle CreateInstance (ActivationContext activationContext, string [] activationCustomData)
+		{
+			throw new NotImplementedException ();
+		}
+
+		// Cross-domain instance creation
+
+		static readonly MethodInfo method_create_instance_xd =
+			typeof (AppDomain).GetMethod ("CreateInstanceCrossDomain", new Type [] {typeof (byte []), typeof (object []), typeof (bool)});
+
+		public static ObjectHandle CreateInstanceFrom (AppDomain domain, string assemblyFile, string typeName)
+		{
+			return CreateInstanceFrom (domain, assemblyFile, typeName, false, _flags, null, null, null, null, null);
+		}
+
+		public static ObjectHandle CreateInstanceFrom (AppDomain domain, string assemblyFile, string typeName,
+							       bool ignoreCase, BindingFlags bindingAttr, Binder binder,
+							       object [] args, CultureInfo culture,
+							       object [] activationAttributes,
+							       Evidence securityAttributes)
+		{
+			if (domain == null)
+				throw new ArgumentNullException ("domain");
+
+			BinaryFormatter bf = new BinaryFormatter ();
+			MemoryStream ms = new MemoryStream ();
+			bf.Serialize (ms, new InstanceCreationContext (assemblyFile, typeName, ignoreCase, bindingAttr, binder, culture, activationAttributes, securityAttributes));
+
+			return (ObjectHandle) AppDomain.InvokeInDomain (domain, method_create_instance_xd, domain, new object [] {ms.ToArray (), args, true});
+		}
+
+		public static ObjectHandle CreateInstance (AppDomain domain, string assemblyName, string typeName)
+		{
+			return CreateInstance (domain, assemblyName, typeName, false, _flags, null, null, null, null, null);
+		}
+
+		public static ObjectHandle CreateInstance (AppDomain domain, string assemblyName, string typeName,
+							   bool ignoreCase, BindingFlags bindingAttr, Binder binder,
+							   object [] args, CultureInfo culture,
+							   object [] activationAttributes,
+							   Evidence securityAttributes)
+		{
+			if (domain == null)
+				throw new ArgumentNullException ("domain");
+
+			BinaryFormatter bf = new BinaryFormatter ();
+			MemoryStream ms = new MemoryStream ();
+			bf.Serialize (ms, new InstanceCreationContext (assemblyName, typeName, ignoreCase, bindingAttr, binder, culture, activationAttributes, securityAttributes));
+
+			return (ObjectHandle) AppDomain.InvokeInDomain (domain, method_create_instance_xd, domain, new object [] {ms.ToArray (), args, false});
+		}
+
 		public static T CreateInstance <T> ()
 		{
 			return (T) CreateInstance (typeof (T));
@@ -327,5 +388,52 @@
 			throw new NotImplementedException ();
 		}
 #endif
+
+#if NET_2_0
+		[Serializable]
+		internal class InstanceCreationContext
+		{
+			public InstanceCreationContext (string assemblyNameOrFile, string typeName, 
+							bool ignoreCase, BindingFlags bindingAttr, Binder binder,
+							CultureInfo culture, object [] activationAttributes,
+							Evidence securityAttributes)
+			{
+				// Looks like .NET does not check serializability for ars...
+				if (activationAttributes != null)
+					foreach (object o in activationAttributes)
+						if (!CheckSerializability (o))
+							throw new NotSupportedException ("Only marshallable objects are supported for activation attributes");
+
+				AssemblyNameOrFile = assemblyNameOrFile;
+				TypeName = typeName;
+				IgnoreCase = ignoreCase;
+				BindingFlags = bindingAttr;
+				Binder = binder;
+				Culture = culture;
+				ActivationAttributes = activationAttributes;
+				Evidence = securityAttributes;
+			}
+
+			bool CheckSerializability (object o)
+			{
+				if (o == null)
+					return true;
+				Type t = o.GetType ();
+				if (t.IsSerializable || t.IsMarshalByRef)
+					return true;
+				return false;
+			}
+
+			public string AssemblyNameOrFile;
+			public string TypeName;
+			public bool IgnoreCase;
+			public BindingFlags BindingFlags;
+			public Binder Binder;
+			public object [] Args;
+			public CultureInfo Culture;
+			public object [] ActivationAttributes;
+			public Evidence Evidence;
+		}
+#endif
 	}
 }
Index: System/AppDomain.cs
===================================================================
--- System/AppDomain.cs	(revision 85725)
+++ System/AppDomain.cs	(working copy)
@@ -44,6 +44,7 @@
 using System.Runtime.Remoting.Contexts;
 using System.Runtime.Remoting.Channels;
 using System.Runtime.Remoting.Messaging;
+using System.Runtime.Serialization.Formatters.Binary;
 using System.Security;
 using System.Security.Permissions;
 using System.Security.Policy;
@@ -338,6 +339,19 @@
 			                                     culture, activationAttributes, securityAttributes);
 		}
 
+#if NET_2_0
+		public ObjectHandle CreateInstanceCrossDomain (byte [] context, object [] args, bool loadFrom)
+		{
+			BinaryFormatter bf = new BinaryFormatter ();
+			MemoryStream ms = new MemoryStream (context);
+			Activator.InstanceCreationContext ctx = (Activator.InstanceCreationContext) bf.Deserialize (ms);
+			if (loadFrom)
+				return CreateInstanceFrom (ctx.AssemblyNameOrFile, ctx.TypeName, ctx.IgnoreCase, ctx.BindingFlags, ctx.Binder, args, ctx.Culture, ctx.ActivationAttributes, ctx.Evidence);
+			else
+				return CreateInstance (ctx.AssemblyNameOrFile, ctx.TypeName, ctx.IgnoreCase, ctx.BindingFlags, ctx.Binder, args, ctx.Culture, ctx.ActivationAttributes, ctx.Evidence);
+		}
+#endif
+
 		public object CreateInstanceFromAndUnwrap (string assemblyName, string typeName)
 		{
 			ObjectHandle oh = CreateInstanceFrom (assemblyName, typeName);
Index: Test/System/ActivatorTest.cs
===================================================================
--- Test/System/ActivatorTest.cs	(revision 85725)
+++ Test/System/ActivatorTest.cs	(working copy)
@@ -356,6 +356,37 @@
 			Assert.IsNotNull (Activator.CreateInstance (typeof (foo1<int>)), "foo1<int>");
 			Assert.IsNotNull (Activator.CreateInstance (typeof (foo2<long, int>)), "foo2<long, int>");
 		}
+
+		[Test]
+		public void CreateInstanceCrossDomain ()
+		{
+			Activator.CreateInstance (AppDomain.CurrentDomain, "mscorlib.dll", "System.Object");
+			Activator.CreateInstance (AppDomain.CurrentDomain, "mscorlib.dll", "System.Object", false,
+						  BindingFlags.Public | BindingFlags.Instance, null, null, CultureInfo.InvariantCulture,
+						  null, null);
+			// FIXME: below works as a standalone case, but does not as a unit test (causes JIT error).
+//                	Activator.CreateInstance (AppDomain.CreateDomain ("foo"), "mscorlib.dll", "System.Object", false,
+//						  BindingFlags.Public | BindingFlags.Instance, null, null, null,
+//						  null, null);
+		}
+
+		[Test]
+		public void CreateInstanceCrossDomainNonSerializableArgs ()
+		{
+			// I'm not sure why this is possible ...
+			Activator.CreateInstance (AppDomain.CurrentDomain, "mscorlib.dll", "System.WeakReference", false,
+						  BindingFlags.Public | BindingFlags.Instance, null, new object [] {ModuleHandle.EmptyHandle}, null, null, null);
+		}
+
+		[Test]
+		[ExpectedException (typeof (NotSupportedException))]
+		public void CreateInstanceCrossDomainNonSerializableAtts ()
+		{
+			// even on invalid success it causes different exception though.
+			Activator.CreateInstance (AppDomain.CurrentDomain, "mscorlib.dll", "System.Object", false,
+						  BindingFlags.Public | BindingFlags.Instance, null, null, null,
+						  new object [] {ModuleHandle.EmptyHandle}, null);
+		}
 #endif
 	}
 }