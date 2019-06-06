--- old\Uri.cs	2004-01-11 12:54:24.000000000 +0200
+++ new\Uri.cs	2004-01-07 19:50:27.750418800 +0200
@@ -704,6 +704,19 @@
 				// delims      = "<" | ">" | "#" | "%" | <">
 				// unwise      = "{" | "}" | "|" | "\" | "^" | "[" | "]" | "`"
 
+				// check for escape code already placed in str, 
+				// i.e. for encoding that follows the pattern 
+                // "%hexhex" in a string, where "hex" is a digit from 0-9 
+				// or a letter from A-F (case-insensitive).
+				if('%'.Equals(c) && IsHexEncoding(str,i))
+				{
+					// if ,yes , copy it as is
+					s.Append(c);
+					s.Append(str[++i]);
+					s.Append(str[++i]);
+					continue;
+				}
+
 				if ((c <= 0x20) || (c >= 0x7f) || 
 				    ("<>%\"{}|\\^`".IndexOf (c) != -1) ||
 				    (escapeHex && (c == '#')) ||
@@ -713,6 +726,7 @@
 					s.Append (HexEscape (c));
 					continue;
 				}
+				
 					
 				s.Append (c);
 			}
