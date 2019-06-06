diff -u mono/interpreter.cs tip/interpreter.cs
--- mono/interpreter.cs	2004-02-20 12:21:39.429113320 -0500
+++ tip/interpreter.cs	2004-02-20 12:23:13.792767864 -0500
@@ -128,14 +128,20 @@
 						//	True
 
 						if (qs == null) {
-							bool ignore = ((OpFlags)program[pc + 3] & OpFlags.IgnoreCase) != 0;
+							bool ignore = ((OpFlags)program[pc + 3] & OpFlags.IgnoreCase) != 0;							
 							string substring = GetString (pc + 3);
 
 							qs = new QuickSearch (substring, ignore);
 						}
-
-						while (anch_ptr <= anch_end) {
-							anch_ptr = qs.Search (text, anch_ptr, anch_end);
+						bool reverse = ((OpFlags)program[pc + 3] & OpFlags.RightToLeft) != 0;
+						while (anch_ptr <= anch_end) {							if (reverse) 
+							{
+								anch_ptr = qs.reverseSearch (text, anch_ptr, 0);
+								string substring = GetString (pc + 3);
+								anch_ptr += substring.Length;
+							}
+							else
+								anch_ptr = qs.Search (text, anch_ptr, anch_end);
 							if (anch_ptr < 0)
 								break;
 
diff -u mono/quicksearch.cs tip/quicksearch.cs
--- mono/quicksearch.cs	2004-02-20 12:22:51.034227688 -0500
+++ tip/quicksearch.cs	2004-02-20 12:12:34.887896168 -0500
@@ -76,6 +76,49 @@
 			return -1;
 		}
 
+		public int reverseSearch (string text, int start, int end) 
+		{			
+			if (start < end)
+				return -1;
+
+			int ptr = start;
+
+			// use simple scan for a single-character search string
+			if (len == 1) 
+			{
+				while (ptr >= end) 
+				{
+					if(str[0] == GetChar(text[ptr]))
+						return ptr;
+					else
+						ptr--;
+				}
+				return -1;
+			}
+
+		
+			if ( end < len)
+				end = len;
+
+			while (ptr >= end) 
+			{
+				int i = 0;
+				while (str[i] == GetChar(text[ptr - i])) 
+				{
+					if (++ i > len)
+						return ptr;
+				}
+
+				if (ptr > end)
+					ptr -= GetShiftDistance (text[ptr + len]);
+				else
+					break;
+			}
+
+			return -1;
+		}
+
+
 		// private
 
 		private void SetupShiftTable () {
diff -u mono/regex.cs tip/regex.cs
--- mono/regex.cs	2004-02-20 12:22:30.589335784 -0500
+++ tip/regex.cs	2004-02-20 12:15:42.685346616 -0500
@@ -231,7 +261,10 @@
 		// match methods
 		
 		public bool IsMatch (string input) {
-			return IsMatch (input, 0);
+			if (RightToLeft)
+				return IsMatch (input, input.Length);
+			else
+				return IsMatch (input, 0);
 		}
 
 		public bool IsMatch (string input, int startat) {
@@ -239,19 +272,27 @@
 		}
 
 		public Match Match (string input) {
-			return Match (input, 0);
+			if (RightToLeft)
+				return Match (input, input.Length);
+			else
+				return Match (input, 0);
 		}
 
 		public Match Match (string input, int startat) {
+			if (RightToLeft) --startat;
 			return CreateMachine ().Scan (this, input, startat, input.Length);
 		}
 
 		public Match Match (string input, int startat, int length) {
+			if (RightToLeft) --startat;
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
@@ -268,11 +309,17 @@
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
@@ -294,11 +341,17 @@
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
@@ -309,11 +362,17 @@
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
@@ -327,23 +386,53 @@
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
diff -u mono/syntax.cs tip/syntax.cs
--- mono/syntax.cs	2004-02-20 12:21:39.445110888 -0500
+++ tip/syntax.cs	2004-02-20 12:23:40.973635744 -0500
@@ -221,8 +221,8 @@
 			// anchoring expression
 
 			AnchorInfo info = GetAnchorInfo ();
-			if (reverse)
-				info = new AnchorInfo (this, GetFixedWidth ());	// FIXME
+			//if (reverse)
+			//	info = new AnchorInfo (this, GetFixedWidth ());	// FIXME
 
 			LinkRef pattern = cmp.NewLink ();
 			cmp.EmitAnchor (info.Offset, pattern);
