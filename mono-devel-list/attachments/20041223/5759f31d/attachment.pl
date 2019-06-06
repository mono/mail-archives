Index: System.Xml.Schema/ChangeLog
===================================================================
--- System.Xml.Schema/ChangeLog	(revision 38021)
+++ System.Xml.Schema/ChangeLog	(working copy)
@@ -1,3 +1,7 @@
+2004-12-22  Atsushi Enomoto <atsushi@ximian.com>
+
+	* XmlSchema.cs : XmlResolver.ResolveUri() may return null.
+
 2004-12-16  Atsushi Enomoto <atsushi@ximian.com>
 
 	* XmlSchemaValidator.cs : ValidateElement() was not LAMESPEC. Added
Index: System.Xml.Schema/XmlSchema.cs
===================================================================
--- System.Xml.Schema/XmlSchema.cs	(revision 38021)
+++ System.Xml.Schema/XmlSchema.cs	(working copy)
@@ -578,7 +578,8 @@
 			Uri baseUri = null;
 			if (this.SourceUri != null && this.SourceUri != String.Empty)
 				baseUri = new Uri (this.SourceUri);
-			return resolver.ResolveUri (baseUri, relativeUri).ToString ();
+			Uri abs = resolver.ResolveUri (baseUri, relativeUri);
+			return abs != null ? abs.ToString () : String.Empty;
 		}
 
 		internal bool IsNamespaceAbsent (string ns)
Index: System.Xml/ChangeLog
===================================================================
--- System.Xml/ChangeLog	(revision 38021)
+++ System.Xml/ChangeLog	(working copy)
@@ -1,3 +1,11 @@
+2004-12-22  Atsushi Enomoto <atsushi@ximian.com>
+
+	* XmlParserContext.cs : all the string properties must not be set as
+	  null. Thanks to Joshua.
+	* XmlTextReader.cs,
+	  DTDObjectModel.cs,
+	  DTDReader.cs : XmlResolver.ResolveUri() may return null.
+
 2004-12-17  Atsushi Enomoto <atsushi@ximian.com>
 
 	* XmlReaderBinarySupport.cs : added support class for base64/binhex
Index: System.Xml/XmlParserContext.cs
===================================================================
--- System.Xml/XmlParserContext.cs	(revision 38021)
+++ System.Xml/XmlParserContext.cs	(working copy)
@@ -162,16 +162,16 @@
 
 			this.namespaceManager = nsMgr != null ? nsMgr : new XmlNamespaceManager (nameTable);
 			if (dtd != null) {
-				this.docTypeName = dtd.Name;
-				this.publicID = dtd.PublicId;
-				this.systemID = dtd.SystemId;
-				this.internalSubset = dtd.InternalSubset;
+				this.DocTypeName = dtd.Name;
+				this.PublicId = dtd.PublicId;
+				this.SystemId = dtd.SystemId;
+				this.InternalSubset = dtd.InternalSubset;
 				this.dtd = dtd;
 			}
 			this.encoding = enc;
 
-			this.baseURI = baseURI;
-			this.xmlLang = xmlLang;
+			this.BaseURI = baseURI;
+			this.XmlLang = xmlLang;
 			this.xmlSpace = xmlSpace;
 
 			contextItems = new ArrayList ();
@@ -180,15 +180,15 @@
 
 		#region Fields
 
-		private string baseURI;
-		private string docTypeName;
+		private string baseURI = String.Empty;
+		private string docTypeName = String.Empty;
 		private Encoding encoding;
-		private string internalSubset;
+		private string internalSubset = String.Empty;
 		private XmlNamespaceManager namespaceManager;
 		private XmlNameTable nameTable;
-		private string publicID;
-		private string systemID;
-		private string xmlLang;
+		private string publicID = String.Empty;
+		private string systemID = String.Empty;
+		private string xmlLang = String.Empty;
 		private XmlSpace xmlSpace;
 		private ArrayList contextItems;
 		private int contextItemCount;
@@ -200,12 +200,12 @@
 
 		public string BaseURI {
 			get { return baseURI; }
-			set { baseURI = value; }
+			set { baseURI = value != null ? value : String.Empty; }
 		}
 
 		public string DocTypeName {
 			get { return docTypeName != null ? docTypeName : dtd != null ? dtd.Name : null; }
-			set { docTypeName = value; }
+			set { docTypeName = value != null ? value : String.Empty; }
 		}
 
 		internal DTDObjectModel Dtd {
@@ -220,7 +220,7 @@
 
 		public string InternalSubset {
 			get { return internalSubset != null ? internalSubset : dtd != null ? dtd.InternalSubset : null; }
-			set { internalSubset = value; }
+			set { internalSubset = value != null ? value : String.Empty; }
 		}
 
 		public XmlNamespaceManager NamespaceManager {
@@ -235,17 +235,17 @@
 
 		public string PublicId {
 			get { return publicID != null ? publicID : dtd != null ? dtd.PublicId : null; }
-			set { publicID = value; }
+			set { publicID = value != null ? value : String.Empty; }
 		}
 
 		public string SystemId {
 			get { return systemID != null ? systemID : dtd != null ? dtd.SystemId : null; }
-			set { systemID = value; }
+			set { systemID = value != null ? value : String.Empty; }
 		}
 
 		public string XmlLang {
 			get { return xmlLang; }
-			set { xmlLang = value; }
+			set { xmlLang = value != null ? value : String.Empty; }
 		}
 
 		public XmlSpace XmlSpace {
Index: System.Xml/XmlTextReader.cs
===================================================================
--- System.Xml/XmlTextReader.cs	(revision 38021)
+++ System.Xml/XmlTextReader.cs	(working copy)
@@ -98,12 +98,13 @@
 		public XmlTextReader (string url, XmlNameTable nt)
 		{
 			Uri uri = resolver.ResolveUri (null, url);
+			string uriString = uri != null ? uri.ToString () : String.Empty;
 			Stream s = resolver.GetEntity (uri, null, typeof (Stream)) as Stream;
 			XmlParserContext ctx = new XmlParserContext (nt,
 				new XmlNamespaceManager (nt),
 				String.Empty,
 				XmlSpace.None);
-			this.InitializeContext (uri.ToString(), ctx, new XmlStreamReader (s), XmlNodeType.Document);
+			this.InitializeContext (uriString, ctx, new XmlStreamReader (s), XmlNodeType.Document);
 		}
 
 		public XmlTextReader (TextReader input, XmlNameTable nt)
@@ -1307,32 +1308,41 @@
 			}
 
 			for (int i = 0; i < attributeCount; i++) {
-				if (Object.ReferenceEquals (attributeTokens [i].Prefix, XmlNamespaceManager.PrefixXml)) {
-					string aname = attributeTokens [i].LocalName;
-					string value = attributeTokens [i].Value;
-					switch (aname) {
-					case "base":
-						if (this.resolver != null)
-							parserContext.BaseURI = resolver.ResolveUri (new Uri (BaseURI), value).ToString ();
-						else
-							parserContext.BaseURI = value;
+				if (!Object.ReferenceEquals (attributeTokens [i].Prefix, XmlNamespaceManager.PrefixXml))
+					continue;
+				string aname = attributeTokens [i].LocalName;
+				string value = attributeTokens [i].Value;
+				switch (aname) {
+				case "base":
+					if (this.resolver != null) {
+						Uri buri =
+							BaseURI != String.Empty ?
+							new Uri (BaseURI) : null;
+						Uri uri = resolver.ResolveUri (
+							buri, value);
+						parserContext.BaseURI =
+							uri != null ?
+							uri.ToString () :
+							String.Empty;
+					}
+					else
+						parserContext.BaseURI = value;
+					break;
+				case "lang":
+					parserContext.XmlLang = value;
+					break;
+				case "space":
+					switch (value) {
+					case "preserve":
+						parserContext.XmlSpace = XmlSpace.Preserve;
 						break;
-					case "lang":
-						parserContext.XmlLang = value;
+					case "default":
+						parserContext.XmlSpace = XmlSpace.Default;
 						break;
-					case "space":
-						switch (value) {
-						case "preserve":
-							parserContext.XmlSpace = XmlSpace.Preserve;
-							break;
-						case "default":
-							parserContext.XmlSpace = XmlSpace.Default;
-							break;
-						default:
-							throw NotWFError (String.Format ("Invalid xml:space value: {0}", value));
-						}
-						break;
+					default:
+						throw NotWFError (String.Format ("Invalid xml:space value: {0}", value));
 					}
+					break;
 				}
 			}
 
Index: System.Xml/DTDObjectModel.cs
===================================================================
--- System.Xml/DTDObjectModel.cs	(revision 38021)
+++ System.Xml/DTDObjectModel.cs	(working copy)
@@ -1010,7 +1010,7 @@
 			}
 
 			Uri absUri = resolver.ResolveUri (baseUri, SystemId);
-			string absPath = absUri.ToString ();
+			string absPath = absUri != null ? absUri.ToString () : String.Empty;
 			if (Root.ExternalResources.ContainsKey (absPath))
 				LiteralEntityValue = (string) Root.ExternalResources [absPath];
 			Stream s = null;
Index: System.Xml/DTDReader.cs
===================================================================
--- System.Xml/DTDReader.cs	(revision 38021)
+++ System.Xml/DTDReader.cs	(working copy)
@@ -1604,7 +1604,7 @@
 			}
 
 			Uri absUri = DTD.Resolver.ResolveUri (baseUri, url);
-			string absPath = absUri.ToString ();
+			string absPath = absUri != null ? absUri.ToString () : String.Empty;
 
 			foreach (XmlParserInput i in parserInputStack.ToArray ()) {
 				if (i.BaseURI == absPath)
Index: Mono.Xml.Schema/XsdValidatingReader.cs
===================================================================
--- Mono.Xml.Schema/XsdValidatingReader.cs	(revision 38021)
+++ Mono.Xml.Schema/XsdValidatingReader.cs	(working copy)
@@ -215,6 +215,7 @@
 
 		// It is used only for independent XmlReader use, not for XmlValidatingReader.
 #if NET_2_0
+		[Obsolete]
 		public override object ReadTypedValue ()
 #else
 		public object ReadTypedValue ()
@@ -1507,9 +1508,10 @@
 		private XmlSchema ReadExternalSchema (string uri)
 		{
 			Uri absUri = resolver.ResolveUri ((BaseURI != "" ? new Uri (BaseURI) : null), uri);
+			string absUriString = absUri != null ? absUri.ToString () : String.Empty;
 			XmlTextReader xtr = null;
 			try {
-				xtr = new XmlTextReader (absUri.ToString (),
+				xtr = new XmlTextReader (absUriString,
 					(Stream) resolver.GetEntity (
 						absUri, null, typeof (Stream)),
 					NameTable);
Index: Mono.Xml.Schema/ChangeLog
===================================================================
--- Mono.Xml.Schema/ChangeLog	(revision 38021)
+++ Mono.Xml.Schema/ChangeLog	(working copy)
@@ -1,3 +1,7 @@
+2004-12-22  Atsushi Enomoto <atsushi@ximian.com>
+
+	* XsdValidatingReader.cs : XmlResolver.ResolveUri() may return null.
+
 2004-12-16  Atsushi Enomoto <atsushi@ximian.com>
 
 	* XsdValidatingReader.cs : added ActualSchemaType to context type.
Index: Mono.Xml.Xsl/ChangeLog
===================================================================
--- Mono.Xml.Xsl/ChangeLog	(revision 38021)
+++ Mono.Xml.Xsl/ChangeLog	(working copy)
@@ -1,3 +1,8 @@
+2004-12-22  Atsushi Enomoto <atsushi@ximian.com>
+
+	* XslFunction.cs,
+	  Compiler.cs : XmlResolver.ResolveUri() may return null.
+
 2004-12-01  Atsushi Enomoto  <atsushi@ximian.com>
 
 	* Compiler.cs : XPathNavigatorNsm needed more love. Clone() does not
Index: Mono.Xml.Xsl/Compiler.cs
===================================================================
--- Mono.Xml.Xsl/Compiler.cs	(revision 38021)
+++ Mono.Xml.Xsl/Compiler.cs	(working copy)
@@ -195,10 +195,11 @@
 			// todo: detect recursion
 			Uri baseUriObj = (Input.BaseURI == String.Empty) ? null : new Uri (Input.BaseURI);
 			Uri absUri = res.ResolveUri (baseUriObj, url);
+			string absUriString = absUri != null ? absUri.ToString () : String.Empty;
 			using (Stream s = (Stream)res.GetEntity (absUri, null, typeof(Stream)))
 			{
 
-				XmlValidatingReader vr = new XmlValidatingReader (new XmlTextReader (absUri.ToString (), s, nsMgr.NameTable));
+				XmlValidatingReader vr = new XmlValidatingReader (new XmlTextReader (absUriString, s, nsMgr.NameTable));
 				vr.ValidationType = ValidationType.None;
 				XPathNavigator n = new XPathDocument (vr, XmlSpace.Preserve).CreateNavigator ();
 				vr.Close ();
Index: Mono.Xml.Xsl/XslFunctions.cs
===================================================================
--- Mono.Xml.Xsl/XslFunctions.cs	(revision 38021)
+++ Mono.Xml.Xsl/XslFunctions.cs	(working copy)
@@ -237,7 +237,8 @@
 //			Debug.WriteLine ("THIS: " + thisUri);
 //			Debug.WriteLine ("BASE: " + baseUri);
 			XmlResolver r = p.Resolver;
-			
+			if (r == null)
+				return null;
 			Uri uriBase = null;
 			if (! object.ReferenceEquals (baseUri, VoidBaseUriFlag) && baseUri != String.Empty)
 				uriBase = r.ResolveUri (null, baseUri);
@@ -254,7 +255,7 @@
 				Uri uri = Resolve (itr.Current.Value, baseUri != null ? baseUri : /*itr.Current.BaseURI*/doc.BaseURI, xsltContext.Processor);
 				if (!got.ContainsKey (uri)) {
 					got.Add (uri, null);
-					if (uri.ToString () == "") {
+					if (uri != null && uri.ToString () == "") {
 						XPathNavigator n = doc.Clone ();
 						n.MoveToRoot ();
 						list.Add (n);
@@ -270,7 +271,7 @@
 		{
 			Uri uri = Resolve (arg0, baseUri != null ? baseUri : doc.BaseURI, xsltContext.Processor);
 			XPathNavigator n;
-			if (uri.ToString () == "") {
+			if (uri != null && uri.ToString () == "") {
 				n = doc.Clone ();
 				n.MoveToRoot ();
 			} else
