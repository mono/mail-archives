Index: mono-api-diff.cs
===================================================================
--- mono-api-diff.cs	(revision 51229)
+++ mono-api-diff.cs	(working copy)
@@ -628,6 +628,7 @@
 		string layout;
 		XMLAttributes attributes;
 		XMLInterfaces interfaces;
+		XMLGenericTypeConstraints genericConstraints;
 		XMLFields fields;
 		XMLConstructors constructors;
 		XMLProperties properties;
@@ -681,6 +682,12 @@
 				child = child.NextSibling;
 			}
 
+			if (child != null && child.Name == "generic-type-constraints") {
+				genericConstraints = new XMLGenericTypeConstraints ();
+				genericConstraints.LoadData (child);
+				child = child.NextSibling;
+			}
+
 			if (child != null && child.Name == "fields") {
 				fields = new XMLFields ();
 				fields.LoadData (child);
@@ -775,6 +782,14 @@
 				counters.AddPartialToPartial (interfaces.Counters);
 			}
 
+			if (genericConstraints != null || oclass.genericConstraints != null) {
+				if (genericConstraints == null)
+					genericConstraints = new XMLGenericTypeConstraints ();
+
+				genericConstraints.CompareTo (doc, parent, oclass.genericConstraints);
+				counters.AddPartialToPartial (genericConstraints.Counters);
+			}
+
 			if (fields != null || oclass.fields != null) {
 				if (fields == null)
 					fields = new XMLFields ();
@@ -1166,6 +1181,28 @@
 		}
 	}
 
+	class XMLGenericTypeConstraints : XMLNameGroup
+	{
+		public override string GroupName {
+			get { return "generic-type-constraints"; }
+		}
+
+		public override string Name {
+			get { return "generic-type-constraint"; }
+		}
+	}
+
+	class XMLGenericMethodConstraints : XMLNameGroup
+	{
+		public override string GroupName {
+			get { return "generic-method-constraints"; }
+		}
+
+		public override string Name {
+			get { return "generic-method-constraint"; }
+		}
+	}
+
 	abstract class XMLMember : XMLNameGroup
 	{
 		Hashtable attributeMap;
@@ -1542,6 +1579,7 @@
 	{
 		Hashtable returnTypes;
 		Hashtable parameters;
+		Hashtable genericConstraints;
 
 		protected override void LoadExtraData (string name, XmlNode node)
 		{
@@ -1564,6 +1602,15 @@
 				parameters[name] = parms;
 			}
 
+			XmlNode genericNode = node.SelectSingleNode ("generic-method-constraints");
+			if (genericNode != null) {
+				if (genericConstraints == null)
+					genericConstraints = new Hashtable ();
+				XMLGenericMethodConstraints csts = new XMLGenericMethodConstraints ();
+				csts.LoadData (genericNode);
+				genericConstraints [name] = csts;
+			}
+
 			base.LoadExtraData (name, node);
 		}
 
Index: mono-api-info.cs
===================================================================
--- mono-api-info.cs	(revision 51229)
+++ mono-api-info.cs	(working copy)
@@ -302,6 +302,28 @@
 				}
 			}
 
+#if NET_2_0
+			// Generic constraints
+			Type [] gargs = type.GetGenericArguments ();
+			XmlElement ngeneric = (gargs.Length == 0) ? null :
+				document.CreateElement ("generic-type-constraints");
+			foreach (Type garg in gargs) {
+				Type [] csts = garg.GetGenericParameterConstraints ();
+				if (csts.Length == 0 || csts [0] == typeof (object))
+					continue;
+				XmlElement el = document.CreateElement ("generic-type-constraint");
+				el.SetAttribute ("name", garg.ToString ());
+				ngeneric.AppendChild (el);
+				foreach (Type ct in csts) {
+					XmlElement cel = document.CreateElement ("type");
+					cel.AppendChild (document.CreateTextNode (ct.FullName));
+					el.AppendChild (cel);
+				}
+			}
+			if (ngeneric != null && ngeneric.FirstChild != null)
+				nclass.AppendChild (ngeneric);
+#endif
+
 			ArrayList members = new ArrayList ();
 
 			FieldInfo[] fields = GetFields (type);
@@ -702,6 +724,28 @@
 
 			AttributeData.OutputAttributes (document, p,
 				method.ReturnTypeCustomAttributes.GetCustomAttributes (false));
+#if NET_2_0
+			// Generic constraints
+			Type [] gargs = method.GetGenericArguments ();
+			XmlElement ngeneric = (gargs.Length == 0) ? null :
+				document.CreateElement ("generic-method-constraints");
+			foreach (Type garg in gargs) {
+				Type [] csts = garg.GetGenericParameterConstraints ();
+				if (csts.Length == 0 || csts [0] == typeof (object))
+					continue;
+				XmlElement el = document.CreateElement ("generic-method-constraint");
+				el.SetAttribute ("name", garg.ToString ());
+				ngeneric.AppendChild (el);
+				foreach (Type ct in csts) {
+					XmlElement cel = document.CreateElement ("type");
+					cel.AppendChild (document.CreateTextNode (ct.FullName));
+					el.AppendChild (cel);
+				}
+			}
+			if (ngeneric != null && ngeneric.FirstChild != null)
+				p.AppendChild (ngeneric);
+#endif
+
 		}
 
 		public override bool NoMemberAttributes {