Index: corlib.dll.sources
===================================================================
--- corlib.dll.sources	(revision 77822)
+++ corlib.dll.sources	(working copy)
@@ -524,6 +524,7 @@
 System.Resources/IResourceReader.cs
 System.Resources/IResourceWriter.cs
 System.Resources/MissingManifestResourceException.cs
+System.Resources/MissingSatelliteAssemblyException.cs
 System.Resources/NeutralResourcesLanguageAttribute.cs
 System.Resources/ResourceManager.cs
 System.Resources/ResourceReader.cs
Index: System.Resources/IResourceWriter.cs
===================================================================
--- System.Resources/IResourceWriter.cs	(revision 77822)
+++ System.Resources/IResourceWriter.cs	(working copy)
@@ -34,7 +34,9 @@
 
 namespace System.Resources
 {
-
+#if NET_2_0
+	[System.Runtime.InteropServices.ComVisible (true)]
+#endif
 	public interface IResourceWriter : IDisposable
 	{
 		void AddResource (string name, byte[] value);
Index: System.Resources/NeutralResourcesLanguageAttribute.cs
===================================================================
--- System.Resources/NeutralResourcesLanguageAttribute.cs	(revision 77822)
+++ System.Resources/NeutralResourcesLanguageAttribute.cs	(working copy)
@@ -32,6 +32,9 @@
 
 namespace System.Resources
 {
+#if NET_2_0
+	[System.Runtime.InteropServices.ComVisible (true)]
+#endif
 	[AttributeUsage (AttributeTargets.Assembly)]
 	public sealed class NeutralResourcesLanguageAttribute : Attribute
 	{
Index: System.Resources/SatelliteContractVersionAttribute.cs
===================================================================
--- System.Resources/SatelliteContractVersionAttribute.cs	(revision 77822)
+++ System.Resources/SatelliteContractVersionAttribute.cs	(working copy)
@@ -33,6 +33,9 @@
 namespace System.Resources
 {
 	[AttributeUsage (AttributeTargets.Assembly)]
+#if NET_2_0
+	[System.Runtime.InteropServices.ComVisible (true)]
+#endif
 	public sealed class SatelliteContractVersionAttribute : Attribute
 	{
 		private Version ver; 
Index: System.Resources/ResourceManager.cs
===================================================================
--- System.Resources/ResourceManager.cs	(revision 77822)
+++ System.Resources/ResourceManager.cs	(working copy)
@@ -35,11 +35,15 @@
 using System.Collections;
 using System.Reflection;
 using System.Globalization;
+using System.Runtime.InteropServices;
 using System.IO;
 
 namespace System.Resources
 {
 	[Serializable]
+#if NET_2_0
+	[ComVisible (true)]
+#endif
 	public class ResourceManager
 	{
 		public static readonly int HeaderVersionNumber = 1;
@@ -56,6 +60,10 @@
 		
 		/* Recursing through culture parents stops here */
 		private CultureInfo neutral_culture;
+
+#if NET_2_0
+		private UltimateResourceFallbackLocation fallbackLocation;
+#endif
 		
 		// constructors
 		protected ResourceManager () {
@@ -280,13 +288,36 @@
 					return ass.GetManifestResourceStream (s);
 			return null;
 		}
-		
+
+#if NET_2_0
+		[CLSCompliant (false)]
+		[ComVisible (true)]
+		public UnmanagedMemoryStream GetStream (string name)
+		{
+			return GetStream (name, CultureInfo.InvariantCulture);
+		}
+
+		[CLSCompliant (false)]
+		[ComVisible (true)]
+		public UnmanagedMemoryStream GetStream (string name, CultureInfo culture)
+		{
+			if (name == null)
+				throw new ArgumentNullException ("name");
+			if (culture == null)
+				throw new ArgumentNullException ("culture");
+			ResourceSet set = InternalGetResourceSet (culture, true, true);
+			if (set == null)
+				throw new MissingManifestResourceException (String.Format ("Could not find any resource appropriate for the specified culture or its parents (resource file : \"{0}\")", GetResourceFileName(culture)));
+
+			return set.GetStream (name);
+		}
+#endif
 		protected virtual ResourceSet InternalGetResourceSet (CultureInfo culture, bool Createifnotexists, bool tryParents)
 		{
 			ResourceSet set;
 			
 			if (culture == null) {
-				string msg = String.Format ("Could not find any resource appropiate for the " +
+				string msg = String.Format ("Could not find any resource appropriate for the " +
 							    "specified culture or its parents (assembly:{0})",
 							    MainAssembly != null ? MainAssembly.GetName ().Name : "");
 							    
@@ -331,7 +362,7 @@
 					 */
 					set=(ResourceSet)Activator.CreateInstance(resourceSetType, args);
 				} else if (culture.Equals (CultureInfo.InvariantCulture)) {
-					string msg = "Could not find any resource appropiate for the " +
+					string msg = "Could not find any resource appropriate for the " +
 						     "specified culture or its parents. " +
 						     "Make sure \"{1}\" was correctly embedded or " +
 						     "linked into assembly \"{0}\".";
@@ -424,5 +455,13 @@
 				return(new Version(sat_attr.Version));
 			}
 		}
+
+#if NET_2_0
+		[MonoLimitation ("the property exists but is not respected")]
+		protected UltimateResourceFallbackLocation FallbackLocation {
+			get { return fallbackLocation; }
+			set { fallbackLocation = value; }
+		}
+#endif
 	}
 }
Index: System.Resources/IResourceReader.cs
===================================================================
--- System.Resources/IResourceReader.cs	(revision 77822)
+++ System.Resources/IResourceReader.cs	(working copy)
@@ -35,6 +35,9 @@
 
 namespace System.Resources
 {
+#if NET_2_0
+	[System.Runtime.InteropServices.ComVisible (true)]
+#endif
 	public interface IResourceReader : IEnumerable, IDisposable
 	{
 		void Close();
Index: System.Resources/ResourceSet.cs
===================================================================
--- System.Resources/ResourceSet.cs	(revision 77822)
+++ System.Resources/ResourceSet.cs	(working copy)
@@ -38,6 +38,9 @@
 namespace System.Resources
 {
 	[Serializable]
+#if NET_2_0
+	[ComVisible (true)]
+#endif
 	public class ResourceSet : IDisposable
 
 #if (NET_1_1)
@@ -46,6 +49,9 @@
 
 	{
 
+#if NET_2_0
+		[NonSerialized]
+#endif
 		protected IResourceReader Reader;
 		protected Hashtable Table;
 
@@ -198,5 +204,20 @@
 			while (i.MoveNext ()) 
 				Table.Add (i.Key, i.Value);
 		}
+
+#if NET_2_0
+		internal UnmanagedMemoryStream GetStream (string name)
+		{
+			if (Reader == null)
+				throw new InvalidOperationException ("ResourceSet is closed.");
+
+			IDictionaryEnumerator i = Reader.GetEnumerator();
+			i.Reset ();
+			while (i.MoveNext ())
+				if (name == (string) i.Key)
+					return ((ResourceReader.ResourceEnumerator) i).ValueAsStream;
+			return null;
+		}
+#endif
 	}
 }
Index: System.Resources/ResourceWriter.cs
===================================================================
--- System.Resources/ResourceWriter.cs	(revision 77822)
+++ System.Resources/ResourceWriter.cs	(working copy)
@@ -39,9 +39,28 @@
 
 namespace System.Resources
 {
+#if NET_2_0
+	[System.Runtime.InteropServices.ComVisible (true)]
+#endif
 	public sealed class ResourceWriter : IResourceWriter, IDisposable
 	{
-		Hashtable resources;
+		class TypeByNameObject
+		{
+			public readonly string TypeName;
+			public readonly byte [] Value;
+
+			public TypeByNameObject (string typeName, byte [] value)
+			{
+				TypeName = typeName;
+				Value = (byte []) value.Clone ();
+			}
+		}
+
+#if NET_2_0
+		SortedList resources = new SortedList (StringComparer.Ordinal);
+#else
+		Hashtable resources = new Hashtable(CaseInsensitiveHashCodeProvider.Default, CaseInsensitiveComparer.Default);
+#endif
 		Stream stream;
 		
 		public ResourceWriter (Stream stream)
@@ -52,7 +71,6 @@
 				throw new ArgumentException ("stream is not writable.");
 
 			this.stream=stream;
-			resources=new Hashtable(CaseInsensitiveHashCodeProvider.Default, CaseInsensitiveComparer.Default);
 		}
 		
 		public ResourceWriter (String fileName)
@@ -61,7 +79,6 @@
 				throw new ArgumentNullException ("fileName is null.");
 
 			stream=new FileStream(fileName, FileMode.Create, FileAccess.Write);
-			resources=new Hashtable(CaseInsensitiveHashCodeProvider.Default, CaseInsensitiveComparer.Default);
 		}
 		
 		public void AddResource (string name, byte[] value)
@@ -137,7 +154,22 @@
 			resources=null;
 			stream=null;
 		}
-		
+
+#if NET_2_0
+		public void AddResourceData (string name, string typeName, byte [] serializedData)
+		{
+			if (name == null)
+				throw new ArgumentNullException ("name");
+			if (typeName == null)
+				throw new ArgumentNullException ("typeName");
+			if (serializedData == null)
+				throw new ArgumentNullException ("serializedData");
+
+			// shortcut
+			AddResource (name, new TypeByNameObject (typeName, serializedData));
+		}
+#endif
+
 		private bool generated=false;
 		
 		public void Generate () {
@@ -170,7 +202,11 @@
 							     Encoding.UTF8);
 
 			resman.Write(typeof(ResourceReader).AssemblyQualifiedName);
+#if NET_2_0
+			resman.Write(typeof(ResourceSet).FullName);
+#else
 			resman.Write(typeof(ResourceSet).AssemblyQualifiedName);
+#endif
 
 			/* Only space for 32 bits of header len in the
 			 * resource file format
@@ -218,19 +254,116 @@
 					count++;
 					continue;
 				}
-				
-				Type type=res_enum.Value.GetType();
+				// implementation note: TypeByNameObject is
+				// not used in 1.x profile.
+				TypeByNameObject tbn = res_enum.Value as TypeByNameObject;
+				Type type = tbn != null ? null : res_enum.Value.GetType();
+				object typeObj = tbn != null ? (object) tbn.TypeName : type;
 
 				/* Keep a list of unique types */
-				if(!types.Contains(type)) {
-					types.Add(type);
+#if NET_2_0
+				// do not output predefined ones.
+				switch (type != null ? Type.GetTypeCode (type) : TypeCode.Empty) {
+				case TypeCode.Decimal:
+				case TypeCode.Single:
+				case TypeCode.Double:
+				case TypeCode.SByte:
+				case TypeCode.Int16:
+				case TypeCode.Int32:
+				case TypeCode.Int64:
+				case TypeCode.Byte:
+				case TypeCode.UInt16:
+				case TypeCode.UInt32:
+				case TypeCode.UInt64:
+				case TypeCode.DateTime:
+				case TypeCode.String:
+					break;
+				default:
+					if (type == typeof (TimeSpan))
+						break;
+					if (type == typeof (MemoryStream))
+						break;
+					if (type==typeof(byte[]))
+						break;
+
+					if (!types.Contains (typeObj))
+						types.Add (typeObj);
+					/* Write the data section */
+					Write7BitEncodedInt(res_data, types.IndexOf(typeObj));
+					break;
 				}
-
+#else
+				if (!types.Contains (typeObj))
+					types.Add (typeObj);
 				/* Write the data section */
 				Write7BitEncodedInt(res_data, types.IndexOf(type));
+#endif
+
 				/* Strangely, Char is serialized
 				 * rather than just written out
 				 */
+#if NET_2_0
+				if (tbn != null)
+					res_data.Write((byte []) tbn.Value);
+				else if (type==typeof(Byte)) {
+					res_data.Write((byte) PredefinedResourceType.Byte);
+					res_data.Write((Byte)res_enum.Value);
+				} else if (type==typeof(Decimal)) {
+					res_data.Write((byte) PredefinedResourceType.Decimal);
+					res_data.Write((Decimal)res_enum.Value);
+				} else if (type==typeof(DateTime)) {
+					res_data.Write((byte) PredefinedResourceType.DateTime);
+					res_data.Write(((DateTime)res_enum.Value).Ticks);
+				} else if (type==typeof(Double)) {
+					res_data.Write((byte) PredefinedResourceType.Double);
+					res_data.Write((Double)res_enum.Value);
+				} else if (type==typeof(Int16)) {
+					res_data.Write((byte) PredefinedResourceType.Int16);
+					res_data.Write((Int16)res_enum.Value);
+				} else if (type==typeof(Int32)) {
+					res_data.Write((byte) PredefinedResourceType.Int32);
+					res_data.Write((Int32)res_enum.Value);
+				} else if (type==typeof(Int64)) {
+					res_data.Write((byte) PredefinedResourceType.Int64);
+					res_data.Write((Int64)res_enum.Value);
+				} else if (type==typeof(SByte)) {
+					res_data.Write((byte) PredefinedResourceType.SByte);
+					res_data.Write((SByte)res_enum.Value);
+				} else if (type==typeof(Single)) {
+					res_data.Write((byte) PredefinedResourceType.Single);
+					res_data.Write((Single)res_enum.Value);
+				} else if (type==typeof(String)) {
+					res_data.Write((byte) PredefinedResourceType.String);
+					res_data.Write((String)res_enum.Value);
+				} else if (type==typeof(TimeSpan)) {
+					res_data.Write((byte) PredefinedResourceType.TimeSpan);
+					res_data.Write(((TimeSpan)res_enum.Value).Ticks);
+				} else if (type==typeof(UInt16)) {
+					res_data.Write((byte) PredefinedResourceType.UInt16);
+					res_data.Write((UInt16)res_enum.Value);
+				} else if (type==typeof(UInt32)) {
+					res_data.Write((byte) PredefinedResourceType.UInt32);
+					res_data.Write((UInt32)res_enum.Value);
+				} else if (type==typeof(UInt64)) {
+					res_data.Write((byte) PredefinedResourceType.UInt64);
+					res_data.Write((UInt64)res_enum.Value);
+				} else if (type==typeof(byte[])) {
+					res_data.Write((byte) PredefinedResourceType.ByteArray);
+					byte [] data = (byte[])res_enum.Value;
+					res_data.Write((uint) data.Length);
+					res_data.Write(data, 0, data.Length);
+				} else if (type==typeof(MemoryStream)) {
+					res_data.Write((byte) PredefinedResourceType.Stream);
+					byte [] data = ((MemoryStream)res_enum.Value).ToArray ();
+					res_data.Write((uint) data.Length);
+					res_data.Write(data, 0, data.Length);
+				} else {
+					/* non-intrinsic types are
+					 * serialized
+					 */
+					formatter.Serialize(res_data.BaseStream, res_enum.Value);
+				}
+#else
 				if(type==typeof(Byte)) {
 					res_data.Write((Byte)res_enum.Value);
 				} else if (type==typeof(Decimal)) {
@@ -265,6 +398,7 @@
 					 */
 					formatter.Serialize(res_data.BaseStream, res_enum.Value);
 				}
+#endif
 
 				count++;
 			}
@@ -276,13 +410,20 @@
 			
 			/* now do the ResourceReader header */
 
+#if NET_2_0
+			writer.Write(2);
+#else
 			writer.Write(1);
+#endif
 			writer.Write(resources.Count);
 			writer.Write(types.Count);
 
 			/* Write all of the unique types */
-			foreach(Type type in types) {
-				writer.Write(type.AssemblyQualifiedName);
+			foreach(object type in types) {
+				if (type is Type)
+					writer.Write(((Type) type).AssemblyQualifiedName);
+				else
+					writer.Write((string) type);
 			}
 
 			/* Pad the next fields (hash values) on an 8
@@ -328,6 +469,7 @@
 			writer.Flush();
 		}
 
+		// looks like it is (similar to) DJB hash
 		private int GetHash(string name)
 		{
 			uint hash=5381;
Index: System.Resources/UltimateResourceFallbackLocation.cs
===================================================================
--- System.Resources/UltimateResourceFallbackLocation.cs	(revision 77822)
+++ System.Resources/UltimateResourceFallbackLocation.cs	(working copy)
@@ -30,6 +30,8 @@
 #if NET_2_0
 namespace System.Resources
 {
+	[System.Runtime.InteropServices.ComVisible (true)]
+	[Serializable]
 	public enum UltimateResourceFallbackLocation {
 		MainAssembly = 0,
 		Satellite = 1
Index: System.Resources/MissingManifestResourceException.cs
===================================================================
--- System.Resources/MissingManifestResourceException.cs	(revision 77822)
+++ System.Resources/MissingManifestResourceException.cs	(working copy)
@@ -37,6 +37,9 @@
 {
 
 	[Serializable]
+#if NET_2_0
+	[System.Runtime.InteropServices.ComVisible (true)]
+#endif
 	public class MissingManifestResourceException: SystemException
 	{
 		private string param;
Index: System.Resources/ResourceReader.cs
===================================================================
--- System.Resources/ResourceReader.cs	(revision 77822)
+++ System.Resources/ResourceReader.cs	(working copy)
@@ -6,9 +6,10 @@
 //	Nick Drochak <ndrochak@gol.com>
 //	Dick Porter <dick@ximian.com>
 //	Marek Safar <marek.safar@seznam.cz>
+//	Atsushi Enomoto  <atsushi@ximian.com>
 //
 // (C) 2001, 2002 Ximian Inc, http://www.ximian.com
-// Copyright (C) 2004-2005 Novell, Inc (http://www.novell.com)
+// Copyright (C) 2004-2005,2007 Novell, Inc (http://www.novell.com)
 //
 // Permission is hereby granted, free of charge, to any person obtaining
 // a copy of this software and associated documentation files (the
@@ -34,6 +35,7 @@
 using System.Resources;
 using System.IO;
 using System.Text;
+using System.Runtime.InteropServices;
 using System.Runtime.Serialization;
 using System.Runtime.Serialization.Formatters.Binary;
 using System.Security.Permissions;
@@ -64,6 +66,9 @@
 		FistCustom	= 64
 	}
 
+#if NET_2_0
+	[System.Runtime.InteropServices.ComVisible (true)]
+#endif
 	public sealed class ResourceReader : IResourceReader, IEnumerable, IDisposable
 	{
 		BinaryReader reader;
@@ -179,7 +184,6 @@
 						throw new ArgumentException("Malformed .resources file (padding values incorrect)");
 					}
 				}
-
 				/* Read in the hash values for each
 				 * resource name.  These can be used
 				 * by ResourceSet (calling internal
@@ -303,7 +307,10 @@
 					return reader.ReadBytes (reader.ReadInt32 ());
 
 				case PredefinedResourceType.Stream:
-					throw new NotImplementedException (PredefinedResourceType.Stream.ToString ());
+					// FIXME: create pinned UnmanagedMemoryStream for efficiency.
+					byte [] bytes = new byte [reader.ReadUInt32 ()];
+					reader.Read (bytes, 0, bytes.Length);
+					return new MemoryStream (bytes);
 			}
 
 			type_index -= (int)PredefinedResourceType.FistCustom;
@@ -367,7 +374,7 @@
 			}
 			return obj;
 		}
-
+		
 		private object ResourceValue(int index)
 		{
 			lock(this)
@@ -398,6 +405,60 @@
 			}
 		}
 
+#if NET_2_0
+		internal UnmanagedMemoryStream ResourceValueAsStream (string name, int index)
+		{
+			lock(this)
+			{
+				long pos=positions[index]+nameSectionOffset;
+				reader.BaseStream.Seek(pos, SeekOrigin.Begin);
+
+				/* Read a 7-bit encoded byte length field */
+				long len=Read7BitEncodedInt();
+				/* ... and skip that data to the info
+				 * we want, the offset into the data
+				 * section
+				 */
+				reader.BaseStream.Seek(len, SeekOrigin.Current);
+
+				long data_offset=reader.ReadInt32();
+				reader.BaseStream.Seek(data_offset+dataSectionOffset, SeekOrigin.Begin);
+				int type_index=Read7BitEncodedInt();
+				if ((PredefinedResourceType)type_index != PredefinedResourceType.Stream)
+					throw new InvalidOperationException (String.Format ("Resource '{0}' was not a Stream. Use GetObject() instead.", name));
+
+				// here we return a Stream from exactly
+				// current position so that the returned
+				// Stream represents a single object stream.
+				long slen = reader.ReadInt32();
+				IntPtrStream basePtrStream = reader.BaseStream as IntPtrStream;
+				unsafe {
+					if (basePtrStream != null) {
+						byte* addr = (byte*) basePtrStream.BaseAddress.ToPointer ();
+						addr += basePtrStream.Position;
+						return new UnmanagedMemoryStream ((byte*) (void*) addr, slen);
+					} else {
+						IntPtr ptr = Marshal.AllocHGlobal ((int) slen);
+						byte* addr = (byte*) ptr.ToPointer ();
+						UnmanagedMemoryStream ms = new UnmanagedMemoryStream (addr, slen, slen, FileAccess.ReadWrite);
+						// The memory resource must be freed
+						// when the stream is disposed.
+						ms.Closed += delegate (object o, EventArgs e) {
+							Marshal.FreeHGlobal (ptr);
+						};
+						byte [] bytes = new byte [slen < 1024 ? slen : 1024];
+						for (int i = 0; i < slen; i += bytes.Length) {
+							int x = reader.Read (bytes, 0, bytes.Length);
+							ms.Write (bytes, 0, x);
+						}
+						ms.Seek (0, SeekOrigin.Begin);
+						return ms;
+					}
+				}
+			}
+		}
+#endif
+
 		public void Close ()
 		{
 			Dispose(true);
@@ -483,6 +544,19 @@
 				}
 			}
 			
+#if NET_2_0
+			public UnmanagedMemoryStream ValueAsStream
+			{
+				get {
+					if (reader.reader == null)
+						throw new InvalidOperationException("ResourceReader is closed.");
+					if (index < 0)
+						throw new InvalidOperationException("Enumeration has not started. Call MoveNext.");
+					return(reader.ResourceValueAsStream((string) Key, index));
+				}
+			}
+#endif
+			
 			public virtual object Current
 			{
 				get {
Index: Test/System.Resources/ResourceManagerTest.cs
===================================================================
--- Test/System.Resources/ResourceManagerTest.cs	(revision 77822)
+++ Test/System.Resources/ResourceManagerTest.cs	(working copy)
@@ -71,7 +71,52 @@
 			Assert.AreEqual ("Hello World", rm.GetObject ("HelloWorld"), "#02");
 		}
 
+#if NET_2_0
 		[Test]
+		[ExpectedException (typeof (InvalidOperationException))]
+		public void GetStreamOverNonStream ()
+		{
+			Thread.CurrentThread.CurrentUICulture = CultureInfo.InvariantCulture;
+			ResourceManager rm = ResourceManager.
+				CreateFileBasedResourceManager ("MyResources", "Test/resources", null);
+			UnmanagedMemoryStream s = rm.GetStream ("HelloWorld");
+			Assert.AreEqual (10, s.Length, "#1");
+			Assert.AreEqual ("Hello World", new StreamReader (s).ReadToEnd (), "#2");
+		}
+
+		[Test]
+		public void TestInvariantCultureStreamMissing ()
+		{
+			Thread.CurrentThread.CurrentUICulture = CultureInfo.InvariantCulture;
+			ResourceManager rm = ResourceManager.
+				CreateFileBasedResourceManager ("StreamTest", "Test/resources", null);
+			Assert.IsNull (rm.GetStream ("HelloWorld")); // no such resource
+		}
+
+		[Test]
+		public void TestInvariantCultureStream ()
+		{
+			Thread.CurrentThread.CurrentUICulture = CultureInfo.InvariantCulture;
+			ResourceManager rm = ResourceManager.
+				CreateFileBasedResourceManager ("StreamTest", "Test/resources", null);
+			UnmanagedMemoryStream s = rm.GetStream ("test");
+			Assert.AreEqual (22, s.Length, "#1");
+			Assert.AreEqual ("veritas vos liberabit\n", new StreamReader (s).ReadToEnd (), "#2");
+		}
+
+		[Test]
+		public void TestCustomCultureStream ()
+		{
+			Thread.CurrentThread.CurrentUICulture = CultureInfo.InvariantCulture;
+			ResourceManager rm = ResourceManager.
+				CreateFileBasedResourceManager ("StreamTest", "Test/resources", null);
+			UnmanagedMemoryStream s = rm.GetStream ("test", new CultureInfo ("ja-JP"));
+			Assert.AreEqual (22, s.Length, "#1");
+			Assert.AreEqual ("Veritas Vos Liberabit\n", new StreamReader (s).ReadToEnd (), "#2");
+		}
+#endif
+
+		[Test]
 		public void TestGermanCulture ()
 		{
 			Thread.CurrentThread.CurrentUICulture = new CultureInfo ("de-DE");
Index: System.IO/UnmanagedMemoryStream.cs
===================================================================
--- System.IO/UnmanagedMemoryStream.cs	(revision 77823)
+++ System.IO/UnmanagedMemoryStream.cs	(working copy)
@@ -54,6 +54,8 @@
 		long initial_position;
 		long current_position;
 		
+		internal event EventHandler Closed;
+		
 #region Constructor
 		protected UnmanagedMemoryStream()
 		{
@@ -272,8 +274,11 @@
 		 
 		protected override void Dispose (bool disposing)
 		{
-
+			if (closed)
+				return;
 			closed = true;
+			if (Closed != null)
+				Closed (this, null);
 		}
 		 
 		public override void Write (byte[] buffer, int offset, int count)
Index: System.IO/IntPtrStream.cs
===================================================================
--- System.IO/IntPtrStream.cs	(revision 77822)
+++ System.IO/IntPtrStream.cs	(working copy)
@@ -57,6 +57,14 @@
 			position = 0;
 		}
 
+		internal IntPtr BaseAddress {
+			get {
+				unsafe {
+					return new IntPtr ((void*) base_address);
+				}
+			}
+		}
+
 		public override bool CanRead {
 			get {
 				return true;