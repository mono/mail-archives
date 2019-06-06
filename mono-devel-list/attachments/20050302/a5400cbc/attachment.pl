diff -Naur ./System.Xml/XmlTextWriter.cs ../monomerge2/System.Xml/XmlTextWriter.cs
--- ./System.Xml/XmlTextWriter.cs	2005-02-02 20:28:28.000000000 +0200
+++ ../monomerge2/System.Xml/XmlTextWriter.cs	2005-02-10 18:42:33.000000000 +0200
@@ -328,6 +328,7 @@
 					if (namespaceManager.LookupNamespace (aprefix, false) == ans)
 						continue;
 	
+					namespaceManager.AddNamespace (aprefix, ans);
 					w.Write (" xmlns:");
 					w.Write (aprefix);
 					w.Write ('=');
@@ -716,10 +717,10 @@
 
 		public override void WriteStartAttribute (string prefix, string localName, string ns)
 		{
-			if (prefix == "xml") {
+			if (ns == XmlNamespaceManager.XmlnsXml) {
 				// MS.NET looks to allow other names than 
 				// lang and space (e.g. xml:link, xml:hack).
-				ns = XmlNamespaceManager.XmlnsXml;
+				
 				if (localName == "lang")
 					openXmlLang = true;
 				else if (localName == "space")
@@ -732,10 +733,10 @@
 				if (prefix != "xmlns")
 					throw new ArgumentException ("Cannot use prefix with an empty namespace.");
 
-			if (prefix == "xmlns") {
-				if (localName == null || localName.Length == 0) {
-					localName = prefix;
-					prefix = String.Empty;
+			if (localName == "xmlns") { //Semantically xmlns is a prefix, not a localName
+				if (prefix == null || prefix.Length == 0) {
+					prefix = localName;
+					localName = String.Empty;
 				}
 				else if (localName.ToLower (CultureInfo.InvariantCulture).StartsWith ("xml"))
 					throw new ArgumentException ("Prefixes beginning with \"xml\" (regardless of whether the characters are uppercase, lowercase, or some combination thereof) are reserved for use by XML: " + prefix + ":" + localName);
@@ -743,9 +744,9 @@
 
 			// Note that null namespace with "xmlns" are allowed.
 #if NET_1_0
-			if ((prefix == "xmlns" || localName == "xmlns" && prefix == String.Empty) && ns != XmlnsNamespace)
+			if (prefix == "xmlns" && ns != XmlnsNamespace)
 #else
-			if ((prefix == "xmlns" || localName == "xmlns" && prefix == String.Empty) && ns != null && ns != XmlnsNamespace)
+			if (prefix == "xmlns" && ns != null && ns != XmlnsNamespace)
 #endif
 				throw new ArgumentException (String.Format ("The 'xmlns' attribute is bound to the reserved namespace '{0}'", XmlnsNamespace));
 
@@ -765,35 +766,60 @@
 			if (ns != String.Empty && prefix != "xmlns") {
 				string existingPrefix = namespaceManager.LookupPrefix (ns, false);
 
-				if (existingPrefix == null || existingPrefix == "") {
+				if (existingPrefix == null) {
 					bool createPrefix = false;
-					if (prefix == "")
+					
+					if (prefix == string.Empty)
 						createPrefix = true;
 					else {
 						string existingNs = namespaceManager.LookupNamespace (prefix, false);
+						if (existingNs != null && existingNs!= string.Empty && existingNs != ns)
+                            createPrefix = true;
+						foreach (DictionaryEntry entry in newAttributeNamespaces)
+							if (entry.Value.Equals (ns)) {
+								prefix = (string) entry.Key;
+								createPrefix = false;
+							}
+#if false
 						if (existingNs != null) {
 							namespaceManager.RemoveNamespace (prefix, existingNs);
-							if (namespaceManager.LookupNamespace (prefix, false) != existingNs) {
+							string inheritedNs = namespaceManager.LookupNamespace (prefix, false);
+							if (inheritedNs != existingNs) {
 								createPrefix = true;
 								namespaceManager.AddNamespace (prefix, existingNs);
 							}
 						}
+#endif
 					}
+					
 					if (createPrefix)
 						prefix = "d" + indentLevel + "p" + (newAttributeNamespaces.Count + 1);
-					
-					// check if prefix exists. If yes - check if namespace is the same.
-					if (newAttributeNamespaces [prefix] == null)
-						newAttributeNamespaces.Add (prefix, ns);
-					else if (!newAttributeNamespaces [prefix].Equals (ns))
-						throw new ArgumentException ("Duplicate prefix with different namespace");
 				}
-
+					
 				if (prefix == String.Empty && ns != XmlnsNamespace)
 					prefix = (existingPrefix == null) ?
 						String.Empty : existingPrefix;
+
+				// check if prefix exists. If yes - check if namespace is the same.
+				if (newAttributeNamespaces [prefix] == null)
+					newAttributeNamespaces.Add (prefix, ns);
+				else if (!newAttributeNamespaces [prefix].Equals (ns))
+					throw new ArgumentException ("Duplicate prefix with different namespace");
+			}
+
+			if (prefix == "xmlns") { //Syntatically xmlns looks like a localName for default NS
+				if (prefix != openElementPrefix || openElementNS == null)
+					shouldAddSavedNsToManager = true; 
+				saveAttributeValue = true;
+				savedAttributePrefix = (localName != null) ? localName : String.Empty;
+				savingAttributeValue = String.Empty;
 			}
 
+			if (prefix == "xmlns" && (localName == null || localName.Length == 0)) {
+				localName = prefix;
+				prefix = String.Empty;
+			}
+			
 			if (prefix != String.Empty) 
 			{
 				formatPrefix = prefix + ":";
@@ -814,14 +840,6 @@
 			openAttribute = true;
 			attributeWrittenForElement = true;
 			ws = WriteState.Attribute;
-
-			if (prefix == "xmlns" || prefix == String.Empty && localName == "xmlns") {
-				if (prefix != openElementPrefix || openElementNS == null)
-					shouldAddSavedNsToManager = true; 
-				saveAttributeValue = true;
-				savedAttributePrefix = (prefix == "xmlns") ? localName : String.Empty;
-				savingAttributeValue = String.Empty;
-			}
 		}
 
 		public override void WriteStartDocument ()
@@ -914,8 +932,8 @@
 
 			if (ns != null) {
 				if (ns.Length > 0) {
-					string existing = LookupPrefix (ns);
-					if (existing != prefix) {
+					string existing = namespaceManager.LookupNamespace (prefix, false);
+					if ( existing != ns) {
 						shouldCheckElementXmlns = true;
 						namespaceManager.AddNamespace (prefix, ns);
 					}
@@ -941,7 +959,7 @@
 				savingAttributeValue += text;
 		}
 
-		string [] replacements = new string [] {
+		static readonly string [] replacements = new string [] {
 			"&amp;", "&lt;", "&gt;", "&quot;", "&apos;",
 			"&#xD;", "&#xA;"};
 
