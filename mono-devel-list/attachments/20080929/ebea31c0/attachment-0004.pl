--- CodeAnd.cs	2008-09-29 08:58:01.750000000 +0200
+++ ..\Mono.CodeGeneration patched/CodeAnd.cs	2008-09-29 09:22:28.312500000 +0200
@@ -70,7 +70,6 @@
 		public override void GenerateForBranch(ILGenerator gen, Label label, bool branchCase)
 		{
 			Label endLabel = gen.DefineLabel();
-			exp1.Generate(gen);
 
 			if (exp1 is CodeConditionExpression)
 			{
