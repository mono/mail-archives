Index: ChangeLog
===================================================================
RCS file: /cvs/public/mcs/class/System.Data/System.Data/ChangeLog,v
retrieving revision 1.122
diff -u -r1.122 ChangeLog
--- ChangeLog	7 Apr 2004 06:46:47 -0000	1.122
+++ ChangeLog	13 Apr 2004 03:37:40 -0000
@@ -1,3 +1,17 @@
+2004-04-13  Atsushi Enomoto  <atsushi@ximian.com>
+
+	* DataSet.cs :
+	  - InferXmlSchema(): Throw explicit NotImplementedException now.
+	  - Don't put XML declaration everywhere. Write just for filename arg.
+	  - xmlns="" should not be written. Maybe WebService problem is 
+	    because default namespace is overwritten. This patch will keep
+	    the WS problem away and actually fixes some unit tests (i.e. use
+	    explicit String.Empty for null namespace in WriteStartElement()).
+	  - MoveToContent() should always be called, not only when 
+	    LocalName="xml". It will ignore prolog (DTD, PI, comment etc.).
+	  - Even XmlReadMode is DiffGram, reader might not be "diffgram"
+	    element. As to MSDN, diffgram does not contain schema.
+
 2004-04-07  Marek Safar  <marek.safar@seznam.cz>
 
 	* Constraint.cs: changed ClsCompliant to CLSCompliant, build fix.
Index: DataSet.cs
===================================================================
RCS file: /cvs/public/mcs/class/System.Data/System.Data/DataSet.cs,v
retrieving revision 1.70
diff -u -r1.70 DataSet.cs
--- DataSet.cs	2 Apr 2004 05:54:58 -0000	1.70
+++ DataSet.cs	13 Apr 2004 03:37:41 -0000
@@ -8,6 +8,7 @@
 //   Stuart Caborn <stuart.caborn@virgin.net>
 //   Tim Coleman (tim@timcoleman.com)
 //   Ville Palo <vi64pa@koti.soon.fi>
+//   Atsushi Enomoto <atsushi@ximian.com>
 //
 // (C) Ximian, Inc. 2002
 // Copyright (C) Tim Coleman, 2002, 2003
@@ -478,7 +479,7 @@
 			StringWriter Writer = new StringWriter ();
 
 			// Sending false for not printing the Processing instruction
-			WriteXml (Writer, XmlWriteMode.IgnoreSchema, false);
+			WriteXml (Writer, XmlWriteMode.IgnoreSchema);
 			return Writer.ToString ();
 		}
 
@@ -522,6 +523,7 @@
 		[MonoTODO]
 		public void InferXmlSchema (XmlReader reader, string[] nsArray)
 		{
+			throw new NotImplementedException ();
 		}
 
 		public void InferXmlSchema (Stream stream, string[] nsArray)
@@ -604,11 +606,12 @@
 		{
 			XmlTextWriter writer = new XmlTextWriter (fileName, null);
 			writer.Formatting = Formatting.Indented;
-			
+			writer.WriteStartDocument ();
 			try {
 				WriteXml (writer);
 			}
 			finally {
+				writer.WriteEndDocument ();
 				writer.Close ();
 			}
 		}
@@ -622,18 +625,20 @@
 
 		public void WriteXml (XmlWriter writer)
 		{
-			WriteXml (writer, XmlWriteMode.IgnoreSchema, true);
+			WriteXml (writer, XmlWriteMode.IgnoreSchema);
 		}
 
 		public void WriteXml (string filename, XmlWriteMode mode)
 		{
 			XmlTextWriter writer = new XmlTextWriter (filename, null);
 			writer.Formatting = Formatting.Indented;
+			writer.WriteStartDocument ();
 			
 			try {
-				WriteXml (writer, mode, true);
+				WriteXml (writer, mode);
 			}
 			finally {
+				writer.WriteEndDocument ();
 				writer.Close ();
 			}
 		}
@@ -642,67 +647,26 @@
 		{
 			XmlTextWriter writer = new XmlTextWriter (stream, null);
 			writer.Formatting = Formatting.Indented;
-			WriteXml (writer, mode, true);
+			WriteXml (writer, mode);
 		}
 
 		public void WriteXml (TextWriter writer, XmlWriteMode mode)
 		{
 			XmlTextWriter xwriter = new XmlTextWriter (writer);
 			xwriter.Formatting = Formatting.Indented;
-			WriteXml (xwriter, mode, true);
+			WriteXml (xwriter, mode);
 		}
 
 		public void WriteXml (XmlWriter writer, XmlWriteMode mode)
 		{
-			WriteXml (writer, mode, true);
-		}
-		
-		internal void WriteXml (Stream stream, XmlWriteMode mode, bool writePI)
-		{
-			XmlTextWriter writer = new XmlTextWriter (stream, null);
-			writer.Formatting = Formatting.Indented;
-			WriteXml (writer, mode, writePI);
-		}
-
-		internal void WriteXml (string fileName, XmlWriteMode mode, bool writePI)
-		{
-			XmlTextWriter writer = new XmlTextWriter (fileName, null);
-			writer.Formatting = Formatting.Indented;
-			
-			try {
-				WriteXml (writer, mode, writePI);
-			}
-			finally {
-				writer.Close ();
-			}
-		}
-
-		internal void WriteXml (TextWriter writer, XmlWriteMode mode, bool writePI)
-		{
-			XmlTextWriter xwriter = new XmlTextWriter (writer);
-			xwriter.Formatting = Formatting.Indented;
-			WriteXml (xwriter, mode, writePI);
-		}
-
-		internal void WriteXml (XmlWriter writer, XmlWriteMode mode, bool writePI)
-		{
-			if (writePI && (writer.WriteState == WriteState.Start))
-				writer.WriteStartDocument (true);
-
 			if (mode == XmlWriteMode.DiffGram) {
 				SetRowsID();
 				WriteDiffGramElement(writer);
 			}
-			
-			WriteStartElement (writer, mode, Namespace, Prefix, XmlConvert.EncodeName (DataSetName));
-			
-			/*********************************************************
-			 * This is a patch for interoperability with ms.net.     *
-			 * Because in web services the .net client expects this  *
-			 * atrribute even if namespace is an empty string        *
-			 ********************************************************/
-			if (Namespace == null || Namespace.Length == 0)
-				WriteAttributeString (writer, mode, null, null, "xmlns", Namespace);
+
+			string ns = Namespace == null ? String.Empty : Namespace;
+
+			WriteStartElement (writer, mode, ns, Prefix, XmlConvert.EncodeName (DataSetName));
 			
 			if (mode == XmlWriteMode.WriteSchema) {
 				DoWriteXmlSchema (writer);
@@ -733,10 +697,12 @@
 		{
 			XmlTextWriter writer = new XmlTextWriter (fileName, null);
 			writer.Formatting = Formatting.Indented;
+			writer.WriteStartDocument ();
 			try {
 				WriteXmlSchema (writer);
 			}
 			finally {
+				writer.WriteEndDocument ();
 				writer.Close ();
 			}
 		}
@@ -752,10 +718,7 @@
 		{
 			//Create a skeleton doc and then write the schema 
 			//proper which is common to the WriteXml method in schema mode
-			writer.WriteStartDocument ();
 			DoWriteXmlSchema (writer);
-			
-			writer.WriteEndDocument ();
 		}
 
 		public void ReadXmlSchema (Stream stream)
@@ -810,15 +773,12 @@
 
 		public XmlReadMode ReadXml (XmlReader r)
 		{
-			XmlDataLoader Loader = new XmlDataLoader (this);
 			// FIXME: somekinda exception?
 			if (!r.Read ())
 				return XmlReadMode.Auto; // FIXME
-			
-			// Check if the curent element is the process instruction (PI).
-			// if it is move to next element.
-			if (r.LocalName == "xml")
-				r.MoveToContent();
+
+			// Skip XML declaration and prolog
+			r.MoveToContent();
 
 			// The document can be diffgram if :
 			// 1. The first element is diffgram.
@@ -904,18 +864,18 @@
 			// we have to initiate the reader.
 			if (reader.ReadState == ReadState.Initial)
 				reader.Read();
-			
-			// Check if the curent element is the process instruction (PI).
-			// if it is move to next element.
-			if (reader.LocalName == "xml")
-				reader.MoveToContent();
+
+			// Skip XML declaration and prolog
+			reader.MoveToContent();
 
 			XmlReadMode Result = XmlReadMode.Auto;
 
 			if (mode == XmlReadMode.DiffGram) {
+#if false
 				if (reader.LocalName != "diffgram"){
 					reader.MoveToContent ();
 					reader.ReadStartElement ();	// <DataSet>
+					DataSetName = reader.LocalName;
 
 					reader.MoveToContent ();
 					if (reader.LocalName == "schema")
@@ -923,9 +883,18 @@
 
 					reader.MoveToContent ();
 				}
-				XmlDiffLoader DiffLoader = new XmlDiffLoader (this);
-				DiffLoader.Load (reader);
-				Result =  XmlReadMode.DiffGram;
+				XmlDiffLoader DiffLoader = new XmlDiffLoader (this);
+				DiffLoader.Load (reader);
+				Result =  XmlReadMode.DiffGram;
+#else
+				if (reader.LocalName == "diffgram" && reader.NamespaceURI == XmlConstants.DiffgrNamespace) {
+					XmlDiffLoader DiffLoader = new XmlDiffLoader (this);
+					DiffLoader.Load (reader);
+					Result =  XmlReadMode.DiffGram;
+				}
+				else
+					Result = ReadXml (reader, XmlReadMode.Auto, true);
+#endif
 			}
 			else 
 				Result = ReadXml(reader, mode, true);
@@ -1030,7 +999,7 @@
 		void IXmlSerializable.WriteXml (XmlWriter writer)
 		{
 			DoWriteXmlSchema (writer);
-			WriteXml (writer, XmlWriteMode.DiffGram, true);
+			WriteXml (writer, XmlWriteMode.DiffGram);
 		}
 
 		protected virtual bool ShouldSerializeRelations ()
@@ -1244,15 +1213,7 @@
 		    
 		private void WriteStartElement (XmlWriter writer, XmlWriteMode mode, string nspc, string prefix, string name)
 		{
-			if (nspc == null || nspc == "") {
-				writer.WriteStartElement (name);
-			}
-			else if (prefix != null) {
-				writer.WriteStartElement (prefix, name, nspc);
-			}
-			else {
-				writer.WriteStartElement (writer.LookupPrefix (nspc), name, nspc);
-			}
+			writer.WriteStartElement (prefix, name, nspc);
 		}
 		
 		private void WriteAttributeString (XmlWriter writer, XmlWriteMode mode, string nspc, string prefix, string name, string stringValue)