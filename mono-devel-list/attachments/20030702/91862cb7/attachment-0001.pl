/*	System.Web.UI.XhtmlTextWriter.cs
 *	Authors
 *		Jeremiah McElroy (jeremiah@facility9.com)
 */

 using System;
 using System.IO;
 using System.Collections;
 using System.Web;
 using System.Web.UI;

 namespace System.Web.UI
 {

	public class XhtmlTextWriter : System.IO.TextWriter 
	{
		// Fields
		private int _attrCount;
		private int _endTagCount;
		private int _inlineCount;
		private int _styleCount;
		private int _tagIndex;
		private int indentLevel;

		private bool _isDescendant;
		private bool tabsPending;

		private string _tagName;
		public const string DefaultTabString = "\t";
		public const char DoubleQuoteChar = '"';
		public const string EndTagLeftChars = "</";
		public const char EqualsChar = '=';
		public const string EqualsDoubleQuoteString = "=\"";		
		public const string SelfClosingChars = " /";
		public const string SelfClosingTagEnd = " />";
		public const char SemicolonChar = ';';
		public const char SingleQuoteChar = '\'';
		public const char SlashChar = '/';
		public const char SpaceChar = ' ';
		public const char StyleEqualsChar = ':';		
		private string tabString;
		public const char TagLeftChar = '<';
		public const char TagRightChar = '>';
		private static string[] _styleNameLookupArray;

		private static Hashtable _attrKeyLookupTable;
		private XhtmlRenderAttribute[] _attrList;
		private static AttributeInformation[] _attrNameLookupArray;
		private XhtmlTagStackEntry[] _endTags;
		private HttpWriter _httpWriter;
		private static Hashtable _styleKeyLookupTable;
		private XhtmlRenderStyle[] _styleList;
		private XhtmlTextWriterTag _tagKey;
		private static Hashtable _tagKeyLookupTable;
		private static XhtmlTagInformation[] _tagNameLookupArray;
		private TextWriter writer;

		// Properties
		public override System.Text.Encoding Encoding {
			get {
				return writer.Encoding;
			}
		}

		public int Indent {
			get {
				return indentLevel;
			}

			set {
				if (value < 0)
					value = 0;
				indentLevel = value;
			}
		}

		public System.IO.TextWriter InnerWriter {
			get {
				return writer;	
			}

			set {
				writer = value;
				_httpWriter = value as HttpWriter;
			}
		}

		public override String NewLine {
			get {
				return writer.NewLine;
			}

			set {
				writer.NewLine = value;
			}
		}

		protected System.Web.UI.XhtmlTextWriterTag TagKey {
			get {
				return _tagKey;
			}

			set {
				_tagIndex = (int) value;
				if (_tagIndex < 0 || _tagIndex >= (int) XhtmlTextWriter._tagNameLookupArray.Length)
					throw new ArgumentOutOfRangeException ("value");
				_tagKey = value;
				if (value != 0)
					_tagName = XhtmlTextWriter._tagNameLookupArray[_tagIndex].name;
			}
		}

		protected String TagName {
			get {
				return _tagName;
			}
			
			set {
				_tagName = value;
				_tagKey = GetTagKey (_tagName);
				_tagIndex = (int) _tagKey;
			}
		}

		// Methods
		public virtual void AddAttribute (XhtmlTextWriterAttribute key, string value)
		{
			if ( (int) key >= 0 && (int) key < XhtmlTextWriter._attrNameLookupArray.Length) {
				AttributeInformation attrInfo = XhtmlTextWriter._attrNameLookupArray [(int) key];
				AddAttribute (attrInfo.name, value, key, attrInfo.encode);
			}
		}

		public virtual void AddAttribute (XhtmlTextWriterAttribute key, string value, bool fEncode)
		{
			if ( (int) key >= 0 && (int) key < XhtmlTextWriter._attrNameLookupArray.Length) 
				AddAttribute(XhtmlTextWriter._attrNameLookupArray[(int) key].name, value, key, fEncode);
		}

		public virtual void AddAttribute (string name, string value)
		{
			XhtmlTextWriterAttribute attr = GetAttributeKey (name);
			value = EncodeAttributeValue (GetAttributeKey (name), value);
			AddAttribute (name, value, attr);
		}

		public virtual void AddAttribute (string name, string value, bool fEndode)
		{
			value = EncodeAttributeValue (value, fEndode);
			AddAttribute (name, value, GetAttributeKey(name));
		}

		protected virtual void AddAttribute (string name, string value, XhtmlTextWriterAttribute key)
		{
			AddAttribute (name, value, key, false);
		}

		private void AddAttribute (string name, string value, XhtmlTextWriterAttribute key, bool encode)
		{
			if (_attrCount >= (int) _attrList.Length) {
				XhtmlRenderAttribute[] rAttrArr = new XhtmlRenderAttribute [_attrList.Length * 2];
				System.Array.Copy (_attrList, rAttrArr, (int) _attrList.Length);
				_attrList = rAttrArr;
			}
			XhtmlRenderAttribute rAttr;
			rAttr.name = name;
			rAttr.value = value;
			rAttr.key = key;
			rAttr.encode = encode;
			_attrList [_attrCount++] = rAttr;
		}

		public virtual void AddStyleAttribute (XhtmlTextWriterStyle key, string value)
		{
			AddStyleAttribute (GetStyleName (key), value, key);
		}

		public virtual void AddStyleAttribute (string name, string value)
		{
			AddStyleAttribute (name, value, GetStyleKey (name));
		}

		protected virtual void AddStyleAttribute (string name, string value, XhtmlTextWriterStyle key)
		{
			XhtmlRenderStyle[] tagRender;
			XhtmlRenderStyle beforeTag;

			if (_styleCount >= (int) _styleList.Length) {
				XhtmlRenderStyle[] rAttrArr = new XhtmlRenderStyle [_styleList.Length * 2];
				System.Array.Copy (_styleList, rAttrArr, (int) _styleList.Length);
				_styleList = rAttrArr;
			}
			XhtmlRenderStyle rAttr;
			rAttr.name = name;
			rAttr.value = value;
			rAttr.key = key;
			_styleList [_styleCount++] = rAttr;
		}

		public override void Close()
		{
			writer.Close ();
		}

		protected virtual string EncodeAttributeValue (XhtmlTextWriterAttribute attrKey, string value)
		{
			bool valid = true;
			if (0 <= (int) attrKey && (int) attrKey < XhtmlTextWriter._attrNameLookupArray.Length)
				valid = XhtmlTextWriter._attrNameLookupArray[(int) attrKey].encode;
			return EncodeAttributeValue (value, valid);
		}

		protected string EncodeAttributeValue (string value, bool fEncode)
		{
			if (value == null)
				return null;
			if (!(fEncode))
				return value;
			return System.Web.HttpUtility.HtmlAttributeEncode (value);
		}

		protected string EncodeUrl (string url)
		{
			if (url.IndexOf (SpaceChar) < 0)
				return url;
			System.Text.StringBuilder sb = new System.Text.StringBuilder();
			for (int i = 0; i <= url.Length; i++) {
				char temp = url[i];
				if (temp != 32)
					sb.Append (temp);
				else
					sb.Append ("%20");
			}
			return sb.ToString ();
		}

		protected virtual void FilterAttributes ()
		{
			int count = 0;
			for (int i = 0; i < _styleCount; i++) {
				XhtmlRenderStyle rStyle = _styleList[i];
				if (OnStyleAttributeRender (rStyle.name, rStyle.value, rStyle.key)) {
					count++;
				}
			}
			_styleCount = count;
			count = 0;
			for (int i=0; i <= _attrCount; i++) {
				XhtmlRenderAttribute rAttr = _attrList[i];
				if (OnAttributeRender (rAttr.name, rAttr.value, rAttr.key)) {
					count++;
				}
			}
			_attrCount = count;
		}

		public override void Flush ()
		{
			writer.Flush ();
		}

		protected XhtmlTextWriterAttribute GetAttributeKey (string attrName)
		{
			if (attrName != null && attrName.Length > 0) {
				object attr = XhtmlTextWriter._attrKeyLookupTable[attrName.ToLower ()];
				if (attr != null)
					return (XhtmlTextWriterAttribute) attr;
			}
			return (XhtmlTextWriterAttribute) (-1);
		}

		protected string GetAttributeName (XhtmlTextWriterAttribute attrKey)
		{
			if ((int) attrKey >= 0 && (int) attrKey < XhtmlTextWriter._attrNameLookupArray.Length)
				return XhtmlTextWriter._attrNameLookupArray[(int) attrKey].name;
			return System.String.Empty;
		}

		protected XhtmlTextWriterStyle GetStyleKey (string styleName)
		{
			if (styleName != null && styleName.Length > 0) {
				object style = XhtmlTextWriter._styleKeyLookupTable[styleName.ToLower ()];
				if (style != null)
					return (XhtmlTextWriterStyle) style;
			}
			return (XhtmlTextWriterStyle) (-1);
		}

		protected string GetStyleName (XhtmlTextWriterStyle styleKey)
		{
			if ((int) styleKey >= 0 && (int) styleKey < XhtmlTextWriter._styleNameLookupArray.Length)
				return XhtmlTextWriter._styleNameLookupArray[(int) styleKey];
			return System.String.Empty;
		}

		protected virtual XhtmlTextWriterTag GetTagKey (string tagName)
		{
			if (tagName != null && tagName.Length > 0) {
				object tag = XhtmlTextWriter._tagKeyLookupTable[tagName.ToLower ()];
				if (tag != null)
					return (XhtmlTextWriterTag) tag;
			}
			return 0;
		}

		protected virtual string GetTagName (XhtmlTextWriterTag tagKey)
		{
			if ((int) tagKey >= 0 && (int) tagKey < XhtmlTextWriter._tagNameLookupArray.Length)
				return XhtmlTextWriter._tagNameLookupArray[(int) tagKey].name;
			return System.String.Empty;
		}

		protected bool IsAttributeDefined (XhtmlTextWriterAttribute key)
		{
			for (int i=0; i < _attrCount; i++) {
				if (_attrList[i].key == key)
					return true;
			}
			return false;
		}

		protected bool IsAttributeDefined (XhtmlTextWriterAttribute key, ref string value)
		{
			value = null;
			for (int i=0; i < _attrCount; i++) {
				if (_attrList[i].key == key) {
					value = _attrList[i].value;
					return true;
				}
			}
			return false;
		}

		protected bool IsStyleAttributeDefined (XhtmlTextWriterStyle key)
		{
			for (int i= 0; i < _styleCount; i++) {
				if (_styleList[i].key == key)
					return true;
			}
			return false;
		}

		protected bool IsStyleAttributeDefined (XhtmlTextWriterStyle key, ref string value)
		{
			value = null;
			for ( int i=0; i < _styleCount; i++) {
				if (_styleList[i].key == key) {
					value = _styleList[i].value;
					return true;
				}
			}
			return false;
		}

		protected virtual bool OnAttributeRender (string name, string value, XhtmlTextWriterAttribute key)
		{
			return true;
		}

		protected virtual bool OnStyleAttributeRender (string name, string value, XhtmlTextWriterStyle key)
		{
			return true;
		}

		protected virtual bool OnTagRender (string name, XhtmlTextWriterTag key)
		{
			return true;
		}

		protected virtual void OutputTabs ()
		{
			if (tabsPending) {
				for (int i=0; i <= indentLevel; i++) {
					writer.Write (tabString);
				}
				tabsPending = false;
			}
		}

		protected string PopEndTag ()
		{
			if (_endTagCount <= 0)
				throw new InvalidOperationException ("A PopEndTag was called without a corresponding PushEndTag");
			_endTagCount--;
			TagKey = _endTags[_endTagCount].tagKey;
			return _endTags[_endTagCount].endTagText;
		}

		protected void PushEndTag (string endTag)
		{
			if (_endTagCount >= (int) _endTags.Length) {
				XhtmlTagStackEntry[] temp = new XhtmlTagStackEntry [(int) _endTags.Length * 2];
				System.Array.Copy (_endTags, temp, (int) _endTags.Length);
				_endTags = temp;
			}
			_endTags[_endTagCount].tagKey = _tagKey;
			_endTags[_endTagCount].endTagText = endTag;
			_endTagCount++;
		}

		protected static void RegisterAttribute (string name, XhtmlTextWriterAttribute key)
		{
			XhtmlTextWriter.RegisterAttribute (name, key, false);
		}

		private static void RegisterAttribute (string name, XhtmlTextWriterAttribute key, bool fEncode)
		{
			name = name.ToLower ();
			XhtmlTextWriter._attrKeyLookupTable.Add (name, key);
			if ((int) key < (int) XhtmlTextWriter._attrNameLookupArray.Length)
				XhtmlTextWriter._attrNameLookupArray[(int) key] = new AttributeInformation (name, fEncode);
		}

		protected static void RegisterStyle (string name, XhtmlTextWriterStyle key)
		{
			name = name.ToLower ();
			XhtmlTextWriter._styleKeyLookupTable.Add (name, key);
			if ((int) key < (int) XhtmlTextWriter._styleNameLookupArray.Length)
				XhtmlTextWriter._styleNameLookupArray[(int) key] = name;
		}

		protected static void RegisterTag (string name, XhtmlTextWriterTag key)
		{
			XhtmlTextWriter.RegisterTag (name, key, XhtmlTagType.Other);
		}

		private static void RegisterTag (string name, XhtmlTextWriterTag key, XhtmlTagType type)
		{
			name = name.ToLower ();
			XhtmlTextWriter._tagKeyLookupTable.Add (name, key);
			string fullTag = null;
			if ((int) type != 1 && (int) key != 0) {
				fullTag = EndTagLeftChars + name + TagRightChar;
			}
			if ((int) key < XhtmlTextWriter._tagNameLookupArray.Length)
				XhtmlTextWriter._tagNameLookupArray [(int) key] = new XhtmlTagInformation (name, type, fullTag);
		}

		protected virtual string RenderAfterContent ()
		{
			return null;
		}

		protected virtual string RenderAfterTag ()
		{
			return null;
		}

		protected virtual string RenderBeforeContent ()
		{
			return null;
		}

		protected virtual string RenderBeforeTag ()
		{
			return null;
		}

		public virtual void RenderBeginTag (XhtmlTextWriterTag tagKey)
		{
			TagKey = tagKey;
			bool tagRendered = true;
			bool tagRender = true;
			if (_isDescendant) {
				tagRender = OnTagRender (_tagName, _tagKey);
				FilterAttributes ();
				string beforeTag = RenderBeforeTag ();
				if (beforeTag != null) {
					if (tabsPending)
						OutputTabs ();
					writer.Write (beforeTag);
				}
			}
			XhtmlTagInformation currentTag = XhtmlTextWriter._tagNameLookupArray[_tagIndex];
			if (tagRender) {
				tagRendered = false;
				if (tabsPending)
					OutputTabs ();
				writer.Write (TagLeftChar);
				writer.Write (_tagName);
				XhtmlRenderAttribute rAttr;
				string rAttrValue = null;
				for (int i=0; i < _attrCount; i++) {
					rAttr = _attrList[i];
					if (rAttr.key == XhtmlTextWriterAttribute.Style)
						rAttrValue = rAttr.value;
					else {
						writer.Write (SpaceChar);
						writer.Write (rAttr.name);
						if (rAttr.value != null) {
							writer.Write (EqualsChar);
							writer.Write (DoubleQuoteChar);
							if (rAttr.encode) {
								if (_httpWriter == null) {
									System.Web.HttpUtility.HtmlAttributeEncode (rAttr.value, writer);
								}
								else {
									System.Web.HttpUtility.HtmlAttributeEncode (rAttr.value, (TextWriter) _httpWriter);
								}
							}
							else {
								writer.Write (rAttr.value);
							}
							writer.Write (DoubleQuoteChar);
						}
					}
				}
				if (_styleCount > 0 || rAttrValue != null) {
					writer.Write (SpaceChar);
					writer.Write ("style");
					writer.Write (EqualsChar);
					writer.Write (DoubleQuoteChar);
					XhtmlRenderStyle rStyle;
					for (int i=0; i < _styleCount; i++) {
						rStyle = _styleList[i];
						writer.Write (rStyle.name);
						writer.Write (StyleEqualsChar);
						writer.Write (rStyle.value);
						writer.Write (SemicolonChar);
					}
					if (rAttrValue != null)
						writer.Write (rAttrValue);
					writer.Write (DoubleQuoteChar);
				}
				if (currentTag.tagType == XhtmlTagType.Empty) {
					writer.Write (SpaceChar);
					writer.Write (SlashChar);
					writer.Write (TagRightChar);
				}
				else
					writer.Write (TagRightChar);
			}
			string beforeContent = RenderBeforeContent ();
			if (beforeContent != null) {
				if (tabsPending)
					OutputTabs ();
				writer.Write (beforeContent);
			}
			if (tagRendered) {
				if (currentTag.tagType == XhtmlTagType.Inline)
					_inlineCount++;
				else {
					WriteLine ();
					Indent++;
				}
				if (currentTag.closingTag == null) {
					currentTag.closingTag = EndTagLeftChars + _tagName + TagRightChar;
				}
			}
			if (_isDescendant) {
				string afterContent = RenderAfterContent ();
				if (afterContent != null) {
					if (currentTag.closingTag != null)
						currentTag.closingTag = afterContent;
				}
				string afterTag = RenderAfterTag ();
				if (afterTag != null) {
					if (currentTag.closingTag != null)
						currentTag.closingTag = afterTag;
				}
			}
			PushEndTag (currentTag.closingTag);
			_attrCount = 0;
			_styleCount = 0;
		}

		public virtual void RenderBeginTag (string tagName)
		{
			TagName = tagName;
			RenderBeginTag (_tagKey);
		}

		public virtual void RenderEndTag ()
		{
			string endTagText = PopEndTag ();
			if (endTagText != null) {
				if (XhtmlTextWriter._tagNameLookupArray [_tagIndex].tagType == 0) {
					_inlineCount--;
					Write (endTagText);
				}
				else{
					WriteLine ();
					Indent--;
					Write (endTagText);
				}
			}
		}

		public override void Write (bool value)
		{
			if (tabsPending)
				OutputTabs ();
			writer.Write (value);
		}

		public override void Write (char value)
		{
			if (tabsPending)
				OutputTabs ();
			writer.Write (value);
		}

		public override void Write (char[] buffer)
		{
			if (tabsPending)
				OutputTabs ();
			writer.Write (buffer);
		}

		public override void Write (char[] buffer, int index, int count)
		{
			if (tabsPending)
				OutputTabs ();
			writer.Write (buffer, index, count);
		}

		public override void Write (double value)
		{
			if (tabsPending)
				OutputTabs ();
			writer.Write (value);
		}

		public override void Write (int value)
		{
			if (tabsPending)
				OutputTabs ();
			writer.Write (value);
		}

		public override void Write (long value)
		{
			if (tabsPending)
				OutputTabs ();
			writer.Write (value);
		}

		public override void Write (object value)
		{
			if (tabsPending)
				OutputTabs ();
			writer.Write (value);
		}

		public override void Write (float value)
		{
			if (tabsPending)
				OutputTabs ();
			writer.Write (value);
		}

		public override void Write (string s)
		{
			if (tabsPending)
				OutputTabs ();
			writer.Write (s);
		}

		public override void Write (string format, object arg0)
		{
			if (tabsPending)
				OutputTabs ();
			writer.Write (format, arg0);
		}

		public override void Write (string format, object arg0, object arg1)
		{
			if (tabsPending)
				OutputTabs ();
			writer.Write (format, arg0, arg1);
		}

		public override void Write (string format, params object[] arg)
		{
			if (tabsPending)
				OutputTabs ();
			writer.Write (format, arg);
		}

		public virtual void WriteAttribute (string name, string value)
		{
			WriteAttribute (name, value, false);
		}

		public virtual void WriteAttribute (string name, string value, bool fEncode)
		{
			writer.Write (SpaceChar);
			writer.Write (name);
			if (value != null) {
				writer.Write (EqualsChar);
				writer.Write (DoubleQuoteChar);
				if (fEncode) {
					if (_httpWriter == null) {
						System.Web.HttpUtility.HtmlAttributeEncode (value, writer);
					}
					else{
						System.Web.HttpUtility.HtmlAttributeEncode (value, (TextWriter) _httpWriter);
					}
				}
				else{
					writer.Write (value);
				}
				writer.Write (DoubleQuoteChar);
			}
		}

		public virtual void WriteBeginTag (string tagName)
		{
			if (tabsPending)
				OutputTabs ();
			writer.Write (TagLeftChar);
			writer.Write (tagName);
		}

		public virtual void WriteEndTag (string tagName)
		{
			if (tabsPending)
				OutputTabs ();
			writer.Write (TagLeftChar);
			writer.Write (SlashChar);
			writer.Write (tagName);
			writer.Write (TagRightChar);
		}

		public virtual void WriteFullBeginTag (string tagName)
		{
			if (tabsPending)
				OutputTabs ();
			writer.Write (TagLeftChar);
			writer.Write (tagName);
			writer.Write (TagRightChar);
		}

		public override void WriteLine ()
		{
			writer.WriteLine ();
			tabsPending = true;
		}

		public override void WriteLine (bool value)
		{
			if (tabsPending)
				OutputTabs ();
			writer.WriteLine (value);
			tabsPending = true;
		}

		public override void WriteLine (char value)
		{
			if (tabsPending)
				OutputTabs ();
			writer.WriteLine (value);
			tabsPending = true;
		}

		public override void WriteLine (char[] buffer)
		{
			if (tabsPending)
				OutputTabs ();
			writer.WriteLine (buffer);
			tabsPending = true;
		}

		public override void WriteLine (char[] buffer, int index, int count)
		{
			if (tabsPending)
				OutputTabs ();
			writer.WriteLine (buffer, index, count);
			tabsPending = true;
		}

		public override void WriteLine (double value)
		{
			if (tabsPending)
				OutputTabs ();
			writer.WriteLine (value);
			tabsPending = true;
		}

		public override void WriteLine (int value)
		{
			if (tabsPending)
				OutputTabs ();
			writer.WriteLine (value);
			tabsPending = true;
		}

		public override void WriteLine (long value)
		{
			if (tabsPending)
				OutputTabs ();
			writer.WriteLine (value);
			tabsPending = true;
		}

		public override void WriteLine (object value)
		{
			if (tabsPending)
				OutputTabs ();
			writer.WriteLine (value);
			tabsPending = true;
		}

		public override void WriteLine (float value)
		{
			if (tabsPending)
				OutputTabs ();
			writer.WriteLine (value);
			tabsPending = true;
		}

		public override void WriteLine (string s)
		{
			if (tabsPending)
				OutputTabs ();
			writer.WriteLine (s);
			tabsPending = true;
		}

		public override void WriteLine (string format, object arg0)
		{
			if (tabsPending)
				OutputTabs ();
			writer.WriteLine (format, arg0);
			tabsPending = true;
		}

		public override void WriteLine (string format, object arg0, object arg1)
		{
			if (tabsPending)
				OutputTabs ();
			writer.WriteLine (format, arg0, arg1);
			tabsPending = true;
		}

		public override void WriteLine (string format, params object[] arg)
		{
			if (tabsPending)
				OutputTabs ();
			writer.WriteLine (format, arg);
			tabsPending = true;
		}

		[CLSCompliant(false)]
		public override void WriteLine (uint value)
		{
			if (tabsPending)
				OutputTabs ();
			writer.WriteLine (value);
			tabsPending = true;
		}

		public void WriteLineNoTabs (string s)
		{
			writer.WriteLine (s);
		}

		public virtual void WriteStyleAttribute (string name, string value)
		{
			WriteStyleAttribute (name, value, false);
		}

		public virtual void WriteStyleAttribute (string name, string value, bool fEncode)
		{
			writer.Write (name);
			writer.Write (StyleEqualsChar);
			if (fEncode) {
				if (_httpWriter == null) {
					System.Web.HttpUtility.HtmlAttributeEncode (value, writer);
				}
				else{
					System.Web.HttpUtility.HtmlAttributeEncode (value, (TextWriter) _httpWriter);
				}
			}
			else {
				writer.Write (value);
			}
			writer.Write (SemicolonChar);
		}

		// Constructors
		public XhtmlTextWriter (TextWriter writer) : this (writer, " ") {}

		public XhtmlTextWriter (TextWriter writer, string tabString) 
		{
			this.writer = writer;
			this.tabString = tabString;
			indentLevel = 0;
			tabsPending = false;
			_httpWriter = writer as HttpWriter;
			_isDescendant = GetType () == typeof (XhtmlTextWriter) == false;
			_attrList = new XhtmlRenderAttribute[88];
			_attrCount = 0;
			_styleList = new XhtmlRenderStyle[20];
			_endTags = new XhtmlTagStackEntry[16];
			_endTagCount = 0;
			_inlineCount = 0;
		}

		static XhtmlTextWriter () 
		{
			XhtmlTextWriter._tagKeyLookupTable = new Hashtable (89);
			XhtmlTextWriter._tagNameLookupArray = new XhtmlTagInformation [89];

			XhtmlTextWriter.RegisterTag ("", XhtmlTextWriterTag.Unknown, XhtmlTagType.Other);
			XhtmlTextWriter.RegisterTag ("a", XhtmlTextWriterTag.A, XhtmlTagType.Inline);
			XhtmlTextWriter.RegisterTag ("abbr", XhtmlTextWriterTag.Abbr, XhtmlTagType.Inline);
			XhtmlTextWriter.RegisterTag ("acronym", XhtmlTextWriterTag.Acronym, XhtmlTagType.Inline);
			XhtmlTextWriter.RegisterTag ("address", XhtmlTextWriterTag.Address, XhtmlTagType.Inline);
			XhtmlTextWriter.RegisterTag ("applet", XhtmlTextWriterTag.Applet, XhtmlTagType.Other);
			XhtmlTextWriter.RegisterTag ("area", XhtmlTextWriterTag.Area, XhtmlTagType.Other);
			XhtmlTextWriter.RegisterTag ("b", XhtmlTextWriterTag.B, XhtmlTagType.Inline);
			XhtmlTextWriter.RegisterTag ("base", XhtmlTextWriterTag.Base, XhtmlTagType.Empty);
			XhtmlTextWriter.RegisterTag ("basefont", XhtmlTextWriterTag.BaseFont, XhtmlTagType.Empty);
			XhtmlTextWriter.RegisterTag ("bdo", XhtmlTextWriterTag.Bdo, XhtmlTagType.Inline);
			XhtmlTextWriter.RegisterTag ("big", XhtmlTextWriterTag.Big, XhtmlTagType.Inline);
			XhtmlTextWriter.RegisterTag ("blockquote", XhtmlTextWriterTag.Blockquote, XhtmlTagType.Flow);
			XhtmlTextWriter.RegisterTag ("body", XhtmlTextWriterTag.Body, XhtmlTagType.Flow);
			XhtmlTextWriter.RegisterTag ("br", XhtmlTextWriterTag.Br, XhtmlTagType.Empty);
			XhtmlTextWriter.RegisterTag ("button", XhtmlTextWriterTag.Button, XhtmlTagType.Inline);
			XhtmlTextWriter.RegisterTag ("caption", XhtmlTextWriterTag.Caption, XhtmlTagType.Inline);
			XhtmlTextWriter.RegisterTag ("center", XhtmlTextWriterTag.Center, XhtmlTagType.Flow);
			XhtmlTextWriter.RegisterTag ("cite", XhtmlTextWriterTag.Cite, XhtmlTagType.Inline);
			XhtmlTextWriter.RegisterTag ("col", XhtmlTextWriterTag.Col, XhtmlTagType.Empty);
			XhtmlTextWriter.RegisterTag ("colgroup", XhtmlTextWriterTag.ColGroup, XhtmlTagType.Other);
			XhtmlTextWriter.RegisterTag ("dd", XhtmlTextWriterTag.Dd, XhtmlTagType.Flow);
			XhtmlTextWriter.RegisterTag ("del", XhtmlTextWriterTag.Del, XhtmlTagType.Flow);
			XhtmlTextWriter.RegisterTag ("dfn", XhtmlTextWriterTag.Dfn, XhtmlTagType.Inline);
			XhtmlTextWriter.RegisterTag ("dir", XhtmlTextWriterTag.Dir, XhtmlTagType.Other);
			XhtmlTextWriter.RegisterTag ("div", XhtmlTextWriterTag.Div, XhtmlTagType.Flow);
			XhtmlTextWriter.RegisterTag ("dl", XhtmlTextWriterTag.Dl, XhtmlTagType.Block);
			XhtmlTextWriter.RegisterTag ("dt", XhtmlTextWriterTag.Dt, XhtmlTagType.Inline);
			XhtmlTextWriter.RegisterTag ("em", XhtmlTextWriterTag.Em, XhtmlTagType.Inline);
			XhtmlTextWriter.RegisterTag ("fieldset", XhtmlTextWriterTag.FieldSet, XhtmlTagType.PcData);
			XhtmlTextWriter.RegisterTag ("font", XhtmlTextWriterTag.Font, XhtmlTagType.Inline);
			XhtmlTextWriter.RegisterTag ("form", XhtmlTextWriterTag.Form, XhtmlTagType.Block);
			XhtmlTextWriter.RegisterTag ("frameset", XhtmlTextWriterTag.FrameSet, XhtmlTagType.Other);
			XhtmlTextWriter.RegisterTag ("frame", XhtmlTextWriterTag.Frame, XhtmlTagType.Empty);
			XhtmlTextWriter.RegisterTag ("h1", XhtmlTextWriterTag.H1, XhtmlTagType.Inline);
			XhtmlTextWriter.RegisterTag ("h2", XhtmlTextWriterTag.H2, XhtmlTagType.Inline);
			XhtmlTextWriter.RegisterTag ("h3", XhtmlTextWriterTag.H3, XhtmlTagType.Inline);
			XhtmlTextWriter.RegisterTag ("h4", XhtmlTextWriterTag.H4, XhtmlTagType.Inline);
			XhtmlTextWriter.RegisterTag ("h5", XhtmlTextWriterTag.H5, XhtmlTagType.Inline);
			XhtmlTextWriter.RegisterTag ("h6", XhtmlTextWriterTag.H6, XhtmlTagType.Inline);
			XhtmlTextWriter.RegisterTag ("head", XhtmlTextWriterTag.Head, XhtmlTagType.Other);
			XhtmlTextWriter.RegisterTag ("hr", XhtmlTextWriterTag.Hr, XhtmlTagType.Empty);
			XhtmlTextWriter.RegisterTag ("html", XhtmlTextWriterTag.Html, XhtmlTagType.Other);
			XhtmlTextWriter.RegisterTag ("i", XhtmlTextWriterTag.I, XhtmlTagType.Inline);
			XhtmlTextWriter.RegisterTag ("iframe", XhtmlTextWriterTag.IFrame, XhtmlTagType.Flow);
			XhtmlTextWriter.RegisterTag ("img", XhtmlTextWriterTag.Img, XhtmlTagType.Empty);
			XhtmlTextWriter.RegisterTag ("input", XhtmlTextWriterTag.Input, XhtmlTagType.Empty);
			XhtmlTextWriter.RegisterTag ("ins", XhtmlTextWriterTag.Ins, XhtmlTagType.Flow);
			XhtmlTextWriter.RegisterTag ("isindex", XhtmlTextWriterTag.IsIndex, XhtmlTagType.Empty);
			XhtmlTextWriter.RegisterTag ("kbd", XhtmlTextWriterTag.Kbd, XhtmlTagType.Inline);
			XhtmlTextWriter.RegisterTag ("label", XhtmlTextWriterTag.Label, XhtmlTagType.Inline);
			XhtmlTextWriter.RegisterTag ("legend", XhtmlTextWriterTag.Legend, XhtmlTagType.Inline);
			XhtmlTextWriter.RegisterTag ("li", XhtmlTextWriterTag.Li, XhtmlTagType.Flow);
			XhtmlTextWriter.RegisterTag ("link", XhtmlTextWriterTag.Link, XhtmlTagType.Empty);
			XhtmlTextWriter.RegisterTag ("map", XhtmlTextWriterTag.Map, XhtmlTagType.Block);
			XhtmlTextWriter.RegisterTag ("menu", XhtmlTextWriterTag.Menu, XhtmlTagType.Block);
			XhtmlTextWriter.RegisterTag ("meta", XhtmlTextWriterTag.Meta, XhtmlTagType.Empty);
			XhtmlTextWriter.RegisterTag ("noframes", XhtmlTextWriterTag.NoFrames, XhtmlTagType.Flow);
			XhtmlTextWriter.RegisterTag ("object", XhtmlTextWriterTag.Object, XhtmlTagType.Other);
			XhtmlTextWriter.RegisterTag ("ol", XhtmlTextWriterTag.Ol, XhtmlTagType.Block);
			XhtmlTextWriter.RegisterTag ("optgroup", XhtmlTextWriterTag.OptGroup, XhtmlTagType.Other);
			XhtmlTextWriter.RegisterTag ("option", XhtmlTextWriterTag.Option, XhtmlTagType.Flow);
			XhtmlTextWriter.RegisterTag ("p", XhtmlTextWriterTag.P, XhtmlTagType.Inline);
			XhtmlTextWriter.RegisterTag ("param", XhtmlTextWriterTag.Param, XhtmlTagType.Empty);
			XhtmlTextWriter.RegisterTag ("pre", XhtmlTextWriterTag.Pre, XhtmlTagType.Other);
			XhtmlTextWriter.RegisterTag ("q", XhtmlTextWriterTag.Q, XhtmlTagType.Inline);
			XhtmlTextWriter.RegisterTag ("s", XhtmlTextWriterTag.S, XhtmlTagType.Inline);
			XhtmlTextWriter.RegisterTag ("samp", XhtmlTextWriterTag.Samp, XhtmlTagType.Inline);
			XhtmlTextWriter.RegisterTag ("script", XhtmlTextWriterTag.Script, XhtmlTagType.PcData);
			XhtmlTextWriter.RegisterTag ("select", XhtmlTextWriterTag.Select, XhtmlTagType.Inline);
			XhtmlTextWriter.RegisterTag ("small", XhtmlTextWriterTag.Small, XhtmlTagType.Inline);
			XhtmlTextWriter.RegisterTag ("span", XhtmlTextWriterTag.Span, XhtmlTagType.Inline);
			XhtmlTextWriter.RegisterTag ("strike", XhtmlTextWriterTag.Strike, XhtmlTagType.Inline);
			XhtmlTextWriter.RegisterTag ("strong", XhtmlTextWriterTag.Strong, XhtmlTagType.Inline);
			XhtmlTextWriter.RegisterTag ("style", XhtmlTextWriterTag.Style, XhtmlTagType.PcData);
			XhtmlTextWriter.RegisterTag ("sub", XhtmlTextWriterTag.Sub, XhtmlTagType.Inline);
			XhtmlTextWriter.RegisterTag ("sup", XhtmlTextWriterTag.Sup, XhtmlTagType.Inline);
			XhtmlTextWriter.RegisterTag ("table", XhtmlTextWriterTag.Table, XhtmlTagType.Block);
			XhtmlTextWriter.RegisterTag ("td", XhtmlTextWriterTag.Td, XhtmlTagType.Flow);
			XhtmlTextWriter.RegisterTag ("textarea", XhtmlTextWriterTag.TextArea, XhtmlTagType.Inline);
			XhtmlTextWriter.RegisterTag ("tfoot", XhtmlTextWriterTag.TFoot, XhtmlTagType.Other);
			XhtmlTextWriter.RegisterTag ("th", XhtmlTextWriterTag.Th, XhtmlTagType.Other);
			XhtmlTextWriter.RegisterTag ("thead", XhtmlTextWriterTag.THead, XhtmlTagType.Other);
			XhtmlTextWriter.RegisterTag ("title", XhtmlTextWriterTag.Title, XhtmlTagType.PcData);
			XhtmlTextWriter.RegisterTag ("tr", XhtmlTextWriterTag.Tr, XhtmlTagType.Other);
			XhtmlTextWriter.RegisterTag ("tt", XhtmlTextWriterTag.Tt, XhtmlTagType.Inline);
			XhtmlTextWriter.RegisterTag ("u", XhtmlTextWriterTag.U, XhtmlTagType.Inline);
			XhtmlTextWriter.RegisterTag ("ul", XhtmlTextWriterTag.Ul, XhtmlTagType.Block);
			XhtmlTextWriter.RegisterTag ("var", XhtmlTextWriterTag.Var, XhtmlTagType.Inline);

			XhtmlTextWriter._attrKeyLookupTable = new Hashtable (95);
			XhtmlTextWriter._attrNameLookupArray = new AttributeInformation [95];

			// FIXME
			// I've guessed at many of the fEncode values.
			// Where a value was given in HtmlTextWriter.cs I have used that value.
			XhtmlTextWriter.RegisterAttribute ("accept", XhtmlTextWriterAttribute.Accept, true);
			XhtmlTextWriter.RegisterAttribute ("accept-charset", XhtmlTextWriterAttribute.AcceptCharset, true);
			XhtmlTextWriter.RegisterAttribute ("acceskey", XhtmlTextWriterAttribute.AccessKey, true);
			XhtmlTextWriter.RegisterAttribute ("align", XhtmlTextWriterAttribute.Align, false);
			XhtmlTextWriter.RegisterAttribute ("alink", XhtmlTextWriterAttribute.ALink, false);
			XhtmlTextWriter.RegisterAttribute ("alt", XhtmlTextWriterAttribute.Alt, true);
			XhtmlTextWriter.RegisterAttribute ("archive", XhtmlTextWriterAttribute.Archive, false);
			XhtmlTextWriter.RegisterAttribute ("background", XhtmlTextWriterAttribute.Background, false);
			XhtmlTextWriter.RegisterAttribute ("bgcolor", XhtmlTextWriterAttribute.BgColor, false);
			XhtmlTextWriter.RegisterAttribute ("border", XhtmlTextWriterAttribute.Border, false);
			XhtmlTextWriter.RegisterAttribute ("cellpadding", XhtmlTextWriterAttribute.CellPadding, false);
			XhtmlTextWriter.RegisterAttribute ("cellspacing", XhtmlTextWriterAttribute.CellSpacing, false);
			XhtmlTextWriter.RegisterAttribute ("charset", XhtmlTextWriterAttribute.Charset, false);
			XhtmlTextWriter.RegisterAttribute ("checked", XhtmlTextWriterAttribute.Checked, false);
			XhtmlTextWriter.RegisterAttribute ("cite", XhtmlTextWriterAttribute.Cite, false);
			XhtmlTextWriter.RegisterAttribute ("class", XhtmlTextWriterAttribute.Class, true);
			XhtmlTextWriter.RegisterAttribute ("classid", XhtmlTextWriterAttribute.ClassId, true);
			XhtmlTextWriter.RegisterAttribute ("codebase", XhtmlTextWriterAttribute.CodeBase, true);
			XhtmlTextWriter.RegisterAttribute ("codetype", XhtmlTextWriterAttribute.CodeType, true);
			XhtmlTextWriter.RegisterAttribute ("cols", XhtmlTextWriterAttribute.Cols, false);
			XhtmlTextWriter.RegisterAttribute ("colspan", XhtmlTextWriterAttribute.ColSpan, false);
			XhtmlTextWriter.RegisterAttribute ("compact", XhtmlTextWriterAttribute.Compact, false);
			XhtmlTextWriter.RegisterAttribute ("content", XhtmlTextWriterAttribute.Content, false);
			XhtmlTextWriter.RegisterAttribute ("coords", XhtmlTextWriterAttribute.Coords, false);
			XhtmlTextWriter.RegisterAttribute ("data", XhtmlTextWriterAttribute.Data, true);
			XhtmlTextWriter.RegisterAttribute ("datetime", XhtmlTextWriterAttribute.DateTime, true);
			XhtmlTextWriter.RegisterAttribute ("declare", XhtmlTextWriterAttribute.Declare, true);
			XhtmlTextWriter.RegisterAttribute ("defer", XhtmlTextWriterAttribute.Defer, true);
			XhtmlTextWriter.RegisterAttribute ("dir", XhtmlTextWriterAttribute.Dir, true);
			XhtmlTextWriter.RegisterAttribute ("disabled", XhtmlTextWriterAttribute.Disabled, false);
			XhtmlTextWriter.RegisterAttribute ("enctype", XhtmlTextWriterAttribute.EncType, true);
			XhtmlTextWriter.RegisterAttribute ("for", XhtmlTextWriterAttribute.For, true);
			XhtmlTextWriter.RegisterAttribute ("frameborder", XhtmlTextWriterAttribute.FrameBorder, false);
			XhtmlTextWriter.RegisterAttribute ("height", XhtmlTextWriterAttribute.Height, false);
			XhtmlTextWriter.RegisterAttribute ("href", XhtmlTextWriterAttribute.Href, true);
			XhtmlTextWriter.RegisterAttribute ("hreflang", XhtmlTextWriterAttribute.HrefLang, true);
			XhtmlTextWriter.RegisterAttribute ("http-equiv", XhtmlTextWriterAttribute.HttpEquiv, false);
			XhtmlTextWriter.RegisterAttribute ("id", XhtmlTextWriterAttribute.Id, false);
			XhtmlTextWriter.RegisterAttribute ("ismap", XhtmlTextWriterAttribute.IsMap, true);
			XhtmlTextWriter.RegisterAttribute ("lang", XhtmlTextWriterAttribute.Lang, true);
			XhtmlTextWriter.RegisterAttribute ("language", XhtmlTextWriterAttribute.Language, true);
			XhtmlTextWriter.RegisterAttribute ("link", XhtmlTextWriterAttribute.Link, true);
			XhtmlTextWriter.RegisterAttribute ("longdesc", XhtmlTextWriterAttribute.LongDesc, true);
			XhtmlTextWriter.RegisterAttribute ("marginheight", XhtmlTextWriterAttribute.MarginHeight, false);
			XhtmlTextWriter.RegisterAttribute ("marginwidth", XhtmlTextWriterAttribute.MarginWidth, false);
			XhtmlTextWriter.RegisterAttribute ("maxlength", XhtmlTextWriterAttribute.MaxLength, true);
			XhtmlTextWriter.RegisterAttribute ("media", XhtmlTextWriterAttribute.Media, true);
			XhtmlTextWriter.RegisterAttribute ("multiple", XhtmlTextWriterAttribute.Multiple, true);
			XhtmlTextWriter.RegisterAttribute ("name", XhtmlTextWriterAttribute.Name, true);
			XhtmlTextWriter.RegisterAttribute ("nohref", XhtmlTextWriterAttribute.NoHref, true);
			XhtmlTextWriter.RegisterAttribute ("noshade", XhtmlTextWriterAttribute.NoShade, false);
			XhtmlTextWriter.RegisterAttribute ("object", XhtmlTextWriterAttribute.Object, true);
			XhtmlTextWriter.RegisterAttribute ("onblur", XhtmlTextWriterAttribute.OnBlur, true);
			XhtmlTextWriter.RegisterAttribute ("onchange", XhtmlTextWriterAttribute.OnChange, true);
			XhtmlTextWriter.RegisterAttribute ("onclick", XhtmlTextWriterAttribute.OnClick, true);
			XhtmlTextWriter.RegisterAttribute ("ondblclick", XhtmlTextWriterAttribute.OnDblClick, true);
			XhtmlTextWriter.RegisterAttribute ("onfocus", XhtmlTextWriterAttribute.OnFocus, true);
			XhtmlTextWriter.RegisterAttribute ("onkeydown", XhtmlTextWriterAttribute.OnKeyDown, true);
			XhtmlTextWriter.RegisterAttribute ("onkeypress", XhtmlTextWriterAttribute.OnKeyPress, true);
			XhtmlTextWriter.RegisterAttribute ("onkeyup", XhtmlTextWriterAttribute.OnKeyUp, true);
			XhtmlTextWriter.RegisterAttribute ("onload", XhtmlTextWriterAttribute.OnLoad, true);
			XhtmlTextWriter.RegisterAttribute ("onmousedown", XhtmlTextWriterAttribute.OnMouseDown, true);
			XhtmlTextWriter.RegisterAttribute ("onmousemove", XhtmlTextWriterAttribute.OnMouseMove, true);
			XhtmlTextWriter.RegisterAttribute ("onmouseout", XhtmlTextWriterAttribute.OnMouseOut, true);
			XhtmlTextWriter.RegisterAttribute ("onmouseover", XhtmlTextWriterAttribute.OnMouseOver, true);
			XhtmlTextWriter.RegisterAttribute ("onmouseup", XhtmlTextWriterAttribute.OnMouseUp, true);
			XhtmlTextWriter.RegisterAttribute ("onreset", XhtmlTextWriterAttribute.OnReset, true);
			XhtmlTextWriter.RegisterAttribute ("onselect", XhtmlTextWriterAttribute.OnSelect, true);
			XhtmlTextWriter.RegisterAttribute ("onsubmit", XhtmlTextWriterAttribute.OnSubmit, true);
			XhtmlTextWriter.RegisterAttribute ("onunload", XhtmlTextWriterAttribute.OnUnload, true);
			XhtmlTextWriter.RegisterAttribute ("profile", XhtmlTextWriterAttribute.Profile, true);
			XhtmlTextWriter.RegisterAttribute ("readonly", XhtmlTextWriterAttribute.ReadOnly, true);
			XhtmlTextWriter.RegisterAttribute ("rel", XhtmlTextWriterAttribute.Rel, true);
			XhtmlTextWriter.RegisterAttribute ("rev", XhtmlTextWriterAttribute.Rev, true);
			XhtmlTextWriter.RegisterAttribute ("scheme", XhtmlTextWriterAttribute.Scheme, true);
			XhtmlTextWriter.RegisterAttribute ("shape", XhtmlTextWriterAttribute.Shape, false);
			XhtmlTextWriter.RegisterAttribute ("size", XhtmlTextWriterAttribute.Size, false);
			XhtmlTextWriter.RegisterAttribute ("src", XhtmlTextWriterAttribute.Src, true);
			XhtmlTextWriter.RegisterAttribute ("standby", XhtmlTextWriterAttribute.StandBy, true);
			XhtmlTextWriter.RegisterAttribute ("start", XhtmlTextWriterAttribute.Start, true);
			XhtmlTextWriter.RegisterAttribute ("style", XhtmlTextWriterAttribute.Style, false);
			XhtmlTextWriter.RegisterAttribute ("tabindex", XhtmlTextWriterAttribute.TabIndex, false);
			XhtmlTextWriter.RegisterAttribute ("target", XhtmlTextWriterAttribute.Target, false);
			XhtmlTextWriter.RegisterAttribute ("text", XhtmlTextWriterAttribute.Text, false);
			XhtmlTextWriter.RegisterAttribute ("title", XhtmlTextWriterAttribute.Title, true);
			XhtmlTextWriter.RegisterAttribute ("type", XhtmlTextWriterAttribute.Type, false);
			XhtmlTextWriter.RegisterAttribute ("usemap", XhtmlTextWriterAttribute.UseMap, true);
			XhtmlTextWriter.RegisterAttribute ("valign", XhtmlTextWriterAttribute.Valign, false);
			XhtmlTextWriter.RegisterAttribute ("value", XhtmlTextWriterAttribute.Value, true);
			XhtmlTextWriter.RegisterAttribute ("valuetype", XhtmlTextWriterAttribute.ValueType, true);
			XhtmlTextWriter.RegisterAttribute ("vlink", XhtmlTextWriterAttribute.VLink, false);
			XhtmlTextWriter.RegisterAttribute ("width", XhtmlTextWriterAttribute.Width, false);
			XhtmlTextWriter.RegisterAttribute ("xml:lang", XhtmlTextWriterAttribute.XmlLang, true);
			XhtmlTextWriter.RegisterAttribute ("xml:space", XhtmlTextWriterAttribute.XmlSpace, true);

			XhtmlTextWriter._styleKeyLookupTable = new Hashtable (14);
			XhtmlTextWriter._styleNameLookupArray = new String [14];

			XhtmlTextWriter.RegisterStyle ("background-color", XhtmlTextWriterStyle.BackgroundColor);
			XhtmlTextWriter.RegisterStyle ("background-image", XhtmlTextWriterStyle.BackgroundImage);
			XhtmlTextWriter.RegisterStyle ("border-collapse", XhtmlTextWriterStyle.BorderCollapse);
			XhtmlTextWriter.RegisterStyle ("border-color", XhtmlTextWriterStyle.BorderColor);
			XhtmlTextWriter.RegisterStyle ("border-style", XhtmlTextWriterStyle.BorderStyle);
			XhtmlTextWriter.RegisterStyle ("border-width", XhtmlTextWriterStyle.BorderWidth);
			XhtmlTextWriter.RegisterStyle ("color", XhtmlTextWriterStyle.Color);
			XhtmlTextWriter.RegisterStyle ("font-family", XhtmlTextWriterStyle.FontFamily);
			XhtmlTextWriter.RegisterStyle ("font-size", XhtmlTextWriterStyle.FontSize);
			XhtmlTextWriter.RegisterStyle ("font-style", XhtmlTextWriterStyle.FontStyle);
			XhtmlTextWriter.RegisterStyle ("font-weight", XhtmlTextWriterStyle.FontWeight);
			XhtmlTextWriter.RegisterStyle ("height", XhtmlTextWriterStyle.Height);
			XhtmlTextWriter.RegisterStyle ("text-decoration", XhtmlTextWriterStyle.TextDecoration);
			XhtmlTextWriter.RegisterStyle ("width", XhtmlTextWriterStyle.Width);
		}

	} // XhtmlTextWriter

	enum XhtmlTagType {
		Block,
		Empty,
		Flow,
		Inline,
		Other,
		PcData
	}

	struct XhtmlRenderAttribute {
		public bool encode;
		public XhtmlTextWriterAttribute key;
		public string name;
		public string value;
	} 

	struct XhtmlRenderStyle {
		public XhtmlTextWriterStyle key;
		public string name;
		public string value;
	} 

	struct XhtmlTagStackEntry {
		public string endTagText;
		public XhtmlTextWriterTag tagKey;
	}

	struct XhtmlTagInformation {
		public string closingTag;
		public string name;
		public XhtmlTagType tagType;

		public XhtmlTagInformation(string name, XhtmlTagType tagType, string closingTag){
			this.name = name;
			this.tagType = tagType;
			this.closingTag = closingTag;   
		}
	} 
 
 } // namespace System.Web.UI
