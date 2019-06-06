//
// System.Web.Compilation.TemplateControlCompiler
//
// Authors:
//	Gonzalo Paniagua Javier (gonzalo@ximian.com)
//
// (C) 2003 Ximian, Inc (http://www.ximian.com)
//

//
// Permission is hereby granted, free of charge, to any person obtaining
// a copy of this software and associated documentation files (the
// "Software"), to deal in the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to
// permit persons to whom the Software is furnished to do so, subject to
// the following conditions:
// 
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//
using System;
using System.CodeDom;
using System.Collections;
using System.ComponentModel;
using System.Drawing;
using System.Globalization;
using System.Reflection;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Util;
using System.ComponentModel.Design.Serialization;
#if NET_2_0
using System.Collections.Specialized;
using System.Text.RegularExpressions;
#endif

namespace System.Web.Compilation
{
	class TemplateControlCompiler : BaseCompiler
	{
		static BindingFlags noCaseFlags = BindingFlags.Public | BindingFlags.NonPublic |
						  BindingFlags.Instance | BindingFlags.IgnoreCase;

		TemplateControlParser parser;
		int dataBoundAtts;
		ILocation currentLocation;

		static TypeConverter colorConverter;

		internal static CodeVariableReferenceExpression ctrlVar = new CodeVariableReferenceExpression ("__ctrl");
		
#if NET_2_0
		static Regex bindRegex = new Regex (@"Bind\s*\(""(.*?)""\)\s*%>", RegexOptions.Compiled);
#endif

		public TemplateControlCompiler (TemplateControlParser parser)
			: base (parser)
		{
			this.parser = parser;
		}

		protected void EnsureID (ControlBuilder builder)
		{
			if (builder.ID == null || builder.ID.Trim () == "")
				builder.ID = builder.GetNextID (null);
		}

		void CreateField (ControlBuilder builder, bool check)
		{
#if NET_2_0
			if (partialNameOverride [builder.ID] != null)
				return;
#endif
			currentLocation = builder.location;
			if (check && CheckBaseFieldOrProperty (builder.ID, builder.ControlType))
				return; // The field or property already exists in a base class and is accesible.

			CodeMemberField field;
			field = new CodeMemberField (builder.ControlType.FullName, builder.ID);
			field.Attributes = MemberAttributes.Family;
			mainClass.Members.Add (field);
		}

		bool CheckBaseFieldOrProperty (string id, Type type)
		{
			FieldInfo fld = parser.BaseType.GetField (id, noCaseFlags);

			Type other = null;
			if (fld == null || fld.IsPrivate) {
				PropertyInfo prop = parser.BaseType.GetProperty (id, noCaseFlags);
				if (prop != null) {
					MethodInfo setm = prop.GetSetMethod (true);
					if (setm != null)
						other = prop.PropertyType;
				}
			} else {
				other = fld.FieldType;
			}
			
			if (other == null)
				return false;

			if (!other.IsAssignableFrom (type)) {
				string msg = String.Format ("The base class includes the field '{0}', but its " +
							    "type '{1}' is not compatible with {2}",
							    id, other, type);
				throw new ParseException (currentLocation, msg);
			}

			return true;
		}

		void AddParsedSubObjectStmt (ControlBuilder builder, CodeExpression expr) 
		{
			if (!builder.haveParserVariable) {
				CodeVariableDeclarationStatement p = new CodeVariableDeclarationStatement();
				p.Name = "__parser";
				p.Type = new CodeTypeReference (typeof (IParserAccessor));
				p.InitExpression = new CodeCastExpression (typeof (IParserAccessor), ctrlVar);
				builder.methodStatements.Add (p);
				builder.haveParserVariable = true;
			}

			CodeVariableReferenceExpression var = new CodeVariableReferenceExpression ("__parser");
			CodeMethodInvokeExpression invoke = new CodeMethodInvokeExpression (var, "AddParsedSubObject");
			invoke.Parameters.Add (expr);
			builder.methodStatements.Add (invoke);
		}

		void InitMethod (ControlBuilder builder, bool isTemplate, bool childrenAsProperties)
		{
			string tailname = ((builder is RootBuilder) ? "Tree" : ("_" + builder.ID));
			CodeMemberMethod method = new CodeMemberMethod ();
			builder.method = method;
			builder.methodStatements = method.Statements;

			method.Name = "__BuildControl" + tailname;
			method.Attributes = MemberAttributes.Private | MemberAttributes.Final;
			Type type = builder.ControlType;

			/* in the case this is the __BuildControlTree
			 * method, allow subclasses to insert control
			 * specific code. */
			if (builder is RootBuilder)
				AddStatementsToInitMethod (method);

			if (builder.HasAspCode) {
				CodeMemberMethod renderMethod = new CodeMemberMethod ();
				builder.renderMethod = renderMethod;
				renderMethod.Name = "__Render" + tailname;
				renderMethod.Attributes = MemberAttributes.Private | MemberAttributes.Final;
				CodeParameterDeclarationExpression arg1 = new CodeParameterDeclarationExpression ();
				arg1.Type = new CodeTypeReference (typeof (HtmlTextWriter));
				arg1.Name = "__output";
				CodeParameterDeclarationExpression arg2 = new CodeParameterDeclarationExpression ();
				arg2.Type = new CodeTypeReference (typeof (Control));
				arg2.Name = "parameterContainer";
				renderMethod.Parameters.Add (arg1);
				renderMethod.Parameters.Add (arg2);
				mainClass.Members.Add (renderMethod);
			}
			
			if (childrenAsProperties || builder.ControlType == null) {
				string typeString;
				if (builder is RootBuilder) {
#if NET_2_0
					if (parser.IsPartial)
						typeString = parser.PartialClassName;
					else
#endif
						typeString = parser.ClassName;
				}
				else {
					if (builder.ControlType != null && builder.isProperty &&
					    !typeof (ITemplate).IsAssignableFrom (builder.ControlType))
						typeString = builder.ControlType.FullName;
					else 
						typeString = "System.Web.UI.Control";
				}

				method.Parameters.Add (new CodeParameterDeclarationExpression (typeString, "__ctrl"));
			} else {
				
				if (typeof (Control).IsAssignableFrom (type))
					method.ReturnType = new CodeTypeReference (typeof (Control));

				// _ctrl = new $controlType ($parameters);
				//
				CodeObjectCreateExpression newExpr = new CodeObjectCreateExpression (type);

				object [] atts = type.GetCustomAttributes (typeof (ConstructorNeedsTagAttribute), true);
				if (atts != null && atts.Length > 0) {
					ConstructorNeedsTagAttribute att = (ConstructorNeedsTagAttribute) atts [0];
					if (att.NeedsTag)
						newExpr.Parameters.Add (new CodePrimitiveExpression (builder.TagName));
				} else if (builder is DataBindingBuilder) {
					newExpr.Parameters.Add (new CodePrimitiveExpression (0));
					newExpr.Parameters.Add (new CodePrimitiveExpression (1));
				}

				method.Statements.Add (new CodeVariableDeclarationStatement (builder.ControlType, "__ctrl"));
				CodeAssignStatement assign = new CodeAssignStatement ();
				assign.Left = ctrlVar;
				assign.Right = newExpr;
				method.Statements.Add (assign);
				
				// this.$builderID = _ctrl;
				//
				CodeFieldReferenceExpression builderID = new CodeFieldReferenceExpression ();
				builderID.TargetObject = thisRef;
				builderID.FieldName = builder.ID;
				assign = new CodeAssignStatement ();
				assign.Left = builderID;
				assign.Right = ctrlVar;
				method.Statements.Add (assign);
				if (typeof (UserControl).IsAssignableFrom (type)) {
					CodeMethodReferenceExpression mref = new CodeMethodReferenceExpression ();
					mref.TargetObject = builderID;
					mref.MethodName = "InitializeAsUserControl";
					CodeMethodInvokeExpression initAsControl = new CodeMethodInvokeExpression (mref);
					initAsControl.Parameters.Add (new CodePropertyReferenceExpression (thisRef, "Page"));
					method.Statements.Add (initAsControl);
				}

#if NET_2_0
				// _ctrl.SkinID = $value
				// _ctrl.ApplyStyleSheetSkin (this);
				//
				// the SkinID assignment needs to come
				// before the call to
				// ApplyStyleSheetSkin, for obvious
				// reasons.  We skip SkinID in
				// CreateAssignStatementsFromAttributes
				// below.
				// 
				if (builder.attribs != null) {
					string skinid = builder.attribs ["skinid"] as string;
					if (skinid != null)
						CreateAssignStatementFromAttribute (builder, "skinid");
				}
				if (typeof (WebControl).IsAssignableFrom (type)) {
					CodeMethodInvokeExpression applyStyleSheetSkin = new CodeMethodInvokeExpression (ctrlVar, "ApplyStyleSheetSkin");
					if (typeof (Page).IsAssignableFrom (parser.BaseType))
						applyStyleSheetSkin.Parameters.Add (thisRef);
					else
						applyStyleSheetSkin.Parameters.Add (new CodePropertyReferenceExpression (thisRef, "Page"));
					method.Statements.Add (applyStyleSheetSkin);
				}
#endif

#if NET_2_0
				if (typeof (ContentPlaceHolder).IsAssignableFrom (type)) {
					CodePropertyReferenceExpression prop = new CodePropertyReferenceExpression (thisRef, "ContentPlaceHolders");
					CodeMethodInvokeExpression addPlaceholder = new CodeMethodInvokeExpression (prop, "Add");
					addPlaceholder.Parameters.Add (ctrlVar);
					method.Statements.Add (addPlaceholder);


					CodeConditionStatement condStatement;

					// Add the __Template_* field
					CodeMemberField fld = new CodeMemberField (typeof (ITemplate), "__Template_" + builder.ID);
					fld.Attributes = MemberAttributes.Private;
					mainClass.Members.Add (fld);

					CodeFieldReferenceExpression templateID = new CodeFieldReferenceExpression ();
					templateID.TargetObject = thisRef;
					templateID.FieldName = "__Template_" + builder.ID;

					// if ((this.ContentTemplates != null)) {
					// 	this.__Template_$builder.ID = ((System.Web.UI.ITemplate)(this.ContentTemplates["$builder.ID"]));
					// }
					//
					CodeFieldReferenceExpression contentTemplates = new CodeFieldReferenceExpression ();
					contentTemplates.TargetObject = thisRef;
					contentTemplates.FieldName = "ContentTemplates";

					CodeIndexerExpression indexer = new CodeIndexerExpression ();
					indexer.TargetObject = new CodePropertyReferenceExpression (thisRef, "ContentTemplates");
					indexer.Indices.Add (new CodePrimitiveExpression (builder.ID));

					assign = new CodeAssignStatement ();
					assign.Left = templateID;
					assign.Right = new CodeCastExpression (new CodeTypeReference (typeof (ITemplate)), indexer);

					condStatement = new CodeConditionStatement (new CodeBinaryOperatorExpression (contentTemplates,
														      CodeBinaryOperatorType.IdentityInequality,
														      new CodePrimitiveExpression (null)),
										    assign);

					method.Statements.Add (condStatement);

					// if ((this.__Template_mainContent != null)) {
					// 	this.__Template_mainContent.InstantiateIn(__ctrl);
					// }
					// and also set things up such that any additional code ends up in:
					// else {
					// 	...
					// }
					//
					CodeMethodReferenceExpression methodRef = new CodeMethodReferenceExpression ();
					methodRef.TargetObject = templateID;
					methodRef.MethodName = "InstantiateIn";

					CodeMethodInvokeExpression instantiateInInvoke;
					instantiateInInvoke = new CodeMethodInvokeExpression (methodRef, ctrlVar);

					condStatement = new CodeConditionStatement (new CodeBinaryOperatorExpression (templateID,
														      CodeBinaryOperatorType.IdentityInequality,
														      new CodePrimitiveExpression (null)),
										    new CodeExpressionStatement (instantiateInInvoke));
					method.Statements.Add (condStatement);

					// this is the bit that causes the following stuff to end up in the else { }
					builder.methodStatements = condStatement.FalseStatements;

					// __ctrl.TemplateControl = this;
					assign = new CodeAssignStatement ();
					assign.Left = new CodePropertyReferenceExpression (ctrlVar, "TemplateControl");;
					assign.Right = thisRef;

					method.Statements.Add (assign);
				}
#endif
			}

			mainClass.Members.Add (method);
		}

		protected virtual void AddStatementsToInitMethod (CodeMemberMethod method)
		{
		}

		void AddLiteralSubObject (ControlBuilder builder, string str)
		{
			if (!builder.HasAspCode) {
				CodeObjectCreateExpression expr;
				expr = new CodeObjectCreateExpression (typeof (LiteralControl), new CodePrimitiveExpression (str));
				AddParsedSubObjectStmt (builder, expr);
			} else {
				CodeMethodReferenceExpression methodRef = new CodeMethodReferenceExpression ();
				methodRef.TargetObject = new CodeArgumentReferenceExpression ("__output");
				methodRef.MethodName = "Write";

				CodeMethodInvokeExpression expr;
				expr = new CodeMethodInvokeExpression (methodRef, new CodePrimitiveExpression (str));
				builder.renderMethod.Statements.Add (expr);
			}
		}

		string TrimDB (string value)
		{
			string str = value.Trim ();
			str = str.Substring (3);
			return str.Substring (0, str.Length - 2);
		}

		string DataBoundProperty (ControlBuilder builder, Type type, string varName, string value)
		{
			value = TrimDB (value);
			CodeMemberMethod method;
			string dbMethodName = builder.method.Name + "_DB_" + dataBoundAtts++;
#if NET_2_0
                       bool need_if = false;
                       value = value.Trim ();
                       if (StrUtils.StartsWith (value, "Bind")) {
                               value = "Eval" + value.Substring (4);
                               need_if = true;
                       }
#endif

			method = CreateDBMethod (dbMethodName, GetContainerType (builder), builder.ControlType);

			CodeVariableReferenceExpression targetExpr = new CodeVariableReferenceExpression ("target");

			// This should be a CodePropertyReferenceExpression for properties... but it works anyway
			CodeFieldReferenceExpression field = new CodeFieldReferenceExpression (targetExpr, varName);

			CodeExpression expr;
			if (type == typeof (string)) {
				CodeMethodInvokeExpression tostring = new CodeMethodInvokeExpression ();
				CodeTypeReferenceExpression conv = new CodeTypeReferenceExpression (typeof (Convert));
				tostring.Method = new CodeMethodReferenceExpression (conv, "ToString");
				tostring.Parameters.Add (new CodeSnippetExpression (value));
				expr = tostring;
			} else {
				CodeSnippetExpression snippet = new CodeSnippetExpression (value);
				expr = new CodeCastExpression (type, snippet);
			}
			
#if NET_2_0
                       CodeAssignStatement assign = new CodeAssignStatement (field, expr);
                       if (!need_if)
                               method.Statements.Add (assign);
                       else {
                               CodeExpression page=new CodePropertyReferenceExpression(new CodeThisReferenceExpression(), "Page");
                               CodeExpression left=new CodeMethodInvokeExpression (page, "GetDataItem");
                               CodeBinaryOperatorExpression ce = new  CodeBinaryOperatorExpression(left, CodeBinaryOperatorType.IdentityInequality, new CodePrimitiveExpression(null));
                               CodeConditionStatement ccs = new CodeConditionStatement (ce, assign);
                               method.Statements.Add (ccs);
                       }
#else 
			method.Statements.Add (new CodeAssignStatement (field, expr));
#endif
			mainClass.Members.Add (method);
			return method.Name;
		}

		void AddCodeForPropertyOrField (ControlBuilder builder, Type type, string var_name, string att, MemberInfo member, bool isDataBound)
		{
			CodeMemberMethod method = builder.method;
			if (isDataBound && IsWritablePropertyOrField (member)) {
				string dbMethodName = DataBoundProperty (builder, type, var_name, att);
				AddEventAssign (method, "DataBinding", typeof (EventHandler), dbMethodName);
				return;
			}

			CodeAssignStatement assign = new CodeAssignStatement ();
			assign.Left = new CodePropertyReferenceExpression (ctrlVar, var_name);
			currentLocation = builder.location;
			assign.Right = GetExpressionFromString (type, att, member);

			method.Statements.Add (assign);
		}

		bool IsDataBound (string value)
		{
			if (value == null || value == "")
				return false;

			string str = value.Trim ();
			return (StrUtils.StartsWith (str, "<%#") && StrUtils.EndsWith (str, "%>"));
		}

#if NET_2_0
		void RegisterBindingInfo (ControlBuilder builder, string propName, ref string value)
		{
			string str = value.Trim ();
			str = str.Substring (3).Trim ();	// eats "<%#"
			if (StrUtils.StartsWith (str, "Bind")) {
				Match match = bindRegex.Match (str);
				if (match.Success) {
					string bindingName = match.Groups [1].Value;
					
					TemplateBuilder templateBuilder = builder.ParentTemplateBuilder;
					if (templateBuilder == null || templateBuilder.BindingDirection == BindingDirection.OneWay)
						throw new HttpException ("Bind expression not allowed in this context.");
						
					string id = builder.attribs ["ID"] as string;
					if (id == null)
						throw new HttpException ("Control of type '" + builder.ControlType + "' using two-way binding on property '" + propName + "' must have an ID.");
					
					templateBuilder.RegisterBoundProperty (builder.ControlType, propName, id, bindingName);
					//value = "<%# Eval" + str.Substring (4);
				}
			}
		}
#endif

		/*
		static bool InvariantCompare (string a, string b)
		{
			return (0 == String.Compare (a, b, false, CultureInfo.InvariantCulture));
		}
		*/

		static bool InvariantCompareNoCase (string a, string b)
		{
			return (0 == String.Compare (a, b, true, CultureInfo.InvariantCulture));
		}

		static MemberInfo GetFieldOrProperty (Type type, string name)
		{
			MemberInfo member = null;
			try {
				member = type.GetProperty (name, noCaseFlags & ~BindingFlags.NonPublic);
			} catch {}
			
			if (member != null)
				return member;

			try {
				member = type.GetField (name, noCaseFlags & ~BindingFlags.NonPublic);
			} catch {}

			return member;
		}

		static bool IsWritablePropertyOrField (MemberInfo member)
		{
			PropertyInfo pi = member as PropertyInfo;
			if (pi != null)
				return pi.CanWrite;
			FieldInfo fi = member as FieldInfo;
			if (fi != null)
				return !fi.IsInitOnly;
			throw new ArgumentException ("Argument must be of PropertyInfo or FieldInfo type", "member");
		}

		bool ProcessPropertiesAndFields (ControlBuilder builder, MemberInfo member, string id,
						string attValue, string prefix)
		{
			int hyphen = id.IndexOf ('-');
			bool isPropertyInfo = (member is PropertyInfo);
			bool isDataBound = IsDataBound (attValue);

			Type type;
			if (isPropertyInfo) {
				type = ((PropertyInfo) member).PropertyType;
			} else {
				type = ((FieldInfo) member).FieldType;
			}

			if (InvariantCompareNoCase (member.Name, id)) {
#if NET_2_0
				if (isDataBound) RegisterBindingInfo (builder, member.Name, ref attValue);
#endif
				if (!IsWritablePropertyOrField (member))
					return false;

				AddCodeForPropertyOrField (builder, type, member.Name, attValue, member, isDataBound);
				return true;
			}
			
			if (hyphen == -1)
				return false;

			string prop_field = id.Replace ("-", ".");
			string [] parts = prop_field.Split (new char [] {'.'});
			int length = parts.Length;
			if (length < 2 || !InvariantCompareNoCase (member.Name, parts [0]))
				return false;

			if (length > 2) {
				MemberInfo sub_member = GetFieldOrProperty (type, parts [1]);
				if (sub_member == null)
					return false;

				string new_prefix = prefix + parts [0] + ".";
				string new_id = id.Substring (hyphen + 1);
				return ProcessPropertiesAndFields (builder, sub_member, new_id, attValue, new_prefix);
			}

			MemberInfo subpf = GetFieldOrProperty (type, parts [1]);
			if (!(subpf is PropertyInfo))
				return false;

			PropertyInfo subprop = (PropertyInfo) subpf;
			if (subprop.CanWrite == false)
				return false;

			bool is_bool = (subprop.PropertyType == typeof (bool));
			if (!is_bool && attValue == null)
				return false; // Font-Size -> Font-Size="" as html

			string val = attValue;
			if (attValue == null && is_bool)
				val = "true"; // Font-Bold <=> Font-Bold="true"
#if NET_2_0
			if (isDataBound) RegisterBindingInfo (builder, prefix + member.Name + "." + subprop.Name, ref attValue);
#endif
			AddCodeForPropertyOrField (builder, subprop.PropertyType,
						prefix + member.Name + "." + subprop.Name,
						val, subprop, isDataBound);

			return true;
		}

		void AddEventAssign (CodeMemberMethod method, string name, Type type, string value)
		{
			//"__ctrl.{0} += new {1} (this.{2});"
			CodeEventReferenceExpression evtID = new CodeEventReferenceExpression (ctrlVar, name);

			CodeDelegateCreateExpression create;
			create = new CodeDelegateCreateExpression (new CodeTypeReference (type), thisRef, value);

			CodeAttachEventStatement attach = new CodeAttachEventStatement (evtID, create);
			method.Statements.Add (attach);
		}
		
		void CreateAssignStatementFromAttribute (ControlBuilder builder, string id)
		{
			EventInfo [] ev_info = null;
			Type type = builder.ControlType;

			string attvalue = builder.attribs [id] as string;
			if (id.Length > 2 && id.Substring (0, 2).ToUpper () == "ON"){
				if (ev_info == null)
					ev_info = type.GetEvents ();

				string id_as_event = id.Substring (2);
				foreach (EventInfo ev in ev_info){
					if (InvariantCompareNoCase (ev.Name, id_as_event)){
						AddEventAssign (builder.method,
								ev.Name,
								ev.EventHandlerType,
								attvalue);
						
						return;
					}
				}

			}

			int hyphen = id.IndexOf ('-');
			string alt_id = id;
			if (hyphen != -1)
				alt_id = id.Substring (0, hyphen);

			MemberInfo fop = GetFieldOrProperty (type, alt_id);
			if (fop != null) {
				if (ProcessPropertiesAndFields (builder, fop, id, attvalue, null))
					return;
			}

			if (!typeof (IAttributeAccessor).IsAssignableFrom (type))
				throw new ParseException (builder.location, "Unrecognized attribute: " + id);

			string val;
			CodeMemberMethod method = builder.method;
			bool databound = IsDataBound (attvalue);
			if (databound) {
				val = attvalue.Substring (3);
				val = val.Substring (0, val.Length - 2);
				CreateDBAttributeMethod (builder, id, val);
			} else {
				CodeCastExpression cast;
				CodeMethodReferenceExpression methodExpr;
				CodeMethodInvokeExpression expr;

				cast = new CodeCastExpression (typeof (IAttributeAccessor), ctrlVar);
				methodExpr = new CodeMethodReferenceExpression (cast, "SetAttribute");
				expr = new CodeMethodInvokeExpression (methodExpr);
				expr.Parameters.Add (new CodePrimitiveExpression (id));
				expr.Parameters.Add (new CodePrimitiveExpression (attvalue));
				method.Statements.Add (expr);
			}

		}

		protected void CreateAssignStatementsFromAttributes (ControlBuilder builder)
		{
			this.dataBoundAtts = 0;
			IDictionary atts = builder.attribs;
			if (atts == null || atts.Count == 0)
				return;

			foreach (string id in atts.Keys) {
				if (InvariantCompareNoCase (id, "runat"))
					continue;

#if NET_2_0
				/* we skip SkinID here as it's assigned in BuildControlTree */
				if (InvariantCompareNoCase (id, "skinid"))
					continue;
#endif
				CreateAssignStatementFromAttribute (builder, id);
			}
		}

		void CreateDBAttributeMethod (ControlBuilder builder, string attr, string code)
		{
			if (code == null || code.Trim () == "")
				return;

			string id = builder.GetNextID (null);
			string dbMethodName = "__DataBind_" + id;
			CodeMemberMethod method = builder.method;
			AddEventAssign (method, "DataBinding", typeof (EventHandler), dbMethodName);

			method = CreateDBMethod (dbMethodName, GetContainerType (builder), builder.ControlType);
			CodeCastExpression cast;
			CodeMethodReferenceExpression methodExpr;
			CodeMethodInvokeExpression expr;

			CodeVariableReferenceExpression targetExpr = new CodeVariableReferenceExpression ("target");
			cast = new CodeCastExpression (typeof (IAttributeAccessor), targetExpr);
			methodExpr = new CodeMethodReferenceExpression (cast, "SetAttribute");
			expr = new CodeMethodInvokeExpression (methodExpr);
			expr.Parameters.Add (new CodePrimitiveExpression (attr));
			CodeMethodInvokeExpression tostring = new CodeMethodInvokeExpression ();
			tostring.Method = new CodeMethodReferenceExpression (
							new CodeTypeReferenceExpression (typeof (Convert)),
							"ToString");
			tostring.Parameters.Add (new CodeSnippetExpression (code));
			expr.Parameters.Add (tostring);
			method.Statements.Add (expr);
			mainClass.Members.Add (method);
		}

		void AddRenderControl (ControlBuilder builder)
		{
			CodeIndexerExpression indexer = new CodeIndexerExpression ();
			indexer.TargetObject = new CodePropertyReferenceExpression (
							new CodeArgumentReferenceExpression ("parameterContainer"),
							"Controls");
							
			indexer.Indices.Add (new CodePrimitiveExpression (builder.renderIndex));
			
			CodeMethodInvokeExpression invoke = new CodeMethodInvokeExpression (indexer, "RenderControl");
			invoke.Parameters.Add (new CodeArgumentReferenceExpression ("__output"));
			builder.renderMethod.Statements.Add (invoke);
			builder.renderIndex++;
		}

		protected void AddChildCall (ControlBuilder parent, ControlBuilder child)
		{
			CodeMethodReferenceExpression m = new CodeMethodReferenceExpression (thisRef, child.method.Name);
			CodeMethodInvokeExpression expr = new CodeMethodInvokeExpression (m);

			object [] atts = child.ControlType.GetCustomAttributes (typeof (PartialCachingAttribute), true);
			if (atts != null && atts.Length > 0) {
				PartialCachingAttribute pca = (PartialCachingAttribute) atts [0];
				CodeTypeReferenceExpression cc = new CodeTypeReferenceExpression("System.Web.UI.StaticPartialCachingControl");
				CodeMethodInvokeExpression build = new CodeMethodInvokeExpression (cc, "BuildCachedControl");
				build.Parameters.Add (new CodeArgumentReferenceExpression("__ctrl"));
				build.Parameters.Add (new CodePrimitiveExpression (child.ID));
#if NET_1_1
				if (pca.Shared)
					build.Parameters.Add (new CodePrimitiveExpression (child.ControlType.GetHashCode ().ToString ()));
				else
#endif
					build.Parameters.Add (new CodePrimitiveExpression (Guid.NewGuid ().ToString ()));
					
				build.Parameters.Add (new CodePrimitiveExpression (pca.Duration));
				build.Parameters.Add (new CodePrimitiveExpression (pca.VaryByParams));
				build.Parameters.Add (new CodePrimitiveExpression (pca.VaryByControls));
				build.Parameters.Add (new CodePrimitiveExpression (pca.VaryByCustom));
				build.Parameters.Add (new CodeDelegateCreateExpression (
							      new CodeTypeReference (typeof (System.Web.UI.BuildMethod)),
							      thisRef, child.method.Name));
				
				parent.methodStatements.Add (build);
				if (parent.HasAspCode)
					AddRenderControl (parent);
				return;
			}
                                
			if (child.isProperty || parent.ChildrenAsProperties) {
				expr.Parameters.Add (new CodeFieldReferenceExpression (ctrlVar, child.TagName));
				parent.methodStatements.Add (expr);
				return;
			}

			parent.methodStatements.Add (expr);
			CodeFieldReferenceExpression field = new CodeFieldReferenceExpression (thisRef, child.ID);
			if (parent.ControlType == null || typeof (IParserAccessor).IsAssignableFrom (parent.ControlType)) {
				AddParsedSubObjectStmt (parent, field);
			} else {
				CodeMethodInvokeExpression invoke = new CodeMethodInvokeExpression (ctrlVar, "Add");
				invoke.Parameters.Add (field);
				parent.methodStatements.Add (invoke);
			}
				
			if (parent.HasAspCode)
				AddRenderControl (parent);
		}

		void AddTemplateInvocation (CodeMemberMethod method, string name, string methodName)
		{
			CodePropertyReferenceExpression prop = new CodePropertyReferenceExpression (ctrlVar, name);

			CodeObjectCreateExpression newBuild = new CodeObjectCreateExpression (typeof (BuildTemplateMethod));
			newBuild.Parameters.Add (new CodeMethodReferenceExpression (thisRef, methodName));

			CodeObjectCreateExpression newCompiled = new CodeObjectCreateExpression (typeof (CompiledTemplateBuilder));
			newCompiled.Parameters.Add (newBuild);

			CodeAssignStatement assign = new CodeAssignStatement (prop, newCompiled);
			method.Statements.Add (assign);
		}

#if NET_2_0
		void AddBindableTemplateInvocation (CodeMemberMethod method, string name, string methodName, string extractMethodName)
		{
			CodePropertyReferenceExpression prop = new CodePropertyReferenceExpression (ctrlVar, name);

			CodeObjectCreateExpression newBuild = new CodeObjectCreateExpression (typeof (BuildTemplateMethod));
			newBuild.Parameters.Add (new CodeMethodReferenceExpression (thisRef, methodName));

			CodeObjectCreateExpression newExtract = new CodeObjectCreateExpression (typeof (ExtractTemplateValuesMethod));
			newExtract.Parameters.Add (new CodeMethodReferenceExpression (thisRef, extractMethodName));

			CodeObjectCreateExpression newCompiled = new CodeObjectCreateExpression (typeof (CompiledBindableTemplateBuilder));
			newCompiled.Parameters.Add (newBuild);
			newCompiled.Parameters.Add (newExtract);
			
			CodeAssignStatement assign = new CodeAssignStatement (prop, newCompiled);
			method.Statements.Add (assign);
		}
		
		string CreateExtractValuesMethod (TemplateBuilder builder)
		{
			CodeMemberMethod method = new CodeMemberMethod ();
			method.Name = "__ExtractValues_" + builder.ID;
			method.Attributes = MemberAttributes.Private | MemberAttributes.Final;
			method.ReturnType = new CodeTypeReference (typeof(IOrderedDictionary));
			
			CodeParameterDeclarationExpression arg = new CodeParameterDeclarationExpression ();
			arg.Type = new CodeTypeReference (typeof (Control));
			arg.Name = "__container";
			method.Parameters.Add (arg);
			mainClass.Members.Add (method);
			
			CodeObjectCreateExpression newTable = new CodeObjectCreateExpression ();
			newTable.CreateType = new CodeTypeReference (typeof(OrderedDictionary));
			method.Statements.Add (new CodeVariableDeclarationStatement (typeof(OrderedDictionary), "__table", newTable));
			CodeVariableReferenceExpression tableExp = new CodeVariableReferenceExpression ("__table");
			
			if (builder.Bindings != null) {
				foreach (TemplateBinding binding in builder.Bindings) {
					CodeVariableDeclarationStatement dec = new CodeVariableDeclarationStatement (binding.ControlType, binding.ControlId);
					method.Statements.Add (dec);
					CodeVariableReferenceExpression cter = new CodeVariableReferenceExpression ("__container");
					CodeMethodInvokeExpression invoke = new CodeMethodInvokeExpression (cter, "FindControl");
					invoke.Parameters.Add (new CodePrimitiveExpression (binding.ControlId));
					
					CodeAssignStatement assign = new CodeAssignStatement ();
					CodeVariableReferenceExpression control = new CodeVariableReferenceExpression (binding.ControlId); 
					assign.Left = control;
					assign.Right = new CodeCastExpression (binding.ControlType, invoke);
					method.Statements.Add (assign);
					
					CodeConditionStatement sif = new CodeConditionStatement ();
					sif.Condition = new CodeBinaryOperatorExpression (control, CodeBinaryOperatorType.IdentityInequality, new CodePrimitiveExpression (null));
					
					assign = new CodeAssignStatement ();
					assign.Left = new CodeIndexerExpression (tableExp, new CodePrimitiveExpression (binding.FieldName));
					assign.Right = new CodePropertyReferenceExpression (control, binding.ControlProperty);
					sif.TrueStatements.Add (assign);
					method.Statements.Add (sif);
				}
			}

			method.Statements.Add (new CodeMethodReturnStatement (tableExp));
			return method.Name;
		}

		void AddContentTemplateInvocation (ContentBuilderInternal cbuilder, CodeMemberMethod method, string methodName)
		{
			CodeObjectCreateExpression newBuild = new CodeObjectCreateExpression (typeof (BuildTemplateMethod));
			newBuild.Parameters.Add (new CodeMethodReferenceExpression (thisRef, methodName));

			CodeObjectCreateExpression newCompiled = new CodeObjectCreateExpression (typeof (CompiledTemplateBuilder));
			newCompiled.Parameters.Add (newBuild);
			
			CodeMethodInvokeExpression invoke = new CodeMethodInvokeExpression (thisRef, "AddContentTemplate");
			invoke.Parameters.Add (new CodePrimitiveExpression (cbuilder.ContentPlaceHolderID));
			invoke.Parameters.Add (newCompiled);

			method.Statements.Add (invoke);
		}
#endif

		void AddCodeRender (ControlBuilder parent, CodeRenderBuilder cr)
		{
			if (cr.Code == null || cr.Code.Trim () == "")
				return;

			if (!cr.IsAssign) {
				CodeSnippetStatement code = new CodeSnippetStatement (cr.Code);
				parent.renderMethod.Statements.Add (code);
				return;
			}

			CodeMethodInvokeExpression expr = new CodeMethodInvokeExpression ();
			expr.Method = new CodeMethodReferenceExpression (
							new CodeArgumentReferenceExpression ("__output"),
							"Write");

			expr.Parameters.Add (new CodeSnippetExpression (cr.Code));
			parent.renderMethod.Statements.Add (expr);
		}

		static Type GetContainerType (ControlBuilder builder)
		{
			TemplateBuilder tb = builder as TemplateBuilder;
			if (tb != null && tb.ContainerType != null)
				return tb.ContainerType;

			Type type = builder.BindingContainerType;

			PropertyInfo prop = type.GetProperty ("Items", noCaseFlags & ~BindingFlags.NonPublic);
			if (prop == null)
				return type;

			Type ptype = prop.PropertyType;
			if (!typeof (ICollection).IsAssignableFrom (ptype))
				return type;

			prop = ptype.GetProperty ("Item", noCaseFlags & ~BindingFlags.NonPublic);
			if (prop == null)
				return type;

			return prop.PropertyType;
		}
		
		CodeMemberMethod CreateDBMethod (string name, Type container, Type target)
		{
			CodeMemberMethod method = new CodeMemberMethod ();
			method.Attributes = MemberAttributes.Public | MemberAttributes.Final;
			method.Name = name;
			method.Parameters.Add (new CodeParameterDeclarationExpression (typeof (object), "sender"));
			method.Parameters.Add (new CodeParameterDeclarationExpression (typeof (EventArgs), "e"));

			CodeTypeReference containerRef = new CodeTypeReference (container);
			CodeTypeReference targetRef = new CodeTypeReference (target);

			CodeVariableDeclarationStatement decl = new CodeVariableDeclarationStatement();
			decl.Name = "Container";
			decl.Type = containerRef;
			method.Statements.Add (decl);

			decl = new CodeVariableDeclarationStatement();
			decl.Name = "target";
			decl.Type = targetRef;
			method.Statements.Add (decl);

			CodeVariableReferenceExpression targetExpr = new CodeVariableReferenceExpression ("target");
			CodeAssignStatement assign = new CodeAssignStatement ();
			assign.Left = targetExpr;
			assign.Right = new CodeCastExpression (targetRef, new CodeArgumentReferenceExpression ("sender"));
			method.Statements.Add (assign);

			assign = new CodeAssignStatement ();
			assign.Left = new CodeVariableReferenceExpression ("Container");
			assign.Right = new CodeCastExpression (containerRef,
						new CodePropertyReferenceExpression (targetExpr, "BindingContainer"));
			method.Statements.Add (assign);

			return method;
		}

		void AddDataBindingLiteral (ControlBuilder builder, DataBindingBuilder db)
		{
			if (db.Code == null || db.Code.Trim () == "")
				return;

			EnsureID (db);
			CreateField (db, false);

			string dbMethodName = "__DataBind_" + db.ID;
			// Add the method that builds the DataBoundLiteralControl
			InitMethod (db, false, false);
			CodeMemberMethod method = db.method;
			AddEventAssign (method, "DataBinding", typeof (EventHandler), dbMethodName);
			method.Statements.Add (new CodeMethodReturnStatement (ctrlVar));

			// Add the DataBind handler
			method = CreateDBMethod (dbMethodName, GetContainerType (builder), typeof (DataBoundLiteralControl));

			CodeVariableReferenceExpression targetExpr = new CodeVariableReferenceExpression ("target");
			CodeMethodInvokeExpression invoke = new CodeMethodInvokeExpression ();
			invoke.Method = new CodeMethodReferenceExpression (targetExpr, "SetDataBoundString");
			invoke.Parameters.Add (new CodePrimitiveExpression (0));

			CodeMethodInvokeExpression tostring = new CodeMethodInvokeExpression ();
			tostring.Method = new CodeMethodReferenceExpression (
							new CodeTypeReferenceExpression (typeof (Convert)),
							"ToString");
			tostring.Parameters.Add (new CodeSnippetExpression (db.Code));
			invoke.Parameters.Add (tostring);
			method.Statements.Add (invoke);
			
			mainClass.Members.Add (method);

			AddChildCall (builder, db);
		}

		void FlushText (ControlBuilder builder, StringBuilder sb)
		{
			if (sb.Length > 0) {
				AddLiteralSubObject (builder, sb.ToString ());
				sb.Length = 0;
			}
		}

		protected void CreateControlTree (ControlBuilder builder, bool inTemplate, bool childrenAsProperties)
		{
			EnsureID (builder);
			bool isTemplate = (typeof (TemplateBuilder).IsAssignableFrom (builder.GetType ()));
			if (!isTemplate && !inTemplate) {
				CreateField (builder, true);
			} else if (!isTemplate) {
				builder.ID = builder.GetNextID (null);
				CreateField (builder, false);
			}

			InitMethod (builder, isTemplate, childrenAsProperties);
			if (!isTemplate || builder.GetType () == typeof (RootBuilder))
				CreateAssignStatementsFromAttributes (builder);

			if (builder.Children != null && builder.Children.Count > 0) {
				ArrayList templates = null;

				StringBuilder sb = new StringBuilder ();
				foreach (object b in builder.Children) {

					if (b is string) {
						sb.Append ((string) b);
						continue;
					}

					FlushText (builder, sb);
					if (b is ObjectTagBuilder) {
						ProcessObjectTag ((ObjectTagBuilder) b);
						continue;
					}

					StringPropertyBuilder pb = b as StringPropertyBuilder;
					if (pb != null){
						if (pb.Children != null && pb.Children.Count > 0) {
							StringBuilder asb = new StringBuilder ();
							foreach (string s in pb.Children)
								asb.Append (s);
							CodeMemberMethod method = builder.method;
							CodeAssignStatement assign = new CodeAssignStatement ();
							assign.Left = new CodePropertyReferenceExpression (ctrlVar, pb.PropertyName);
							assign.Right = new CodePrimitiveExpression (asb.ToString ());
							method.Statements.Add (assign);
						}
						continue;
					}

#if NET_2_0
					if (b is ContentBuilderInternal) {
						ContentBuilderInternal cb = (ContentBuilderInternal) b;
						CreateControlTree (cb, false, true);
						AddContentTemplateInvocation (cb, builder.method, cb.method.Name);
						continue;
					}
#endif

					if (b is TemplateBuilder) {
						if (templates == null)
							templates = new ArrayList ();

						templates.Add (b);
						continue;
					}

					if (b is CodeRenderBuilder) {
						AddCodeRender (builder, (CodeRenderBuilder) b);
						continue;
					}

					if (b is DataBindingBuilder) {
						AddDataBindingLiteral (builder, (DataBindingBuilder) b);
						continue;
					}
					
					if (b is ControlBuilder) {
						ControlBuilder child = (ControlBuilder) b;
						CreateControlTree (child, inTemplate, builder.ChildrenAsProperties);
						AddChildCall (builder, child);
						continue;
					}

					throw new Exception ("???");
				}

				FlushText (builder, sb);

				if (templates != null) {
					foreach (TemplateBuilder b in templates) {
						CreateControlTree (b, true, false);
#if NET_2_0
						if (b.BindingDirection == BindingDirection.TwoWay) {
							string extractMethod = CreateExtractValuesMethod (b);
							AddBindableTemplateInvocation (builder.method, b.TagName, b.method.Name, extractMethod);
						}
						else
#endif
						AddTemplateInvocation (builder.method, b.TagName, b.method.Name);
					}
				}

			}

			if (builder.defaultPropertyBuilder != null) {
				ControlBuilder b = builder.defaultPropertyBuilder;
				CreateControlTree (b, false, true);
				AddChildCall (builder, b);
			}

			if (builder.HasAspCode) {
				CodeMethodReferenceExpression m = new CodeMethodReferenceExpression ();
				m.TargetObject = thisRef;
				m.MethodName = builder.renderMethod.Name;

				CodeDelegateCreateExpression create = new CodeDelegateCreateExpression ();
				create.DelegateType = new CodeTypeReference (typeof (RenderMethod));
				create.TargetObject = thisRef;
				create.MethodName = builder.renderMethod.Name;

				CodeMethodInvokeExpression invoke = new CodeMethodInvokeExpression ();
				invoke.Method = new CodeMethodReferenceExpression (ctrlVar, "SetRenderMethodDelegate");
				invoke.Parameters.Add (create);

				builder.methodStatements.Add (invoke);
			}
			
			if (!childrenAsProperties && typeof (Control).IsAssignableFrom (builder.ControlType))
				builder.method.Statements.Add (new CodeMethodReturnStatement (ctrlVar));
		}

		protected internal override void CreateMethods ()
		{
			base.CreateMethods ();

			CreateProperties ();
			CreateControlTree (parser.RootBuilder, false, false);
			CreateFrameworkInitializeMethod ();
		}

		void CallBaseFrameworkInitialize (CodeMemberMethod method)
		{
			CodeBaseReferenceExpression baseRef = new CodeBaseReferenceExpression ();
			CodeMethodInvokeExpression invoke = new CodeMethodInvokeExpression (baseRef, "FrameworkInitialize");
			method.Statements.Add (invoke);
		}

		void CreateFrameworkInitializeMethod ()
		{
			CodeMemberMethod method = new CodeMemberMethod ();
			method.Name = "FrameworkInitialize";
			method.Attributes = MemberAttributes.Family | MemberAttributes.Override;
			PrependStatementsToFrameworkInitialize (method);
			CallBaseFrameworkInitialize (method);
			AppendStatementsToFrameworkInitialize (method);
			mainClass.Members.Add (method);
		}

		protected virtual void PrependStatementsToFrameworkInitialize (CodeMemberMethod method)
		{
		}

		protected virtual void AppendStatementsToFrameworkInitialize (CodeMemberMethod method)
		{
			if (!parser.EnableViewState) {
				CodeAssignStatement stmt = new CodeAssignStatement ();
				stmt.Left = new CodePropertyReferenceExpression (thisRef, "EnableViewState");
				stmt.Right = new CodePrimitiveExpression (false);
				method.Statements.Add (stmt);
			}

			CodeMethodReferenceExpression methodExpr;
			methodExpr = new CodeMethodReferenceExpression (thisRef, "__BuildControlTree");
			CodeMethodInvokeExpression expr = new CodeMethodInvokeExpression (methodExpr, thisRef);
			method.Statements.Add (new CodeExpressionStatement (expr));
		}

		protected override void AddApplicationAndSessionObjects ()
		{
			foreach (ObjectTagBuilder tag in GlobalAsaxCompiler.ApplicationObjects) {
				CreateFieldForObject (tag.Type, tag.ObjectID);
				CreateApplicationOrSessionPropertyForObject (tag.Type, tag.ObjectID, true, false);
			}

			foreach (ObjectTagBuilder tag in GlobalAsaxCompiler.SessionObjects) {
				CreateApplicationOrSessionPropertyForObject (tag.Type, tag.ObjectID, false, false);
			}
		}

		protected void ProcessObjectTag (ObjectTagBuilder tag)
		{
			string fieldName = CreateFieldForObject (tag.Type, tag.ObjectID);
			CreatePropertyForObject (tag.Type, tag.ObjectID, fieldName, false);
		}

		void CreateProperties ()
		{
			if (!parser.AutoEventWireup) {
				CreateAutoEventWireup ();
			} else {
				CreateAutoHandlers ();
			}

			CreateApplicationInstance ();
			CreateTemplateSourceDirectory ();
		}

		void CreateTemplateSourceDirectory ()
		{
			CodeMemberProperty prop = new CodeMemberProperty ();
			prop.Type = new CodeTypeReference (typeof (string));
			prop.Name = "TemplateSourceDirectory";
			prop.Attributes = MemberAttributes.Public | MemberAttributes.Override;

			CodePrimitiveExpression expr = new CodePrimitiveExpression (parser.BaseVirtualDir);
			prop.GetStatements.Add (new CodeMethodReturnStatement (expr));
			mainClass.Members.Add (prop);
		}

		void CreateApplicationInstance ()
		{
			CodeMemberProperty prop = new CodeMemberProperty ();
			Type appType = typeof (HttpApplication);
			prop.Type = new CodeTypeReference (appType);
			prop.Name = "ApplicationInstance";
			prop.Attributes = MemberAttributes.Family | MemberAttributes.Final;

			CodePropertyReferenceExpression propRef = new CodePropertyReferenceExpression (thisRef, "Context");

			propRef = new CodePropertyReferenceExpression (propRef, "ApplicationInstance");

			CodeCastExpression cast = new CodeCastExpression (appType.FullName, propRef);
			prop.GetStatements.Add (new CodeMethodReturnStatement (cast));
			mainClass.Members.Add (prop);
		}

		void CreateAutoHandlers ()
		{
			// Create AutoHandlers property
			CodeMemberProperty prop = new CodeMemberProperty ();
			prop.Type = new CodeTypeReference (typeof (int));
			prop.Name = "AutoHandlers";
			prop.Attributes = MemberAttributes.Family | MemberAttributes.Override;
			
			CodeMethodReturnStatement ret = new CodeMethodReturnStatement ();
			CodeFieldReferenceExpression fldRef ;
			fldRef = new CodeFieldReferenceExpression (mainClassExpr, "__autoHandlers");
			ret.Expression = fldRef;
			prop.GetStatements.Add (ret);
			
			prop.SetStatements.Add (new CodeAssignStatement (fldRef, new CodePropertySetValueReferenceExpression ()));

			mainClass.Members.Add (prop);

			// Add the __autoHandlers field
			CodeMemberField fld = new CodeMemberField (typeof (int), "__autoHandlers");
			fld.Attributes = MemberAttributes.Private | MemberAttributes.Static;
			mainClass.Members.Add (fld);
		}

		void CreateAutoEventWireup ()
		{
			// The getter returns false
			CodeMemberProperty prop = new CodeMemberProperty ();
			prop.Type = new CodeTypeReference (typeof (bool));
			prop.Name = "SupportAutoEvents";
			prop.Attributes = MemberAttributes.Family | MemberAttributes.Override;
			prop.GetStatements.Add (new CodeMethodReturnStatement (new CodePrimitiveExpression (false)));
			mainClass.Members.Add (prop);
		}

#if NET_2_0
		protected virtual string HandleUrlProperty (string str, MemberInfo member)
		{
			return str;
		}
#endif
    
		CodeExpression GetExpressionFromString (Type type, string str, MemberInfo member)
		{			
#if NET_2_0
			Type origType = type;
			bool wasNullable = false;
			
			if (type.IsGenericType && type.GetGenericTypeDefinition() == typeof(Nullable<>)) {
				Type[] types = type.GetGenericArguments();
				type = types[0]; // we're interested only in the first type here
				wasNullable = true;
			}
#endif

			if (type == typeof (string)) {
#if NET_2_0
				object[] urlAttr = member.GetCustomAttributes (typeof (UrlPropertyAttribute), true);
				if (urlAttr.Length != 0)
					str = HandleUrlProperty (str, member);
#endif
				return new CodePrimitiveExpression (str);
			}

			if (type == typeof (bool)) {
				if (str == null || str == "" || InvariantCompareNoCase (str, "true"))
					return new CodePrimitiveExpression (true);
				else if (InvariantCompareNoCase (str, "false"))
					return new CodePrimitiveExpression (false);
#if NET_2_0
				else if (wasNullable && InvariantCompareNoCase(str, "null"))
					return new CodePrimitiveExpression (null);
#endif
				else
					throw new ParseException (currentLocation,
							"Value '" + str  + "' is not a valid boolean.");
			}

			if (str == null)
				return new CodePrimitiveExpression (null);

			if (type.IsPrimitive)
				return new CodePrimitiveExpression (Convert.ChangeType (str, type, CultureInfo.InvariantCulture));

			if (type == typeof (string [])) {
				string [] subs = str.Split (',');
				CodeArrayCreateExpression expr = new CodeArrayCreateExpression ();
				expr.CreateType = new CodeTypeReference (typeof (string));
				foreach (string v in subs) {
					expr.Initializers.Add (new CodePrimitiveExpression (v.Trim ()));
				}

				return expr;
			}

			if (type == typeof (Color)){
				if (colorConverter == null)
					colorConverter = TypeDescriptor.GetConverter (typeof (Color));

				if (str.Trim().Length == 0) {
					CodeTypeReferenceExpression ft = new CodeTypeReferenceExpression (typeof (Color));
					return new CodeFieldReferenceExpression (ft, "Empty");
				}
				
				Color c;
				try {
					if (str.IndexOf (',') == -1) {
						c = (Color) colorConverter.ConvertFromString (str);
					} else {
						int [] argb = new int [4];
						argb [0] = 255;

						string [] parts = str.Split (',');
						int length = parts.Length;
						if (length < 3)
							throw new Exception ();

						int basei = (length == 4) ? 0 : 1;
						for (int i = length - 1; i >= 0; i--) {
							argb [basei + i] = (int) Byte.Parse (parts [i]);
						}
						c = Color.FromArgb (argb [0], argb [1], argb [2], argb [3]);
					}
				} catch (Exception e){
					// Hack: "LightGrey" is accepted, but only for ASP.NET, as the
					// TypeConverter for Color fails to ConvertFromString.
					// Hence this hack...
					if (InvariantCompareNoCase ("LightGrey", str)) {
						c = Color.LightGray;
					} else {
						throw new ParseException (currentLocation,
							"Color " + str + " is not a valid color.", e);
					}
				}

				if (c.IsKnownColor){
					CodeFieldReferenceExpression expr = new CodeFieldReferenceExpression ();
					if (c.IsSystemColor)
						type = typeof (SystemColors);

					expr.TargetObject = new CodeTypeReferenceExpression (type);
					expr.FieldName = c.Name;
					return expr;
				} else {
					CodeMethodReferenceExpression m = new CodeMethodReferenceExpression ();
					m.TargetObject = new CodeTypeReferenceExpression (type);
					m.MethodName = "FromArgb";
					CodeMethodInvokeExpression invoke = new CodeMethodInvokeExpression (m);
					invoke.Parameters.Add (new CodePrimitiveExpression (c.A));
					invoke.Parameters.Add (new CodePrimitiveExpression (c.R));
					invoke.Parameters.Add (new CodePrimitiveExpression (c.G));
					invoke.Parameters.Add (new CodePrimitiveExpression (c.B));
					return invoke;
				}
			}

			TypeConverter converter = TypeDescriptor.GetProperties (member.DeclaringType) [member.Name].Converter;
			
			if (converter != null && converter.CanConvertFrom (typeof (string))) {
				object value = converter.ConvertFrom (str);

				if (converter.CanConvertTo (typeof (InstanceDescriptor))) {
					InstanceDescriptor idesc = (InstanceDescriptor) converter.ConvertTo (value, typeof(InstanceDescriptor));
					return GenerateInstance (idesc, true);
				}

				CodeExpression exp = GenerateObjectInstance (value, false);
				if (exp != null) return exp;
				
				CodeMethodReferenceExpression m = new CodeMethodReferenceExpression ();
				m.TargetObject = new CodeTypeReferenceExpression (typeof (TypeDescriptor));
				m.MethodName = "GetConverter";
				CodeMethodInvokeExpression invoke = new CodeMethodInvokeExpression (m);
				CodeTypeReference tref = new CodeTypeReference (type);
				invoke.Parameters.Add (new CodeTypeOfExpression (tref));
				
				invoke = new CodeMethodInvokeExpression (invoke, "ConvertFrom");
				invoke.Parameters.Add (new CodePrimitiveExpression (str));

				return new CodeCastExpression (tref, invoke);
			}
			
			Console.WriteLine ("Unknown type: " + type + " value: " + str);

			return new CodePrimitiveExpression (str);
		}
		
		CodeExpression GenerateInstance (InstanceDescriptor idesc, bool throwOnError)
		{
			CodeExpression[] parameters = new CodeExpression [idesc.Arguments.Count];
			int n = 0;
			foreach (object ob in idesc.Arguments) {
				CodeExpression exp = GenerateObjectInstance (ob, throwOnError);
				if (exp == null) return null;
				parameters [n++] = exp;
			}
			
			switch (idesc.MemberInfo.MemberType) {
			case MemberTypes.Constructor:
				CodeTypeReference tob = new CodeTypeReference (idesc.MemberInfo.DeclaringType);
				return new CodeObjectCreateExpression (tob, parameters);

			case MemberTypes.Method:
				CodeTypeReferenceExpression mt = new CodeTypeReferenceExpression (idesc.MemberInfo.DeclaringType);
				return new CodeMethodInvokeExpression (mt, idesc.MemberInfo.Name, parameters);

			case MemberTypes.Field:
				CodeTypeReferenceExpression ft = new CodeTypeReferenceExpression (idesc.MemberInfo.DeclaringType);
				return new CodeFieldReferenceExpression (ft, idesc.MemberInfo.Name);

			case MemberTypes.Property:
				CodeTypeReferenceExpression pt = new CodeTypeReferenceExpression (idesc.MemberInfo.DeclaringType);
				return new CodePropertyReferenceExpression (pt, idesc.MemberInfo.Name);
			}
			throw new ParseException (currentLocation, "Invalid instance type.");
		}
		
		CodeExpression GenerateObjectInstance (object value, bool throwOnError)
		{
			if (value == null)
				return new CodePrimitiveExpression (null);
			
			Type t = value.GetType();
			if (t.IsPrimitive || value is string)
				return new CodePrimitiveExpression (value);
				
			if (t.IsArray) {
				Array ar = (Array) value;
				CodeExpression[] items = new CodeExpression [ar.Length];
				for (int n=0; n<ar.Length; n++) {
					CodeExpression exp = GenerateObjectInstance (ar.GetValue (n), throwOnError);
					if (exp == null) return null; 
					items [n] = exp;
				}
				return new CodeArrayCreateExpression (new CodeTypeReference (t), items);
			}
			
			TypeConverter converter = TypeDescriptor.GetConverter (t);
			if (converter != null && converter.CanConvertTo (typeof (InstanceDescriptor))) {
				InstanceDescriptor idesc = (InstanceDescriptor) converter.ConvertTo (value, typeof(InstanceDescriptor));
				return GenerateInstance (idesc, throwOnError);
			}
			
			InstanceDescriptor desc = GetDefaultInstanceDescriptor (value);
			if (desc != null) return GenerateInstance (desc, throwOnError);
			
			if (throwOnError)
				throw new ParseException (currentLocation, "Cannot generate an instance for the type: " + t);
			else
				return null;
		}
		
		InstanceDescriptor GetDefaultInstanceDescriptor (object value)
		{
			if (value is System.Web.UI.WebControls.Unit) {
				System.Web.UI.WebControls.Unit s = (System.Web.UI.WebControls.Unit) value;
				MethodInfo met = typeof(System.Web.UI.WebControls.Unit).GetMethod ("Parse", new Type[] {typeof(string)});
				return new InstanceDescriptor (met, new object[] {s.ToString ()});
			}
			
			if (value is System.Web.UI.WebControls.FontUnit) {
				System.Web.UI.WebControls.FontUnit s = (System.Web.UI.WebControls.FontUnit) value;
				MethodInfo met = typeof(System.Web.UI.WebControls.FontUnit).GetMethod ("Parse", new Type[] {typeof(string)});
				return new InstanceDescriptor (met, new object[] {s.ToString ()});
			}
			return null;
		}
	}
}

