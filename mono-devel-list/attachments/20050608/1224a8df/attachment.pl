Index: ChangeLog
===================================================================
--- ChangeLog	(revision 45568)
+++ ChangeLog	(working copy)
@@ -1,3 +1,13 @@
+2005-06-08  Ilya Kharmatsky <ilyak-at-mainsoft.com>
+
+    * HtmlTextWriter.cs: Internal structs such as TagStackEntry,
+    TagInforamation, RenderStyle etc. changed in J2EE configuration
+    to be classes (due to heavy performance impact). All code changes
+    are related to this issue.
+    * ObjectStateFormatter.cs: Added TARGET_JVM directives, which
+    allow to skip Assembly related work in J2EE configuration (due to
+    limitations of Assembly API in Grasshopper).
+      
 2005-06-06  Lluis Sanchez Gual <lluis@novell.com>
 
 	* Control.cs: Added new DataBind() overload for 2.0. The old
Index: ObjectStateFormatter.cs
===================================================================
--- ObjectStateFormatter.cs	(revision 45568)
+++ ObjectStateFormatter.cs	(working copy)
@@ -721,9 +721,10 @@
 				} else {
 					w.Write (PrimaryId);
 					w.Write (((Type) o).FullName);
-					
+#if !TARGET_J2EE					
 					// We should cache the name of the assembly
 					w.Write (((Type) o).Assembly.FullName);
+#endif
 				}
 			}
 			
@@ -731,9 +732,13 @@
 			{
 				if (token == PrimaryId) {
 					string type = r.ReadString ();
+#if !TARGET_J2EE										
 					string assembly = r.ReadString ();
 					
 					Type t = Assembly.Load (assembly).GetType (type);
+#else
+					Type t = Type.GetType(type);
+#endif
 					ctx.CacheItem (t);
 					return t;
 				} else {
Index: HtmlTextWriter.cs
===================================================================
--- HtmlTextWriter.cs	(revision 45568)
+++ HtmlTextWriter.cs	(working copy)
@@ -306,6 +306,9 @@
 		_attrList = rAttrArr;
 	}
 	RenderAttribute rAttr;
+#if TARGET_J2EE
+	rAttr = new RenderAttribute();
+#endif
 	rAttr.name = name;
 	rAttr.value = value;
 	rAttr.key = key;
@@ -328,6 +331,9 @@
 		_styleList = rAttrArr;
 	}
 	RenderStyle rAttr;
+#if TARGET_J2EE
+	rAttr = new RenderStyle();
+#endif
 	rAttr.name = name;
 	rAttr.value = value;
 	rAttr.key = key;
@@ -512,6 +518,9 @@
 		System.Array.Copy(_endTags, temp, (int) _endTags.Length);
 		_endTags = temp;
 	}
+#if TARGET_J2EE
+	_endTags[_endTagCount] = new TagStackEntry();
+#endif
 	_endTags[_endTagCount].tagKey = _tagKey;
 	_endTags[_endTagCount].endTagText = endTag;
 	_endTagCount++;
@@ -1059,7 +1068,11 @@
 
 } //HtmlTextWriter
 
+#if TARGET_J2EE
+class AttributeInformation {
+#else	
 struct AttributeInformation {
+#endif	
 	public bool encode;
 	public string name;
 
@@ -1069,20 +1082,32 @@
 	}
 } 
  
+#if TARGET_J2EE
+class RenderAttribute {
+#else	
 struct RenderAttribute {
+#endif	
 	public bool encode;
 	public HtmlTextWriterAttribute key;
 	public string name;
 	public string value;
 } 
  
+#if TARGET_J2EE
+class RenderStyle {
+#else	
 struct RenderStyle {
+#endif	
 	public HtmlTextWriterStyle key;
 	public string name;
 	public string value;
 } 
  
+#if TARGET_J2EE
+class TagInformation {
+#else	
 struct TagInformation {
+#endif	
 	public string closingTag;
 	public string name;
 	public TagType tagType;
@@ -1094,7 +1119,11 @@
 	}
 } 
  
+#if TARGET_J2EE
+class TagStackEntry {
+#else	
 struct TagStackEntry {
+#endif	
 	public string endTagText;
 	public HtmlTextWriterTag tagKey;
 } 
