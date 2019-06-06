Index: Documentation/en/ns-System.Diagnostics.Contracts.xml
===================================================================
--- Documentation/en/ns-System.Diagnostics.Contracts.xml	(revision 159760)
+++ Documentation/en/ns-System.Diagnostics.Contracts.xml	(working copy)
@@ -1,6 +1,6 @@
 <Namespace Name="System.Diagnostics.Contracts">
   <Docs>
-    <summary>To be added.</summary>
-    <remarks>To be added.</remarks>
+    <summary>This namespace contains classes for specifying code contracts.</summary>
+    <remarks>To enforce the code contracts at runtime use the ccrewrite tool. To statically check the code contracts use the cccheck tool.</remarks>
   </Docs>
 </Namespace>
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
Index: Documentation/en/System.Diagnostics.Contracts/ContractReferenceAssemblyAttribute.xml
===================================================================
--- Documentation/en/System.Diagnostics.Contracts/ContractReferenceAssemblyAttribute.xml	(revision 159760)
+++ Documentation/en/System.Diagnostics.Contracts/ContractReferenceAssemblyAttribute.xml	(working copy)
@@ -14,8 +14,13 @@
     </Attribute>
   </Attributes>
   <Docs>
-    <summary>To be added.</summary>
-    <remarks>To be added.</remarks>
+    <summary>Marks an assembly as being a contarct reference assembly. This assembly will contain no code except as required by the contracts.</summary>
+    <remarks><para>
+Contract reference assemblies are required to allow contracts to be inherited across assemblies. The reference assembly contains the full code contract specifications, so dependant assemblies are able to inherit code contracts correctly.
+</para>
+<para>
+Contract reference assemblies are generated by the ccrefgen tool.
+</para></remarks>
   </Docs>
   <Members>
     <Member MemberName=".ctor">
@@ -26,8 +31,8 @@
       </AssemblyInfo>
       <Parameters />
       <Docs>
-        <summary>To be added.</summary>
-        <remarks>To be added.</remarks>
+        <summary>Construct a ContractReferenceAssemblyAttribute.</summary>
+        <remarks />
       </Docs>
     </Member>
   </Members>
Index: Documentation/en/System.Diagnostics.Contracts/ContractFailedEventArgs.xml
===================================================================
--- Documentation/en/System.Diagnostics.Contracts/ContractFailedEventArgs.xml	(revision 159760)
+++ Documentation/en/System.Diagnostics.Contracts/ContractFailedEventArgs.xml	(working copy)
@@ -9,8 +9,8 @@
   </Base>
   <Interfaces />
   <Docs>
-    <summary>To be added.</summary>
-    <remarks>To be added.</remarks>
+    <summary>Contains event data for the Contract.ContractFailed event.</summary>
+    <remarks />
   </Docs>
   <Members>
     <Member MemberName=".ctor">
@@ -31,12 +31,12 @@
         <Parameter Name="originalException" Type="System.Exception" />
       </Parameters>
       <Docs>
-        <param name="failureKind">To be added.</param>
-        <param name="message">To be added.</param>
-        <param name="condition">To be added.</param>
-        <param name="originalException">To be added.</param>
-        <summary>To be added.</summary>
-        <remarks>To be added.</remarks>
+        <param name="failureKind">The kind of contract failure.</param>
+        <param name="message">The message associated with this contract failure.</param>
+        <param name="condition">The condition that caused the contract failure.</param>
+        <param name="originalException">The original exception that caused this contract failure, if any.</param>
+        <summary>Construct a ContractFailedEventArgs.</summary>
+        <remarks />
       </Docs>
     </Member>
     <Member MemberName="Condition">
@@ -49,9 +49,9 @@
         <ReturnType>System.String</ReturnType>
       </ReturnValue>
       <Docs>
-        <summary>To be added.</summary>
-        <value>To be added.</value>
-        <remarks>To be added.</remarks>
+        <summary>Gets the condition that caused the contract failure.</summary>
+        <value>The condition that caused the contract failure.</value>
+        <remarks />
       </Docs>
     </Member>
     <Member MemberName="FailureKind">
@@ -64,9 +64,9 @@
         <ReturnType>System.Diagnostics.Contracts.ContractFailureKind</ReturnType>
       </ReturnValue>
       <Docs>
-        <summary>To be added.</summary>
-        <value>To be added.</value>
-        <remarks>To be added.</remarks>
+        <summary>Gets the kind of contract failure.</summary>
+        <value>The kind of contract failure.</value>
+        <remarks />
       </Docs>
     </Member>
     <Member MemberName="Handled">
@@ -79,9 +79,9 @@
         <ReturnType>System.Boolean</ReturnType>
       </ReturnValue>
       <Docs>
-        <summary>To be added.</summary>
-        <value>To be added.</value>
-        <remarks>To be added.</remarks>
+        <summary>Gets whether the contract failure has been handled.</summary>
+        <value>Whether the contract failure has been handled.</value>
+        <remarks />
       </Docs>
     </Member>
     <Member MemberName="Message">
@@ -94,9 +94,9 @@
         <ReturnType>System.String</ReturnType>
       </ReturnValue>
       <Docs>
-        <summary>To be added.</summary>
-        <value>To be added.</value>
-        <remarks>To be added.</remarks>
+        <summary>Gets the message associated with this contract failure.</summary>
+        <value>The message associated with this contract failure.</value>
+        <remarks />
       </Docs>
     </Member>
     <Member MemberName="OriginalException">
@@ -109,9 +109,9 @@
         <ReturnType>System.Exception</ReturnType>
       </ReturnValue>
       <Docs>
-        <summary>To be added.</summary>
-        <value>To be added.</value>
-        <remarks>To be added.</remarks>
+        <summary>Gets the original exception that caused this contract failure, if any.</summary>
+        <value>The original exception that caused this contract failure, if any.</value>
+        <remarks />
       </Docs>
     </Member>
     <Member MemberName="SetHandled">
@@ -125,8 +125,8 @@
       </ReturnValue>
       <Parameters />
       <Docs>
-        <summary>To be added.</summary>
-        <remarks>To be added.</remarks>
+        <summary>Mark this contract failure as having been handled.</summary>
+        <remarks>Marking the contract failure as having been handled suppresses the default contract failure behaviour. </remarks>
       </Docs>
     </Member>
     <Member MemberName="SetUnwind">
@@ -140,8 +140,9 @@
       </ReturnValue>
       <Parameters />
       <Docs>
-        <summary>To be added.</summary>
-        <remarks>To be added.</remarks>
+        <summary>Request that this contract failure unwind the stack by throwing an exception.</summary>
+        <remarks>Marking the contract failure as having been handled suppresses the default contract failure behaviour.
+Requesting the contract failure unwind the stack suppresses the default contract failure behaviour, and throws a <see cref="T:System.Diagnostics.Contracts.ContractException" /> instead.</remarks>
       </Docs>
     </Member>
     <Member MemberName="Unwind">
@@ -154,9 +155,9 @@
         <ReturnType>System.Boolean</ReturnType>
       </ReturnValue>
       <Docs>
-        <summary>To be added.</summary>
-        <value>To be added.</value>
-        <remarks>To be added.</remarks>
+        <summary>Gets whether the contract failure should unwind the stack.</summary>
+        <value>Whether the contract failure should unwind the stack.</value>
+        <remarks />
       </Docs>
     </Member>
   </Members>
Index: Documentation/en/System.Diagnostics.Contracts/ContractVerificationAttribute.xml
===================================================================
--- Documentation/en/System.Diagnostics.Contracts/ContractVerificationAttribute.xml	(revision 159760)
+++ Documentation/en/System.Diagnostics.Contracts/ContractVerificationAttribute.xml	(working copy)
@@ -17,8 +17,8 @@
     </Attribute>
   </Attributes>
   <Docs>
-    <summary>To be added.</summary>
-    <remarks>To be added.</remarks>
+    <summary>Indicates whether the code contract verification tools should verify this item. If not, the item is assumed to be correct.</summary>
+    <remarks />
   </Docs>
   <Members>
     <Member MemberName=".ctor">
@@ -31,9 +31,9 @@
         <Parameter Name="value" Type="System.Boolean" />
       </Parameters>
       <Docs>
-        <param name="value">To be added.</param>
-        <summary>To be added.</summary>
-        <remarks>To be added.</remarks>
+        <param name="value">Whether to include this item in verification.</param>
+        <summary>Construct a ContractVerificationAttribute, specifying whether to include this item in verification.</summary>
+        <remarks />
       </Docs>
     </Member>
     <Member MemberName="Value">
@@ -46,9 +46,9 @@
         <ReturnType>System.Boolean</ReturnType>
       </ReturnValue>
       <Docs>
-        <summary>To be added.</summary>
-        <value>To be added.</value>
-        <remarks>To be added.</remarks>
+        <summary>Gets whether to include this item in verification.</summary>
+        <value>Whether to include this item in verification.</value>
+        <remarks />
       </Docs>
     </Member>
   </Members>
Index: Documentation/en/System.Diagnostics.Contracts/ContractPublicPropertyNameAttribute.xml
===================================================================
--- Documentation/en/System.Diagnostics.Contracts/ContractPublicPropertyNameAttribute.xml	(revision 159760)
+++ Documentation/en/System.Diagnostics.Contracts/ContractPublicPropertyNameAttribute.xml	(working copy)
@@ -17,8 +17,8 @@
     </Attribute>
   </Attributes>
   <Docs>
-    <summary>To be added.</summary>
-    <remarks>To be added.</remarks>
+    <summary>Specifies a public property name associated with a field, allowing a less-visible field to be used in contracts within a method.</summary>
+    <remarks />
   </Docs>
   <Members>
     <Member MemberName=".ctor">
@@ -31,9 +31,9 @@
         <Parameter Name="name" Type="System.String" />
       </Parameters>
       <Docs>
-        <param name="name">To be added.</param>
-        <summary>To be added.</summary>
-        <remarks>To be added.</remarks>
+        <param name="name">The name of the public property associated with this field.</param>
+        <summary>Construct a ContractPublicPropertyNameAttribute, specifying the name of the public property associated with this field.</summary>
+        <remarks />
       </Docs>
     </Member>
     <Member MemberName="Name">
@@ -46,9 +46,9 @@
         <ReturnType>System.String</ReturnType>
       </ReturnValue>
       <Docs>
-        <summary>To be added.</summary>
-        <value>To be added.</value>
-        <remarks>To be added.</remarks>
+        <summary>The name of the public property associated with this field.</summary>
+        <value>The name of the public property associated with this field.</value>
+        <remarks />
       </Docs>
     </Member>
   </Members>
Index: Documentation/en/System.Diagnostics.Contracts/ContractClassAttribute.xml
===================================================================
--- Documentation/en/System.Diagnostics.Contracts/ContractClassAttribute.xml	(revision 159760)
+++ Documentation/en/System.Diagnostics.Contracts/ContractClassAttribute.xml	(working copy)
@@ -20,8 +20,8 @@
     </Attribute>
   </Attributes>
   <Docs>
-    <summary>To be added.</summary>
-    <remarks>To be added.</remarks>
+    <summary>Marks a class as having another class that contains its code contracts.</summary>
+    <remarks>Interfaces and abstract methods cannot have their contracts written directly in the code. The <see cref="T:System.Diagnostics.Contracts.ContractClassAttribute" /> and <see cref="T:System.Diagnostics.Contracts.ContractClassForAttribute" /> may be used to specify another class that contains the contracts for an interface or abstract class.</remarks>
   </Docs>
   <Members>
     <Member MemberName=".ctor">
@@ -34,9 +34,9 @@
         <Parameter Name="typeContainingContracts" Type="System.Type" />
       </Parameters>
       <Docs>
-        <param name="typeContainingContracts">To be added.</param>
-        <summary>To be added.</summary>
-        <remarks>To be added.</remarks>
+        <param name="typeContainingContracts">The type that contains the code contract specifications.</param>
+        <summary>Constructs a ContractClassAttribute, specifying the type that contains the code contract specifications.</summary>
+        <remarks />
       </Docs>
     </Member>
     <Member MemberName="TypeContainingContracts">
@@ -49,9 +49,9 @@
         <ReturnType>System.Type</ReturnType>
       </ReturnValue>
       <Docs>
-        <summary>To be added.</summary>
-        <value>To be added.</value>
-        <remarks>To be added.</remarks>
+        <summary>Get the type that contains the code contract specifications.</summary>
+        <value>The type that contains the code contract specifications.</value>
+        <remarks />
       </Docs>
     </Member>
   </Members>
Index: Documentation/en/System.Diagnostics.Contracts/ContractFailureKind.xml
===================================================================
--- Documentation/en/System.Diagnostics.Contracts/ContractFailureKind.xml	(revision 159760)
+++ Documentation/en/System.Diagnostics.Contracts/ContractFailureKind.xml	(working copy)
@@ -8,8 +8,8 @@
     <BaseTypeName>System.Enum</BaseTypeName>
   </Base>
   <Docs>
-    <summary>To be added.</summary>
-    <remarks>To be added.</remarks>
+    <summary>The different kinds of code contract that can fail.</summary>
+    <remarks />
   </Docs>
   <Members>
     <Member MemberName="Assert">
@@ -22,7 +22,7 @@
         <ReturnType>System.Diagnostics.Contracts.ContractFailureKind</ReturnType>
       </ReturnValue>
       <Docs>
-        <summary>To be added.</summary>
+        <summary>An Assert contract.</summary>
       </Docs>
     </Member>
     <Member MemberName="Assume">
@@ -35,7 +35,7 @@
         <ReturnType>System.Diagnostics.Contracts.ContractFailureKind</ReturnType>
       </ReturnValue>
       <Docs>
-        <summary>To be added.</summary>
+        <summary>An Assume contract.</summary>
       </Docs>
     </Member>
     <Member MemberName="Invariant">
@@ -48,7 +48,7 @@
         <ReturnType>System.Diagnostics.Contracts.ContractFailureKind</ReturnType>
       </ReturnValue>
       <Docs>
-        <summary>To be added.</summary>
+        <summary>A type-level Invariant contract.</summary>
       </Docs>
     </Member>
     <Member MemberName="Postcondition">
@@ -61,7 +61,7 @@
         <ReturnType>System.Diagnostics.Contracts.ContractFailureKind</ReturnType>
       </ReturnValue>
       <Docs>
-        <summary>To be added.</summary>
+        <summary>A Post-Condition contract.</summary>
       </Docs>
     </Member>
     <Member MemberName="PostconditionOnException">
@@ -74,7 +74,7 @@
         <ReturnType>System.Diagnostics.Contracts.ContractFailureKind</ReturnType>
       </ReturnValue>
       <Docs>
-        <summary>To be added.</summary>
+        <summary>A Post-Condition contract, that is only active when an exception is thrown to be handled outside the current method.</summary>
       </Docs>
     </Member>
     <Member MemberName="Precondition">
@@ -87,7 +87,7 @@
         <ReturnType>System.Diagnostics.Contracts.ContractFailureKind</ReturnType>
       </ReturnValue>
       <Docs>
-        <summary>To be added.</summary>
+        <summary>A Pre-Condition contract.</summary>
       </Docs>
     </Member>
   </Members>
Index: Documentation/en/System.Diagnostics.Contracts/Contract.xml
===================================================================
--- Documentation/en/System.Diagnostics.Contracts/Contract.xml	(revision 159760)
+++ Documentation/en/System.Diagnostics.Contracts/Contract.xml	(working copy)
@@ -9,8 +9,8 @@
   </Base>
   <Interfaces />
   <Docs>
-    <summary>To be added.</summary>
-    <remarks>To be added.</remarks>
+    <summary>Contains methods that allow various contracts to be specified in code.</summary>
+    <remarks />
   </Docs>
   <Members>
     <Member MemberName="Assert">
@@ -37,9 +37,9 @@
         <Parameter Name="condition" Type="System.Boolean" />
       </Parameters>
       <Docs>
-        <param name="condition">To be added.</param>
-        <summary>To be added.</summary>
-        <remarks>To be added.</remarks>
+        <param name="condition">The condition to verify.</param>
+        <summary>Trigger a contract failure if condition is false.</summary>
+        <remarks />
       </Docs>
     </Member>
     <Member MemberName="Assert">
@@ -67,10 +67,10 @@
         <Parameter Name="userMessage" Type="System.String" />
       </Parameters>
       <Docs>
-        <param name="condition">To be added.</param>
-        <param name="userMessage">To be added.</param>
-        <summary>To be added.</summary>
-        <remarks>To be added.</remarks>
+        <param name="condition">The condition to verify.</param>
+        <param name="userMessage">Message to display if condition is false.</param>
+        <summary>Trigger a contract failure if condition is false.</summary>
+        <remarks />
       </Docs>
     </Member>
     <Member MemberName="Assume">
@@ -97,9 +97,9 @@
         <Parameter Name="condition" Type="System.Boolean" />
       </Parameters>
       <Docs>
-        <param name="condition">To be added.</param>
-        <summary>To be added.</summary>
-        <remarks>To be added.</remarks>
+        <param name="condition">The condition that is assumed to be true.</param>
+        <summary>Forces the condition specified to be considered true by the code contract tools.</summary>
+        <remarks>If the code contracts are included at runtime, this acts like a <see cref="m:System.Diagnostics.Contracts.Contract.Assert()" />.</remarks>
       </Docs>
     </Member>
     <Member MemberName="Assume">
@@ -127,10 +127,10 @@
         <Parameter Name="userMessage" Type="System.String" />
       </Parameters>
       <Docs>
-        <param name="condition">To be added.</param>
-        <param name="userMessage">To be added.</param>
-        <summary>To be added.</summary>
-        <remarks>To be added.</remarks>
+        <param name="condition">The condition that is assumed to be true.</param>
+        <param name="userMessage">Message to display if condition is false.</param>
+        <summary>Forces the condition specified to be considered true by the code contract tools.</summary>
+        <remarks>If the code contracts are included at runtime, this acts like a <see cref="m:System.Diagnostics.Contracts.Contract.Assert()" />.</remarks>
       </Docs>
     </Member>
     <Member MemberName="ContractFailed">
@@ -143,8 +143,13 @@
         <ReturnType>System.EventHandler&lt;System.Diagnostics.Contracts.ContractFailedEventArgs&gt;</ReturnType>
       </ReturnValue>
       <Docs>
-        <summary>To be added.</summary>
-        <remarks>To be added.</remarks>
+        <summary>Called on any contract failure.</summary>
+        <remarks><para>
+Event handlers can mark the contract failure as having been handling by calling <see cref="m:System.Diagnostics.Contracts.ContractFailedEventArgs.SetHandled()" />.
+</para>
+<para>
+Event handlers can this current contract failure unwind the stack by calling <see cref="m:System.Diagnostics.Contracts.ContractFailedEventArgs.SetUnwind()" />. This causes a <see cref="T:System.Diagnostics.Contracts.ContractException" /> to be thrown.
+</para></remarks>
       </Docs>
     </Member>
     <Member MemberName="EndContractBlock">
@@ -166,8 +171,17 @@
       </ReturnValue>
       <Parameters />
       <Docs>
-        <summary>To be added.</summary>
-        <remarks>To be added.</remarks>
+        <summary>Marker method to mark the end of the legacy requires code block.</summary>
+        <remarks>Legacy requires are preconditions that perform tests and throw exceptions. This is the only form of legacy require allowed.
+
+<example>
+  <code lang="C#">
+if (parameter &lt; 0) {
+	throw new ArgumentException();
+}
+Contracts.EndContractBlock();
+  </code>
+</example></remarks>
       </Docs>
     </Member>
     <Member MemberName="Ensures">
@@ -191,9 +205,9 @@
         <Parameter Name="condition" Type="System.Boolean" />
       </Parameters>
       <Docs>
-        <param name="condition">To be added.</param>
-        <summary>To be added.</summary>
-        <remarks>To be added.</remarks>
+        <param name="condition">The postcondition to verify.</param>
+        <summary>Specifies a postconditon contract for normal return.</summary>
+        <remarks>All code contract method calls must be at the beginning of the method or property. The code contract rewriter tool must be used to enable contracts to be verified at runtime.</remarks>
       </Docs>
     </Member>
     <Member MemberName="Ensures">
@@ -218,10 +232,10 @@
         <Parameter Name="userMessage" Type="System.String" />
       </Parameters>
       <Docs>
-        <param name="condition">To be added.</param>
-        <param name="userMessage">To be added.</param>
-        <summary>To be added.</summary>
-        <remarks>To be added.</remarks>
+        <param name="condition">The postcondition to verify.</param>
+        <param name="userMessage">Message to display on contract failure.</param>
+        <summary>Specifies a postconditon contract for normal return.</summary>
+        <remarks>ll code contract method calls must be at the beginning of the method or property. The code contract rewriter tool must be used to enable contracts to be verified at runtime.</remarks>
       </Docs>
     </Member>
     <Member MemberName="EnsuresOnThrow&lt;TException&gt;">
@@ -252,10 +266,10 @@
         <Parameter Name="condition" Type="System.Boolean" />
       </Parameters>
       <Docs>
-        <typeparam name="TException">To be added.</typeparam>
-        <param name="condition">To be added.</param>
-        <summary>To be added.</summary>
-        <remarks>To be added.</remarks>
+        <typeparam name="TException">The exception type that causes this postcondition to be verified.</typeparam>
+        <param name="condition">The postcondition to verify.</param>
+        <summary>Specifies a postcondition contract for when an exception is thrown.</summary>
+        <remarks>All code contract method calls must be at the beginning of the method or property. The code contract rewriter tool must be used to enable contracts to be verified at runtime.</remarks>
       </Docs>
     </Member>
     <Member MemberName="EnsuresOnThrow&lt;TException&gt;">
@@ -287,11 +301,11 @@
         <Parameter Name="userMessage" Type="System.String" />
       </Parameters>
       <Docs>
-        <typeparam name="TException">To be added.</typeparam>
-        <param name="condition">To be added.</param>
-        <param name="userMessage">To be added.</param>
-        <summary>To be added.</summary>
-        <remarks>To be added.</remarks>
+        <typeparam name="TException">The exception type that causes this postcondition to be verified.</typeparam>
+        <param name="condition">The postcondition to verify.</param>
+        <param name="userMessage">Message to display on contract failure.</param>
+        <summary>Specifies a postcondition contract for when an exception is thrown.</summary>
+        <remarks>All code contract method calls must be at the beginning of the method or property. The code contract rewriter tool must be used to enable contracts to be verified at runtime.</remarks>
       </Docs>
     </Member>
     <Member MemberName="Exists">
@@ -314,12 +328,12 @@
         <Parameter Name="predicate" Type="System.Predicate&lt;System.Int32&gt;" />
       </Parameters>
       <Docs>
-        <param name="fromInclusive">To be added.</param>
-        <param name="toExclusive">To be added.</param>
-        <param name="predicate">To be added.</param>
-        <summary>To be added.</summary>
-        <returns>To be added.</returns>
-        <remarks>To be added.</remarks>
+        <param name="fromInclusive">The inclusive start of the range.</param>
+        <param name="toExclusive">The exclusive end of the range.</param>
+        <param name="predicate">TThe predicate to apply to each value within the range.</param>
+        <summary>Determines that at least one value in the range satisfies the predicate.</summary>
+        <returns>Whether at least one value in the range satisfies the predicate.</returns>
+        <remarks>This method can be used within a contract condition to allow contracts to be applied to integer ranges.</remarks>
       </Docs>
     </Member>
     <Member MemberName="Exists&lt;T&gt;">
@@ -344,12 +358,12 @@
         <Parameter Name="predicate" Type="System.Predicate&lt;T&gt;" />
       </Parameters>
       <Docs>
-        <typeparam name="T">To be added.</typeparam>
-        <param name="collection">To be added.</param>
-        <param name="predicate">To be added.</param>
-        <summary>To be added.</summary>
-        <returns>To be added.</returns>
-        <remarks>To be added.</remarks>
+        <typeparam name="T">The type of elements in the collection.</typeparam>
+        <param name="collection">The collection to check.</param>
+        <param name="predicate">The predicate to apply to each element of the collection.</param>
+        <summary>Determines that at least one element in the collection satisfies the predicate.</summary>
+        <returns>Whether at least one element in the collection satisfies the predicate.</returns>
+        <remarks>This method can be used within a contract condition to allow contracts to be applied to collections.</remarks>
       </Docs>
     </Member>
     <Member MemberName="ForAll">
@@ -372,12 +386,12 @@
         <Parameter Name="predicate" Type="System.Predicate&lt;System.Int32&gt;" />
       </Parameters>
       <Docs>
-        <param name="fromInclusive">To be added.</param>
-        <param name="toExclusive">To be added.</param>
-        <param name="predicate">To be added.</param>
-        <summary>To be added.</summary>
-        <returns>To be added.</returns>
-        <remarks>To be added.</remarks>
+        <param name="fromInclusive">The inclusive start of the range.</param>
+        <param name="toExclusive">The exclusive end of the range.</param>
+        <param name="predicate">The predicate to apply to each value within the range.</param>
+        <summary>Determines that all values in the range satisfy the predicate.</summary>
+        <returns>Whether all values in the range satisfy the predicate.</returns>
+        <remarks>This method can be used within a contract condition to allow contracts to be applied to integer ranges.</remarks>
       </Docs>
     </Member>
     <Member MemberName="ForAll&lt;T&gt;">
@@ -402,12 +416,12 @@
         <Parameter Name="predicate" Type="System.Predicate&lt;T&gt;" />
       </Parameters>
       <Docs>
-        <typeparam name="T">To be added.</typeparam>
-        <param name="collection">To be added.</param>
-        <param name="predicate">To be added.</param>
-        <summary>To be added.</summary>
-        <returns>To be added.</returns>
-        <remarks>To be added.</remarks>
+        <typeparam name="T">The type of elements in the collection.</typeparam>
+        <param name="collection">The collection to check.</param>
+        <param name="predicate">The predicate to apply to each element of the collection.</param>
+        <summary>Determines that all elements in the collection satisfy the predicate.</summary>
+        <returns>Whether all elements in the collection satisfy the predicate.</returns>
+        <remarks>This method can be used within a contract condition to allow contracts to be applied to collections.</remarks>
       </Docs>
     </Member>
     <Member MemberName="Invariant">
@@ -431,9 +445,9 @@
         <Parameter Name="condition" Type="System.Boolean" />
       </Parameters>
       <Docs>
-        <param name="condition">To be added.</param>
-        <summary>To be added.</summary>
-        <remarks>To be added.</remarks>
+        <param name="condition">The invariant condition to verify.</param>
+        <summary>Specifies an invariant class-level condition.</summary>
+        <remarks>Invariant conditions can only be used in a method marked with the <see cref="T:System.Diagnostics.Contracts.ContractInvariantMethodAttribute" /> attribute. The code contract rewriter tool must be used to enable contracts to be verified at runtime.</remarks>
       </Docs>
     </Member>
     <Member MemberName="Invariant">
@@ -458,10 +472,10 @@
         <Parameter Name="userMessage" Type="System.String" />
       </Parameters>
       <Docs>
-        <param name="condition">To be added.</param>
-        <param name="userMessage">To be added.</param>
-        <summary>To be added.</summary>
-        <remarks>To be added.</remarks>
+        <param name="condition">The invariant condition to verify.</param>
+        <param name="userMessage">Message to display on contract failure.</param>
+        <summary>Specifies an invariant class-level condition.</summary>
+        <remarks>Invariant conditions can only be used in a method marked with the <see cref="T:System.Diagnostics.Contracts.ContractInvariantMethodAttribute" /> attribute. The code contract rewriter tool must be used to enable contracts to be verified at runtime.</remarks>
       </Docs>
     </Member>
     <Member MemberName="OldValue&lt;T&gt;">
@@ -485,11 +499,11 @@
         <Parameter Name="value" Type="T" />
       </Parameters>
       <Docs>
-        <typeparam name="T">To be added.</typeparam>
-        <param name="value">To be added.</param>
-        <summary>To be added.</summary>
-        <returns>To be added.</returns>
-        <remarks>To be added.</remarks>
+        <typeparam name="T">The type of the value.</typeparam>
+        <param name="value">The field or parameter of which to represent the initial value.</param>
+        <summary>Used within a postcondition to represent an initial value.</summary>
+        <returns>The initial value.</returns>
+        <remarks>The code contract rewriter tool must be used for this method to be effective. Otherwise the default value for the type is returned.</remarks>
       </Docs>
     </Member>
     <Member MemberName="Requires">
@@ -513,9 +527,9 @@
         <Parameter Name="condition" Type="System.Boolean" />
       </Parameters>
       <Docs>
-        <param name="condition">To be added.</param>
-        <summary>To be added.</summary>
-        <remarks>To be added.</remarks>
+        <param name="condition">The precondition to verify.</param>
+        <summary>Specifies a precondition contract for normal return.</summary>
+        <remarks>All code contract method calls must be at the beginning of the method or property. The code contract rewriter tool must be used to enable contracts to be verified at runtime.</remarks>
       </Docs>
     </Member>
     <Member MemberName="Requires">
@@ -540,10 +554,10 @@
         <Parameter Name="userMessage" Type="System.String" />
       </Parameters>
       <Docs>
-        <param name="condition">To be added.</param>
-        <param name="userMessage">To be added.</param>
-        <summary>To be added.</summary>
-        <remarks>To be added.</remarks>
+        <param name="condition">The precondition to verify.</param>
+        <param name="userMessage">Message to display on contract failure.</param>
+        <summary>Specifies a precondition contract for normal return.</summary>
+        <remarks>All code contract method calls must be at the beginning of the method or property. The code contract rewriter tool must be used to enable contracts to be verified at runtime.</remarks>
       </Docs>
     </Member>
     <Member MemberName="Requires&lt;TException&gt;">
@@ -571,10 +585,10 @@
         <Parameter Name="condition" Type="System.Boolean" />
       </Parameters>
       <Docs>
-        <typeparam name="TException">To be added.</typeparam>
-        <param name="condition">To be added.</param>
-        <summary>To be added.</summary>
-        <remarks>To be added.</remarks>
+        <typeparam name="TException">The exception type that causes this precondition to be verified.</typeparam>
+        <param name="condition">The precondition to verify.</param>
+        <summary>Specifies a precondition contract for when an exception is thrown.</summary>
+        <remarks>All code contract method calls must be at the beginning of the method or property. The code contract rewriter tool must be used to enable contracts to be verified at runtime.</remarks>
       </Docs>
     </Member>
     <Member MemberName="Requires&lt;TException&gt;">
@@ -603,11 +617,11 @@
         <Parameter Name="userMessage" Type="System.String" />
       </Parameters>
       <Docs>
-        <typeparam name="TException">To be added.</typeparam>
-        <param name="condition">To be added.</param>
-        <param name="userMessage">To be added.</param>
-        <summary>To be added.</summary>
-        <remarks>To be added.</remarks>
+        <typeparam name="TException">The exception type that causes this precondition to be verified.</typeparam>
+        <param name="condition">The precondition to verify.</param>
+        <param name="userMessage">Message to display on contract failure.</param>
+        <summary>Specifies a precondition contract for when an exception is thrown.</summary>
+        <remarks>All code contract method calls must be at the beginning of the method or property. The code contract rewriter tool must be used to enable contracts to be verified at runtime.</remarks>
       </Docs>
     </Member>
     <Member MemberName="Result&lt;T&gt;">
@@ -629,10 +643,10 @@
       </TypeParameters>
       <Parameters />
       <Docs>
-        <typeparam name="T">To be added.</typeparam>
-        <summary>To be added.</summary>
-        <returns>To be added.</returns>
-        <remarks>To be added.</remarks>
+        <typeparam name="T">The type of the return value.</typeparam>
+        <summary>Used within a postcondition to represent the return value.</summary>
+        <returns>The return value.</returns>
+        <remarks>The code contract rewriter tool must be used for this method to be effective. Otherwise the default value for the type is returned.</remarks>
       </Docs>
     </Member>
     <Member MemberName="ValueAtReturn&lt;T&gt;">
@@ -656,11 +670,11 @@
         <Parameter Name="value" Type="T&amp;" RefType="out" />
       </Parameters>
       <Docs>
-        <typeparam name="T">To be added.</typeparam>
-        <param name="value">To be added.</param>
-        <summary>To be added.</summary>
-        <returns>To be added.</returns>
-        <remarks>To be added.</remarks>
+        <typeparam name="T">The type of the out parameter.</typeparam>
+        <param name="value">The out parameter.</param>
+        <summary>Used within a postcondition to represent the final value of an out parameter.</summary>
+        <returns>The final value of the out parameter.</returns>
+        <remarks>The code contract rewriter tool must be used for this method to be effective. Otherwise the default value for the type is returned in the out parameter and the return value.</remarks>
       </Docs>
     </Member>
   </Members>
Index: Documentation/en/System.Diagnostics.Contracts/ContractRuntimeIgnoredAttribute.xml
===================================================================
--- Documentation/en/System.Diagnostics.Contracts/ContractRuntimeIgnoredAttribute.xml	(revision 159760)
+++ Documentation/en/System.Diagnostics.Contracts/ContractRuntimeIgnoredAttribute.xml	(working copy)
@@ -17,8 +17,8 @@
     </Attribute>
   </Attributes>
   <Docs>
-    <summary>To be added.</summary>
-    <remarks>To be added.</remarks>
+    <summary>Marks a method or property as having no runtime behaviour when called in methods in System.Diagnostics.Contracts.Contract.</summary>
+    <remarks />
   </Docs>
   <Members>
     <Member MemberName=".ctor">
@@ -29,8 +29,8 @@
       </AssemblyInfo>
       <Parameters />
       <Docs>
-        <summary>To be added.</summary>
-        <remarks>To be added.</remarks>
+        <summary>Construct a ContractRuntimeIgnoredAttribute.</summary>
+        <remarks />
       </Docs>
     </Member>
   </Members>
Index: Documentation/en/System.Diagnostics.Contracts/ContractClassForAttribute.xml
===================================================================
--- Documentation/en/System.Diagnostics.Contracts/ContractClassForAttribute.xml	(revision 159760)
+++ Documentation/en/System.Diagnostics.Contracts/ContractClassForAttribute.xml	(working copy)
@@ -17,8 +17,8 @@
     </Attribute>
   </Attributes>
   <Docs>
-    <summary>To be added.</summary>
-    <remarks>To be added.</remarks>
+    <summary>Marks a class as containing contracts for the type specified.</summary>
+    <remarks>Interfaces and abstract methods cannot have their contracts written directly in the code. The <see cref="T:System.Diagnostics.Contracts.ContractClassAttribute" /> and <see cref="T:System.Diagnostics.Contracts.ContractClassForAttribute" /> may be used to specify another class that contains the contracts for an interface or abstract class.</remarks>
   </Docs>
   <Members>
     <Member MemberName=".ctor">
@@ -31,9 +31,9 @@
         <Parameter Name="typeContractsAreFor" Type="System.Type" />
       </Parameters>
       <Docs>
-        <param name="typeContractsAreFor">To be added.</param>
-        <summary>To be added.</summary>
-        <remarks>To be added.</remarks>
+        <param name="typeContractsAreFor">The type (interface or abstract class) for which these are the code contract specifications.</param>
+        <summary>Constructs a ContractClassForAttribute, specifying the type (interface or abstract class) for which these are the code contract specifications.</summary>
+        <remarks />
       </Docs>
     </Member>
     <Member MemberName="TypeContractsAreFor">
@@ -46,9 +46,9 @@
         <ReturnType>System.Type</ReturnType>
       </ReturnValue>
       <Docs>
-        <summary>To be added.</summary>
-        <value>To be added.</value>
-        <remarks>To be added.</remarks>
+        <summary>Get the type for which these are the code contract specifications.</summary>
+        <value>The type for which these are the code contract specifications.</value>
+        <remarks />
       </Docs>
     </Member>
   </Members>
Index: Documentation/en/System.Diagnostics.Contracts/ContractInvariantMethodAttribute.xml
===================================================================
--- Documentation/en/System.Diagnostics.Contracts/ContractInvariantMethodAttribute.xml	(revision 159760)
+++ Documentation/en/System.Diagnostics.Contracts/ContractInvariantMethodAttribute.xml	(working copy)
@@ -17,8 +17,8 @@
     </Attribute>
   </Attributes>
   <Docs>
-    <summary>To be added.</summary>
-    <remarks>To be added.</remarks>
+    <summary>Specifies that this method contains Contract invariant conditions for this class.</summary>
+    <remarks>There may be multiple methods with this attribute in one class, their effect is accumulated. The method must take no parameters and return void, and may be any visibility.</remarks>
   </Docs>
   <Members>
     <Member MemberName=".ctor">
@@ -29,8 +29,8 @@
       </AssemblyInfo>
       <Parameters />
       <Docs>
-        <summary>To be added.</summary>
-        <remarks>To be added.</remarks>
+        <summary>Construct a ContractInvariantMethodAttribute.</summary>
+        <remarks />
       </Docs>
     </Member>
   </Members>
Index: Documentation/en/System.Diagnostics.Contracts/PureAttribute.xml
===================================================================
--- Documentation/en/System.Diagnostics.Contracts/PureAttribute.xml	(revision 159760)
+++ Documentation/en/System.Diagnostics.Contracts/PureAttribute.xml	(working copy)
@@ -17,8 +17,13 @@
     </Attribute>
   </Attributes>
   <Docs>
-    <summary>To be added.</summary>
-    <remarks>To be added.</remarks>
+    <summary>Marks a method or type to indicate that it has no side effects.</summary>
+    <remarks><para>
+Only methods marked Pure may be used within code contract definitions. This is to ensure that checking a contract causes no side-effects.
+</para>
+<para>
+Methods within the System.Diagnostics.Contracts namespace are always considered to be pure. Some delegates are always considered to be pure, such as <see cref="T:System.Predicate&lt;T&gt;" /> and <see cref="T:System.Comparison&lt;T&gt;" />.
+</para></remarks>
   </Docs>
   <Members>
     <Member MemberName=".ctor">
@@ -29,8 +34,8 @@
       </AssemblyInfo>
       <Parameters />
       <Docs>
-        <summary>To be added.</summary>
-        <remarks>To be added.</remarks>
+        <summary>Construct a PureAttribute.</summary>
+        <remarks />
       </Docs>
     </Member>
   </Members>
