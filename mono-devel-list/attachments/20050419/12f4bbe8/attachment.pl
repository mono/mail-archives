Index: decl.cs
===================================================================
--- decl.cs	(revision 43229)
+++ decl.cs	(working copy)
@@ -1438,8 +1438,7 @@
 						//
 						if ((member.Name != "Invoke" ||
 						     !type.IsSubclassOf (TypeManager.multicast_delegate_type)) &&
-						    (member.Name != "Finalize" ||
-						     type != TypeManager.object_type)) {
+						    member.Name != "Finalize") {
 							Report.SymbolRelatedToPreviousError (base_method);
 							Report.Warning (-28, 
 								"The method '{0}' is marked 'override'," + 
