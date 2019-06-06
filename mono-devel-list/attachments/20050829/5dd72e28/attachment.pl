Index: cs-tokenizer.cs
===================================================================
--- cs-tokenizer.cs	(revision 49034)
+++ cs-tokenizer.cs	(working copy)
@@ -1590,6 +1590,13 @@
 		// 
 		bool process_directives = true;
 
+		// get current status of if blocks.
+		bool is_inside_disabled_block ()
+		{
+			return ifstack != null && ifstack.Count != 0 &&
+				((int) ifstack.Peek ()) & TAKING == 0;
+		}
+
 		//
 		// if true, then the code continues processing the code
 		// if false, the code stays in a loop until another directive is
@@ -1599,6 +1606,7 @@
 		{
 			string cmd, arg;
 			bool region_directive = false;
+			current_location = new Location (ref_line, Col);
 
 			get_cmd_arg (out cmd, out arg);
 
@@ -1611,22 +1619,24 @@
 			// The first group of pre-processing instructions is always processed
 			//
 			switch (cmd){
-			case "pragma":
-				if (RootContext.Version == LanguageVersion.ISO_1) {
-					Report.FeatureIsNotStandardized (Location, "#pragma");
+			case "define":
+				if (any_token_seen){
+					Error_TokensSeen ();
+					return true;
+				}
+				if (caller_is_taking)
+					PreProcessDefinition (true, arg);
+				return true;
+
+			case "undef":
+				if (any_token_seen){
+					Error_TokensSeen ();
 					return caller_is_taking;
 				}
-
-				PreProcessPragma (arg);
+				if (caller_is_taking)
+					PreProcessDefinition (false, arg);
 				return caller_is_taking;
 
-			case "line":
-				if (!PreProcessLine (arg))
-					Report.Error (
-						1576, Location,
-						"The line number specified for #line directive is missing or invalid");
-				return caller_is_taking;
-
 			case "region":
 				region_directive = true;
 				arg = "true";
@@ -1757,6 +1767,20 @@
 					
 					return ret;
 				}
+			case "pragma":
+				if (RootContext.Version == LanguageVersion.ISO_1) {
+					Report.FeatureIsNotStandardized (Location, "#pragma");
+					return caller_is_taking;
+				}
+				break;
+			case "line":
+			case "error":
+			case "warning":
+				// processed only when current code block is not disabled.
+				break; 
+			default:
+				Report.Error (1024, Location, "Wrong preprocessor directive");
+				return caller_is_taking;
 			}
 
 			//
@@ -1766,21 +1790,16 @@
 				return false;
 					
 			switch (cmd){
-			case "define":
-				if (any_token_seen){
-					Error_TokensSeen ();
-					return true;
-				}
-				PreProcessDefinition (true, arg);
+			case "pragma":
+				PreProcessPragma (arg);
 				return true;
 
-			case "undef":
-				if (any_token_seen){
-					Error_TokensSeen ();
-					return true;
-				}
-				PreProcessDefinition (false, arg);
-				return true;
+			case "line":
+				if (!PreProcessLine (arg))
+					Report.Error (
+						1576, Location,
+						"The line number specified for #line directive is missing or invalid");
+				return caller_is_taking;
 
 			case "error":
 				Report.Error (1029, Location, "#error: '" + arg + "'");
@@ -1790,10 +1809,7 @@
 				Report.Warning (1030, Location, "#warning: `{0}'", arg);
 				return true;
 			}
-
-			Report.Error (1024, Location, "Wrong preprocessor directive");
 			return true;
-
 		}
 
 		private int consume_string (bool quoted)