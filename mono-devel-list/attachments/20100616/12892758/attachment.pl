Index: ChangeLog
===================================================================
--- ChangeLog	(revision 159003)
+++ ChangeLog	(working copy)
@@ -1,3 +1,7 @@
+2010-06-16  Chris Bacon <chrisbacon76@gmail.com>
+
+	* corlib.dll.sources: Add files required for Code Contracts.
+
 2010-05-23  Carlos Alberto Cortez <calberto.cortez@gmail.com>
 
 	* corlib.dll.sources: Add System.IO.IsolatedStorageSecurityState.cs
Index: corlib.dll.sources
===================================================================
--- corlib.dll.sources	(revision 159003)
+++ corlib.dll.sources	(working copy)
@@ -331,14 +331,17 @@
 System.Diagnostics.Contracts/Contract.cs
 System.Diagnostics.Contracts/ContractClassAttribute.cs
 System.Diagnostics.Contracts/ContractClassForAttribute.cs
+System.Diagnostics.Contracts/ContractException.cs
 System.Diagnostics.Contracts/ContractFailedEventArgs.cs
 System.Diagnostics.Contracts/ContractFailureKind.cs
 System.Diagnostics.Contracts/ContractInvariantMethodAttribute.cs
 System.Diagnostics.Contracts/ContractPublicPropertyNameAttribute.cs
 System.Diagnostics.Contracts/ContractReferenceAssemblyAttribute.cs
 System.Diagnostics.Contracts/ContractRuntimeIgnoredAttribute.cs
+System.Diagnostics.Contracts/ContractShouldAssertException.cs
 System.Diagnostics.Contracts/ContractVerificationAttribute.cs
 System.Diagnostics.Contracts/PureAttribute.cs
+System.Diagnostics.Contracts/Internal/ContractHelper.cs
 System.Diagnostics.SymbolStore/ISymbolBinder.cs
 System.Diagnostics.SymbolStore/ISymbolBinder1.cs
 System.Diagnostics.SymbolStore/ISymbolDocument.cs
Index: System.Diagnostics.Contracts/Contract.cs
===================================================================
--- System.Diagnostics.Contracts/Contract.cs	(revision 159003)
+++ System.Diagnostics.Contracts/Contract.cs	(working copy)
@@ -3,8 +3,9 @@
 //
 // Authors:
 //    Miguel de Icaza (miguel@gnome.org)
+//    Chris Bacon (chrisbacon76@gmail.com)
 //
-// Copyright 2009 Novell (http://www.novell.com)
+// Copyright 2009, 2010 Novell (http://www.novell.com)
 //
 // Permission is hereby granted, free of charge, to any person obtaining
 // a copy of this software and associated documentation files (the
@@ -26,30 +27,15 @@
 // WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 //
 
-//
-// Things left to do:
-// 
-//   * This is a blind implementation from specs, without any testing, so the escalation
-//     is probably broken, and so are the messages and arguments to the eventargs properties
-//
-//   * How to plug the original condition into the Escalate method?   Perhaps we need
-//     some injection for it?
-//
-//   * The "originalException" in Escalate is nowhere used
-//
-//   * We do not Escalate everything that needs to be, perhaps that is the role of the
-//     rewriter to call Escalate with the proper values?
-//
-//   * I added a "new()" constraint to methods that took a TException because I needed
-//     to new the exception, but this is perhaps wrong.
-//
-//   * Result and ValueAtReturn, I need to check what these do in .NET 4, but have not
-//     installed it yet ;-)
-//
 using System;
 using System.Collections.Generic;
+using System.Diagnostics.Contracts.Internal;
 
 namespace System.Diagnostics.Contracts {
+
+	/// <summary>
+	/// Contains methods that allow various contracts to be specified in code.
+	/// </summary>
 #if NET_2_1 || NET_4_0
 	public
 #else
@@ -58,38 +44,90 @@
 
 	static class Contract {
 
+		/// <summary>
+		/// Called on any contract failure.
+		/// </summary>
 		public static event EventHandler<ContractFailedEventArgs> ContractFailed;
 
-		static void Escalate (ContractFailureKind kind, Exception e, string text, params object [] args)
+		// Used in test
+		internal static EventHandler<ContractFailedEventArgs> InternalContractFailedEvent
 		{
-			if (ContractFailed != null){
-				var ea = new ContractFailedEventArgs (kind, text, "<condition>", e ?? new Exception ());
-				ContractFailed (null, ea);
-				if (!ea.Unwind)
-					return;
+			get { return ContractFailed; }
+		}
+
+		// Used in test
+		internal static Type GetContractExceptionType ()
+		{
+			return typeof (ContractException);
+		}
+
+		// Used in test
+		internal static Type GetContractShouldAssertExceptionType ()
+		{
+			return typeof (ContractShouldAssertException);
+		}
+
+		static void ReportFailure (ContractFailureKind kind, string userMessage, string conditionText, Exception innerException)
+		{
+			string msg = ContractHelper.RaiseContractFailedEvent (kind, userMessage, conditionText, innerException);
+			// if msg is null, then it has been handled already, so don't do anything here
+			if (msg != null)
+				ContractHelper.TriggerFailure (kind, msg, userMessage, conditionText, innerException);
+		}
+
+		static void AssertMustUseRewriter (ContractFailureKind kind, string message)
+		{
+			if (Environment.UserInteractive) {
+				// FIXME: This should trigger an assertion.
+				// But code will never get here at the moment, as Environment.UserInteractive currently
+				// always returns false.
+				throw new ContractShouldAssertException (message);
+			} else {
+				// Note that FailFast() currently throws a NotImplemenetedException()
+#if NET_4_0
+				Environment.FailFast(message, new ExecutionEngineException());
+#else
+				Environment.FailFast(message);
+#endif
 			}
-			Console.Error.WriteLine ("Contract.{0}: {1}", kind.ToString (), String.Format (text, args));
 		}
-		
+
+		/// <summary>
+		/// Trigger a contract failure if condition is false.
+		/// </summary>
+		/// <param name="condition">The condition to verify.</param>
 		[ConditionalAttribute("CONTRACTS_FULL")]
 		[ConditionalAttribute("DEBUG")]
 		public static void Assert (bool condition)
 		{
 			if (condition)
 				return;
-			Escalate (ContractFailureKind.Assert, null, "failure");
+
+			ReportFailure (ContractFailureKind.Assert, null, null, null);
 		}
 
+		/// <summary>
+		/// Trigger a contract failure if condition is false.
+		/// </summary>
+		/// <param name="condition">The condition to verify.</param>
+		/// <param name="userMessage">Message to display if condition is false.</param>
 		[ConditionalAttribute("DEBUG")]
 		[ConditionalAttribute("CONTRACTS_FULL")]
 		public static void Assert (bool condition, string userMessage)
 		{
 			if (condition)
 				return;
-			
-			Escalate (ContractFailureKind.Assert, null, userMessage);
+
+			ReportFailure (ContractFailureKind.Assert, userMessage, null, null);
 		}
 
+		/// <summary>
+		/// Forces the condition specified to be considered true by the code contract tools.
+		/// </summary>
+		/// <param name="condition">The condition that is assumed to be true.</param>
+		/// <remarks>
+		/// If the code contracts are included at runtime, this acts like a Contract.Assert().
+		/// </remarks>
 		[ConditionalAttribute("DEBUG")]
 		[ConditionalAttribute("CONTRACTS_FULL")]
 		public static void Assume(bool condition)
@@ -98,49 +136,111 @@
 			if (condition)
 				return;
 
-			Escalate (ContractFailureKind.Assume, null, "failure");
+			ReportFailure (ContractFailureKind.Assume, null, null, null);
 		}
 
+		/// <summary>
+		/// Forces the condition specified to be considered true by the code contract tools.
+		/// </summary>
+		/// <param name="condition">The condition that is assumed to be true.</param>
+		/// <param name="userMessage">Message to display if condition is false.</param>
+		/// <remarks>
+		/// If the code contracts are included at runtime, this acts like a Contract.Assert().
+		/// </remarks>
 		[ConditionalAttribute("CONTRACTS_FULL")]
 		[ConditionalAttribute("DEBUG")]
 		public static void Assume (bool condition, string userMessage)
 		{
+			// At runtime, this behaves like assert
 			if (condition)
 				return;
-			
-			Escalate (ContractFailureKind.Assume, null, userMessage);
+
+			ReportFailure (ContractFailureKind.Assume, userMessage, null, null);
 		}
 
+		/// <summary>
+		/// Marker method to mark the end of the legacy requires code block.
+		/// </summary>
+		/// <remarks>
+		/// Legacy requires are preconditions that perform tests and throw exceptions.
+		/// This is the only form of legacy require allowed.
+		/// </remarks>
 		[ConditionalAttribute("CONTRACTS_FULL")]
 		public static void EndContractBlock ()
 		{
-			// seems to be some kind of flag, no code generated
+			// Marker method, no code required.
 		}
 
+		/// <summary>
+		/// Specifies a postconditon contract for normal return.
+		/// </summary>
+		/// <param name="condition">The postcondition to verify.</param>
+		/// <remarks>
+		/// All code contract method calls must be at the beginning of the method or property.
+		/// The code contract rewriter tool must be used to enable contracts to be verified at runtime.
+		/// </remarks>
 		[ConditionalAttribute("CONTRACTS_FULL")]
 		public static void Ensures (bool condition)
 		{
-			// Requires binary rewriter to work
+			AssertMustUseRewriter (ContractFailureKind.Postcondition, "Contract.Ensures");
 		}
 
+		/// <summary>
+		/// Specifies a postconditon contract for normal return.
+		/// </summary>
+		/// <param name="condition">The postcondition to verify.</param>
+		/// <param name="userMessage">Message to display on contract failure.</param>
+		/// <remarks>
+		/// All code contract method calls must be at the beginning of the method or property.
+		/// The code contract rewriter tool must be used to enable contracts to be verified at runtime.
+		/// </remarks>
 		[ConditionalAttribute("CONTRACTS_FULL")]
 		public static void Ensures (bool condition, string userMessage)
 		{
-			// Requires binary rewriter to work
+			AssertMustUseRewriter (ContractFailureKind.Postcondition, "Contract.Ensures");
 		}
 
+		/// <summary>
+		/// Specifies a postcondition contract for when an exception is thrown.
+		/// </summary>
+		/// <typeparam name="TException">The exception type that causes this postcondition to be verified.</typeparam>
+		/// <param name="condition">The postcondition to verify.</param>
+		/// <remarks>
+		/// All code contract method calls must be at the beginning of the method or property.
+		/// The code contract rewriter tool must be used to enable contracts to be verified at runtime.
+		/// </remarks>
 		[ConditionalAttribute("CONTRACTS_FULL")]
 		public static void EnsuresOnThrow<TException> (bool condition) where TException : Exception
 		{
-			// Requires binary rewriter to work
+			AssertMustUseRewriter (ContractFailureKind.Postcondition, "Contract.EnsuresOnThrow");
 		}
 
+		/// <summary>
+		/// Specifies a postcondition contract for when an exception is thrown.
+		/// </summary>
+		/// <typeparam name="TException">The exception type that causes this postcondition to be verified.</typeparam>
+		/// <param name="condition">The postcondition to verify.</param>
+		/// <param name="userMessage">Message to display on contract failure.</param>
+		/// <remarks>
+		/// All code contract method calls must be at the beginning of the method or property.
+		/// The code contract rewriter tool must be used to enable contracts to be verified at runtime.
+		/// </remarks>
 		[ConditionalAttribute("CONTRACTS_FULL")]
 		public static void EnsuresOnThrow<TException> (bool condition, string userMessage) where TException : Exception
 		{
-			// Requires binary rewriter to work
+			AssertMustUseRewriter (ContractFailureKind.Postcondition, "Contract.EnsuresOnThrow");
 		}
 
+		/// <summary>
+		/// Determines that at least one element in the collection satisfies the predicate.
+		/// </summary>
+		/// <typeparam name="T">The type of elements in the collection.</typeparam>
+		/// <param name="collection">The collection to check.</param>
+		/// <param name="predicate">The predicate to apply to each element of the collection.</param>
+		/// <returns>Whether at least one element in the collection satisfies the predicate.</returns>
+		/// <remarks>
+		/// This method can be used within a contract condition to allow contracts to be applied to collections.
+		/// </remarks>
 		public static bool Exists<T> (IEnumerable<T> collection, Predicate<T> predicate)
 		{
 			if (predicate == null)
@@ -154,6 +254,16 @@
 			return false;
 		}
 
+		/// <summary>
+		/// Determines that at least one value in the range satisfies the predicate.
+		/// </summary>
+		/// <param name="fromInclusive">The inclusive start of the range.</param>
+		/// <param name="toExclusive">The exclusive end of the range.</param>
+		/// <param name="predicate">The predicate to apply to each value within the range.</param>
+		/// <returns>Whether at least one value in the range satisfies the predicate.</returns>
+		/// <remarks>
+		/// This method can be used within a contract condition to allow contracts to be applied to integer ranges.
+		/// </remarks>
 		public static bool Exists (int fromInclusive, int toExclusive, Predicate<int> predicate)
 		{
 			if (predicate == null)
@@ -168,6 +278,16 @@
 			return false;
 		}
 
+		/// <summary>
+		/// Determines that all elements in the collection satisfy the predicate.
+		/// </summary>
+		/// <typeparam name="T">The type of elements in the collection.</typeparam>
+		/// <param name="collection">The collection to check.</param>
+		/// <param name="predicate">The predicate to apply to each element of the collection.</param>
+		/// <returns>Whether all elements in the collection satisfy the predicate.</returns>
+		/// <remarks>
+		/// This method can be used within a contract condition to allow contracts to be applied to collections.
+		/// </remarks>
 		public static bool ForAll<T> (IEnumerable<T> collection, Predicate<T> predicate)
 		{
 			if (predicate == null)
@@ -182,6 +302,16 @@
 			return true;
 		}
 
+		/// <summary>
+		/// Determines that all values in the range satisfy the predicate.
+		/// </summary>
+		/// <param name="fromInclusive">The inclusive start of the range.</param>
+		/// <param name="toExclusive">The exclusive end of the range.</param>
+		/// <param name="predicate">The predicate to apply to each value within the range.</param>
+		/// <returns>Whether all values in the range satisfy the predicate.</returns>
+		/// <remarks>
+		/// This method can be used within a contract condition to allow contracts to be applied to integer ranges.
+		/// </remarks>
 		public static bool ForAll (int fromInclusive, int toExclusive, Predicate<int> predicate)
 		{
 			if (predicate == null)
@@ -196,75 +326,137 @@
 			return true;
 		}
 
+		/// <summary>
+		/// Specifies an invariant class-level condition.
+		/// </summary>
+		/// <param name="condition">The invariant condition to verify.</param>
+		/// <remarks>
+		/// Invariant conditions can only be used in a method marked with the ContractInvariantMethod attribute.
+		/// The code contract rewriter tool must be used to enable contracts to be verified at runtime.
+		/// </remarks>
 		[ConditionalAttribute("CONTRACTS_FULL")]
 		public static void Invariant (bool condition)
 		{
-			// Binary rewriter required
+			AssertMustUseRewriter (ContractFailureKind.Invariant, "Contract.Invariant");
 		}
 
+		/// <summary>
+		/// Specifies an invariant class-level condition.
+		/// </summary>
+		/// <param name="condition">The invariant condition to verify.</param>
+		/// <param name="userMessage">Message to display on contract failure.</param>
 		[ConditionalAttribute("CONTRACTS_FULL")]
 		public static void Invariant (bool condition, string userMessage)
 		{
-			// Binary rewriter required
+			AssertMustUseRewriter (ContractFailureKind.Invariant, "Contract.Invariant");
 		}
 
-		static Exception RewriterRequired ()
-		{
-			return new Exception ("The rewriter is required to use this method");
-		}
-	
+		/// <summary>
+		/// Used within a postcondition to represent an initial value.
+		/// </summary>
+		/// <typeparam name="T">The type of the value.</typeparam>
+		/// <param name="value">The field or parameter of which to represent the initial value.</param>
+		/// <returns>The initial value.</returns>
+		/// <remarks>
+		/// The code contract rewriter tool must be used for this method to be effective.
+		/// Otherwise the default value for the type is returned.
+		/// </remarks>
 		public static T OldValue<T> (T value)
 		{
-			// This is really the binary rewriter that should kick-in
-			throw RewriterRequired ();
+			// Marker method, no code required.
+			return default (T);
 		}
 
+		/// <summary>
+		/// Specifies a precondition contract for normal return.
+		/// </summary>
+		/// <param name="condition">The precondition to verify.</param>
+		/// <remarks>
+		/// All code contract method calls must be at the beginning of the method or property.
+		/// The code contract rewriter tool must be used to enable contracts to be verified at runtime.
+		/// </remarks>
 		[ConditionalAttribute("CONTRACTS_FULL")]
-		[MonoTODO ("Currently throws Exception, needs to throw the proper exception")]
 		public static void Requires (bool condition)
 		{
-			if (!condition){
-				Escalate (ContractFailureKind.Precondition, null, "failure");
-				throw new Exception ();
-			}
+			AssertMustUseRewriter (ContractFailureKind.Precondition, "Contract.Requires");
 		}
 
+		/// <summary>
+		/// Specifies a precondition contract for normal return.
+		/// </summary>
+		/// <param name="condition">The precondition to verify.</param>
+		/// <param name="userMessage">Message to display on contract failure.</param>
+		/// <remarks>
+		/// All code contract method calls must be at the beginning of the method or property.
+		/// The code contract rewriter tool must be used to enable contracts to be verified at runtime.
+		/// </remarks>
 		[ConditionalAttribute("CONTRACTS_FULL")]
-		[MonoTODO ("Currently throws Exception, needs to throw the proper exception")]
 		public static void Requires (bool condition, string userMessage)
 		{
-			if (!condition){
-				Escalate (ContractFailureKind.Precondition, null, userMessage);
-				throw new Exception ();
-			}
+			AssertMustUseRewriter (ContractFailureKind.Precondition, "Contract.Requires");
 		}
 
-		public static void Requires<TException> (bool condition) where TException : Exception, new ()
+		/// <summary>
+		/// Specifies a precondition contract for when an exception is thrown.
+		/// </summary>
+		/// <typeparam name="TException">The exception type that causes this precondition to be verified.</typeparam>
+		/// <param name="condition">The precondition to verify.</param>
+		/// <remarks>
+		/// All code contract method calls must be at the beginning of the method or property.
+		/// The code contract rewriter tool must be used to enable contracts to be verified at runtime.
+		/// </remarks>
+		public static void Requires<TException> (bool condition) where TException : Exception
 		{
-			if (!condition){
-				var e = new TException ();
-				Escalate (ContractFailureKind.Precondition, e, "failure");
-				throw e;
-			}
+			AssertMustUseRewriter (ContractFailureKind.Precondition, "Contract.Requires<TException>");
 		}
 
-		public static void Requires<TException>(bool condition, string userMessage) where TException : Exception, new ()
+		/// <summary>
+		/// Specifies a precondition contract for when an exception is thrown.
+		/// </summary>
+		/// <typeparam name="TException">The exception type that causes this precondition to be verified.</typeparam>
+		/// <param name="condition">The precondition to verify.</param>
+		/// <param name="userMessage">Message to display on contract failure.</param>
+		/// <remarks>
+		/// All code contract method calls must be at the beginning of the method or property.
+		/// The code contract rewriter tool must be used to enable contracts to be verified at runtime.
+		/// </remarks>
+		public static void Requires<TException> (bool condition, string userMessage) where TException : Exception
 		{
-			if (!condition){
-				var e = new TException ();
-				Escalate (ContractFailureKind.Precondition, e, userMessage);
-				throw e;
-			}
+			AssertMustUseRewriter (ContractFailureKind.Precondition, "Contract.Requires<TException>");
 		}
 
+		/// <summary>
+		/// Used within a postcondition to represent the return value.
+		/// </summary>
+		/// <typeparam name="T">The type of the return value.</typeparam>
+		/// <returns>The return value.</returns>
+		/// <remarks>
+		/// The code contract rewriter tool must be used for this method to be effective.
+		/// Otherwise the default value for the type is returned.
+		/// </remarks>
 		public static T Result<T> ()
 		{
-			throw RewriterRequired ();
+			// Marker method, no code required.
+			return default (T);
 		}
 
+		/// <summary>
+		/// Used within a postcondition to represent the final value of an out parameter.
+		/// </summary>
+		/// <typeparam name="T">The type of the out parameter.</typeparam>
+		/// <param name="value">The out parameter.</param>
+		/// <returns>The final value of the out parameter.</returns>
+		/// <remarks>
+		/// The code contract rewriter tool must be used for this method to be effective.
+		/// Otherwise the default value for the type is returned in the out parameter and the return value.
+		/// </remarks>
 		public static T ValueAtReturn<T> (out T value)
 		{
-			throw RewriterRequired ();
+			// Marker method, no code required.
+			value = default (T);
+			return default (T);
 		}
+
 	}
+
 }

Property changes on: System.Diagnostics.Contracts/Contract.cs
___________________________________________________________________
Added: svn:eol-style
   + native

Index: System.Diagnostics.Contracts/ContractRuntimeIgnoredAttribute.cs
===================================================================
--- System.Diagnostics.Contracts/ContractRuntimeIgnoredAttribute.cs	(revision 159003)
+++ System.Diagnostics.Contracts/ContractRuntimeIgnoredAttribute.cs	(working copy)
@@ -28,6 +28,11 @@
 #if NET_2_1 || NET_4_0
 using System;
 namespace System.Diagnostics.Contracts {
+
+	/// <summary>
+	/// Marks a method or property as having no runtime behaviour when called
+	/// in methods in System.Diagnostics.Contracts.Contract.
+	/// </summary>
 	[Conditional ("CONTRACTS_FULL")]
 	[AttributeUsage (AttributeTargets.Method | AttributeTargets.Property, AllowMultiple=false, Inherited = true)]
 	public sealed class ContractRuntimeIgnoredAttribute : Attribute {

Property changes on: System.Diagnostics.Contracts/ContractRuntimeIgnoredAttribute.cs
___________________________________________________________________
Added: svn:eol-style
   + native

Index: System.Diagnostics.Contracts/ContractInvariantMethodAttribute.cs
===================================================================
--- System.Diagnostics.Contracts/ContractInvariantMethodAttribute.cs	(revision 159003)
+++ System.Diagnostics.Contracts/ContractInvariantMethodAttribute.cs	(working copy)
@@ -28,6 +28,14 @@
 #if NET_2_1 || NET_4_0
 using System;
 namespace System.Diagnostics.Contracts {
+
+	/// <summary>
+	/// Specifies that this method contains Contract invariant conditions for this class.
+	/// </summary>
+	/// <remarks>
+	/// There may be multiple methods with this attribute in one class, their effect is accumulated.
+	/// The method must take no parameters and return void, and may be any visibility.
+	/// </remarks>
 	[Conditional ("CONTRACTS_FULL")]
 	[AttributeUsage (AttributeTargets.Method, Inherited=false)]
 	public sealed class ContractInvariantMethodAttribute : Attribute {

Property changes on: System.Diagnostics.Contracts/ContractInvariantMethodAttribute.cs
___________________________________________________________________
Added: svn:eol-style
   + native

Index: System.Diagnostics.Contracts/ContractReferenceAssemblyAttribute.cs
===================================================================
--- System.Diagnostics.Contracts/ContractReferenceAssemblyAttribute.cs	(revision 159003)
+++ System.Diagnostics.Contracts/ContractReferenceAssemblyAttribute.cs	(working copy)
@@ -28,6 +28,11 @@
 #if NET_2_1 || NET_4_0
 using System;
 namespace System.Diagnostics.Contracts {
+
+	/// <summary>
+	/// Marks an assembly as being a contarct reference assembly.
+	/// This assembly will contain no code except as required by the contracts.
+	/// </summary>
 	[AttributeUsage (AttributeTargets.Assembly)]
 	public sealed class ContractReferenceAssemblyAttribute : Attribute {
 		public ContractReferenceAssemblyAttribute () {}

Property changes on: System.Diagnostics.Contracts/ContractReferenceAssemblyAttribute.cs
___________________________________________________________________
Added: svn:eol-style
   + native

Index: System.Diagnostics.Contracts/ChangeLog
===================================================================
--- System.Diagnostics.Contracts/ChangeLog	(revision 159003)
+++ System.Diagnostics.Contracts/ChangeLog	(working copy)
@@ -1,3 +1,10 @@
+2010-06-07  Chris Bacon <chrisbacon76@gmail.com>
+
+	* Contract.cs: Implemented correct runtime behaviour without rewriter.
+	* ContractException.cs: New file
+	* ContractShouldAssertException.cs: New file. Used to simulate Asserts because
+	  Mono doesn't have a way of asserting from within corlib.
+
 2010-03-11  Sebastien Pouliot  <sebastien@ximian.com>
 
 	* *.cs: Add NET_2_1 since contracts are part of SL4 :-)
Index: System.Diagnostics.Contracts/ContractClassAttribute.cs
===================================================================
--- System.Diagnostics.Contracts/ContractClassAttribute.cs	(revision 159003)
+++ System.Diagnostics.Contracts/ContractClassAttribute.cs	(working copy)
@@ -28,6 +28,10 @@
 #if NET_2_1 || NET_4_0
 using System;
 namespace System.Diagnostics.Contracts {
+
+	/// <summary>
+	/// Marks this type as having another class that contains its code contracts.
+	/// </summary>
 	[Conditional ("CONTRACTS_FULL")]
 	[Conditional ("DEBUG")]
 	[AttributeUsage (AttributeTargets.Class | AttributeTargets.Interface | AttributeTargets.Delegate, Inherited=false)]

Property changes on: System.Diagnostics.Contracts/ContractClassAttribute.cs
___________________________________________________________________
Added: svn:eol-style
   + native

Index: System.Diagnostics.Contracts/ContractFailureKind.cs
===================================================================
--- System.Diagnostics.Contracts/ContractFailureKind.cs	(revision 159003)
+++ System.Diagnostics.Contracts/ContractFailureKind.cs	(working copy)
@@ -30,6 +30,9 @@
 
 namespace System.Diagnostics.Contracts {
 
+	/// <summary>
+	/// The different kinds of contracts that can fail.
+	/// </summary>
 #if NET_2_1 || NET_4_0
 	public
 #else

Property changes on: System.Diagnostics.Contracts/ContractFailureKind.cs
___________________________________________________________________
Added: svn:eol-style
   + native

Index: System.Diagnostics.Contracts/ContractException.cs
===================================================================
--- System.Diagnostics.Contracts/ContractException.cs	(revision 0)
+++ System.Diagnostics.Contracts/ContractException.cs	(revision 0)
@@ -0,0 +1,56 @@
+//
+// System.Diagnostics.Contracts.ContractException.cs
+//
+// Authors:
+//    Chris Bacon (chrisbacon76@gmail.com)
+//
+// Copyright 2010 Novell (http://www.novell.com)
+//
+// Permission is hereby granted, free of charge, to any person obtaining
+// a copy of this software and associated documentation files (the
+// "Software"), to deal in the Software without restriction, including
+// without limitation the rights to use, copy, modify, merge, publish,
+// distribute, sublicense, and/or sell copies of the Software, and to
+// permit persons to whom the Software is furnished to do so, subject to
+// the following conditions:
+// 
+// The above copyright notice and this permission notice shall be
+// included in all copies or substantial portions of the Software.
+// 
+// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
+// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
+// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
+// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+//
+#if NET_2_1 || NET_4_0
+
+using System;
+
+namespace System.Diagnostics.Contracts {
+
+	class ContractException : Exception {
+
+		internal ContractException (string failure, ContractFailureKind kind, string condition, string userMessage, Exception innerException)
+			: base (failure, innerException)
+		{
+			this.Failure = failure;
+			this.Kind = kind;
+			this.Condition = condition;
+			this.UserMessage = userMessage;
+		}
+
+		public string Failure { get; private set; }
+
+		public ContractFailureKind Kind { get; private set; }
+
+		public string Condition { get; private set; }
+
+		public string UserMessage { get; private set; }
+
+	}
+
+}
+#endif

Property changes on: System.Diagnostics.Contracts/ContractException.cs
___________________________________________________________________
Added: svn:eol-style
   + native

Index: System.Diagnostics.Contracts/ContractShouldAssertException.cs
===================================================================
--- System.Diagnostics.Contracts/ContractShouldAssertException.cs	(revision 0)
+++ System.Diagnostics.Contracts/ContractShouldAssertException.cs	(revision 0)
@@ -0,0 +1,42 @@
+//
+// System.Diagnostics.Contracts.ContractException.cs
+//
+// Authors:
+//    Chris Bacon (chrisbacon76@gmail.com)
+//
+// Copyright 2010 Novell (http://www.novell.com)
+//
+// Permission is hereby granted, free of charge, to any person obtaining
+// a copy of this software and associated documentation files (the
+// "Software"), to deal in the Software without restriction, including
+// without limitation the rights to use, copy, modify, merge, publish,
+// distribute, sublicense, and/or sell copies of the Software, and to
+// permit persons to whom the Software is furnished to do so, subject to
+// the following conditions:
+// 
+// The above copyright notice and this permission notice shall be
+// included in all copies or substantial portions of the Software.
+// 
+// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
+// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
+// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
+// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+//
+
+using System;
+
+namespace System.Diagnostics.Contracts {
+
+	class ContractShouldAssertException : Exception {
+
+		public ContractShouldAssertException (string msg)
+			: base (msg)
+		{
+		}
+
+	}
+
+}

Property changes on: System.Diagnostics.Contracts/ContractShouldAssertException.cs
___________________________________________________________________
Added: svn:eol-style
   + native

Index: System.Diagnostics.Contracts/ContractClassForAttribute.cs
===================================================================
--- System.Diagnostics.Contracts/ContractClassForAttribute.cs	(revision 159003)
+++ System.Diagnostics.Contracts/ContractClassForAttribute.cs	(working copy)
@@ -28,8 +28,12 @@
 #if NET_2_1 || NET_4_0
 using System;
 namespace System.Diagnostics.Contracts {
+
+	/// <summary>
+	/// Marks a class as containing contracts for the type specified.
+	/// </summary>
 	[Conditional ("CONTRACTS_FULL")]
-	[AttributeUsage (AttributeTargets.Delegate | AttributeTargets.Interface | AttributeTargets.Class, Inherited=false)]
+	[AttributeUsage (AttributeTargets.Class, Inherited = false)]
 	public sealed class ContractClassForAttribute : Attribute {
 		Type type;
 

Property changes on: System.Diagnostics.Contracts/ContractClassForAttribute.cs
___________________________________________________________________
Added: svn:eol-style
   + native

Index: System.Diagnostics.Contracts/PureAttribute.cs
===================================================================
--- System.Diagnostics.Contracts/PureAttribute.cs	(revision 159003)
+++ System.Diagnostics.Contracts/PureAttribute.cs	(working copy)
@@ -32,6 +32,10 @@
 
 namespace System.Diagnostics.Contracts
 {
+
+	/// <summary>
+	/// Marks a method or type to indicate that it has no side effects.
+	/// </summary>
 	[ConditionalAttribute("CONTRACTS_FULL")]
 	[AttributeUsageAttribute (AttributeTargets.Class | AttributeTargets.Constructor | AttributeTargets.Method | AttributeTargets.Property | AttributeTargets.Event | AttributeTargets.Parameter | AttributeTargets.Delegate)]
 	public sealed class PureAttribute : Attribute
Index: System.Diagnostics.Contracts/ContractFailedEventArgs.cs
===================================================================
--- System.Diagnostics.Contracts/ContractFailedEventArgs.cs	(revision 159003)
+++ System.Diagnostics.Contracts/ContractFailedEventArgs.cs	(working copy)
@@ -3,6 +3,7 @@
 //
 // Authors:
 //    Miguel de Icaza (miguel@gnome.org)
+//    Chris Bacon (chrisbacon76@gmail.com)
 //
 // Copyright 2009 Novell (http://www.novell.com)
 //
@@ -30,6 +31,9 @@
 
 namespace System.Diagnostics.Contracts {
 
+	/// <summary>
+	/// Contains event data for the Contract.ContractFailed event.
+	/// </summary>
 #if NET_2_1 || NET_4_0
 	public
 #else
@@ -42,27 +46,55 @@
 			Condition = condition;
 			FailureKind = failureKind;
 			Handled = false;
-			Unwind = true;
+			Unwind = false; // MS docs are incorrect - this should default to false.
 			Message = message;
 			OriginalException = originalException;
 		}
 
+		/// <summary>
+		/// Mark this contract failure as having been handled.
+		/// </summary>
 		public void SetHandled ()
 		{
 			Handled = true;
 		}
 
+		/// <summary>
+		/// Request that this contract failure unwind the stack by throwing an exception.
+		/// </summary>
 		public void SetUnwind ()
 		{
 			Unwind = true;
 		}
 
+		/// <summary>
+		/// Gets the condition that caused the contract failure.
+		/// </summary>
 		public string Condition { get; private set; }
+
+		/// <summary>
+		/// Gets the kind of contract failure.
+		/// </summary>
 		public ContractFailureKind FailureKind { get; private set; }
+
+		/// <summary>
+		/// Gets whether the contract failure has been handled.
+		/// </summary>
 		public bool Handled { get; private set; }
+
+		/// <summary>
+		/// Gets whether the contract failure should unwind the stack.
+		/// </summary>
 		public bool Unwind { get; private set; }
+
+		/// <summary>
+		/// Gets the message associated with this contract failure.
+		/// </summary>
 		public string Message { get; private set; }
+
+		/// <summary>
+		/// Gets the original exception that caused this contract failure, if any.
+		/// </summary>
 		public Exception OriginalException { get; private set; }
 	}
 }
-

Property changes on: System.Diagnostics.Contracts/ContractFailedEventArgs.cs
___________________________________________________________________
Added: svn:eol-style
   + native

Index: System.Diagnostics.Contracts/ContractVerificationAttribute.cs
===================================================================
--- System.Diagnostics.Contracts/ContractVerificationAttribute.cs	(revision 159003)
+++ System.Diagnostics.Contracts/ContractVerificationAttribute.cs	(working copy)
@@ -28,6 +28,11 @@
 #if NET_2_1 || NET_4_0
 using System;
 namespace System.Diagnostics.Contracts {
+
+	/// <summary>
+	/// Indicates whether the code contract verification tools should verify this item.
+	/// If not, the item is assumed to be correct.
+	/// </summary>
 	[Conditional ("CONTRACTS_FULL")]
 	[AttributeUsageAttribute (AttributeTargets.Assembly | AttributeTargets.Class | AttributeTargets.Struct | AttributeTargets.Constructor | AttributeTargets.Method | AttributeTargets.Property)]
 	public sealed class ContractVerificationAttribute : Attribute {
@@ -38,6 +43,9 @@
 			val = value;
 		}
 
+		/// <summary>
+		/// Gets whether to include this item in verification.
+		/// </summary>
 		public bool Value {
 			get { return val; }
 		}

Property changes on: System.Diagnostics.Contracts/ContractVerificationAttribute.cs
___________________________________________________________________
Added: svn:eol-style
   + native

Index: System.Diagnostics.Contracts/ContractPublicPropertyNameAttribute.cs
===================================================================
--- System.Diagnostics.Contracts/ContractPublicPropertyNameAttribute.cs	(revision 159003)
+++ System.Diagnostics.Contracts/ContractPublicPropertyNameAttribute.cs	(working copy)
@@ -28,6 +28,11 @@
 #if NET_2_1 || NET_4_0
 using System;
 namespace System.Diagnostics.Contracts {
+
+	/// <summary>
+	/// Specifies a public property name associated with a field, allowing a less-visible field to be used
+	/// in contracts within a method.
+	/// </summary>
 	[Conditional ("CONTRACTS_FULL")]
 	[AttributeUsage (AttributeTargets.Field)]
 	public sealed class ContractPublicPropertyNameAttribute : Attribute {

Property changes on: System.Diagnostics.Contracts/ContractPublicPropertyNameAttribute.cs
___________________________________________________________________
Added: svn:eol-style
   + native

Index: System.Diagnostics.Contracts/Internal/ContractHelper.cs
===================================================================
--- System.Diagnostics.Contracts/Internal/ContractHelper.cs	(revision 0)
+++ System.Diagnostics.Contracts/Internal/ContractHelper.cs	(revision 0)
@@ -0,0 +1,161 @@
+//
+// System.Diagnostics.Contracts.Internal.ContractHelper.cs
+//
+// Authors:
+//    Chris Bacon (chrisbacon76@gmail.com)
+//
+// Copyright 2010 Novell (http://www.novell.com)
+//
+// Permission is hereby granted, free of charge, to any person obtaining
+// a copy of this software and associated documentation files (the
+// "Software"), to deal in the Software without restriction, including
+// without limitation the rights to use, copy, modify, merge, publish,
+// distribute, sublicense, and/or sell copies of the Software, and to
+// permit persons to whom the Software is furnished to do so, subject to
+// the following conditions:
+// 
+// The above copyright notice and this permission notice shall be
+// included in all copies or substantial portions of the Software.
+// 
+// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
+// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
+// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
+// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+//
+
+using System;
+using System.Text;
+
+namespace System.Diagnostics.Contracts.Internal {
+
+	/// <summary>
+	/// Implements methods required by the contract rewriter to handle contract failures.
+	/// </summary>
+#if NET_2_1 || NET_4_0
+	public
+#else
+	internal
+#endif
+	static class ContractHelper {
+
+		/// <summary>
+		/// Behaviour defined in section 7.3 of UserDoc.pdf from Microsoft.
+		/// Determines the default contract failure behaviour, which is that
+		/// event handlers are called in turn, thrown exceptions acts as if SetUnwind() has been called.
+		/// </summary>
+		/// <param name="failureKind">The kind of contract failure.</param>
+		/// <param name="userMessage">The user message describing this contract failure.</param>
+		/// <param name="conditionText">The condition that caused this contract failure.</param>
+		/// <param name="innerException">The exception that caused this contract filure, if any.</param>
+		/// <returns></returns>
+		public static string RaiseContractFailedEvent (ContractFailureKind failureKind, string userMessage, string conditionText, Exception innerException)
+		{
+
+			StringBuilder msg = new StringBuilder (60);
+			switch (failureKind) {
+			case ContractFailureKind.Assert:
+				msg.Append ("Assertion failed");
+				break;
+			case ContractFailureKind.Assume:
+				msg.Append ("Assumption failed");
+				break;
+			case ContractFailureKind.Invariant:
+				msg.Append ("Invariant failed");
+				break;
+			case ContractFailureKind.Postcondition:
+				msg.Append ("Postcondition failed");
+				break;
+			case ContractFailureKind.PostconditionOnException:
+				msg.Append ("Postcondition failed after throwing an exception");
+				break;
+			case ContractFailureKind.Precondition:
+				msg.Append ("Precondition failed");
+				break;
+			default:
+				throw new NotSupportedException ("Not supported: " + failureKind);
+			}
+			if (conditionText != null) {
+				msg.Append (": ");
+				msg.Append (conditionText);
+			} else {
+				msg.Append ('.');
+			}
+			if (userMessage != null) {
+				msg.Append ("  ");
+				msg.Append (userMessage);
+			}
+			string msgString = msg.ToString ();
+
+			Exception handlerException = null;
+			bool unwind = false, handled = false;
+
+			var contractFailed = Contract.InternalContractFailedEvent;
+			if (contractFailed != null) {
+				// Execute all event handlers
+				var handlers = contractFailed.GetInvocationList ();
+				var e = new ContractFailedEventArgs (failureKind, msgString, conditionText, innerException);
+				foreach (var handler in handlers) {
+					try {
+						handler.DynamicInvoke (null, e);
+					} catch (Exception ex) {
+						e.SetUnwind ();
+						// If multiple handlers throw an exception then the specification states that it
+						// is undetermined which one becomes the InnerException.
+						handlerException = ex.InnerException;
+					}
+				}
+				unwind = e.Unwind;
+				handled = e.Handled;
+			}
+
+			if (unwind) {
+				Exception ex = innerException ?? handlerException;
+				throw new ContractException (msgString, failureKind, conditionText, userMessage, ex);
+			}
+
+			return handled ? null : msgString;
+		}
+
+		/// <summary>
+		/// Implements the default failure behaviour.
+		/// </summary>
+		/// <param name="kind">The kind of contract failure.</param>
+		/// <param name="displayMessage">The message to display describing this contract failure.</param>
+		/// <param name="userMessage">The user message describing this contract failure.</param>
+		/// <param name="conditionText">The condition that caused this contract failure.</param>
+		/// <param name="innerException">The exception that caused this contract filure, if any.</param>
+		public static void TriggerFailure (ContractFailureKind kind, string displayMessage, string userMessage, string conditionText, Exception innerException)
+		{
+			StringBuilder msg = new StringBuilder (50);
+
+			if (conditionText != null) {
+				msg.Append ("Expression: ");
+				msg.AppendLine (conditionText);
+			}
+			msg.Append ("Description: ");
+			if (displayMessage != null) {
+				msg.Append (displayMessage);
+			}
+
+			if (Environment.UserInteractive) {
+				// FIXME: This should trigger an assertion.
+				// But code will never get here at the moment, as Environment.UserInteractive currently
+				// always returns false.
+				throw new ContractShouldAssertException (msg.ToString ());
+			} else {
+				// Note that FailFast() currently throws a NotImplemenetedException()
+#if NET_4_0
+				Environment.FailFast(msg.ToString(), new ExecutionEngineException());
+#else
+				Environment.FailFast(msg.ToString());
+#endif
+			}
+
+		}
+
+	}
+
+}

Property changes on: System.Diagnostics.Contracts/Internal/ContractHelper.cs
___________________________________________________________________
Added: svn:eol-style
   + native

Index: System.Diagnostics.Contracts/Internal/ChangeLog
===================================================================
--- System.Diagnostics.Contracts/Internal/ChangeLog	(revision 0)
+++ System.Diagnostics.Contracts/Internal/ChangeLog	(revision 0)
@@ -0,0 +1,3 @@
+2010-06-07  Chris Bacon <chrisbacon76@gmail.com>
+
+	* ContractHelper.cs: New file

Property changes on: System.Diagnostics.Contracts/Internal/ChangeLog
___________________________________________________________________
Added: svn:eol-style
   + native

