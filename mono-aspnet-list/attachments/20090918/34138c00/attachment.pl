Index: System.Web.Script.Services/RestHandler.cs
===================================================================
--- System.Web.Script.Services/RestHandler.cs	(revision 142129)
+++ System.Web.Script.Services/RestHandler.cs	(working copy)
@@ -120,7 +120,7 @@
 						new ReadOnlySessionWrapperHandler (handler) : new SessionWrapperHandler (handler);
 			}
 			else
-				if (mi.WebMethod.EnableSession)
+				if (mi.EnableSession)
 					return new SessionWrapperHandler (handler);
 
 			return handler;
@@ -136,19 +136,13 @@
 			HttpRequest request = context.Request;
 			HttpResponse response = context.Response;
 			response.ContentType =
-				_logicalMethodInfo.ScriptMethod.ResponseFormat == ResponseFormat.Json ?
+				_logicalMethodInfo.ResponseFormat == ResponseFormat.Json ?
 				"application/json" : "text/xml";
 			response.Cache.SetCacheability (HttpCacheability.Private);
 			response.Cache.SetMaxAge (TimeSpan.Zero);
 
-			IDictionary<string, object> @params =
-				"GET".Equals (request.RequestType, StringComparison.OrdinalIgnoreCase)
-				? GetNameValueCollectionDictionary (request.QueryString) :
-				(IDictionary<string, object>) JavaScriptSerializer.DefaultSerializer.DeserializeObjectInternal
-				(new StreamReader (request.InputStream, request.ContentEncoding));
-			
 			try {
-				_logicalMethodInfo.Invoke (@params, response.Output);
+				_logicalMethodInfo.Invoke (request, response);
 			}
 			catch (TargetInvocationException e) {
 				response.AddHeader ("jsonerror", "true");
@@ -158,16 +152,6 @@
 				response.End ();
 			}
 		}
-
-		IDictionary <string, object> GetNameValueCollectionDictionary (NameValueCollection nvc)
-		{
-			var ret = new Dictionary <string, object> ();
-
-			for (int i = nvc.Count - 1; i >= 0; i--)
-				ret.Add (nvc.GetKey (i), JavaScriptSerializer.DefaultSerializer.DeserializeObjectInternal (nvc.Get (i)));
-
-			return ret;
-		}
 		
 		#endregion
 	}
Index: System.Web.Script.Services/ChangeLog
===================================================================
--- System.Web.Script.Services/ChangeLog	(revision 142129)
+++ System.Web.Script.Services/ChangeLog	(working copy)
@@ -1,3 +1,11 @@
+2009-09-17  Atsushi Enomoto  <atsushi@ximian.com>
+
+	* LogicalTypeInfo.cs, RestHandler.cs : add support for WCF proxy
+	  generator. Make LogicalTypeInfo and LogicalMethodInfo abstract
+	  and create sets of derivation for asmx and WCF. Large part of the
+	  code still lives in abstract class, being reduced dependency on
+	  ScriptServiceAttribute.
+
 2009-08-15  Marek Habersack  <mhabersack@novell.com>
 
 	* LogicalTypeInfo.cs: make sure JavaScriptSerializer instance used
Index: System.Web.Script.Services/LogicalTypeInfo.cs
===================================================================
--- System.Web.Script.Services/LogicalTypeInfo.cs	(revision 142129)
+++ System.Web.Script.Services/LogicalTypeInfo.cs	(working copy)
@@ -1,10 +1,12 @@
 //
-// ScriptHandlerFactory.cs
+// LogicalTypeInfo.cs
 //
 // Author:
 //   Konstantin Triger <kostat@mainsoft.com>
+//   Atsushi Enomoto <atsushi@ximian.com>
 //
 // (C) 2007 Mainsoft, Inc.  http://www.mainsoft.com
+// Copyright (C) 2009 Novell, Inc. http://novell.com
 //
 //
 // Permission is hereby granted, free of charge, to any person obtaining
@@ -29,6 +31,7 @@
 
 using System;
 using System.Collections.Generic;
+using System.Collections.Specialized;
 using System.Text;
 using System.Web.Services;
 using System.Reflection;
@@ -37,36 +40,38 @@
 using System.IO;
 using System.Xml.Serialization;
 using System.Xml;
+using System.ServiceModel;
+using System.ServiceModel.Description;
 
 namespace System.Web.Script.Services
 {
-	internal sealed class LogicalTypeInfo
+	internal sealed class JsonResult
 	{
-		#region LogicalMethodInfo
+		public readonly object d;
+		public JsonResult (object result) {
+			d = result;
+		}
+	}
 
-		public sealed class LogicalMethodInfo
+	internal abstract class LogicalTypeInfo
+	{
+		public static LogicalTypeInfo CreateTypeInfo (Type t, string filePath)
 		{
-			readonly LogicalTypeInfo _typeInfo;
+			if (t.GetCustomAttributes (typeof (ServiceContractAttribute), false).Length > 0)
+				return new WcfLogicalTypeInfo (t, filePath);
+			else
+				return new AsmxLogicalTypeInfo (t, filePath);
+		}
+
+		internal abstract class LogicalMethodInfo
+		{
 			readonly MethodInfo _methodInfo;
+			internal readonly ParameterInfo [] _params;
+			internal readonly Dictionary<string, int> _paramMap;
 
-			readonly WebMethodAttribute _wma;
-
-			readonly ScriptMethodAttribute _sma;
-
-			readonly ParameterInfo [] _params;
-			readonly Dictionary<string, int> _paramMap;
-			readonly XmlSerializer _xmlSer;
-
-			public LogicalMethodInfo (LogicalTypeInfo typeInfo, MethodInfo method) {
-				_typeInfo = typeInfo;
+			protected LogicalMethodInfo (LogicalTypeInfo typeInfo, MethodInfo method)
+			{
 				_methodInfo = method;
-
-				_wma = (WebMethodAttribute) Attribute.GetCustomAttribute (method, typeof (WebMethodAttribute));
-
-				_sma = (ScriptMethodAttribute) Attribute.GetCustomAttribute (method, typeof (ScriptMethodAttribute));
-				if (_sma == null)
-					_sma = ScriptMethodAttribute.Default;
-
 				_params = MethodInfo.GetParameters ();
 
 				if (HasParameters) {
@@ -75,55 +80,14 @@
 						_paramMap.Add(_params[i].Name, i);
 				}
 
-				if (ScriptMethod.ResponseFormat == ResponseFormat.Xml
-					&& MethodInfo.ReturnType != typeof (void)) {
-					Type retType = MethodInfo.ReturnType;
-					if (Type.GetTypeCode (retType) != TypeCode.String || ScriptMethod.XmlSerializeString)
-						_xmlSer = new XmlSerializer (retType);
-				}
 			}
 
-			public void Invoke (IDictionary<string, object> @params, TextWriter writer) {
-				object [] pp = null;
-				if (HasParameters) {
-					Type ptype;
-					int i;
-					object value;
-					pp = new object [_params.Length];
-
-					foreach (KeyValuePair<string, object> pair in @params) {
-						if (!_paramMap.TryGetValue (pair.Key, out i))
-							continue;
-
-						value = pair.Value;
-						ptype = _params [i].ParameterType;
-						if (ptype == typeof (System.Object))
-							pp [i] = value;
-						else
-							pp [i] = LogicalTypeInfo.JSSerializer.ConvertToType (ptype, value);
-					}
-				}
-
-				object target = MethodInfo.IsStatic ? null : Activator.CreateInstance (_typeInfo._type);
-				object result = MethodInfo.Invoke (target, pp);
-				if (_xmlSer != null) {
-					XmlTextWriter xwriter = new XmlTextWriter (writer);
-					xwriter.Formatting = Formatting.None;
-					_xmlSer.Serialize (xwriter, result);
-				}
-				else
-				{
-					result = new JsonResult (result);
-					LogicalTypeInfo.JSSerializer.Serialize (result, writer);
-				}
-			}
-
-			bool HasParameters { get { return _params != null && _params.Length > 0; } }
-			public string MethodName { get { return String.IsNullOrEmpty (WebMethod.MessageName) ? MethodInfo.Name : WebMethod.MessageName; } }
-
-			public ScriptMethodAttribute ScriptMethod { get { return _sma; } }
+			public abstract bool UseHttpGet { get; }
+			public abstract bool EnableSession { get; }
+			public abstract ResponseFormat ResponseFormat { get; }
+			public abstract string MethodName { get; }
 			public MethodInfo MethodInfo { get { return _methodInfo; } }
-			public WebMethodAttribute WebMethod { get { return _wma; } }
+			public bool HasParameters { get { return _params != null && _params.Length > 0; } }
 			public IEnumerable<Type> GetParameterTypes () {
 				if (HasParameters)
 					for (int i = 0; i < _params.Length; i++)
@@ -135,7 +99,7 @@
 			public void GenerateMethod (StringBuilder proxy, bool isPrototype, bool isPage) {
 				string service = isPage ? "PageMethods" : MethodInfo.DeclaringType.FullName;
 
-				string useHttpGet = ScriptMethod.UseHttpGet ? "true" : "false";
+				string useHttpGet = UseHttpGet ? "true" : "false";
 				string paramMap = GenerateParameters (true);
 				string paramList = GenerateParameters (false);
 
@@ -169,10 +133,10 @@
 
 				return builder.ToString ();
 			}
+
+			public abstract void Invoke (HttpRequest request, HttpResponse response);
 		}
 
-		#endregion
-
 #if !TARGET_J2EE
 		static Hashtable _type_to_logical_type = Hashtable.Synchronized (new Hashtable ());
 #else
@@ -192,37 +156,45 @@
 		}
 #endif
 
-		//readonly LogicalMethodInfo [] _logicalMethods;
-		readonly Hashtable _methodMap;
-		readonly Type _type;
+		static internal LogicalTypeInfo GetLogicalTypeInfo (Type t, string filePath) {
+			Hashtable type_to_manager = _type_to_logical_type;
+			LogicalTypeInfo tm = (LogicalTypeInfo) type_to_manager [t];
+
+			if (tm != null)
+				return tm;
+
+			tm = CreateTypeInfo (t, filePath);
+			type_to_manager [t] = tm;
+
+			return tm;
+		}
+
+		protected static string EnsureNamespaceRegistered (string ns, string name, StringBuilder proxy, List<string> registeredNamespaces) {
+			if (String.IsNullOrEmpty (ns))
+				return "var " + name;
+
+			if (!registeredNamespaces.Contains (ns)) {
+				registeredNamespaces.Add (ns);
+				proxy.AppendFormat (
+@"
+Type.registerNamespace('{0}');",
+								   ns);
+			}
+			return name;
+		}
+
+		// instance members
+
+		internal readonly Type _type;
 		readonly string _proxy;
-		static readonly JavaScriptSerializer JSSerializer = new JavaScriptSerializer (null, true);
+		internal readonly Hashtable _methodMap;
 
-		private LogicalTypeInfo (Type t, string filePath) {
+		protected LogicalTypeInfo (Type t, string filePath)
+		{
 			_type = t;
 			bool isPage = _type.IsSubclassOf (typeof (System.Web.UI.Page));
-			BindingFlags bindingAttr = isPage ? (BindingFlags.Static | BindingFlags.FlattenHierarchy | BindingFlags.Public) : (BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic);
-			MethodInfo [] all_type_methods = _type.GetMethods (bindingAttr);
-			List<LogicalMethodInfo> logicalMethods = new List<LogicalMethodInfo> (all_type_methods.Length);
-			foreach (MethodInfo mi in all_type_methods) {
-				if (mi.IsPublic && 
-					mi.GetCustomAttributes (typeof (WebMethodAttribute), false).Length > 0)
-					logicalMethods.Add (new LogicalMethodInfo (this, mi));
-				else {
-					foreach (Type ifaceType in _type.GetInterfaces ()) {
-						if (ifaceType.GetCustomAttributes (typeof (WebServiceBindingAttribute), false).Length > 0) {
-							MethodInfo found = FindInInterface (ifaceType, mi);
-							if (found != null) {
-								if (found.GetCustomAttributes (typeof (WebMethodAttribute), false).Length > 0)
-									logicalMethods.Add (new LogicalMethodInfo (this, found));
 
-								break;
-							}
-						}
-					}
-				}
-			}
-
+			var logicalMethods = GetLogicalMethods (isPage);
 			//_logicalMethods = (LogicalMethodInfo []) list.ToArray (typeof (LogicalMethodInfo));
 
 			_methodMap = new Hashtable (logicalMethods.Count);
@@ -273,75 +245,64 @@
 			for (int i = 0; i < logicalMethods.Count; i++)
 				logicalMethods [i].GenerateMethod (proxy, false, isPage);
 
-			bool gtc = false;
+			GenerateTypeRegistrationScript (proxy, registeredNamespaces);
 
-			foreach (GenerateScriptTypeAttribute gsta in GetGenerateScriptTypeAttributes ()) {
-				if (!gtc && !gsta.Type.IsEnum) {
-					proxy.Append (
-@"
-var gtc = Sys.Net.WebServiceProxy._generateTypedConstructor;");
-					gtc = true;
-				}
-				GenerateScript (proxy, gsta, registeredNamespaces);
-			}
-
 			proxy.AppendLine ();
 			_proxy = proxy.ToString ();
 		}
 
-		IEnumerable<MemberInfo> GetGenerateScriptTypes () {
+		protected IEnumerable<MemberInfo> GetGenerateScriptTypes () {
 			foreach (LogicalMethodInfo lmi in _methodMap.Values)
 				yield return lmi.MethodInfo;
 
 			yield return _type;
 		}
 
-		IEnumerable<GenerateScriptTypeAttribute> GetGenerateScriptTypeAttributes () {
-			Hashtable generatedTypes = new Hashtable ();
-
-			foreach (MemberInfo mi in GetGenerateScriptTypes ()) {
-				GenerateScriptTypeAttribute [] gstas = (GenerateScriptTypeAttribute []) mi.GetCustomAttributes (typeof (GenerateScriptTypeAttribute), true);
-				if (gstas == null || gstas.Length == 0)
-					continue;
-
-				for (int i = 0; i < gstas.Length; i++) {
-					if (!generatedTypes.Contains (gstas [i].Type)) {
-						if (ShouldGenerateScript (gstas [i].Type, true)) {
-							generatedTypes [gstas [i].Type] = gstas [i].Type;
-							yield return gstas [i];
-						}
-					}
-				}
+		protected static void GenerateTypeRegistrationScript (StringBuilder proxy, Type scriptType, string scriptTypeId, List<string> registeredNamespaces) {
+			string className = scriptType.FullName.Replace ('+', '_');
+			string ns = scriptType.Namespace;
+			string scriptTypeDeclaration = EnsureNamespaceRegistered (ns, className, proxy, registeredNamespaces);
+			proxy.AppendFormat (
+@"
+if (typeof({0}) === 'undefined') {{", className);
+			if (scriptType.IsEnum) {
+				proxy.AppendFormat (
+@"
+{0} = function() {{ throw Error.invalidOperation(); }}
+{0}.prototype = {1}
+{0}.registerEnum('{0}', {2});",
+				className,
+				// This method is also used for WCF, but for enum this should work ...
+				AsmxLogicalTypeInfo.JSSerializer.Serialize(GetEnumPrototypeDictionary (scriptType)),
+				Attribute.GetCustomAttribute (scriptType, typeof (FlagsAttribute)) != null ? "true" : "false");
+				
 			}
-
-			foreach (LogicalMethodInfo lmi in _methodMap.Values) {
-				foreach (Type t in lmi.GetParameterTypes ()) {
-					Type param = GetTypeToGenerate (t);
-					if (!generatedTypes.Contains (param)) {
-						if (ShouldGenerateScript (param, false)) {
-							generatedTypes [param] = param;
-							yield return new GenerateScriptTypeAttribute (param);
-						}
-					}
-				}
+			else {
+				string typeId = String.IsNullOrEmpty (scriptTypeId) ? scriptType.FullName : scriptTypeId;
+				proxy.AppendFormat (
+@"
+" + scriptTypeDeclaration + @"=gtc(""{1}"");
+{0}.registerClass('{0}');",
+				className, typeId);
 			}
+			proxy.Append ('}');
 		}
 
-		static Type GetTypeToGenerate (Type type) {
-			if (type.IsArray)
-				return type.GetElementType ();
-			if (type.IsGenericType) {
-				while (type.IsGenericType && type.GetGenericArguments ().Length == 1)
-					type = type.GetGenericArguments () [0];
-				return type;
-			}
-			return type;
+		static IDictionary <string, object> GetEnumPrototypeDictionary (Type type)
+		{
+			var ret = new Dictionary <string, object> ();
+			string [] names = Enum.GetNames (type);
+			Array values = Enum.GetValues (type);
+			for (int i = 0; i < names.Length; i++)
+				ret.Add (names [i], values.GetValue (i));
+
+			return ret;
 		}
 
 		static readonly Type typeOfIEnumerable = typeof (IEnumerable);
 		static readonly Type typeOfIDictionary = typeof (IDictionary);
 
-		static bool ShouldGenerateScript (Type type, bool throwIfNot) {
+		protected static bool ShouldGenerateScript (Type type, bool throwIfNot) {
 			if (type.IsEnum)
 				return true;
 
@@ -378,61 +339,193 @@
 			throw new InvalidOperationException (
 				"Using the GenerateScriptTypes attribute is not supported for types in the following categories: primitive types; DateTime; generic types taking more than one parameter; types implementing IEnumerable or IDictionary; interfaces; Abstract classes; classes without a public default constructor.");
 		}
+		
+		protected abstract void GenerateTypeRegistrationScript (StringBuilder proxy, List<string> registeredNamespaces);
 
-		static void GenerateScript (StringBuilder proxy, GenerateScriptTypeAttribute gsta, List<string> registeredNamespaces) {
-			string className = gsta.Type.FullName.Replace ('+', '_');
-			string ns = gsta.Type.Namespace;
-			string scriptTypeDeclaration = EnsureNamespaceRegistered (ns, className, proxy, registeredNamespaces);
-			proxy.AppendFormat (
-@"
-if (typeof({0}) === 'undefined') {{", className);
-			if (gsta.Type.IsEnum) {
-				proxy.AppendFormat (
-@"
-{0} = function() {{ throw Error.invalidOperation(); }}
-{0}.prototype = {1}
-{0}.registerEnum('{0}', {2});",
-				className,
-				JSSerializer.Serialize(GetEnumPrototypeDictionary (gsta.Type)),
-				Attribute.GetCustomAttribute (gsta.Type, typeof (FlagsAttribute)) != null ? "true" : "false");
-				
+		protected abstract List<LogicalMethodInfo> GetLogicalMethods (bool isPage);
+
+		public string Proxy { get { return _proxy; } }
+
+		public LogicalMethodInfo this [string method] {
+			get { return (LogicalMethodInfo) _methodMap [method]; }
+		}
+	}
+
+	internal sealed class AsmxLogicalTypeInfo : LogicalTypeInfo
+	{
+		#region LogicalMethodInfo
+
+		public sealed class AsmxLogicalMethodInfo : LogicalTypeInfo.LogicalMethodInfo
+		{
+			readonly LogicalTypeInfo _typeInfo;
+
+			readonly WebMethodAttribute _wma;
+
+			readonly ScriptMethodAttribute _sma;
+
+			readonly XmlSerializer _xmlSer;
+
+			public AsmxLogicalMethodInfo (LogicalTypeInfo typeInfo, MethodInfo method)
+				: base (typeInfo, method)
+			{
+				_typeInfo = typeInfo;
+
+				_wma = (WebMethodAttribute) Attribute.GetCustomAttribute (method, typeof (WebMethodAttribute));
+
+				_sma = (ScriptMethodAttribute) Attribute.GetCustomAttribute (method, typeof (ScriptMethodAttribute));
+				if (_sma == null)
+					_sma = ScriptMethodAttribute.Default;
+
+				if (ScriptMethod.ResponseFormat == ResponseFormat.Xml
+					&& MethodInfo.ReturnType != typeof (void)) {
+					Type retType = MethodInfo.ReturnType;
+					if (Type.GetTypeCode (retType) != TypeCode.String || ScriptMethod.XmlSerializeString)
+						_xmlSer = new XmlSerializer (retType);
+				}
 			}
-			else {
-				string typeId = String.IsNullOrEmpty (gsta.ScriptTypeId) ? gsta.Type.FullName : gsta.ScriptTypeId;
-				proxy.AppendFormat (
-@"
-" + scriptTypeDeclaration + @"=gtc(""{1}"");
-{0}.registerClass('{0}');",
-				className, typeId);
+
+			IDictionary<string,object> BuildInvokeParameters (HttpRequest request)
+			{
+				return "GET".Equals (request.RequestType, StringComparison.OrdinalIgnoreCase) ?
+					GetNameValueCollectionDictionary (request.QueryString) :
+					(IDictionary<string, object>) JavaScriptSerializer.DefaultSerializer.DeserializeObjectInternal (new StreamReader (request.InputStream, request.ContentEncoding));
 			}
-			proxy.Append ('}');
+
+			IDictionary <string, object> GetNameValueCollectionDictionary (NameValueCollection nvc)
+			{
+				var ret = new Dictionary <string, object> ();
+
+				for (int i = nvc.Count - 1; i >= 0; i--)
+					ret.Add (nvc.GetKey (i), JavaScriptSerializer.DefaultSerializer.DeserializeObjectInternal (nvc.Get (i)));
+
+				return ret;
+			}
+
+			public override void Invoke (HttpRequest request, HttpResponse response) {
+				var writer = response.Output;
+				IDictionary<string, object> @params = BuildInvokeParameters (request);
+
+				object [] pp = null;
+				if (HasParameters) {
+					Type ptype;
+					int i;
+					object value;
+					pp = new object [_params.Length];
+
+					foreach (KeyValuePair<string, object> pair in @params) {
+						if (!_paramMap.TryGetValue (pair.Key, out i))
+							continue;
+
+						value = pair.Value;
+						ptype = _params [i].ParameterType;
+						if (ptype == typeof (System.Object))
+							pp [i] = value;
+						else
+							pp [i] = AsmxLogicalTypeInfo.JSSerializer.ConvertToType (ptype, value);
+					}
+				}
+
+				object target = MethodInfo.IsStatic ? null : Activator.CreateInstance (_typeInfo._type);
+				object result = MethodInfo.Invoke (target, pp);
+				if (_xmlSer != null) {
+					XmlTextWriter xwriter = new XmlTextWriter (writer);
+					xwriter.Formatting = Formatting.None;
+					_xmlSer.Serialize (xwriter, result);
+				}
+				else
+				{
+					result = new JsonResult (result);
+					AsmxLogicalTypeInfo.JSSerializer.Serialize (result, writer);
+				}
+			}
+
+			public override string MethodName { get { return String.IsNullOrEmpty (WebMethod.MessageName) ? MethodInfo.Name : WebMethod.MessageName; } }
+
+			public ScriptMethodAttribute ScriptMethod { get { return _sma; } }
+			public WebMethodAttribute WebMethod { get { return _wma; } }
+			public override bool UseHttpGet { get { return ScriptMethod.UseHttpGet; } }
+			public override bool EnableSession { get { return WebMethod.EnableSession; } }
+			public override ResponseFormat ResponseFormat { get { return ScriptMethod.ResponseFormat; } }
 		}
 
-		static string EnsureNamespaceRegistered (string ns, string name, StringBuilder proxy, List<string> registeredNamespaces) {
-			if (String.IsNullOrEmpty (ns))
-				return "var " + name;
+		#endregion
 
-			if (!registeredNamespaces.Contains (ns)) {
-				registeredNamespaces.Add (ns);
-				proxy.AppendFormat (
-@"
-Type.registerNamespace('{0}');",
-								   ns);
+		//readonly LogicalMethodInfo [] _logicalMethods;
+		internal static readonly JavaScriptSerializer JSSerializer = new JavaScriptSerializer (null, true);
+
+		protected override List<LogicalMethodInfo> GetLogicalMethods (bool isPage)
+		{
+			BindingFlags bindingAttr = isPage ? (BindingFlags.Static | BindingFlags.FlattenHierarchy | BindingFlags.Public) : (BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic);
+			MethodInfo [] all_type_methods = _type.GetMethods (bindingAttr);
+			List<LogicalMethodInfo> logicalMethods = new List<LogicalMethodInfo> (all_type_methods.Length);
+			foreach (MethodInfo mi in all_type_methods) {
+				if (mi.IsPublic && 
+					mi.GetCustomAttributes (typeof (WebMethodAttribute), false).Length > 0)
+					logicalMethods.Add (new AsmxLogicalMethodInfo (this, mi));
+				else {
+					foreach (Type ifaceType in _type.GetInterfaces ()) {
+						if (ifaceType.GetCustomAttributes (typeof (WebServiceBindingAttribute), false).Length > 0) {
+							MethodInfo found = FindInInterface (ifaceType, mi);
+							if (found != null) {
+								if (found.GetCustomAttributes (typeof (WebMethodAttribute), false).Length > 0)
+									logicalMethods.Add (new AsmxLogicalMethodInfo (this, found));
+
+								break;
+							}
+						}
+					}
+				}
 			}
-			return name;
+			return logicalMethods;
 		}
 
-		static IDictionary <string, object> GetEnumPrototypeDictionary (Type type)
+		internal AsmxLogicalTypeInfo (Type t, string filePath) 
+			: base (t, filePath)
 		{
-			var ret = new Dictionary <string, object> ();
-			string [] names = Enum.GetNames (type);
-			Array values = Enum.GetValues (type);
-			for (int i = 0; i < names.Length; i++)
-				ret.Add (names [i], values.GetValue (i));
+		}
 
-			return ret;
+		IEnumerable<GenerateScriptTypeAttribute> GetGenerateScriptTypeAttributes () {
+			Hashtable generatedTypes = new Hashtable ();
+
+			foreach (MemberInfo mi in GetGenerateScriptTypes ()) {
+				GenerateScriptTypeAttribute [] gstas = (GenerateScriptTypeAttribute []) mi.GetCustomAttributes (typeof (GenerateScriptTypeAttribute), true);
+				if (gstas == null || gstas.Length == 0)
+					continue;
+
+				for (int i = 0; i < gstas.Length; i++) {
+					if (!generatedTypes.Contains (gstas [i].Type)) {
+						if (ShouldGenerateScript (gstas [i].Type, true)) {
+							generatedTypes [gstas [i].Type] = gstas [i].Type;
+							yield return gstas [i];
+						}
+					}
+				}
+			}
+
+			foreach (LogicalMethodInfo lmi in _methodMap.Values) {
+				foreach (Type t in lmi.GetParameterTypes ()) {
+					Type param = GetTypeToGenerate (t);
+					if (!generatedTypes.Contains (param)) {
+						if (ShouldGenerateScript (param, false)) {
+							generatedTypes [param] = param;
+							yield return new GenerateScriptTypeAttribute (param);
+						}
+					}
+				}
+			}
 		}
-		
+
+		static Type GetTypeToGenerate (Type type) {
+			if (type.IsArray)
+				return type.GetElementType ();
+			if (type.IsGenericType) {
+				while (type.IsGenericType && type.GetGenericArguments ().Length == 1)
+					type = type.GetGenericArguments () [0];
+				return type;
+			}
+			return type;
+		}
+
 		static MethodInfo FindInInterface (Type ifaceType, MethodInfo method) {
 			int nameStartIndex = 0;
 			if (method.IsPrivate) {
@@ -470,31 +563,110 @@
 			return null;
 		}
 
-		public string Proxy { get { return _proxy; } }
+		protected override void GenerateTypeRegistrationScript (StringBuilder proxy, List<string> registeredNamespaces)
+		{
+			bool gtc = false;
 
-		public LogicalMethodInfo this [string method] {
-			get { return (LogicalMethodInfo) _methodMap [method]; }
+			foreach (GenerateScriptTypeAttribute gsta in GetGenerateScriptTypeAttributes ()) {
+				if (!gtc && !gsta.Type.IsEnum) {
+					proxy.Append (
+@"
+var gtc = Sys.Net.WebServiceProxy._generateTypedConstructor;");
+					gtc = true;
+				}
+				GenerateTypeRegistrationScript (proxy, gsta.Type, gsta.ScriptTypeId, registeredNamespaces);
+			}
 		}
+	}
 
-		static internal LogicalTypeInfo GetLogicalTypeInfo (Type t, string filePath) {
-			Hashtable type_to_manager = _type_to_logical_type;
-			LogicalTypeInfo tm = (LogicalTypeInfo) type_to_manager [t];
+	internal class WcfLogicalTypeInfo : LogicalTypeInfo
+	{
+		ContractDescription cd;
 
-			if (tm != null)
-				return tm;
+		public WcfLogicalTypeInfo (Type type, string filePath)
+			: base (type, filePath)
+		{
+		}
 
-			tm = new LogicalTypeInfo (t, filePath);
-			type_to_manager [t] = tm;
+		ContractDescription Contract {
+			get {
+				if (cd == null)
+					cd = ContractDescription.GetContract (_type);
+				return cd;
+			}
+		}
 
-			return tm;
+		IEnumerable<KeyValuePair<Type,string>> GetDataContractTypeInfos ()
+		{
+			foreach (var od in Contract.Operations) {
+				foreach (var md in od.Messages) {
+					foreach (var pd in md.Body.Parts) {
+						if (ShouldGenerateScript (pd.Type, false))
+							yield return new KeyValuePair<Type,string> (pd.Type, null);
+					}
+					if (md.Body.ReturnValue != null && ShouldGenerateScript (md.Body.ReturnValue.Type, false))
+						yield return new KeyValuePair<Type,string> (md.Body.ReturnValue.Type, null);
+				}
+			}
+			yield break;
 		}
-		
-		sealed class JsonResult
+
+		protected override void GenerateTypeRegistrationScript (StringBuilder proxy, List<string> registeredNamespaces)
 		{
-			public readonly object d;
-			public JsonResult (object result) {
-				d = result;
+			bool gtc = false;
+
+			foreach (KeyValuePair<Type,string> pair in GetDataContractTypeInfos ()) {
+				if (!gtc && !pair.Key.IsEnum) {
+					proxy.Append (
+@"
+var gtc = Sys.Net.WebServiceProxy._generateTypedConstructor;");
+					gtc = true;
+				}
+				GenerateTypeRegistrationScript (proxy, pair.Key, pair.Value, registeredNamespaces);
 			}
 		}
+
+		protected override List<LogicalMethodInfo> GetLogicalMethods (bool isPage)
+		{
+			if (isPage)
+				throw new NotSupportedException ();
+
+			var l = new List<LogicalMethodInfo> ();
+			foreach (var od in Contract.Operations)
+				l.Add (new WcfLogicalMethodInfo (this, od));
+			return l;
+		}
+
+		internal class WcfLogicalMethodInfo : LogicalMethodInfo
+		{
+			OperationDescription od;
+
+			public WcfLogicalMethodInfo (LogicalTypeInfo typeInfo, OperationDescription od)
+				: base (typeInfo, od.SyncMethod)
+			{
+				this.od = od;
+			}
+
+			public override bool UseHttpGet { get { return true; } } // always
+
+			// FIXME: could this be enabled?
+			public override bool EnableSession {
+				get { return false; }
+			}
+
+			public override ResponseFormat ResponseFormat {
+				get { return ResponseFormat.Json; } // always
+			}
+
+			public override string MethodName {
+				get { return od.Name; }
+			}
+
+			public override void Invoke (HttpRequest request, HttpResponse response)
+			{
+				// invocation is done in WCF part.
+				throw new NotSupportedException ();
+			}
+		}
 	}
 }
Index: ChangeLog
===================================================================
--- ChangeLog	(revision 142129)
+++ ChangeLog	(working copy)
@@ -1,3 +1,7 @@
+2009-09-17  Atsushi Enomoto  <atsushi@ximian.com>
+
+	* Makefile : add -r:System.ServiceModel.
+
 2009-07-06  Raja R Harinath  <harinath@hurrynot.org>
 
 	* Makefile (TEST_MCS_FLAGS): Reference SystemWebTestShim.
Index: Makefile
===================================================================
--- Makefile	(revision 142129)
+++ Makefile	(working copy)
@@ -48,6 +48,7 @@
 	-r:System.Web.Services.dll	\
 	-r:System.Configuration.dll	\
 	-r:System.EnterpriseServices.dll \
+	-r:System.ServiceModel.dll	\
 	$(OTHER_LIB_MCS_FLAGS) 		\
 	$(RESOURCE_FILES:%=/resource:%)
 
