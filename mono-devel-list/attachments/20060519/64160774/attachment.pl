Index: configure.ac
===================================================================
--- configure.ac	(revision 60884)
+++ configure.ac	(working copy)
@@ -67,4 +67,7 @@
 rules/Gendarme.Rules.Portability/Makefile
 rules/Gendarme.Rules.Portability/Gendarme.Rules.Portability.xml
 rules/Gendarme.Rules.Portability/Test/Makefile
+rules/Gendarme.Rules.ExceptionMgmt/Makefile
+rules/Gendarme.Rules.ExceptionMgmt/Gendarme.Rules.ExceptionMgmt.xml
+rules/Gendarme.Rules.ExceptionMgmt/Test/Makefile
 ])
Index: rules/Makefile.am
===================================================================
--- rules/Makefile.am	(revision 60884)
+++ rules/Makefile.am	(working copy)
@@ -1,6 +1,6 @@
 SUBDIRS= Gendarme.Rules.Performance Gendarme.Rules.Security \
 	 Gendarme.Rules.Correctness Gendarme.Rules.Concurrency \
-	 Gendarme.Rules.Portability
+	 Gendarme.Rules.Portability Gendarme.Rules.ExceptionMgmt
 
 EXTRA_DIST = rules.xml
 DISTCLEANFILES = Makefile.in
Index: rules/rules.xml
===================================================================
--- rules/rules.xml	(revision 60884)
+++ rules/rules.xml	(working copy)
@@ -5,6 +5,7 @@
 		<rules include="*" from="Gendarme.Rules.Performance.dll" />
 		<rules include="*" from="Gendarme.Rules.Security.dll" />
 		<rules include="*" from="Gendarme.Rules.Portability.dll" />
+		<rules include="*" from="Gendarme.Rules.ExceptionMgmt.dll" />
 	</ruleset>
 	<ruleset name="concurrency">
 		<rules include="*" from="Gendarme.Rules.Concurrency.dll" />
@@ -21,4 +22,7 @@
 	<ruleset name="portability">
 		<rules include="*" from="Gendarme.Rules.Portability.dll" />
 	</ruleset>
+	<ruleset name="exceptionmgmt">
+		<rules include="*" from="Gendarme.Rules.ExceptionMgmt.dll" />
+	</ruleset>
 </gendarme>
Index: rules/Gendarme.Rules.ExceptionMgmt/Test/TestPatterns.cs
===================================================================
--- rules/Gendarme.Rules.ExceptionMgmt/Test/TestPatterns.cs	(revision 0)
+++ rules/Gendarme.Rules.ExceptionMgmt/Test/TestPatterns.cs	(revision 0)
@@ -0,0 +1,126 @@
+using System;
+
+namespace Gendarme.Rules.ExceptionMgmt.Tests
+{
+	/// <summary>
+	/// Summary description for TestPatterns.
+	/// </summary>
+	public class TestPatterns
+	{
+		public TestPatterns()
+		{
+		}
+
+		public void ThrowOriginalEx()
+		{
+			int i = 0;
+			try
+			{
+				i = Int32.Parse("Broken!");
+			}
+			catch(Exception ex)
+			{
+				// Throw exception immediately.
+				// This should trip the DontDestroyStackTrace rule.
+				throw ex;
+			}
+		}
+
+		public void ThrowOriginalExWithJunk()
+		{
+			int i = 0;
+			try
+			{
+				i = Int32.Parse("Broken!");
+			}
+			catch(Exception ex)
+			{
+				int j = 0;
+				for(int k=0;k<10;k++)
+				{
+					// throw some junk into the catch block, to ensure that
+					j += 10;
+					Console.WriteLine(j);
+				}
+
+				// This should trip the DontDestroyStackTrace rule, because we're
+				// throwing the original exception.
+				throw ex;
+			}
+		}
+
+		public void RethrowOriginalEx()
+		{
+			int i = 0;
+			try
+			{
+				i = Int32.Parse("Broken!");
+			}
+			catch(Exception ex)
+			{
+				// This should NOT trip the DontDestroyStackTrace rule, because we're
+				// rethrowing the original exception.
+				throw;
+			}
+		}
+
+		public void ThrowOriginalExAndRethrowWithJunk()
+		{
+			int i = 0;
+			try
+			{
+				i = Int32.Parse("Broken!");
+			}
+			catch(Exception ex)
+			{
+				int j = 0;
+				for(int k=0;k<10;k++)
+				{
+					// throw some junk into the catch block, to ensure that
+					j += 10;
+					Console.WriteLine(j);
+					if((i % 1234) > 56)
+					{
+						// This should trip the DontDestroyStackTrace rule, because we're
+						// throwing the original exception.
+						throw ex;
+					}
+				}
+
+				// More junk - just to ensure that alternate paths through
+				// this catch block end up at a throw and a rethrow
+				throw;
+			}
+		}
+
+		public void RethrowOriginalExAndThrowWithJunk()
+		{
+			int i = 0;
+			try
+			{
+				i = Int32.Parse("Broken!");
+			}
+			catch(Exception ex)
+			{
+				int j = 0;
+				for(int k=0;k<10;k++)
+				{
+					// throw some junk into the catch block, to ensure that
+					j += 10;
+					Console.WriteLine(j);
+					if((i % 1234) > 56)
+					{
+						// More junk - just to ensure that alternate paths through
+						// this catch block end up at a throw and a rethrow
+						throw;
+					}
+				}
+
+				// This should trip the DontDestroyStackTrace rule, because we're
+				// throwing the original exception.
+				throw ex;
+			}
+		}
+
+	}
+}

Property changes on: rules/Gendarme.Rules.ExceptionMgmt/Test/TestPatterns.cs
___________________________________________________________________
Name: svn:executable
   + *

Index: rules/Gendarme.Rules.ExceptionMgmt/Test/Makefile.am
===================================================================
--- rules/Gendarme.Rules.ExceptionMgmt/Test/Makefile.am	(revision 0)
+++ rules/Gendarme.Rules.ExceptionMgmt/Test/Makefile.am	(revision 0)
@@ -0,0 +1,4 @@
+EXTRA_DIST = *.cs
+DISTCLEANFILES = Makefile.in
+
+all:
Index: rules/Gendarme.Rules.ExceptionMgmt/Impl/SEHCatchBlock.cs
===================================================================
--- rules/Gendarme.Rules.ExceptionMgmt/Impl/SEHCatchBlock.cs	(revision 0)
+++ rules/Gendarme.Rules.ExceptionMgmt/Impl/SEHCatchBlock.cs	(revision 0)
@@ -0,0 +1,28 @@
+using System;
+using Mono.Cecil;
+using Mono.Cecil.Cil;
+
+namespace Gendarme.Rules.ExceptionMgmt
+{
+	
+	internal class SEHCatchBlock : SEHHandlerBlock, ISEHCatchBlock
+	{
+		private TypeReference typeReference = null;
+		
+		public SEHCatchBlock()
+		{
+		}
+		
+		public TypeReference ExceptionType
+		{
+			get
+			{
+				return typeReference;
+			}
+			set
+			{
+				typeReference = value;
+			}
+		}		
+	}	
+}

Property changes on: rules/Gendarme.Rules.ExceptionMgmt/Impl/SEHCatchBlock.cs
___________________________________________________________________
Name: svn:executable
   + *

Index: rules/Gendarme.Rules.ExceptionMgmt/Impl/ExecutionBlock.cs
===================================================================
--- rules/Gendarme.Rules.ExceptionMgmt/Impl/ExecutionBlock.cs	(revision 0)
+++ rules/Gendarme.Rules.ExceptionMgmt/Impl/ExecutionBlock.cs	(revision 0)
@@ -0,0 +1,95 @@
+using System;
+using System.Collections;
+
+using Mono.Cecil;
+using Mono.Cecil.Cil;
+
+namespace Gendarme.Rules.ExceptionMgmt.Impl
+{
+	/// <summary>
+	/// Represents a block of IL instructions
+	/// </summary>
+	public class ExecutionBlock : ICloneable
+	{
+		private IInstruction firstInstruction;
+		private IInstruction lastInstruction;
+		
+		/// <summary>
+		/// Creates an instance of <c>ExecutionBlock</c>
+		/// </summary>
+		public ExecutionBlock()
+		{
+			firstInstruction = null;
+			lastInstruction = null;
+		}
+
+		/// <summary>
+		/// The first instruction in this block
+		/// </summary>
+		/// <value>
+		/// An instance of <see cref="IInstruction"/> representing the first
+		/// instruction in this block
+		/// </value>
+		public IInstruction First
+		{
+			get
+			{
+				return firstInstruction;
+			}
+			set
+			{
+				firstInstruction = value;
+			}
+		}
+
+		/// <summary>
+		/// The last instruction in this block
+		/// </summary>
+		/// <value>
+		/// An instance of <see cref="IInstruction"/> representing the last
+		/// instruction in this block
+		/// </value>
+		public IInstruction Last
+		{
+			get
+			{
+				return lastInstruction;
+			}
+			set
+			{
+				lastInstruction = value;
+			}
+		}
+		
+		/// <summary>
+		/// Determines whether or not <see cref="instruction"/> is located
+		/// between <see cref="ExecutionBlock.First"/> and
+		/// <see cref="ExecutionBlock.Last"/>
+		/// </summary>
+		public bool Contains(IInstruction instruction)
+		{
+			if(firstInstruction == null || lastInstruction == null ||
+				firstInstruction.Offset > lastInstruction.Offset)
+			{
+				return false;
+			}
+			else
+			{
+				return (instruction.Offset >= firstInstruction.Offset) &&
+					(instruction.Offset <= lastInstruction.Offset);
+			}
+		}
+
+		#region ICloneable Members
+
+		public object Clone()
+		{
+			ExecutionBlock other = new ExecutionBlock();
+			other.First = firstInstruction;
+			other.Last = lastInstruction;
+			return other;
+		}
+
+		#endregion
+	}
+}

Property changes on: rules/Gendarme.Rules.ExceptionMgmt/Impl/ExecutionBlock.cs
___________________________________________________________________
Name: svn:executable
   + *

Index: rules/Gendarme.Rules.ExceptionMgmt/Impl/ExecutionPath.cs
===================================================================
--- rules/Gendarme.Rules.ExceptionMgmt/Impl/ExecutionPath.cs	(revision 0)
+++ rules/Gendarme.Rules.ExceptionMgmt/Impl/ExecutionPath.cs	(revision 0)
@@ -0,0 +1,99 @@
+using System;
+using System.Collections;
+
+using Mono.Cecil;
+using Mono.Cecil.Cil;
+
+namespace Gendarme.Rules.ExceptionMgmt.Impl
+{
+	/// <summary>
+	/// Represents a sequence of <see cref="ExecutionBlock"/>s that
+	/// could potentially be executed, in order.
+	/// </summary>
+	public class ExecutionPath : CollectionBase, ICloneable
+	{
+		/// <summary>
+		/// Creates an instance of <c>ExecutionPath</c>
+		/// </summary>
+		public ExecutionPath()
+		{
+		}
+		
+		/// <summary>
+		/// Adds <paramref name="block"/> to the end of the list of
+		/// <see cref="ExecutionBlock"/>s
+		/// </summary>
+		public void Add(ExecutionBlock block)
+		{
+			List.Add(block);
+		}
+		
+		/// <summary>
+		/// Determines whether or not <paramref name="instruction"/>
+		/// is contained in one of the <see cref="ExecutionBlock"/>s
+		/// listed in this <c>ExecutionBlock</c>
+		/// </summary>
+		public bool Contains(IInstruction instruction)
+		{
+			foreach(ExecutionBlock block in List)
+			{
+				if(block.Contains(instruction))
+				{
+					return true;
+				}
+			}
+
+			return false;
+		}
+
+		public override bool Equals(object obj)
+		{
+			if(!(obj is ExecutionPath))
+			{
+				return false;
+			}
+
+			ExecutionPath other = (ExecutionPath)obj;
+
+			if(other.Count != Count)
+			{
+				return false;
+			}
+
+			IEnumerator thisEnum = List.GetEnumerator();
+			IEnumerator otherEnum = other.GetEnumerator();
+			while(thisEnum.MoveNext() && otherEnum.MoveNext())
+			{
+				ExecutionBlock thisBlock = (ExecutionBlock)thisEnum.Current;
+				ExecutionBlock otherBlock = (ExecutionBlock)otherEnum.Current;
+				if(thisBlock.First.Offset != otherBlock.First.Offset ||
+					thisBlock.Last.Offset != otherBlock.Last.Offset)
+				{
+					return false;
+				}
+			}
+
+			return true;
+		}
+
+		public override int GetHashCode()
+		{
+			return List.GetHashCode();
+		}
+
+		#region ICloneable Members
+
+		public object Clone()
+		{
+			ExecutionPath other = new ExecutionPath();
+			foreach(ExecutionBlock block in List)
+			{
+				other.Add((ExecutionBlock)block.Clone());
+			}
+
+			return other;
+		}
+
+		#endregion
+	}
+}

Property changes on: rules/Gendarme.Rules.ExceptionMgmt/Impl/ExecutionPath.cs
___________________________________________________________________
Name: svn:executable
   + *

Index: rules/Gendarme.Rules.ExceptionMgmt/Impl/SEHHandlerBlockCollection.cs
===================================================================
--- rules/Gendarme.Rules.ExceptionMgmt/Impl/SEHHandlerBlockCollection.cs	(revision 0)
+++ rules/Gendarme.Rules.ExceptionMgmt/Impl/SEHHandlerBlockCollection.cs	(revision 0)
@@ -0,0 +1,151 @@
+using System;
+using System.Collections;
+
+namespace Gendarme.Rules.ExceptionMgmt
+{
+	internal class SEHHandlerBlockCollection : IList, ICollection
+	{
+		private ArrayList list;
+		
+		public SEHHandlerBlockCollection()
+		{
+			list = new ArrayList();
+		}
+		
+		public int Add(SEHHandlerBlock sehHandlerBlock)
+		{
+			return list.Add(sehHandlerBlock);
+		}
+		
+		public void Remove(SEHHandlerBlock sehHandlerBlock)
+		{
+			if(list.Contains(sehHandlerBlock))
+			{
+				list.Remove(sehHandlerBlock);
+			}
+		}
+		
+		public void Clear()
+		{
+			list.Clear();
+		}
+		
+		public bool Contains(SEHHandlerBlock sehHandlerBlock)
+		{
+			return list.Contains(sehHandlerBlock);
+		}
+		
+		public SEHHandlerBlock this[int index]
+		{
+			get
+			{
+				return (SEHHandlerBlock)list[index];
+			}
+		}
+		
+		public IEnumerator GetEnumerator()
+		{
+			return list.GetEnumerator();
+		}
+		
+		public void CopyTo(Array array, int index)
+		{
+			list.CopyTo(array, index);
+		}
+		
+		public object SyncRoot
+		{
+			get
+			{
+				return list.SyncRoot;
+			}
+		}
+		
+		public bool IsSynchronized
+		{
+			get
+			{
+				return list.IsSynchronized;
+			}
+		}
+		
+		public int Count
+		{
+			get
+			{
+				return list.Count;
+			}
+		}
+		
+		public void RemoveAt(int index)
+		{
+			list.RemoveAt(index);
+		}
+
+		public bool IsReadOnly
+		{
+			get
+			{
+				return false;
+			}
+		}
+		
+		public bool IsFixedSize
+		{
+			get
+			{
+				return false;
+			}
+		}
+
+		public int IndexOf(SEHHandlerBlock sehHandlerBlock)
+		{
+			return list.IndexOf(sehHandlerBlock);
+		}
+		
+		public void Insert(int index, SEHHandlerBlock sehHandlerBlock)
+		{
+			list.Insert(index, sehHandlerBlock);
+		}
+								
+		int IList.Add(object obj)
+		{
+			return Add((SEHHandlerBlock)obj);
+		}
+		
+		void IList.Remove(object obj)
+		{
+			Remove((SEHHandlerBlock)obj);
+		}
+		
+		object IList.this[int index]
+		{
+			get
+			{
+				return list[index];
+			}
+			set
+			{
+				throw new NotSupportedException();
+			}
+		}
+		
+		int IList.IndexOf(object obj)
+		{
+			return IndexOf((SEHHandlerBlock)obj);
+		}
+		
+		bool IList.Contains(object obj)
+		{
+			return Contains((SEHHandlerBlock)obj);
+		}
+		
+		void IList.Insert(int index, object obj)
+		{
+			Insert(index, (SEHHandlerBlock)obj);
+		}
+		
+		
+	}
+	
+}

Property changes on: rules/Gendarme.Rules.ExceptionMgmt/Impl/SEHHandlerBlockCollection.cs
___________________________________________________________________
Name: svn:executable
   + *

Index: rules/Gendarme.Rules.ExceptionMgmt/Impl/ExceptionBlockParser.cs
===================================================================
--- rules/Gendarme.Rules.ExceptionMgmt/Impl/ExceptionBlockParser.cs	(revision 0)
+++ rules/Gendarme.Rules.ExceptionMgmt/Impl/ExceptionBlockParser.cs	(revision 0)
@@ -0,0 +1,86 @@
+using System;
+using System.Collections;
+using Mono.Cecil;
+using Mono.Cecil.Cil;
+
+namespace Gendarme.Rules.ExceptionMgmt
+{
+	
+	/// <summary>
+	/// Parses a methods' exception details into instances of
+	/// <see cref="ISEHGuardedBlock"/>s
+	/// </summary>
+	public class ExceptionBlockParser
+	{
+		public ExceptionBlockParser()
+		{
+		}
+		
+		/// <summary>
+		/// Parses <paramref name="method"/>'s info to extract information
+		/// about the guarded blocks of IL present in it.
+		/// </summary>
+		public ISEHGuardedBlock[] GetExceptionBlocks(IMethodDefinition method)
+		{
+			ArrayList guardedBlocks = new ArrayList();
+			Hashtable blockStarts = new Hashtable();
+			ExceptionHandlerCollection ehc = null;
+			
+			if(method.Body != null)
+			{
+				ehc = method.Body.ExceptionHandlers;
+				// Parse the exception handlers now
+				foreach(ExceptionHandler eh in ehc)
+				{
+					SEHGuardedBlock guardedBlock = null;
+
+					if(eh.Type == ExceptionHandlerType.Catch)
+					{
+						if(!blockStarts.ContainsKey(eh.TryStart))
+						{
+							guardedBlock = new SEHGuardedBlock();
+							guardedBlock.Start = eh.TryStart;
+							guardedBlock.End = eh.TryEnd;
+							blockStarts[eh.TryStart] = guardedBlock;
+						}
+						else
+						{
+							guardedBlock = (SEHGuardedBlock)blockStarts[eh.TryStart];
+						}
+
+						SEHCatchBlock cb = new SEHCatchBlock();
+						cb.ExceptionType = eh.CatchType;
+						cb.Start = eh.HandlerStart;
+						cb.End = eh.HandlerEnd;
+						cb.Type = SEHHandlerType.Catch;
+						guardedBlock.SEHHandlerBlocksInternal.Add(cb);
+					}
+					else if(eh.Type == ExceptionHandlerType.Finally)
+					{
+						if(!blockStarts.ContainsKey(eh.TryStart))
+						{
+							guardedBlock = new SEHGuardedBlock();
+							guardedBlock.Start = eh.TryStart;
+							guardedBlock.End = eh.TryEnd;
+							blockStarts[eh.TryStart] = guardedBlock;
+						}
+						else
+						{
+							guardedBlock = (SEHGuardedBlock)blockStarts[eh.TryStart];
+						}
+
+						SEHHandlerBlock hb = new SEHHandlerBlock();
+						hb.Start = eh.HandlerStart;
+						hb.End = eh.HandlerEnd;
+						hb.Type = SEHHandlerType.Finally;
+						guardedBlock.SEHHandlerBlocksInternal.Add(hb);
+					}
+				}
+			}
+			
+			ISEHGuardedBlock[] ret = new ISEHGuardedBlock[blockStarts.Count];
+			blockStarts.Values.CopyTo(ret,0);
+			return ret;
+		}
+	}
+}

Property changes on: rules/Gendarme.Rules.ExceptionMgmt/Impl/ExceptionBlockParser.cs
___________________________________________________________________
Name: svn:executable
   + *

Index: rules/Gendarme.Rules.ExceptionMgmt/Impl/SEHGuardedBlock.cs
===================================================================
--- rules/Gendarme.Rules.ExceptionMgmt/Impl/SEHGuardedBlock.cs	(revision 0)
+++ rules/Gendarme.Rules.ExceptionMgmt/Impl/SEHGuardedBlock.cs	(revision 0)
@@ -0,0 +1,64 @@
+using System;
+using System.Collections;
+using Mono.Cecil;
+using Mono.Cecil.Cil;
+
+
+namespace Gendarme.Rules.ExceptionMgmt
+{
+	
+	internal class SEHGuardedBlock : ISEHGuardedBlock
+	{
+		private IInstruction start;
+		private IInstruction end;
+		private SEHHandlerBlockCollection handlerBlocks;
+		
+		public SEHGuardedBlock()
+		{
+			handlerBlocks = new SEHHandlerBlockCollection();
+		}
+		
+		public IInstruction Start
+		{
+			get
+			{
+				return start;
+			}
+			set
+			{
+				start = value;
+			}			
+		}
+
+		public IInstruction End
+		{
+			get
+			{
+				return end;
+			}
+			set
+			{
+				end = value;
+			}
+		}
+		
+		public ISEHHandlerBlock[] SEHHandlerBlocks
+		{
+			get
+			{
+				ISEHHandlerBlock[] ret =
+					new ISEHHandlerBlock[handlerBlocks.Count];
+				handlerBlocks.CopyTo(ret,0);
+				return ret;
+			}
+		}
+
+		public SEHHandlerBlockCollection SEHHandlerBlocksInternal
+		{
+			get
+			{
+				return handlerBlocks;
+			}
+		}
+	}
+}

Property changes on: rules/Gendarme.Rules.ExceptionMgmt/Impl/SEHGuardedBlock.cs
___________________________________________________________________
Name: svn:executable
   + *

Index: rules/Gendarme.Rules.ExceptionMgmt/Impl/ExecutionPathFactory.cs
===================================================================
--- rules/Gendarme.Rules.ExceptionMgmt/Impl/ExecutionPathFactory.cs	(revision 0)
+++ rules/Gendarme.Rules.ExceptionMgmt/Impl/ExecutionPathFactory.cs	(revision 0)
@@ -0,0 +1,163 @@
+using System;
+using System.Collections;
+
+using Mono.Cecil;
+using Mono.Cecil.Cil;
+
+namespace Gendarme.Rules.ExceptionMgmt.Impl
+{
+	/// <summary>
+	/// Generates <see cref="ExecutionPath"/>s through a block of instructions
+	/// in a given <see cref="IMethodDefinition"/>
+	/// </summary>
+	public class ExecutionPathFactory
+	{
+		private IMethodDefinition method;
+		private int maxCondBranches = 16;
+		
+		/// <summary>
+		/// Creates an instance of <c>ExecutionPathFactory</c> that can
+		/// generate <see cref="ExecutionPath"/>s through the given
+		/// <paramref name="method"/>
+		public ExecutionPathFactory(IMethodDefinition method)
+		{
+			this.method = method;
+		}
+		
+		/// <summary>
+		/// Creates a list of <see cref="ExecutionPaths"/> possible, starting
+		/// at <paramref name="start"/> and going through <paramref name="end"/>
+		/// </summary>
+		public ExecutionPath[] CreatePaths(Instruction start, Instruction end)
+		{
+			if(start == null)
+			{
+				throw new ArgumentNullException("start");
+			}
+			if(end == null)
+			{
+				throw new ArgumentNullException("end");
+			}
+			if(!method.Body.Instructions.Contains(start))
+			{
+				throw new ArgumentException(
+					"start instruction is not contained in method " + method.DeclaringType.FullName + "::" + method.Name,
+					"start");
+			}
+			if(!method.Body.Instructions.Contains(end))
+			{
+				throw new ArgumentException(
+					"end instruction is not contained in method " + method.DeclaringType.FullName + "::" + method.Name,
+					"end");
+			}
+			if(NumCondBranches(start,end) > maxCondBranches)
+			{
+				throw new ArgumentException(
+					"More than " + maxCondBranches + " condition branch present between " +
+					"start and end instructions.");
+			}
+			
+			ArrayList paths = new ArrayList();
+			CreatePathHelper(start, end, new ExecutionPath(),paths);
+			ExecutionPath[] ret = new ExecutionPath[paths.Count];
+			paths.CopyTo(ret);
+			return ret;
+		}
+
+		private void CreatePathHelper(
+			IInstruction start, 
+			IInstruction end, 
+			ExecutionPath path, 
+			ArrayList completedPaths)
+		{
+			ExecutionBlock curBlock = new ExecutionBlock();
+			curBlock.First = start;
+
+			IInstruction cur = start;
+			bool stop = false;
+			do
+			{
+				switch(cur.OpCode.FlowControl)
+				{
+					case FlowControl.Branch:
+					case FlowControl.Cond_Branch:
+						if(cur.OpCode == OpCodes.Switch)
+						{
+							IInstruction[] targetOffsets = (IInstruction[])cur.Operand;
+							foreach(IInstruction target in targetOffsets)
+							{
+								if(!path.Contains(target))
+								{
+									curBlock.Last = cur;
+									path.Add(curBlock);
+									CreatePathHelper(target, end, (ExecutionPath)path.Clone(),completedPaths);
+								}
+							}
+							stop = true;
+						}
+						else if(cur.OpCode == OpCodes.Leave || cur.OpCode == OpCodes.Leave_S)
+						{
+							curBlock.Last = cur;
+							path.Add(curBlock);
+							completedPaths.Add(path);
+							stop = true;
+							break;
+						}
+						else 
+						{
+							IInstruction target = (IInstruction)cur.Operand;
+							if(!path.Contains(target))
+							{
+								curBlock.Last = cur;
+								path.Add(curBlock);
+								CreatePathHelper(target, end, (ExecutionPath)path.Clone(),completedPaths);
+							}
+							if(!path.Contains(cur.Next))
+							{
+								curBlock = new ExecutionBlock();
+								curBlock.First = cur.Next;
+							}
+							else
+							{
+								stop = true;
+							}
+						}
+						break;
+					case FlowControl.Throw:
+					case FlowControl.Return:
+						curBlock.Last = cur;
+						path.Add(curBlock);
+						completedPaths.Add(path);
+						stop = true;
+						break;
+					default:
+						break;
+				}
+
+				if(cur.Next != null && cur != end && !stop)
+				{
+					cur = cur.Next;
+				}
+				else
+				{
+					stop = true;
+				}
+			} while(!stop);
+		}
+		
+		private int NumCondBranches(IInstruction start, IInstruction end)
+		{
+			IInstruction cur = start;
+			int count = 0;
+			while(cur != null && cur != end)
+			{
+				if(cur.OpCode.FlowControl == FlowControl.Cond_Branch)
+				{
+					count++;
+				}
+				cur = cur.Next;
+			}
+			return count;
+		}
+	}
+}

Property changes on: rules/Gendarme.Rules.ExceptionMgmt/Impl/ExecutionPathFactory.cs
___________________________________________________________________
Name: svn:executable
   + *

Index: rules/Gendarme.Rules.ExceptionMgmt/Impl/SEHHandlerBlock.cs
===================================================================
--- rules/Gendarme.Rules.ExceptionMgmt/Impl/SEHHandlerBlock.cs	(revision 0)
+++ rules/Gendarme.Rules.ExceptionMgmt/Impl/SEHHandlerBlock.cs	(revision 0)
@@ -0,0 +1,53 @@
+using System;
+using Mono.Cecil;
+using Mono.Cecil.Cil;
+
+namespace Gendarme.Rules.ExceptionMgmt
+{
+	internal class SEHHandlerBlock : ISEHHandlerBlock
+	{
+		private Instruction start = null;
+		private Instruction end = null;
+		private SEHHandlerType type;
+		
+		public SEHHandlerBlock()
+		{
+		}
+		
+		public Instruction Start
+		{
+			get
+			{
+				return start;
+			}
+			set
+			{
+				start = value;
+			}
+		}
+
+		public Instruction End
+		{
+			get
+			{
+				return end;
+			}
+			set
+			{
+				end = value;
+			}
+		}
+		
+		public SEHHandlerType Type
+		{
+			get
+			{
+				return type;
+			}
+			set
+			{
+				type = value;
+			}
+		}
+	}
+}

Property changes on: rules/Gendarme.Rules.ExceptionMgmt/Impl/SEHHandlerBlock.cs
___________________________________________________________________
Name: svn:executable
   + *

Index: rules/Gendarme.Rules.ExceptionMgmt/Gendarme.Rules.ExceptionMgmt.xml.in
===================================================================
--- rules/Gendarme.Rules.ExceptionMgmt/Gendarme.Rules.ExceptionMgmt.xml.in	(revision 0)
+++ rules/Gendarme.Rules.ExceptionMgmt/Gendarme.Rules.ExceptionMgmt.xml.in	(revision 0)
@@ -0,0 +1,8 @@
+<rules>
+	<rule	Name="DontDestroyStackTrace" 
+		Type="Gendarme.Rules.ExceptionMgmt.DontDestroyStackTrace, Gendarme.Rules.ExceptionMgmt, Version=@VERSION@, Culture=neutral, PublicKeyToken=null"
+		Uri="http://www.mono-project.com/Gendarme" >
+		<problem>A catch block in method or property '{0}' throws the caught exception.</problem>
+		<solution>If you need to throw the exception caught by the catch block, use 'throw;' instead of 'throw ex;'</solution>
+	</rule>
+</rules>
Index: rules/Gendarme.Rules.ExceptionMgmt/ISEHGuardedBlock.cs
===================================================================
--- rules/Gendarme.Rules.ExceptionMgmt/ISEHGuardedBlock.cs	(revision 0)
+++ rules/Gendarme.Rules.ExceptionMgmt/ISEHGuardedBlock.cs	(revision 0)
@@ -0,0 +1,55 @@
+using System;
+using Mono.Cecil;
+using Mono.Cecil.Cil;
+
+namespace Gendarme.Rules.ExceptionMgmt
+{
+	/// <summary>
+	/// A guarded block of IL instructions, along with all ISEHHandlerBlocks
+	/// for this guarded block
+	/// </summary>
+	public interface ISEHGuardedBlock
+	{
+		/// <summary>
+		/// The first guarded instruction
+		/// </summary>
+		/// <value>
+		/// An <see cref="IInstruction"/> representing the first guarded
+		/// instructions.
+		/// </value>
+		IInstruction Start
+		{
+			get;
+		}
+
+		/// <summary>
+		/// The last guarded instruction
+		/// </summary>
+		/// <value>
+		/// An <see cref="IInstruction"/> representing the last guarded
+		/// instructions.
+		/// </value>
+		IInstruction End
+		{
+			get;
+		}
+		
+		/// <summary>
+		/// All handler blocks for the guarded instructions
+		/// </summary>
+		/// <value>
+		/// An array of <see cref="ISEHHandlerBlock"/> instances representing
+		/// the handler blocks for the guarded instructions
+		/// </value>
+		/// <remarks>
+		/// This array will have one or more entries, depending on the
+		/// type of SEH handler.  For filter, fault, and finally handlers, this
+		/// array will contain exactly one entry.  For catch handlers, this
+		/// array will contain one or more entries.
+		/// </remarks>
+		ISEHHandlerBlock[] SEHHandlerBlocks
+		{
+			get;
+		}
+	}	
+}

Property changes on: rules/Gendarme.Rules.ExceptionMgmt/ISEHGuardedBlock.cs
___________________________________________________________________
Name: svn:executable
   + *

Index: rules/Gendarme.Rules.ExceptionMgmt/SEHHandlerType.cs
===================================================================
--- rules/Gendarme.Rules.ExceptionMgmt/SEHHandlerType.cs	(revision 0)
+++ rules/Gendarme.Rules.ExceptionMgmt/SEHHandlerType.cs	(revision 0)
@@ -0,0 +1,35 @@
+
+using System;
+
+namespace Gendarme.Rules.ExceptionMgmt
+{
+	/// <summary>
+	/// Enumerates the types of SEH handler blocks
+	/// </summary>
+	public enum SEHHandlerType
+	{
+		/// <summary>
+		/// An SEH catch block, invoked if an exception is thrown in the
+		/// guarded block that matches or descends from a specified class
+		/// </summary>
+		Catch,
+		
+		/// <summary>
+		/// An SEH fault block, invoked if any exception is thrown in
+		/// the guarded block
+		/// </summary>
+		Fault,
+		
+		/// <summary>
+		/// An SEH filter block, invoked if any exception is thrown in
+		/// the guarded block
+		/// </summary>
+		Filter,
+		
+		/// <summary>
+		/// An SEH finally block, invoked regardless of whether or not
+		/// an exception is thrown in the guarded block
+		/// </summary>
+		Finally,
+	}	
+}

Property changes on: rules/Gendarme.Rules.ExceptionMgmt/SEHHandlerType.cs
___________________________________________________________________
Name: svn:executable
   + *

Index: rules/Gendarme.Rules.ExceptionMgmt/ISEHHandlerBlock.cs
===================================================================
--- rules/Gendarme.Rules.ExceptionMgmt/ISEHHandlerBlock.cs	(revision 0)
+++ rules/Gendarme.Rules.ExceptionMgmt/ISEHHandlerBlock.cs	(revision 0)
@@ -0,0 +1,50 @@
+
+using System;
+using Mono.Cecil.Cil;
+
+namespace Gendarme.Rules.ExceptionMgmt
+{
+	
+	/// <summary>
+	/// A guarded block of IL instructions, along with all ISEHHandlerBlocks
+	/// for this guarded block
+	/// </summary>
+	public interface ISEHHandlerBlock
+	{
+		/// <summary>
+		/// The first guarded instruction
+		/// </summary>
+		/// <value>
+		/// An <see cref="IInstruction"/> representing the first guarded
+		/// instructions.
+		/// </value>
+		Instruction Start
+		{
+			get;
+		}
+
+		/// <summary>
+		/// The last guarded instruction
+		/// </summary>
+		/// <value>
+		/// An <see cref="IInstruction"/> representing the last guarded
+		/// instructions.
+		/// </value>
+		Instruction End
+		{
+			get;
+		}
+		
+		/// <summary>
+		/// The type of exception handler
+		/// </summary>
+		/// <value>
+		/// One of the constants defined in <see cref="SEHHandlerType"/>
+		/// </value>
+		SEHHandlerType Type
+		{
+			get;
+		}
+	}
+	
+}

Property changes on: rules/Gendarme.Rules.ExceptionMgmt/ISEHHandlerBlock.cs
___________________________________________________________________
Name: svn:executable
   + *

Index: rules/Gendarme.Rules.ExceptionMgmt/DontDestroyStackTrace.cs
===================================================================
--- rules/Gendarme.Rules.ExceptionMgmt/DontDestroyStackTrace.cs	(revision 0)
+++ rules/Gendarme.Rules.ExceptionMgmt/DontDestroyStackTrace.cs	(revision 0)
@@ -0,0 +1,258 @@
+using System;
+using System.Collections;
+using Mono.Cecil;
+using Mono.Cecil.Cil;
+using Gendarme.Framework;
+using Gendarme.Rules.ExceptionMgmt.Impl;
+
+namespace Gendarme.Rules.ExceptionMgmt
+{
+	
+	public class DontDestroyStackTrace : IMethodRule
+	{
+		private static TypeReference voidReference;
+		private ArrayList warnedOffsetsInMethod;
+
+		public DontDestroyStackTrace() 
+		{
+			// List of the offsets warned about already
+			warnedOffsetsInMethod = new ArrayList();
+		}
+
+		public IList CheckMethod ( IAssemblyDefinition assembly,
+		    IModuleDefinition module, ITypeDefinition type,
+		    IMethodDefinition method, Runner runner) {
+
+			voidReference = module.Import(typeof(void));
+
+			ArrayList executionPaths = new ArrayList();
+			ExecutionPathFactory epf = new ExecutionPathFactory(method);
+			ExceptionBlockParser ebp = new ExceptionBlockParser();
+			ISEHGuardedBlock[] guardedBlocks = ebp.GetExceptionBlocks(method);
+			foreach(ISEHGuardedBlock guardedBlock in guardedBlocks)
+			{
+				foreach(ISEHHandlerBlock handlerBlock in guardedBlock.SEHHandlerBlocks)
+				{
+					if(handlerBlock is SEHCatchBlock)
+					{
+						// Grab all of the execution paths through this block
+						ExecutionPath[] ret = new ExecutionPath[0];
+						try
+						{
+							ret = epf.CreatePaths(handlerBlock.Start,handlerBlock.End);
+						}
+						catch(ArgumentException)
+						{
+							Console.WriteLine("Could not process method " +
+								method.DeclaringType.Name + "::" + method.Name +
+								"because it contained too many conditional branches.");
+							return null;
+						}
+						
+						executionPaths.AddRange(ret);
+					}
+				}
+			}
+			
+			ArrayList violations = new ArrayList();
+			warnedOffsetsInMethod.Clear();
+
+		    // Look for paths that "throw ex;"	
+			foreach(ExecutionPath catchPath in executionPaths)
+			{
+				ProcessCatchPath(catchPath, method, violations);
+			}
+			return violations.Count == 0 ? null : violations;	
+		}
+
+		private void ProcessCatchPath(ExecutionPath catchPath, IMethodDefinition method, ArrayList violations)
+		{
+			// Track original exception (top of stack at start) through to the final
+			// return (be it throw, rethrow, leave, or leave.s)
+			
+			// Current stack position: 0 = top of stack
+			int exStackPos = 0;
+			int exLocalVarPos = -1;
+			foreach(ExecutionBlock block in catchPath)
+			{
+				IInstruction cur = null;
+				while(cur != block.Last)
+				{
+					if(cur == null)
+					{
+						cur = block.First;
+					}
+					else
+					{
+						cur = cur.Next;
+					}
+
+					if(cur.OpCode == OpCodes.Rethrow)
+					{
+						// Rethrown exception - no problem!
+						return;
+					}
+	
+					if(cur.OpCode == OpCodes.Stloc ||
+						cur.OpCode == OpCodes.Stloc_0 ||
+						cur.OpCode == OpCodes.Stloc_1 ||
+						cur.OpCode == OpCodes.Stloc_2 ||
+						cur.OpCode == OpCodes.Stloc_3 ||
+						cur.OpCode == OpCodes.Stloc_S)
+					{
+						int varIndex = GetVarIndex(cur);
+						if(exStackPos == 0)
+						{
+							// Storing argument on top of stack in local variable reference
+							exLocalVarPos = varIndex;
+							exStackPos = -1;
+						}
+						else if(exLocalVarPos != -1 && varIndex == exLocalVarPos)
+						{
+							// Writing over orignal exception...
+							exLocalVarPos = -1;
+						}
+					}
+					else if(exLocalVarPos != -1 && 
+							(cur.OpCode == OpCodes.Ldloc ||
+							 cur.OpCode == OpCodes.Ldloc_0 ||
+							 cur.OpCode == OpCodes.Ldloc_1 ||
+							 cur.OpCode == OpCodes.Ldloc_2 ||
+							 cur.OpCode == OpCodes.Ldloc_3 ||
+							 cur.OpCode == OpCodes.Ldloc_S))
+					{
+						int varIndex = GetVarIndex(cur);
+						if(varIndex == exLocalVarPos)
+						{
+							// Loading exception from local var back onto stack
+							exStackPos = 0;
+						}
+					}
+					else if(cur.OpCode == OpCodes.Throw && exStackPos == 0)
+					{
+						// If our original exception is on top of the stack, we're rethrowing it.
+						// This is deemed naughty...
+						if(!warnedOffsetsInMethod.Contains(cur.Offset))
+						{
+							Location loc = new Location(method.DeclaringType.FullName,method.Name,cur.Offset);
+							Message msg = new Message(
+								"Throwing original exception - destroys stack trace!",
+								loc,
+								MessageType.Error);
+							violations.Add(msg);
+							warnedOffsetsInMethod.Add(cur.Offset);
+						}
+						return;
+					}
+					else if(exStackPos != -1)
+					{
+						// If we're still on the stack, track our position after
+						// this instruction
+						int numPops = GetNumPops(cur);
+						if(exStackPos < numPops)
+						{
+							// Popped ex off of stack
+							exStackPos = -1;
+						}
+						else 
+						{
+							// Determine new position on stack after this
+							// instruction
+							int numPushes = GetNumPushes(cur);
+							exStackPos += numPushes - numPops;
+						}
+					}
+				}
+			}
+			return ;
+		}
+
+		private int GetNumPops(IInstruction instr)
+		{
+			switch(instr.OpCode.StackBehaviourPop)
+			{
+				case StackBehaviour.Pop0:
+					return 0;
+				case StackBehaviour.Pop1:
+				case StackBehaviour.Popi:
+				case StackBehaviour.Popref:
+					return 1;
+				case StackBehaviour.Pop1_pop1:
+				case StackBehaviour.Popi_pop1:
+				case StackBehaviour.Popi_popi:
+				case StackBehaviour.Popi_popi8:
+				case StackBehaviour.Popi_popr4:
+				case StackBehaviour.Popi_popr8:
+				case StackBehaviour.Popref_pop1:
+				case StackBehaviour.Popref_popi:
+					return 2;
+				case StackBehaviour.Popi_popi_popi:
+				case StackBehaviour.Popref_popi_popi:
+				case StackBehaviour.Popref_popi_popi8:
+				case StackBehaviour.Popref_popi_popr4:
+				case StackBehaviour.Popref_popi_popr8:
+				case StackBehaviour.Popref_popi_popref:
+					return 3;
+				case StackBehaviour.Varpop:
+					// We have to determine from the call how many arguments will
+					// be popped from the stack
+					MethodReference callMethod = (MethodReference)instr.Operand;
+					return callMethod.Parameters.Count;
+			}
+			return 0;
+		}
+
+		private int GetNumPushes(IInstruction instr)
+		{
+			switch(instr.OpCode.StackBehaviourPush)
+			{
+				case StackBehaviour.Push0:
+					return 0;
+				case StackBehaviour.Push1:
+				case StackBehaviour.Pushi:
+				case StackBehaviour.Pushi8:
+				case StackBehaviour.Pushr4:
+				case StackBehaviour.Pushr8:
+				case StackBehaviour.Pushref:
+					return 1;
+				case StackBehaviour.Push1_push1:
+					return 2;
+				case StackBehaviour.Varpush:
+					// We have to determine from the call how many arguments will
+					// be pushed onto the stack
+					MethodReference callMethod = (MethodReference)instr.Operand;
+					return (callMethod.ReturnType.ReturnType == voidReference) ? 0 : 1;
+			}
+			return 0;
+		}
+
+		private int GetVarIndex(IInstruction instr)
+		{
+			if(instr.OpCode == OpCodes.Stloc_0 || instr.OpCode == OpCodes.Ldloc_0)
+			{
+				return 0;
+			}
+			else if(instr.OpCode == OpCodes.Stloc_1 || instr.OpCode == OpCodes.Ldloc_1)
+			{
+				return 1;
+			}
+			else if(instr.OpCode == OpCodes.Stloc_2 || instr.OpCode == OpCodes.Ldloc_2)
+			{
+				return 2;
+			}
+			else if(instr.OpCode == OpCodes.Stloc_3 || instr.OpCode == OpCodes.Ldloc_3)
+			{
+				return 3;
+			}
+			else if(instr.OpCode == OpCodes.Stloc_S || instr.OpCode == OpCodes.Stloc || 
+			           instr.OpCode == OpCodes.Ldloc_S || instr.OpCode == OpCodes.Ldloc ||
+			           instr.OpCode == OpCodes.Ldloca || instr.OpCode == OpCodes.Ldloca_S)
+			{
+				VariableDefinition varDef = (VariableDefinition)instr.Operand;
+				return varDef.Index;
+			}
+
+			return -1;
+		}
+	}	
+}

Property changes on: rules/Gendarme.Rules.ExceptionMgmt/DontDestroyStackTrace.cs
___________________________________________________________________
Name: svn:executable
   + *

Index: rules/Gendarme.Rules.ExceptionMgmt/Gendarme.Rules.ExceptionMgmt.dll
===================================================================
Cannot display: file marked as a binary type.
svn:mime-type = application/octet-stream

Property changes on: rules/Gendarme.Rules.ExceptionMgmt/Gendarme.Rules.ExceptionMgmt.dll
___________________________________________________________________
Name: svn:executable
   + *
Name: svn:mime-type
   + application/octet-stream

Index: rules/Gendarme.Rules.ExceptionMgmt/Makefile.am
===================================================================
--- rules/Gendarme.Rules.ExceptionMgmt/Makefile.am	(revision 0)
+++ rules/Gendarme.Rules.ExceptionMgmt/Makefile.am	(revision 0)
@@ -0,0 +1,47 @@
+SUBDIRS=Test
+
+security_rulesdir=$(pkglibdir)
+security_rules_SCRIPTS = Gendarme.Rules.ExceptionMgmt.dll
+EXTRA_DIST = $(exceptionmgmt_rules_sources) $(exceptionmgmt_rules_sources_in) Gendarme.Rules.ExceptionMgmt.xml
+CLEANFILES = Gendarme.Rules.ExceptionMgmt.dll Test.Rules.ExceptionMgmt.dll
+DISTCLEANFILES = Makefile.in Gendarme.Rules.ExceptionMgmt.xml TestResult.xml
+
+exceptionmgmt_rules_sources_in = ../../AssemblyInfo.cs.in
+exceptionmgmt_rules_generated_sources = $(exceptionmgmt_rules_sources_in:.in=)
+exceptionmgmt_rules_sources = DontDestroyStackTrace.cs ISEHCatchBlock.cs \
+	ISEHGuardedBlock.cs ISEHHandlerBlock.cs \
+	SEHHandlerType.cs Impl/ExceptionBlockParser.cs Impl/ExecutionBlock.cs \
+	Impl/ExecutionPath.cs Impl/ExecutionPathFactory.cs Impl/SEHCatchBlock.cs \
+	Impl/SEHGuardedBlock.cs Impl/SEHHandlerBlock.cs Impl/SEHHandlerBlockCollection.cs
+
+exceptionmgmt_rules_build_sources = $(addprefix $(srcdir)/, $(exceptionmgmt_rules_sources))
+exceptionmgmt_rules_build_sources += $(exceptionmgmt_rules_generated_sources)
+
+Gendarme.Rules.ExceptionMgmt.dll: $(exceptionmgmt_rules_build_sources)
+	$(MCS) -target:library -pkg:mono-cecil -r:../../framework/Gendarme.Framework.dll -out:$@ $(exceptionmgmt_rules_build_sources)
+
+# Install Unstable Mono Libraries (see configure.ac)
+
+install-data-hook:
+	$(INSTALL) -c -m 0644 Gendarme.Rules.ExceptionMgmt.xml $(DESTDIR)$(pkglibdir);
+	for ASM in $(INSTALLED_ASSEMBLIES); do \
+		$(INSTALL) -c -m 0755 $$ASM $(DESTDIR)$(pkglibdir); \
+	done;
+
+uninstall-hook:
+	rm -f $(DESTDIR)$(pkglibdir)/`basename Gendarme.Rules.ExceptionMgmt.xml`;
+	for ASM in $(INSTALLED_ASSEMBLIES); do \
+		rm -f $(DESTDIR)$(pkglibdir)/`basename $$ASM`; \
+	done;
+
+exceptionmgmt_test_sources = TestPatterns.cs 
+exceptionmgmt_test_build_sources = $(addprefix $(srcdir)/Test/, $(exceptionmgmt_test_sources))
+
+Test.Rules.ExceptionMgmt.dll: $(exceptionmgmt_rules_build_sources)
+	$(MCS) -target:library -pkg:mono-cecil -r:nunit.framework.dll -r:../../framework/Gendarme.Framework.dll \
+		-r:Gendarme.Rules.ExceptionMgmt.dll -out:$@ $(exceptionmgmt_test_build_sources)
+
+test: Gendarme.Rules.ExceptionMgmt.dll Test.Rules.ExceptionMgmt.dll
+
+run-test: Gendarme.Rules.ExceptionMgmt.dll Test.Rules.ExceptionMgmt.dll
+	MONO_PATH=../../framework/:$(CECIL_PATH):$(MONO_PATH) nunit-console Test.Rules.ExceptionMgmt.dll
Index: rules/Gendarme.Rules.ExceptionMgmt/ISEHCatchBlock.cs
===================================================================
--- rules/Gendarme.Rules.ExceptionMgmt/ISEHCatchBlock.cs	(revision 0)
+++ rules/Gendarme.Rules.ExceptionMgmt/ISEHCatchBlock.cs	(revision 0)
@@ -0,0 +1,25 @@
+using System;
+using Mono.Cecil;
+
+namespace Gendarme.Rules.ExceptionMgmt
+{
+	
+	/// <summary>
+	/// A guarded block of IL instructions that represents a catch handler
+	/// for a specific exception type
+	/// </summary>
+	public interface ISEHCatchBlock : ISEHHandlerBlock
+	{
+		/// <summary>
+		/// The type of exception this catch block handles
+		/// </summary>
+		/// <value>
+		/// A reference to a <see cref="TypeReference"/> that indicates the
+		/// type of exception this block handles
+		/// </value>
+		TypeReference ExceptionType
+		{
+			get;
+		}
+	}	
+}

Property changes on: rules/Gendarme.Rules.ExceptionMgmt/ISEHCatchBlock.cs
___________________________________________________________________
Name: svn:executable
   + *

Index: rules/Gendarme.Rules.ExceptionMgmt/Gendarme.Rules.ExceptionMgmt.xml
===================================================================
--- rules/Gendarme.Rules.ExceptionMgmt/Gendarme.Rules.ExceptionMgmt.xml	(revision 0)
+++ rules/Gendarme.Rules.ExceptionMgmt/Gendarme.Rules.ExceptionMgmt.xml	(revision 0)
@@ -0,0 +1,8 @@
+<rules>
+	<rule	Name="DontDestroyStackTrace" 
+		Type="Gendarme.Rules.ExceptionMgmt.DontDestroyStackTrace, Gendarme.Rules.ExceptionMgmt, Version=0.0.1.0, Culture=neutral, PublicKeyToken=null"
+		Uri="http://www.mono-project.com/Gendarme" >
+		<problem>A catch block in method or property '{0}' throws the caught exception.</problem>
+		<solution>If you need to throw the exception caught by the catch block, use 'throw;' instead of 'throw ex;'</solution>
+	</rule>
+</rules>
