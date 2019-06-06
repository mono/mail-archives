? rightToLeft.patch
? test.patch
Index: ChangeLog
===================================================================
RCS file: /mono/mcs/class/System/System.Text.RegularExpressions/ChangeLog,v
retrieving revision 1.26
diff -u -r1.26 ChangeLog
--- ChangeLog	16 Mar 2004 23:04:13 -0000	1.26
+++ ChangeLog	17 Mar 2004 20:19:03 -0000
@@ -1,6 +1,20 @@
+
+2004-03-17  Francois Beauchemin <beauche@softhome.net>
+	* syntax.cs, interpreter.cs, quicksearch.cs, regex.cs, compiler.cs : 
+		Revised support for RigthToLeft. 
+		quicksearch has now an reverse option.		
+		This fixes bug #54537 
+
+ 	* regex.cs, compiler.cs :
+	 	Some code to support CILCompiler.		
+	* regex.cs : 
+		Added some undocumented of MS.
+
+
 2004-03-16  Gonzalo Paniagua Javier <gonzalo@ximian.com>
 
 	* parser.cs: allow a @"\0" escape sequence. Fixes bug #54797.
+
 
 2004-02-01  Miguel de Icaza  <miguel@ximian.com>
 
Index: compiler.cs
===================================================================
RCS file: /mono/mcs/class/System/System.Text.RegularExpressions/compiler.cs,v
retrieving revision 1.3
diff -u -r1.3 compiler.cs
--- compiler.cs	12 Nov 2002 15:54:11 -0000	1.3
+++ compiler.cs	17 Mar 2004 20:19:03 -0000
@@ -51,7 +51,11 @@
 		void EmitIn (LinkRef tail);
 		void EmitInfo (int count, int min, int max);
 		void EmitFastRepeat (int min, int max, bool lazy, LinkRef tail);
-		void EmitAnchor (int offset, LinkRef tail);
+		void EmitAnchor (bool reverse, int offset, LinkRef tail);
+
+		// event for the CILCompiler
+		void EmitBranchEnd();
+		void EmitAlternationEnd();
 
 		LinkRef NewLink ();
 		void ResolveLink (LinkRef link);
@@ -254,9 +258,9 @@
 			EmitLink (tail);
 		}
 
-		public void EmitAnchor (int offset, LinkRef tail) {
+		public void EmitAnchor (bool reverse, int offset, LinkRef tail) {
 			BeginLink (tail);
-			Emit (OpCode.Anchor);
+			Emit (OpCode.Anchor, MakeFlags(false, false, reverse, false));
 			EmitLink (tail);
 			Emit ((ushort)offset);
 		}
@@ -279,6 +283,9 @@
 				pgm[stack.OffsetAddress] = (ushort)stack.GetOffset (CurrentAddress);
 		}
 
+		public void EmitBranchEnd(){}
+		public void EmitAlternationEnd(){}
+
 		// private members
 
 		private static OpFlags MakeFlags (bool negate, bool ignore, bool reverse, bool lazy) {
@@ -319,6 +326,7 @@
 			stack.Push ();
 		}
 
+
 		private class PatternLinkStack : LinkStack {
 			public PatternLinkStack () {
 			}
@@ -375,4 +383,23 @@
 
 		private Stack stack;
 	}
+
+	//Used by CILCompiler and Interpreter
+	internal struct Mark {
+		public int Start, End;
+		public int Previous;
+		
+		public bool IsDefined {
+			get { return Start >= 0 && End >= 0; }
+		}
+		
+		public int Index {
+			get { return Start < End ? Start : End; }
+		}
+		
+		public int Length {
+			get { return Start < End ? End - Start : Start - End; }
+		}
+	}
+
 }
Index: interpreter.cs
===================================================================
RCS file: /mono/mcs/class/System/System.Text.RegularExpressions/interpreter.cs,v
retrieving revision 1.4
diff -u -r1.4 interpreter.cs
--- interpreter.cs	27 Nov 2003 15:31:59 -0000	1.4
+++ interpreter.cs	17 Mar 2004 20:19:03 -0000
@@ -63,54 +63,66 @@
 				switch (op) {
 				case OpCode.Anchor: {
 					int skip = program[pc + 1];
-
+					
 					int anch_offset = program[pc + 2];
-					int anch_ptr = ptr + anch_offset;
-					int anch_end = text_end - match_min + anch_offset;	// maximum anchor position
+					bool anch_reverse = (flags & OpFlags.RightToLeft) != 0;	
+					int anch_ptr = anch_reverse ?  ptr - anch_offset  : ptr + anch_offset;
+					int anch_end = text_end - match_min + anch_offset;	// maximum anchor position  
+					
+					
+					int anch_begin =  0;
+
 
 					// the general case for an anchoring expression is at the bottom, however we
 					// do some checks for the common cases before to save processing time. the current
 					// optimizer only outputs three types of anchoring expressions: fixed position,
 					// fixed substring, and no anchor.
 
-					OpCode anch_op = (OpCode)(program[pc + 3] & 0x00ff);
+					OpCode anch_op = (OpCode)(program[pc + 3] & 0x00ff);					
 					if (anch_op == OpCode.Position && skip == 6) {				// position anchor
 						// Anchor
 						// 	Position
 						//	True
 
 						switch ((Position)program[pc + 4]) {
-						case Position.StartOfString:
-							if (anch_ptr == 0) {
-								ptr = 0;
+						case Position.StartOfString:							
+							if (anch_reverse || anch_offset == 0) {
+								ptr = anch_offset;
 								if (TryMatch (ref ptr, pc + skip))
 									goto Pass;
 							}
 							break;
 						
 						case Position.StartOfLine:
-							if (anch_ptr == 0) {
+													
+							 if (anch_ptr == 0) {
 								ptr = 0;
 								if (TryMatch (ref ptr, pc + skip))
 									goto Pass;
-
+								
 								++ anch_ptr;
 							}
 
-							while (anch_ptr <= anch_end) {
-								if (text[anch_ptr - 1] == '\n') {
-									ptr = anch_ptr - anch_offset;
+							while ((anch_reverse && anch_ptr >= 0) || (!anch_reverse && anch_ptr <= anch_end)) {  
+								if (anch_ptr == 0 || text[anch_ptr - 1] == '\n') {
+									if (anch_reverse)
+										ptr = anch_ptr == anch_end ? anch_ptr : anch_ptr + anch_offset;
+									else
+										ptr = anch_ptr == 0 ? anch_ptr : anch_ptr - anch_offset;
 									if (TryMatch (ref ptr, pc + skip))
 										goto Pass;
 								}
-
-								++ anch_ptr;
+							
+								if (anch_reverse)
+									-- anch_ptr;
+								else
+									++ anch_ptr;
 							}
 							break;
 						
 						case Position.StartOfScan:
-							if (anch_ptr == scan_ptr) {
-								ptr = scan_ptr - anch_offset;
+							if (anch_ptr == scan_ptr) {							
+								ptr = anch_reverse ? scan_ptr + anch_offset : scan_ptr - anch_offset;
 								if (TryMatch (ref ptr, pc + skip))
 									goto Pass;
 							}
@@ -126,36 +138,55 @@
 						// Anchor
 						//	String
 						//	True
+				 
+						bool reverse = ((OpFlags)program[pc + 3] & OpFlags.RightToLeft) != 0;
+						string substring = GetString (pc + 3);
 
 						if (qs == null) {
 							bool ignore = ((OpFlags)program[pc + 3] & OpFlags.IgnoreCase) != 0;
-							string substring = GetString (pc + 3);
 
-							qs = new QuickSearch (substring, ignore);
+							qs = new QuickSearch (substring, ignore, reverse);
 						}
+						while ((anch_reverse && anch_ptr >= anch_begin) 
+						       || (!anch_reverse && anch_ptr <= anch_end)) {
 
-						while (anch_ptr <= anch_end) {
-							anch_ptr = qs.Search (text, anch_ptr, anch_end);
+							if (reverse) 	
+							{
+								anch_ptr = qs.Search (text, anch_ptr, anch_begin);
+								if (anch_ptr != -1)
+									anch_ptr += substring.Length ;
+								
+							}
+							else
+								anch_ptr = qs.Search (text, anch_ptr, anch_end);
 							if (anch_ptr < 0)
 								break;
 
-							ptr = anch_ptr - anch_offset;
+							ptr = reverse ? anch_ptr + anch_offset : anch_ptr - anch_offset;
 							if (TryMatch (ref ptr, pc + skip))
 								goto Pass;
 
-							++ anch_ptr;
+							if (reverse)
+								anch_ptr -= 2;
+							else 
+								++ anch_ptr;
 						}
 					}
 					else if (anch_op == OpCode.True) {					// no anchor
 						// Anchor
 						//	True
 
-						while (anch_ptr <= anch_end) {
+					
+						while ((anch_reverse && anch_ptr >= anch_begin) 
+						       || (!anch_reverse && anch_ptr <= anch_end)) {
+
 							ptr = anch_ptr;
 							if (TryMatch (ref ptr, pc + skip))
 								goto Pass;
-
-							++ anch_ptr;
+							if (anch_reverse)
+								-- anch_ptr;
+							else 
+								++ anch_ptr;
 						}
 					}
 					else {									// general case
@@ -163,17 +194,22 @@
 						//	<expr>
 						//	True
 
-						while (anch_ptr <= anch_end) {
+						while ((anch_reverse && anch_ptr >= anch_begin) 
+						       || (!anch_reverse && anch_ptr <= anch_end)) {
+
 							ptr = anch_ptr;
 							if (Eval (Mode.Match, ref ptr, pc + 3)) {
 								// anchor expression passed: try real expression at the correct offset
 
-								ptr = anch_ptr - anch_offset;
+								ptr = anch_reverse ? anch_ptr + anch_offset : anch_ptr - anch_offset;
 								if (TryMatch (ref ptr, pc + skip))
 									goto Pass;
 							}
 
-							++ anch_ptr;
+						    if (anch_reverse)
+								-- anch_ptr;
+							else 
+								++ anch_ptr;
 						}
 					}
 
@@ -205,7 +241,8 @@
 						if (ptr < 0)
 							goto Fail;
 					}
-					else if (ptr + len > text_end)
+					else 
+					if (ptr + len > text_end)
 						goto Fail;
 
 					pc += 2;
@@ -460,7 +497,16 @@
 						OpFlags tail_flags = (OpFlags)(tail_word & 0xff00);
 
 						if (tail_op == OpCode.String)
-							c1 = program[pc + 2];				// first char of string
+						{
+							int offset = 0;
+						
+							if ((tail_flags & OpFlags.RightToLeft) != 0)
+							{
+								offset = program[pc + 1] - 1 ;
+							}
+							  
+							c1 = program[pc + 2 + offset];				// first char of string
+						}
 						else
 							c1 = program[pc + 1];				// character
 						
@@ -585,6 +631,7 @@
 			char c = '\0';
 			bool negate;
 			bool ignore;
+		
 			do {
 				ushort word = program[pc];
 				OpCode op = (OpCode)(word & 0x00ff);
@@ -660,6 +707,7 @@
 					int i = (int)c - lo;
 					if (i < 0 || i >= len << 4)
 						break;
+						
 
 					if ((program[bits + (i >> 4)] & (1 << (i & 0xf))) != 0)
 						return !negate;
@@ -876,7 +924,7 @@
 		private int[] groups;			// current group definitions
 
 		// private classes
-
+/*
 		private struct Mark {
 			public int Start, End;
 			public int Previous;
@@ -893,7 +941,7 @@
 				get { return Start < End ? End - Start : Start - End; }
 			}
 		}
-
+*/
 		private class RepeatContext {
 			public RepeatContext (RepeatContext previous, int min, int max, bool lazy, int expr_pc) {
 				this.previous = previous;
Index: quicksearch.cs
===================================================================
RCS file: /mono/mcs/class/System/System.Text.RegularExpressions/quicksearch.cs,v
retrieving revision 1.3
diff -u -r1.3 quicksearch.cs
--- quicksearch.cs	2 Dec 2003 03:51:03 -0000	1.3
+++ quicksearch.cs	17 Mar 2004 20:19:03 -0000
@@ -14,14 +14,19 @@
 using System.Collections;
 
 namespace System.Text.RegularExpressions {
-	class QuickSearch {
+	public class QuickSearch {
 		// simplified boyer-moore for fast substring matching
 		// (for short strings, we use simple scans)
+		public QuickSearch (string str, bool ignore) 
+			: this(str, ignore, false)
+		{
+		}
 	
-		public QuickSearch (string str, bool ignore) {
+		public QuickSearch (string str, bool ignore, bool reverse) {
 			this.str = str;
 			this.len = str.Length;
 			this.ignore = ignore;
+			this.reverse = reverse;
 
 			if (ignore)
 				str = str.ToLower ();
@@ -46,44 +51,112 @@
 		public int Search (string text, int start, int end) {
 			int ptr = start;
 
-			// use simple scan for a single-character search string
-			if (len == 1) {
-				while (ptr <= end) {
-					if(str[0] == GetChar(text[ptr]))
-						return ptr;
+		
+			if ( reverse ) 
+			{
+				if (start < end)
+					return -1;
+
+				if ( ptr > text.Length) 
+				{
+					ptr = text.Length;
+				}
+
+				// use simple scan for a single-character search string
+				if (len == 1) 
+				{
+					while (--ptr >= end) 
+					{
+						if(str[0] == GetChar(text[ptr]))
+							return ptr ;
+						
+					}
+					return -1;
+				}
+
+		
+				if ( end < len)
+					end =  len - 1 ;
+
+				ptr--;
+				while (ptr >= end) 
+				{
+					int i = len -1 ;
+					while (str[i] == GetChar(text[ptr - len +1 + i])) 
+					{
+						if (-- i <  0)
+							return ptr - len + 1;
+					}
+
+					if (ptr > end)
+					{
+						ptr -= GetShiftDistance (text[ptr - len ]);
+					
+					}
 					else
-						ptr++;
+						break;
 				}
-				return -1;
+
 			}
+			else 
+			{
+				// use simple scan for a single-character search string
+				if (len == 1) 
+				{
+					while (ptr <= end) 
+					{
+						if(str[0] == GetChar(text[ptr]))
+							return ptr;
+						else
+							ptr++;
+					}	
+					return -1;
+				}
 
-			if (end > text.Length - len)
-				end = text.Length - len;
+				if (end > text.Length - len)
+					end = text.Length - len;
 
-			while (ptr <= end) {
-				int i = len - 1;
-				while (str[i] == GetChar(text[ptr + i])) {
-					if (-- i < 0)
-						return ptr;
-				}
+				while (ptr <= end) 
+				{
+					int i = len - 1;
+					while (str[i] == GetChar(text[ptr + i])) 
+					{
+						if (-- i < 0)
+							return ptr;
+					}
 
-				if (ptr < end)
-					ptr += GetShiftDistance (text[ptr + len]);
-				else
-					break;
+					if (ptr < end)
+						ptr += GetShiftDistance (text[ptr + len]);
+					else
+						break;
+				}
 			}
 
 			return -1;
+				
 		}
 
-		// private
+			// private
 
 		private void SetupShiftTable () {
 			shift = new Hashtable ();
-			for (int i = 0; i < len; ++ i) {
-				char c = str[i];
-				shift[GetChar(c)] = len - i;
+			if (reverse)
+			{
+				for (int i = len ; i > 0; -- i) 
+				{
+					char c = str[i -1];
+					shift[GetChar(c)] = i;
+				}
+			}
+			else
+			{
+				for (int i = 0; i < len; ++ i) 
+				{
+					char c = str[i];
+					shift[GetChar(c)] = len - i;
+				}
 			}
+			
 		}
 	    
 		private int GetShiftDistance (char c) {
@@ -101,6 +174,7 @@
 		private string str;
 		private int len;
 		private bool ignore;
+		private bool reverse;
 
 		private Hashtable shift;
 		private readonly static int THRESHOLD = 5;
Index: regex.cs
===================================================================
RCS file: /mono/mcs/class/System/System.Text.RegularExpressions/regex.cs,v
retrieving revision 1.17
diff -u -r1.17 regex.cs
--- regex.cs	7 Jan 2004 18:23:37 -0000	1.17
+++ regex.cs	17 Mar 2004 20:19:03 -0000
@@ -16,6 +16,9 @@
 using RegularExpression = System.Text.RegularExpressions.Syntax.RegularExpression;
 using Parser = System.Text.RegularExpressions.Syntax.Parser;
 
+using System.Diagnostics;
+
+
 namespace System.Text.RegularExpressions {
 	
 	public delegate string MatchEvaluator (Match match);
@@ -39,21 +42,49 @@
 		public static void CompileToAssembly
 			(RegexCompilationInfo[] regexes, AssemblyName aname)
 		{
-			throw new Exception ("Not implemented.");
+				Regex.CompileToAssembly(regexes, aname, new CustomAttributeBuilder[] {}, null);
 		}
 
 		public static void CompileToAssembly
 			(RegexCompilationInfo[] regexes, AssemblyName aname,
 			 CustomAttributeBuilder[] attribs)
 		{
-			throw new Exception ("Not implemented.");
+			Regex.CompileToAssembly(regexes, aname, attribs, null);		       
 		}
 
 		public static void CompileToAssembly
 			(RegexCompilationInfo[] regexes, AssemblyName aname,
 			 CustomAttributeBuilder[] attribs, string resourceFile)
 		{
-			throw new Exception ("Not implemented.");
+			throw new Exception ("Not fully implemented.");
+			// TODO : Make use of attribs and resourceFile parameters
+			/*
+			AssemblyBuilder asmBuilder = AppDomain.CurrentDomain.DefineDynamicAssembly (aname, AssemblyBuilderAccess.RunAndSave);
+			ModuleBuilder modBuilder = asmBuilder.DefineDynamicModule("InnerRegexModule",aname.Name);
+			Parser psr = new Parser ();	
+			
+			System.Console.WriteLine("CompileToAssembly");
+			       
+			for(int i=0; i < regexes.Length; i++)
+				{
+					System.Console.WriteLine("Compiling expression :" + regexes[i].Pattern);
+					RegularExpression re = psr.ParseRegularExpression (regexes[i].Pattern, regexes[i].Options);
+					
+					// compile
+										
+					CILCompiler cmp = new CILCompiler (modBuilder, i);
+					bool reverse = (regexes[i].Options & RegexOptions.RightToLeft) !=0;
+					re.Compile (cmp, reverse);
+					cmp.Close();
+					
+				}
+		       
+
+			// Define a runtime class with specified name and attributes.
+			TypeBuilder builder = modBuilder.DefineType("ITest");
+			builder.CreateType();
+			asmBuilder.Save(aname.Name);
+			*/
 		}
 		
 		public static string Escape (string str) {
@@ -136,6 +167,7 @@
 
 		protected Regex () {
 			// XXX what's this constructor for?
+			// : Used to compile to assembly (Custum regex inherit from Regex and use this constructor)
 		}
 
 		public Regex (string pattern) : this (pattern, RegexOptions.None) {
@@ -143,11 +175,11 @@
 
 		public Regex (string pattern, RegexOptions options) {
 			this.pattern = pattern;
-			this.options = options;
+			this.roptions = options;
 		
-			this.factory = cache.Lookup (pattern, options);
+			this.machineFactory = cache.Lookup (pattern, options);
 
-			if (this.factory == null) {
+			if (this.machineFactory == null) {
 				// parse and install group mapping
 
 				Parser psr = new Parser ();
@@ -159,8 +191,8 @@
 				
 				ICompiler cmp;
 				//if ((options & RegexOptions.Compiled) != 0)
-				//	throw new Exception ("Not implemented.");
-					//cmp = new CILCompiler ();
+				//	//throw new Exception ("Not implemented.");
+				//	cmp = new CILCompiler ();
 				//else
 					cmp = new PatternCompiler ();
 
@@ -168,29 +200,29 @@
 
 				// install machine factory and add to pattern cache
 
-				this.factory = cmp.GetMachineFactory ();
-				this.factory.Mapping = mapping;
-				cache.Add (pattern, options, this.factory);
+				this.machineFactory = cmp.GetMachineFactory ();
+				this.machineFactory.Mapping = mapping;
+				cache.Add (pattern, options, this.machineFactory);
 			} else {
-				this.group_count = this.factory.GroupCount;
-				this.mapping = this.factory.Mapping;
+				this.group_count = this.machineFactory.GroupCount;
+				this.mapping = this.machineFactory.Mapping;
 			}
 		}
 
 		protected Regex (SerializationInfo info, StreamingContext context) :
 			this (info.GetString ("pattern"), 
-			      (RegexOptions) info.GetValue ("options", typeof (RegexOptions))) {			
+			      (RegexOptions) info.GetValue ("roptions", typeof (RegexOptions))) {			
 		}
 
 
 		// public instance properties
 		
 		public RegexOptions Options {
-			get { return options; }
+			get { return roptions; }
 		}
 
 		public bool RightToLeft {
-			get { return (options & RegexOptions.RightToLeft) != 0; }
+			get { return (roptions & RegexOptions.RightToLeft) != 0; }
 		}
 
 		// public instance methods
@@ -231,7 +263,10 @@
 		// match methods
 		
 		public bool IsMatch (string input) {
-			return IsMatch (input, 0);
+			if (RightToLeft)
+				return IsMatch (input, input.Length);
+			else
+				return IsMatch (input, 0);
 		}
 
 		public bool IsMatch (string input, int startat) {
@@ -239,19 +274,27 @@
 		}
 
 		public Match Match (string input) {
-			return Match (input, 0);
+			if (RightToLeft)
+				return Match (input, input.Length);
+			else
+				return Match (input, 0);
 		}
 
 		public Match Match (string input, int startat) {
+	
 			return CreateMachine ().Scan (this, input, startat, input.Length);
 		}
 
 		public Match Match (string input, int startat, int length) {
+	
 			return CreateMachine ().Scan (this, input, startat, startat + length);
 		}
 
 		public MatchCollection Matches (string input) {
-			return Matches (input, 0);
+			if (RightToLeft)
+				return Matches (input, input.Length);
+			else
+				return Matches (input, 0);
 		}
 
 		public MatchCollection Matches (string input, int startat) {
@@ -268,11 +311,17 @@
 		// replace methods
 
 		public string Replace (string input, MatchEvaluator evaluator) {
-			return Replace (input, evaluator, Int32.MaxValue, 0);
+			if (RightToLeft)			
+				return Replace (input, evaluator, Int32.MaxValue, input.Length);
+			else
+				return Replace (input, evaluator, Int32.MaxValue, 0);
 		}
 
 		public string Replace (string input, MatchEvaluator evaluator, int count) {
-			return Replace (input, evaluator, count, 0);
+			if (RightToLeft)
+				return Replace (input, evaluator, count, input.Length);
+			else
+				return Replace (input, evaluator, count, 0);
 		}
 
 		public string Replace (string input, MatchEvaluator evaluator, int count, int startat)
@@ -294,11 +343,17 @@
 		}
 
 		public string Replace (string input, string replacement) {
-			return Replace (input, replacement, Int32.MaxValue, 0);
+			if (RightToLeft)
+				return Replace (input, replacement, Int32.MaxValue, input.Length);
+			else
+				return Replace (input, replacement, Int32.MaxValue, 0);
 		}
 
 		public string Replace (string input, string replacement, int count) {
-			return Replace (input, replacement, count, 0);
+			if (RightToLeft)			
+				return Replace (input, replacement, count, input.Length);
+			else	
+				return Replace (input, replacement, count, 0);
 		}
 
 		public string Replace (string input, string replacement, int count, int startat) {
@@ -309,11 +364,17 @@
 		// split methods
 
 		public string[] Split (string input) {
-			return Split (input, Int32.MaxValue, 0);
+			if (RightToLeft)	
+				return Split (input, Int32.MaxValue, input.Length);
+			else
+				return Split (input, Int32.MaxValue, 0);
 		}
 
 		public string[] Split (string input, int count) {
-			return Split (input, count, 0);
+			if (RightToLeft)				
+				return Split (input, count, input.Length);
+			else
+				return Split (input, count, 0);
 		}
 
 		public string[] Split (string input, int count, int startat) {
@@ -327,23 +388,53 @@
 				if (!m.Success)
 					break;
 			
-				splits.Add (input.Substring (ptr, m.Index - ptr));
+				if (RightToLeft)
+					splits.Add (input.Substring (m.Index + m.Length , ptr - m.Index - m.Length ));
+				else
+					splits.Add (input.Substring (ptr, m.Index - ptr));
+					
 				int gcount = m.Groups.Count;
 				for (int gindex = 1; gindex < gcount; gindex++) {
 					Group grp = m.Groups [gindex];
 					splits.Add (input.Substring (grp.Index, grp.Length));
 				}
 
-				ptr = m.Index + m.Length;
+				if (RightToLeft)
+					ptr = m.Index; 
+				else
+					ptr = m.Index + m.Length;
+					
 			}
 
-			if (ptr <= input.Length) {
-				splits.Add (input.Substring (ptr));
+			if (RightToLeft) {
+				if ( ptr >= 0) {
+						splits.Add (input.Substring(0, ptr));
+				}
+			}				
+			else {
+				if (ptr <= input.Length) {
+						splits.Add (input.Substring (ptr));
+				}
+				
 			}
 
 			return (string []) splits.ToArray (typeof (string));
 		}
 
+		// MS undocummented method
+                               
+		protected void InitializeReferences() {
+			throw new Exception ("Not implemented.");
+		}
+		
+		protected bool UseOptionC(){
+			throw new Exception ("Not implemented.");
+		}
+
+		protected bool UseOptionR(){
+			throw new Exception ("Not implemented.");
+		}
+
 		// object methods
 		
 		public override string ToString () {
@@ -353,7 +444,7 @@
 		// ISerializable interface
 		public virtual void GetObjectData (SerializationInfo info, StreamingContext context) {
 			info.AddValue ("pattern", this.ToString (), typeof (string));
-			info.AddValue ("options", this.Options, typeof (RegexOptions));
+			info.AddValue ("roptions", this.Options, typeof (RegexOptions));
 		}
 
 		// internal
@@ -365,15 +456,25 @@
 		// private
 
 		private IMachine CreateMachine () {
-			return factory.NewInstance ();
+			return machineFactory.NewInstance ();
 		}
 
-		protected internal string pattern;
-		private RegexOptions options;
-
-		private IMachineFactory factory;
+		private IMachineFactory machineFactory;
 		private IDictionary mapping;
 		private int group_count;
+
+		
+		// protected members
+
+		protected internal string pattern;
+		protected internal RegexOptions roptions;
+		
+		// MS undocumented members
+		protected internal System.Collections.Hashtable capnames;
+		protected internal System.Collections.Hashtable cap;
+		protected internal int capsize;
+		protected internal string[] caplist;
+		protected internal RegexRunnerFactory factory;
 	}
 
 	[Serializable]
Index: syntax.cs
===================================================================
RCS file: /mono/mcs/class/System/System.Text.RegularExpressions/syntax.cs,v
retrieving revision 1.2
diff -u -r1.2 syntax.cs
--- syntax.cs	2 Feb 2004 03:02:08 -0000	1.2
+++ syntax.cs	17 Mar 2004 20:19:03 -0000
@@ -43,7 +43,7 @@
 			return -1;
 		}
 
-		public virtual AnchorInfo GetAnchorInfo () {
+		public virtual AnchorInfo GetAnchorInfo (bool reverse) {
 			return new AnchorInfo (this, GetFixedWidth ());
 		}
 
@@ -130,7 +130,7 @@
 			}
 		}
 
-		public override AnchorInfo GetAnchorInfo () {
+		public override AnchorInfo GetAnchorInfo (bool reverse) {
 			int ptr;
 			int width = GetFixedWidth ();
 
@@ -140,8 +140,16 @@
 			// accumulate segments
 
 			ptr = 0;
-			foreach (Expression e in Expressions) {
-				AnchorInfo info = e.GetAnchorInfo ();
+			//foreach (Expression e in Expressions) {
+			int count = Expressions.Count;
+			for (int i = 0; i < count; ++ i) {
+				Expression e;
+				if (reverse)
+					e = Expressions [count - i - 1];
+				else
+					e = Expressions [i];		
+				
+				AnchorInfo info = e.GetAnchorInfo (reverse);
 				infos.Add (info);
 
 				if (info.IsPosition)
@@ -170,20 +178,40 @@
 
 			if (!longest.IsEmpty) {
 				string str = "";
+				ArrayList strs = new ArrayList();
 				bool ignore = false;
 
 				ptr = 0;
-				foreach (AnchorInfo info in infos) {
+				
+				//foreach (AnchorInfo info in infos) {
+				for (int i = 0; i < infos.Count; ++ i) {
+					AnchorInfo info;
+
+					info = (AnchorInfo)infos[i];		
+					
 					if (info.IsSubstring && longest.Contains (info.GetInterval (ptr))) {
-						str += info.Substring;	// TODO mark subexpressions
+						//str += info.Substring;	// TODO mark subexpressions
+						strs.Add(info.Substring);
 						ignore |= info.IgnoreCase;
 					}
 
-					if (info.IsUnknownWidth)
-						break;
-
-					ptr += info.Width;
+					
+					 	if (info.IsUnknownWidth)					 		
+							break;
+					
+						ptr += info.Width;
+				}	
+					
+				for (int i = 0; i< strs.Count; ++i)
+				{
+					if (reverse)
+						str += strs [strs.Count - i - 1];
+					else
+						str += strs [i];
+							
+					
 				}
+			
 
 				return new AnchorInfo (this, longest.low, width, str, ignore);
 			}
@@ -220,12 +248,12 @@
 
 			// anchoring expression
 
-			AnchorInfo info = GetAnchorInfo ();
-			if (reverse)
-				info = new AnchorInfo (this, GetFixedWidth ());	// FIXME
+			AnchorInfo info = GetAnchorInfo (reverse);
+			//if (reverse)
+			//	info = new AnchorInfo (this, GetFixedWidth ());	// FIXME
 
 			LinkRef pattern = cmp.NewLink ();
-			cmp.EmitAnchor (info.Offset, pattern);
+			cmp.EmitAnchor (reverse, info.Offset, pattern);
 
 			if (info.IsPosition)
 				cmp.EmitPosition (info.Position);
@@ -385,12 +413,12 @@
 				max = max * this.max;
 		}
 
-		public override AnchorInfo GetAnchorInfo () {
+		public override AnchorInfo GetAnchorInfo (bool reverse) {
 			int width = GetFixedWidth ();
 			if (Minimum == 0)
 				return new AnchorInfo (this, width);
 			
-			AnchorInfo info = Expression.GetAnchorInfo ();
+			AnchorInfo info = Expression.GetAnchorInfo (reverse);
 			if (info.IsPosition)
 				return new AnchorInfo (this, info.Offset, width, info.Position);
 			
@@ -524,7 +552,7 @@
 			
 			// test expression: lookahead / lookbehind
 
-			TestExpression.Compile (cmp, reverse ^ this.reverse);
+			TestExpression.Compile (cmp, this.reverse);
 			cmp.EmitTrue ();
 
 			// target expressions
@@ -587,18 +615,21 @@
 		}
 
 		public override void Compile (ICompiler cmp, bool reverse) {
-			LinkRef next = cmp.NewLink ();
+			//			LinkRef next = cmp.NewLink ();
 			LinkRef tail = cmp.NewLink ();
 		
 			foreach (Expression e in Alternatives) {
+				LinkRef next = cmp.NewLink ();
 				cmp.EmitBranch (next);
 				e.Compile (cmp, reverse);
 				cmp.EmitJump (tail);
 				cmp.ResolveLink (next);
+				cmp.EmitBranchEnd();
 			}
 
 			cmp.EmitFalse ();
 			cmp.ResolveLink (tail);
+			cmp.EmitAlternationEnd();
 		}
 
 		public override void GetWidth (out int min, out int max) {
@@ -647,7 +678,7 @@
 			min = max = str.Length;
 		}
 
-		public override AnchorInfo GetAnchorInfo () {
+		public override AnchorInfo GetAnchorInfo (bool reverse) {
 			return new AnchorInfo (this, 0, str.Length, str, ignore);
 		}
 
@@ -681,7 +712,7 @@
 			return false;
 		}
 
-		public override AnchorInfo GetAnchorInfo () {
+		public override AnchorInfo GetAnchorInfo (bool revers) {
 			switch (pos) {
 			case Position.StartOfString: case Position.StartOfLine: case Position.StartOfScan:
 				return new AnchorInfo (this, 0, 0, pos);
@@ -816,7 +847,6 @@
 
 		public override void Compile (ICompiler cmp, bool reverse) {
 			// create the meta-collection
-
 			IntervalCollection meta =
 				intervals.GetMetaCollection (new IntervalCollection.CostDelegate (GetIntervalCost));
 
@@ -836,6 +866,7 @@
 			LinkRef tail = cmp.NewLink ();
 			if (count > 1)
 				cmp.EmitIn (tail);
+				
 
 			// emit categories
 
@@ -1004,3 +1035,4 @@
 		}
 	}
 }
+
