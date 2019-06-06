Index: System.Data/DataSet.cs
===================================================================
--- System.Data/DataSet.cs	(revision 45319)
+++ System.Data/DataSet.cs	(working copy)
@@ -880,219 +880,171 @@
 
 		// LAMESPEC: XmlReadMode.Fragment is far from presisely
 		// documented. MS.NET infers schema against this mode.
-		public XmlReadMode ReadXml (XmlReader input, XmlReadMode mode)
-		{
-			switch (input.ReadState) {
-			case ReadState.EndOfFile:
-			case ReadState.Error:
-			case ReadState.Closed:
+		public XmlReadMode ReadXml (XmlReader reader, XmlReadMode mode) {
+			if (reader == null)
 				return mode;
+
+			switch (reader.ReadState) {
+				case ReadState.EndOfFile:
+				case ReadState.Error:
+				case ReadState.Closed:
+					return mode;
 			}
+
 			// Skip XML declaration and prolog
-			input.MoveToContent ();
-			if (input.EOF)
+			reader.MoveToContent();
+			if (reader.EOF)
 				return mode;
 
-			// FIXME: We need more decent code here, but for now
-			// I don't know the precise MS.NET behavior, I just
-			// delegate to specific read process.
-			switch (mode) {
-			case XmlReadMode.IgnoreSchema:
-				return ReadXmlIgnoreSchema (input, mode, true);
-			case XmlReadMode.ReadSchema:
-				return ReadXmlReadSchema (input, mode, true);
+			if (reader is XmlTextReader) {
+				((XmlTextReader) reader).WhitespaceHandling = WhitespaceHandling.None;
 			}
-			// remaining modes are: Auto, InferSchema, Fragment, Diffgram
 
-			XmlReader reader = input;
+			XmlReadMode Result = mode;
+			XmlDiffLoader DiffLoader = null;
 
-			int depth = reader.Depth;
-			XmlReadMode result = mode;
-			bool skippedTopLevelElement = false;
-			string potentialDataSetName = null;
-			XmlDocument doc = null;
-			bool shouldReadData = mode != XmlReadMode.DiffGram;
-			bool shouldNotInfer = Tables.Count > 0;
-
-			switch (mode) {
-			case XmlReadMode.Auto:
-			case XmlReadMode.InferSchema:
-				doc = new XmlDocument ();
-				do {
-					doc.AppendChild (doc.ReadNode (reader));
-				} while (!reader.EOF &&
-					doc.DocumentElement == null);
-				reader = new XmlNodeReader (doc);
-				reader.MoveToContent ();
-				break;
-			case XmlReadMode.DiffGram:
-				if (!(reader.LocalName == "diffgram" &&
-					reader.NamespaceURI == XmlConstants.DiffgrNamespace))
-					goto case XmlReadMode.Auto;
-				break;
-			}
-
-			switch (mode) {
-			case XmlReadMode.Auto:
-			case XmlReadMode.InferSchema:
-			case XmlReadMode.ReadSchema:
-				if (!(reader.LocalName == "diffgram" &&
-					reader.NamespaceURI == XmlConstants.DiffgrNamespace) &&
-					!(reader.LocalName == "schema" &&
-					reader.NamespaceURI == XmlSchema.Namespace))
-					potentialDataSetName = reader.LocalName;
-				goto default;
-			case XmlReadMode.Fragment:
-				break;
-			default:
-				if (!(reader.LocalName == "diffgram" &&
-					reader.NamespaceURI == XmlConstants.DiffgrNamespace) &&
-					!(reader.LocalName == "schema" &&
-					reader.NamespaceURI == XmlSchema.Namespace)) {
-					if (!reader.IsEmptyElement) {
-						reader.Read ();
-						reader.MoveToContent ();
-						skippedTopLevelElement = true;
-					}
-					else {
-						switch (mode) {
-						case XmlReadMode.Auto:
-						case XmlReadMode.InferSchema:
-							DataSetName = reader.LocalName;
-							break;
-						}
-						reader.Read ();
-					}
+			// If diffgram, then read the first element as diffgram 
+			if (reader.LocalName == "diffgram" && reader.NamespaceURI == XmlConstants.DiffgrNamespace) {
+				switch (mode) {
+					case XmlReadMode.Auto:
+					case XmlReadMode.DiffGram:
+						if (DiffLoader == null)
+							DiffLoader = new XmlDiffLoader (this);
+						DiffLoader.Load (reader);
+						// (and leave rest of the reader as is)
+						return  XmlReadMode.DiffGram;
+					case XmlReadMode.Fragment:
+						reader.Skip ();
+						// (and continue to read)
+						break;
+					default:
+						reader.Skip ();
+						// (and leave rest of the reader as is)
+						return mode;
 				}
-				break;
 			}
-
 			// If schema, then read the first element as schema 
 			if (reader.LocalName == "schema" && reader.NamespaceURI == XmlSchema.Namespace) {
-				shouldNotInfer = true;
 				switch (mode) {
-				case XmlReadMode.IgnoreSchema:
-				case XmlReadMode.InferSchema:
-					reader.Skip ();
-					break;
-				case XmlReadMode.Fragment:
-					ReadXmlSchema (reader);
-					break;
-				case XmlReadMode.DiffGram:
-				case XmlReadMode.Auto:
-					if (Tables.Count == 0) {
-						ReadXmlSchema (reader);
-						if (mode == XmlReadMode.Auto)
-							result = XmlReadMode.ReadSchema;
-					} else {
-					// otherwise just ignore and return IgnoreSchema
+					case XmlReadMode.IgnoreSchema:
+					case XmlReadMode.InferSchema:
 						reader.Skip ();
-						result = XmlReadMode.IgnoreSchema;
-					}
-					break;
-				case XmlReadMode.ReadSchema:
-					ReadXmlSchema (reader);
-					break;
+						// (and break up read)
+						return mode;
+					case XmlReadMode.Fragment:
+						ReadXmlSchema (reader);
+						// (and continue to read)
+						break;
+					case XmlReadMode.Auto:
+						if (Tables.Count == 0) {
+							ReadXmlSchema (reader);
+							return XmlReadMode.ReadSchema;
+						} else {
+							// otherwise just ignore and return IgnoreSchema
+							reader.Skip ();
+							return XmlReadMode.IgnoreSchema;
+						}
+					default:
+						ReadXmlSchema (reader);
+						// (and leave rest of the reader as is)
+						return mode; // When DiffGram, return DiffGram
 				}
 			}
 
-			// If diffgram, then read the first element as diffgram 
-			if (reader.LocalName == "diffgram" && reader.NamespaceURI == XmlConstants.DiffgrNamespace) {
-				switch (mode) {
-				case XmlReadMode.Auto:
-				case XmlReadMode.IgnoreSchema:
-				case XmlReadMode.DiffGram:
-					XmlDiffLoader DiffLoader = new XmlDiffLoader (this);
-					DiffLoader.Load (reader);
-					if (mode == XmlReadMode.Auto)
-						result = XmlReadMode.DiffGram;
-					shouldReadData = false;
-					break;
-				case XmlReadMode.Fragment:
-					reader.Skip ();
-					break;
-				default:
-					reader.Skip ();
-					break;
+			int depth = (reader.NodeType == XmlNodeType.Element) ? reader.Depth : -1;
+
+			XmlDocument doc = new XmlDocument ();
+			XmlElement root = doc.CreateElement(reader.Prefix, reader.LocalName, reader.NamespaceURI);
+			if (reader.HasAttributes) {
+				for (int i = 0; i < reader.AttributeCount; i++) {
+					reader.MoveToAttribute(i);
+					if (reader.NamespaceURI == XmlConstants.XmlnsNS)
+						root.SetAttribute(reader.Name, reader.GetAttribute(i));
+					else {
+						XmlAttribute attr = root.SetAttributeNode(reader.LocalName, reader.NamespaceURI);
+						attr.Prefix = reader.Prefix;
+						attr.Value = reader.GetAttribute(i);
+					}
 				}
 			}
 
-			// if schema after diffgram, just skip it.
-			if (!shouldReadData && reader.LocalName == "schema" && reader.NamespaceURI == XmlSchema.Namespace) {
-				shouldNotInfer = true;
-				switch (mode) {
-				default:
-					reader.Skip ();
+			reader.Read();
+			XmlReadMode retMode = mode;
+			bool schemaLoaded = false;
+
+			for (;;) {
+				if( reader.Depth == depth ||
+					reader.NodeType == XmlNodeType.EndElement)
 					break;
-				case XmlReadMode.ReadSchema:
-				case XmlReadMode.DiffGram:
-					if (Tables.Count == 0)
-						ReadXmlSchema (reader);
-					break;
+
+				if (reader.NodeType != XmlNodeType.Element) {
+					if (!reader.Read())
+						break;
+					continue;
 				}
-			}
 
-			if (reader.EOF)
-				return result == XmlReadMode.Auto ?
-					potentialDataSetName != null && !shouldNotInfer ?
-					XmlReadMode.InferSchema :
-					XmlReadMode.IgnoreSchema : result;
+				if (reader.LocalName == "schema" && reader.NamespaceURI == XmlSchema.Namespace) {
+					switch (mode) {
+						case XmlReadMode.IgnoreSchema:
+						case XmlReadMode.InferSchema:
+							reader.Skip ();
+							break;
+						
+						default:
+							ReadXmlSchema (reader);
+							retMode = XmlReadMode.ReadSchema;
+							schemaLoaded = true;
+							// (and leave rest of the reader as is)
+							break;
+					}
 
-			// Otherwise, read as dataset... but only when required.
-			if (shouldReadData && !shouldNotInfer) {
-				switch (mode) {
-				case XmlReadMode.Auto:
-					if (Tables.Count > 0)
-						goto case XmlReadMode.IgnoreSchema;
-					else
-						goto case XmlReadMode.InferSchema;
-				case XmlReadMode.InferSchema:
-					InferXmlSchema (doc, null);
-					if (mode == XmlReadMode.Auto)
-						result = XmlReadMode.InferSchema;
-					break;
-				case XmlReadMode.IgnoreSchema:
-				case XmlReadMode.Fragment:
-				case XmlReadMode.DiffGram:
-					break;
-				default:
-					shouldReadData = false;
-					break;
+					continue;
 				}
-			}
+	
+				if ((reader.LocalName == "diffgram") && (reader.NamespaceURI == XmlConstants.DiffgrNamespace)) {
+					if ((mode == XmlReadMode.DiffGram) || (mode == XmlReadMode.IgnoreSchema)
+						|| mode == XmlReadMode.Auto) {
+						if (DiffLoader == null)
+							DiffLoader = new XmlDiffLoader (this);
+						DiffLoader.Load (reader);
+						// (and leave rest of the reader as is)
+						retMode = XmlReadMode.DiffGram;
+					}
+					else
+						reader.Skip();
 
-			if (shouldReadData) {
-				XmlReader dataReader = reader;
-				if (doc != null) {
-					dataReader = new XmlNodeReader (doc);
-					dataReader.MoveToContent ();
+					continue;
 				}
-				if (reader.NodeType == XmlNodeType.Element)
-					XmlDataReader.ReadXml (this, dataReader,
-						mode);
+
+				//collect data
+				XmlNode n = doc.ReadNode(reader);
+				root.AppendChild(n);
 			}
 
-			if (skippedTopLevelElement) {
-				switch (result) {
-				case XmlReadMode.Auto:
-				case XmlReadMode.InferSchema:
-//					DataSetName = potentialDataSetName;
-//					result = XmlReadMode.InferSchema;
-					break;
-				}
+			if (mode == XmlReadMode.DiffGram) {
 				if (reader.NodeType == XmlNodeType.EndElement)
 					reader.ReadEndElement ();
+				return retMode;
 			}
-//*
-			while (input.Depth > depth)
-				input.Read ();
-			if (input.NodeType == XmlNodeType.EndElement)
-				input.Read ();
-//*/
-			input.MoveToContent ();
 
-			return result == XmlReadMode.Auto ?
-				XmlReadMode.IgnoreSchema : result;
+			doc.AppendChild(root);
+
+			if (!schemaLoaded &&
+				retMode != XmlReadMode.ReadSchema &&
+				mode != XmlReadMode.IgnoreSchema && mode != XmlReadMode.Fragment) {
+				// TODO : Fragment should not infer shcema
+				InferXmlSchema(doc, null);
+				if (mode == XmlReadMode.Auto)
+					retMode = XmlReadMode.InferSchema;
+			}
+
+			XmlNodeReader docReader = new XmlNodeReader (doc);
+			XmlDataReader.ReadXml (this, docReader, mode);
+
+			if (reader.NodeType == XmlNodeType.EndElement)
+				reader.ReadEndElement ();
+
+			return retMode;
 		}
 		#endregion // Public Methods
 
@@ -1166,7 +1118,7 @@
 		
 		protected virtual void ReadXmlSerializable (XmlReader reader)
 		{
-			ReadXml (reader);
+			ReadXml (reader, XmlReadMode.DiffGram);
 		}
 
 		void IXmlSerializable.ReadXml (XmlReader reader)
@@ -1224,58 +1176,6 @@
 
 		#region Private Methods
 
-		private XmlReadMode ReadXmlIgnoreSchema (XmlReader input, XmlReadMode mode, bool checkRecurse)
-		{
-			if (input.LocalName == "schema" &&
-				input.NamespaceURI == XmlSchema.Namespace) {
-				input.Skip ();
-			}
-			else if (input.LocalName == "diffgram" &&
-				input.NamespaceURI == XmlConstants.DiffgrNamespace) {
-				XmlDiffLoader DiffLoader = new XmlDiffLoader (this);
-				DiffLoader.Load (input);
-			}
-			else if (checkRecurse ||
-				input.LocalName == DataSetName &&
-				input.NamespaceURI == Namespace) {
-				XmlDataReader.ReadXml (this, input, mode);
-			}
-			else if (checkRecurse && !input.IsEmptyElement) {
-				int depth = input.Depth;
-				input.Read ();
-				input.MoveToContent ();
-				ReadXmlIgnoreSchema (input, mode, false);
-				while (input.Depth > depth)
-					input.Skip ();
-				if (input.NodeType == XmlNodeType.EndElement)
-					input.ReadEndElement ();
-			}
-			input.MoveToContent ();
-			return XmlReadMode.IgnoreSchema;
-		}
-
-		private XmlReadMode ReadXmlReadSchema (XmlReader input, XmlReadMode mode, bool checkRecurse)
-		{
-			if (input.LocalName == "schema" &&
-				input.NamespaceURI == XmlSchema.Namespace) {
-				ReadXmlSchema (input);
-			}
-			else if (checkRecurse && !input.IsEmptyElement) {
-				int depth = input.Depth;
-				input.Read ();
-				input.MoveToContent ();
-				ReadXmlReadSchema (input, mode, false);
-				while (input.Depth > depth)
-					input.Skip ();
-				if (input.NodeType == XmlNodeType.EndElement)
-					input.ReadEndElement ();
-			}
-			else
-				input.Skip ();
-			input.MoveToContent ();
-			return XmlReadMode.ReadSchema;
-		}
-
 		internal static string WriteObjectXml (object o)
 		{
 			switch (Type.GetTypeCode (o.GetType ())) {
