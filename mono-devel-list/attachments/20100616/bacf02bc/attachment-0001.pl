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
@@ -26,30 +27,12 @@
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
 #if NET_2_1 || NET_4_0
 	public
 #else
@@ -60,24 +43,57 @@
 
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
 
 		[ConditionalAttribute("DEBUG")]
@@ -86,8 +102,8 @@
 		{
 			if (condition)
 				return;
-			
-			Escalate (ContractFailureKind.Assert, null, userMessage);
+
+			ReportFailure (ContractFailureKind.Assert, userMessage, null, null);
 		}
 
 		[ConditionalAttribute("DEBUG")]
@@ -98,47 +114,48 @@
 			if (condition)
 				return;
 
-			Escalate (ContractFailureKind.Assume, null, "failure");
+			ReportFailure (ContractFailureKind.Assume, null, null, null);
 		}
 
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
 
 		[ConditionalAttribute("CONTRACTS_FULL")]
 		public static void EndContractBlock ()
 		{
-			// seems to be some kind of flag, no code generated
+			// Marker method, no code required.
 		}
 
 		[ConditionalAttribute("CONTRACTS_FULL")]
 		public static void Ensures (bool condition)
 		{
-			// Requires binary rewriter to work
+			AssertMustUseRewriter (ContractFailureKind.Postcondition, "Contract.Ensures");
 		}
 
 		[ConditionalAttribute("CONTRACTS_FULL")]
 		public static void Ensures (bool condition, string userMessage)
 		{
-			// Requires binary rewriter to work
+			AssertMustUseRewriter (ContractFailureKind.Postcondition, "Contract.Ensures");
 		}
 
 		[ConditionalAttribute("CONTRACTS_FULL")]
 		public static void EnsuresOnThrow<TException> (bool condition) where TException : Exception
 		{
-			// Requires binary rewriter to work
+			AssertMustUseRewriter (ContractFailureKind.Postcondition, "Contract.EnsuresOnThrow");
 		}
 
 		[ConditionalAttribute("CONTRACTS_FULL")]
 		public static void EnsuresOnThrow<TException> (bool condition, string userMessage) where TException : Exception
 		{
-			// Requires binary rewriter to work
+			AssertMustUseRewriter (ContractFailureKind.Postcondition, "Contract.EnsuresOnThrow");
 		}
 
 		public static bool Exists<T> (IEnumerable<T> collection, Predicate<T> predicate)
@@ -199,72 +216,56 @@
 		[ConditionalAttribute("CONTRACTS_FULL")]
 		public static void Invariant (bool condition)
 		{
-			// Binary rewriter required
+			AssertMustUseRewriter (ContractFailureKind.Invariant, "Contract.Invariant");
 		}
 
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
 		public static T OldValue<T> (T value)
 		{
-			// This is really the binary rewriter that should kick-in
-			throw RewriterRequired ();
+			// Marker method, no code required.
+			return default (T);
 		}
 
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
+		public static void Requires<TException> (bool condition, string userMessage) where TException : Exception
 		{
-			if (!condition){
-				var e = new TException ();
-				Escalate (ContractFailureKind.Precondition, e, userMessage);
-				throw e;
-			}
+			AssertMustUseRewriter (ContractFailureKind.Precondition, "Contract.Requires<TException>");
 		}
 
 		public static T Result<T> ()
 		{
-			throw RewriterRequired ();
+			// Marker method, no code required.
+			return default (T);
 		}
 
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


Property changes on: System.Diagnostics.Contracts/ContractRuntimeIgnoredAttribute.cs
___________________________________________________________________
Added: svn:eol-style
   + native


Property changes on: System.Diagnostics.Contracts/ContractInvariantMethodAttribute.cs
___________________________________________________________________
Added: svn:eol-style
   + native


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

Property changes on: System.Diagnostics.Contracts/ContractClassAttribute.cs
___________________________________________________________________
Added: svn:eol-style
   + native


Property changes on: System.Diagnostics.Contracts/ContractFailureKind.cs
___________________________________________________________________
Added: svn:eol-style
   + native

Index: System.Diagnostics.Contracts/ContractException.cs
===================================================================
--- System.Diagnostics.Contracts/ContractException.cs	(revision 0)
+++ System.Diagnostics.Contracts/ContractException.cs	(revision 0)
@@ -0,0 +1,53 @@
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
@@ -29,7 +29,7 @@
 using System;
 namespace System.Diagnostics.Contracts {
 	[Conditional ("CONTRACTS_FULL")]
-	[AttributeUsage (AttributeTargets.Delegate | AttributeTargets.Interface | AttributeTargets.Class, Inherited=false)]
+	[AttributeUsage (AttributeTargets.Class, Inherited = false)]
 	public sealed class ContractClassForAttribute : Attribute {
 		Type type;
 

Property changes on: System.Diagnostics.Contracts/ContractClassForAttribute.cs
___________________________________________________________________
Added: svn:eol-style
   + native

Index: System.Diagnostics.Contracts/ContractFailedEventArgs.cs
===================================================================
--- System.Diagnostics.Contracts/ContractFailedEventArgs.cs	(revision 159003)
+++ System.Diagnostics.Contracts/ContractFailedEventArgs.cs	(working copy)
@@ -42,7 +42,7 @@
 			Condition = condition;
 			FailureKind = failureKind;
 			Handled = false;
-			Unwind = true;
+			Unwind = false; // MS docs are incorrect - this should default to false.
 			Message = message;
 			OriginalException = originalException;
 		}

Property changes on: System.Diagnostics.Contracts/ContractFailedEventArgs.cs
___________________________________________________________________
Added: svn:eol-style
   + native


Property changes on: System.Diagnostics.Contracts/ContractVerificationAttribute.cs
___________________________________________________________________
Added: svn:eol-style
   + native


Property changes on: System.Diagnostics.Contracts/ContractPublicPropertyNameAttribute.cs
___________________________________________________________________
Added: svn:eol-style
   + native

Index: System.Diagnostics.Contracts/Internal/ContractHelper.cs
===================================================================
--- System.Diagnostics.Contracts/Internal/ContractHelper.cs	(revision 0)
+++ System.Diagnostics.Contracts/Internal/ContractHelper.cs	(revision 0)
@@ -0,0 +1,140 @@
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
+#if NET_2_1 || NET_4_0
+	public
+#else
+	internal
+#endif
+	static class ContractHelper {
+
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

