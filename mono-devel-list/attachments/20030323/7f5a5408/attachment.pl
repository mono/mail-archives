Index: driver.cs
===================================================================
RCS file: /mono/mcs/mcs/driver.cs,v
retrieving revision 1.141
diff -u -r1.141 driver.cs
--- driver.cs	27 Feb 2003 19:48:17 -0000	1.141
+++ driver.cs	23 Mar 2003 11:24:11 -0000
@@ -195,6 +195,7 @@
 				"                      (number, `utf8' or `reset')\n" +
 				"   -define:S1[;S2]    Defines one or more symbols (short: /d:)\n" +
 				"   -debug[+-]         Generate debugging information\n" + 
+				"   -doc:FILE          XML Documentation file to generate\n" + 
 				"   -g                 Generate debugging information\n" +
 				"   --fatal            Makes errors fatal\n" +
 				"   -lib:PATH1,PATH2   Adds the paths to the assembly link path\n" +
@@ -919,7 +920,14 @@
 				}
 				return true;
 			}
-
+			case "/doc": {
+				if (value == ""){
+					Report.Error (5, arg + " requires an argument");
+					Environment.Exit (1);
+				}
+				// TODO handle the /doc argument to generate xml doc
+				return true;
+			}
 			case "/lib": {
 				string [] libdirs;
 				
