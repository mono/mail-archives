Index: main/src/core/MonoDevelop.Projects/ChangeLog
===================================================================
--- main/src/core/MonoDevelop.Projects/ChangeLog	(revision 135777)
+++ main/src/core/MonoDevelop.Projects/ChangeLog	(working copy)
@@ -1,3 +1,18 @@
+2009-06-09  Carlo Kok  <ck@remobjects.com>
+	* MonoDevelop.Projects.Dom/ITypeParameter.cs:
+	* MonoDevelop.Projects.Dom/TypeParameter.cs:
+	* MonoDevelop.Projects.Dom/DomCecilMethod.cs:
+	* MonoDevelop.Projects.Dom/DomCecilType.cs:
+	* MonoDevelop.Projects.Dom/InstantiatedParameterType.cs: Type 
+	  parameter variance support.
+	* MonoDevelop.Projects.Dom/IParameter.cs:
+	* MonoDevelop.Projects.Dom/DomParameter.cs:
+	* MonoDevelop.Projects.Dom/DomCecilParameter.cs: Default 
+	  parameter value support.
+	* MonoDevelop.Projects.Dom.Serialization/CodeCompletionDatabase.cs:
+	* MonoDevelop.Projects.Dom.Serialization/DomPersistence.cs:
+	  Store generic variance & default parameter values properly
+
 2009-06-09  Lluis Sanchez Gual  <lluis@novell.com>
 
 	* MonoDevelop.Projects.Policies/PolicyBag.cs: Fix MS.NET build
Index: main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom.Serialization/CodeCompletionDatabase.cs
===================================================================
--- main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom.Serialization/CodeCompletionDatabase.cs	(revision 135770)
+++ main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom.Serialization/CodeCompletionDatabase.cs	(working copy)
@@ -49,7 +49,7 @@
 	{
 		static protected readonly int MAX_ACTIVE_COUNT = 100;
 		static protected readonly int MIN_ACTIVE_COUNT = 10;
-		static protected readonly int FORMAT_VERSION   = 68;
+		static protected readonly int FORMAT_VERSION   = 69;
 		
 		NamespaceEntry rootNamespace;
 		protected ArrayList references;
Index: main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom.Serialization/DomPersistence.cs
===================================================================
--- main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom.Serialization/DomPersistence.cs	(revision 135770)
+++ main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom.Serialization/DomPersistence.cs	(working copy)
@@ -197,27 +197,34 @@
 			foreach (ITypeParameter genArg in method.TypeParameters) {
 				Write (writer, nameTable, genArg);
 			}
+		}
+
+		public static DomParameter ReadParameter (BinaryReader reader, INameDecoder nameTable)
+		{
+			DomParameter result = new DomParameter ();
+
+			result.Name = ReadString (reader, nameTable);
+			result.ParameterModifiers = (ParameterModifiers)reader.ReadUInt32 ();
+			result.ReturnType = ReadReturnType (reader, nameTable);
+			result.Location = ReadLocation (reader, nameTable);
+			if(reader.ReadBoolean())
+				result.DefaultValue = ReadExpression (reader, nameTable);
+			return result;
 		}
 		
-		public static DomParameter ReadParameter (BinaryReader reader, INameDecoder nameTable)
-		{
-			DomParameter result = new DomParameter ();
-			
-			result.Name               = ReadString (reader, nameTable);
-			result.ParameterModifiers = (ParameterModifiers)reader.ReadUInt32();
-			result.ReturnType         = ReadReturnType (reader, nameTable);
-			result.Location           = ReadLocation (reader, nameTable);
-			
-			return result;
-		}
-		
 		public static void Write (BinaryWriter writer, INameEncoder nameTable, IParameter parameter)
 		{
 			Debug.Assert (parameter != null);
 			WriteString (parameter.Name, writer, nameTable);
+			
 			writer.Write ((uint)parameter.ParameterModifiers);
 			Write (writer, nameTable, parameter.ReturnType);
-			Write (writer, nameTable, parameter.Location);
+			Write (writer, nameTable, parameter.Location);
+			if(parameter.DefaultValue is CodePrimitiveExpression) {
+				writer.Write (true);
+				Write (writer, nameTable, (CodePrimitiveExpression) parameter.DefaultValue);
+			} else
+				writer.Write (false); 
 		}
 		
 		public static DomProperty ReadProperty (BinaryReader reader, INameDecoder nameTable)
@@ -457,7 +464,11 @@
 			if ((f & 2) != 0)
 				tp.ValueTypeRequired = true;
 			if ((f & 4) != 0)
-				tp.ConstructorRequired = true;
+				tp.ConstructorRequired = true;
+
+			// Variance 
+
+			tp.Variance = (TypeParameterVariance)reader.ReadByte ();
 
 			// Constraints
 			
@@ -487,8 +498,12 @@
 				f |= 2;
 			if (typeParameter.ConstructorRequired)
 				f |= 4;
-			writer.Write (f);
-			
+			writer.Write (f);
+
+			// Variance 
+
+			writer.Write ((byte)typeParameter.Variance);
+
 			// Constraints
 			
 			writer.Write (typeParameter.Constraints.Count ());
@@ -568,15 +583,30 @@
 				SerializeObject (writer, exps);
 			} else {
 				writer.Write (exps.Length);
-				foreach (CodePrimitiveExpression exp in exps) {
-					if (exp.Value == null) {
-						writer.Write ((int) TypeCode.DBNull);
-					} else {
-						writer.Write ((int) Type.GetTypeCode (exp.Value.GetType ()));
-						WriteString (Convert.ToString (exp.Value, CultureInfo.InvariantCulture), writer, nameTable);
-					}
+				foreach (CodePrimitiveExpression exp in exps) {
+					Write (writer, nameTable, exp);		
 				}
 			}
+		}
+
+		public static void Write (BinaryWriter writer, INameEncoder nameTable, CodePrimitiveExpression exp)
+		{
+			if(exp.Value == null) {
+				writer.Write ((int)TypeCode.DBNull);
+			}
+			else {
+				writer.Write ((int)Type.GetTypeCode (exp.Value.GetType ()));
+				WriteString (Convert.ToString (exp.Value, CultureInfo.InvariantCulture), writer, nameTable);
+			}
+		}
+
+		public static CodeExpression ReadExpression (BinaryReader reader, INameDecoder nameTable)
+		{
+			TypeCode code = (TypeCode)reader.ReadInt32 ();
+			if(code == TypeCode.DBNull)
+				return new CodePrimitiveExpression (null);
+			else
+				return new CodePrimitiveExpression (Convert.ChangeType (ReadString (reader, nameTable), code, CultureInfo.InvariantCulture));
 		}
 		
 		public static CodeExpression[] ReadExpressionArray (BinaryReader reader, INameDecoder nameTable)
@@ -588,14 +618,8 @@
 				return (CodeExpression[]) DeserializeObject (reader);
 			} else {
 				CodeExpression[] exps = new CodeExpression[count];
-				for (int n=0; n<count; n++) {
-					object value;
-					TypeCode code = (TypeCode) reader.ReadInt32 ();
-					if (code == TypeCode.DBNull)
-						value = null;
-					else
-						value = Convert.ChangeType (ReadString (reader, nameTable), code, CultureInfo.InvariantCulture);
-					exps [n] = new CodePrimitiveExpression (value);
+				for (int n=0; n<count; n++) {
+					exps [n] = ReadExpression (reader, nameTable);
 				}
 				return exps;
 			}
Index: main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/DomCecilMethod.cs
===================================================================
--- main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/DomCecilMethod.cs	(revision 135770)
+++ main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/DomCecilMethod.cs	(working copy)
@@ -144,6 +144,7 @@
 			}
 			foreach (GenericParameter param in methodDefinition.GenericParameters) {
 				TypeParameter tp = new TypeParameter (param.FullName);
+				tp.Variance = (TypeParameterVariance)(((uint)param.Attributes) & 3);
 				foreach (TypeReference tr in param.Constraints)
 					tp.AddConstraint (DomCecilMethod.GetReturnType (tr));
 				AddTypeParameter (tp);
Index: main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/DomCecilParameter.cs
===================================================================
--- main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/DomCecilParameter.cs	(revision 135770)
+++ main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/DomCecilParameter.cs	(working copy)
@@ -60,6 +60,10 @@
 			}
 			if ((parameterDefinition.Attributes & ParameterAttributes.Optional) == ParameterAttributes.Optional) 
 				this.ParameterModifiers |= ParameterModifiers.Optional;
+
+			if((parameterDefinition.Attributes & ParameterAttributes.HasDefault) == ParameterAttributes.HasDefault) {
+				this.DefaultValue = new System.CodeDom.CodePrimitiveExpression (parameterDefinition.Constant);
+			}
 			
 			if (ReturnType.ArrayDimensions > 0) {
 				foreach (CustomAttribute customAttribute in parameterDefinition.CustomAttributes) {
Index: main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/DomCecilType.cs
===================================================================
--- main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/DomCecilType.cs	(revision 135770)
+++ main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/DomCecilType.cs	(working copy)
@@ -149,6 +149,7 @@
 			
 			foreach (GenericParameter parameter in typeDefinition.GenericParameters) {
 				TypeParameter tp = new TypeParameter (parameter.FullName);
+				tp.Variance = (TypeParameterVariance)(((uint)parameter.Attributes) & 3);
 				foreach (TypeReference tr in parameter.Constraints)
 					tp.AddConstraint (DomCecilMethod.GetReturnType (tr));
 				AddTypeParameter (tp);
Index: main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/DomParameter.cs
===================================================================
--- main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/DomParameter.cs	(revision 135770)
+++ main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/DomParameter.cs	(working copy)
@@ -27,6 +27,7 @@
 //
 
 using System;
+using System.CodeDom;
 using System.Collections.Generic;
 
 namespace MonoDevelop.Projects.Dom
@@ -35,6 +36,11 @@
 	{
 		protected List<IAttribute> attributes = null;
 
+		public CodeExpression DefaultValue {
+			get;
+			set;
+		}
+
 		public IMember DeclaringMember {
 			get;
 			set;
Index: main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/InstantiatedParameterType.cs
===================================================================
--- main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/InstantiatedParameterType.cs	(revision 135770)
+++ main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/InstantiatedParameterType.cs	(working copy)
@@ -129,6 +129,14 @@
 			}
 		}
 
+		public TypeParameterVariance Variance
+		{
+			get
+			{
+				return typeparam.Variance;
+			}
+		}
+
 		#endregion
 	}
 }
Index: main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/IParameter.cs
===================================================================
--- main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/IParameter.cs	(revision 135770)
+++ main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/IParameter.cs	(working copy)
@@ -27,6 +27,7 @@
 //
 
 using System;
+using System.CodeDom;
 using System.Collections.Generic;
 
 namespace MonoDevelop.Projects.Dom
@@ -74,5 +75,8 @@
 			get;
 		}
 		
+		CodeExpression DefaultValue {
+			get;
+		}
 	}
 }
Index: main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/ITypeParameter.cs
===================================================================
--- main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/ITypeParameter.cs	(revision 135770)
+++ main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/ITypeParameter.cs	(working copy)
@@ -30,6 +30,7 @@
 
 namespace MonoDevelop.Projects.Dom
 {
+	public enum TypeParameterVariance { None, Out, In }
 	public interface ITypeParameter
 	{
 		string Name { get; }
@@ -43,5 +44,7 @@
 		bool ClassRequired { get; }
 		
 		bool ValueTypeRequired { get; }
+
+		TypeParameterVariance Variance { get; }
 	}
 }
Index: main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/TypeParameter.cs
===================================================================
--- main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/TypeParameter.cs	(revision 135770)
+++ main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/TypeParameter.cs	(working copy)
@@ -46,6 +46,8 @@
 		
 		public bool ValueTypeRequired { get; set; }
 
+		public TypeParameterVariance Variance { get; set; }
+
 		List<IAttribute> attributes = null;
 		static readonly IAttribute[] emptyAttributes = new IAttribute[0];
 		public IEnumerable<IAttribute> Attributes {