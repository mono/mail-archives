--- old\XmlNode.cs	2004-01-15 08:57:01.000000000 +0200
+++ new\XmlNode.cs	2004-01-15 08:46:15.883373200 +0200
@@ -408,9 +408,26 @@
 
 			// checking validity finished. then appending...
 
+			
+			if (newChild == this || isAncestorIntern(newChild))
+				throw new ArgumentException("Cannot insert a node or any ancestor of that node as a child of itself.");
+
 			return insertBeforeIntern (newChild, refChild);
 		}
 
+		// check for the node to be one of node ancestors
+		internal bool isAncestorIntern(XmlNode newChild)
+		{
+			XmlNode currNode = this.ParentNode;
+			while(currNode != null)
+			{
+				if(currNode == newChild)
+					return true;
+				currNode = currNode.ParentNode;
+			}
+			return false;
+		}
+
 		internal XmlNode insertBeforeIntern (XmlNode newChild, XmlNode refChild)
 		{
 			XmlDocument ownerDoc = (NodeType == XmlNodeType.Document) ? (XmlDocument)this : OwnerDocument;
@@ -593,12 +610,10 @@
 		{
 			if(oldChild.ParentNode != this)
 				throw new InvalidOperationException ("oldChild is not a child of this node.");
-			XmlNode parent = this.ParentNode;
-			while(parent != null) {
-				if(newChild == parent)
-					throw new InvalidOperationException ("newChild is ancestor of this node.");
-				parent = parent.ParentNode;
-			}
+			
+			if (newChild == this || isAncestorIntern(newChild))
+				throw new ArgumentException("Cannot insert a node or any ancestor of that node as a child of itself.");
+			
 			foreach(XmlNode n in ChildNodes) {
 				if(n == oldChild) {
 					XmlNode prev = oldChild.PreviousSibling;
