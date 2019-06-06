Index: addins/CSharpBinding/Gui/CSharpTextEditorCompletion.cs
===================================================================
--- addins/CSharpBinding/Gui/CSharpTextEditorCompletion.cs	(revision 121785)
+++ addins/CSharpBinding/Gui/CSharpTextEditorCompletion.cs	(working copy)
@@ -310,20 +310,20 @@
 				if (result == null)
 					return null;
 				
-				int i = completionContext.TriggerOffset;
-				string token = GetPreviousToken (ref i, false);
+				int i2 = completionContext.TriggerOffset;
+				string token = GetPreviousToken (ref i2, false);
 				if (token == "=") {
-					int j = i;
+					int j = i2;
 					string prevToken = GetPreviousToken (ref j, false);
 					if (prevToken == "=" || prevToken == "+" || prevToken == "-") {
 						token = prevToken + token;
-						i = j;
+						i2 = j;
 					}
 				}
 				switch (token) {
 				case "=":
 				case "==":
-					result = FindExpression (dom, completionContext,  i - completionContext.TriggerOffset - 1);
+					result = FindExpression (dom, completionContext,  i2 - completionContext.TriggerOffset - 1);
 					System.Console.WriteLine(result.Expression);
 					resolver = new MonoDevelop.CSharpBinding.NRefactoryResolver (dom, Document.CompilationUnit, ICSharpCode.NRefactory.SupportedLanguage.CSharp, Editor, Document.FileName);
 					resolveResult = resolver.Resolve (result, location);
@@ -343,7 +343,7 @@
 					return null;
 				case "+=":
 				case "-=":
-					result = FindExpression (dom, completionContext,  i - completionContext.TriggerOffset - 1);
+					result = FindExpression (dom, completionContext,  i2 - completionContext.TriggerOffset - 1);
 					resolver = new MonoDevelop.CSharpBinding.NRefactoryResolver (dom, Document.CompilationUnit, ICSharpCode.NRefactory.SupportedLanguage.CSharp, Editor, Document.FileName);
 					resolveResult = resolver.Resolve (result, location);
 					
@@ -390,7 +390,7 @@
 					}
 					return null;
 				}
-				return HandleKeywordCompletion (completionContext, result, i, token);
+				return HandleKeywordCompletion (completionContext, result, i2, token);
 			default:
 				if (Char.IsLetter (completionChar) && TextEditorProperties.EnableAutoCodeCompletion
 					    && !stateTracker.Engine.IsInsideDocLineComment
@@ -624,10 +624,10 @@
 					} else
 						break;
 				}
-				IType cls = NRefactoryResolver.GetTypeAtCursor (Document.CompilationUnit, Document.FileName, new DomLocation (completionContext.TriggerLine, completionContext.TriggerLineOffset));
-				if (cls != null && (cls.ClassType == ClassType.Class || cls.ClassType == ClassType.Struct)) {
+				IType cls2 = NRefactoryResolver.GetTypeAtCursor (Document.CompilationUnit, Document.FileName, new DomLocation (completionContext.TriggerLine, completionContext.TriggerLineOffset));
+				if (cls2 != null && (cls2.ClassType == ClassType.Class || cls2.ClassType == ClassType.Struct)) {
 					string modifiers = Editor.GetText (firstMod, wordStart);
-					return GetOverrideCompletionData (completionContext, cls, modifiers);
+					return GetOverrideCompletionData (completionContext, cls2, modifiers);
 				}
 				return null;
 			case "new":