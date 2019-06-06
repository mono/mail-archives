Index: ListBox.cs
===================================================================
--- ListBox.cs	(revision 44453)
+++ ListBox.cs	(working copy)
@@ -124,7 +124,6 @@
 		private SelectionMode selection_mode;
 		private bool sorted;
 		private bool use_tabstops;
-		private int preferred_height;
 		private int top_index;
 		private int column_width_internal;
 		private VScrollBar vscrollbar_ctrl;
@@ -146,7 +145,6 @@
 			horizontal_scrollbar = false;
 			integral_height = true;
 			multicolumn = false;
-			preferred_height = 7;
 			scroll_always_visible = false;
 			selected_index = -1;
 			focused_item = -1;
@@ -409,7 +407,22 @@
 		[DesignerSerializationVisibility (DesignerSerializationVisibility.Hidden)]
 		[EditorBrowsable (EditorBrowsableState.Advanced)]
 		public int PreferredHeight {
-			get { return preferred_height;}
+			get {
+				int itemsHeight = 0;
+				if (draw_mode == DrawMode.Normal)
+					itemsHeight = FontHeight * items.Count;
+				else if (draw_mode == DrawMode.OwnerDrawFixed)
+					itemsHeight = ItemHeight * items.Count;
+				else if (draw_mode == DrawMode.OwnerDrawVariable) {
+					for (int i = 0; i < items.Count; i++)
+						itemsHeight += items.GetListBoxItem (i).ItemHeight;
+				}
+				
+				itemsHeight += ThemeEngine.Current.DrawListBoxDecorationTop (BorderStyle);
+				itemsHeight += ThemeEngine.Current.DrawListBoxDecorationBottom (BorderStyle);
+				
+				return itemsHeight;
+			}
 		}
 
 		public override RightToLeft RightToLeft {