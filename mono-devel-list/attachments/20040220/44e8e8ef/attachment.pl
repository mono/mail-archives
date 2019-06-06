? 54537_Test.patch
Index: PerlTrials.cs
===================================================================
RCS file: /usr/local/cvsroot/tip-mono/Test/System.Text.RegularExpressions/PerlTrials.cs,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 PerlTrials.cs
--- PerlTrials.cs	13 Jan 2004 18:17:54 -0000	1.1.1.1
+++ PerlTrials.cs	20 Feb 2004 18:05:42 -0000
@@ -740,7 +740,11 @@
 			new RegexTrial (@"^(b+?|a){1,2}c", RegexOptions.None, "bbbbac", "Pass. Group[0]=(0,6) Group[1]=(0,4)(4,1)"),
 			new RegexTrial (@"\((\w\. \w+)\)", RegexOptions.None, "cd. (A. Tw)", "Pass. Group[0]=(4,7) Group[1]=(5,5)"),
 			new RegexTrial (@"((?:aaaa|bbbb)cccc)?", RegexOptions.None, "aaaacccc", "Pass. Group[0]=(0,8) Group[1]=(0,8)"),
-			new RegexTrial (@"((?:aaaa|bbbb)cccc)?", RegexOptions.None, "bbbbcccc", "Pass. Group[0]=(0,8) Group[1]=(0,8)")
+			new RegexTrial (@"((?:aaaa|bbbb)cccc)?", RegexOptions.None, "bbbbcccc", "Pass. Group[0]=(0,8) Group[1]=(0,8)"),
+
+			new RegexTrial (@"b", RegexOptions.RightToLeft, "babaaa", "Pass. Group[0]=(2,1)")
+
+				
 		};
 	}
 }
