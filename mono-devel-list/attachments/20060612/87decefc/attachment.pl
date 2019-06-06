Index: Mono.Cecil/AssemblyResolver.cs
===================================================================
--- Mono.Cecil/AssemblyResolver.cs	(revision 0)
+++ Mono.Cecil/AssemblyResolver.cs	(revision 0)
@@ -0,0 +1,76 @@
+//
+// AssemblyResolver.cs
+//
+// Author:
+//   Eyal Alaluf (eyala@mainsoft.com), Vladislav Spivak (spivak@mainsoft.com)
+//
+// (C) 2006 Mainsoft Co.
+//
+// Permission is hereby granted, free of charge, to any person obtaining
+// a copy of this software and associated documentation files (the
+// "Software"), to deal in the Software without restriction, including
+// without limitation the rights to use, copy, modify, merge, publish,
+// distribute, sublicense, and/or sell copies of the Software, and to
+// permit persons to whom the Software is furnished to do so, subject to
+// the following conditions:
+//
+// The above copyright notice and this permission notice shall be
+// included in all copies or substantial portions of the Software.
+//
+// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
+// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
+// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
+// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+//
+
+using System;
+using System.Collections;
+using System.IO;
+
+namespace Mono.Cecil
+{
+	/// <summary>
+	/// Summary description for Resolver.
+	/// </summary>
+	/// 
+
+	public class AssemblyResolver : IAssemblyResolver
+	{
+		private readonly string [] _libpath;		
+		private readonly Hashtable _asmdefs = new Hashtable();
+
+		public AssemblyResolver(string libpath)
+		{
+			_libpath = libpath.Split(';');
+		}
+
+		public IAssemblyDefinition GetAssembly(string name)
+		{
+			if (_asmdefs.ContainsKey(name))
+				return (IAssemblyDefinition)_asmdefs[name];
+
+			foreach(string dir in _libpath)
+			{
+				//try dlls first
+				string finalname = null;
+				if (File.Exists(dir+"\\"+name + ".dll"))
+					finalname = dir+"\\"+name + ".dll";
+				else if (File.Exists(dir+"\\"+name + ".exe"))
+					finalname = dir+"\\"+name + ".exe";
+				else if (File.Exists(dir+"\\"+name))
+					finalname = dir+"\\"+name;
+				else
+					continue;
+
+				IAssemblyDefinition asm = AssemblyFactory.GetAssembly (finalname);
+				_asmdefs.Add(name, asm);
+				return asm;
+			}
+
+			throw new FileNotFoundException(name + ".dll");
+		}
+	}
+}
Index: Mono.Cecil/AssemblyFactory.cs
===================================================================
--- Mono.Cecil/AssemblyFactory.cs	(revision 61523)
+++ Mono.Cecil/AssemblyFactory.cs	(working copy)
@@ -37,6 +37,8 @@
 
 	public sealed class AssemblyFactory {
 
+		public static IAssemblyResolver Resolver;
+
 		AssemblyFactory ()
 		{
 		}
Index: Mono.Cecil/IAssemblyResolver.cs
===================================================================
--- Mono.Cecil/IAssemblyResolver.cs	(revision 0)
+++ Mono.Cecil/IAssemblyResolver.cs	(revision 0)
@@ -0,0 +1,41 @@
+//
+// IAssemblyResolver.cs
+//
+// Author:
+//   Eyal Alaluf (eyala@mainsoft.com)
+//
+// (C) 2006 Mainsoft Co.
+//
+// Permission is hereby granted, free of charge, to any person obtaining
+// a copy of this software and associated documentation files (the
+// "Software"), to deal in the Software without restriction, including
+// without limitation the rights to use, copy, modify, merge, publish,
+// distribute, sublicense, and/or sell copies of the Software, and to
+// permit persons to whom the Software is furnished to do so, subject to
+// the following conditions:
+//
+// The above copyright notice and this permission notice shall be
+// included in all copies or substantial portions of the Software.
+//
+// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
+// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
+// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
+// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+//
+
+using System;
+
+namespace Mono.Cecil
+{
+	/// <summary>
+	/// Summary description for Resolver.
+	/// </summary>
+	/// 
+	public interface IAssemblyResolver  
+	{
+		IAssemblyDefinition GetAssembly(string name);
+	}
+}
Index: Mono.Cecil.Signatures/SignatureReader.cs
===================================================================
--- Mono.Cecil.Signatures/SignatureReader.cs	(revision 61523)
+++ Mono.Cecil.Signatures/SignatureReader.cs	(working copy)
@@ -700,13 +700,35 @@
 					byte [] bytes = br.ReadBytes (length);
 					elem.Value = Encoding.UTF8.GetString (bytes, 0, bytes.Length);
 				}
-
 				return elem;
 			}
 
 			elem.String = elem.Type = elem.BoxedValueType = false;
+			if (!readSimpleValue(br, ref elem, elem.ElemType)) {
+				ITypeReference typeRef = GetEnumUnderlyingType(elem.ElemType);
+				if (typeRef == null || !readSimpleValue(br, ref elem, typeRef))
+					read = false;
+			}
 
-			switch (elemName) {
+			return elem;
+		}
+
+		private ITypeReference GetEnumUnderlyingType(ITypeReference enumType)
+		{
+			ITypeDefinition type = enumType as ITypeDefinition;
+			if (type == null && AssemblyFactory.Resolver != null) 
+			{
+				IAssemblyDefinition asm = AssemblyFactory.Resolver.GetAssembly(enumType.Scope.Name);
+				type = asm.MainModule.Types[enumType.FullName];
+			}
+			if (type != null && type.IsEnum)
+				return type.Fields.GetField("value__").FieldType;
+			return null;
+		}
+
+		bool readSimpleValue(BinaryReader br, ref CustomAttrib.Elem elem, ITypeReference type)
+		{
+			switch (type.FullName) {
 			case Constants.Boolean :
 				elem.Value = br.ReadByte () == 1;
 				break;
@@ -744,12 +766,10 @@
 				elem.Value = br.ReadUInt64 ();
 				break;
 			default : // enum
-				read = false;
-				return elem;
+				return false;
 			}
-
 			elem.Simple = true;
-			return elem;
+			return true;
 		}
 
 		// elem in named args, only have an ElementType
