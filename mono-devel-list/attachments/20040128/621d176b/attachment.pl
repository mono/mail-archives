--- old\XmlNotation.cs	2004-01-28 10:09:17.900629000 +0200
+++ new\XmlNotation.cs	2004-01-28 09:58:35.367031200 +0200
@@ -60,7 +60,9 @@
 		}
 
 		public override string Name {
-			get { return prefix + ":" + localName; }
+			get { 
+				return ((prefix != String.Empty) ? (prefix + ":" + localName) : localName); 
+			}
 		}
 
 		public override XmlNodeType NodeType {
