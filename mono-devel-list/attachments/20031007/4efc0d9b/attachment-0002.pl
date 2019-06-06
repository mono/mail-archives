Index: cs-parser.jay
===================================================================
RCS file: /cvs/public/mcs/gmcs/cs-parser.jay,v
retrieving revision 1.10
diff -u -r1.10 cs-parser.jay
--- cs-parser.jay	15 Sep 2003 18:57:27 -0000	1.10
+++ cs-parser.jay	7 Oct 2003 02:32:28 -0000
@@ -4301,7 +4301,7 @@
 void CheckToken (int error, int yyToken, string msg)
 {
 	if (yyToken >= Token.FIRST_KEYWORD && yyToken <= Token.LAST_KEYWORD){
-		Report.Error (error, lexer.Location, String.Format ("{0}: `{1}' is a keyword", msg, yyName [yyToken].ToLower ()));
+		Report.Error (error, lexer.Location, String.Format ("{0}: `{1}' is a keyword", msg, yyNames [yyToken].ToLower ()));
 		return;
 	}		
 	Report.Error (error, lexer.Location, msg);