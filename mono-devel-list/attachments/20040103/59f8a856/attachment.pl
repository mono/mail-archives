Index: convert.cs
===================================================================
RCS file: /mono/mcs/mcs/convert.cs,v
retrieving revision 1.16
diff -u -r1.16 convert.cs
--- convert.cs	20 Dec 2003 13:48:34 -0000	1.16
+++ convert.cs	3 Jan 2004 04:37:10 -0000
@@ -1625,7 +1625,8 @@
 			//
 			// Unboxing conversion.
 			//
-			if (expr_type == TypeManager.object_type && target_type.IsValueType){
+			if ((expr_type == TypeManager.object_type ||
+				expr_type == TypeManager.enum_type) && target_type.IsValueType){
 				if (expr is NullLiteral){
 					Report.Error (37, loc, "Cannot convert null to value type `" +
                                                       TypeManager.CSharpName (target_type) + "'");
