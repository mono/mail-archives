Index: MSXslScriptManager.cs
===================================================================
--- Mono.Xml.Xsl/MSXslScriptManager.cs	(revision 42433)
+++ Mono.Xml.Xsl/MSXslScriptManager.cs	(working copy)
@@ -127,6 +127,9 @@
 			
 			public object Compile (XPathNavigator node)
 			{
+#if TARGET_JVM
+				throw new NotImplementedException ();
+#else
 				string suffix = Guid.NewGuid ().ToString ().Replace ("-", String.Empty);
 				switch (this.language) {
 				case ScriptingLanguage.CSharp:
@@ -138,6 +141,7 @@
 				default:
 					return null;
 				}
+#endif
 			}
 		}
 	}
