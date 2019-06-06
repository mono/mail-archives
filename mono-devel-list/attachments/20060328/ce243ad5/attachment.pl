Index: XmlAttribute.cs
===================================================================
--- XmlAttribute.cs	(revision 58623)
+++ XmlAttribute.cs	(working copy)
@@ -156,8 +156,8 @@
 		}
 
 		public override string Name {
-			get { 
-				return name.Prefix != String.Empty ? OwnerDocument.NameTable.Add (name.Prefix + ":" + name.LocalName) : name.LocalName;
+			get {
+				return OwnerDocument.NameCache.GetAtomizedPrefixedName (name.Prefix, name.LocalName);
 			}
 		}
 
Index: XmlNameEntryCache.cs
===================================================================
--- XmlNameEntryCache.cs	(revision 58623)
+++ XmlNameEntryCache.cs	(working copy)
@@ -38,12 +38,29 @@
 		Hashtable table = new Hashtable ();
 		XmlNameTable nameTable;
 		XmlNameEntry dummy = new XmlNameEntry (String.Empty, String.Empty, String.Empty);
+		char [] cacheBuffer;
 
 		public XmlNameEntryCache (XmlNameTable nameTable)
 		{
 			this.nameTable = nameTable;
 		}
 
+		public string GetAtomizedPrefixedName (string prefix, string local)
+		{
+			if (prefix.Length == 0)
+				return local;
+
+			if (cacheBuffer == null)
+				cacheBuffer = new char [20];
+			else if (cacheBuffer.Length < prefix.Length + local.Length + 1)
+				cacheBuffer = new char [Math.Max (
+					prefix.Length + local.Length + 1,
+					cacheBuffer.Length << 1)];
+			prefix.CopyTo (0, cacheBuffer, 0, prefix.Length);				cacheBuffer [prefix.Length] = ':';
+			local.CopyTo (0, cacheBuffer, prefix.Length + 1, local.Length);
+			return nameTable.Add (cacheBuffer, 0, prefix.Length + local.Length + 1);
+		}
+
 		public XmlNameEntry Add (string prefix, string local, string ns,
 			bool atomic)
 		{
