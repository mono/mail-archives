Index: rules/Gendarme.Rules.Exceptions/DontDestroyStackTrace.cs
===================================================================
--- rules/Gendarme.Rules.Exceptions/DontDestroyStackTrace.cs	(revision 63746)
+++ rules/Gendarme.Rules.Exceptions/DontDestroyStackTrace.cs	(working copy)
@@ -161,10 +161,16 @@
 			case StackBehaviour.Popref_popi_popref:
 				return 3;
 			case StackBehaviour.Varpop:
-				// We have to determine from the call how many arguments will
-				// be popped from the stack
-				MethodReference callMethod = (MethodReference)instr.Operand;
-				return callMethod.Parameters.Count;
+				if(instr.Operand is MethodReference) {
+					// We have to determine from the call how many arguments will
+					// be popped from the stack
+					MethodReference callMethod = (MethodReference)instr.Operand;
+					return callMethod.Parameters.Count;
+				} else {
+					throw new InvalidOperationException("Unexpected instruction: '" + 
+					instr.OpCode.ToString() + "' at offset 0x" + 
+					instr.Offset.ToString("X"));
+				}
 			}
 			
 			return 0;
