Index: ChangeLog
===================================================================
--- ChangeLog	(revision 48380)
+++ ChangeLog	(working copy)
@@ -1,3 +1,7 @@
+2005-08-16  Atsushi Enomoto  <atsushi@ximian.com>
+
+	* xmlconf.cs: we need error message to do real-world debugging.
+
 2005-07-21  Rafael Mizrahi  <rafim@mainsoft.com>
 
 	* xmlconf.cs: Close readers handlers in order to free file descriptors.
Index: xmlconf.cs
===================================================================
--- xmlconf.cs	(revision 48380)
+++ xmlconf.cs	(working copy)
@@ -153,7 +153,7 @@
 	class TestFromCatalog: NUnit.Core.TestCase
 	{
 		XmlElement _test;
-		string _stackTrace;
+		string _errorString;
 		bool _inverseResult;
 
 		public TestFromCatalog (string testId, XmlElement test, bool inverseResult)
@@ -172,7 +172,7 @@
 				return true;
 			}
 			catch (Exception e) {
-				_stackTrace = e.StackTrace;
+				_errorString = e.ToString ();
 				return false;
 			}
 			finally {
@@ -191,7 +191,7 @@
 				return true;
 			}
 			catch (Exception e) {
-				_stackTrace = e.StackTrace; //rewrites existing, possibly, but it's ok
+				_errorString = e.ToString (); //rewrites existing, possibly, but it's ok
 				return false;
 			}
 			finally {
@@ -226,7 +226,7 @@
 				message += " non-validating passed:"+nonValidatingPassed.ToString();
 				message += " validating passed:"+validatingPassed.ToString();
 				message += " description:"+_test.InnerText;
-				res.Failure (message, _stackTrace);
+				res.Failure (message, _errorString);
 			}
 		}
 