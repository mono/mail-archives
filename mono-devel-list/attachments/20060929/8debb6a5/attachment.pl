Index: Test/System.Reflection/ChangeLog
===================================================================
--- Test/System.Reflection/ChangeLog	(revision 64207)
+++ Test/System.Reflection/ChangeLog	(working copy)
@@ -1,3 +1,7 @@
+2006-09-29  Jb Evain  <jbevain@gmail.com>
+
+	* FieldInfoTest.cs: Test for FieldInfo.SetValue on a literal field.
+
 2006-08-08  Gert Driesen  <drieseng@users.sourceforge.net>
 
 	* AssemblyTest.cs: Modified test to pass on 2.0 profile and .NET 2.0.
Index: Test/System.Reflection/FieldInfoTest.cs
===================================================================
--- Test/System.Reflection/FieldInfoTest.cs	(revision 64207)
+++ Test/System.Reflection/FieldInfoTest.cs	(working copy)
@@ -118,6 +118,16 @@
 		f.SetValue (null, 8);
 	}
 
+	const int literal = 42;
+
+	[Test]
+	[ExpectedException (typeof (FieldAccessException))]
+	public void SetValueOnLiteralField ()
+	{
+		FieldInfo f = typeof (FieldInfoTest).GetField ("literal", BindingFlags.Static | BindingFlags.NonPublic);
+		f.SetValue (null, 0);
+	}
+
 	public int? nullable_field;
 
 	public static int? static_nullable_field;
Index: System.Reflection/ChangeLog
===================================================================
--- System.Reflection/ChangeLog	(revision 64207)
+++ System.Reflection/ChangeLog	(working copy)
@@ -1,3 +1,7 @@
+2006-09-29  Jb Evain  <jbevain@gmail.com>
+
+	* MonoFieldInfo.cs: throw a FieldAccessException when setting a literal field.
+
 2006-08-08  Gert Driesen  <drieseng@users.sourceforge.net>
 
 	* Assembly.cs: On 2.0 profile, throw FileNotFoundException for
Index: System.Reflection/MonoField.cs
===================================================================
--- System.Reflection/MonoField.cs	(revision 64207)
+++ System.Reflection/MonoField.cs	(working copy)
@@ -117,6 +117,8 @@
 		{
 			if (!IsStatic && obj == null)
 				throw new TargetException ("Non-static field requires a target");
+			if (IsLiteral)
+				throw new FieldAccessException ("Cannot set a constant field");
 			if (binder == null)
 				binder = Binder.DefaultBinder;
 			if (val != null) {
