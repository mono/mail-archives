Index: main/src/core/MonoDevelop.Projects/ChangeLog
===================================================================
--- main/src/core/MonoDevelop.Projects/ChangeLog	(revision 135402)
+++ main/src/core/MonoDevelop.Projects/ChangeLog	(working copy)
@@ -1,3 +1,15 @@
+2009-06-04  Carlo Kok  <ck@remobjects.com>
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
+
 2009-06-04  Lluis Sanchez Gual  <lluis@novell.com>
 
 	* MonoDevelop.Projects.Dom/DomCecilProperty.cs: Indexers may
Index: main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/DomCecilMethod.cs
===================================================================
--- main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/DomCecilMethod.cs	(revision 135402)
+++ main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/DomCecilMethod.cs	(working copy)
@@ -143,7 +143,8 @@
 				this.name = methodDefinition.Name;
 			}
 			foreach (GenericParameter param in methodDefinition.GenericParameters) {
-				TypeParameter tp = new TypeParameter (param.FullName);
+				TypeParameter tp = new TypeParameter (param.FullName);
+				tp.Variance = (TypeParameterVariance)(((uint)param.Attributes) & 3);
 				foreach (TypeReference tr in param.Constraints)
 					tp.AddConstraint (DomCecilMethod.GetReturnType (tr));
 				AddTypeParameter (tp);
Index: main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/DomCecilParameter.cs
===================================================================
--- main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/DomCecilParameter.cs	(revision 135402)
+++ main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/DomCecilParameter.cs	(working copy)
@@ -59,7 +59,11 @@
 				this.ParameterModifiers = ParameterModifiers.In;
 			}
 			if ((parameterDefinition.Attributes & ParameterAttributes.Optional) == ParameterAttributes.Optional) 
-				this.ParameterModifiers |= ParameterModifiers.Optional;
+				this.ParameterModifiers |= ParameterModifiers.Optional;
+
+			if((parameterDefinition.Attributes & ParameterAttributes.HasDefault) == ParameterAttributes.HasDefault) {
+				this.DefaultValue = new System.CodeDom.CodePrimitiveExpression (parameterDefinition.Constant);
+			}
 			
 			if (ReturnType.ArrayDimensions > 0) {
 				foreach (CustomAttribute customAttribute in parameterDefinition.CustomAttributes) {
Index: main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/DomCecilType.cs
===================================================================
--- main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/DomCecilType.cs	(revision 135402)
+++ main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/DomCecilType.cs	(working copy)
@@ -140,7 +140,8 @@
 			}
 			
 			foreach (GenericParameter parameter in typeDefinition.GenericParameters) {
-				TypeParameter tp = new TypeParameter (parameter.FullName);
+				TypeParameter tp = new TypeParameter (parameter.FullName);
+				tp.Variance = (TypeParameterVariance)(((uint)parameter.Attributes) & 3);
 				foreach (TypeReference tr in parameter.Constraints)
 					tp.AddConstraint (DomCecilMethod.GetReturnType (tr));
 				AddTypeParameter (tp);
Index: main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/DomParameter.cs
===================================================================
--- main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/DomParameter.cs	(revision 135402)
+++ main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/DomParameter.cs	(working copy)
@@ -27,13 +27,19 @@
 //
 
 using System;
+using System.CodeDom;
 using System.Collections.Generic;
 
 namespace MonoDevelop.Projects.Dom
 {
 	public class DomParameter : IParameter
 	{
-		protected List<IAttribute> attributes = null;
+		protected List<IAttribute> attributes = null;
+
+		public CodeExpression DefaultValue {
+			get;
+			set;
+		}
 
 		public IMember DeclaringMember {
 			get;
Index: main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/InstantiatedParameterType.cs
===================================================================
--- main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/InstantiatedParameterType.cs	(revision 135402)
+++ main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/InstantiatedParameterType.cs	(working copy)
@@ -52,7 +52,7 @@
 			Name = tp.Name;
 			Namespace = outerType.Namespace;
 			Location = outerType.Location;
-			DeclaringType = outerType;
+			DeclaringType = outerType;
 			
 			if (tp.ValueTypeRequired)
 				BaseType = new DomReturnType ("System.ValueType");
@@ -127,6 +127,14 @@
 			get { 
 				return typeparam.ValueTypeRequired;
 			}
+		}
+
+		public TypeParameterVariance Variance
+		{
+			get
+			{
+				return typeparam.Variance;
+			}
 		}
 
 		#endregion
Index: main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/IParameter.cs
===================================================================
--- main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/IParameter.cs	(revision 135402)
+++ main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/IParameter.cs	(working copy)
@@ -26,7 +26,8 @@
 // WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 //
 
-using System;
+using System;
+using System.CodeDom;
 using System.Collections.Generic;
 
 namespace MonoDevelop.Projects.Dom
@@ -72,7 +73,10 @@
 		
 		string StockIcon {
 			get;
+		}
+		
+		CodeExpression DefaultValue {
+			get;
 		}
-		
 	}
 }
Index: main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/ITypeParameter.cs
===================================================================
--- main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/ITypeParameter.cs	(revision 135402)
+++ main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/ITypeParameter.cs	(working copy)
@@ -29,7 +29,8 @@
 using System.Collections.Generic;
 
 namespace MonoDevelop.Projects.Dom
-{
+{
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
--- main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/TypeParameter.cs	(revision 135402)
+++ main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/TypeParameter.cs	(working copy)
@@ -44,7 +44,9 @@
 		
 		public bool ClassRequired { get; set; }
 		
-		public bool ValueTypeRequired { get; set; }
+		public bool ValueTypeRequired { get; set; }
+
+		public TypeParameterVariance Variance { get; set; }
 
 		List<IAttribute> attributes = null;
 		static readonly IAttribute[] emptyAttributes = new IAttribute[0];