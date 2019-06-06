Index: cs-parser.jay
===================================================================
RCS file: /cvs/public/mcs/mcs/cs-parser.jay,v
retrieving revision 1.256
diff -u -r1.256 cs-parser.jay
--- cs-parser.jay	30 Sep 2003 17:44:28 -0000	1.256
+++ cs-parser.jay	7 Oct 2003 02:16:40 -0000
@@ -4186,7 +4186,7 @@
 void CheckToken (int error, int yyToken, string msg)
 {
 	if (yyToken >= Token.FIRST_KEYWORD && yyToken <= Token.LAST_KEYWORD){
-		Report.Error (error, lexer.Location, String.Format ("{0}: `{1}' is a keyword", msg, yyName [yyToken].ToLower ()));
+		Report.Error (error, lexer.Location, String.Format ("{0}: `{1}' is a keyword", msg, yyNames [yyToken].ToLower ()));
 		return;
 	}		
 	Report.Error (error, lexer.Location, msg);