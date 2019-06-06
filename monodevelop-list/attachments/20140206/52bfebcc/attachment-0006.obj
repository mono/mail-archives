--- extras/MonoDevelop.Profiling/MonoDevelop.Profiling.HeapShot/Gui/ReferenceTreeViewer.cs.orig	2014-01-19 20:21:36.880339096 -0600
+++ extras/MonoDevelop.Profiling/MonoDevelop.Profiling.HeapShot/Gui/ReferenceTreeViewer.cs	2014-01-19 20:23:10.689862326 -0600
@@ -411,53 +411,53 @@
 					case 0:
 						return "Type " + node.TypeName;
 					case 1: {
-						string pname = GetParentType (iter);
-						if (pname != null) {
+						string pname1 = GetParentType (iter);
+						if (pname1 != null) {
 							if (InverseReferences)
-								return string.Format ("There are <b>{0:n0}</b> instances of type <b>{1}</b> which contain references to objects of type <b>{2}</b>", node.RefCount, GetShortName (node.TypeName), pname);
+								return string.Format ("There are <b>{0:n0}</b> instances of type <b>{1}</b> which contain references to objects of type <b>{2}</b>", node.RefCount, GetShortName (node.TypeName), pname1);
 							else
-								return string.Format ("There are <b>{0:n0}</b> instances of type <b>{1}</b> referenced by objects of type <b>{2}</b>", node.RefCount, GetShortName (node.TypeName), pname);
+								return string.Format ("There are <b>{0:n0}</b> instances of type <b>{1}</b> referenced by objects of type <b>{2}</b>", node.RefCount, GetShortName (node.TypeName), pname1);
 						} else
 							return string.Format ("There are <b>{0:n0}</b> instances of type <b>{1}</b>.", node.RefCount, GetShortName (node.TypeName));
 					}
 					case 2: {
-						string pname = GetParentType (iter);
-						if (pname != null)
-							return string.Format ("There are <b>{0:n0}</b> distinct references from objects of type <b>{1}</b> to objects of type <b>{2}</b>", node.RefsToParent, GetShortName (node.TypeName), pname);
+						string pname2 = GetParentType (iter);
+						if (pname2 != null)
+							return string.Format ("There are <b>{0:n0}</b> distinct references from objects of type <b>{1}</b> to objects of type <b>{2}</b>", node.RefsToParent, GetShortName (node.TypeName), pname2);
 						else
 							return "";
 					}
 					case 3: {
-						string rname = GetRootType (iter);
-						if (rname != null)
-							return string.Format ("There are <b>{0:n0}</b> indirect references from objects of type <b>{1}</b> to objects of type <b>{2}</b>", node.RefsToRoot, GetShortName (node.TypeName), rname);
+						string rname1 = GetRootType (iter);
+						if (rname1 != null)
+							return string.Format ("There are <b>{0:n0}</b> indirect references from objects of type <b>{1}</b> to objects of type <b>{2}</b>", node.RefsToRoot, GetShortName (node.TypeName), rname1);
 						else
 							return "";
 					}
 					case 4: {
-						string rname = GetRootType (iter);
-						if (rname != null)
-							return string.Format ("There are <b>{0:n0}</b> bytes of <b>{1}</b> objects indirectly referenced by <b>{2}</b> objects", node.RootMemory, rname, GetShortName (node.TypeName));
+						string rname2 = GetRootType (iter);
+						if (rname2 != null)
+							return string.Format ("There are <b>{0:n0}</b> bytes of <b>{1}</b> objects indirectly referenced by <b>{2}</b> objects", node.RootMemory, rname2, GetShortName (node.TypeName));
 						else
 							return "";
 					}
 					case 5: {
-						string pname = GetParentType (iter);
-						if (pname != null) {
+						string pname3 = GetParentType (iter);
+						if (pname3 != null) {
 							if (InverseReferences)
-								return string.Format ("There are <b>{0:n0}</b> bytes of <b>{1}</b> objects which have references to <b>{2}</b> objects", node.TotalMemory, GetShortName (node.TypeName), pname);
+								return string.Format ("There are <b>{0:n0}</b> bytes of <b>{1}</b> objects which have references to <b>{2}</b> objects", node.TotalMemory, GetShortName (node.TypeName), pname3);
 							else
-								return string.Format ("There are <b>{0:n0}</b> bytes of <b>{1}</b> objects referenced by <b>{2}</b> objects", node.TotalMemory, GetShortName (node.TypeName), pname);
+								return string.Format ("There are <b>{0:n0}</b> bytes of <b>{1}</b> objects referenced by <b>{2}</b> objects", node.TotalMemory, GetShortName (node.TypeName), pname3);
 						} else
 							return string.Format ("There are <b>{0:n0}</b> bytes of <b>{1}</b> objects", node.TotalMemory, GetShortName (node.TypeName));
 					}
 					case 6:
-						string pname = GetParentType (iter);
-						if (pname != null) {
+						string pname4 = GetParentType (iter);
+						if (pname4 != null) {
 							if (InverseReferences)
-								return string.Format ("Objects of type <b>{0}</b> which have references to <b>{2}</b> objects have an average size of <b>{1:n0}</b> bytes", GetShortName (node.TypeName), node.AverageSize, pname);
+								return string.Format ("Objects of type <b>{0}</b> which have references to <b>{2}</b> objects have an average size of <b>{1:n0}</b> bytes", GetShortName (node.TypeName), node.AverageSize, pname4);
 							else
-								return string.Format ("Objects of type <b>{0}</b> referenced by <b>{2}</b> objects have an average size of <b>{1:n0}</b> bytes", GetShortName (node.TypeName), node.AverageSize, pname);
+								return string.Format ("Objects of type <b>{0}</b> referenced by <b>{2}</b> objects have an average size of <b>{1:n0}</b> bytes", GetShortName (node.TypeName), node.AverageSize, pname4);
 						} else
 							return string.Format ("Objects of type <b>{0}</b> have an average size of <b>{1:n0}</b> bytes", GetShortName (node.TypeName), node.AverageSize);
 				}
