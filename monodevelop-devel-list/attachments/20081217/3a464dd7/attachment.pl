Index: addins/Mono.Texteditor/Mono.TextEditor/DocumentLocation.cs
===================================================================
--- addins/Mono.Texteditor/Mono.TextEditor/DocumentLocation.cs	(revision 121639)
+++ addins/Mono.Texteditor/Mono.TextEditor/DocumentLocation.cs	(working copy)
@@ -42,7 +42,7 @@
 			}
 		}
 		
-		public DocumentLocation (int line, int column)
+		public DocumentLocation (int line, int column) : this ()
 		{
 			this.Line = line;
 			this.Column = column;
Index: core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/DomLocation.cs
===================================================================
--- core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/DomLocation.cs	(revision 121639)
+++ core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/DomLocation.cs	(working copy)
@@ -55,7 +55,7 @@
 			}
 		}
 		
-		public DomLocation (int line, int column)
+		public DomLocation (int line, int column) : this ()
 		{
 			this.Line   = line;
 			this.Column = column;
Index: core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/DomRegion.cs
===================================================================
--- core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/DomRegion.cs	(revision 121639)
+++ core/MonoDevelop.Projects/MonoDevelop.Projects.Dom/DomRegion.cs	(working copy)
@@ -55,7 +55,7 @@
 		{
 		}
 		
-		public DomRegion (int startLine, int startColumn, int endLine, int endColumn)
+		public DomRegion (int startLine, int startColumn, int endLine, int endColumn) : this ()
 		{
 			this.Start = new DomLocation (startLine, startColumn);
 			this.End   = new DomLocation (endLine, endColumn);