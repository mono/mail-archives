Index: source/Parser/Parser(Statements).vb
===================================================================
--- source.orig/Parser/Parser(Statements).vb	2010-01-13 01:11:52.345114369 -0600
+++ source/Parser/Parser(Statements).vb	2010-01-13 01:13:39.246363359 -0600
@@ -533,6 +533,7 @@
                 If decl.IsVariableDeclaration Then
                     m_Code.Variables.Add(decl.VariableDeclaration)
                 End If
+                decl.SetUsingCodeBlock(m_Code)
             Next
         End If
 
Index: source/Statements/UsingDeclarator.vb
===================================================================
--- source.orig/Statements/UsingDeclarator.vb	2010-01-13 01:12:05.643868555 -0600
+++ source/Statements/UsingDeclarator.vb	2010-01-13 01:12:43.753869612 -0600
@@ -122,6 +122,12 @@
         Return result
     End Function
 
+    Public Sub SetUsingCodeBlock(code As CodeBlock)
+        If m_ArgumentList IsNot Nothing Then
+            m_ArgumentList.Parent = code
+        End If
+    End Sub
+
     Public Overrides Function ResolveCode(ByVal Info As ResolveInfo) As Boolean
         Dim result As Boolean = True
 
