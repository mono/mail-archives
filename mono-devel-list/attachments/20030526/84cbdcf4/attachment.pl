Index: System.Xml.Xsl/XslTransform.cs
===================================================================
RCS file: /mono/mcs/class/System.XML/System.Xml.Xsl/XslTransform.cs,v
retrieving revision 1.17
diff -u -p -r1.17 XslTransform.cs
--- System.Xml.Xsl/XslTransform.cs	11 May 2003 16:36:02 -0000	1.17
+++ System.Xml.Xsl/XslTransform.cs	27 May 2003 02:33:17 -0000
@@ -14,6 +14,8 @@ using System.IO;
 using System.Text;
 using System.Runtime.InteropServices;
 
+using BF = System.Reflection.BindingFlags;
+
 namespace System.Xml.Xsl
 {
 	public sealed class XslTransform
@@ -176,7 +178,8 @@ namespace System.Xml.Xsl
 				if (xmlDocument == IntPtr.Zero)
 					throw new XmlException ("Error parsing input file");
 
-				resultDocument = ApplyStylesheet (xmlDocument, null);
+				resultDocument = ApplyStylesheet (xmlDocument, null, null);
+
 				/*
 				* If I do this, the <?xml version=... is always present *
 				if (-1 == xsltSaveResultToFilename (outputfile, resultDocument, stylesheet, 0))
@@ -196,12 +199,65 @@ namespace System.Xml.Xsl
 			}
 		}
 
-		IntPtr ApplyStylesheet (IntPtr doc, string[] argArr)
+		IntPtr ApplyStylesheet (IntPtr doc, string[] argArr, System.Collections.Hashtable extobjects)
 		{
 			if (stylesheet == IntPtr.Zero)
 				throw new XmlException ("No style sheet!");
 
-			IntPtr result = xsltApplyStylesheet (stylesheet, doc, argArr);
+			IntPtr result;
+
+			if (extobjects == null || extobjects.Count == 0) {
+				// If there are no extension objects, use the simple (old) method.
+				result = xsltApplyStylesheet (stylesheet, doc, argArr);
+			} else {
+				// If there are extension objects, create a context and register the functions.
+
+				IntPtr context = xsltNewTransformContext(stylesheet, doc);
+
+				if (context == IntPtr.Zero) throw new XmlException("Error creating transformation context.");
+
+				try {
+					foreach (string ns in extobjects.Keys) {
+						object ext = extobjects[ns];
+
+						System.Type type;
+						System.Collections.IEnumerable methods;
+
+						// As an added bonus, if the extension object is a UseStaticMethods object
+						// (defined below), then add the static methods of the specified type.
+						if (ext is UseStaticMethods) {
+							type = ((UseStaticMethods)ext).Type;
+							methods = type.GetMethods(System.Reflection.BindingFlags.Static | System.Reflection.BindingFlags.Public);
+							ext = null;
+						} else {
+							type = ext.GetType();
+							methods = type.GetMethods();
+						}
+
+						System.Collections.Hashtable alreadyadded = new	System.Collections.Hashtable();
+						foreach (System.Reflection.MethodInfo mi in methods) {
+							if (alreadyadded.ContainsKey(mi.Name)) continue; // don't add twice
+							alreadyadded[mi.Name] = 1;
+
+							// Simple extension function delegate
+							ExtensionFunction func = new ExtensionFunction(new ReflectedExtensionFunction(type, ext, mi.Name).Function);
+
+							// Delegate for libxslt library call
+							libxsltXPathFunction libfunc = new libxsltXPathFunction(new ExtensionFunctionWrapper(func).Function);
+	
+							int ret = xsltRegisterExtFunction(context, mi.Name, ns, libfunc);
+							if (ret != 0) throw new XmlException("Could not register extension function " + mi.DeclaringType.FullName + "." + mi.Name + " in " + ns);
+						}
+					
+					}
+	
+					result = xsltApplyStylesheetUser(stylesheet, doc, argArr, null, IntPtr.Zero, context);
+				} finally {
+					xsltFreeTransformContext(context);
+				}
+			}
+
+
 			if (result == IntPtr.Zero)
 				throw new XmlException ("Error applying style sheet");
 
@@ -236,9 +292,9 @@ namespace System.Xml.Xsl
 			return result.ReadToEnd ();
 		}
 
-		string ApplyStylesheetAndGetString (IntPtr doc, string[] argArr)
+		string ApplyStylesheetAndGetString (IntPtr doc, string[] argArr, System.Collections.Hashtable extobjects)
 		{
-			IntPtr xmlOutput = ApplyStylesheet (doc, argArr);
+			IntPtr xmlOutput = ApplyStylesheet (doc, argArr, extobjects);
 			string strOutput = GetStringFromDocument (xmlOutput);
 			xmlFreeDoc (xmlOutput);
 
@@ -263,7 +319,7 @@ namespace System.Xml.Xsl
 		{
 			IntPtr xmlInput = GetDocumentFromNavigator (input);
 			string[] argArr = null;
-                        if (args != null) {
+			if (args != null) {
 				argArr = new string[args.parameters.Count * 2 + 1];
 				int index = 0;
 				foreach (object key in args.parameters.Keys) {
@@ -278,7 +334,7 @@ namespace System.Xml.Xsl
 				}
 				argArr[index] = null;
 			}
-			string xslOutputString = ApplyStylesheetAndGetString (xmlInput, argArr);
+			string xslOutputString = ApplyStylesheetAndGetString (xmlInput, argArr, args.extensionObjects);
 			xmlFreeDoc (xmlInput);
 			Cleanup ();
 
@@ -350,7 +406,7 @@ namespace System.Xml.Xsl
 				}
 				argArr[index] = null;
 			}
-			string transform = ApplyStylesheetAndGetString (inputDoc, argArr);
+			string transform = ApplyStylesheetAndGetString (inputDoc, argArr, args.extensionObjects);
 			xmlFreeDoc (inputDoc);
 			Cleanup ();
 			output.Write (transform);
@@ -487,6 +543,106 @@ namespace System.Xml.Xsl
 			}
 		}
 
+		// Extension Objects
+
+		internal delegate object ExtensionFunction(object[] args);
+
+		// Wraps an ExtensionFunction into a function that is callable from the libxslt library.
+		private unsafe class ExtensionFunctionWrapper {
+			ExtensionFunction func;
+
+			public ExtensionFunctionWrapper(ExtensionFunction func) { this.func = func; }
+			
+			public unsafe void Function(IntPtr xpath_ctxt, int nargs) {
+
+				// Convert XPath arguments into "managed" arguments
+				System.Collections.ArrayList args = new System.Collections.ArrayList();
+				for (int i = 0; i < nargs; i++) {
+					xpathobject* aptr = valuePop(xpath_ctxt);
+					if (aptr->type == 2) // Booleans
+						args.Add( xmlXPathCastToBoolean(aptr) == 0 ? false : true );
+					else if (aptr->type == 3) // Doubles
+						args.Add( xmlXPathCastToNumber(aptr));
+					else if (aptr->type == 4) // Strings
+						args.Add( xmlXPathCastToString(aptr));
+					else if (aptr->type == 1) { // Node Sets ==> ArrayList of strings
+						System.Collections.ArrayList a = new System.Collections.ArrayList();
+						for (int ni = 0; ni < aptr->nodesetptr->count; ni++) {
+							xpathobject *n = xmlXPathNewNodeSet(aptr->nodesetptr->nodes[ni]);
+							valuePush(xpath_ctxt, n);
+							xmlXPathStringFunction(xpath_ctxt, 1);
+							a.Add(xmlXPathCastToString(valuePop(xpath_ctxt)));
+							xmlXPathFreeObject(n);
+						}
+						args.Add(a);
+					} else { // Anything else => string
+						valuePush(xpath_ctxt, aptr);
+						xmlXPathStringFunction(xpath_ctxt, 1);
+						args.Add(xmlXPathCastToString(valuePop(xpath_ctxt)));
+					}
+
+					xmlXPathFreeObject(aptr);
+				}
+
+				// Call function
+				args.Reverse();
+				object ret = func(args.ToArray());
+
+				// Convert the result back to an XPath object
+				if (ret == null) // null => ""
+					valuePush(xpath_ctxt, xmlXPathNewCString(""));
+				else if (ret is Boolean) // Booleans
+					valuePush(xpath_ctxt, xmlXPathNewBoolean((bool)ret ? 1 : 0));
+				else if (ret is int || ret is long || ret is double || ret is float || ret is decimal)
+					// Numbers
+					valuePush(xpath_ctxt, xmlXPathNewFloat((double)ret));
+				else // Strings
+					valuePush(xpath_ctxt, xmlXPathNewCString(ret.ToString()));
+
+			}
+		}
+
+		// Provides a delegate for calling a late-bound method of a type with a given name.
+		// Determines method based on types of arguments.
+		private class ReflectedExtensionFunction {
+			System.Type type;
+			object src;
+			string methodname;
+		
+			public ReflectedExtensionFunction(System.Type type, object src, string methodname) { this.type = type; this.src = src; this.methodname = methodname; }
+		
+			public object Function(object[] args) {
+				// Construct arg type array, stringified version in case of problem
+				System.Type[] argtypes = new System.Type[args.Length];
+				string argtypelist = null;
+				for (int i = 0; i < args.Length; i++) {
+					argtypes[i] = (args[i] == null ? typeof(object) : args[i].GetType() );
+
+					if (argtypelist != null) argtypelist += ", ";
+					argtypelist += argtypes[i].FullName;
+				}
+				if (argtypelist == null) argtypelist = "";
+
+				// Find the method
+				System.Reflection.MethodInfo mi = type.GetMethod(methodname, (src == null ? BF.Static : BF.Instance | BF.Static) | BF.Public, null, argtypes, null);
+
+				// No method?
+				if (mi == null) throw new XmlException("No applicable function for " + methodname + " takes (" + argtypelist + ")");
+
+				// Invoke
+				return mi.Invoke(src, args);
+			}
+		}
+
+		// Special Mono-specific class that allows static methods of a type to
+		// be bound without needing an instance of that type.  Useful for
+		// registering System.Math functions, for example.
+		// Usage:   args.AddExtensionObject( new XslTransform.UseStaticMethods(typeof(thetype)) );
+		public sealed class UseStaticMethods {
+			public readonly System.Type Type;
+			public UseStaticMethods(System.Type Type) { this.Type = Type; }
+		}
+
 		#endregion
 
 		#region Calls to external libraries
@@ -533,6 +689,65 @@ namespace System.Xml.Xsl
 
 		[DllImport ("xml2")]
 		static extern void xmlFree (IntPtr data);
+
+		// Functions and structures for extension objects
+
+		[DllImport ("xslt")]
+		static extern IntPtr xsltNewTransformContext (IntPtr style, IntPtr doc);
+
+		[DllImport ("xslt")]
+		static extern void xsltFreeTransformContext (IntPtr context);
+
+		[DllImport ("xslt")]
+		static extern IntPtr xsltApplyStylesheetUser (IntPtr stylePtr, IntPtr DocPtr, string[] argPtr, string output, IntPtr profile, IntPtr context);
+
+		[DllImport ("xslt")]
+		static extern int xsltRegisterExtFunction (IntPtr context, string name, string uri, libxsltXPathFunction function);
+
+		[DllImport ("xml2")]
+		unsafe static extern xpathobject* valuePop (IntPtr context);
+
+		[DllImport ("xml2")]
+		unsafe static extern void valuePush (IntPtr context, xpathobject* data);
+
+		[DllImport("xml2")]
+		unsafe static extern void xmlXPathFreeObject(xpathobject* obj);
+		
+		[DllImport("xml2")]
+		unsafe static extern xpathobject* xmlXPathNewCString(string str);
+
+		[DllImport("xml2")]
+		unsafe static extern xpathobject* xmlXPathNewFloat(double val);
+
+		[DllImport("xml2")]
+		unsafe static extern xpathobject* xmlXPathNewBoolean(int val);
+
+		[DllImport("xml2")]
+		unsafe static extern xpathobject* xmlXPathNewNodeSet(IntPtr nodeptr);
+
+		[DllImport("xml2")]
+		unsafe static extern int xmlXPathCastToBoolean(xpathobject* val);
+
+		[DllImport("xml2")]
+		unsafe static extern double xmlXPathCastToNumber(xpathobject* val);
+
+		[DllImport("xml2")]
+		unsafe static extern string xmlXPathCastToString(xpathobject* val);
+
+		[DllImport("xml2")]
+		static extern void xmlXPathStringFunction(IntPtr context, int nargs);
+
+		private delegate void libxsltXPathFunction(IntPtr xpath_ctxt, int nargs);
+
+		private struct xpathobject {
+			public int type;
+			public xmlnodelist* nodesetptr;
+		}
+		private struct xmlnodelist {
+			public int count;
+			public int allocated;
+			public IntPtr* nodes;
+		}
 
 		#endregion
 
