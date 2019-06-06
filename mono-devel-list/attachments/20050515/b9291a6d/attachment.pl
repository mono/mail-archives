Index: class/corlib/System.Reflection.Emit/ILGenerator.cs
===================================================================
--- class/corlib/System.Reflection.Emit/ILGenerator.cs	(revision 44532)
+++ class/corlib/System.Reflection.Emit/ILGenerator.cs	(working copy)
@@ -104,6 +104,17 @@
 			handlers [i].extype = null;
 		}
 
+		internal void AddFilter (int offset)
+		{
+			int i;
+			End (offset);
+			add_block (offset);
+			i = handlers.Length - 1;
+			handlers [i].type = ILExceptionBlock.FILTER;
+			handlers [i].extype = null;
+			handlers [i].filter_offset = offset;
+		}
+
 		internal void End (int offset)
 		{
 			if (handlers == null)
@@ -121,6 +132,12 @@
 				return ILExceptionBlock.CATCH;
 		}
 
+		internal void PatchLastClauseStart (int start)
+		{
+			if (handlers != null && handlers.Length > 0)
+				handlers [handlers.Length - 1].start = start;
+		}
+
 		internal void Debug (int b)
 		{
 #if NO
@@ -322,6 +339,7 @@
 		{
 			switch (ex_handlers [cur_block].LastClauseType ()) {
 			case ILExceptionBlock.CATCH:
+			case ILExceptionBlock.FILTER:
 				// how could we optimize code size here?
 				Emit (OpCodes.Leave, ex_handlers [cur_block].end);
 				break;
@@ -329,9 +347,6 @@
 			case ILExceptionBlock.FINALLY:
 				Emit (OpCodes.Endfinally);
 				break;
-			case ILExceptionBlock.FILTER:
-				Emit (OpCodes.Endfilter);
-				break;
 			}
 		}
 
@@ -339,19 +354,30 @@
 		{
 			if (open_blocks.Count <= 0)
 				throw new NotSupportedException ("Not in an exception block");
-			InternalEndClause ();
-			ex_handlers [cur_block].AddCatch (exceptionType, code_len);
-			cur_stack = 1; // the exception object is on the stack by default
-			if (max_stack < cur_stack)
-				max_stack = cur_stack;
+
+			if (ex_handlers [cur_block].LastClauseType () == ILExceptionBlock.FILTER) {
+				if (exceptionType != null)
+					throw new ArgumentException ("Do not supply an exception type for filter clause");
+				Emit (OpCodes.Endfilter);
+				ex_handlers [cur_block].PatchLastClauseStart (code_len);
+			} else {
+				InternalEndClause ();
+				cur_stack = 1; // the exception object is on the stack by default
+				if (max_stack < cur_stack)
+					max_stack = cur_stack;
+				ex_handlers [cur_block].AddCatch (exceptionType, code_len);
+			}
+
 			//System.Console.WriteLine ("Begin catch Block: {0} {1}",exceptionType.ToString(), max_stack);
-			//throw new NotImplementedException ();
 		}
 
-		[MonoTODO]
 		public virtual void BeginExceptFilterBlock ()
 		{
-			throw new NotImplementedException ();
+			if (open_blocks.Count <= 0)
+				throw new NotSupportedException ("Not in an exception block");
+			InternalEndClause ();
+
+			ex_handlers [cur_block].AddFilter (code_len);
 		}
 
 		public virtual Label BeginExceptionBlock ()
