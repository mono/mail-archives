Index: parameter.cs
===================================================================
--- parameter.cs	(revision 45101)
+++ parameter.cs	(working copy)
@@ -22,10 +22,12 @@
 	public abstract class ParameterBase : Attributable {
 
 		protected ParameterBuilder builder;
+		public readonly Location Location;
 
-		public ParameterBase (Attributes attrs)
+		public ParameterBase (Attributes attrs, Location loc)
 			: base (attrs)
 		{
+			Location = loc;
 		}
 
 		public override void ApplyAttributeBuilder (Attribute a, CustomAttributeBuilder cb)
@@ -57,7 +59,7 @@
 	/// </summary>
 	public class ReturnParameter: ParameterBase {
 		public ReturnParameter (MethodBuilder mb, Location location):
-			base (null)
+			base (null, location)
 		{
 			try {
 				builder = mb.DefineParameter (0, ParameterAttributes.None, "");			
@@ -101,8 +103,8 @@
 	/// of the 'set' method in properties, and the 'add' and 'remove' methods in events.
 	/// </summary>
 	public class ImplicitParameter: ParameterBase {
-		public ImplicitParameter (MethodBuilder mb):
-			base (null)
+		public ImplicitParameter (MethodBuilder mb, Location loc):
+			base (null, loc)
 		{
 			builder = mb.DefineParameter (1, ParameterAttributes.None, "");			
 		}
@@ -149,8 +151,8 @@
 
 		EmitContext ec;  // because ApplyAtrribute doesn't have ec
 		
-		public Parameter (Expression type, string name, Modifier mod, Attributes attrs)
-			: base (attrs)
+		public Parameter (Expression type, string name, Modifier mod, Attributes attrs, Location loc)
+			: base (attrs, loc)
 		{
 			Name = name;
 			ModFlags = mod;
@@ -333,22 +335,19 @@
 		public readonly bool HasArglist;
 		string signature;
 		Type [] types;
-		Location loc;
 		
 		static Parameters empty_parameters;
 		
-		public Parameters (Parameter [] fixed_parameters, Parameter array_parameter, Location l)
+		public Parameters (Parameter [] fixed_parameters, Parameter array_parameter)
 		{
 			FixedParameters = fixed_parameters;
 			ArrayParameter  = array_parameter;
-			loc = l;
 		}
 
-		public Parameters (Parameter [] fixed_parameters, bool has_arglist, Location l)
+		public Parameters (Parameter [] fixed_parameters, bool has_arglist)
 		{
 			FixedParameters = fixed_parameters;
 			HasArglist = has_arglist;
-			loc = l;
 		}
 
 		/// <summary>
@@ -358,7 +357,7 @@
 		public static Parameters EmptyReadOnlyParameters {
 			get {
 				if (empty_parameters == null)
-					empty_parameters = new Parameters (null, null, Location.Null);
+					empty_parameters = new Parameters (null, null);
 			
 				return empty_parameters;
 			}
@@ -370,10 +369,6 @@
 			}
 		}
 
-		public Location Location {
-			get { return loc; }
-		}
-		
 		public void ComputeSignature (EmitContext ec)
 		{
 			signature = "";
@@ -381,7 +376,7 @@
 				for (int i = 0; i < FixedParameters.Length; i++){
 					Parameter par = FixedParameters [i];
 					
-					signature += par.GetSignature (ec, loc);
+					signature += par.GetSignature (ec, par.Location);
 				}
 			}
 			//
@@ -390,7 +385,7 @@
 			//
 		}
 
-		void Error_DuplicateParameterName (string name)
+		void Error_DuplicateParameterName (string name, Location loc)
 		{
 			Report.Error (
 				100, loc, "The parameter name `" + name + "' is a duplicate");
@@ -412,12 +407,14 @@
 				for (j = i + 1; j < count; j++){
 					if (base_name != FixedParameters [j].Name)
 						continue;
-					Error_DuplicateParameterName (base_name);
+					Error_DuplicateParameterName (base_name,
+						FixedParameters [i].Location);
 					return false;
 				}
 
 				if (base_name == array_par_name){
-					Error_DuplicateParameterName (base_name);
+					Error_DuplicateParameterName (base_name,
+						FixedParameters [i].Location);
 					return false;
 				}
 			}
@@ -496,7 +493,7 @@
 				foreach (Parameter p in FixedParameters){
 					Type t = null;
 					
-					if (p.Resolve (ec, loc))
+					if (p.Resolve (ec, p.Location))
 						t = p.ExternalType ();
 					else
 						failed = true;
@@ -507,7 +504,7 @@
 			}
 			
 			if (extra > 0){
-				if (ArrayParameter.Resolve (ec, loc))
+				if (ArrayParameter.Resolve (ec, ArrayParameter.Location))
 					types [i] = ArrayParameter.ExternalType ();
 				else 
 					failed = true;
Index: class.cs
===================================================================
--- class.cs	(revision 45101)
+++ class.cs	(working copy)
@@ -5983,7 +5983,7 @@
 			{
 				if (a.Target == AttributeTargets.Parameter) {
 					if (param_attr == null)
-						param_attr = new ImplicitParameter (method_data.MethodBuilder);
+						param_attr = new ImplicitParameter (method_data.MethodBuilder, method.Location);
 
 					param_attr.ApplyAttributeBuilder (a, cb);
 					return;
@@ -5995,8 +5995,8 @@
 			protected virtual InternalParameters GetParameterInfo (EmitContext ec)
 			{
 				Parameter [] parms = new Parameter [1];
-				parms [0] = new Parameter (method.Type, "value", Parameter.Modifier.NONE, null);
-				Parameters parameters = new Parameters (parms, null, method.Location);
+				parms [0] = new Parameter (method.Type, "value", Parameter.Modifier.NONE, null, method.Location);
+				Parameters parameters = new Parameters (parms, null);
 
 				bool old_unsafe = ec.InUnsafe;
 				ec.InUnsafe = InUnsafe;
@@ -6781,7 +6781,7 @@
 			{
 				if (a.Target == AttributeTargets.Parameter) {
 					if (param_attr == null)
-						param_attr = new ImplicitParameter (method_data.MethodBuilder);
+						param_attr = new ImplicitParameter (method_data.MethodBuilder, method.Location);
 
 					param_attr.ApplyAttributeBuilder (a, cb);
 					return;
@@ -6965,8 +6965,8 @@
 			ec.InUnsafe = InUnsafe;
 
 			Parameter [] parms = new Parameter [1];
-			parms [0] = new Parameter (Type, "value", Parameter.Modifier.NONE, null);
-			Parameters parameters = new Parameters (parms, null, Location);
+			parms [0] = new Parameter (Type, "value", Parameter.Modifier.NONE, null, Location);
+			Parameters parameters = new Parameters (parms, null);
 			Type [] types = parameters.GetParameterInfo (ec);
 			InternalParameters ip = new InternalParameters (types, parameters);
 
@@ -7130,9 +7130,9 @@
 
 				fixed_parms.CopyTo (tmp, 0);
 				tmp [fixed_parms.Length] = new Parameter (
-					method.Type, "value", Parameter.Modifier.NONE, null);
+					method.Type, "value", Parameter.Modifier.NONE, null, method.Location);
 
-				Parameters set_formal_params = new Parameters (tmp, null, method.Location);
+				Parameters set_formal_params = new Parameters (tmp, null);
 				Type [] types = set_formal_params.GetParameterInfo (ec);
 				
 				return new InternalParameters (types, set_formal_params);
Index: delegate.cs
===================================================================
--- delegate.cs	(revision 45101)
+++ delegate.cs	(working copy)
@@ -146,10 +146,10 @@
 			// FIXME: POSSIBLY make these static, as they are always the same
 			Parameter [] fixed_pars = new Parameter [2];
 			fixed_pars [0] = new Parameter (TypeManager.system_object_expr, "object",
-							Parameter.Modifier.NONE, null);
+							Parameter.Modifier.NONE, null, Location);
 			fixed_pars [1] = new Parameter (TypeManager.system_intptr_expr, "method", 
-							Parameter.Modifier.NONE, null);
-			Parameters const_parameters = new Parameters (fixed_pars, null, Location);
+							Parameter.Modifier.NONE, null, Location);
+			Parameters const_parameters = new Parameters (fixed_pars, null);
 			
 			TypeManager.RegisterMethod (
 				ConstructorBuilder,
@@ -324,12 +324,12 @@
 			
 			async_params [params_num] = new Parameter (
 				TypeManager.system_asynccallback_expr, "callback",
-								   Parameter.Modifier.NONE, null);
+								   Parameter.Modifier.NONE, null, Location);
 			async_params [params_num + 1] = new Parameter (
 				TypeManager.system_object_expr, "object",
-								   Parameter.Modifier.NONE, null);
+								   Parameter.Modifier.NONE, null, Location);
 
-			Parameters async_parameters = new Parameters (async_params, null, Location);
+			Parameters async_parameters = new Parameters (async_params, null);
 
 			TypeManager.RegisterMethod (BeginInvokeBuilder,
 						    new InternalParameters (async_parameters.GetParameterInfo (ec), async_parameters),
@@ -356,7 +356,7 @@
 				}
 			}
 			end_param_types [out_params] = TypeManager.iasyncresult_type;
-			end_params [out_params] = new Parameter (TypeManager.system_iasyncresult_expr, "result", Parameter.Modifier.NONE, null);
+			end_params [out_params] = new Parameter (TypeManager.system_iasyncresult_expr, "result", Parameter.Modifier.NONE, null, Location);
 
 			//
 			// Create method, define parameters, register parameters with type system
@@ -372,7 +372,7 @@
 				EndInvokeBuilder.DefineParameter (i + 1, end_params [i].Attributes, end_params [i].Name);
 			}
 
-			Parameters end_parameters = new Parameters (end_params, null, Location);
+			Parameters end_parameters = new Parameters (end_params, null);
 
 			TypeManager.RegisterMethod (
 				EndInvokeBuilder,
Index: iterators.cs
===================================================================
--- iterators.cs	(revision 45101)
+++ iterators.cs	(working copy)
@@ -517,10 +517,11 @@
 			if (!is_static)
 				list.Add (new Parameter (
 					new TypeExpression (container.TypeBuilder, Location),
-					"this", Parameter.Modifier.NONE, null));
+					"this", Parameter.Modifier.NONE,
+					null, Location));
 			list.Add (new Parameter (
 				TypeManager.system_boolean_expr, "initialized",
-				Parameter.Modifier.NONE, null));
+				Parameter.Modifier.NONE, null, Location));
 
 			Parameter[] old_fixed = parameters.Parameters.FixedParameters;
 			if (old_fixed != null)
@@ -530,8 +531,7 @@
 			list.CopyTo (fixed_params);
 
 			ctor_params = new Parameters (
-				fixed_params, parameters.Parameters.ArrayParameter,
-				Location);
+				fixed_params, parameters.Parameters.ArrayParameter);
 
 			Constructor ctor = new Constructor (
 				this, Name, Modifiers.PUBLIC, ctor_params,
Index: cs-parser.jay
===================================================================
--- cs-parser.jay	(revision 45101)
+++ cs-parser.jay	(working copy)
@@ -1135,7 +1135,7 @@
 		Parameter [] pars = new Parameter [pars_list.Count];
 		pars_list.CopyTo (pars);
 
-	  	$$ = new Parameters (pars, null, lexer.Location); 
+	  	$$ = new Parameters (pars, null); 
 	  } 
 	| fixed_parameters COMMA parameter_array
 	  {
@@ -1144,7 +1144,7 @@
 		Parameter [] pars = new Parameter [pars_list.Count];
 		pars_list.CopyTo (pars);
 
-		$$ = new Parameters (pars, (Parameter) $3, lexer.Location); 
+		$$ = new Parameters (pars, (Parameter) $3); 
 	  }
 	| fixed_parameters COMMA ARGLIST
 	  {
@@ -1153,7 +1153,7 @@
 		Parameter [] pars = new Parameter [pars_list.Count];
 		pars_list.CopyTo (pars);
 
-		$$ = new Parameters (pars, true, lexer.Location);
+		$$ = new Parameters (pars, true);
 	  }
 	| parameter_array COMMA fixed_parameters
 	  {
@@ -1167,11 +1167,11 @@
 	  }
 	| parameter_array 
 	  {
-		$$ = new Parameters (null, (Parameter) $1, lexer.Location);
+		$$ = new Parameters (null, (Parameter) $1);
 	  }
 	| ARGLIST
 	  {
-		$$ = new Parameters (null, true, lexer.Location);
+		$$ = new Parameters (null, true);
 	  }
 	;
 
@@ -1198,7 +1198,7 @@
 	  type
 	  IDENTIFIER
 	  {
-		$$ = new Parameter ((Expression) $3, (string) $4, (Parameter.Modifier) $2, (Attributes) $1);
+		$$ = new Parameter ((Expression) $3, (string) $4, (Parameter.Modifier) $2, (Attributes) $1, lexer.Location);
 	  }
 	| opt_attributes
 	  opt_parameter_modifier
@@ -1247,7 +1247,7 @@
 parameter_array
 	: opt_attributes PARAMS type IDENTIFIER
 	  { 
-		$$ = new Parameter ((Expression) $3, (string) $4, Parameter.Modifier.PARAMS, (Attributes) $1);
+		$$ = new Parameter ((Expression) $3, (string) $4, Parameter.Modifier.PARAMS, (Attributes) $1, lexer.Location);
 		note ("type must be a single-dimension array type"); 
 	  }
 	| opt_attributes PARAMS parameter_modifier type IDENTIFIER 
@@ -1375,12 +1375,12 @@
 		Parameter [] args;
 		Parameter implicit_value_parameter = new Parameter (
 			implicit_value_parameter_type, "value", 
-			Parameter.Modifier.NONE, null);
+			Parameter.Modifier.NONE, null, lexer.Location);
 
 		if (parsing_indexer == false) {
 			args  = new Parameter [1];
 			args [0] = implicit_value_parameter;
-			current_local_parameters = new Parameters (args, null, lexer.Location);
+			current_local_parameters = new Parameters (args, null);
 		} else {
 			Parameter [] fpars = indexer_parameters.FixedParameters;
 
@@ -1393,7 +1393,7 @@
 			} else 
 				args = null;
 			current_local_parameters = new Parameters (
-				args, indexer_parameters.ArrayParameter, lexer.Location);
+				args, indexer_parameters.ArrayParameter);
 		}
 		
 		lexer.PropertyParsing = false;
@@ -1727,13 +1727,13 @@
 		
 		Parameter [] param_list = new Parameter [decl.arg2type != null ? 2 : 1];
 
-		param_list[0] = new Parameter (decl.arg1type, decl.arg1name, Parameter.Modifier.NONE, null);
+		param_list[0] = new Parameter (decl.arg1type, decl.arg1name, Parameter.Modifier.NONE, null, decl.location);
 		if (decl.arg2type != null)
-			param_list[1] = new Parameter (decl.arg2type, decl.arg2name, Parameter.Modifier.NONE, null);
+			param_list[1] = new Parameter (decl.arg2type, decl.arg2name, Parameter.Modifier.NONE, null, decl.location);
 
 		Operator op = new Operator (
 			current_class, decl.optype, decl.ret_type, (int) $2, 
-			new Parameters (param_list, null, decl.location),
+			new Parameters (param_list, null),
 			(ToplevelBlock) $5, (Attributes) $1, decl.location);
 
 		if (RootContext.Documentation != null) {
@@ -1772,9 +1772,9 @@
 		Parameter [] pars = new Parameter [1];
 		Expression type = (Expression) $5;
 
-		pars [0] = new Parameter (type, (string) $6, Parameter.Modifier.NONE, null);
+		pars [0] = new Parameter (type, (string) $6, Parameter.Modifier.NONE, null, lexer.Location);
 
-		current_local_parameters = new Parameters (pars, null, lexer.Location);
+		current_local_parameters = new Parameters (pars, null);
 
 		if (RootContext.Documentation != null) {
 			tmpComment = Lexer.consume_doc_comment ();
@@ -1797,10 +1797,10 @@
 		Expression typeL = (Expression) $5;
 		Expression typeR = (Expression) $8;
 
-	       pars [0] = new Parameter (typeL, (string) $6, Parameter.Modifier.NONE, null);
-	       pars [1] = new Parameter (typeR, (string) $9, Parameter.Modifier.NONE, null);
+	       pars [0] = new Parameter (typeL, (string) $6, Parameter.Modifier.NONE, null, lexer.Location);
+	       pars [1] = new Parameter (typeR, (string) $9, Parameter.Modifier.NONE, null, lexer.Location);
 
-	       current_local_parameters = new Parameters (pars, null, lexer.Location);
+	       current_local_parameters = new Parameters (pars, null);
 
 		if (RootContext.Documentation != null) {
 			tmpComment = Lexer.consume_doc_comment ();
@@ -1863,9 +1863,9 @@
 	  {
 		Parameter [] pars = new Parameter [1];
 
-		pars [0] = new Parameter ((Expression) $5, (string) $6, Parameter.Modifier.NONE, null);
+		pars [0] = new Parameter ((Expression) $5, (string) $6, Parameter.Modifier.NONE, null, lexer.Location);
 
-		current_local_parameters = new Parameters (pars, null, lexer.Location);  
+		current_local_parameters = new Parameters (pars, null);  
 		  
 		if (RootContext.Documentation != null) {
 			tmpComment = Lexer.consume_doc_comment ();
@@ -1879,9 +1879,9 @@
 	  {
 		Parameter [] pars = new Parameter [1];
 
-		pars [0] = new Parameter ((Expression) $5, (string) $6, Parameter.Modifier.NONE, null);
+		pars [0] = new Parameter ((Expression) $5, (string) $6, Parameter.Modifier.NONE, null, lexer.Location);
 
-		current_local_parameters = new Parameters (pars, null, lexer.Location);  
+		current_local_parameters = new Parameters (pars, null);  
 		  
 		if (RootContext.Documentation != null) {
 			tmpComment = Lexer.consume_doc_comment ();
@@ -2036,7 +2036,7 @@
                         
 			Method d = new Destructor (
 				current_class, TypeManager.system_void_expr, m, "Finalize", 
-				new Parameters (null, null, l), (Attributes) $1, l);
+				new Parameters (null, null), (Attributes) $1, l);
 			if (RootContext.Documentation != null)
 				d.DocComment = ConsumeStoredComment ();
 		  
@@ -2143,11 +2143,11 @@
 		Parameter [] args = new Parameter [1];
 		Parameter implicit_value_parameter = new Parameter (
 			implicit_value_parameter_type, "value", 
-			Parameter.Modifier.NONE, null);
+			Parameter.Modifier.NONE, null, lexer.Location);
 
 		args [0] = implicit_value_parameter;
 		
-		current_local_parameters = new Parameters (args, null, lexer.Location);  
+		current_local_parameters = new Parameters (args, null);  
 		lexer.EventParsing = false;
 	  }
           block
@@ -2171,11 +2171,11 @@
 		Parameter [] args = new Parameter [1];
 		Parameter implicit_value_parameter = new Parameter (
 			implicit_value_parameter_type, "value", 
-			Parameter.Modifier.NONE, null);
+			Parameter.Modifier.NONE, null, lexer.Location);
 
 		args [0] = implicit_value_parameter;
 		
-		current_local_parameters = new Parameters (args, null, lexer.Location);  
+		current_local_parameters = new Parameters (args, null);  
 		lexer.EventParsing = false;
 	  }
           block
@@ -3047,7 +3047,7 @@
 			ArrayList par_list = (ArrayList) $2;
 			Parameter [] pars = new Parameter [par_list.Count];
 			par_list.CopyTo (pars);
-			$$ = new Parameters (pars, null, lexer.Location);
+			$$ = new Parameters (pars, null);
 		}
 	  }
 	;
@@ -3074,7 +3074,7 @@
 
 anonymous_method_parameter
 	: opt_parameter_modifier type IDENTIFIER {
-		$$ = new Parameter ((Expression) $2, (string) $3, (Parameter.Modifier) $1, null);
+		$$ = new Parameter ((Expression) $2, (string) $3, (Parameter.Modifier) $1, null, lexer.Location);
 	  }
 	| PARAMS type IDENTIFIER {
 		Report.Error (1670, lexer.Location, "params modifier not allowed in anonymous method declaration");
Index: anonymous.cs
===================================================================
--- anonymous.cs	(revision 45101)
+++ anonymous.cs	(working copy)
@@ -186,7 +186,7 @@
 						continue;
 					fixedpars [j] = new Parameter (
 						new TypeExpression (invoke_pd.ParameterType (i), loc),
-						"+" + j, invoke_pd.ParameterModifier (i), null);
+						"+" + j, invoke_pd.ParameterModifier (i), null, loc);
 					j++;
 				}
 				
@@ -194,10 +194,10 @@
 				if (params_idx != -1){
 					variable = new Parameter (
 						new TypeExpression (invoke_pd.ParameterType (params_idx), loc),
-						"+" + params_idx, invoke_pd.ParameterModifier (params_idx), null);
+						"+" + params_idx, invoke_pd.ParameterModifier (params_idx), null, loc);
 				}
 
-				Parameters = new Parameters (fixedpars, variable, loc);
+				Parameters = new Parameters (fixedpars, variable);
 			}
 			
 			//
Index: statement.cs
===================================================================
--- statement.cs	(revision 45101)
+++ statement.cs	(working copy)
@@ -1574,7 +1574,7 @@
 			int idx;
 			Parameter p = Toplevel.Parameters.GetParameterByName (name, out idx);
 			if (p != null) {
-				Report.SymbolRelatedToPreviousError (Toplevel.Parameters.Location, name);
+				Report.SymbolRelatedToPreviousError (p.Location, name);
 				Report.Error (136, l, "'{0}' hides a method parameter", name);
 				return null;
 			}