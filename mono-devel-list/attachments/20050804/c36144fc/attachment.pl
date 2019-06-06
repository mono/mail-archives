Index: mcs/ChangeLog
===================================================================
--- mcs/ChangeLog	(revision 47981)
+++ mcs/ChangeLog	(working copy)
@@ -1,3 +1,7 @@
+2005-08-03  Elliott Draper   <el@eldiablo.co.uk>
+	Fixed a spelling mistake in errors thrown by the compiler for a missing/invalid strong name key file when building an assembly.
+	* codegen.cs: Replaced "speficied" with "specified".
+
 2005-08-03  Raja R Harinath  <rharinath@novell.com>
 
 	First cut of the qualified-alias-member feature.
Index: mcs/codegen.cs
===================================================================
--- mcs/codegen.cs	(revision 47981)
+++ mcs/codegen.cs	(working copy)
@@ -1046,7 +1046,7 @@
 				}
 			}
 			catch (Exception) {
-				Error_AssemblySigning ("The speficied file `" + RootContext.StrongNameKeyFile + "' is incorrectly encoded");
+				Error_AssemblySigning ("The specified file `" + RootContext.StrongNameKeyFile + "' is incorrectly encoded");
 				Environment.Exit (1);
 			}
 		}
@@ -1152,7 +1152,7 @@
 									"ECMA key can only be used to delay-sign assemblies");
 							}
 							else {
-								Error_AssemblySigning ("The speficied file `" + RootContext.StrongNameKeyFile + "' does not have a private key");
+								Error_AssemblySigning ("The specified file `" + RootContext.StrongNameKeyFile + "' does not have a private key");
 							}
 							return null;
 						}
@@ -1160,7 +1160,7 @@
 				}
 			}
 			else {
-				Error_AssemblySigning ("The speficied file `" + RootContext.StrongNameKeyFile + "' does not exist");
+				Error_AssemblySigning ("The specified file `" + RootContext.StrongNameKeyFile + "' does not exist");
 				return null;
 			}
 			return an;
Index: gmcs/ChangeLog
===================================================================
--- gmcs/ChangeLog	(revision 47981)
+++ gmcs/ChangeLog	(working copy)
@@ -1,3 +1,7 @@
+2005-08-03  Elliott Draper   <el@eldiablo.co.uk>
+	Fixed a spelling mistake in errors thrown by the compiler for a missing/invalid strong name key file when building an assembly.
+	* codegen.cs: Replaced "speficied" with "specified".
+
 2005-08-03  Martin Baulig  <martin@ximian.com>
 
 	Make iterators in generic methods work; see gtest-191.cs.
Index: gmcs/codegen.cs
===================================================================
--- gmcs/codegen.cs	(revision 47981)
+++ gmcs/codegen.cs	(working copy)
@@ -1062,7 +1062,7 @@
 				}
 			}
 			catch (Exception) {
-				Error_AssemblySigning ("The speficied file `" + RootContext.StrongNameKeyFile + "' is incorrectly encoded");
+				Error_AssemblySigning ("The specified file `" + RootContext.StrongNameKeyFile + "' is incorrectly encoded");
 				Environment.Exit (1);
 			}
 		}
@@ -1167,7 +1167,7 @@
 									"ECMA key can only be used to delay-sign assemblies");
 							}
 							else {
-								Error_AssemblySigning ("The speficied file `" + RootContext.StrongNameKeyFile + "' does not have a private key");
+								Error_AssemblySigning ("The specified file `" + RootContext.StrongNameKeyFile + "' does not have a private key");
 							}
 							return null;
 						}
@@ -1175,7 +1175,7 @@
 				}
 			}
 			else {
-				Error_AssemblySigning ("The speficied file `" + RootContext.StrongNameKeyFile + "' does not exist");
+				Error_AssemblySigning ("The specified file `" + RootContext.StrongNameKeyFile + "' does not exist");
 				return null;
 			}
 			return an;
