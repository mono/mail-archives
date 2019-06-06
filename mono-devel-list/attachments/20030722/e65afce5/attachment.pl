Index: class/System.Security/System.Security.Cryptography.Xml/XmlDsigC14NTransform.cs
===================================================================
RCS file: /mono/mcs/class/System.Security/System.Security.Cryptography.Xml/XmlDsigC14NTransform.cs,v
retrieving revision 1.3
diff -u -r1.3 XmlDsigC14NTransform.cs
--- class/System.Security/System.Security.Cryptography.Xml/XmlDsigC14NTransform.cs	20 Feb 2003 00:49:58 -0000	1.3
+++ class/System.Security/System.Security.Cryptography.Xml/XmlDsigC14NTransform.cs	22 Jul 2003 18:18:07 -0000
@@ -4,33 +4,34 @@
 //
 // Author:
 //	Sebastien Pouliot (spouliot@motus.com)
+//	Aleksey Sanin (aleksey@aleksey.com)
 //
 // (C) 2002, 2003 Motus Technologies Inc. (http://www.motus.com)
+// (C) 2003 Aleksey Sanin (aleksey@aleksey.com)
 //
 
+using System.Collections;
 using System.IO;
 using System.Text;
 using System.Xml;
 
 namespace System.Security.Cryptography.Xml { 
-
 	[MonoTODO]
 	public class XmlDsigC14NTransform : Transform {
-
 		private Type[] input;
 		private Type[] output;
-		private bool comments;
+		private XmlDsigCanonicalizer canonicalizer;
 		private Stream s;
-
+		
 		public XmlDsigC14NTransform () 
 		{
 			Algorithm = "http://www.w3.org/TR/2001/REC-xml-c14n-20010315";
-			comments = false;
+			canonicalizer = new XmlDsigCanonicalizer(false, false);
 		}
 
 		public XmlDsigC14NTransform (bool includeComments) 
 		{
-			comments = includeComments;
+			canonicalizer = new XmlDsigCanonicalizer(true, false);
 		}
 
 		public override Type[] InputTypes {
@@ -85,26 +86,651 @@
 
 		public override void LoadInput (object obj) 
 		{
-			XmlNodeList xnl = null;
+		    if (obj is Stream) 
+		    {
+			s = (obj as Stream);
+			// todo: parse doc from stream?
+		    }
+		    else if (obj is XmlDocument)
+		    {
+			s = canonicalizer.Canonicalize((obj as XmlDocument));
+		    }
+		    else if (obj is XmlNodeList)
+		    {
+			s = canonicalizer.Canonicalize((obj as XmlNodeList));
+		    }
+		    // note: there is no default are other types won't throw an exception
+		}
+	}
+	
+	internal class XmlDsigCanonicalizer
+	{
+		private enum XmlDsigCanonicalizerState
+		{
+		    BeforeDocElement,
+		    InsideDocElement,
+		    AfterDocElement
+		}
+		
+		// c14n parameters
+		private bool comments;
+		private bool exclusive;
+
+		// input/output
+		private XmlNodeList xnl;
+		private StringBuilder res;
+		
+		// namespaces rendering stack
+		private XmlDsigCanonicalizerState state;
+		private ArrayList visibleNamespaces;
+		private int prevVisibleNamespacesStart;
+		private int prevVisibleNamespacesEnd;
+
+		public XmlDsigCanonicalizer(bool withComments, bool excC14N)
+		{	    
+			res = new StringBuilder ();
+			comments = withComments;
+			exclusive = excC14N;
+			state = XmlDsigCanonicalizerState.BeforeDocElement;
+			visibleNamespaces = new ArrayList();
+			prevVisibleNamespacesStart = 0;
+			prevVisibleNamespacesEnd = 0;
+		}
+		
+		public Stream Canonicalize(XmlDocument doc)
+		{
+		    WriteDocumentNode(doc);
+		    
+		    UTF8Encoding utf8 = new UTF8Encoding ();
+		    byte[] data = utf8.GetBytes (res.ToString ());
+		    return new MemoryStream (data);
+		}
+		
+		public Stream Canonicalize(XmlNodeList nodes)
+		{
+		    xnl = nodes;
+		    if (nodes == null || nodes.Count < 1)
+		    {
+			return null;
+		    }
+		    return Canonicalize(nodes[0].OwnerDocument);
+		}		
+
+		private void WriteNode(XmlNode node)
+		{
+		    // Console.WriteLine("Debug: node=" + node.Name);
+
+		    bool visible = IsNodeVisible(node);
+
+		    switch(node.NodeType) 
+		    {
+			case XmlNodeType.Document:
+			case XmlNodeType.DocumentFragment:
+			    WriteDocumentNode(node);
+			    break;
+			case XmlNodeType.Element:
+			    WriteElementNode(node, visible);
+			    break;
+			case XmlNodeType.CDATA:
+			case XmlNodeType.SignificantWhitespace:
+			case XmlNodeType.Text:
+        		    // CDATA sections are processed as text nodes
+			    WriteTextNode(node, visible);
+			    break;
+			case XmlNodeType.Whitespace:
+			    if (state == XmlDsigCanonicalizerState.InsideDocElement)
+			    {
+				WriteTextNode(node, visible);
+			    }
+			    break;
+			case XmlNodeType.Comment:
+			    WriteCommentNode(node, visible);
+			    break;
+			case XmlNodeType.ProcessingInstruction:
+			    WriteProcessingInstructionNode(node, visible);
+			    break;
+			case XmlNodeType.EntityReference:
+			    throw new XmlException ("Entity references should be resolved by parser");
+			case XmlNodeType.Attribute:
+			    throw new XmlException ("Attribute node is impossible here");
+			case XmlNodeType.EndElement:
+			    throw new XmlException ("EndElement node is impossible here");
+			case XmlNodeType.EndEntity:
+			    throw new XmlException ("EndEntity node is impossible here");
+			case XmlNodeType.DocumentType:
+			case XmlNodeType.Entity:
+			case XmlNodeType.Notation:
+			case XmlNodeType.XmlDeclaration:
+			    // just do nothing
+			    break;
+		    }
+		}
+
+		private void WriteDocumentNode(XmlNode node)
+    		{
+		    state = XmlDsigCanonicalizerState.BeforeDocElement;
+		    XmlNode child = node.FirstChild;
+		    while (child != null)
+		    {
+			WriteNode(child);
+			child = child.NextSibling;
+		    }
+		}
+		
+		// Element Nodes
+		// If the element is not in the node-set, then the result is obtained 
+		// by processing the namespace axis, then the attribute axis, then 
+		// processing the child nodes of the element that are in the node-set 
+		// (in document order). If the element is inthe node-set, then the result 
+		// is an open angle bracket (<), the element QName, the result of 
+		// processing the namespace axis, the result of processing the attribute 
+		// axis, a close angle bracket (>), the result of processing the child 
+		// nodes of the element that are in the node-set (in document order), an 
+		// open angle bracket, a forward slash (/), the element QName, and a close 
+		// angle bracket.
+		private void WriteElementNode(XmlNode node, bool visible)
+		{
+		    // Console.WriteLine("Debug: element node");
+		    
+		    // remember current state 
+		    int savedPrevVisibleNamespacesStart = prevVisibleNamespacesStart;
+		    int savedPrevVisibleNamespacesEnd = prevVisibleNamespacesEnd;
+		    int savedVisibleNamespacesSize = visibleNamespaces.Count;
+		    XmlDsigCanonicalizerState s = state;
+		    if (visible && state == XmlDsigCanonicalizerState.BeforeDocElement)
+		    {
+			state = XmlDsigCanonicalizerState.InsideDocElement;
+		    }
+		    
+		    // write start tag
+		    if (visible) 
+		    {
+			res.Append("<");
+			res.Append(node.Name);
+		    }
+		    
+		    // this is odd but you can select namespaces
+		    // and attributes even if node itself is not visible
+		    WriteNamespacesAxis(node, visible);
+		    WriteAttributesAxis(node);			
+	
+		    if (visible)
+		    {
+			res.Append(">");
+		    } 
+
+		    // write children
+		    XmlNode child = node.FirstChild;
+		    while(child != null)
+		    {
+			WriteNode(child);
+			child = child.NextSibling;
+		    }
+		    		    
+		    // write end tag	    
+		    if(visible) 
+		    {
+			res.Append("</");
+			res.Append(node.Name);
+			res.Append(">");
+		    }
+		    
+		    // restore state
+		    if (visible && s == XmlDsigCanonicalizerState.BeforeDocElement)
+		    {
+			state = XmlDsigCanonicalizerState.AfterDocElement;
+		    }
+		    prevVisibleNamespacesStart = savedPrevVisibleNamespacesStart;
+		    prevVisibleNamespacesEnd = savedPrevVisibleNamespacesEnd;
+		    if (visibleNamespaces.Count > savedVisibleNamespacesSize)
+		    {
+			visibleNamespaces.RemoveRange (savedVisibleNamespacesSize, 
+						       visibleNamespaces.Count - savedVisibleNamespacesSize);
+		    }
+		}
+
+		// Namespace Axis
+		// Consider a list L containing only namespace nodes in the 
+		// axis and in the node-set in lexicographic order (ascending). To begin 
+		// processing L, if the first node is not the default namespace node (a node 
+		// with no namespace URI and no local name), then generate a space followed 
+		// by xmlns="" if and only if the following conditions are met:
+		//    - the element E that owns the axis is in the node-set
+		//    - The nearest ancestor element of E in the node-set has a default 
+		//	    namespace node in the node-set (default namespace nodes always 
+		//      have non-empty values in XPath)
+		// The latter condition eliminates unnecessary occurrences of xmlns="" in 
+		// the canonical form since an element only receives an xmlns="" if its 
+		// default namespace is empty and if it has an immediate parent in the 
+		// canonical form that has a non-empty default namespace. To finish 
+		// processing  L, simply process every namespace node in L, except omit 
+		// namespace node with local name xml, which defines the xml prefix, 
+		// if its string value is http://www.w3.org/XML/1998/namespace.
+		private void WriteNamespacesAxis(XmlNode node, bool visible)
+		{
+		    // Console.WriteLine("Debug: namespaces");
 
-			if (obj is Stream) 
-				s = (obj as Stream);
-			else if (obj is XmlDocument)
-				xnl = (obj as XmlDocument).ChildNodes;
-			else if (obj is XmlNodeList)
-				xnl = (XmlNodeList) obj;
-
-			if (xnl != null) {
-				StringBuilder sb = new StringBuilder ();
-				foreach (XmlNode xn in xnl)
-					sb.Append (xn.InnerText);
-
-				UTF8Encoding utf8 = new UTF8Encoding ();
-				byte[] data = utf8.GetBytes (sb.ToString ());
-				s = new MemoryStream (data);
+		    XmlDocument doc = node.OwnerDocument;    
+		    bool has_empty_namespace = false;
+		    ArrayList list = new ArrayList();
+		    for(XmlNode cur = node; cur != null && cur != doc; cur = cur.ParentNode)
+		    {
+			foreach(XmlNode attribute in cur.Attributes)
+			{		
+			    if (!IsNamespaceNode(attribute)) 
+			    {
+			    	continue;
+			    }
+			    	
+			    // get namespace prefix
+			    string prefix = string.Empty;
+			    if (attribute.Prefix == "xmlns") 
+			    {
+				prefix = attribute.LocalName;
+			    }
+			    
+			    // check if it is "xml" namespace			    
+			    if (prefix == "xml" && attribute.Value == "http://www.w3.org/XML/1998/namespace")
+			    {
+				continue;
+			    }
+			    
+			    // make sure that this is an active namespace
+			    // for our node
+			    string ns = node.GetNamespaceOfPrefix(prefix);
+			    if (ns != attribute.Value) 
+			    {
+				continue;
+			    }
+			    
+			    // check that it is selected with XPath
+			    if (!IsNodeVisible(attribute)) 
+			    {
+				continue;
+			    }
+
+			    // check that we have not rendered it yet
+			    bool rendered = IsNamespaceRendered(prefix, attribute.Value);
+
+			    // add to the visible namespaces stack
+			    if (visible)
+			    {
+				visibleNamespaces.Add(attribute);
+			    }  
+			      
+			    if (!rendered)
+			    {
+				list.Add(attribute);
+			    }
+			    if (prefix == string.Empty)
+			    {	
+				has_empty_namespace = true;
+			    }
+			}
+		    }
+		    
+		    if(visible && !has_empty_namespace && !IsNamespaceRendered(string.Empty, string.Empty)) 
+		    {
+			res.Append(" xmlns=\"\"");
+		    }
+		    
+		    list.Sort(new XmlDsigC14NTransformNamespacesComparer());
+		    foreach(object obj in list)
+		    {
+			XmlNode attribute = (obj as XmlNode);
+			if(attribute != null)
+			{
+			    res.Append(" ");
+			    res.Append(attribute.Name);
+			    res.Append("=\"");
+			    res.Append(attribute.Value);
+			    res.Append("\"");
+			}
+		    }
+		    
+		    // move the rendered namespaces stack
+		    if (visible)
+		    {
+			prevVisibleNamespacesStart = prevVisibleNamespacesEnd;
+			prevVisibleNamespacesEnd = visibleNamespaces.Count;	
+		    }
+		}
+		
+		// Attribute Axis 
+		// In lexicographic order (ascending), process each node that 
+		// is in the element's attribute axis and in the node-set.
+		// 
+		// The processing of an element node E MUST be modified slightly 
+		// when an XPath node-set is given as input and the element's 
+		// parent is omitted from the node-set.
+		private void WriteAttributesAxis(XmlNode node)
+		{
+		    // Console.WriteLine("Debug: attributes");
+		
+		    ArrayList list = new ArrayList();
+		    foreach(XmlNode attribute in node.Attributes)
+		    {	
+			if (!IsNamespaceNode(attribute) && IsNodeVisible(attribute)) 
+			{
+			    list.Add(attribute);
+			}
+		    }
+		     
+		    // Add attributes from "xml" namespace for "inclusive" c14n only:
+		    //
+		    // The method for processing the attribute axis of an element E 
+		    // in the node-set is enhanced. All element nodes along E's 
+		    // ancestor axis are examined for nearest occurrences of 
+		    // attributes in the xml namespace, such as xml:lang and 
+		    // xml:space (whether or not they are in the node-set). 
+		    // From this list of attributes, remove any that are in E's 
+		    // attribute axis (whether or not they are in the node-set). 
+		    // Then, lexicographically merge this attribute list with the 
+		    // nodes of E's attribute axis that are in the node-set. The 
+		    // result of visiting the attribute axis is computed by 
+		    // processing the attribute nodes in this merged attribute list.
+		    if(!exclusive && node.ParentNode != null && !IsNodeVisible(node.ParentNode.ParentNode))
+		    {
+			// if we have whole document then the node.ParentNode.ParentNode
+			// is always visible
+			for(XmlNode cur = node.ParentNode; cur != null; cur = cur.ParentNode)
+			{
+			    foreach(XmlNode attribute in cur.Attributes)
+			    {
+				// we are looking for "xml:*" attributes
+				if (attribute.Prefix != "xml")
+				{
+				    continue;
+				}
+				
+				// exclude ones that are in the node's attributes axis
+				if (node.Attributes.GetNamedItem(attribute.LocalName, attribute.NamespaceURI) != null)
+				{
+				    continue;
+				}
+				
+				// finally check that we don't have the same attribute in our list
+				bool found = false;
+				foreach(object obj in list)
+				{
+				    XmlNode n = (obj as XmlNode);
+				    if (n.Prefix == "xml" && n.LocalName == attribute.LocalName)
+				    {
+					found = true;
+					break;
+				    }
+				}
+				if (found) 
+				{
+				    continue;
+				}
+				
+				// now we can add this attribute to our list
+				list.Add(attribute);
+			    }
+			}		
+		    }
+		    		    
+		    list.Sort(new XmlDsigC14NTransformAttributesComparer());
+		    foreach(object obj in list)
+		    {
+			XmlNode attribute = (obj as XmlNode);
+			if(attribute != null)
+			{
+			    res.Append(" ");
+			    res.Append(attribute.Name);
+			    res.Append("=\"");
+			    res.Append(NormalizeString(attribute.Value, XmlNodeType.Attribute));
+			    res.Append("\"");
 			}
+		    }
+		}
+
+            	// Text Nodes
+            	// the string value, except all ampersands are replaced 
+            	// by &amp;, all open angle brackets (<) are replaced by &lt;, all closing 
+            	// angle brackets (>) are replaced by &gt;, and all #xD characters are 
+            	// replaced by &#xD;.
+		private void WriteTextNode(XmlNode node, bool visible)
+		{
+		    // Console.WriteLine("Debug: text node");
 
-			// note: there is no default are other types won't throw an exception
+		    if(visible)
+		    {
+			res.Append(NormalizeString(node.Value, XmlNodeType.Text));
+		    }
+		}		
+
+		// Comment Nodes
+            	// Nothing if generating canonical XML without comments. For 
+            	// canonical XML with comments, generate the opening comment 
+            	// symbol (<!--), the string value of the node, and the 
+            	// closing comment symbol (-->). Also, a trailing #xA is rendered 
+	        // after the closing comment symbol for comment children of the 
+        	// root node with a lesser document order than the document 
+            	// element, and a leading #xA is rendered before the opening 
+            	// comment symbol of comment children of the root node with a 
+            	// greater document order than the document element. (Comment 
+	        // children of the root node represent comments outside of the 
+            	// top-level document element and outside of the document type 
+            	// declaration).
+		private void WriteCommentNode(XmlNode node, bool visible)
+		{
+		    // Console.WriteLine("Debug: comment node");
+		    
+		    if (visible && comments)
+		    {
+			if(state == XmlDsigCanonicalizerState.AfterDocElement)
+			{
+			    res.Append("\x0A<!--");
+			} 
+			else
+			{
+			    res.Append("<!--");
+			}
+			
+			res.Append(NormalizeString(node.Value, XmlNodeType.Comment));
+			
+			if(state == XmlDsigCanonicalizerState.BeforeDocElement)
+			{
+			    res.Append("-->\x0A");
+			} 
+			else
+			{
+			    res.Append("-->");
+			}
+	    	    }
+		}
+		
+        	// Processing Instruction (PI) Nodes- 
+            	// The opening PI symbol (<?), the PI target name of the node, 
+            	// a leading space and the string value if it is not empty, and 
+            	// the closing PI symbol (?>). If the string value is empty, 
+            	// then the leading space is not added. Also, a trailing #xA is 
+            	// rendered after the closing PI symbol for PI children of the 
+            	// root node with a lesser document order than the document 
+            	// element, and a leading #xA is rendered before the opening PI 
+            	// symbol of PI children of the root node with a greater document 
+            	// order than the document element.
+		private void WriteProcessingInstructionNode(XmlNode node, bool visible)
+		{
+		    // Console.WriteLine("Debug: PI node");
+
+		    if (visible)
+		    {
+			if(state == XmlDsigCanonicalizerState.AfterDocElement)
+			{
+			    res.Append("\x0A<?");
+			} 
+			else
+			{
+			    res.Append("<?");
+			}
+				
+			res.Append(node.Name);
+			if(node.Value.Length > 0) 
+			{				    
+			    res.Append(" ");
+			    res.Append(NormalizeString(node.Value, XmlNodeType.ProcessingInstruction));
+			}
+			
+			if(state == XmlDsigCanonicalizerState.BeforeDocElement)
+			{
+			    res.Append("?>\x0A");
+			} 
+			else
+			{
+			    res.Append("?>");
+			}
+	    	    }
+		}
+		
+		private bool IsNodeVisible(XmlNode node)
+		{
+		    // if node list is empty then we process whole document
+		    if(xnl == null) 
+		    {
+			return true;
+		    }
+		    
+		    // walk thru the list
+		    foreach (XmlNode xn in xnl)
+		    {
+			if(node.Equals(xn)) 
+			{
+			    return true;
+			}
+		    }
+		    
+		    return false;
+		}
+
+		private bool IsNamespaceRendered(string prefix, string uri)
+		{
+		    // if the default namespace xmlns="" is not re-defined yet
+		    // then we do not want to print it out
+		    bool IsEmptyNs = prefix == string.Empty && uri == string.Empty;
+		    int start = (IsEmptyNs) ? 0 : prevVisibleNamespacesStart;
+		    for(int i = visibleNamespaces.Count - 1; i >= start; i--)
+		    {
+			XmlNode node = (visibleNamespaces[i] as XmlNode);
+			if (node != null)
+			{
+			    // get namespace prefix
+			    string p = string.Empty;
+			    if (node.Prefix == "xmlns") 
+			    {
+				p = node.LocalName;
+			    }
+			    if (p == prefix) 
+			    {
+				return node.Value == uri;
+			    }
+			}
+		    }
+		    
+		    return IsEmptyNs;
+		}
+		
+		private bool IsNamespaceNode(XmlNode node)
+    		{
+		    if (node == null || node.NodeType != XmlNodeType.Attribute) 
+		    {
+			return false;
+		    }
+		    return node.NamespaceURI == "http://www.w3.org/2000/xmlns/";
+		}
+    
+		private string NormalizeString(string input, XmlNodeType type)
+		{
+		    StringBuilder sb = new StringBuilder();
+		    for (int i = 0; i < input.Length; i++)
+		    {
+			char ch = input[i];
+			if (ch == '<' && (type == XmlNodeType.Attribute || type == XmlNodeType.Text))
+			{	
+			    sb.Append ("&lt;");
+			}
+			else if (ch == '>' && type == XmlNodeType.Text)
+			{
+			    sb.Append ("&gt;");
+			}			
+			else if (ch == '&' && (type == XmlNodeType.Attribute || type == XmlNodeType.Text))
+			{	
+			    sb.Append ("&amp;");
+			}
+			else if (ch == '\"' && type == XmlNodeType.Attribute)
+			{
+			    sb.Append ("&quot;");
+			}			
+			else if (ch == '\x09' && type == XmlNodeType.Attribute)
+			{
+			    sb.Append ("&#x9;");
+			}			
+			else if (ch == '\x0A' && type == XmlNodeType.Attribute)
+			{
+			    sb.Append ("&#xA;");
+			}			
+			else if (ch == '\x0D' && (type == XmlNodeType.Attribute ||
+						  type == XmlNodeType.Text ||
+						  type == XmlNodeType.Comment ||
+						  type == XmlNodeType.ProcessingInstruction))
+			{
+			    sb.Append ("&#xD;");
+			}		
+			else
+			{
+			    sb.Append (ch);
+			}
+		    }
+		    
+		    return sb.ToString();
+		}
+	}
+    
+	internal class XmlDsigC14NTransformAttributesComparer : IComparer
+	{
+		public int Compare(object x, object y)
+		{
+		    XmlNode n1 = (x as XmlNode);
+		    XmlNode n2 = (y as XmlNode);
+		
+		    // simple cases
+		    if (n1 == n2) return 0;
+		    else if (n1 == null) return -1;
+		    else if (n2 == null) return 1;
+	    	    else if (n1.Prefix == n2.Prefix) return string.Compare(n1.LocalName, n2.LocalName);
+	
+    		    // Attributes in the default namespace are first
+		    // because the default namespace is not applied to
+    		    // unqualified attributes
+		    if (n1.Prefix == string.Empty) return -1;
+		    else if (n2.Prefix == string.Empty) return 1;
+		    
+		    int ret = string.Compare(n1.NamespaceURI, n2.NamespaceURI);
+		    if (ret == 0) {
+			ret = string.Compare(n1.LocalName, n2.LocalName);
+		    }
+		    return ret;
+		}
+	}
+
+	internal class XmlDsigC14NTransformNamespacesComparer : IComparer
+	{
+		public int Compare(object x, object y)
+		{
+		    XmlNode n1 = (x as XmlNode);
+		    XmlNode n2 = (y as XmlNode);
+		
+		    // simple cases
+		    if (n1 == n2) return 0;
+		    else if (n1 == null) return -1;
+		    else if (n2 == null) return 1;
+		    else if (n1.Prefix == string.Empty) return -1;
+		    else if (n2.Prefix == string.Empty) return 1;
+		    
+		    return string.Compare(n1.LocalName, n2.LocalName);
 		}
 	}
 }
+
Index: class/System.Security/Test/System.Security.Cryptography.Xml/XmlDsigC14NTransformTest.cs
===================================================================
RCS file: /mono/mcs/class/System.Security/Test/System.Security.Cryptography.Xml/XmlDsigC14NTransformTest.cs,v
retrieving revision 1.2
diff -u -r1.2 XmlDsigC14NTransformTest.cs
--- class/System.Security/Test/System.Security.Cryptography.Xml/XmlDsigC14NTransformTest.cs	13 May 2003 20:23:05 -0000	1.2
+++ class/System.Security/Test/System.Security.Cryptography.Xml/XmlDsigC14NTransformTest.cs	22 Jul 2003 18:18:08 -0000
@@ -3,8 +3,10 @@
 //
 // Author:
 //	Sebastien Pouliot (spouliot@motus.com)
+//	Aleksey Sanin (aleksey@aleksey.com)
 //
 // (C) 2002, 2003 Motus Technologies Inc. (http://www.motus.com)
+// (C) 2003 Aleksey Sanin (aleksey@aleksey.com)
 //
 
 using System;
@@ -135,5 +137,281 @@
 			XmlDocument doc = new XmlDocument();
 			object o = transform.GetOutput (doc.GetType ());
 		}
+		
+	        [Test]
+	        public void C14NSpecExample1()
+	        {
+			string res = ExecuteXmlDSigC14NTransform(C14NSpecExample1Input);
+			AssertEquals("Example 1 from c14n spec - PIs, Comments, and Outside of Document Element (without comments)", 
+				     C14NSpecExample1Output, res);
+	        }
+
+	        [Test]
+	        public void C14NSpecExample2()
+	        {
+			string res = ExecuteXmlDSigC14NTransform(C14NSpecExample2Input);
+			AssertEquals("Example 2 from c14n spec - Whitespace in Document Content (without comments)", 
+				    C14NSpecExample2Output, res);
+		}
+
+	        [Test]
+	        public void C14NSpecExample3()
+	        {
+	    		string res = ExecuteXmlDSigC14NTransform(C14NSpecExample3Input);
+	    		AssertEquals("Example 3 from c14n spec - Start and End Tags (without comments)", 
+	    			     C14NSpecExample3Output, res);
+	        }
+	    
+	        [Test]
+	        public void C14NSpecExample4()
+	        {
+	    		string res = ExecuteXmlDSigC14NTransform(C14NSpecExample4Input);
+	    		AssertEquals("Example 4 from c14n spec - Character Modifications and Character References (without comments)", 
+	    			     C14NSpecExample4Output, res);
+	        }
+	    
+	        [Test]
+	        public void C14NSpecExample5()
+	        {
+	    	    	string res = ExecuteXmlDSigC14NTransform(C14NSpecExample5Input);
+	    	    	AssertEquals("Example 5 from c14n spec - Entity References (without comments)", 
+	    		     C14NSpecExample5Output, res);
+	        }
+    
+	        public void C14NSpecExample6()
+	        {
+	    	    	string res = ExecuteXmlDSigC14NTransform(C14NSpecExample6Input);
+	    	    	AssertEquals("Example 6 from c14n spec - UTF-8 Encoding (without comments)", 
+	    	    		     C14NSpecExample6Output, res);
+	        }
+
+		private string ExecuteXmlDSigC14NTransform(string InputXml)
+		{
+		    XmlDocument doc = new XmlDocument();
+		    doc.PreserveWhitespace = true;
+		    doc.LoadXml(InputXml);
+		
+    	    	    // Aleksey:
+		    // Currently Mono's XmlValidatingReader does not support resolving
+		    // default attributes (vreader.ValidationType = ValidationType.None).
+		    // We need it for C14N and this code needs to be uncommented 
+		    // when Mono will have it.
+		    //
+		    //	UTF8Encoding utf8 = new UTF8Encoding ();
+		    //	byte[] data = utf8.GetBytes (InputXml.ToString ());
+		    //	Stream stream = new MemoryStream (data);
+		    //	XmlTextReader reader = new XmlTextReader(stream);
+		    //	XmlValidatingReader vreader = new XmlValidatingReader(reader);
+		    //	vreader.ValidationType = ValidationType.None;
+		    //	vreader.EntityHandling = EntityHandling.ExpandCharEntities;
+		    //	doc.Load(vreader);
+
+		    transform.LoadInput(doc);
+		    return Stream2String((Stream)transform.GetOutput ());
+		}
+
+	        //
+	        // Example 1 from C14N spec - PIs, Comments, and Outside of Document Element: 
+	        // http://www.w3.org/TR/xml-c14n#Example-OutsideDoc
+	        // 
+	        // Aleksey: 
+	        // removed reference to an empty external DTD
+	        //
+	        static string C14NSpecExample1Input =  
+	    	    "<?xml version=\"1.0\"?>\n" +
+	    	    "\n" +
+	    	    "<?xml-stylesheet   href=\"doc.xsl\"\n" +
+	    	    "   type=\"text/xsl\"   ?>\n" +
+	    	    "\n" +
+	    	    // "<!DOCTYPE doc SYSTEM \"doc.dtd\">\n" +
+	    	    "\n" +
+	    	    "<doc>Hello, world!<!-- Comment 1 --></doc>\n" +
+	    	    "\n" +
+	    	    "<?pi-without-data     ?>\n\n" +
+	    	    "<!-- Comment 2 -->\n\n" +
+	    	    "<!-- Comment 3 -->\n";
+	        static string C14NSpecExample1Output =   
+	    	    "<?xml-stylesheet href=\"doc.xsl\"\n" +
+	    	    "   type=\"text/xsl\"   ?>\n" +
+	    	    "<doc>Hello, world!</doc>\n" +
+	    	    "<?pi-without-data?>";
+	        
+	        //
+	        // Example 2 from C14N spec - Whitespace in Document Content: 
+	        // http://www.w3.org/TR/xml-c14n#Example-WhitespaceInContent
+	        // 
+	        static string C14NSpecExample2Input =  
+	    	    "<doc>\n" +
+	    	    "  <clean>   </clean>\n" +
+	    	    "   <dirty>   A   B   </dirty>\n" +
+	    	    "   <mixed>\n" +
+	    	    "      A\n" +
+	    	    "      <clean>   </clean>\n" +
+	    	    "      B\n" +
+	    	    "      <dirty>   A   B   </dirty>\n" +
+	    	    "      C\n" +
+	    	    "   </mixed>\n" +
+	    	    "</doc>\n";
+	        static string C14NSpecExample2Output =   
+	    	    "<doc>\n" +
+	    	    "  <clean>   </clean>\n" +
+	    	    "   <dirty>   A   B   </dirty>\n" +
+	    	    "   <mixed>\n" +
+	    	    "      A\n" +
+	    	    "      <clean>   </clean>\n" +
+	    	    "      B\n" +
+	    	    "      <dirty>   A   B   </dirty>\n" +
+	    	    "      C\n" +
+	    	    "   </mixed>\n" +
+	    	    "</doc>";
+	    
+	        //
+	        // Example 3 from C14N spec - Start and End Tags: 
+	        // http://www.w3.org/TR/xml-c14n#Example-SETags
+	        //
+	        // Aleksey:
+	        // Currently Mono XML parser does not support resolving default 
+	        // attributes thru XmlValidateReader interface. Thus this test
+	        // fails because it needs a default attribute. Bellow I put a
+	        // test w/o default attributes. Thus we commented out DTD declaration.
+	        //
+	        // See Also: ExecuteXmlDSigC14NTransformTest()
+	        //
+	        static string C14NSpecExample3Input =  
+	    	    // "<!DOCTYPE doc [<!ATTLIST e9 attr CDATA \"default\">]>\n" +
+	    	    "<doc>\n" +
+	    	    "   <e1   />\n" +
+	    	    "   <e2   ></e2>\n" +
+	    	    "   <e3    name = \"elem3\"   id=\"elem3\"    />\n" +
+	    	    "   <e4    name=\"elem4\"   id=\"elem4\"    ></e4>\n" +
+	    	    "   <e5 a:attr=\"out\" b:attr=\"sorted\" attr2=\"all\" attr=\"I\'m\"\n" +
+	    	    "       xmlns:b=\"http://www.ietf.org\" \n" +
+	    	    "       xmlns:a=\"http://www.w3.org\"\n" +
+	    	    "       xmlns=\"http://www.uvic.ca\"/>\n" +
+	    	    "   <e6 xmlns=\"\" xmlns:a=\"http://www.w3.org\">\n" +
+	    	    "       <e7 xmlns=\"http://www.ietf.org\">\n" +
+	    	    "           <e8 xmlns=\"\" xmlns:a=\"http://www.w3.org\">\n" +
+	    	    "               <e9 xmlns=\"\" xmlns:a=\"http://www.ietf.org\"/>\n" +
+	    	    "           </e8>\n" +
+	    	    "       </e7>\n" +
+	    	    "   </e6>\n" +
+	    	    "</doc>\n";
+	        static string C14NSpecExample3Output =   
+	    	    "<doc>\n" +
+	    	    "   <e1></e1>\n" +
+	    	    "   <e2></e2>\n" +
+	    	    "   <e3 id=\"elem3\" name=\"elem3\"></e3>\n" +
+	    	    "   <e4 id=\"elem4\" name=\"elem4\"></e4>\n" +
+	    	    "   <e5 xmlns=\"http://www.uvic.ca\" xmlns:a=\"http://www.w3.org\" xmlns:b=\"http://www.ietf.org\" attr=\"I\'m\" attr2=\"all\" b:attr=\"sorted\" a:attr=\"out\"></e5>\n" +
+    	    	    "   <e6 xmlns:a=\"http://www.w3.org\">\n" +
+	    	    "       <e7 xmlns=\"http://www.ietf.org\">\n" +
+	    	    "           <e8 xmlns=\"\">\n" +
+	    	    // "               <e9 xmlns:a=\"http://www.ietf.org\" attr=\"default\"></e9>\n" +
+	    	    "               <e9 xmlns:a=\"http://www.ietf.org\"></e9>\n" +
+	    	    "           </e8>\n" +
+	    	    "       </e7>\n" +
+	    	    "   </e6>\n" +
+	    	    "</doc>";
+	    
+	    
+	        //
+	        // Example 4 from C14N spec - Character Modifications and Character References: 
+	        // http://www.w3.org/TR/xml-c14n#Example-Chars
+	        //
+	        // Aleksey: 
+	        // This test does not include "normId" element
+	        // because it has an invalid ID attribute "id" which
+	        // should be normalized by XML parser. Currently Mono
+	        // does not support this (see comment after this example
+	        // in the spec).
+	        static string C14NSpecExample4Input =  
+	    	    "<!DOCTYPE doc [<!ATTLIST normId id ID #IMPLIED>]>\n" +
+	    	    "<doc>\n" +
+	    	    "   <text>First line&#x0d;&#10;Second line</text>\n" +
+	    	    "   <value>&#x32;</value>\n" +
+	    	    "   <compute><![CDATA[value>\"0\" && value<\"10\" ?\"valid\":\"error\"]]></compute>\n" +
+	    	    "   <compute expr=\'value>\"0\" &amp;&amp; value&lt;\"10\" ?\"valid\":\"error\"\'>valid</compute>\n" +
+	    	    "   <norm attr=\' &apos;   &#x20;&#13;&#xa;&#9;   &apos; \'/>\n" +
+	    	    // "   <normId id=\' &apos;   &#x20;&#13;&#xa;&#9;   &apos; \'/>\n" +
+	    	    "</doc>\n";
+	        static string C14NSpecExample4Output =   
+	    	    "<doc>\n" +
+	    	    "   <text>First line&#xD;\n" +
+	    	    "Second line</text>\n" +
+	    	    "   <value>2</value>\n" +
+	    	    "   <compute>value&gt;\"0\" &amp;&amp; value&lt;\"10\" ?\"valid\":\"error\"</compute>\n" +
+	    	    "   <compute expr=\"value>&quot;0&quot; &amp;&amp; value&lt;&quot;10&quot; ?&quot;valid&quot;:&quot;error&quot;\">valid</compute>\n" +
+	    	    "   <norm attr=\" \'    &#xD;&#xA;&#x9;   \' \"></norm>\n" +
+	    	    // "   <normId id=\"\' &#xD;&#xA;&#x9; \'\"></normId>\n" +
+	    	    "</doc>";
+	    
+	        //
+	        // Example 5 from C14N spec - Entity References: 
+	        // http://www.w3.org/TR/xml-c14n#Example-Entities
+	        //
+	        // Aleksey: 
+	        // We don't support entities :( at all...
+	        static string C14NSpecExample5Input =  
+	    	    "<!DOCTYPE doc [\n" +
+	    	    "<!ATTLIST doc attrExtEnt ENTITY #IMPLIED>\n" +
+	    	    "<!ENTITY ent1 \"Hello\">\n" +
+	    	    "<!ENTITY ent2 SYSTEM \"world.txt\">\n" +
+	    	    "<!ENTITY entExt SYSTEM \"earth.gif\" NDATA gif>\n" +
+	    	    "<!NOTATION gif SYSTEM \"viewgif.exe\">\n" +
+	    	    "]>\n" +
+	    	    "<doc attrExtEnt=\"entExt\">\n" +
+	    	    // "   &ent1;, &ent2;!\n" +
+	    	    "</doc>\n" +
+	    	    "\n" +
+	    	    "<!-- Let world.txt contain \"world\" (excluding the quotes) -->\n";
+	        static string C14NSpecExample5Output =  
+	    	    "<doc attrExtEnt=\"entExt\">\n" +
+	    	    // "   Hello, world!\n" +
+	    	    "</doc>";	    
+
+	        //
+	        // Example 6 from C14N spec - UTF-8 Encoding: 
+	        // http://www.w3.org/TR/xml-c14n#Example-UTF8
+	        // 
+	        static string C14NSpecExample6Input =  
+	    	    "<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>\n" +
+	    	    "<doc>&#169;</doc>\n";
+	        static string C14NSpecExample6Output =  
+	    	    "<doc>\xC2\xA9</doc>";
+	    
+
+	        //
+	        // Example 7 from C14N spec - Document Subsets: 
+	        // http://www.w3.org/TR/xml-c14n#Example-DocSubsets
+	        // 
+		// Aleksey:
+		// Well, XPath support in Mono is far from complete....
+		// I was not able to simplify the xpath expression from this test
+		// so it runs on Mono and still makes sense for testing this feature.
+		// Thus this test is not included in the suite now.
+	        static string C14NSpecExample7Input =  
+	    	    "<!DOCTYPE doc [\n" +
+	    	    "<!ATTLIST e2 xml:space (default|preserve) \'preserve\'>\n" +
+	    	    "<!ATTLIST e3 id ID #IMPLIED>\n" +
+	    	    "]>\n" +
+	    	    "<doc xmlns=\"http://www.ietf.org\" xmlns:w3c=\"http://www.w3.org\">\n" +
+	    	    "   <e1>\n" +
+	    	    "      <e2 xmlns=\"\">\n" +
+	    	    "         <e3 id=\"E3\"/>\n" +
+	    	    "      </e2>\n" +
+	    	    "   </e1>\n" +
+	    	    "</doc>\n";
+
+	        static string C14NSpecExample7Xpath =  
+    	    	    "(//.|//@*|//namespace::*)\n" +
+	    	    "[\n" +
+	    	    "self::ietf:e1\n" +
+	    	    "    or\n" +
+	    	    "(parent::ietf:e1 and not(self::text() or self::e2))\n" +
+	    	    "    or\n" +
+	    	    "count(id(\"E3\")|ancestor-or-self::node()) = count(ancestor-or-self::node())\n" +
+	    	    "]";
+	        static string C14NSpecExample7Output =  
+	    	    "<e1 xmlns=\"http://www.ietf.org\" xmlns:w3c=\"http://www.w3.org\"><e3 xmlns=\"\" id=\"E3\" xml:space=\"preserve\"></e3></e1>";
 	}
 }
Index: class/System.Security/Test/System.Security.Cryptography.Xml/XmlDsigC14NWithCommentsTransformTest.cs
===================================================================
RCS file: /mono/mcs/class/System.Security/Test/System.Security.Cryptography.Xml/XmlDsigC14NWithCommentsTransformTest.cs,v
retrieving revision 1.2
diff -u -r1.2 XmlDsigC14NWithCommentsTransformTest.cs
--- class/System.Security/Test/System.Security.Cryptography.Xml/XmlDsigC14NWithCommentsTransformTest.cs	13 May 2003 20:23:05 -0000	1.2
+++ class/System.Security/Test/System.Security.Cryptography.Xml/XmlDsigC14NWithCommentsTransformTest.cs	22 Jul 2003 18:18:08 -0000
@@ -78,5 +78,297 @@
 			XmlDocument doc = new XmlDocument();
 			object o = transform.GetOutput (doc.GetType ());
 		}
-	}
-}
+
+	        [Test]
+		public void C14NSpecExample1()
+	        {
+			string res = ExecuteXmlDSigC14NTransform(C14NSpecExample1Input);
+			AssertEquals("Example 1 from c14n spec - PIs, Comments, and Outside of Document Element (with comments)", 
+				     C14NSpecExample1Output, res);
+		}
+
+		[Test]
+		public void C14NSpecExample2()
+		{
+	    		string res = ExecuteXmlDSigC14NTransform(C14NSpecExample2Input);
+			AssertEquals("Example 2 from c14n spec - Whitespace in Document Content (with comments)", 
+				    C14NSpecExample2Output, res);
+		}
+    
+	        [Test]
+	        public void C14NSpecExample3()
+	        {
+	    		string res = ExecuteXmlDSigC14NTransform(C14NSpecExample3Input);
+	    		AssertEquals("Example 3 from c14n spec - Start and End Tags (with comments)", 
+	    			     C14NSpecExample3Output, res);
+	        }
+	        
+	        [Test]
+	        public void C14NSpecExample4()
+	        {
+	    		string res = ExecuteXmlDSigC14NTransform(C14NSpecExample4Input);
+	    		AssertEquals("Example 4 from c14n spec - Character Modifications and Character References (with comments)", 
+	    			     C14NSpecExample4Output, res);
+	        }
+	    
+	        [Test]
+	        public void C14NSpecExample5()
+	        {
+	    	    	string res = ExecuteXmlDSigC14NTransform(C14NSpecExample5Input);
+	    	    	AssertEquals("Example 5 from c14n spec - Entity References (with comments)", 
+	    	    		     C14NSpecExample5Output, res);
+	        }
+
+	        [Test]
+	        public void C14NSpecExample6()
+	        {
+	    	    	string res = ExecuteXmlDSigC14NTransform(C14NSpecExample6Input);
+	    	    	AssertEquals("Example 6 from c14n spec - UTF-8 Encoding (with comments)", 
+	    		     C14NSpecExample6Output, res);
+	        }
+
+		private string ExecuteXmlDSigC14NTransform(string InputXml)
+		{
+		    XmlDocument doc = new XmlDocument();
+		    doc.PreserveWhitespace = true;
+		    doc.LoadXml(InputXml);
+		
+    	    	    // Aleksey:
+		    // Currently Mono's XmlValidatingReader does not support resolving
+		    // default attributes (vreader.ValidationType = ValidationType.None).
+		    // We need it for C14N and this code needs to be uncommented 
+		    // when Mono will have it.
+		    //
+		    //	UTF8Encoding utf8 = new UTF8Encoding ();
+		    //	byte[] data = utf8.GetBytes (InputXml.ToString ());
+		    //	Stream stream = new MemoryStream (data);
+		    //	XmlTextReader reader = new XmlTextReader(stream);
+		    //	XmlValidatingReader vreader = new XmlValidatingReader(reader);
+		    //	vreader.ValidationType = ValidationType.None;
+		    //	vreader.EntityHandling = EntityHandling.ExpandCharEntities;
+		    //	doc.Load(vreader);
+
+		    transform.LoadInput(doc);
+		    
+		    return Stream2String((Stream)transform.GetOutput ());
+		}
+
+		private string Stream2String (Stream s) 
+		{
+			StringBuilder sb = new StringBuilder ();
+			int b = s.ReadByte ();
+			while (b != -1) {
+				sb.Append (Convert.ToChar (b));
+				b = s.ReadByte ();
+			}
+			return sb.ToString ();
+		}
+
+	        //
+	        // Example 1 from C14N spec - PIs, Comments, and Outside of Document Element: 
+	        // http://www.w3.org/TR/xml-c14n#Example-OutsideDoc
+	        // 
+	        // Aleksey: 
+	        // removed reference to an empty external DTD
+	        //
+	        static string C14NSpecExample1Input =  
+	    	    "<?xml version=\"1.0\"?>\n" +
+	    	    "\n" +
+	    	    "<?xml-stylesheet   href=\"doc.xsl\"\n" +
+	    	    "   type=\"text/xsl\"   ?>\n" +
+	    	    "\n" +
+	    	    // "<!DOCTYPE doc SYSTEM \"doc.dtd\">\n" +
+	    	    "\n" +
+	    	    "<doc>Hello, world!<!-- Comment 1 --></doc>\n" +
+	    	    "\n" +
+	    	    "<?pi-without-data     ?>\n\n" +
+	    	    "<!-- Comment 2 -->\n\n" +
+	    	    "<!-- Comment 3 -->\n";
+	        static string C14NSpecExample1Output =   
+	    	    "<?xml-stylesheet href=\"doc.xsl\"\n" +
+	    	    "   type=\"text/xsl\"   ?>\n" +
+	    	    "<doc>Hello, world!<!-- Comment 1 --></doc>\n" +
+	    	    "<?pi-without-data?>\n" +
+	    	    "<!-- Comment 2 -->\n" +
+	    	    "<!-- Comment 3 -->";
+	        
+	        //
+	        // Example 2 from C14N spec - Whitespace in Document Content: 
+	        // http://www.w3.org/TR/xml-c14n#Example-WhitespaceInContent
+	        // 
+	        static string C14NSpecExample2Input =  
+	    	    "<doc>\n" +
+	    	    "  <clean>   </clean>\n" +
+	    	    "   <dirty>   A   B   </dirty>\n" +
+	    	    "   <mixed>\n" +
+	    	    "      A\n" +
+	    	    "      <clean>   </clean>\n" +
+	    	    "      B\n" +
+	    	    "      <dirty>   A   B   </dirty>\n" +
+	    	    "      C\n" +
+	    	    "   </mixed>\n" +
+	    	    "</doc>\n";
+	        static string C14NSpecExample2Output =   
+	    	    "<doc>\n" +
+	    	    "  <clean>   </clean>\n" +
+	    	    "   <dirty>   A   B   </dirty>\n" +
+	    	    "   <mixed>\n" +
+	    	    "      A\n" +
+	    	    "      <clean>   </clean>\n" +
+	    	    "      B\n" +
+	    	    "      <dirty>   A   B   </dirty>\n" +
+	    	    "      C\n" +
+	    	    "   </mixed>\n" +
+	    	    "</doc>";
+	    
+	        //
+	        // Example 3 from C14N spec - Start and End Tags: 
+	        // http://www.w3.org/TR/xml-c14n#Example-SETags
+	        //
+	        // Aleksey:
+	        // Currently Mono XML parser does not support resolving default 
+	        // attributes thru XmlValidateReader interface. Thus this test
+	        // fails because it needs a default attribute. Bellow I put a
+	        // test w/o default attributes. Thus we commented out DTD declaration.
+	        //
+	        // See Also: ExecuteXmlDSigC14NTransformTest()
+	        //
+	        static string C14NSpecExample3Input =  
+	    	    // "<!DOCTYPE doc [<!ATTLIST e9 attr CDATA \"default\">]>\n" +
+	    	    "<doc>\n" +
+	    	    "   <e1   />\n" +
+	    	    "   <e2   ></e2>\n" +
+	    	    "   <e3    name = \"elem3\"   id=\"elem3\"    />\n" +
+	    	    "   <e4    name=\"elem4\"   id=\"elem4\"    ></e4>\n" +
+	    	    "   <e5 a:attr=\"out\" b:attr=\"sorted\" attr2=\"all\" attr=\"I\'m\"\n" +
+	    	    "       xmlns:b=\"http://www.ietf.org\" \n" +
+	    	    "       xmlns:a=\"http://www.w3.org\"\n" +
+	    	    "       xmlns=\"http://www.uvic.ca\"/>\n" +
+	    	    "   <e6 xmlns=\"\" xmlns:a=\"http://www.w3.org\">\n" +
+	    	    "       <e7 xmlns=\"http://www.ietf.org\">\n" +
+	    	    "           <e8 xmlns=\"\" xmlns:a=\"http://www.w3.org\">\n" +
+	    	    "               <e9 xmlns=\"\" xmlns:a=\"http://www.ietf.org\"/>\n" +
+	    	    "           </e8>\n" +
+	    	    "       </e7>\n" +
+	    	    "   </e6>\n" +
+	    	    "</doc>\n";
+	        static string C14NSpecExample3Output =   
+	    	    "<doc>\n" +
+	    	    "   <e1></e1>\n" +
+	    	    "   <e2></e2>\n" +
+	    	    "   <e3 id=\"elem3\" name=\"elem3\"></e3>\n" +
+	    	    "   <e4 id=\"elem4\" name=\"elem4\"></e4>\n" +
+	    	    "   <e5 xmlns=\"http://www.uvic.ca\" xmlns:a=\"http://www.w3.org\" xmlns:b=\"http://www.ietf.org\" attr=\"I\'m\" attr2=\"all\" b:attr=\"sorted\" a:attr=\"out\"></e5>\n" +
+    	    	    "   <e6 xmlns:a=\"http://www.w3.org\">\n" +
+	    	    "       <e7 xmlns=\"http://www.ietf.org\">\n" +
+	    	    "           <e8 xmlns=\"\">\n" +
+	    	    // "               <e9 xmlns:a=\"http://www.ietf.org\" attr=\"default\"></e9>\n" +
+	    	    "               <e9 xmlns:a=\"http://www.ietf.org\"></e9>\n" +
+	    	    "           </e8>\n" +
+	    	    "       </e7>\n" +
+	    	    "   </e6>\n" +
+	    	    "</doc>";
+	    
+	    
+	        //
+	        // Example 4 from C14N spec - Character Modifications and Character References: 
+	        // http://www.w3.org/TR/xml-c14n#Example-Chars
+	        //
+	        // Aleksey: 
+	        // This test does not include "normId" element
+	        // because it has an invalid ID attribute "id" which
+	        // should be normalized by XML parser. Currently Mono
+	        // does not support this (see comment after this example
+	        // in the spec).
+	        static string C14NSpecExample4Input =  
+	    	    "<!DOCTYPE doc [<!ATTLIST normId id ID #IMPLIED>]>\n" +
+	    	    "<doc>\n" +
+	    	    "   <text>First line&#x0d;&#10;Second line</text>\n" +
+	    	    "   <value>&#x32;</value>\n" +
+	    	    "   <compute><![CDATA[value>\"0\" && value<\"10\" ?\"valid\":\"error\"]]></compute>\n" +
+	    	    "   <compute expr=\'value>\"0\" &amp;&amp; value&lt;\"10\" ?\"valid\":\"error\"\'>valid</compute>\n" +
+	    	    "   <norm attr=\' &apos;   &#x20;&#13;&#xa;&#9;   &apos; \'/>\n" +
+	    	    // "   <normId id=\' &apos;   &#x20;&#13;&#xa;&#9;   &apos; \'/>\n" +
+	    	    "</doc>\n";
+	        static string C14NSpecExample4Output =   
+	    	    "<doc>\n" +
+	    	    "   <text>First line&#xD;\n" +
+	    	    "Second line</text>\n" +
+	    	    "   <value>2</value>\n" +
+	    	    "   <compute>value&gt;\"0\" &amp;&amp; value&lt;\"10\" ?\"valid\":\"error\"</compute>\n" +
+	    	    "   <compute expr=\"value>&quot;0&quot; &amp;&amp; value&lt;&quot;10&quot; ?&quot;valid&quot;:&quot;error&quot;\">valid</compute>\n" +
+	    	    "   <norm attr=\" \'    &#xD;&#xA;&#x9;   \' \"></norm>\n" +
+	    	    // "   <normId id=\"\' &#xD;&#xA;&#x9; \'\"></normId>\n" +
+	    	    "</doc>";
+	    
+	        //
+	        // Example 5 from C14N spec - Entity References: 
+	        // http://www.w3.org/TR/xml-c14n#Example-Entities
+	        //
+	        // Aleksey: 
+	        // We don't support entities :( at all...
+	        static string C14NSpecExample5Input =  
+	    	    "<!DOCTYPE doc [\n" +
+	    	    "<!ATTLIST doc attrExtEnt ENTITY #IMPLIED>\n" +
+	    	    "<!ENTITY ent1 \"Hello\">\n" +
+	    	    "<!ENTITY ent2 SYSTEM \"world.txt\">\n" +
+	    	    "<!ENTITY entExt SYSTEM \"earth.gif\" NDATA gif>\n" +
+	    	    "<!NOTATION gif SYSTEM \"viewgif.exe\">\n" +
+	    	    "]>\n" +
+	    	    "<doc attrExtEnt=\"entExt\">\n" +
+	    	    // "   &ent1;, &ent2;!\n" +
+	    	    "</doc>\n" +
+	    	    "\n" +
+	    	    "<!-- Let world.txt contain \"world\" (excluding the quotes) -->\n";
+	        static string C14NSpecExample5Output =  
+	    	    "<doc attrExtEnt=\"entExt\">\n" +
+	    	    // "   Hello, world!\n" +
+	    	    "</doc>\n" + 
+	    	    "<!-- Let world.txt contain \"world\" (excluding the quotes) -->";
+	    	
+	        //
+	        // Example 6 from C14N spec - UTF-8 Encoding: 
+	        // http://www.w3.org/TR/xml-c14n#Example-UTF8
+	        // 
+	        static string C14NSpecExample6Input =  
+	    	    "<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>\n" +
+	    	    "<doc>&#169;</doc>\n";
+	        static string C14NSpecExample6Output =  
+	    	    "<doc>\xC2\xA9</doc>";
+	    
+
+	        //
+	        // Example 7 from C14N spec - Document Subsets: 
+	        // http://www.w3.org/TR/xml-c14n#Example-DocSubsets
+	        // 
+		// Aleksey:
+		// Well, XPath support in Mono is far from complete....
+		// I was not able to simplify the xpath expression from this test
+		// so it runs on Mono and still makes sense for testing this feature.
+		// Thus this test is not included in the suite now.
+	        static string C14NSpecExample7Input =  
+	    	    "<!DOCTYPE doc [\n" +
+	    	    "<!ATTLIST e2 xml:space (default|preserve) \'preserve\'>\n" +
+	    	    "<!ATTLIST e3 id ID #IMPLIED>\n" +
+	    	    "]>\n" +
+	    	    "<doc xmlns=\"http://www.ietf.org\" xmlns:w3c=\"http://www.w3.org\">\n" +
+	    	    "   <e1>\n" +
+	    	    "      <e2 xmlns=\"\">\n" +
+	    	    "         <e3 id=\"E3\"/>\n" +
+	    	    "      </e2>\n" +
+	    	    "   </e1>\n" +
+	    	    "</doc>\n";
+
+	        static string C14NSpecExample7Xpath =  
+    	    	    "(//.|//@*|//namespace::*)\n" +
+	    	    "[\n" +
+	    	    "self::ietf:e1\n" +
+	    	    "    or\n" +
+	    	    "(parent::ietf:e1 and not(self::text() or self::e2))\n" +
+	    	    "    or\n" +
+	    	    "count(id(\"E3\")|ancestor-or-self::node()) = count(ancestor-or-self::node())\n" +
+	    	    "]";
+	        static string C14NSpecExample7Output =  
+	    	    "<e1 xmlns=\"http://www.ietf.org\" xmlns:w3c=\"http://www.w3.org\"><e3 xmlns=\"\" id=\"E3\" xml:space=\"preserve\"></e3></e1>";   
+	    	}
+	    }
