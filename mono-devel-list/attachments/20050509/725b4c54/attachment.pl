Index: System.Security.Permissions/PermissionSetAttribute.cs
===================================================================
--- System.Security.Permissions/PermissionSetAttribute.cs	(revision 44258)
+++ System.Security.Permissions/PermissionSetAttribute.cs	(working copy)
@@ -96,7 +96,7 @@
 			try {
 				sp.LoadXml (xml);
 			}
-			catch (Mono.Xml.MiniParser.XMLError xe) {
+			catch (Mono.Xml.SmallXmlParserException xe) {
 				throw new XmlSyntaxException (xe.Line, xe.ToString ());
 			}
 			SecurityElement se = sp.ToXml ();
Index: corlib.dll.sources
===================================================================
--- corlib.dll.sources	(revision 44258)
+++ corlib.dll.sources	(working copy)
@@ -50,7 +50,7 @@
 Mono.Security.X509.Extensions/BasicConstraintsExtension.cs
 Mono.Security.X509.Extensions/KeyUsageExtension.cs
 Mono.Security.X509.Extensions/SubjectKeyIdentifierExtension.cs
-Mono.Xml/MiniParser.cs
+Mono.Xml/SmallXmlParser.cs
 Mono.Xml/SecurityParser.cs
 System/AccessViolationException.cs
 System/ActivationContext.cs
Index: Mono.Xml/SecurityParser.cs
===================================================================
--- Mono.Xml/SecurityParser.cs	(revision 44258)
+++ Mono.Xml/SecurityParser.cs	(working copy)
@@ -32,6 +32,7 @@
 
 using System;
 using System.Collections;
+using System.IO;
 using System.Security;
 
 namespace Mono.Xml {
@@ -43,7 +44,7 @@
 	[CLSCompliant(false)]    
 	public
 #endif
-	class SecurityParser : MiniParser, MiniParser.IHandler, MiniParser.IReader {
+	class SecurityParser : SmallXmlParser, SmallXmlParser.IContentHandler {
 
 		private SecurityElement root;
 
@@ -55,10 +56,8 @@
 		public void LoadXml (string xml) 
 		{
 			root = null;
-			xmldoc = xml;
-			pos = 0;
 			stack.Clear ();
-			Parse (this, this);
+			Parse (new StringReader (xml), this);
 		}
 
 		public SecurityElement ToXml () 
@@ -66,26 +65,18 @@
 			return root;
 		}
 
-		// IReader
+		// IContentHandler
 
-		private string xmldoc;
-		private int pos;
-
-		public int Read () 
-		{
-			if (pos >= xmldoc.Length)
-				return -1;
-			return (int) xmldoc [pos++];
-		}
-
-		// IHandler
-
 		private SecurityElement current;
 		private Stack stack;
 
-		public void OnStartParsing (MiniParser parser) {}
+		public void OnStartParsing (SmallXmlParser parser) {}
 
-		public void OnStartElement (string name, MiniParser.IAttrList attrs) 
+		public void OnProcessingInstruction (string name, string text) {}
+
+		public void OnIgnorableWhitespace (string s) {}
+
+		public void OnStartElement (string name, SmallXmlParser.IAttrList attrs) 
 		{
 			SecurityElement newel = new SecurityElement (name); 
 			if (root == null) {
@@ -114,6 +105,6 @@
 			current.Text = ch;
 		}
 
-		public void OnEndParsing (MiniParser parser) {}
+		public void OnEndParsing (SmallXmlParser parser) {}
 	}
 }
Index: Mono.Xml/SmallXmlParser.cs
===================================================================
--- Mono.Xml/SmallXmlParser.cs	(revision 0)
+++ Mono.Xml/SmallXmlParser.cs	(revision 0)
@@ -0,0 +1,587 @@
+using System;
+using System.Collections;
+using System.Globalization;
+using System.IO;
+using System.Text;
+
+namespace Mono.Xml
+{
+	internal class DefaultHandler : SmallXmlParser.IContentHandler
+	{
+		public void OnStartParsing (SmallXmlParser parser)
+		{
+		}
+
+		public void OnEndParsing (SmallXmlParser parser)
+		{
+		}
+
+		public void OnStartElement (string name, SmallXmlParser.IAttrList attrs)
+		{
+		}
+
+		public void OnEndElement (string name)
+		{
+		}
+
+		public void OnChars (string s)
+		{
+		}
+
+		public void OnIgnorableWhitespace (string s)
+		{
+		}
+
+		public void OnProcessingInstruction (string name, string text)
+		{
+		}
+	}
+
+	internal class SmallXmlParser
+	{
+		public interface IContentHandler
+		{
+			void OnStartParsing (SmallXmlParser parser);
+			void OnEndParsing (SmallXmlParser parser);
+			void OnStartElement (string name, IAttrList attrs);
+			void OnEndElement (string name);
+			void OnProcessingInstruction (string name, string text);
+			void OnChars (string text);
+			void OnIgnorableWhitespace (string text);
+		}
+
+		public interface IAttrList
+		{
+			int Length { get; }
+			bool IsEmpty { get; }
+			string GetName (int i);
+			string GetValue (int i);
+			string GetValue (string name);
+			string [] Names { get; }
+			string [] Values { get; }
+		}
+
+		class AttrListImpl : IAttrList
+		{
+			public int Length {
+				get { return attrNames.Count; }
+			}
+			public bool IsEmpty {
+				get { return attrNames.Count == 0; }
+			}
+			public string GetName (int i)
+			{
+				return (string) attrNames [i];
+			}
+			public string GetValue (int i)
+			{
+				return (string) attrValues [i];
+			}
+			public string GetValue (string name)
+			{
+				for (int i = 0; i < attrNames.Count; i++)
+					if ((string) attrNames [i] == name)
+						return (string) attrValues [i];
+				return null;
+			}
+			public string [] Names {
+				get { return (string []) attrNames.ToArray (typeof (string)); }
+			}
+			public string [] Values {
+				get { return (string []) attrValues.ToArray (typeof (string)); }
+			}
+
+			ArrayList attrNames = new ArrayList ();
+			ArrayList attrValues = new ArrayList ();
+
+			internal void Clear ()
+			{
+				attrNames.Clear ();
+				attrValues.Clear ();
+			}
+
+			internal void Add (string name, string value)
+			{
+				attrNames.Add (name);
+				attrValues.Add (value);
+			}
+		}
+
+		IContentHandler handler;
+		TextReader reader;
+		Stack elementNames = new Stack ();
+		Stack xmlSpaces = new Stack ();
+		string xmlSpace;
+		StringBuilder buffer = new StringBuilder (200);
+		char [] nameBuffer = new char [30];
+		bool isWhitespace;
+
+		AttrListImpl attributes = new AttrListImpl ();
+		int line = 1, column;
+		bool resetColumn;
+
+		public SmallXmlParser ()
+		{
+		}
+
+		private Exception Error (string msg)
+		{
+			return new SmallXmlParserException (msg, line, column);
+		}
+
+		private Exception UnexpectedEndError ()
+		{
+			string [] arr = new string [elementNames.Count];
+			elementNames.CopyTo (arr, 0);
+			return Error (String.Format (
+				"Unexpected end of stream. Element stack content is {0}", String.Join (",", arr)));
+		}
+
+
+		private bool IsNameChar (char c, bool start)
+		{
+			switch (c) {
+			case ':':
+			case '_':
+				return true;
+			case '-':
+			case '.':
+				return !start;
+			}
+			if (c > 0x100) { // optional condition for optimization
+				switch (c) {
+				case '\u0559':
+				case '\u06E5':
+				case '\u06E6':
+					return true;
+				}
+				if ('\u02BB' <= c && c <= '\u02C1')
+					return true;
+			}
+			switch (Char.GetUnicodeCategory (c)) {
+			case UnicodeCategory.LowercaseLetter:
+			case UnicodeCategory.UppercaseLetter:
+			case UnicodeCategory.OtherLetter:
+			case UnicodeCategory.TitlecaseLetter:
+			case UnicodeCategory.LetterNumber:
+				return true;
+			case UnicodeCategory.SpacingCombiningMark:
+			case UnicodeCategory.EnclosingMark:
+			case UnicodeCategory.NonSpacingMark:
+			case UnicodeCategory.ModifierLetter:
+			case UnicodeCategory.DecimalDigitNumber:
+				return !start;
+			default:
+				return false;
+			}
+		}
+
+		private bool IsWhitespace (int c)
+		{
+			switch (c) {
+			case ' ':
+			case '\r':
+			case '\t':
+			case '\n':
+				return true;
+			default:
+				return false;
+			}
+		}
+
+
+		public void SkipWhitespaces ()
+		{
+			SkipWhitespaces (false);
+		}
+
+		private void HandleWhitespaces ()
+		{
+			while (IsWhitespace (Peek ()))
+				buffer.Append ((char) Read ());
+			if (Peek () != '<' && Peek () >= 0)
+				isWhitespace = false;
+		}
+
+		public void SkipWhitespaces (bool expected)
+		{
+			while (true) {
+				switch (Peek ()) {
+				case ' ':
+				case '\r':
+				case '\t':
+				case '\n':
+					Read ();
+					if (expected)
+						expected = false;
+					continue;
+				}
+				if (expected)
+					throw Error ("Whitespace is expected.");
+				return;
+			}
+		}
+
+
+		private int Peek ()
+		{
+			return reader.Peek ();
+		}
+
+		private int Read ()
+		{
+			int i = reader.Read ();
+			if (i == '\n')
+				resetColumn = true;
+			if (resetColumn) {
+				line++;
+				resetColumn = false;
+				column = 1;
+			}
+			else
+				column++;
+			return i;
+		}
+
+		public void Expect (int c)
+		{
+			int p = Read ();
+			if (p < 0)
+				throw UnexpectedEndError ();
+			else if (p != c)
+				throw Error (String.Format ("Expected '{0}' but got {1}", (char) c, (char) p));
+		}
+
+		private string ReadUntil (char until, bool handleReferences)
+		{
+			while (true) {
+				if (Peek () < 0)
+					throw UnexpectedEndError ();
+				char c = (char) Read ();
+				if (c == until)
+					break;
+				else if (handleReferences && c == '&')
+					ReadReference ();
+				else
+					buffer.Append (c);
+			}
+			string ret = buffer.ToString ();
+			buffer.Length = 0;
+			return ret;
+		}
+
+		public string ReadName ()
+		{
+			int idx = 0;
+			if (Peek () < 0 || !IsNameChar ((char) Peek (), true))
+				throw Error ("XML name start character is expected.");
+			for (int i = Peek (); i >= 0; i = Peek ()) {
+				char c = (char) i;
+				if (!IsNameChar (c, false))
+					break;
+				if (idx == nameBuffer.Length) {
+					char [] tmp = new char [idx * 2];
+					Array.Copy (nameBuffer, tmp, idx);
+					nameBuffer = tmp;
+				}
+				nameBuffer [idx++] = c;
+				Read ();
+			}
+			if (idx == 0)
+				throw Error ("Valid XML name is expected.");
+			return new string (nameBuffer, 0, idx);
+		}
+
+
+		public void Parse (TextReader input, IContentHandler handler)
+		{
+			this.reader = input;
+			this.handler = handler;
+
+			while (Peek () >= 0)
+				ReadContent ();
+			HandleBufferedContent ();
+			if (elementNames.Count > 0)
+				throw Error (String.Format ("Insufficient close tag: {0}", elementNames.Peek ()));
+
+			Cleanup ();
+		}
+
+		private void Cleanup ()
+		{
+			line = 1;
+			column = 0;
+			handler = null;
+			reader = null;
+			elementNames.Clear ();
+			xmlSpaces.Clear ();
+			attributes.Clear ();
+			buffer.Length = 0;
+			xmlSpace = null;
+			isWhitespace = false;
+		}
+
+		public void ReadContent ()
+		{
+			string name;
+			if (IsWhitespace (Peek ())) {
+				if (buffer.Length == 0)
+					isWhitespace = true;
+				HandleWhitespaces ();
+			}
+			if (Peek () == '<') {
+				Read ();
+				switch (Peek ()) {
+				case '!': // declarations
+					Read ();
+					if (Peek () == '[') {
+						Read ();
+						if (ReadName () != "CDATA")
+							throw Error ("Invalid declaration markup");
+						Expect ('[');
+						ReadCDATASection ();
+						return;
+					}
+					else if (Peek () == '-') {
+						ReadComment ();
+						return;
+					}
+					else if (ReadName () != "DOCTYPE")
+						throw Error ("Invalid declaration markup.");
+					else
+						throw Error ("This parser does not support document type.");
+				case '?': // PIs
+					HandleBufferedContent ();
+					Read ();
+					name = ReadName ();
+					SkipWhitespaces ();
+					string text = String.Empty;
+					if (Peek () != '?') {
+						while (true) {
+							text += ReadUntil ('?', false);
+							if (Peek () == '>')
+								break;
+							buffer.Append ('?');
+						}
+					}
+					handler.OnProcessingInstruction (
+						name, text);
+					Expect ('>');
+					return;
+				case '/': // end tags
+					HandleBufferedContent ();
+					if (elementNames.Count == 0)
+						throw UnexpectedEndError ();
+					Read ();
+					name = ReadName ();
+					SkipWhitespaces ();
+					string expected = (string) elementNames.Pop ();
+					if (name != expected)
+						throw Error (String.Format ("End tag mismatch: expected {0} but found {1}", expected, name));
+					handler.OnEndElement (name);
+					Expect ('>');
+					return;
+				default: // start tags (including empty tags)
+					HandleBufferedContent ();
+					name = ReadName ();
+					while (Peek () != '>' && Peek () != '/')
+						ReadAttribute (attributes);
+					handler.OnStartElement (name, attributes);
+					attributes.Clear ();
+					SkipWhitespaces ();
+					if (Peek () == '/') {
+						Read ();
+						handler.OnEndElement (name);
+					}
+					else {
+						elementNames.Push (name);
+						xmlSpaces.Push (xmlSpace);
+					}
+					Expect ('>');
+					return;
+				}
+			}
+			else
+				ReadCharacters ();
+		}
+
+		private void HandleBufferedContent ()
+		{
+			if (buffer.Length == 0)
+				return;
+			if (isWhitespace)
+				handler.OnIgnorableWhitespace (buffer.ToString ());
+			else
+				handler.OnChars (buffer.ToString ());
+			buffer.Length = 0;
+			isWhitespace = false;
+		}
+
+		private void ReadCharacters ()
+		{
+			isWhitespace = false;
+			while (true) {
+				int i = Peek ();
+				switch (i) {
+				case -1:
+					return;
+				case '<':
+					return;
+				case '&':
+					Read ();
+					ReadReference ();
+					continue;
+				default:
+					buffer.Append ((char) Read ());
+					continue;
+				}
+			}
+		}
+
+		private void ReadReference ()
+		{
+			if (Peek () == '#') {
+				// character reference
+				Read ();
+				ReadCharacterReference ();
+			} else {
+				string name = ReadName ();
+				Expect (';');
+				switch (name) {
+				case "amp":
+					buffer.Append ('&');
+					break;
+				case "quot":
+					buffer.Append ('"');
+					break;
+				case "apos":
+					buffer.Append ('\'');
+					break;
+				case "lt":
+					buffer.Append ('<');
+					break;
+				case "gt":
+					buffer.Append ('>');
+					break;
+				default:
+					throw Error ("General non-predefined entity reference is not supported in this parser.");
+				}
+			}
+		}
+
+		private int ReadCharacterReference ()
+		{
+			int n = 0;
+			if (Peek () == 'x') { // hex
+				Read ();
+				for (int i = Peek (); i >= 0; i = Peek ()) {
+					if ('0' <= i && i <= '9')
+						n = n << 4 + i - '0';
+					else if ('A' <= i && i <='F')
+						n = n << 4 + i - 'A' + 10;
+					else if ('a' <= i && i <='f')
+						n = n << 4 + i - 'a' + 10;
+					else
+						break;
+					Read ();
+				}
+			} else {
+				for (int i = Peek (); i >= 0; i = Peek ()) {
+					if ('0' <= i && i <= '9')
+						n = n << 4 + i - '0';
+					else
+						break;
+					Read ();
+				}
+			}
+			return n;
+		}
+
+		private void ReadAttribute (AttrListImpl a)
+		{
+			SkipWhitespaces (true);
+			if (Peek () == '/' || Peek () == '>')
+				// came here just to spend trailing whitespaces
+				return;
+
+			string name = ReadName ();
+			string value;
+			SkipWhitespaces ();
+			Expect ('=');
+			SkipWhitespaces ();
+			switch (Read ()) {
+			case '\'':
+				value = ReadUntil ('\'', true);
+				break;
+			case '"':
+				value = ReadUntil ('"', true);
+				break;
+			default:
+				throw Error ("Invalid attribute value markup.");
+			}
+			if (name == "xml:space")
+				xmlSpace = value;
+			a.Add (name, value);
+		}
+
+		private void ReadCDATASection ()
+		{
+			int nBracket = 0;
+			while (true) {
+				if (Peek () < 0)
+					throw UnexpectedEndError ();
+				char c = (char) Read ();
+				if (c == ']')
+					nBracket++;
+				else if (c == '>' && nBracket > 2) {
+					for (int i = nBracket; i > 2; i--)
+						buffer.Append (']');
+					break;
+				}
+				else {
+					for (int i = 0; i < nBracket; i++)
+						buffer.Append (']');
+					nBracket = 0;
+					buffer.Append (c);
+				}
+			}
+		}
+
+		private void ReadComment ()
+		{
+			Expect ('-');
+			Expect ('-');
+			while (true) {
+				if (Read () != '-')
+					continue;
+				if (Read () != '-')
+					continue;
+				if (Read () != '>')
+					throw Error ("'--' is not allowed inside comment markup.");
+				break;
+			}
+		}
+	}
+
+	internal class SmallXmlParserException : SystemException
+	{
+		int line;
+		int column;
+
+		public SmallXmlParserException (string msg, int line, int column)
+			: base (String.Format ("{0}. At ({1},{2})", msg, line, column))
+		{
+			this.line = line;
+			this.column = column;
+		}
+
+		public int Line {
+			get { return line; }
+		}
+
+		public int Column {
+			get { return column; }
+		}
+	}
+}
+
Index: System.Runtime.Remoting/RemotingConfiguration.cs
===================================================================
--- System.Runtime.Remoting/RemotingConfiguration.cs	(revision 44258)
+++ System.Runtime.Remoting/RemotingConfiguration.cs	(working copy)
@@ -53,7 +53,7 @@
 		static string applicationID = null;
 		static string applicationName = null;
 		static string configFile = "";
-		static MiniParser parser = null; 
+		static SmallXmlParser parser = null; 
 		static string processGuid = null;
 		static bool defaultConfigRead = false;
 		static bool defaultDelayedConfigRead = false;
@@ -126,10 +126,11 @@
 		{
 			try
 			{
-				MiniParser parser = new MiniParser ();
-				RReader rreader = new RReader (filename);
-				ConfigHandler handler = new ConfigHandler (false);
-				parser.Parse (rreader, handler);
+				SmallXmlParser parser = new SmallXmlParser ();
+				using (TextReader rreader = new StreamReader (filename)) {
+					ConfigHandler handler = new ConfigHandler (false);
+					parser.Parse (rreader, handler);
+				}
 			}
 			catch (Exception ex)
 			{
@@ -143,10 +144,11 @@
 			{
 				if (defaultDelayedConfigRead || defaultConfigRead) return;
 				
-				MiniParser parser = new MiniParser ();
-				RReader rreader = new RReader (Environment.GetMachineConfigPath ());
-				ConfigHandler handler = new ConfigHandler (true);
-				parser.Parse (rreader, handler);
+				SmallXmlParser parser = new SmallXmlParser ();
+				using (TextReader rreader = new StreamReader (Environment.GetMachineConfigPath ())) {
+					ConfigHandler handler = new ConfigHandler (true);
+					parser.Parse (rreader, handler);
+				}
 				defaultDelayedConfigRead = true;
 			}
 		}
@@ -385,33 +387,7 @@
 	 * Internal classes used by RemotingConfiguration.Configure () *
 	 ***************************************************************/
 	 
-	internal class RReader : MiniParser.IReader {
-		private string xml; // custom remoting config file
-		private int pos;
-
-		public RReader (string filename)
-		{
-			try {
-				StreamReader sr = new StreamReader (filename);
-				xml = sr.ReadToEnd ();
-				sr.Close ();
-			}
-			catch {
-				xml = null;
-			}
-		}
-
-		public int Read () {
-			try {
-				return (int) xml[pos++];
-			}
-			catch {
-				return -1;
-			}
-		}
-	}
-	
-	internal class ConfigHandler : MiniParser.IHandler 
+	internal class ConfigHandler : SmallXmlParser.IContentHandler 
 	{
 		ArrayList typeEntries = new ArrayList ();
 		ArrayList channelInstances = new ArrayList ();
@@ -446,9 +422,13 @@
 				return currentXmlPath.EndsWith (path);
 		}
 		
-		public void OnStartParsing (MiniParser parser) {}
+		public void OnStartParsing (SmallXmlParser parser) {}
 		
-		public void OnStartElement (string name, MiniParser.IAttrList attrs)
+		public void OnProcessingInstruction (string name, string text) {}
+
+		public void OnIgnorableWhitespace (string s) {}
+
+		public void OnStartElement (string name, SmallXmlParser.IAttrList attrs)
 		{
 			try
 			{
@@ -463,7 +443,7 @@
 			}
 		}
 		
-		public void ParseElement (string name, MiniParser.IAttrList attrs)
+		public void ParseElement (string name, SmallXmlParser.IAttrList attrs)
 		{
 			if (currentProviderData != null)
 			{
@@ -608,7 +588,7 @@
 			currentXmlPath = currentXmlPath.Substring (0, currentXmlPath.Length - name.Length - 1);
 		}
 		
-		void ReadCustomProviderData (string name, MiniParser.IAttrList attrs)
+		void ReadCustomProviderData (string name, SmallXmlParser.IAttrList attrs)
 		{
 			SinkProviderData parent = (SinkProviderData) currentProviderData.Peek ();
 			
@@ -620,7 +600,7 @@
 			currentProviderData.Push (data);
 		}
 
-		void ReadLifetine (MiniParser.IAttrList attrs)
+		void ReadLifetine (SmallXmlParser.IAttrList attrs)
 		{
 			for (int i=0; i < attrs.Names.Length; ++i) {
 				switch (attrs.Names[i]) {
@@ -672,7 +652,7 @@
 			throw new RemotingException ("Invalid time unit: " + unit);
 		}
 		
-		void ReadChannel (MiniParser.IAttrList attrs, bool isTemplate)
+		void ReadChannel (SmallXmlParser.IAttrList attrs, bool isTemplate)
 		{
 			ChannelData channel = new ChannelData ();
 			
@@ -705,7 +685,7 @@
 			currentChannel = channel;
 		}
 		
-		ProviderData ReadProvider (string name, MiniParser.IAttrList attrs, bool isTemplate)
+		ProviderData ReadProvider (string name, SmallXmlParser.IAttrList attrs, bool isTemplate)
 		{
 			ProviderData prov = (name == "provider") ? new ProviderData () : new FormatterData ();
 			SinkProviderData data = new SinkProviderData ("root");
@@ -733,7 +713,7 @@
 			return prov;
 		}
 		
-		void ReadClientActivated (MiniParser.IAttrList attrs)
+		void ReadClientActivated (SmallXmlParser.IAttrList attrs)
 		{
 			string type = GetNotNull (attrs, "type");
 			string assm = ExtractAssembly (ref type);
@@ -744,7 +724,7 @@
 			typeEntries.Add (new ActivatedClientTypeEntry (type, assm, currentClientUrl));
 		}
 		
-		void ReadServiceActivated (MiniParser.IAttrList attrs)
+		void ReadServiceActivated (SmallXmlParser.IAttrList attrs)
 		{
 			string type = GetNotNull (attrs, "type");
 			string assm = ExtractAssembly (ref type);
@@ -752,7 +732,7 @@
 			typeEntries.Add (new ActivatedServiceTypeEntry (type, assm));
 		}
 		
-		void ReadClientWellKnown (MiniParser.IAttrList attrs)
+		void ReadClientWellKnown (SmallXmlParser.IAttrList attrs)
 		{
 			string url = GetNotNull (attrs, "url");
 			string type = GetNotNull (attrs, "type");
@@ -761,7 +741,7 @@
 			typeEntries.Add (new WellKnownClientTypeEntry (type, assm, url));
 		}
 		
-		void ReadServiceWellKnown (MiniParser.IAttrList attrs)
+		void ReadServiceWellKnown (SmallXmlParser.IAttrList attrs)
 		{
 			string objectUri = GetNotNull (attrs, "objectUri");
 			string smode = GetNotNull (attrs, "mode");
@@ -776,7 +756,7 @@
 			typeEntries.Add (new WellKnownServiceTypeEntry (type, assm, objectUri, mode));
 		}
 		
-		void ReadInteropXml (MiniParser.IAttrList attrs, bool isElement)
+		void ReadInteropXml (SmallXmlParser.IAttrList attrs, bool isElement)
 		{
 			Type t = Type.GetType (GetNotNull (attrs, "clr"));
 			string[] xmlName = GetNotNull (attrs, "xml").Split (',');
@@ -787,7 +767,7 @@
 			else SoapServices.RegisterInteropXmlType (localName, ns, t);
 		}
 		
-		void ReadPreload (MiniParser.IAttrList attrs)
+		void ReadPreload (SmallXmlParser.IAttrList attrs)
 		{
 			string type = attrs.GetValue ("type");
 			string assm = attrs.GetValue ("assembly");
@@ -803,7 +783,7 @@
 				throw new RemotingException ("Either type or assembly attributes must be specified");
 		}
 					
-		string GetNotNull (MiniParser.IAttrList attrs, string name)
+		string GetNotNull (SmallXmlParser.IAttrList attrs, string name)
 		{
 			string value = attrs.GetValue (name);
 			if (value == null || value == "") 
@@ -823,7 +803,7 @@
 		
 		public void OnChars (string ch) {}
 		
-		public void OnEndParsing (MiniParser parser)
+		public void OnEndParsing (SmallXmlParser parser)
 		{
 			RemotingConfiguration.RegisterChannels (channelInstances, onlyDelayedChannels);
 			if (appName != null) RemotingConfiguration.ApplicationName = appName;