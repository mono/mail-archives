Index: ConsoleKey.cs
===================================================================
--- ConsoleKey.cs	(revision 49034)
+++ ConsoleKey.cs	(working copy)
@@ -175,12 +175,12 @@
 		Pa1 = 253,
 		OemClear = 254,
 
-#pragma warning disable 3005
+//#pragma warning disable 3005
 		// These are the old names
 		
 		BackSpace = 8,
 		SpaceBar = 32,
-#pragma warning restore
+//#pragma warning restore
 		
 	}
 }