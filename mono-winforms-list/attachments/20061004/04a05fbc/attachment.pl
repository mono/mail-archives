Index: System.Resources/ChangeLog
===================================================================
--- System.Resources/ChangeLog	(revision 66181)
+++ System.Resources/ChangeLog	(working copy)
@@ -1,3 +1,14 @@
+2006-10-03  Robert Jordan  <robertj@gmx.net>
+
+	* ResXResourceReader.cs: Factored out parse_data_node () from load_data ()
+	to be able to correctly handle data nodes that occur before resheader.
+	Fixed handling of objects that have a byte[] converter.
+
+	* ResXResourceWriter.cs: Fixed AddResource (string, object) to support
+	only serializable type, matching MS.
+	Fixed WriteBytes to not emit the mimetype attribute when the
+	type is byte[], otherwise MS.NET won't parse correctly.
+
 2006-10-02  Sebastien Pouliot  <sebastien@ximian.com>
 
 	* ResXResourceReader.cs: Handle empty mimetype just like a null 
Index: System.Resources/ResXResourceReader.cs
===================================================================
--- System.Resources/ResXResourceReader.cs	(revision 66181)
+++ System.Resources/ResXResourceReader.cs	(working copy)
@@ -180,11 +180,7 @@
 					/* resheader apparently can appear anywhere, so we collect
 					 * the data even if we haven't validated yet.
 					 */
-					string n = get_attr (reader, "name");
-					if (n != null) {
-						string v = get_value (reader, "value");
-						hasht [n] = v;
-					}
+					parse_data_node ();
 				}
 			}
 			return gotmime;
@@ -193,51 +189,66 @@
 		private void load_data ()
 		{
 			while (reader.Read ()) {
-				if (reader.NodeType == XmlNodeType.Element && String.Compare (reader.Name, "data", true) == 0) {
-					string n = get_attr (reader, "name");
-					string t = get_attr (reader, "type");
-					string mt = get_attr (reader, "mimetype");
+				if (reader.NodeType == XmlNodeType.Element && String.Compare (reader.Name, "data", true) == 0)
+					parse_data_node ();
 
-					Type tt = t == null ? null : Type.GetType (t);
+			}
+		}
 
-					if (t != null && tt == null) {
-						throw new SystemException ("The type `" + t +"' could not be resolved");
-					}
-					if (tt == typeof (ResXNullRef)) {
-						hasht [n] = null;
-						continue;
-					}
-					if (n != null) {
-						object v = null;
-						string val = get_value (reader, "value");
+		void parse_data_node ()
+		{
+			string name = get_attr (reader, "name");
+			string type_name = get_attr (reader, "type");
+			string mime_type = get_attr (reader, "mimetype");
 
-						if ((mt != null) && (mt.Length > 0) && (tt != null)) {
-							TypeConverter c = TypeDescriptor.GetConverter (tt);
-							v = c.ConvertFrom (Convert.FromBase64String (val));
-						} else if (tt != null) {
-							// MS seems to handle Byte[] without any mimetype :-(
-							if (t.StartsWith("System.Byte[], mscorlib")) {
-								v = Convert.FromBase64String(val);
-							} else {
-								TypeConverter c = TypeDescriptor.GetConverter (tt);
-								v = c.ConvertFromInvariantString (val);
-							}
-						} else if ((mt != null) && (mt.Length > 0)) {
-							byte [] data = Convert.FromBase64String (val);
-							BinaryFormatter f = new BinaryFormatter ();
-							using (MemoryStream s = new MemoryStream (data)) {
-								v = f.Deserialize (s);
-							}
-						} else {
-							v = val;
-						}
-						hasht [n] = v;
+			if (name == null)
+				return;
+
+			Type type = type_name == null ? null : ResolveType (type_name);
+
+			if (type_name != null && type == null)
+				throw new ArgumentException (String.Format (
+					"The type '{0}' of the element '{1}' could not be resolved.", type_name, name));
+
+			if (type == typeof (ResXNullRef)) {
+				hasht [name] = null;
+				return;
+			}
+
+			string value = get_value (reader, "value");
+			object obj = null;
+
+			if (type != null) {
+				TypeConverter c = TypeDescriptor.GetConverter (type);
+
+				if (c == null) {
+					obj = null;
+				} else if (c.CanConvertFrom (typeof (string))) {
+					obj = c.ConvertFromInvariantString (value);
+				} else if (c.CanConvertFrom (typeof (byte[]))) {
+					obj = c.ConvertFrom (Convert.FromBase64String (value));
+				} else {
+					// the type must be a byte[]
+					obj  = Convert.FromBase64String(value);
+				}
+			} else if (mime_type != null && mime_type != String.Empty) {
+				if (mime_type == ResXResourceWriter.BinSerializedObjectMimeType) {
+					byte [] data = Convert.FromBase64String (value);
+					BinaryFormatter f = new BinaryFormatter ();
+					using (MemoryStream s = new MemoryStream (data)) {
+						obj = f.Deserialize (s);
 					}
+				} else {
+					// invalid mime type
+					obj = null;
 				}
+			} else {
+				obj = value;
 			}
+			hasht [name] = obj;
 		}
 
-		private Type GetType(string type) {
+		private Type ResolveType (string type) {
 			if (typeresolver == null) {
 				return Type.GetType(type);
 			} else {
Index: System.Resources/ResXResourceWriter.cs
===================================================================
--- System.Resources/ResXResourceWriter.cs	(revision 66181)
+++ System.Resources/ResXResourceWriter.cs	(working copy)
@@ -138,18 +138,21 @@
 			writer.WriteString(sb.ToString());
 		}
 
-		void WriteBytes (string name, string typename, byte [] value, int offset, int length)
+		void WriteBytes (string name, Type type, byte [] value, int offset, int length)
 		{
 			writer.WriteStartElement ("data");
 			writer.WriteAttributeString ("name", name);
 
-			if (typename != null) {
-				writer.WriteAttributeString ("type", typename);
+			if (type != null) {
+				writer.WriteAttributeString ("type", type.AssemblyQualifiedName);
+                                // byte[] should never get a mimetype, otherwise MS.NET won't be able
+                                // to parse the data.
+                                if (type != typeof (byte[]))
+                                    writer.WriteAttributeString ("mimetype", ByteArraySerializedObjectMimeType);
 				writer.WriteStartElement ("value");
 				WriteNiceBase64(value, offset, length);
 			} else {
-				writer.WriteAttributeString ("mimetype",
-						"application/x-microsoft.net.object.binary.base64");
+				writer.WriteAttributeString ("mimetype", BinSerializedObjectMimeType);
 				writer.WriteStartElement ("value");
 				writer.WriteBase64 (value, offset, length);
 			}
@@ -158,9 +161,9 @@
 			writer.WriteEndElement ();
 		}
 
-		void WriteBytes (string name, string typename, byte [] value)
+		void WriteBytes (string name, Type type, byte [] value)
 		{
-			WriteBytes (name, typename, value, 0, value.Length);
+			WriteBytes (name, type, value, 0, value.Length);
 		}
 
 		void WriteString (string name, string value)
@@ -168,12 +171,12 @@
                         WriteString (name, value, null);
 		}
 
-		void WriteString (string name, string value, string typename)
+		void WriteString (string name, string value, Type type)
 		{
 			writer.WriteStartElement ("data");
 			writer.WriteAttributeString ("name", name);
-                        if (typename != null)
-                                writer.WriteAttributeString ("type", typename);
+                        if (type != null)
+                                writer.WriteAttributeString ("type", type.AssemblyQualifiedName);
 			writer.WriteStartElement ("value");
 			writer.WriteString (value);
 			writer.WriteEndElement ();
@@ -195,7 +198,7 @@
 			if (writer == null)
 				InitWriter ();
 
-			WriteBytes (name, value.GetType ().AssemblyQualifiedName, value);
+			WriteBytes (name, value.GetType (), value);
 		}
 
 		public void AddResource (string name, object value)
@@ -216,6 +219,9 @@
 			if (value == null)
 				throw new ArgumentNullException ("value");
 
+                        if (!value.GetType ().IsSerializable)
+                                throw new InvalidOperationException (String.Format ("The element '{0}' of type '{1}' is not serializable.", name, value.GetType ().Name));
+
 			if (written)
 				throw new InvalidOperationException ("The resource is already generated.");
 
@@ -225,13 +231,13 @@
 			TypeConverter converter = TypeDescriptor.GetConverter (value);
 			if (converter != null && converter.CanConvertTo (typeof (string)) && converter.CanConvertFrom (typeof (string))) {
 				string str = (string) converter.ConvertToInvariantString (value);
-				WriteString (name, str, value.GetType ().AssemblyQualifiedName);
+				WriteString (name, str, value.GetType ());
 				return;
 			}
 			
 			if (converter != null && converter.CanConvertTo (typeof (byte[])) && converter.CanConvertFrom (typeof (byte[]))) {
 				byte[] b = (byte[]) converter.ConvertTo (value, typeof (byte[]));
-				WriteBytes (name, value.GetType().AssemblyQualifiedName, b);
+				WriteBytes (name, value.GetType (), b);
 				return;
 			}
 			
