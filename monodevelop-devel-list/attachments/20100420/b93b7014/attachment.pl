Index: main/src/addins/MonoDevelop.Debugger.Soft/Mono.Debugging.Soft/ChangeLog
===================================================================
--- main/src/addins/MonoDevelop.Debugger.Soft/Mono.Debugging.Soft/ChangeLog	(revision 155785)
+++ main/src/addins/MonoDevelop.Debugger.Soft/Mono.Debugging.Soft/ChangeLog	(working copy)
@@ -1,3 +1,8 @@
+2010-04-19  Carlo Kok  <ck@remobjects.com>
+	* SoftDebuggerSession.cs:
+	* SoftEvaluationContext.cs:
+	  Allow for custom expression evaluator.
+
 2010-04-14  Lluis Sanchez Gual  <lluis@novell.com>
 
 	* SoftDebuggerAdaptor.cs: When getting the members of a type,
Index: main/src/addins/MonoDevelop.Debugger.Soft/Mono.Debugging.Soft/SoftDebuggerSession.cs
===================================================================
--- main/src/addins/MonoDevelop.Debugger.Soft/Mono.Debugging.Soft/SoftDebuggerSession.cs	(revision 155785)
+++ main/src/addins/MonoDevelop.Debugger.Soft/Mono.Debugging.Soft/SoftDebuggerSession.cs	(working copy)
@@ -72,7 +72,6 @@
 		
 		bool loggedSymlinkedRuntimesBug = false;
 		
-		public readonly NRefactoryEvaluator Evaluator = new NRefactoryEvaluator ();
 		public readonly SoftDebuggerAdaptor Adaptor = new SoftDebuggerAdaptor ();
 		
 		public SoftDebuggerSession ()
@@ -893,7 +892,8 @@
 				EvaluationOptions ops = Options.EvaluationOptions;
 				ops.AllowTargetInvoke = true;
 				SoftEvaluationContext ctx = new SoftEvaluationContext (this, frames[0], ops);
-				ValueReference val = Evaluator.Evaluate (ctx, exp);
+                
+				ValueReference val = ctx.Evaluator.Evaluate (ctx, exp);
 				return val.CreateObjectValue (false).Value;
 			} catch (Exception ex) {
 				OnDebuggerOutput (true, ex.ToString ());
Index: main/src/addins/MonoDevelop.Debugger.Soft/Mono.Debugging.Soft/SoftEvaluationContext.cs
===================================================================
--- main/src/addins/MonoDevelop.Debugger.Soft/Mono.Debugging.Soft/SoftEvaluationContext.cs	(revision 155785)
+++ main/src/addins/MonoDevelop.Debugger.Soft/Mono.Debugging.Soft/SoftEvaluationContext.cs	(working copy)
@@ -43,7 +43,15 @@
 		{
 			Frame = frame;
 			Thread = frame.Thread;
-			Evaluator = session.Evaluator;
+
+
+            string method = frame.Method.Name;
+			if (frame.Method.DeclaringType != null)
+				method = frame.Method.DeclaringType.FullName + "." + method;
+			var location = new DC.SourceLocation (method, frame.FileName, frame.LineNumber);
+			var lang = frame.Method != null? "Managed" : "Native";
+
+            Evaluator = session.GetResolver(new DC.StackFrame(frame.ILOffset, location, lang, session.IsExternalCode(frame)));
 			Adapter = session.Adaptor;
 			this.session = session;
 			this.stackVersion = session.StackVersion;
Index: main/src/addins/MonoDevelop.Debugger/ChangeLog
===================================================================
--- main/src/addins/MonoDevelop.Debugger/ChangeLog	(revision 155785)
+++ main/src/addins/MonoDevelop.Debugger/ChangeLog	(working copy)
@@ -1,3 +1,13 @@
+2010-04-19  Carlo Kok  <ck@remobjects.com>
+	
+	* MakeFile.am:
+	* MonoDevelop.Debugger.csproj:
+	* MonoDevelop.Debugger/DebuggingService.cs:
+	* MonoDevelop.Debugger/ExpressionEvaluatorExtensionNode.cs:
+	* MonoDevelop.Debugger/IExpressionEvaluator.cs:
+	* MonoDevelop.Debugger/LocalsPad.cs:
+      Allow for custom debug expression evaluator plugins.
+	
 2010-04-19  Lluis Sanchez Gual  <lluis@novell.com>
 
 	* MonoDevelop.Debugger/ObjectValueTreeView.cs: Reduce size of
Index: main/src/addins/MonoDevelop.Debugger/Makefile.am
===================================================================
--- main/src/addins/MonoDevelop.Debugger/Makefile.am	(revision 155785)
+++ main/src/addins/MonoDevelop.Debugger/Makefile.am	(working copy)
@@ -53,8 +53,10 @@
 	MonoDevelop.Debugger/ExceptionCaughtDialog.cs \
 	MonoDevelop.Debugger/ExceptionsDialog.cs \
 	MonoDevelop.Debugger/ExpressionEvaluatorDialog.cs \
+	MonoDevelop.Debugger/ExpressionEvaluatorExtensionNode.cs \
 	MonoDevelop.Debugger/Extensions.cs \
 	MonoDevelop.Debugger/IDebuggerEngine.cs \
+	MonoDevelop.Debugger/IExpressionEvaluator.cs \
 	MonoDevelop.Debugger/ImmediatePad.cs \
 	MonoDevelop.Debugger/Initializer.cs \
 	MonoDevelop.Debugger/LocalsPad.cs \
Index: main/src/addins/MonoDevelop.Debugger/MonoDevelop.Debugger.addin.xml
===================================================================
--- main/src/addins/MonoDevelop.Debugger/MonoDevelop.Debugger.addin.xml	(revision 155785)
+++ main/src/addins/MonoDevelop.Debugger/MonoDevelop.Debugger.addin.xml	(working copy)
@@ -17,6 +17,11 @@
 		<Description>Debug session factories. Specified classes must implement MonoDevelop.Debugger.IDebuggerEngine</Description>
 		<ExtensionNode name="DebuggerEngine" type="MonoDevelop.Debugger.DebuggerEngineExtensionNode"/>
 	</ExtensionPoint>
+
+  <ExtensionPoint path="/MonoDevelop/Debugging/Evaluators">
+    <Description>Expression evaluator factories. Specified classes must implement MonoDevelop.Debugger.IExpressionEvaluator</Description>
+    <ExtensionNode name="ExpressionEvaluator" type="MonoDevelop.Debugger.ExpressionEvaluatorExtensionNode"/>
+  </ExtensionPoint>
 	
 	<ExtensionPoint path="/MonoDevelop/Debugging/ValueVisualizers">
 		<Description>Value visualizers. Specified classes must implement MonoDevelop.Debugger.IValueVisualizer</Description>
Index: main/src/addins/MonoDevelop.Debugger/MonoDevelop.Debugger.csproj
===================================================================
--- main/src/addins/MonoDevelop.Debugger/MonoDevelop.Debugger.csproj	(revision 155785)
+++ main/src/addins/MonoDevelop.Debugger/MonoDevelop.Debugger.csproj	(working copy)
@@ -86,6 +86,8 @@
   </ItemGroup>
   <ItemGroup>
     <Compile Include="AssemblyInfo.cs" />
+    <Compile Include="MonoDevelop.Debugger\ExpressionEvaluatorExtensionNode.cs" />
+    <Compile Include="MonoDevelop.Debugger\IExpressionEvaluator.cs" />
     <Compile Include="MonoDevelop.Debugger\StackTracePad.cs" />
     <Compile Include="MonoDevelop.Debugger\ObjectValueTreeView.cs" />
     <Compile Include="MonoDevelop.Debugger\WatchPad.cs" />
Index: main/src/addins/MonoDevelop.Debugger/MonoDevelop.Debugger/DebuggingService.cs
===================================================================
--- main/src/addins/MonoDevelop.Debugger/MonoDevelop.Debugger/DebuggingService.cs	(revision 155785)
+++ main/src/addins/MonoDevelop.Debugger/MonoDevelop.Debugger/DebuggingService.cs	(working copy)
@@ -52,7 +52,10 @@
 	public static class DebuggingService
 	{
 		const string FactoriesPath = "/MonoDevelop/Debugging/DebuggerEngines";
-		static DebuggerEngine[] engines;
+		static DebuggerEngine[] engines;
+
+        const string EvaluatorsPath = "/MonoDevelop/Debugging/Evaluators";
+        static Dictionary<string, ExpressionEvaluatorExtensionNode> evaluators;
 		
 		static BreakpointStore breakpoints = new BreakpointStore ();
 		static PinnedWatchStore pinnedWatches = new PinnedWatchStore ();
@@ -455,11 +458,13 @@
 			console.CancelRequested += new EventHandler (OnCancelRequested);
 			
 			if (DebugSessionStarted != null)
-				DebugSessionStarted (null, EventArgs.Empty);
-			
-			NotifyLocationChanged ();
-		}
-		
+				DebugSessionStarted (null, EventArgs.Empty);
+
+            session.GetExpressionEvaluator = new GetExpressionEvaluatorHandler (OnGetExpressionEvaluator);
+
+            NotifyLocationChanged ();
+		}
+
 		static void OnBusyStateChanged (object s, BusyStateEventArgs args)
 		{
 			DispatchService.GuiDispatch (delegate {
@@ -724,7 +729,20 @@
 				engines = engs.ToArray ();
 			}
 			return engines;
-		}		
+		}
+
+        public static Dictionary<string, ExpressionEvaluatorExtensionNode> GetExpressionEvaluators()
+        {
+            if (evaluators == null)
+            {
+                Dictionary<string, ExpressionEvaluatorExtensionNode> evgs = new Dictionary<string, ExpressionEvaluatorExtensionNode> (StringComparer.InvariantCultureIgnoreCase);
+                foreach (ExpressionEvaluatorExtensionNode node in AddinManager.GetExtensionNodes (EvaluatorsPath))
+                    evgs.Add (node.extension, node);
+
+                evaluators = evgs;
+            }
+            return evaluators;
+        }		
 		
 		static DebuggerEngine GetFactoryForCommand (ExecutionCommand cmd)
 		{
@@ -792,7 +810,24 @@
 				}
 			}
 			return null;
-		}
+		}
+
+        public static ExpressionEvaluatorExtensionNode EvaluatorForExtension (string extension)
+        {
+            ExpressionEvaluatorExtensionNode result;
+            if (GetExpressionEvaluators ().TryGetValue (extension, out result))
+                return result;
+            return null;
+        }
+
+
+        static Mono.Debugging.Evaluation.ExpressionEvaluator OnGetExpressionEvaluator (string extension)
+        {
+            ExpressionEvaluatorExtensionNode info = EvaluatorForExtension (extension);
+            if (info != null)
+                return info.Evaluator.Evaluator;
+            return null;
+        }
 	}
 	
 	internal class FeatureCheckerHandlerFactory: IExecutionHandler
Index: main/src/addins/MonoDevelop.Debugger/MonoDevelop.Debugger/ExpressionEvaluatorExtensionNode.cs
===================================================================
--- main/src/addins/MonoDevelop.Debugger/MonoDevelop.Debugger/ExpressionEvaluatorExtensionNode.cs	(revision 0)
+++ main/src/addins/MonoDevelop.Debugger/MonoDevelop.Debugger/ExpressionEvaluatorExtensionNode.cs	(revision 0)
@@ -0,0 +1,53 @@
+﻿// 
+// ExpressionEvaluatorExtensionNode.cs
+//  
+// Author:
+//       Carlo kok  <ck@remobjects.com>
+// 
+// Copyright (c) 2010 RemObjects Software
+// 
+// Permission is hereby granted, free of charge, to any person obtaining a copy
+// of this software and associated documentation files (the "Software"), to deal
+// in the Software without restriction, including without limitation the rights
+// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+// copies of the Software, and to permit persons to whom the Software is
+// furnished to do so, subject to the following conditions:
+// 
+// The above copyright notice and this permission notice shall be included in
+// all copies or substantial portions of the Software.
+// 
+// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+// THE SOFTWARE.
+
+using System;
+using Mono.Addins;
+
+namespace MonoDevelop.Debugger
+{
+    public class ExpressionEvaluatorExtensionNode : TypeExtensionNode
+    {
+        [NodeAttribute ("name")]
+        public string Name;
+
+        [NodeAttribute ("extension")]
+        public string extension;
+
+        private IExpressionEvaluator instance;
+
+        public IExpressionEvaluator Evaluator
+        {
+            get
+            {
+                if (instance == null)
+                    instance = (IExpressionEvaluator)CreateInstance(typeof(IExpressionEvaluator));
+                return instance;
+            }
+        }
+    }
+}
+
Index: main/src/addins/MonoDevelop.Debugger/MonoDevelop.Debugger/IExpressionEvaluator.cs
===================================================================
--- main/src/addins/MonoDevelop.Debugger/MonoDevelop.Debugger/IExpressionEvaluator.cs	(revision 0)
+++ main/src/addins/MonoDevelop.Debugger/MonoDevelop.Debugger/IExpressionEvaluator.cs	(revision 0)
@@ -0,0 +1,38 @@
+﻿// 
+// IExpressionEvaluator.cs
+//  
+// Author:
+//       Carlo kok  <ck@remobjects.com>
+// 
+// Copyright (c) 2010 RemObjects Software
+// 
+// Permission is hereby granted, free of charge, to any person obtaining a copy
+// of this software and associated documentation files (the "Software"), to deal
+// in the Software without restriction, including without limitation the rights
+// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+// copies of the Software, and to permit persons to whom the Software is
+// furnished to do so, subject to the following conditions:
+// 
+// The above copyright notice and this permission notice shall be included in
+// all copies or substantial portions of the Software.
+// 
+// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+// THE SOFTWARE.
+
+using System;
+using Mono.Debugging.Evaluation;
+using Mono.Debugging.Client;
+
+namespace MonoDevelop.Debugger
+{
+    public interface IExpressionEvaluator
+    {
+        ExpressionEvaluator Evaluator { get; }
+        ObjectValue[] GetLocals (StackFrame sf);
+    }
+}
Index: main/src/addins/MonoDevelop.Debugger/MonoDevelop.Debugger/LocalsPad.cs
===================================================================
--- main/src/addins/MonoDevelop.Debugger/MonoDevelop.Debugger/LocalsPad.cs	(revision 155785)
+++ main/src/addins/MonoDevelop.Debugger/MonoDevelop.Debugger/LocalsPad.cs	(working copy)
@@ -25,7 +25,9 @@
 //
 //
 
+using System;
 using Mono.Debugging.Client;
+using System.IO;
 
 namespace MonoDevelop.Debugger
 {
Index: main/src/core/Mono.Debugging/Mono.Debugging.Client/DebuggerSession.cs
===================================================================
--- main/src/core/Mono.Debugging/Mono.Debugging.Client/DebuggerSession.cs	(revision 155785)
+++ main/src/core/Mono.Debugging/Mono.Debugging.Client/DebuggerSession.cs	(working copy)
@@ -41,6 +41,10 @@
 	public delegate bool ExceptionHandler (Exception ex);
 	public delegate string TypeResolverHandler (string identifier, SourceLocation location);
 	public delegate void BreakpointTraceHandler (BreakEvent be, string trace);
+    public delegate Mono.Debugging.Evaluation.ExpressionEvaluator GetExpressionEvaluatorHandler (string extension);
+    public delegate ObjectValue[] GetAllLocalsHandler (StackFrame stackframe);
+
+
 	
 	public abstract class DebuggerSession: IDisposable
 	{
@@ -86,7 +90,7 @@
 		public event EventHandler<TargetEventArgs> TargetExceptionThrown;
 		public event EventHandler<TargetEventArgs> TargetUnhandledException;
 		
-		public event EventHandler<BusyStateEventArgs> BusyStateChanged;
+		public event EventHandler<BusyStateEventArgs> BusyStateChanged;
 		
 		public DebuggerSession ()
 		{
@@ -115,7 +119,9 @@
 		
 		public BreakpointTraceHandler BreakpointTraceHandler { get; set; }
 		
-		public TypeResolverHandler TypeResolverHandler { get; set; }
+		public TypeResolverHandler TypeResolverHandler { get; set; }
+        public GetExpressionEvaluatorHandler GetExpressionEvaluator { get; set; }
+        public GetAllLocalsHandler GetAllLocalsHandler { get; set; }
 
 		public BreakpointStore Breakpoints {
 			get {
@@ -657,7 +663,27 @@
 			}
 		}
 		
-		Mono.Debugging.Evaluation.NRefactoryEvaluator defaultResolver = new Mono.Debugging.Evaluation.NRefactoryEvaluator ();
+		Mono.Debugging.Evaluation.ExpressionEvaluator defaultResolver = new Mono.Debugging.Evaluation.NRefactoryEvaluator ();
+        Dictionary<string, Mono.Debugging.Evaluation.ExpressionEvaluator> evaluators = new Dictionary<string, Mono.Debugging.Evaluation.ExpressionEvaluator>();
+
+        public Mono.Debugging.Evaluation.ExpressionEvaluator GetResolver (StackFrame frame)
+        {
+            if (GetExpressionEvaluator == null) return defaultResolver;
+
+            string fn = frame.SourceLocation == null ? null : frame.SourceLocation.Filename;
+            if (String.IsNullOrEmpty(fn)) return defaultResolver;
+            
+            fn = System.IO.Path.GetExtension(fn);
+            Mono.Debugging.Evaluation.ExpressionEvaluator result;
+            if (evaluators.TryGetValue(fn, out result))
+                return result;
+
+            result = GetExpressionEvaluator(fn) ?? defaultResolver;
+
+            evaluators[fn] = result;
+
+            return result;
+        }
 		
 		protected virtual string OnResolveExpression (string expression, SourceLocation location)
 		{
@@ -1013,5 +1039,6 @@
 		public bool IsBusy { get; internal set; }
 		
 		public string Description { get; internal set; }
-	}
+	}
+
 }
Index: main/src/core/Mono.Debugging/Mono.Debugging.Client/StackFrame.cs
===================================================================
--- main/src/core/Mono.Debugging/Mono.Debugging.Client/StackFrame.cs	(revision 155785)
+++ main/src/core/Mono.Debugging/Mono.Debugging.Client/StackFrame.cs	(working copy)
@@ -99,7 +99,10 @@
 		}
 		
 		public ObjectValue[] GetAllLocals ()
-		{
+		{
+            if (session.GetAllLocalsHandler != null)
+                return session.GetAllLocalsHandler(this);
+
 			return GetAllLocals (session.EvaluationOptions);
 		}
 		
Index: main/src/core/Mono.Debugging/Mono.Debugging.Evaluation/ExpressionEvaluator.cs
===================================================================
--- main/src/core/Mono.Debugging/Mono.Debugging.Evaluation/ExpressionEvaluator.cs	(revision 155785)
+++ main/src/core/Mono.Debugging/Mono.Debugging.Evaluation/ExpressionEvaluator.cs	(working copy)
@@ -33,7 +33,7 @@
 
 namespace Mono.Debugging.Evaluation
 {
-	public class ExpressionEvaluator
+	public abstract class ExpressionEvaluator
 	{
 		public ValueReference Evaluate (EvaluationContext ctx, string exp)
 		{
@@ -157,7 +157,9 @@
 				sb.Append (txt);
 			}
 			return sb.ToString ();
-		}
+		}
+
+        public abstract string Resolve (DebuggerSession session, SourceLocation location, string exp);
 	}
 	
 	[Serializable]
Index: main/src/core/Mono.Debugging/Mono.Debugging.Evaluation/NRefactoryEvaluator.cs
===================================================================
--- main/src/core/Mono.Debugging/Mono.Debugging.Evaluation/NRefactoryEvaluator.cs	(revision 155785)
+++ main/src/core/Mono.Debugging/Mono.Debugging.Evaluation/NRefactoryEvaluator.cs	(working copy)
@@ -97,7 +97,7 @@
 			}
 		}
 		
-		public string Resolve (DebuggerSession session, SourceLocation location, string exp)
+		public override string Resolve (DebuggerSession session, SourceLocation location, string exp)
 		{
 			return Resolve (session, location, exp, false);
 		}