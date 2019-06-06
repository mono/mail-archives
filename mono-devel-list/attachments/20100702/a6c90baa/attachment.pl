Index: Documentation/en/System.Diagnostics.Contracts.Internal/ContractHelper.xml
===================================================================
--- Documentation/en/System.Diagnostics.Contracts.Internal/ContractHelper.xml	(revision 159760)
+++ Documentation/en/System.Diagnostics.Contracts.Internal/ContractHelper.xml	(working copy)
@@ -9,8 +9,8 @@
   </Base>
   <Interfaces />
   <Docs>
-    <summary>To be added.</summary>
-    <remarks>To be added.</remarks>
+    <summary>Methods required by the contract rewriter to handle contract failures.</summary>
+    <remarks>These methods are called by code that has been rewritten by the Ccrewrite tool.</remarks>
   </Docs>
   <Members>
     <Member MemberName="RaiseContractFailedEvent">
@@ -37,13 +37,13 @@
         <Parameter Name="innerException" Type="System.Exception" />
       </Parameters>
       <Docs>
-        <param name="failureKind">To be added.</param>
-        <param name="userMessage">To be added.</param>
-        <param name="conditionText">To be added.</param>
-        <param name="innerException">To be added.</param>
-        <summary>To be added.</summary>
-        <returns>To be added.</returns>
-        <remarks>To be added.</remarks>
+        <param name="failureKind">The kind of contract failure.</param>
+        <param name="userMessage">The user message describing this contract failure.</param>
+        <param name="conditionText">The condition that caused this contract failure.</param>
+        <param name="innerException">The exception that caused this contract filure, if any.</param>
+        <summary>Implements the default behaviour on code contract failure.</summary>
+        <returns>The code contract failure message, if the failure has not been handled already. Null if the failure has been handled successfully.</returns>
+        <remarks>The default behaviour is to call each event handler in turn, with exceptions thrown in the handlers treated as calls to <see cref="m:System.Diagnostics.Contracts.ContractFailedEventArgs.SetUnwind()" />. This is defined fully in section 7.3 of UserDoc.pdf from Microsoft.</remarks>
       </Docs>
     </Member>
     <Member MemberName="TriggerFailure">
@@ -71,13 +71,13 @@
         <Parameter Name="innerException" Type="System.Exception" />
       </Parameters>
       <Docs>
-        <param name="kind">To be added.</param>
-        <param name="displayMessage">To be added.</param>
-        <param name="userMessage">To be added.</param>
-        <param name="conditionText">To be added.</param>
-        <param name="innerException">To be added.</param>
-        <summary>To be added.</summary>
-        <remarks>To be added.</remarks>
+        <param name="kind">The kind of contract failure.</param>
+        <param name="displayMessage">The message to display describing this contract failure.</param>
+        <param name="userMessage">The user message describing this contract failure.</param>
+        <param name="conditionText">The condition that caused this contract failure.</param>
+        <param name="innerException">The exception that caused this contract filure, if any.</param>
+        <summary>Implements the default code contract failure behaviour.</summary>
+        <remarks>The default code contract failure behaviour is to trigger an assert if in user interactive mode, otherwise <see cref="m:System.Environment.FailFast(string message)" /> is called to immediately terminate the process.</remarks>
       </Docs>
     </Member>
   </Members>
Index: Documentation/en/ns-System.Diagnostics.Contracts.Internal.xml
===================================================================
--- Documentation/en/ns-System.Diagnostics.Contracts.Internal.xml	(revision 159760)
+++ Documentation/en/ns-System.Diagnostics.Contracts.Internal.xml	(working copy)
@@ -1,6 +1,6 @@
 <Namespace Name="System.Diagnostics.Contracts.Internal">
   <Docs>
-    <summary>To be added.</summary>
-    <remarks>To be added.</remarks>
+    <summary>This namespace contains classes for handling code contract failures.</summary>
+    <remarks></remarks>
   </Docs>
 </Namespace>
