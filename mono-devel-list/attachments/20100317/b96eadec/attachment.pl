Index: ilasm/Driver.cs
===================================================================
--- ilasm/Driver.cs	(revision 153715)
+++ ilasm/Driver.cs	(working copy)
@@ -20,6 +20,8 @@
 
         public class Driver {
 
+				internal static bool opt_ldc = false;
+		
                 enum Target {
                         Dll,
                         Exe
@@ -270,6 +272,10 @@
 						else
 							keyname = command_arg;
 						break;
+                                        case "opt":
+						if ("ldc" == command_arg)
+							Driver.opt_ldc = true;
+						break;
                                         case "scan_only":
                                                 scan_only = true;
                                                 break;
@@ -344,6 +350,7 @@
                                         "   /exe               Compile to executable.\n" +
                                         "   /dll               Compile to library.\n" +
                                         "   /debug             Include debug information.\n" +
+                                        "   /opt:ldc           Optimize ldc instructions (use shorter forms when possible).\n" +
 					"   /key:keyfile       Strongname using the specified key file\n" +
 					"   /key:@container    Strongname using the specified key container\n" +
                                         "Options can be of the form -option or /option\n");
Index: ilasm/codegen/IntInstr.cs
===================================================================
--- ilasm/codegen/IntInstr.cs	(revision 153715)
+++ ilasm/codegen/IntInstr.cs	(working copy)
@@ -27,9 +27,35 @@
                 public override void Emit (CodeGen code_gen, MethodDef meth,
 					   PEAPI.CILInstructions cil)
                 {
-                        cil.IntInst (op, operand);
-                }
+			if (Driver.opt_ldc && op == PEAPI.IntOp.ldc_i4) {
+				if (operand >= -1 && operand <= 8)
+					cil.Inst (getOptLdcOp (operand));
+				else if (operand >= -128 && operand <= 127)
+					cil.IntInst (PEAPI.IntOp.ldc_i4_s,
+						operand);
+                		else
+					cil.IntInst (op, operand);
+			} else
+				cil.IntInst (op, operand);
+		}
 
+		private PEAPI.Op getOptLdcOp (int operand)
+		{
+			switch (operand) {
+			case -1: return PEAPI.Op.ldc_i4_m1;
+			case 0:  return PEAPI.Op.ldc_i4_0;
+			case 1:  return PEAPI.Op.ldc_i4_1;
+			case 2:  return PEAPI.Op.ldc_i4_2;
+			case 3:  return PEAPI.Op.ldc_i4_3;
+			case 4:  return PEAPI.Op.ldc_i4_4;
+			case 5:  return PEAPI.Op.ldc_i4_5;
+			case 6:  return PEAPI.Op.ldc_i4_6;
+			case 7:  return PEAPI.Op.ldc_i4_7;
+			case 8:  return PEAPI.Op.ldc_i4_8;
+			default:
+				throw new ArgumentOutOfRangeException ("operand");
+			}
+		}
         }
 
 }
