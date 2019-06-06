Index: Driver.cs
===================================================================
--- Driver.cs	(revision 153715)
+++ Driver.cs	(working copy)
@@ -20,6 +20,8 @@
 
         public class Driver {
 
+		internal static bool src_debug_info = false;
+
                 enum Target {
                         Dll,
                         Exe
@@ -251,6 +253,10 @@
                                         case "deb":
 						debugging_info = true;
 						break;
+					case "src-debug":
+						src_debug_info = true;
+						debugging_info = true;
+						break;
                                         // Stubs to stay commandline compatible with MS 
                                         case "listing":
                                         case "nologo":
@@ -344,6 +350,9 @@
                                         "   /exe               Compile to executable.\n" +
                                         "   /dll               Compile to library.\n" +
                                         "   /debug             Include debug information.\n" +
+					"   /src-debug         Include debug information from source; this assumes that.\n" + 
+					"                      the input assembly code holds debug information. This option\n" +
+					"                      implies /debug\n" +
 					"   /key:keyfile       Strongname using the specified key file\n" +
 					"   /key:@container    Strongname using the specified key container\n" +
                                         "Options can be of the form -option or /option\n");
Index: scanner/Location.cs
===================================================================
--- scanner/Location.cs	(revision 153715)
+++ scanner/Location.cs	(working copy)
@@ -11,22 +11,40 @@
 	public class Location : ICloneable {
 		internal int line;
 		internal int column;
+		internal string file;
 
+		public string File {
+			get { return file; }
+		}
 
+
 		/// <summary>
 		/// </summary>
 		public static readonly Location Unknown = new Location (-1, -1);
 
 		/// <summary>
 		/// </summary>
-		public Location () {
+		public Location ()
+		{
 			line = 1;
 			column = 1;
+			file = null;
 		}
 
 		/// <summary>
 		/// </summary>
 		/// <param name="line"></param>
+		public Location (int line)
+		{
+			this.line = line;
+			column = 1;
+			file = null;
+		}
+
+	
+		/// <summary>
+		/// </summary>
+		/// <param name="line"></param>
 		/// <param name="column"></param>
 		public Location (int line, int column)
 		{
@@ -37,11 +55,43 @@
 
 		/// <summary>
 		/// </summary>
+		/// <param name="line"></param>
+		/// <param name="column"></param>
+		/// <param name="file"></param>
+		public Location (int line, int column, string file)
+		{
+			this.line = line;
+			this.column = column;
+			this.file = file;
+		}
+
+		/// <summary>
+		/// </summary>
+		/// <param name="line"></param>
+		/// <param name="file"></param>
+		public Location (int line, string file)
+		{
+			this.line = line;
+			this.column = 1;
+			this.file = file;
+		}
+
+
+
+
+
+
+
+
+	
+		/// <summary>
+		/// </summary>
 		/// <param name="that"></param>
 		public Location (Location that)
 		{
 			this.line = that.line;
 			this.column = that.column;
+			this.file = that.file;
 		}
 
 
@@ -85,6 +135,7 @@
 		{
 			this.line = other.line;
 			this.column = other.column;
+			this.file = other.file;
 		}
 
 
@@ -97,7 +148,8 @@
 
 		public override string ToString ()
 		{
-			return "line (" + line + ") column (" + column + ")";
+			return (file != null ? "file (" + file + ") " : "")
+				+"line (" + line + ") column (" + column + ")";
 		}
 	}
 }
Index: parser/ILParser.jay
===================================================================
--- parser/ILParser.jay	(revision 153715)
+++ parser/ILParser.jay	(working copy)
@@ -33,6 +33,20 @@
                 private ILTokenizer tokenizer;
 		static int yacc_verbose_flag;
 
+		private Location extsrc_location = Location.Unknown;
+
+		private Location SrcLocation {
+			get {
+				if (Driver.src_debug_info)
+					return extsrc_location;
+				else
+					return tokenizer.Location;
+			}
+			set { 
+				extsrc_location = value;
+			}
+		}
+
                 class NameValuePair {
                         public string Name;
                         public object Value;
@@ -535,9 +549,41 @@
 			;
 
 extsource_spec		: D_LINE int32 SQSTRING
+                          {
+				if (Driver.src_debug_info) {
+					string curfile = extsrc_location.File;
+					string newfile = (string) $3;
+					if (newfile != curfile) {
+						codegen.EndSourceFile ();
+						codegen.BeginSourceFile (newfile);
+					}
+					SrcLocation = new Location ((int) $2, newfile);
+				}
+                          }
 			| D_LINE int32
+                          {
+				if (Driver.src_debug_info) {
+					SrcLocation = new Location ((int) $2);
+				}
+                          }
 			| D_LINE int32 COLON int32 SQSTRING
+                          {
+				if (Driver.src_debug_info) {
+					string curfile = extsrc_location.File;
+					string newfile = (string) $5;
+					if (newfile != curfile) {
+						codegen.EndSourceFile ();
+						codegen.BeginSourceFile (newfile);
+					}
+					SrcLocation = new Location ((int) $2, (int) $4, newfile);
+				}
+                          }
 			| D_LINE int32 COLON int32
+                          {
+				if (Driver.src_debug_info) {
+					SrcLocation = new Location ((int) $2, (int) $4);
+				}
+                          }
 			;
 
 language_decl		: D_LANGUAGE SQSTRING
@@ -1863,7 +1909,7 @@
 
 method_all		: method_head OPEN_BRACE method_decls CLOSE_BRACE
                           {
-                                codegen.EndMethodDef (tokenizer.Location);
+                                codegen.EndMethodDef (SrcLocation);
                           }
 			;
 
@@ -1877,7 +1923,7 @@
                                 MethodDef methdef = new MethodDef (
                                         codegen, (MethAttr) $2, cc,
                                         (ImplAttr) $11, (string) $6, (BaseTypeRef) $5,
-                                        (ArrayList) $9, tokenizer.Reader.Location, (GenericParameters) $7, codegen.CurrentTypeDef);
+                                        (ArrayList) $9, SrcLocation, (GenericParameters) $7, codegen.CurrentTypeDef);
                                 if (pinvoke_info) {
                                         ExternModule mod = codegen.ExternTable.AddModule (pinvoke_mod);
                                         methdef.AddPInvokeInfo (pinvoke_attr, mod, pinvoke_meth);
@@ -1891,7 +1937,7 @@
                                 MethodDef methdef = new MethodDef (
                               		codegen, (MethAttr) $2, (CallConv) $3,
                                         (ImplAttr) $14, (string) $10, (BaseTypeRef) $5,
-                                        (ArrayList) $12, tokenizer.Reader.Location, null, codegen.CurrentTypeDef);
+                                        (ArrayList) $12, SrcLocation, null, codegen.CurrentTypeDef);
 
                                 if (pinvoke_info) {
                                         ExternModule mod = codegen.ExternTable.AddModule (pinvoke_mod);
@@ -2079,7 +2125,7 @@
 method_decl		: D_EMITBYTE int32
 						{
 							codegen.CurrentMethodDef.AddInstr (new
-                                        EmitByteInstr ((int) $2, tokenizer.Location));
+                                        EmitByteInstr ((int) $2, SrcLocation));
                           
 						}
 			| D_MAXSTACK int32
@@ -2271,21 +2317,21 @@
 
 try_block		: D_TRY scope_block
                           {
-                                $$ = new TryBlock ((HandlerBlock) $2, tokenizer.Location);
+                                $$ = new TryBlock ((HandlerBlock) $2, SrcLocation);
                           }
 			| D_TRY id K_TO id
                           {
 				LabelInfo from = codegen.CurrentMethodDef.AddLabelRef ((string) $2);
 				LabelInfo to = codegen.CurrentMethodDef.AddLabelRef ((string) $4);
 				
-                                $$ = new TryBlock (new HandlerBlock (from, to), tokenizer.Location);
+                                $$ = new TryBlock (new HandlerBlock (from, to), SrcLocation);
                           }
 			| D_TRY int32 K_TO int32
 			  {
 				LabelInfo from = codegen.CurrentMethodDef.AddLabel ((int) $2);
 				LabelInfo to = codegen.CurrentMethodDef.AddLabel ((int) $4);
 				
-				$$ = new TryBlock (new HandlerBlock (from, to), tokenizer.Location);
+				$$ = new TryBlock (new HandlerBlock (from, to), SrcLocation);
 			  }
 			;
 
@@ -2374,12 +2420,12 @@
 instr			: INSTR_NONE
                           {
                                 codegen.CurrentMethodDef.AddInstr (
-                                        new SimpInstr ((Op) $1, tokenizer.Location));
+                                        new SimpInstr ((Op) $1, SrcLocation));
                           }
 			| INSTR_LOCAL int32
                           {
                                 codegen.CurrentMethodDef.AddInstr (
-                                        new IntInstr ((IntOp) $1, (int) $2, tokenizer.Location));        
+                                        new IntInstr ((IntOp) $1, (int) $2, SrcLocation));        
                           }
                         | INSTR_LOCAL id
                           {
@@ -2387,12 +2433,12 @@
                                 if (slot < 0)
                                         Report.Error (String.Format ("Undeclared identifier '{0}'", (string) $2));
                                 codegen.CurrentMethodDef.AddInstr (
-                                        new IntInstr ((IntOp) $1, slot, tokenizer.Location));
+                                        new IntInstr ((IntOp) $1, slot, SrcLocation));
                           }
                         | INSTR_PARAM int32
                           {
                                 codegen.CurrentMethodDef.AddInstr (
-                                        new IntInstr ((IntOp) $1, (int) $2, tokenizer.Location));
+                                        new IntInstr ((IntOp) $1, (int) $2, SrcLocation));
                           }
                         | INSTR_PARAM id
                           {
@@ -2401,12 +2447,12 @@
                                         Report.Error (String.Format ("Undeclared identifier '{0}'", (string) $2));
 
                                 codegen.CurrentMethodDef.AddInstr (
-                                        new IntInstr ((IntOp) $1, pos, tokenizer.Location));
+                                        new IntInstr ((IntOp) $1, pos, SrcLocation));
                           }
 			| INSTR_I int32
                           {
                                 codegen.CurrentMethodDef.AddInstr (new
-                                        IntInstr ((IntOp) $1, (int) $2, tokenizer.Location));
+                                        IntInstr ((IntOp) $1, (int) $2, SrcLocation));
                           }
 			| INSTR_I id
                           {
@@ -2414,7 +2460,7 @@
                                 if (slot < 0)
                                         Report.Error (String.Format ("Undeclared identifier '{0}'", (string) $2));
                                 codegen.CurrentMethodDef.AddInstr (new
-                                        IntInstr ((IntOp) $1, slot, tokenizer.Location));
+                                        IntInstr ((IntOp) $1, slot, SrcLocation));
                           }
 			| INSTR_I8 int64
                           {
@@ -2422,7 +2468,7 @@
                                         switch ((MiscInstr) $1) {
                                         case MiscInstr.ldc_i8:
                                         codegen.CurrentMethodDef.AddInstr (new LdcInstr ((MiscInstr) $1,
-                                                (long) $2, tokenizer.Location));
+                                                (long) $2, SrcLocation));
                                         break;
                                         }
                                 }
@@ -2432,7 +2478,7 @@
                                 switch ((MiscInstr) $1) {
                                 case MiscInstr.ldc_r4:
                                 case MiscInstr.ldc_r8:
-                                         codegen.CurrentMethodDef.AddInstr (new LdcInstr ((MiscInstr) $1, (double) $2, tokenizer.Location));
+                                         codegen.CurrentMethodDef.AddInstr (new LdcInstr ((MiscInstr) $1, (double) $2, SrcLocation));
                                          break;
                                 }
                           }
@@ -2443,7 +2489,7 @@
                                 switch ((MiscInstr) $1) {
                                         case MiscInstr.ldc_r4:
                                         case MiscInstr.ldc_r8:
-                                        codegen.CurrentMethodDef.AddInstr (new LdcInstr ((MiscInstr) $1, (double) l, tokenizer.Location));
+                                        codegen.CurrentMethodDef.AddInstr (new LdcInstr ((MiscInstr) $1, (double) l, SrcLocation));
                                         break;
                                 }
                           }
@@ -2457,7 +2503,7 @@
 							System.Array.Reverse (fpdata, 0, 4);
 						}
                                                 float s = BitConverter.ToSingle (fpdata, 0);
-                                                codegen.CurrentMethodDef.AddInstr (new LdcInstr ((MiscInstr) $1, s, tokenizer.Location));
+                                                codegen.CurrentMethodDef.AddInstr (new LdcInstr ((MiscInstr) $1, s, SrcLocation));
                                                 break;
                                         case MiscInstr.ldc_r8:
 						fpdata = (byte []) $2;
@@ -2466,7 +2512,7 @@
 							System.Array.Reverse (fpdata, 0, 8);
 						}
                                                 double d = BitConverter.ToDouble (fpdata, 0);
-                                                codegen.CurrentMethodDef.AddInstr (new LdcInstr ((MiscInstr) $1, d, tokenizer.Location));
+                                                codegen.CurrentMethodDef.AddInstr (new LdcInstr ((MiscInstr) $1, d, SrcLocation));
                                                 break;
                                 }
                           }
@@ -2474,18 +2520,18 @@
                           {
 				LabelInfo target = codegen.CurrentMethodDef.AddLabel ((int) $2);
                                 codegen.CurrentMethodDef.AddInstr (new BranchInstr ((BranchOp) $1,
-								   target, tokenizer.Location));  
+								   target, SrcLocation));  
                           }
 			| INSTR_BRTARGET id
                           {
 				LabelInfo target = codegen.CurrentMethodDef.AddLabelRef ((string) $2);
                                 codegen.CurrentMethodDef.AddInstr (new BranchInstr ((BranchOp) $1,
-                                        			   target, tokenizer.Location));
+                                        			   target, SrcLocation));
                           }
 			| INSTR_METHOD method_ref
                           {
                                 codegen.CurrentMethodDef.AddInstr (new MethodInstr ((MethodOp) $1,
-                                        (BaseMethodRef) $2, tokenizer.Location));
+                                        (BaseMethodRef) $2, SrcLocation));
                           }
 			| INSTR_FIELD type type_spec DOUBLE_COLON id
                           {
@@ -2497,35 +2543,35 @@
                                 IFieldRef fieldref = owner.GetFieldRef (
                                         (BaseTypeRef) $2, (string) $5);
 
-                                codegen.CurrentMethodDef.AddInstr (new FieldInstr ((FieldOp) $1, fieldref, tokenizer.Location));
+                                codegen.CurrentMethodDef.AddInstr (new FieldInstr ((FieldOp) $1, fieldref, SrcLocation));
                           }
 			| INSTR_FIELD type id
                           {
                                 GlobalFieldRef fieldref = codegen.GetGlobalFieldRef ((BaseTypeRef) $2, (string) $3);
 
-                                codegen.CurrentMethodDef.AddInstr (new FieldInstr ((FieldOp) $1, fieldref, tokenizer.Location));
+                                codegen.CurrentMethodDef.AddInstr (new FieldInstr ((FieldOp) $1, fieldref, SrcLocation));
                           }
 			| INSTR_TYPE type_spec
                           {
                                 codegen.CurrentMethodDef.AddInstr (new TypeInstr ((TypeOp) $1,
-                                        (BaseTypeRef) $2, tokenizer.Location));
+                                        (BaseTypeRef) $2, SrcLocation));
                           }
 			| INSTR_STRING comp_qstring
                           {
                                 if ((MiscInstr) $1 == MiscInstr.ldstr)
-                                        codegen.CurrentMethodDef.AddInstr (new LdstrInstr ((string) $2, tokenizer.Location));
+                                        codegen.CurrentMethodDef.AddInstr (new LdstrInstr ((string) $2, SrcLocation));
                           }
 			| INSTR_STRING K_BYTEARRAY ASSIGN bytes_list
                           {
                                 byte[] bs = (byte[]) $4;
                                 if ((MiscInstr) $1 == MiscInstr.ldstr)
-                                        codegen.CurrentMethodDef.AddInstr (new LdstrInstr (bs, tokenizer.Location));
+                                        codegen.CurrentMethodDef.AddInstr (new LdstrInstr (bs, SrcLocation));
                           }
 			| INSTR_STRING K_BYTEARRAY bytes_list
                           {
                                 byte[] bs = (byte[]) $3;
                                 if ((MiscInstr) $1 == MiscInstr.ldstr)
-                                        codegen.CurrentMethodDef.AddInstr (new LdstrInstr (bs, tokenizer.Location));
+                                        codegen.CurrentMethodDef.AddInstr (new LdstrInstr (bs, SrcLocation));
                           }
 			| INSTR_SIG call_conv type OPEN_PARENS type_list CLOSE_PARENS
                           {
@@ -2536,23 +2582,23 @@
                                         arg_array = (BaseTypeRef[]) arg_list.ToArray (typeof (BaseTypeRef));
 
                                 codegen.CurrentMethodDef.AddInstr (new CalliInstr ((CallConv) $2,
-                                        (BaseTypeRef) $3, arg_array, tokenizer.Location));
+                                        (BaseTypeRef) $3, arg_array, SrcLocation));
                           }     
 			| INSTR_TOK owner_type
                           {
                                 if ((MiscInstr) $1 == MiscInstr.ldtoken) {
                                         if ($2 is BaseMethodRef)
-                                                codegen.CurrentMethodDef.AddInstr (new LdtokenInstr ((BaseMethodRef) $2, tokenizer.Location));
+                                                codegen.CurrentMethodDef.AddInstr (new LdtokenInstr ((BaseMethodRef) $2, SrcLocation));
                                         else if ($2 is IFieldRef)
-                                                codegen.CurrentMethodDef.AddInstr (new LdtokenInstr ((IFieldRef) $2, tokenizer.Location));
+                                                codegen.CurrentMethodDef.AddInstr (new LdtokenInstr ((IFieldRef) $2, SrcLocation));
                                         else
-                                                codegen.CurrentMethodDef.AddInstr (new LdtokenInstr ((BaseTypeRef) $2, tokenizer.Location));
+                                                codegen.CurrentMethodDef.AddInstr (new LdtokenInstr ((BaseTypeRef) $2, SrcLocation));
                                                 
                                 }
                           }
 			| INSTR_SWITCH OPEN_PARENS labels CLOSE_PARENS
                           {
-                                codegen.CurrentMethodDef.AddInstr (new SwitchInstr ((ArrayList) $3, tokenizer.Location));
+                                codegen.CurrentMethodDef.AddInstr (new SwitchInstr ((ArrayList) $3, SrcLocation));
                           }
 			;
 