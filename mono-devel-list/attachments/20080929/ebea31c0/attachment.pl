--- CodeOr.cs	2008-09-29 08:57:34.281250000 +0200
+++ ..\Mono.CodeGeneration patched/CodeOr.cs	2008-09-29 09:23:14.328125000 +0200
@@ -69,7 +69,6 @@
 		public override void GenerateForBranch(ILGenerator gen, Label label, bool branchCase)
 		{
 			Label endLabel = gen.DefineLabel();
-			exp1.Generate(gen);
 
 			if (exp1 is CodeConditionExpression)
 			{
