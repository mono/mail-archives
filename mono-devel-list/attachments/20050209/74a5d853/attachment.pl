diff -Naur ./Mono.Xml.Xsl/Compiler.cs ../monopatched/Mono.Xml.Xsl/Compiler.cs
--- ./Mono.Xml.Xsl/Compiler.cs	2005-02-06 17:27:15.000000000 +0200
+++ ../monopatched/Mono.Xml.Xsl/Compiler.cs	2005-02-06 17:35:05.000000000 +0200
@@ -468,12 +468,12 @@
 			XPathNavigator nav = Input.Clone ();
 			XPathNavigator nsScope = nav.Clone ();
 			
-			if (nav.MoveToFirstNamespace (XPathNamespaceScope.Local)) {
+			if (nav.MoveToFirstNamespace (XPathNamespaceScope.ExcludeXml)) {
 				do {
 					if (nav.Value != XsltNamespace && !ret.Contains (nav.Name))
 						ret.Add (nav.Name, nav.Value);
 				} while (nav.MoveToNextNamespace (XPathNamespaceScope.Local));
-				nav.MoveToParent ();
+				nav.MoveToParent();
 			}
 			
 			do {
diff -Naur ./Mono.Xml.Xsl/GenericOutputter.cs ../monopatched/Mono.Xml.Xsl/GenericOutputter.cs
--- ./Mono.Xml.Xsl/GenericOutputter.cs	2004-09-12 11:56:01.000000000 +0300
+++ ../monopatched/Mono.Xml.Xsl/GenericOutputter.cs	2005-02-06 17:35:05.000000000 +0200
@@ -74,9 +74,12 @@
 		bool _canProcessAttributes;
 		bool _insideCData;
 		bool _isVariable;
+		bool _omitXmlDeclaration;
+		int _xpCount;
 
 		private GenericOutputter (Hashtable outputs, Encoding encoding)
 		{
+			_xpCount = 0;
 			_encoding = encoding;
 			_outputs = outputs;
 			_currentOutput = (XslOutput)outputs [String.Empty];
@@ -86,6 +89,7 @@
 			_nsManager = new XmlNamespaceManager (_nt);
 			_currentNsPrefixes = new ArrayList ();
 			_currentNamespaceDecls = new Hashtable ();
+			_omitXmlDeclaration = false;
 		}
 
 		public GenericOutputter (XmlWriter writer, Hashtable outputs, Encoding encoding) 
@@ -99,6 +103,7 @@
 			_emitter = new XmlWriterEmitter (writer);
 			_state = writer.WriteState;
 			_isVariable = isVariable;
+			_omitXmlDeclaration = true; // .Net never writes XML declaration via XmlWriter
 		}
 
 		public GenericOutputter (TextWriter writer, Hashtable outputs, Encoding encoding)
@@ -165,18 +170,36 @@
 				//Push scope to allow to unwind namespaces scope back in WriteEndElement
 				//Subject to optimization - avoid redundant push/pop by moving 
 				//namespaces to WriteStartElement
-				_nsManager.PushScope ();
 				//Emit pending attributes
-				for (int i = 0; i < pendingAttributesPos; i++) {
+				ArrayList newNamespaces = new ArrayList(); //remember indexes of new prefexes
+				_nsManager.PushScope ();
+				for (int i = 0; i < _currentNsPrefixes.Count; i++) 
+				{
+					string prefix = (string) _currentNsPrefixes [i];
+					string uri = _currentNamespaceDecls [prefix] as string;
+					
+					if (_nsManager.LookupNamespace(prefix) == uri)
+						continue;
+
+					newNamespaces.Add(i);
+					_nsManager.AddNamespace (prefix, uri);
+				}
+				for (int i = 0; i < pendingAttributesPos; i++) 
+				{
 					Attribute attr = pendingAttributes [i];
-					string prefix = attr.Prefix;
-					if (prefix == String.Empty)
-						prefix = _nsManager.LookupPrefix (attr.Namespace, false);
+					string prefix = _nsManager.LookupPrefix (attr.Namespace, false);
+					if (prefix == null) {
+						prefix = attr.Prefix;
+						_nsManager.AddNamespace (prefix, attr.Namespace);
+					}
+					
 					Emitter.WriteAttributeString (prefix, attr.LocalName, attr.Namespace, attr.Value);
 				}
-				for (int i = 0; i < _currentNsPrefixes.Count; i++) {
-					string prefix = (string) _currentNsPrefixes [i];
+				for (int i = 0; i < newNamespaces.Count; i++)
+				{
+					string prefix = (string) _currentNsPrefixes [(int)newNamespaces[i]];
 					string uri = _currentNamespaceDecls [prefix] as string;
+					
 					if (prefix != String.Empty)
 						Emitter.WriteAttributeString ("xmlns", prefix, XmlNamespaceManager.XmlnsXmlns, uri);
 					else
@@ -197,7 +220,7 @@
 			if (_isVariable)
 				return;
 
-			if (!_currentOutput.OmitXmlDeclaration)
+			if (!_omitXmlDeclaration && !_currentOutput.OmitXmlDeclaration)
 				Emitter.WriteStartDocument (_encoding != null ? _encoding : _currentOutput.Encoding, _currentOutput.Standalone);
 			
 			_state = WriteState.Prolog;
@@ -208,7 +231,6 @@
 			Emitter.WriteEndDocument ();				
 		}
 
-		int _nsCount;
 		public override void WriteStartElement (string prefix, string localName, string nsURI)
 		{
 			if (_emitter == null) {
@@ -261,11 +283,7 @@
 		public override void WriteAttributeString (string prefix, string localName, string nsURI, string value)
 		{
 			if (prefix == String.Empty && nsURI != String.Empty) {
-				prefix = "xp_" + _nsCount;
-				_nsManager.AddNamespace (prefix, nsURI);
-				_currentNsPrefixes.Add (prefix);
-				_currentNamespaceDecls.Add (prefix, nsURI);
-				_nsCount++;
+				prefix = "xp_" + _xpCount++;
 			}
 
 			//Put attribute to pending attributes collection, replacing namesake one
@@ -294,19 +312,12 @@
 			pendingAttributesPos++;
 		}
 
-		public override void WriteNamespaceDecl (string prefix, string nsUri)
-		{
-			if (_nsManager.LookupNamespace (prefix, false) == nsUri)
-				return;
-
-			if (prefix == String.Empty) {
-				//Default namespace
-				if (_nsManager.DefaultNamespace != nsUri)
-					_nsManager.AddNamespace (prefix, nsUri);
-			} else if (_nsManager.LookupPrefix (nsUri, false) == null)
-				//That's new namespace - add it to the collection
-				_nsManager.AddNamespace (prefix, nsUri);
-
+		public override void WriteNamespaceDecl (string prefix, string nsUri) {
+			for (int i = 0; i < pendingAttributesPos; i++) {
+				Attribute attr = pendingAttributes [i];
+				if (attr.Prefix == prefix || attr.Namespace == nsUri)
+					return; //don't touch explicitly declared attributes
+			}
 			if (_currentNamespaceDecls [prefix] as string != nsUri) {
 				if (!_currentNsPrefixes.Contains (prefix))
 					_currentNsPrefixes.Add (prefix);
diff -Naur ./Mono.Xml.Xsl/XslTransformProcessor.cs ../monopatched/Mono.Xml.Xsl/XslTransformProcessor.cs
--- ./Mono.Xml.Xsl/XslTransformProcessor.cs	2005-02-02 20:02:13.000000000 +0200
+++ ../monopatched/Mono.Xml.Xsl/XslTransformProcessor.cs	2005-02-06 17:37:05.000000000 +0200
@@ -83,15 +83,27 @@
 			XPathExpression exp = root.Compile (".");
 			PushNodeset (root.Select (exp, this.XPathContext));
 			
-			foreach (XslGlobalVariable v in CompiledStyle.Variables.Values)	{
-				if (args != null && v is XslGlobalParam) {
-					object p = args.GetParam(v.Name.Name, v.Name.Namespace);
-					if (p != null)
-						((XslGlobalParam)v).Override (this, p);
-					else
+			// have to evaluate the params first, as Global vars may
+			// be dependant on them
+			if (args != null)
+			{
+				foreach (XslGlobalVariable v in CompiledStyle.Variables.Values)
+				{
+					if (v is XslGlobalParam)
+					{
+						object p = args.GetParam(v.Name.Name, v.Name.Namespace);
+						if (p != null)
+							((XslGlobalParam)v).Override (this, p);
+
 						v.Evaluate (this);
+					}
+				}
+			}
+
+			foreach (XslGlobalVariable v in CompiledStyle.Variables.Values)	{
+				if (args == null || !(v is XslGlobalParam)) {
+					v.Evaluate (this);
 				}
-				v.Evaluate (this);
 			}
 			
 			PopNodeset ();
@@ -305,24 +317,40 @@
 			currentTemplateStack.Pop ();
 		}
 
-		internal void TryStylesheetNamespaceOutput (ArrayList excluded)
+		internal void TryElementNamespacesOutput (Hashtable nsDecls, ArrayList excludedPrefixes)
 		{
-			if (outputStylesheetXmlns) {
-				foreach (XmlQualifiedName qname in this.style.StylesheetNamespaces) {
-					string prefix = style.PrefixInEffect (qname.Name, excluded);
-					if (prefix == null)
-						continue;
-					else if (prefix == qname.Name)
-						Out.WriteNamespaceDecl (
-							prefix == "#default" ? String.Empty : prefix,
-							qname.Namespace);
-					else
-						Out.WriteNamespaceDecl (prefix, style.StyleDocument.GetNamespace (prefix));
+			if (nsDecls == null)
+				return;
+
+			foreach (DictionaryEntry cur in nsDecls)
+			{
+				string name = (string)cur.Key;
+				string value = (string)cur.Value;
+				switch (value)
+				{//FIXME: compare names by reference
+					case "http://www.w3.org/1999/XSL/Transform":
+						if ("xsl" == name)
+							continue;
+						else
+							goto default;
+					case XmlNamespaceManager.XmlnsXml:
+						if (XmlNamespaceManager.PrefixXml == name)
+							continue;
+						else
+							goto default;
+					case XmlNamespaceManager.XmlnsXmlns:
+						if (XmlNamespaceManager.PrefixXmlns == name)
+							continue;
+						else
+							goto default;
+					default:
+						if (! excludedPrefixes.Contains (name))
+							Out.WriteNamespaceDecl (name, value);
+						break;
 				}
-				outputStylesheetXmlns = false;
 			}
 		}
-		
+
 		XslTemplate FindTemplate (XPathNavigator node, QName mode)
 		{
 			XslTemplate ret = style.Templates.FindMatch (CurrentNode, mode, this);
diff -Naur ./Mono.Xml.Xsl.Operations/XslCopy.cs ../monopatched/Mono.Xml.Xsl.Operations/XslCopy.cs
--- ./Mono.Xml.Xsl.Operations/XslCopy.cs	2004-09-12 11:56:08.000000000 +0300
+++ ../monopatched/Mono.Xml.Xsl.Operations/XslCopy.cs	2005-02-06 17:35:05.000000000 +0200
@@ -40,12 +40,24 @@
 	internal class XslCopy : XslCompiledElement {
 		XslOperation children;
 		XmlQualifiedName [] useAttributeSets;
+		Hashtable nsDecls;
+		string excludeResultPrefixes;
+		string extensionElementPrefixes;
+		ArrayList excludedPrefixes;
 		
 		public XslCopy (Compiler c) : base (c) {}
 		
 		protected override void Compile (Compiler c)
 		{
-			if (c.Input.MoveToFirstAttribute ()) {
+			this.nsDecls = c.GetNamespacesToCopy ();
+			if (nsDecls.Count == 0) nsDecls = null;
+			this.excludeResultPrefixes = c.Input.GetAttribute ("exclude-result-prefixes", XsltNamespace);
+			this.extensionElementPrefixes = c.Input.GetAttribute ("extension-element-prefixes", XsltNamespace);
+			excludedPrefixes = new ArrayList (excludeResultPrefixes.Split (XmlChar.WhitespaceChars));
+			excludedPrefixes.AddRange (extensionElementPrefixes.Split (XmlChar.WhitespaceChars));
+
+			if (c.Input.MoveToFirstAttribute ())
+			{
 				do {
 					if (c.Input.NamespaceURI == String.Empty && c.Input.LocalName != "use-attribute-sets")
 						throw new XsltCompileException ("Unrecognized attribute \"" + c.Input.Name + "\" in XSLT copy element.", null, c.Input);
@@ -80,7 +92,7 @@
 				p.PushElementState (p.CurrentNode.LocalName, p.CurrentNode.NamespaceURI, true);
 				p.Out.WriteStartElement (p.CurrentNode.Prefix, p.CurrentNode.LocalName, p.CurrentNode.NamespaceURI);
 				
-				p.TryStylesheetNamespaceOutput (null);
+				p.TryElementNamespacesOutput (nsDecls, excludedPrefixes);
 				if (useAttributeSets != null)
 					foreach (XmlQualifiedName s in useAttributeSets)
 						p.ResolveAttributeSet (s).Evaluate (p);
diff -Naur ./Mono.Xml.Xsl.Operations/XslElement.cs ../monopatched/Mono.Xml.Xsl.Operations/XslElement.cs
--- ./Mono.Xml.Xsl.Operations/XslElement.cs	2005-02-02 20:02:27.000000000 +0200
+++ ../monopatched/Mono.Xml.Xsl.Operations/XslElement.cs	2005-02-06 17:35:05.000000000 +0200
@@ -44,6 +44,10 @@
 		string calcName, calcNs, calcPrefix;
 		XmlNamespaceManager nsm;
 		bool isEmptyElement;
+		Hashtable nsDecls;
+		string excludeResultPrefixes;
+		string extensionElementPrefixes;
+		ArrayList excludedPrefixes;
 
 		XslOperation value;
 		XmlQualifiedName [] useAttributeSets;
@@ -51,6 +55,13 @@
 		public XslElement (Compiler c) : base (c) {}
 		protected override void Compile (Compiler c)
 		{
+			this.nsDecls = c.GetNamespacesToCopy ();
+			if (nsDecls.Count == 0) nsDecls = null;
+			this.excludeResultPrefixes = c.Input.GetAttribute ("exclude-result-prefixes", XsltNamespace);
+			this.extensionElementPrefixes = c.Input.GetAttribute ("extension-element-prefixes", XsltNamespace);
+			excludedPrefixes = new ArrayList (excludeResultPrefixes.Split (XmlChar.WhitespaceChars));
+			excludedPrefixes.AddRange (extensionElementPrefixes.Split (XmlChar.WhitespaceChars));
+
 			name = c.ParseAvtAttribute ("name");
 			ns = c.ParseAvtAttribute ("namespace");
 			
@@ -122,7 +133,7 @@
 			bool isCData = p.InsideCDataElement;
 			p.PushElementState (localName, nmsp, false);
 			p.Out.WriteStartElement (prefix, localName, nmsp);
-			p.TryStylesheetNamespaceOutput (null);
+			p.TryElementNamespacesOutput (nsDecls, excludedPrefixes);
 
 			if (useAttributeSets != null)
 				foreach (XmlQualifiedName s in useAttributeSets)
diff -Naur ./Mono.Xml.Xsl.Operations/XslLiteralElement.cs ../monopatched/Mono.Xml.Xsl.Operations/XslLiteralElement.cs
--- ./Mono.Xml.Xsl.Operations/XslLiteralElement.cs	2004-09-12 11:56:09.000000000 +0300
+++ ../monopatched/Mono.Xml.Xsl.Operations/XslLiteralElement.cs	2005-02-06 17:35:06.000000000 +0200
@@ -67,6 +67,7 @@
 			
 			public void Evaluate (XslTransformProcessor p)
 			{
+				//FIXME: fix attribute prefixes according to aliases
 				p.Out.WriteAttributeString (prefix, localname, nsUri, val.Evaluate (p));
 			}
 		}
@@ -139,7 +140,8 @@
 					((XslLiteralAttribute)attrs [i]).Evaluate (p);
 			}
 
-			p.TryStylesheetNamespaceOutput (excludedPrefixes);
+			p.TryElementNamespacesOutput (nsDecls, excludedPrefixes);
+
 			if (nsDecls != null) {
 				foreach (DictionaryEntry de in nsDecls) {
 					string actualPrefix = p.CompiledStyle.Style.PrefixInEffect (de.Key as String, excludedPrefixes);
