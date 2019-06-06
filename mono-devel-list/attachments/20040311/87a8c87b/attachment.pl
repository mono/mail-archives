? 54537_test.patch
? Test_RightToLeft.patch
Index: ChangeLog
===================================================================
RCS file: /mono/mcs/class/System/Test/System.Text.RegularExpressions/ChangeLog,v
retrieving revision 1.4
diff -u -r1.4 ChangeLog
--- ChangeLog	2 Feb 2004 13:04:13 -0000	1.4
+++ ChangeLog	11 Mar 2004 20:12:59 -0000
@@ -1,16 +1,12 @@
-2004-02-02  Nick Drochak <ndrochak@ieee.org>
-
-	* RegexBugs.cs (RangeIgnoreCase): made the last assert pass on .NET.
-
-2004-01-16  Gonzalo Paniagua Javier <gonzalo@ximian.com>
-
-	* RegexBugs.cs: added test from bug #52924.
+2004-03-11  Francois Beauchemin <beauche@softhome.net>
+	* PerlTrials.cs : Added many test for RightToLeft
+	* PerlTest.cs, RegexTrial : Modified version of regextrial to 
+		be run all the test and to report exception.
 
 2004-01-07  Lluis Sanchez Gual <lluis@ximian.com>
 
-	* RegexBugs.cs: Improved test. In Split(), if the last match is at the
-	end of the string, an empty string must be added to the array of
-	results.
+	* RegexBugs.cs: Improved test. In Split(), if the last match is at the end
+	of the string, an empty string must be added to the array of results.
 
 2003-11-27  Gonzalo Paniagua Javier <gonzalo@ximian.com>
 
Index: PerlTest.cs
===================================================================
RCS file: /mono/mcs/class/System/Test/System.Text.RegularExpressions/PerlTest.cs,v
retrieving revision 1.5
diff -u -r1.5 PerlTest.cs
--- PerlTest.cs	18 Mar 2003 21:45:41 -0000	1.5
+++ PerlTest.cs	11 Mar 2004 20:12:59 -0000
@@ -17,21 +17,34 @@
 
 namespace MonoTests.System.Text.RegularExpressions {
 	
+       
 	[TestFixture]
 	public class PerlTest {
 
 		[Test]
 		public void Trials () {
+			string msg = "";
 			foreach (RegexTrial trial in PerlTrials.trials) {
 				string actual = trial.Execute ();
 				if (actual != trial.Expected) {
-					Assertion.Fail (
-						trial.ToString () +
+					msg += "\t" + trial.ToString () +
 						"Expected " + trial.Expected +
-						" but got " + actual
-					);
+						" but got " + actual + "\n";
+						
+					if ( trial.Error != "" ) 
+						msg += "\n" + trial.Error;
+
+						
+					//Assertion.Fail (
+					//	trial.ToString () +
+					//	"Expected " + trial.Expected +
+					//	" but got " + actual
+					//);
 				}
 			}
+			if (msg != "" ) 
+				Assertion.Fail("\n" + msg);
 		}
 	}
 }
+
Index: PerlTrials.cs
===================================================================
RCS file: /mono/mcs/class/System/Test/System.Text.RegularExpressions/PerlTrials.cs,v
retrieving revision 1.4
diff -u -r1.4 PerlTrials.cs
--- PerlTrials.cs	5 May 2002 10:14:38 -0000	1.4
+++ PerlTrials.cs	11 Mar 2004 20:13:00 -0000
@@ -740,7 +740,251 @@
 			new RegexTrial (@"^(b+?|a){1,2}c", RegexOptions.None, "bbbbac", "Pass. Group[0]=(0,6) Group[1]=(0,4)(4,1)"),
 			new RegexTrial (@"\((\w\. \w+)\)", RegexOptions.None, "cd. (A. Tw)", "Pass. Group[0]=(4,7) Group[1]=(5,5)"),
 			new RegexTrial (@"((?:aaaa|bbbb)cccc)?", RegexOptions.None, "aaaacccc", "Pass. Group[0]=(0,8) Group[1]=(0,8)"),
-			new RegexTrial (@"((?:aaaa|bbbb)cccc)?", RegexOptions.None, "bbbbcccc", "Pass. Group[0]=(0,8) Group[1]=(0,8)")
+			new RegexTrial (@"((?:aaaa|bbbb)cccc)?", RegexOptions.None, "bbbbcccc", "Pass. Group[0]=(0,8) Group[1]=(0,8)"),
+			
+			new RegexTrial (@"^(foo)|(bar)$", RegexOptions.None, "foobar", "Pass. Group[0]=(0,3) Group[1]=(0,3) Group[2]="),
+			new RegexTrial (@"^(foo)|(bar)$", RegexOptions.RightToLeft, "foobar", "Pass. Group[0]=(3,3) Group[1]= Group[2]=(3,3)"),
+
+			new RegexTrial (@"b", RegexOptions.RightToLeft, "babaaa", "Pass. Group[0]=(2,1)"),
+			new RegexTrial (@"bab", RegexOptions.RightToLeft, "babababaa", "Pass. Group[0]=(4,3)"),
+			new RegexTrial (@"abb", RegexOptions.RightToLeft , "abb", "Pass. Group[0]=(0,3)"),
+												
+            new RegexTrial (@"b$", RegexOptions.RightToLeft | RegexOptions.Multiline, "aab\naab", "Pass. Group[0]=(6,1)"),
+            new RegexTrial (@"^a", RegexOptions.RightToLeft | RegexOptions.Multiline, "aab\naab", "Pass. Group[0]=(4,1)"),
+            new RegexTrial (@"^aaab", RegexOptions.RightToLeft | RegexOptions.Multiline, "aaab\naab", "Pass. Group[0]=(0,4)"),
+            new RegexTrial (@"abb{2}", RegexOptions.RightToLeft , "abbb", "Pass. Group[0]=(0,4)"),
+            new RegexTrial (@"abb{1,2}", RegexOptions.RightToLeft , "abbb", "Pass. Group[0]=(0,4)"),
+            
+            new RegexTrial (@"abb{1,2}", RegexOptions.RightToLeft , "abbbbbaaaa", "Pass. Group[0]=(0,4)"),
+            new RegexTrial (@"\Ab", RegexOptions.RightToLeft, "bab\naaa", "Pass. Group[0]=(0,1)"),
+            new RegexTrial (@"\Abab$", RegexOptions.RightToLeft, "bab", "Pass. Group[0]=(0,3)"),
+            new RegexTrial (@"b\Z", RegexOptions.RightToLeft, "bab\naaa", "Fail."),
+            new RegexTrial (@"b\Z", RegexOptions.RightToLeft, "babaaab", "Pass. Group[0]=(6,1)"),
+            new RegexTrial (@"b\z", RegexOptions.RightToLeft, "babaaa", "Fail."),
+            new RegexTrial (@"b\z", RegexOptions.RightToLeft, "babaaab", "Pass. Group[0]=(6,1)"),
+			new RegexTrial (@"a\G", RegexOptions.RightToLeft, "babaaa", "Pass. Group[0]=(5,1)"),
+			new RegexTrial (@"\Abaaa\G", RegexOptions.RightToLeft, "baaa", "Pass. Group[0]=(0,4)"),
+//			new RegexTrial (@"b", RegexOptions.RightToLeft, "babaaa", "Pass. Group[0]=(2,1)"),
+//			new RegexTrial (@"b", RegexOptions.RightToLeft, "babaaa", "Pass. Group[0]=(2,1)"),
+//			new RegexTrial (@"b", RegexOptions.RightToLeft, "babaaa", "Pass. Group[0]=(2,1)"),
+//			new RegexTrial (@"b", RegexOptions.RightToLeft, "babaaa", "Pass. Group[0]=(2,1)"),
+
+			new RegexTrial (@"\bc", RegexOptions.RightToLeft, "aaa c aaa c a", "Pass. Group[0]=(10,1)"),
+			new RegexTrial (@"\bc", RegexOptions.RightToLeft, "c aaa c", "Pass. Group[0]=(6,1)"),
+			new RegexTrial (@"\bc", RegexOptions.RightToLeft, "aaa ac", "Fail."),
+			new RegexTrial (@"\bc", RegexOptions.RightToLeft, "c aaa", "Pass. Group[0]=(0,1)"),
+			new RegexTrial (@"\bc", RegexOptions.RightToLeft, "aaacaaa", "Fail."),
+			new RegexTrial (@"\bc", RegexOptions.RightToLeft, "aaac aaa", "Fail."),
+			new RegexTrial (@"\bc", RegexOptions.RightToLeft, "aaa ca caaa", "Pass. Group[0]=(7,1)"),
+			
+			new RegexTrial (@"\Bc", RegexOptions.RightToLeft, "ac aaa ac", "Pass. Group[0]=(8,1)"),
+			new RegexTrial (@"\Bc", RegexOptions.RightToLeft, "aaa c", "Fail."),
+			new RegexTrial (@"\Bc", RegexOptions.RightToLeft, "ca aaa", "Fail."),
+			new RegexTrial (@"\Bc", RegexOptions.RightToLeft, "aaa c aaa", "Fail."),
+			new RegexTrial (@"\Bc", RegexOptions.RightToLeft, " acaca ", "Pass. Group[0]=(4,1)"),
+			new RegexTrial (@"\Bc", RegexOptions.RightToLeft, "aaac aaac", "Pass. Group[0]=(8,1)"),
+			new RegexTrial (@"\Bc", RegexOptions.RightToLeft, "aaa caaa", "Fail."),
+				
+			new RegexTrial (@"b(a?)b", RegexOptions.RightToLeft, "aabababbaaababa", "Pass. Group[0]=(11,3) Group[1]=(12,1)"),
+			new RegexTrial (@"b{4}", RegexOptions.RightToLeft, "abbbbaabbbbaabbb", "Pass. Group[0]=(7,4)"),
+			new RegexTrial (@"b\1aa(.)", RegexOptions.RightToLeft, "bBaaB", "Pass. Group[0]=(0,5) Group[1]=(4,1)"),
+			new RegexTrial (@"b(.)aa\1", RegexOptions.RightToLeft, "bBaaB", "Fail."),
+			
+			new RegexTrial (@"^(a\1?){4}$", RegexOptions.RightToLeft, "aaaaaa", "Pass. Group[0]=(0,6) Group[1]=(5,1)(3,2)(2,1)(0,2)"),
+			new RegexTrial (@"^([0-9a-fA-F]+)(?:x([0-9a-fA-F]+)?)(?:x([0-9a-fA-F]+))?", RegexOptions.RightToLeft, "012cxx0190", "Pass. Group[0]=(0,10) Group[1]=(0,4) Group[2]= Group[3]=(6,4)"),
+			new RegexTrial (@"^(b+?|a){1,2}c", RegexOptions.RightToLeft, "bbbac", "Pass. Group[0]=(0,5) Group[1]=(3,1)(0,3)"),			
+			new RegexTrial (@"\((\w\. \w+)\)", RegexOptions.RightToLeft, "cd. (A. Tw)", "Pass. Group[0]=(4,7) Group[1]=(5,5)"),
+			new RegexTrial (@"((?:aaaa|bbbb)cccc)?", RegexOptions.RightToLeft, "aaaacccc", "Pass. Group[0]=(0,8) Group[1]=(0,8)"),
+			new RegexTrial (@"((?:aaaa|bbbb)cccc)?", RegexOptions.RightToLeft, "bbbbcccc", "Pass. Group[0]=(0,8) Group[1]=(0,8)"),
+			
+			new RegexTrial (@"(?<=a)b", RegexOptions.RightToLeft, "ab", "Pass. Group[0]=(1,1)"),
+			new RegexTrial (@"(?<=a)b", RegexOptions.RightToLeft, "cb", "Fail."),
+			new RegexTrial (@"(?<=a)b", RegexOptions.RightToLeft, "b", "Fail."),
+			new RegexTrial (@"(?<!c)b", RegexOptions.RightToLeft, "ab", "Pass. Group[0]=(1,1)"),
+			new RegexTrial (@"(?<!c)b", RegexOptions.RightToLeft, "cb", "Fail."),
+			new RegexTrial (@"(?<!c)b", RegexOptions.RightToLeft, "b", "Pass. Group[0]=(0,1)"),
+			new RegexTrial (@"(?<!c)b", RegexOptions.RightToLeft, "b", "Pass. Group[0]=(0,1)"),
+			new RegexTrial (@"a(?=d).", RegexOptions.RightToLeft, "adabad", "Pass. Group[0]=(4,2)"),
+			new RegexTrial (@"a(?=c|d).", RegexOptions.RightToLeft, "adabad", "Pass. Group[0]=(4,2)"),
+			
+			new RegexTrial (@"ab*c", RegexOptions.RightToLeft, "abc", "Pass. Group[0]=(0,3)"),
+			new RegexTrial (@"ab*bc", RegexOptions.RightToLeft, "abc", "Pass. Group[0]=(0,3)"),
+			new RegexTrial (@"ab*bc", RegexOptions.RightToLeft, "abbc", "Pass. Group[0]=(0,4)"),
+			new RegexTrial (@"ab*bc", RegexOptions.RightToLeft, "abbbbc", "Pass. Group[0]=(0,6)"),
+			new RegexTrial (@".{1}", RegexOptions.RightToLeft, "abbbbc", "Pass. Group[0]=(5,1)"),
+			new RegexTrial (@".{3,4}", RegexOptions.RightToLeft, "abbbbc", "Pass. Group[0]=(2,4)"),
+			new RegexTrial (@"ab{0,}bc", RegexOptions.RightToLeft, "abbbbc", "Pass. Group[0]=(0,6)"),
+			new RegexTrial (@"ab+bc", RegexOptions.RightToLeft, "abbc", "Pass. Group[0]=(0,4)"),
+			new RegexTrial (@"ab+bc", RegexOptions.RightToLeft, "abc", "Fail."),
+			new RegexTrial (@"ab+bc", RegexOptions.RightToLeft, "abq", "Fail."),
+			new RegexTrial (@"ab{1,}bc", RegexOptions.RightToLeft, "abq", "Fail."),
+			new RegexTrial (@"ab+bc", RegexOptions.RightToLeft, "abbbbc", "Pass. Group[0]=(0,6)"),
+			new RegexTrial (@"ab{1,}bc", RegexOptions.RightToLeft, "abbbbc", "Pass. Group[0]=(0,6)"),
+			new RegexTrial (@"ab{1,3}bc", RegexOptions.RightToLeft, "abbbbc", "Pass. Group[0]=(0,6)"),
+			new RegexTrial (@"ab{3,4}bc", RegexOptions.RightToLeft, "abbbbc", "Pass. Group[0]=(0,6)"),
+			new RegexTrial (@"ab{4,5}bc", RegexOptions.RightToLeft, "abbbbc", "Fail."),
+			new RegexTrial (@"ab?bc", RegexOptions.RightToLeft, "abbc", "Pass. Group[0]=(0,4)"),
+			new RegexTrial (@"ab?bc", RegexOptions.RightToLeft, "abc", "Pass. Group[0]=(0,3)"),
+			new RegexTrial (@"ab{0,1}bc", RegexOptions.RightToLeft, "abc", "Pass. Group[0]=(0,3)"),
+			new RegexTrial (@"ab?bc", RegexOptions.RightToLeft, "abbbbc", "Fail."),
+			new RegexTrial (@"ab?c", RegexOptions.RightToLeft, "abc", "Pass. Group[0]=(0,3)"),
+			new RegexTrial (@"ab{0,1}c", RegexOptions.RightToLeft, "abc", "Pass. Group[0]=(0,3)"),
+			new RegexTrial (@"^abc$", RegexOptions.RightToLeft, "abc", "Pass. Group[0]=(0,3)"),
+			new RegexTrial (@"^abc$", RegexOptions.RightToLeft, "abcc", "Fail."),
+			new RegexTrial (@"^abc", RegexOptions.RightToLeft, "abcc", "Pass. Group[0]=(0,3)"),
+			new RegexTrial (@"^abc$", RegexOptions.RightToLeft, "aabc", "Fail."),
+			new RegexTrial (@"abc$", RegexOptions.RightToLeft, "aabc", "Pass. Group[0]=(1,3)"),
+			new RegexTrial (@"abc$", RegexOptions.RightToLeft, "aabcd", "Fail."),
+			new RegexTrial (@"^", RegexOptions.RightToLeft, "abc", "Pass. Group[0]=(0,0)"),
+			new RegexTrial (@"$", RegexOptions.RightToLeft, "abc", "Pass. Group[0]=(3,0)"),
+			new RegexTrial (@"a.c", RegexOptions.RightToLeft, "abc", "Pass. Group[0]=(0,3)"),
+			new RegexTrial (@"a.c", RegexOptions.RightToLeft, "axc", "Pass. Group[0]=(0,3)"),
+			new RegexTrial (@"a.*c", RegexOptions.RightToLeft, "axyzc", "Pass. Group[0]=(0,5)"),
+			new RegexTrial (@"a.*c", RegexOptions.RightToLeft, "axyzd", "Fail."),
+			new RegexTrial (@"a[bc]d", RegexOptions.RightToLeft, "abc", "Fail."),
+			new RegexTrial (@"a[bc]d", RegexOptions.RightToLeft, "abd", "Pass. Group[0]=(0,3)"),
+			new RegexTrial (@"a[b-d]e", RegexOptions.RightToLeft, "abd", "Fail."),
+			new RegexTrial (@"a[b-d]e", RegexOptions.RightToLeft, "ace", "Pass. Group[0]=(0,3)"),
+			new RegexTrial (@"a[b-d]", RegexOptions.RightToLeft, "aac", "Pass. Group[0]=(1,2)"),
+			new RegexTrial (@"a[-b]", RegexOptions.RightToLeft, "a-", "Pass. Group[0]=(0,2)"),
+			new RegexTrial (@"a[b-]", RegexOptions.RightToLeft, "a-", "Pass. Group[0]=(0,2)"),
+			new RegexTrial (@"a[b-a]", RegexOptions.RightToLeft, "-", "Error."),
+			new RegexTrial (@"a[]b", RegexOptions.RightToLeft, "-", "Error."),
+			new RegexTrial (@"a[", RegexOptions.RightToLeft, "-", "Error."),
+			new RegexTrial (@"a]", RegexOptions.RightToLeft, "a]", "Pass. Group[0]=(0,2)"),
+			new RegexTrial (@"a[]]b", RegexOptions.RightToLeft, "a]b", "Pass. Group[0]=(0,3)"),
+			new RegexTrial (@"a[^bc]d", RegexOptions.RightToLeft, "aed", "Pass. Group[0]=(0,3)"),
+			new RegexTrial (@"a[^bc]d", RegexOptions.RightToLeft, "abd", "Fail."),
+			new RegexTrial (@"a[^-b]c", RegexOptions.RightToLeft, "adc", "Pass. Group[0]=(0,3)"),
+			new RegexTrial (@"a[^-b]c", RegexOptions.RightToLeft, "a-c", "Fail."),
+			new RegexTrial (@"a[^]b]c", RegexOptions.RightToLeft, "a]c", "Fail."),
+			new RegexTrial (@"a[^]b]c", RegexOptions.RightToLeft, "adc", "Pass. Group[0]=(0,3)"),
+			new RegexTrial (@"\ba\b", RegexOptions.RightToLeft, "a-", "Pass. Group[0]=(0,1)"),
+			new RegexTrial (@"\ba\b", RegexOptions.RightToLeft, "-a", "Pass. Group[0]=(1,1)"),
+			new RegexTrial (@"\ba\b", RegexOptions.RightToLeft, "-a-", "Pass. Group[0]=(1,1)"),
+			new RegexTrial (@"\by\b", RegexOptions.RightToLeft, "xy", "Fail."),
+			new RegexTrial (@"\by\b", RegexOptions.RightToLeft, "yz", "Fail."),
+			new RegexTrial (@"\by\b", RegexOptions.RightToLeft, "xyz", "Fail."),
+			new RegexTrial (@"\Ba\B", RegexOptions.RightToLeft, "a-", "Fail."),
+			new RegexTrial (@"\Ba\B", RegexOptions.RightToLeft, "-a", "Fail."),
+			new RegexTrial (@"\Ba\B", RegexOptions.RightToLeft, "-a-", "Fail."),
+			new RegexTrial (@"\By\b", RegexOptions.RightToLeft, "xy", "Pass. Group[0]=(1,1)"),
+			new RegexTrial (@"\by\B", RegexOptions.RightToLeft, "yz", "Pass. Group[0]=(0,1)"),
+			new RegexTrial (@"\By\B", RegexOptions.RightToLeft, "xyz", "Pass. Group[0]=(1,1)"),
+			new RegexTrial (@"\w", RegexOptions.RightToLeft, "a", "Pass. Group[0]=(0,1)"),
+			new RegexTrial (@"\w", RegexOptions.RightToLeft, "-", "Fail."),
+			new RegexTrial (@"\W", RegexOptions.RightToLeft, "a", "Fail."),
+			new RegexTrial (@"\W", RegexOptions.RightToLeft, "-", "Pass. Group[0]=(0,1)"),
+			new RegexTrial (@"a\sb", RegexOptions.RightToLeft, "a b", "Pass. Group[0]=(0,3)"),
+			new RegexTrial (@"a\sb", RegexOptions.RightToLeft, "a-b", "Fail."),
+			new RegexTrial (@"a\Sb", RegexOptions.RightToLeft, "a b", "Fail."),
+			new RegexTrial (@"a\Sb", RegexOptions.RightToLeft, "a-b", "Pass. Group[0]=(0,3)"),
+			new RegexTrial (@"\d", RegexOptions.RightToLeft, "1", "Pass. Group[0]=(0,1)"),
+			new RegexTrial (@"\d", RegexOptions.RightToLeft, "-", "Fail."),
+			new RegexTrial (@"\D", RegexOptions.RightToLeft, "1", "Fail."),
+			new RegexTrial (@"\D", RegexOptions.RightToLeft, "-", "Pass. Group[0]=(0,1)"),
+			new RegexTrial (@"[\w]", RegexOptions.RightToLeft, "a", "Pass. Group[0]=(0,1)"),
+			new RegexTrial (@"[\w]", RegexOptions.RightToLeft, "-", "Fail."),
+			new RegexTrial (@"[\W]", RegexOptions.RightToLeft, "a", "Fail."),
+			new RegexTrial (@"[\W]", RegexOptions.RightToLeft, "-", "Pass. Group[0]=(0,1)"),
+			new RegexTrial (@"a[\s]b", RegexOptions.RightToLeft, "a b", "Pass. Group[0]=(0,3)"),
+			new RegexTrial (@"a[\s]b", RegexOptions.RightToLeft, "a-b", "Fail."),
+			new RegexTrial (@"a[\S]b", RegexOptions.RightToLeft, "a b", "Fail."),
+			new RegexTrial (@"a[\S]b", RegexOptions.RightToLeft, "a-b", "Pass. Group[0]=(0,3)"),
+			new RegexTrial (@"[\d]", RegexOptions.RightToLeft, "1", "Pass. Group[0]=(0,1)"),
+			new RegexTrial (@"[\d]", RegexOptions.RightToLeft, "-", "Fail."),
+			new RegexTrial (@"[\D]", RegexOptions.RightToLeft, "1", "Fail."),
+			new RegexTrial (@"[\D]", RegexOptions.RightToLeft, "-", "Pass. Group[0]=(0,1)"),
+			new RegexTrial (@"ab|cd", RegexOptions.RightToLeft, "abc", "Pass. Group[0]=(0,2)"),
+			new RegexTrial (@"ab|cd", RegexOptions.RightToLeft, "abcd", "Pass. Group[0]=(2,2)"),
+			new RegexTrial (@"()ef", RegexOptions.RightToLeft, "def", "Pass. Group[0]=(1,2) Group[1]=(1,0)"),
+			new RegexTrial (@"*a", RegexOptions.RightToLeft, "-", "Error."),
+			new RegexTrial (@"(*)b", RegexOptions.RightToLeft, "-", "Error."),
+			new RegexTrial (@"$b", RegexOptions.RightToLeft, "b", "Fail."),
+			new RegexTrial (@"a\", RegexOptions.RightToLeft, "-", "Error."),
+			new RegexTrial (@"a\(b", RegexOptions.RightToLeft, "a(b", "Pass. Group[0]=(0,3)"),
+			new RegexTrial (@"a\(*b", RegexOptions.RightToLeft, "ab", "Pass. Group[0]=(0,2)"),
+			new RegexTrial (@"a\(*b", RegexOptions.RightToLeft, "a((b", "Pass. Group[0]=(0,4)"),
+			new RegexTrial (@"a\\b", RegexOptions.RightToLeft, "a\\b", "Pass. Group[0]=(0,3)"),
+			new RegexTrial (@"abc)", RegexOptions.RightToLeft, "-", "Error."),
+			new RegexTrial (@"(abc", RegexOptions.RightToLeft, "-", "Error."),
+			new RegexTrial (@"((a))", RegexOptions.RightToLeft, "abc", "Pass. Group[0]=(0,1) Group[1]=(0,1) Group[2]=(0,1)"),
+			new RegexTrial (@"(a)b(c)", RegexOptions.RightToLeft, "abc", "Pass. Group[0]=(0,3) Group[1]=(0,1) Group[2]=(2,1)"),
+			new RegexTrial (@"a+b+c", RegexOptions.RightToLeft, "aabbabc", "Pass. Group[0]=(4,3)"),
+			new RegexTrial (@"a{1,}b{1,}c", RegexOptions.RightToLeft, "aabbabc", "Pass. Group[0]=(4,3)"),
+			new RegexTrial (@"a**", RegexOptions.RightToLeft, "-", "Error."),
+			new RegexTrial (@"a.+?c", RegexOptions.RightToLeft, "abcabc", "Pass. Group[0]=(3,3)"),
+			new RegexTrial (@"(a+|b)*", RegexOptions.RightToLeft, "ab", "Pass. Group[0]=(0,2) Group[1]=(1,1)(0,1)"),
+			new RegexTrial (@"(a+|b){0,}", RegexOptions.RightToLeft, "ab", "Pass. Group[0]=(0,2) Group[1]=(1,1)(0,1)"),
+			new RegexTrial (@"(a+|b)+", RegexOptions.RightToLeft, "ab", "Pass. Group[0]=(0,2) Group[1]=(1,1)(0,1)"),
+			new RegexTrial (@"(a+|b){1,}", RegexOptions.RightToLeft, "ab", "Pass. Group[0]=(0,2) Group[1]=(1,1)(0,1)"),
+			new RegexTrial (@"(a+|b)?", RegexOptions.RightToLeft, "ab", "Pass. Group[0]=(1,1) Group[1]=(1,1)"),
+			new RegexTrial (@"(a+|b){0,1}", RegexOptions.RightToLeft, "ab", "Pass. Group[0]=(1,1) Group[1]=(1,1)"),
+			new RegexTrial (@")(", RegexOptions.RightToLeft, "-", "Error."),
+			new RegexTrial (@"[^ab]*", RegexOptions.RightToLeft, "cde", "Pass. Group[0]=(0,3)"),
+			new RegexTrial (@"abc", RegexOptions.RightToLeft, "", "Fail."),
+			new RegexTrial (@"a*", RegexOptions.RightToLeft, "", "Pass. Group[0]=(0,0)"),
+			new RegexTrial (@"([abc])*d", RegexOptions.RightToLeft, "abbbcd", "Pass. Group[0]=(0,6) Group[1]=(4,1)(3,1)(2,1)(1,1)(0,1)"),
+			new RegexTrial (@"([abc])*bcd", RegexOptions.RightToLeft, "abcd", "Pass. Group[0]=(0,4) Group[1]=(0,1)"),
+			new RegexTrial (@"a|b|c|d|e", RegexOptions.RightToLeft, "e", "Pass. Group[0]=(0,1)"),
+			new RegexTrial (@"(a|b|c|d|e)f", RegexOptions.RightToLeft, "ef", "Pass. Group[0]=(0,2) Group[1]=(0,1)"),
+			new RegexTrial (@"abcd*efg", RegexOptions.RightToLeft, "abcdefg", "Pass. Group[0]=(0,7)"),
+			new RegexTrial (@"ab*", RegexOptions.RightToLeft, "xabyabbbz", "Pass. Group[0]=(4,4)"),
+			new RegexTrial (@"ab*", RegexOptions.RightToLeft, "xayabbbz", "Pass. Group[0]=(3,4)"),
+			new RegexTrial (@"(ab|cd)e", RegexOptions.RightToLeft, "abcde", "Pass. Group[0]=(2,3) Group[1]=(2,2)"),
+			new RegexTrial (@"[abhgefdc]ij", RegexOptions.RightToLeft, "hij", "Pass. Group[0]=(0,3)"),
+			new RegexTrial (@"^(ab|cd)e", RegexOptions.RightToLeft, "abcde", "Fail."),
+			new RegexTrial (@"(abc|)ef", RegexOptions.RightToLeft, "abcdef", "Pass. Group[0]=(4,2) Group[1]=(4,0)"),
+			new RegexTrial (@"(a|b)c*d", RegexOptions.RightToLeft, "abcd", "Pass. Group[0]=(1,3) Group[1]=(1,1)"),
+			new RegexTrial (@"(ab|ab*)bc", RegexOptions.RightToLeft, "abc", "Pass. Group[0]=(0,3) Group[1]=(0,1)"),
+			new RegexTrial (@"a([bc]*)c*", RegexOptions.RightToLeft, "abc", "Pass. Group[0]=(0,3) Group[1]=(1,1)"),
+			new RegexTrial (@"a([bc]*)(c*d)", RegexOptions.RightToLeft, "abcd", "Pass. Group[0]=(0,4) Group[1]=(1,1) Group[2]=(2,2)"),
+			new RegexTrial (@"a([bc]+)(c*d)", RegexOptions.RightToLeft, "abcd", "Pass. Group[0]=(0,4) Group[1]=(1,1) Group[2]=(2,2)"),
+			new RegexTrial (@"a([bc]*)(c+d)", RegexOptions.RightToLeft, "abcd", "Pass. Group[0]=(0,4) Group[1]=(1,1) Group[2]=(2,2)"),
+			new RegexTrial (@"a[bcd]*dcdcde", RegexOptions.RightToLeft, "adcdcde", "Pass. Group[0]=(0,7)"),
+			new RegexTrial (@"a[bcd]+dcdcde", RegexOptions.RightToLeft, "adcdcde", "Fail."),
+			new RegexTrial (@"(ab|a)b*c", RegexOptions.RightToLeft, "abc", "Pass. Group[0]=(0,3) Group[1]=(0,1)"),
+			new RegexTrial (@"((a)(b)c)(d)", RegexOptions.RightToLeft, "abcd", "Pass. Group[0]=(0,4) Group[1]=(0,3) Group[2]=(0,1) Group[3]=(1,1) Group[4]=(3,1)"),
+			new RegexTrial (@"[a-zA-Z_][a-zA-Z0-9_]*", RegexOptions.RightToLeft, "alpha", "Pass. Group[0]=(0,5)"),
+			new RegexTrial (@"^a(bc+|b[eh])g|.h$", RegexOptions.RightToLeft, "abh", "Pass. Group[0]=(1,2) Group[1]="),
+			new RegexTrial (@"(bc+d$|ef*g.|h?i(j|k))", RegexOptions.RightToLeft, "effgz", "Pass. Group[0]=(0,5) Group[1]=(0,5) Group[2]="),
+			new RegexTrial (@"(bc+d$|ef*g.|h?i(j|k))", RegexOptions.RightToLeft, "ij", "Pass. Group[0]=(0,2) Group[1]=(0,2) Group[2]=(1,1)"),
+			new RegexTrial (@"(bc+d$|ef*g.|h?i(j|k))", RegexOptions.RightToLeft, "effg", "Fail."),
+			new RegexTrial (@"(bc+d$|ef*g.|h?i(j|k))", RegexOptions.RightToLeft, "bcdd", "Fail."),
+			new RegexTrial (@"(bc+d$|ef*g.|h?i(j|k))", RegexOptions.RightToLeft, "reffgz", "Pass. Group[0]=(1,5) Group[1]=(1,5) Group[2]="),
+			new RegexTrial (@"((((((((((a))))))))))", RegexOptions.RightToLeft, "a", "Pass. Group[0]=(0,1) Group[1]=(0,1) Group[2]=(0,1) Group[3]=(0,1) Group[4]=(0,1) Group[5]=(0,1) Group[6]=(0,1) Group[7]=(0,1) Group[8]=(0,1) Group[9]=(0,1) Group[10]=(0,1)"),
+			new RegexTrial (@"((((((((((a))))))))))\10", RegexOptions.RightToLeft, "aa", "Fail."),
+			new RegexTrial (@"\10((((((((((a))))))))))", RegexOptions.RightToLeft, "aa", "Pass. Group[0]=(0,2) Group[1]=(1,1) Group[2]=(1,1) Group[3]=(1,1) Group[4]=(1,1) Group[5]=(1,1) Group[6]=(1,1) Group[7]=(1,1) Group[8]=(1,1) Group[9]=(1,1) Group[10]=(1,1)"),
+			new RegexTrial (@"((((((((((a))))))))))!", RegexOptions.RightToLeft, "aa", "Fail."),
+			new RegexTrial (@"((((((((((a))))))))))!", RegexOptions.RightToLeft, "a!", "Pass. Group[0]=(0,2) Group[1]=(0,1) Group[2]=(0,1) Group[3]=(0,1) Group[4]=(0,1) Group[5]=(0,1) Group[6]=(0,1) Group[7]=(0,1) Group[8]=(0,1) Group[9]=(0,1) Group[10]=(0,1)"),
+			new RegexTrial (@"(((((((((a)))))))))", RegexOptions.RightToLeft, "a", "Pass. Group[0]=(0,1) Group[1]=(0,1) Group[2]=(0,1) Group[3]=(0,1) Group[4]=(0,1) Group[5]=(0,1) Group[6]=(0,1) Group[7]=(0,1) Group[8]=(0,1) Group[9]=(0,1)"),
+			new RegexTrial (@"multiple words of text", RegexOptions.RightToLeft, "uh-uh", "Fail."),
+			new RegexTrial (@"multiple words", RegexOptions.RightToLeft, "multiple words, yeah", "Pass. Group[0]=(0,14)"),
+			new RegexTrial (@"(.*)c(.*)", RegexOptions.RightToLeft, "abcde", "Pass. Group[0]=(0,5) Group[1]=(0,2) Group[2]=(3,2)"),
+			new RegexTrial (@"\((.*), (.*)\)", RegexOptions.RightToLeft, "(a, b)", "Pass. Group[0]=(0,6) Group[1]=(1,1) Group[2]=(4,1)"),
+			new RegexTrial (@"[k]", RegexOptions.RightToLeft, "ab", "Fail."),
+			new RegexTrial (@"abcd", RegexOptions.RightToLeft, "abcd", "Pass. Group[0]=(0,4)"),
+			new RegexTrial (@"a(bc)d", RegexOptions.RightToLeft, "abcd", "Pass. Group[0]=(0,4) Group[1]=(1,2)"),
+			new RegexTrial (@"a[-]?c", RegexOptions.RightToLeft, "ac", "Pass. Group[0]=(0,2)"),
+			new RegexTrial (@"(abc)\1", RegexOptions.RightToLeft, "abcabc", "Fail."),
+			new RegexTrial (@"\1(abc)", RegexOptions.RightToLeft, "abcabc", "Pass. Group[0]=(0,6) Group[1]=(3,3)"),
+			new RegexTrial (@"([a-c]*)\1", RegexOptions.RightToLeft, "abcabc", "Fail."),
+			new RegexTrial (@"\1([a-c]*)", RegexOptions.RightToLeft, "abcabc", "Pass. Group[0]=(0,6) Group[1]=(3,3)"),
+			new RegexTrial (@"\1", RegexOptions.RightToLeft, "-", "Error."),
+			new RegexTrial (@"\2", RegexOptions.RightToLeft, "-", "Error."),
+			new RegexTrial (@"(a)|\1", RegexOptions.RightToLeft, "a", "Pass. Group[0]=(0,1) Group[1]=(0,1)"),
+			new RegexTrial (@"(a)|\1", RegexOptions.RightToLeft, "x", "Fail."),
+			new RegexTrial (@"(a)|\2", RegexOptions.RightToLeft, "-", "Error."),
+			new RegexTrial (@"(([a-c])b*?\2)*", RegexOptions.RightToLeft, "ababbbcbc", "Pass. Group[0]=(9,0) Group[1]= Group[2]="),
+			new RegexTrial (@"(([a-c])b*?\2){3}", RegexOptions.RightToLeft, "ababbbcbc", "Fail."),
+			new RegexTrial (@"((\3|b)\2(a)x)+", RegexOptions.RightToLeft, "aaxabxbaxbbx", "Fail."),
+			new RegexTrial (@"((\3|b)\2(a)x)+", RegexOptions.RightToLeft, "aaaxabaxbaaxbbax", "Fail."),
+			new RegexTrial (@"((\3|b)\2(a)){2,}", RegexOptions.RightToLeft, "bbaababbabaaaaabbaaaabba", "Fail."),
+
+			
+			
+			new RegexTrial (@"b", RegexOptions.RightToLeft, "babaaa", "Pass. Group[0]=(2,1)")
+			
 		};
 	}
 }
Index: RegexTrial.cs
===================================================================
RCS file: /mono/mcs/class/System/Test/System.Text.RegularExpressions/RegexTrial.cs,v
retrieving revision 1.3
diff -u -r1.3 RegexTrial.cs
--- RegexTrial.cs	5 May 2002 10:14:38 -0000	1.3
+++ RegexTrial.cs	11 Mar 2004 20:13:00 -0000
@@ -9,6 +9,7 @@
 		public string input;
 
 		public string expected;
+		public string error = "";
 
 		public RegexTrial (string pattern, RegexOptions options, string input, string expected) {
 			this.pattern = pattern;
@@ -20,6 +21,12 @@
 		public string Expected {
 			get { return expected; }
 		}
+		
+		public string Error {
+			get {
+				return this.error;
+			}
+		}
 
 		public string Execute () {
 			string result;
@@ -42,7 +49,10 @@
 				else
 					result = "Fail.";
 			}
-			catch (Exception) {
+			catch (Exception e) {
+				
+				error = e.Message + "\n" + e.StackTrace + "\n\n";
+				
 				result = "Error.";
 			}
 
