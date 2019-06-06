Change the regex that matches ends of attributes, as Mono fully qualifies the
names.  E.g.:

MS: // end of class DelegateCallingConventionCdeclAttribute
Mono: // end of class Tao.OpenGl.DelegateCallingConventionCdeclAttribute

Change the regex that cuts the body of the IlasmAttribute to be compatible with
monodis-genereated il.  Checks for a line with no starting hex rather than
expecting 'Code size' which should be a tad more generic.

This will fix PostProcess.exe spinning on monodis generated il.  It should
remain compatible with Microsoft ildasm generated il.

- Steven Brown <swbrown@ucsd.edu>


Index: Framework/Projects/Tao.PostProcess/ReleaseBuildProcessor.cs
===================================================================
RCS file: /mono/tao/Framework/Projects/Tao.PostProcess/ReleaseBuildProcessor.cs,v
retrieving revision 1.2
diff -u -r1.2 ReleaseBuildProcessor.cs
--- Framework/Projects/Tao.PostProcess/ReleaseBuildProcessor.cs	6 Jun 2004 19:51:38 -0000	1.2
+++ Framework/Projects/Tao.PostProcess/ReleaseBuildProcessor.cs	30 Jun 2004 05:11:48 -0000
@@ -112,7 +112,7 @@
         private string ModifyIlasmCalls(string fileContent) {
             int callStartPosition = -1;
             int callEndPosition = -1;
-            Regex callStart = new Regex(@"((?<Method> \.custom instance void Tao\..*?\.IlasmAttribute::\.ctor\(string\) = \((?<Body> .*?) \/\/ Code size .*? )} \/\/ end of)", RegexOptions.Compiled | RegexOptions.Singleline);
+            Regex callStart = new Regex(@"((?<Method> \.custom instance void (class )?Tao\..*?\.IlasmAttribute::\.ctor\(string\)\s*=\s*\((?<Body>.*?)(?<LineWithNoHex>\n\s*[^0-9A-Fa-f\s]).*?)}\s*\/\/ end of)", RegexOptions.Compiled | RegexOptions.Singleline);
 
             Match callStartMatch = callStart.Match(fileContent);
             while(callStartMatch.Success) {
@@ -235,7 +235,7 @@
         /// </remarks>
         protected override string InjectMsil(string fileContent) {
             Regex attributeStart = new Regex(@"\.class .*? IlasmAttribute", RegexOptions.Compiled);
-            Regex attributeEnd = new Regex(@"// end of class IlasmAttribute", RegexOptions.Compiled);
+            Regex attributeEnd = new Regex(@"// end of class .*IlasmAttribute", RegexOptions.Compiled);
             fileContent = RemoveAttribute(attributeStart, attributeEnd, fileContent);
             fileContent = ModifyIlasmCalls(fileContent);
 
@@ -258,7 +258,7 @@
         /// </remarks>
         protected override string ModifyCdeclDelegates(string fileContent) {
             Regex attributeStart = new Regex(@"\.class .*? DelegateCallingConventionCdeclAttribute", RegexOptions.Compiled);
-            Regex attributeEnd = new Regex(@"// end of class DelegateCallingConventionCdeclAttribute", RegexOptions.Compiled);
+            Regex attributeEnd = new Regex(@"// end of class .*DelegateCallingConventionCdeclAttribute", RegexOptions.Compiled);
             fileContent = RemoveAttribute(attributeStart, attributeEnd, fileContent);
             fileContent = ModifyCdeclDelegateCalls(fileContent);
 
