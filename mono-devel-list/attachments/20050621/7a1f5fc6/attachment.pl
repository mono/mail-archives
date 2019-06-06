Index: C:/cygwin/monobuild/mcs/class/System.XML/System.Xml/XmlNode.cs
===================================================================
--- C:/cygwin/monobuild/mcs/class/System.XML/System.Xml/XmlNode.cs	(revision 46238)
+++ C:/cygwin/monobuild/mcs/class/System.XML/System.Xml/XmlNode.cs	(working copy)
@@ -108,16 +108,16 @@
 		public virtual string InnerText {
 			get {
 				StringBuilder builder = new StringBuilder ();
-				AppendChildValues (this, builder);
+				AppendChildValues (builder);
 				return builder.ToString ();
 			}
 
 			set { throw new InvalidOperationException ("This node is read only. Cannot be modified."); }
 		}
 
-		private void AppendChildValues (XmlNode parent, StringBuilder builder)
+		private void AppendChildValues (StringBuilder builder)
 		{
-			XmlNode node = parent.FirstChild;
+			XmlNode node = FirstChild;
 
 			while (node != null) {
 				switch (node.NodeType) {
@@ -128,7 +128,7 @@
  					builder.Append (node.Value);
 					break;
 				}
-				AppendChildValues (node, builder);
+				node.AppendChildValues (builder);
 				node = node.NextSibling;
 			}
 		}
