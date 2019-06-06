Index: driver.cs
===================================================================
--- driver.cs	(revision 37706)
+++ driver.cs	(working copy)
@@ -295,7 +295,7 @@
 					a = Assembly.LoadFrom (assembly);
 				} else {
 					string ass = assembly;
-					if (ass.EndsWith (".dll"))
+					if (ass.EndsWith (".dll") || ass.EndsWith (".exe"))
 						ass = assembly.Substring (0, assembly.Length - 4);
 					a = Assembly.Load (ass);
 				}
@@ -304,7 +304,7 @@
 			} catch (FileNotFoundException){
 				foreach (string dir in link_paths){
 					string full_path = Path.Combine (dir, assembly);
-					if (!assembly.EndsWith (".dll"))
+					if (!assembly.EndsWith (".dll") && !assembly.EndsWith (".exe"))
 						full_path += ".dll";
 
 					try {
