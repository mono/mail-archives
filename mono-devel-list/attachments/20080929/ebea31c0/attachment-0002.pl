--- CodeLiteral.cs	2008-09-29 08:57:40.250000000 +0200
+++ ..\Mono.CodeGeneration patched/CodeLiteral.cs	2008-09-29 09:24:22.515625000 +0200
@@ -82,7 +82,7 @@
 				case TypeCode.UInt16:
 				case TypeCode.Int32:
 				case TypeCode.UInt32:
-					int i = (int)value;
+					int i = Convert.ToInt(value); // Old code was ("int)value;" and was crashing when value was boxed.
 					switch (i)
 					{
 						case 0: gen.Emit(OpCodes.Ldc_I4_0); break;
