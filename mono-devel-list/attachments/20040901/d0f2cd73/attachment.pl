Index: class/System/Microsoft.CSharp/CSharpCodeGenerator.cs
===================================================================
RCS file: /cvs/public/mcs/class/System/Microsoft.CSharp/CSharpCodeGenerator.cs,v
retrieving revision 1.24
diff -u -r1.24 CSharpCodeGenerator.cs
--- class/System/Microsoft.CSharp/CSharpCodeGenerator.cs	13 Jul 2004 02:22:26 -0000	1.24
+++ class/System/Microsoft.CSharp/CSharpCodeGenerator.cs	31 Aug 2004 22:07:51 -0000
@@ -40,11 +40,16 @@
 	internal class CSharpCodeGenerator
 		: CodeGenerator
 	{
+            
+		// It is used for beautiful "for" syntax
+		bool dont_write_semicolon;
+            
 		//
 		// Constructors
 		//
 		public CSharpCodeGenerator()
 		{
+			dont_write_semicolon = false;
 		}
 
 		//
@@ -87,7 +92,7 @@
 
 				OutputType( createType );
 				
-				output.WriteLine( "[] {" );
+				output.WriteLine( "{" );
 				++Indent;
 				OutputExpressionList( initializers, true );
 				--Indent;
@@ -278,13 +283,16 @@
 		protected override void GenerateExpressionStatement( CodeExpressionStatement statement )
 		{
 			GenerateExpression( statement.Expression );
+			if (dont_write_semicolon)
+				return;
 			Output.WriteLine( ';' );
 		}
 
 		protected override void GenerateIterationStatement( CodeIterationStatement statement )
 		{
 			TextWriter output = Output;
-
+                    
+			dont_write_semicolon = true;
 			output.Write( "for (" );
 			GenerateStatement( statement.InitStatement );
 			output.Write( "; " );
@@ -292,7 +300,12 @@
 			output.Write( "; " );
 			GenerateStatement( statement.IncrementStatement );
 			output.Write( ") " );
+			dont_write_semicolon = false;
+			output.WriteLine ('{');
+			++Indent;
 			GenerateStatements( statement.Statements );
+			--Indent;
+			output.WriteLine ('}');
 		}
 
 		protected override void GenerateThrowExceptionStatement( CodeThrowExceptionStatement statement )
@@ -410,6 +423,8 @@
 			GenerateExpression( statement.Left );
 			output.Write( " = " );
 			GenerateExpression( statement.Right );
+			if (dont_write_semicolon)
+				return;
 			output.WriteLine( ';' );
 		}
 
@@ -485,6 +500,9 @@
 
 		protected override void GenerateEvent( CodeMemberEvent eventRef, CodeTypeDeclaration declaration )
 		{
+			if (eventRef.CustomAttributes.Count > 0)
+				OutputAttributeDeclarations (eventRef.CustomAttributes);
+
 			OutputMemberAccessModifier (eventRef.Attributes);
 			OutputMemberScopeModifier (eventRef.Attributes | MemberAttributes.Final); // Don't output "virtual"
 			Output.Write ("event ");
@@ -499,14 +517,15 @@
 			if (field.CustomAttributes.Count > 0)
 				OutputAttributeDeclarations( field.CustomAttributes );
 
-			MemberAttributes attributes = field.Attributes;
-			OutputMemberAccessModifier( attributes );
-			OutputFieldScopeModifier( attributes );
-
 			if (IsCurrentEnum)
 				Output.Write(field.Name);
-			else
+			else {
+				MemberAttributes attributes = field.Attributes;
+				OutputMemberAccessModifier( attributes );
+				OutputFieldScopeModifier( attributes );
+
 				OutputTypeNamePair( field.Type, GetSafeName (field.Name) );
+			}
 
 			CodeExpression initExpression = field.InitExpression;
 			if ( initExpression != null ) {
@@ -642,6 +661,9 @@
 		protected override void GenerateConstructor( CodeConstructor constructor,
 							     CodeTypeDeclaration declaration )
 		{
+			if (constructor.CustomAttributes.Count > 0)
+				OutputAttributeDeclarations (constructor.CustomAttributes);
+
 			OutputMemberAccessModifier (constructor.Attributes);
 			Output.Write (GetSafeName (CurrentTypeName) + " (");
 			OutputParameters (constructor.Parameters);
@@ -796,6 +818,7 @@
 			Output.Write( GetTypeOutput( type ) );
 		}
 
+		[MonoTODO ("Implement missing special characters")]
 		protected override string QuoteSnippetString( string value )
 		{
 			// FIXME: this is weird, but works.
@@ -882,59 +905,60 @@
 			if ( arrayType != null )
 				output = GetTypeOutput( arrayType );
 			else { 
-				switch ( type.BaseType ) {
 
-				case "System.Decimal":
+				switch ( type.BaseType.ToLower (System.Globalization.CultureInfo.InvariantCulture)) {
+
+				case "system.decimal":
 					output = "decimal";
 					break;
-				case "System.Double":
+				case "system.double":
 					output = "double";
 					break;
-				case "System.Single":
+				case "system.single":
 					output = "float";
 					break;
 					
-				case "System.Byte":
+				case "system.byte":
 					output = "byte";
 					break;
-				case "System.SByte":
+				case "system.sbyte":
 					output = "sbyte";
 					break;
-				case "System.Int32":
+				case "system.int32":
 					output = "int";
 					break;
-				case "System.UInt32":
+				case "system.uint32":
 					output = "uint";
 					break;
-				case "System.Int64":
+				case "system.int64":
 					output = "long";
 					break;
-				case "System.UInt64":
+				case "system.uint64":
 					output = "ulong";
 					break;
-				case "System.Int16":
+				case "system.int16":
 					output = "short";
 					break;
-				case "System.UInt16":
+				case "system.uint16":
 					output = "ushort";
 					break;
 
-				case "System.Boolean":
+				case "system.boolean":
 					output = "bool";
 					break;
 					
-				case "System.Char":
+				case "system.char":
 					output = "char";
 					break;
 
-				case "System.String":
+				case "system.string":
 					output = "string";
 					break;
-				case "System.Object":
+				case "system.object":
 					output = "object";
 					break;
 
-				case "System.Void":
+				case "system.void":
 					output = "void";
 					break;
 
@@ -954,7 +978,7 @@
 				output += "]";
 			}
 
-			return output;
+			return output.Replace ('+', '.');
 		}
 
 		protected override bool IsValidIdentifier ( string identifier )
Index: class/System/Microsoft.CSharp/ChangeLog
===================================================================
RCS file: /cvs/public/mcs/class/System/Microsoft.CSharp/ChangeLog,v
retrieving revision 1.48
diff -u -r1.48 ChangeLog
--- class/System/Microsoft.CSharp/ChangeLog	22 Jul 2004 17:36:52 -0000	1.48
+++ class/System/Microsoft.CSharp/ChangeLog	31 Aug 2004 22:54:39 -0000
@@ -1,3 +1,13 @@
+2004-09-01 Marek Safar <marek.safar@seznam.cz>
+
+	* CSharpCodeGenerator.cs : New private member dont_write_semicolon.
+	Used for one row "for" syntax.
+	(GenerateEvent): Added attributes output.
+	(GenerateField): Don't output access and scope modifier for enum field.
+	(GenerateConstructor): Added attributes output.
+	(QuoteSnippetString): Fixed mixed case type conversion. Replace '+'
+	with '.' for nested classes.
+
 2004-07-21  Lluis Sanchez Gual  <lluis@novell.com>
 
 	* CSharpCodeCompiler.cs: Hack to make code generation work in 2.0.
Index: class/System/System.CodeDom/ChangeLog
===================================================================
RCS file: /cvs/public/mcs/class/System/System.CodeDom/ChangeLog,v
retrieving revision 1.12
diff -u -r1.12 ChangeLog
--- class/System/System.CodeDom/ChangeLog	9 Aug 2004 16:29:28 -0000	1.12
+++ class/System/System.CodeDom/ChangeLog	31 Aug 2004 22:39:44 -0000
@@ -1,3 +1,14 @@
+2004-09-01 Marek Safar <marek.safar@seznam.cz>
+
+	* CodeCatchClause.cs: System.Exception is default type
+	 for string constructor.
+
+	* CodeTypeMember.cs: Default member attributes are
+	private and final.
+
+	* CodeTypeReference.cs: Implemented array info extraction
+	from Type.
+
 2004-08-09 Gonzalo Paniagua Javier <gonzalo@ximian.com>
 
 	* CodeEntryPointMethod.cs: patch by Fawad Halim that makes the entry
Index: class/System/System.CodeDom/CodeCatchClause.cs
===================================================================
RCS file: /cvs/public/mcs/class/System/System.CodeDom/CodeCatchClause.cs,v
retrieving revision 1.6
diff -u -r1.6 CodeCatchClause.cs
--- class/System/System.CodeDom/CodeCatchClause.cs	21 Jun 2004 17:59:54 -0000	1.6
+++ class/System/System.CodeDom/CodeCatchClause.cs	31 Aug 2004 22:34:39 -0000
@@ -52,6 +52,7 @@
 		public CodeCatchClause ( string localName )
 		{
 			this.localName = localName;
+			this.catchExceptionType = new CodeTypeReference (typeof (Exception));
 		}
 
 		public CodeCatchClause ( string localName,
Index: class/System/System.CodeDom/CodeTypeMember.cs
===================================================================
RCS file: /cvs/public/mcs/class/System/System.CodeDom/CodeTypeMember.cs,v
retrieving revision 1.7
diff -u -r1.7 CodeTypeMember.cs
--- class/System/System.CodeDom/CodeTypeMember.cs	21 Jun 2004 17:59:54 -0000	1.7
+++ class/System/System.CodeDom/CodeTypeMember.cs	30 Aug 2004 21:25:48 -0000
@@ -50,6 +50,7 @@
 		//
 		public CodeTypeMember()
 		{
+			attributes = (MemberAttributes.Private | MemberAttributes.Final);
 		}
 		
 		//
Index: class/System/System.CodeDom/CodeTypeReference.cs
===================================================================
RCS file: /cvs/public/mcs/class/System/System.CodeDom/CodeTypeReference.cs,v
retrieving revision 1.4
diff -u -r1.4 CodeTypeReference.cs
--- class/System/System.CodeDom/CodeTypeReference.cs	21 Jun 2004 17:59:54 -0000	1.4
+++ class/System/System.CodeDom/CodeTypeReference.cs	30 Aug 2004 20:51:48 -0000
@@ -45,6 +45,7 @@
 		//
 		// Constructors
 		//
+		[MonoTODO ("Missing implementation. Implement array info extraction from the string")]
 		public CodeTypeReference( string baseType )
 		{
 			this.baseType = baseType;
@@ -52,6 +53,11 @@
 		
 		public CodeTypeReference( Type baseType )
 		{
+			if (baseType.IsArray) {
+				this.rank = baseType.GetArrayRank ();
+				this.arrayType = new CodeTypeReference (baseType.GetElementType ());
+				return;
+			}
 			this.baseType = baseType.FullName;
 		}
 
Index: class/System/System.CodeDom.Compiler/ChangeLog
===================================================================
RCS file: /cvs/public/mcs/class/System/System.CodeDom.Compiler/ChangeLog,v
retrieving revision 1.32
diff -u -r1.32 ChangeLog
--- class/System/System.CodeDom.Compiler/ChangeLog	9 Aug 2004 17:24:51 -0000	1.32
+++ class/System/System.CodeDom.Compiler/ChangeLog	31 Aug 2004 22:58:33 -0000
@@ -1,3 +1,9 @@
+2004-09-01  Marek Safar  <marek.safar@seznam.cz>
+
+	* CodeGenerator.cs : Added newline after global attributes output.
+	(OutputAttributeDeclaration): Replace '+' with '.' for nested
+	attribute types.
+
 2004-08-09  Atsushi Enomoto  <atsushi@ximian.com>
 
 	* CodeGenerator.cs :
Index: class/System/System.CodeDom.Compiler/CodeGenerator.cs
===================================================================
RCS file: /cvs/public/mcs/class/System/System.CodeDom.Compiler/CodeGenerator.cs,v
retrieving revision 1.23
diff -u -r1.23 CodeGenerator.cs
--- class/System/System.CodeDom.Compiler/CodeGenerator.cs	9 Aug 2004 17:24:51 -0000	1.23
+++ class/System/System.CodeDom.Compiler/CodeGenerator.cs	31 Aug 2004 21:47:29 -0000
@@ -199,6 +199,7 @@
 					OutputAttributeDeclaration (att);
 					GenerateAttributeDeclarationsEnd (attributes);
 				}
+				output.WriteLine ();
 			}
 
 			foreach (CodeNamespace ns in compileUnit.Namespaces)
@@ -642,7 +643,7 @@
 
 		private void OutputAttributeDeclaration (CodeAttributeDeclaration attribute)
 		{
-			output.Write (attribute.Name);
+			output.Write (attribute.Name.Replace ('+', '.'));
 			output.Write ('(');
 			IEnumerator enumerator = attribute.Arguments.GetEnumerator();
 			if (enumerator.MoveNext()) {
