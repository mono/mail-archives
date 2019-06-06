Ok this is about ArrayCreation, and not about ConstructorInfo

DoEmit decides to use EmitStaticInitializers if there are more elements than max_automatic_initializers (6), but not if underlying_type is string_type, decimal_type, or object_type.

The problem is ArrayCreation.LookupType doesn't seem to set underlying_type to the "underlying type" (ie the base type) it's just the type (maybe... I haven't spent much time with the compiler, so this is just my 5 cents). This causes DoEmit to use EmitStaticInitializers on derived classes (not on object itself), and EmitStaticInitializers doesn't work with object types.

As a better example of the problem, the following test will fail on objectDerivedArray, but not objectArray.

using System;
public class objectDerived:Object {}
public class ArrayCreationTest
{
	public static void Main(string[] args)
	{
		object[] objectArray = { null, null, null, null, null, null, null,};
		objectDerived[] objectDerivedArray = { null, null, null, null, null, null, null,};
	}
}

A small change to the if expression in expression.cs appears to fix the problem. 

!!Note!! I haven't regression tested this change. I don't think it's appropriate that I do (being a total n00b). But at least there's some more information here, so that someone who knows what they're doing can implement a fix.

Index: expression.cs
===================================================================
RCS file: /mono/mcs/mcs/expression.cs,v
retrieving revision 1.525
diff -u -r1.525 expression.cs
--- expression.cs	28 Feb 2004 00:34:14 -0000	1.525
+++ expression.cs	9 Mar 2004 02:09:13 -0000
@@ -6271,7 +6271,7 @@
 
 				if (underlying_type != TypeManager.string_type &&
 				    underlying_type != TypeManager.decimal_type &&
-				    underlying_type != TypeManager.object_type) {
+				    !underlying_type.IsSubclassOf(TypeManager.object_type)) {
 					if (num_automatic_initializers > max_automatic_initializers)
 						EmitStaticInitializers (ec, dynamic_initializers || !is_statement);
 				}

