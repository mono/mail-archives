Index: mono-api-diff.cs
===================================================================
--- mono-api-diff.cs	(revision 52182)
+++ mono-api-diff.cs	(working copy)
@@ -1182,8 +1182,27 @@
 		}
 	}
 
-	class XMLGenericTypeConstraints : XMLNameGroup
+	abstract class XMLGenericGroup : XMLNameGroup
 	{
+		string attributes;
+
+		protected override void LoadExtraData (string name, XmlNode node)
+		{
+			attributes = ((XmlElement) node).GetAttribute ("generic-attribute");
+		}
+
+		protected override void CompareToInner (string name, XmlNode parent, XMLNameGroup other)
+		{
+			base.CompareToInner (name, parent, other);
+
+			XMLGenericGroup g = (XMLGenericGroup) other;
+			if (attributes != g.attributes)
+				AddWarning (parent, "Incorrect generic attributes: '{0}' != '{1}'", attributes, g.attributes);
+		}
+	}
+
+	class XMLGenericTypeConstraints : XMLGenericGroup
+	{
 		public override string GroupName {
 			get { return "generic-type-constraints"; }
 		}
@@ -1193,7 +1212,7 @@
 		}
 	}
 
-	class XMLGenericMethodConstraints : XMLNameGroup
+	class XMLGenericMethodConstraints : XMLGenericGroup
 	{
 		public override string GroupName {
 			get { return "generic-method-constraints"; }
@@ -1581,7 +1600,17 @@
 		Hashtable returnTypes;
 		Hashtable parameters;
 		Hashtable genericConstraints;
+		Hashtable signatureFlags;
 
+		[Flags]
+		enum SignatureFlags
+		{
+			None = 0,
+			Abstract = 1,
+			Sealed = 2,
+			Static = 4
+		}
+
 		protected override void LoadExtraData (string name, XmlNode node)
 		{
 			XmlAttribute xatt = node.Attributes ["returntype"];
@@ -1592,6 +1621,19 @@
 				returnTypes [name] = xatt.Value;
 			}
 
+			SignatureFlags flags = SignatureFlags.None;
+			if (((XmlElement) node).GetAttribute ("abstract") == "true")
+				flags |= SignatureFlags.Abstract;
+			if (((XmlElement) node).GetAttribute ("static") == "true")
+				flags |= SignatureFlags.Static;
+			if (((XmlElement) node).GetAttribute ("sealed") == "true")
+				flags |= SignatureFlags.Sealed;
+			if (flags != SignatureFlags.None) {
+				if (signatureFlags == null)
+					signatureFlags = new Hashtable ();
+				signatureFlags [name] = flags;
+			}
+
 			XmlNode parametersNode = node.SelectSingleNode ("parameters");
 			if (parametersNode != null) {
 				if (parameters == null)
@@ -1625,6 +1667,19 @@
 			try {
 				base.CompareToInner(name, parent, other);
 				XMLMethods methods = (XMLMethods) other;
+
+				SignatureFlags flags = signatureFlags != null &&
+					signatureFlags.ContainsKey (name) ?
+					(SignatureFlags) signatureFlags [name] :
+					SignatureFlags.None;
+				SignatureFlags oflags = methods.signatureFlags != null &&
+					methods.signatureFlags.ContainsKey (name) ?
+					(SignatureFlags) methods.signatureFlags [name] :
+					SignatureFlags.None;
+
+				if (flags!= oflags)
+					AddWarning (parent, String.Format ("{0} and should be {1}", oflags, flags));
+
 				if (returnTypes != null) {
 					string rtype = returnTypes[name] as string;
 					string ortype = null;
Index: mono-api-info.cs
===================================================================
--- mono-api-info.cs	(revision 52182)
+++ mono-api-info.cs	(working copy)
@@ -313,6 +313,8 @@
 					continue;
 				XmlElement el = document.CreateElement ("generic-type-constraint");
 				el.SetAttribute ("name", garg.ToString ());
+				el.SetAttribute ("generic-attribute",
+					garg.GenericParameterAttributes.ToString ());
 				ngeneric.AppendChild (el);
 				foreach (Type ct in csts) {
 					XmlElement cel = document.CreateElement ("type");
@@ -699,6 +701,40 @@
 			MethodBase method = (MethodBase) member;
 			string name = method.Name;
 			string parms = Parameters.GetSignature (method.GetParameters ());
+			MethodInfo mi = method as MethodInfo;
+#if NET_2_0
+			Type [] genArgs = mi == null ? Type.EmptyTypes :
+				mi.GetGenericArguments ();
+			if (genArgs.Length > 0) {
+				string [] genArgNames = new string [genArgs.Length];
+				for (int i = 0; i < genArgs.Length; i++) {
+					genArgNames [i] = genArgs [i].Name;
+					string genArgCsts = String.Empty;
+					Type [] gcs = genArgs [i].GetGenericParameterConstraints ();
+					if (gcs.Length > 0) {
+						string [] gcNames = new string [gcs.Length];
+						for (int g = 0; g < gcs.Length; g++)
+							gcNames [g] = gcs [g].FullName;
+						genArgCsts = String.Concat (
+							"(",
+							string.Join (", ", gcNames),
+							") ",
+							genArgNames [i]);
+					}
+					else
+						genArgCsts = genArgNames [i];
+					if ((genArgs [i].GenericParameterAttributes & GenericParameterAttributes.ReferenceTypeConstraint) != 0)
+						genArgCsts = "class " + genArgCsts;
+					else if ((genArgs [i].GenericParameterAttributes & GenericParameterAttributes.NotNullableValueTypeConstraint) != 0)
+						genArgCsts = "struct " + genArgCsts;
+					genArgNames [i] = genArgCsts;
+				}
+				return String.Format ("{0}<{2}>({1})",
+					name,
+					parms,
+					string.Join (",", genArgNames));
+			}
+#endif
 			return String.Format ("{0}({1})", name, parms);
 		}
 
@@ -716,6 +752,18 @@
 				((MethodBase) member).GetParameters ());
 			parms.DoOutput ();
 
+			if (!(member is MethodBase))
+				return;
+
+			MethodBase mbase = (MethodBase) member;
+
+			if (mbase.IsAbstract)
+				AddAttribute (p, "abstract", "true");
+			if (mbase.IsFinal)
+				AddAttribute (p, "sealed", "true");
+			if (mbase.IsStatic)
+				AddAttribute (p, "static", "true");
+
 			if (!(member is MethodInfo))
 				return;
 
@@ -735,6 +783,8 @@
 					continue;
 				XmlElement el = document.CreateElement ("generic-method-constraint");
 				el.SetAttribute ("name", garg.ToString ());
+				el.SetAttribute ("generic-attribute",
+					garg.GenericParameterAttributes.ToString ());
 				ngeneric.AppendChild (el);
 				foreach (Type ct in csts) {
 					XmlElement cel = document.CreateElement ("type");