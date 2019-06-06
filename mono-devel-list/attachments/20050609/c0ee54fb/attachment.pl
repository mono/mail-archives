Index: System.Xml/DTDValidatingReader.cs
===================================================================
--- System.Xml/DTDValidatingReader.cs	(revision 45697)
+++ System.Xml/DTDValidatingReader.cs	(working copy)
@@ -114,7 +114,7 @@
 		bool isSignificantWhitespace;
 		bool isWhitespace;
 		bool isText;
-		bool dontResetTextType;
+		bool nextMaybeSignificantWhitespace;
 
 		// This field is used to get properties and to raise events.
 		XmlValidatingReader validatingReader;
@@ -370,7 +370,7 @@
 			isWhitespace = false;
 			isSignificantWhitespace = false;
 			isText = false;
-			dontResetTextType = false;
+                        nextMaybeSignificantWhitespace = false;
 
 			bool b = ReadContent () || currentTextValue != null;
 			if (!b && this.missingIDReferences.Count > 0) {
@@ -432,6 +432,7 @@
 				return false;
 			}
 
+                        bool dontResetTextType = false;
 			DTDElementDeclaration elem = null;
 
 			switch (reader.NodeType) {
@@ -574,7 +575,7 @@
 					constructingTextValue = null;
 					return true;
 				}
-				break;
+                                goto case XmlNodeType.Text;
 			case XmlNodeType.SignificantWhitespace:
 				if (!isText)
 					isSignificantWhitespace = true;
@@ -604,9 +605,19 @@
 				}
 				break;
 			case XmlNodeType.Whitespace:
+                                if (nextMaybeSignificantWhitespace) {
+                                        currentTextValue = reader.Value;
+                                        nextMaybeSignificantWhitespace = false;
+                                        goto case XmlNodeType.SignificantWhitespace;
+                                }
 				if (!isText && !isSignificantWhitespace)
 					isWhitespace = true;
-				goto case XmlNodeType.Text;
+                                if (entityReaderStack.Count > 0 && validatingReader.EntityHandling == EntityHandling.ExpandEntities) {
+                                        constructingTextValue += reader.Value;
+                                        return ReadContent ();
+                                }
+                                ValidateWhitespaceNode ();
+                                break;
 			case XmlNodeType.EntityReference:
 				if (validatingReader.EntityHandling == EntityHandling.ExpandEntities) {
 					ResolveEntity ();
@@ -614,9 +625,6 @@
 				}
 				break;
 			}
-			if (isWhitespace)
-				ValidateWhitespaceNode ();
-			currentTextValue = constructingTextValue;
 			constructingTextValue = null;
 			MoveToElement ();
 			return true;
