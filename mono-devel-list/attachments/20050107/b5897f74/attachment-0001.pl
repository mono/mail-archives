Index: XmlSerializerNamespaces.cs
===================================================================
--- XmlSerializerNamespaces.cs	(revision 38473)
+++ XmlSerializerNamespaces.cs	(working copy)
@@ -31,6 +31,7 @@
 using System;
 using System.Xml;
 using System.Collections;
+using System.Collections.Specialized;
 
 namespace System.Xml.Serialization
 {
@@ -39,11 +40,11 @@
 	/// </summary>
 	public class XmlSerializerNamespaces
 	{
-		private Hashtable namespaces;
+		private ListDictionary namespaces;
 			
 		public XmlSerializerNamespaces ()
 		{
-			namespaces = new Hashtable ();
+			namespaces = new ListDictionary ();
 		}
 	
 		public XmlSerializerNamespaces(XmlQualifiedName[] namespaces)
@@ -95,7 +96,7 @@
 			return null;
 		}
 
-		internal Hashtable Namespaces
+		internal ListDictionary Namespaces
 		{
 			get {
 				return namespaces;