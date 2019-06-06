Index: EmptyDestructorTest.cs
===================================================================
--- EmptyDestructorTest.cs	(revision 64483)
+++ EmptyDestructorTest.cs	(working copy)
@@ -98,7 +98,7 @@
 		public void EmptyDestructor ()
 		{
 			ITypeDefinition type = GetTest ("EmptyDestructorClass");
-			Assert.IsNull (rule.CheckType (assembly, module, type, new MinimalRunner ()));
+			Assert.IsNotNull (rule.CheckType (assembly, module, type, new MinimalRunner ()));
 		}
 
 		[Test]