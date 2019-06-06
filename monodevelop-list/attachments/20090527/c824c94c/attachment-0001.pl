Index: main/src/core/MonoDevelop.Projects/ChangeLog
===================================================================
--- main/src/core/MonoDevelop.Projects/ChangeLog	(revision 134823)
+++ main/src/core/MonoDevelop.Projects/ChangeLog	(working copy)
@@ -1,3 +1,8 @@
+2009-05-27  Carlo Kok  <ck@remobjects.com>
+	* Added enum to IMember and IType to distinguish between the different
+	  members and types.
+	* Added pointer to array support to IReturnType
+
 2009-05-26  Lluis Sanchez Gual  <lluis@novell.com>
 
 	* MonoDevelop.Projects.Policies/PolicySet.cs: Avoid throwing
Index: main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/AbstractMember.cs
===================================================================
--- main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/AbstractMember.cs	(revision 134823)
+++ main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/AbstractMember.cs	(working copy)
@@ -40,6 +40,10 @@
 		
 		protected IType  declaringType;
 		
+		public abstract MemberType MemberType {
+			get;
+		}
+		
 		public IType DeclaringType {
 			get {
 				return declaringType;
Index: main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/DomCecilMethod.cs
===================================================================
--- main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/DomCecilMethod.cs	(revision 134823)
+++ main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/DomCecilMethod.cs	(working copy)
@@ -104,7 +104,10 @@
 			if (typeReference is Mono.Cecil.PointerType) {
 				Mono.Cecil.PointerType ptrType = (Mono.Cecil.PointerType)typeReference;
 				DomReturnType result = GetReturnType (ptrType.ElementType);
-				result.PointerNestingLevel++;
+				if (result.ArrayDimensions > 0)
+					result.ArrayPointerNestingLevel++;
+				else 
+					result.PointerNestingLevel++;
 				return result;
 			}
 			if (typeReference is Mono.Cecil.ReferenceType)
Index: main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/DomEvent.cs
===================================================================
--- main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/DomEvent.cs	(revision 134823)
+++ main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/DomEvent.cs	(working copy)
@@ -37,6 +37,12 @@
 		IMethod removeMethod = null;
 		IMethod raiseMethod = null;
 		
+		public override MemberType MemberType {
+			get {
+				return MemberType.Event;
+			}
+		}
+		
 		public virtual IMethod AddMethod {
 			get {
 				if (addMethod != null)
Index: main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/DomField.cs
===================================================================
--- main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/DomField.cs	(revision 134823)
+++ main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/DomField.cs	(working copy)
@@ -38,6 +38,12 @@
 			}
 		}
 		
+		public override MemberType MemberType {
+			get {
+				return MemberType.Field;
+			}
+		}
+		
 		static readonly string[] iconTable = {Stock.Field, Stock.PrivateField, Stock.ProtectedField, Stock.InternalField};
 		
 		public override string StockIcon {
Index: main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/DomMemberDecorator.cs
===================================================================
--- main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/DomMemberDecorator.cs	(revision 134823)
+++ main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/DomMemberDecorator.cs	(working copy)
@@ -41,6 +41,12 @@
 		
 		#region IMember implementation 
 		
+		public virtual MemberType MemberType {
+			get {
+				return member.MemberType;
+			}
+		}
+		
 		public virtual System.Xml.XmlNode GetMonodocDocumentation ()
 		{
 			return member.GetMonodocDocumentation ();
Index: main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/DomMethod.cs
===================================================================
--- main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/DomMethod.cs	(revision 134823)
+++ main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/DomMethod.cs	(working copy)
@@ -42,7 +42,13 @@
 
 		static readonly ReadOnlyCollection<IParameter> emptyParameters = new ReadOnlyCollection<IParameter> (new IParameter [0]);
 		static readonly ReadOnlyCollection<ITypeParameter> emptyGenericParameters = new ReadOnlyCollection<ITypeParameter> (new ITypeParameter [0]);
-
+		
+		public override MemberType MemberType {
+			get {
+				return MemberType.Method;
+			}
+		}
+		
 		public virtual MethodModifier MethodModifier {
 			get;
 			set;
Index: main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/DomProperty.cs
===================================================================
--- main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/DomProperty.cs	(revision 134823)
+++ main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/DomProperty.cs	(working copy)
@@ -37,7 +37,13 @@
 	public class DomProperty : AbstractMember, IProperty
 	{
 		protected List<IParameter> parameters = null;
-
+		
+		public override MemberType MemberType {
+			get {
+				return MemberType.Property;
+			}
+		}
+		
 		public PropertyModifier PropertyModifier {
 			get;
 			set;
Index: main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/DomReturnType.cs
===================================================================
--- main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/DomReturnType.cs	(revision 134823)
+++ main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/DomReturnType.cs	(working copy)
@@ -166,7 +166,7 @@
 		}
 		
 		protected string nspace;
-		protected int pointerNestingLevel;
+		protected int pointerNestingLevel, arrayPointerNestingLevel;
 		protected int[] dimensions = null;
 		ReturnTypeModifiers modifiers;
 		
@@ -228,6 +228,16 @@
 				nspace = value;
 			}
 		}
+		
+		public int ArrayPointerNestingLevel {
+			get {
+				return arrayPointerNestingLevel;
+			}
+			set {
+				arrayPointerNestingLevel = value;
+			}
+		}
+		
 		public int PointerNestingLevel {
 			get {
 				return pointerNestingLevel;
@@ -410,17 +420,23 @@
 				if (result.Length > 0)
 					result.Append ('.');
 				result.Append (part.ToInvariantString ());
-			}
+							}
+			if (this.IsNullable)
+				result.Append ('?');
+
+			result.Append (new string ('*', this.PointerNestingLevel));
+
 			for (int i = 0; i < ArrayDimensions; i++) {
 				result.Append ('[');
 				result.Append (new string (',', this.GetDimension (i)));
 				result.Append (']');
 			}
-			result.Append (new string ('*', this.PointerNestingLevel));
+			
+			result.Append (new string ('*', this.ArrayPointerNestingLevel));
+
 			if (this.IsByRef)
 				result.Append ('&');
-			if (this.IsNullable)
-				result.Append ('?');
+
 			return invariantString = result.ToString ();
 		}
 		
Index: main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/DomType.cs
===================================================================
--- main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/DomType.cs	(revision 134823)
+++ main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/DomType.cs	(working copy)
@@ -50,8 +50,19 @@
 		
 		protected ClassType classType = ClassType.Unknown;
 		protected string nameSpace;
-		
-		
+
+		public override MemberType MemberType {
+			get {
+				return MemberType.Type;
+			}
+		}
+
+		public virtual TypeKind Kind {
+			get {
+				return TypeKind.Definition;
+			}
+		}
+
 		protected override string CalculateFullName ()
 		{
 			base.fullNameIsDirty = false;
@@ -177,7 +188,7 @@
 		public virtual IEnumerable<IType> InnerTypes {
 			get {
 				foreach (IMember item in Members)
-					if (item is IType)
+					if (item.MemberType == MemberType.Type)
 						yield return (IType)item;
 			}
 		}
@@ -185,7 +196,7 @@
 		public virtual IEnumerable<IField> Fields {
 			get {
 				foreach (IMember item in Members)
-					if (item is IField)
+					if (item.MemberType == MemberType.Field)
 						yield return (IField)item;
 			}
 		}
@@ -193,7 +204,7 @@
 		public virtual IEnumerable<IProperty> Properties {
 			get {
 				foreach (IMember item in Members)
-					if (item is IProperty)
+					if (item.MemberType == MemberType.Property)
 						yield return (IProperty)item;
 			}
 		}
@@ -201,7 +212,7 @@
 		public virtual IEnumerable<IMethod> Methods {
 			get {
 				foreach (IMember item in Members)
-					if (item is IMethod)
+					if (item.MemberType == MemberType.Method)
 						yield return (IMethod)item;
 			}
 		}
@@ -209,7 +220,7 @@
 		public virtual IEnumerable<IEvent> Events {
 			get {
 				foreach (IMember item in Members)
-					if (item is IEvent)
+					if (item.MemberType == MemberType.Event)
 						yield return (IEvent)item;
 			}
 		}
@@ -372,11 +383,14 @@
 		
 		public bool HasOverriden (IMember member)
 		{
-			if (member is IMethod)
-				return HasOverriden (member as IMethod);
-			if (member is IProperty)
-				return HasOverriden (member as IProperty);
-			return false;
+			switch (member.MemberType) {
+				case MemberType.Method:
+					return HasOverriden (member as IMethod);
+				case MemberType.Property:
+					return HasOverriden (member as IProperty);
+				default:
+					return false;
+			}
 		}
 		
 		public bool IsBaseType (IReturnType type)
@@ -510,18 +524,26 @@
 		
 		public void Add (IMember member)
 		{
-			if (member is IField)
-				Add ((IField) member);
-			else if (member is IMethod)
-				Add ((IMethod) member);
-			else if (member is IProperty)
-				Add ((IProperty) member);
-			else if (member is IEvent)
-				Add ((IEvent) member);
-			else if (member is IType)
-				Add ((IType) member);
-			else
-				throw new InvalidOperationException ();
+			switch (member.MemberType)
+			{
+				case MemberType.Field:
+					Add ((IField) member);
+					break;
+				case MemberType.Method:
+					Add ((IMethod) member);
+					break;
+				case MemberType.Property:
+					Add ((IProperty) member);
+					break;
+				case MemberType.Event:
+					Add ((IEvent) member);
+					break;
+				case MemberType.Type:
+					Add ((IType) member);
+					break;
+				default:
+					throw new InvalidOperationException ();
+			}
 		}
 		
 		protected void ClearInterfaceImplementations ()
Index: main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/IMember.cs
===================================================================
--- main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/IMember.cs	(revision 134823)
+++ main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/IMember.cs	(working copy)
@@ -32,6 +32,17 @@
 
 namespace MonoDevelop.Projects.Dom
 {
+	public enum MemberType
+	{
+		Field,
+		Constructor,
+		Method,
+		Property,
+		Event,
+		Type,
+		Namespace
+	}
+
 	public interface IMember : IComparable, IDomVisitable
 	{
 		string FullName {
@@ -88,7 +99,11 @@
 		
 		System.Xml.XmlNode GetMonodocDocumentation ();
 		bool IsAccessibleFrom (ProjectDom dom, IType calledType, IMember member, bool includeProtected);
-		
+
+		MemberType MemberType {
+			get;
+		}
+
 		#region ModifierAccessors
 		bool IsObsolete { get; }
 		bool IsPrivate   { get; }
Index: main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/InstantiatedParameterType.cs
===================================================================
--- main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/InstantiatedParameterType.cs	(revision 134823)
+++ main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/InstantiatedParameterType.cs	(working copy)
@@ -32,10 +32,20 @@
 
 namespace MonoDevelop.Projects.Dom
 {
-	internal class InstantiatedParameterType: DomType
+	internal class InstantiatedParameterType : DomType, ITypeParameterType
 	{
+		TypeParameter typeparam;
+
+		public override TypeKind Kind
+		{
+			get {
+				return TypeKind.GenericParameter;
+			}
+		}
+
 		public InstantiatedParameterType (ProjectDom dom, IType outerType, TypeParameter tp)
 		{
+			typeparam = tp;
 			compilationUnit = outerType.CompilationUnit;
 			ClassType = ClassType.Class;
 			Modifiers = Modifiers.Public;
@@ -91,5 +101,34 @@
 			}
 			return false;
 		}
+
+		#region ITypeParameter Members
+
+
+		public IList<IReturnType> Constraints {
+			get { 
+				return typeparam.Constraints; 
+			}
+		}
+
+		public bool ConstructorRequired {
+			get {
+				return typeparam.ConstructorRequired;
+			}
+		}
+
+		public bool ClassRequired {
+			get { 
+				return typeparam.ClassRequired; 
+			}
+		}
+
+		public bool ValueTypeRequired {
+			get { 
+				return typeparam.ValueTypeRequired;
+			}
+		}
+
+		#endregion
 	}
 }
Index: main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/InstantiatedType.cs
===================================================================
--- main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/InstantiatedType.cs	(revision 134823)
+++ main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/InstantiatedType.cs	(working copy)
@@ -31,10 +31,17 @@
 
 namespace MonoDevelop.Projects.Dom
 {
-	public class InstantiatedType : DomType
+	public class InstantiatedType : DomType, IInstantiatedType
 	{
 		IList<IReturnType> genericParameters = null;
 		static readonly IList<IReturnType> emptyList = new IReturnType[0];
+
+		public override TypeKind Kind {
+			get {
+				return TypeKind.GenericInstantiation;
+			}
+		}
+
 		public IList<IReturnType> GenericParameters {
 			get {
 				return genericParameters ?? emptyList;
Index: main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/IReturnType.cs
===================================================================
--- main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/IReturnType.cs	(revision 134823)
+++ main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/IReturnType.cs	(working copy)
@@ -57,6 +57,8 @@
 	/// General return type format:
 	/// Namespace.Part1,...,PartN
 	/// Where Part is a typename: Typename&lt;arg1, ... ,argn&gt;
+	/// Elements are defined in the order they would appear on a string:
+	/// {Namespace} {Parts} '?'{nullable} '*'{PointerNestingLevel} '[]'*{ArrayDimensions}, '*'{ArrayPointerNestingLevel} '&'{ByRef}
 	/// </summary>
 	public interface IReturnType : IReturnTypePart, IDomVisitable
 	{
@@ -72,6 +74,11 @@
 		List<IReturnTypePart> Parts {
 			get;
 		}
+
+		bool IsNullable
+		{
+			get;
+		}
 		
 		int PointerNestingLevel {
 			get;
@@ -80,16 +87,17 @@
 		int ArrayDimensions {
 			get;
 		}
-		
-		ReturnTypeModifiers Modifiers {
+
+		int ArrayPointerNestingLevel {
 			get;
 		}
 		
 		bool IsByRef {
 			get;
 		}
-		
-		bool IsNullable {
+
+		ReturnTypeModifiers Modifiers
+		{
 			get;
 		}
 		
Index: main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/IType.cs
===================================================================
--- main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/IType.cs	(revision 134823)
+++ main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/IType.cs	(working copy)
@@ -33,6 +33,13 @@
 
 namespace MonoDevelop.Projects.Dom
 {
+	public enum TypeKind 
+	{
+		Definition,
+		GenericInstantiation,
+		GenericParameter
+	}
+
 	public interface IType : IMember, IEquatable<IType>
 	{
 		string Namespace {
@@ -151,5 +158,24 @@
 		}
 		
 		List<IMethod> GetExtensionMethods (List<IType> accessibleExtensionTypes);
+
+		TypeKind Kind {
+			get;
+		}
 	}
+
+	public interface IInstantiatedType : IType
+	{
+		IList<IReturnType> GenericParameters {
+			get;
+		}
+		
+		IType UninstantiatedType { 
+			get; 
+		}
+	}
+
+	public interface ITypeParameterType : IType, ITypeParameter
+	{
+	}
 }
Index: main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/Namespace.cs
===================================================================
--- main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/Namespace.cs	(revision 134823)
+++ main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/Namespace.cs	(working copy)
@@ -43,6 +43,12 @@
 			this.Documentation = documentation;
 		}
 		
+		public override MemberType MemberType {
+			get {
+				return MemberType.Namespace;
+			}
+		}
+		
 		public override string ToString ()
 		{
 			return string.Format ("[Namespace: Name={0}]", name);