Index: engine/provider.cs
===================================================================
--- engine/provider.cs	(revision 51172)
+++ engine/provider.cs	(working copy)
@@ -895,7 +895,9 @@
 		foreach (string path in UncompiledHelpSources) {
 			EcmaUncompiledHelpSource hs = new EcmaUncompiledHelpSource(path);
 			root.help_sources.Add (hs);
-			Node hsn = root.CreateNode(hs.Name, "extra-help-source-" + hs.Name);
+			string epath = "extra-help-source-" + hs.Name;
+			Node hsn = root.CreateNode (hs.Name, "root:/" + epath);
+			root.name_to_hs [epath] = hs;
 			hsn.EnsureNodes ();
 			foreach (Node n in hs.Tree.Nodes){
 				hsn.AddNode (n);
Index: engine/ecma-provider.cs
===================================================================
--- engine/ecma-provider.cs	(revision 51172)
+++ engine/ecma-provider.cs	(working copy)
@@ -1005,7 +1005,7 @@
 		return Htmlize(ecma_xml, null);
 	}
 	
-	static string Htmlize (IXPathNavigable ecma_xml, XsltArgumentList args)
+	public static string Htmlize (IXPathNavigable ecma_xml, XsltArgumentList args)
 	{
 		EnsureTransform ();
 		
@@ -1842,7 +1842,32 @@
 	public override string GetText (string url, out Node match_node) {
 		if (url == "root:") {
 			match_node = null;
-			return null;
+			
+			//load index.xml
+			XmlDocument index = new XmlDocument ();
+			index.Load (Path.Combine (basedir.FullName, "index.xml"));
+			XmlNodeList nodes = index.SelectNodes ("/Overview/Types/Namespace");
+			
+			//recreate masteroverview.xml
+			XmlDocument summary = new XmlDocument ();
+			XmlElement elements = summary.CreateElement ("elements");
+			foreach (XmlNode node in nodes) {
+				XmlElement ns = summary.CreateElement ("namespace");
+				XmlAttribute attr = summary.CreateAttribute ("ns");
+				attr.Value = node.Attributes["Name"].Value;
+				ns.Attributes.Append (attr);
+				elements.AppendChild (ns);
+			}
+			summary.AppendChild (elements);
+
+			XmlReader reader = new XmlTextReader (new StringReader (summary.OuterXml));
+
+			//transform the recently created masteroverview.xml
+			XsltArgumentList args = new XsltArgumentList();
+			args.AddExtensionObject("monodoc://extensions", ExtObject);
+			args.AddParam("show", "", "masteroverview");
+			string s = EcmaHelpSource.Htmlize(new XPathDocument (reader), args);
+			return BuildHtml (css_ecma_code, s); 
 		}
 		return base.GetText(url, out match_node);
 	}