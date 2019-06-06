Index: ColumnClickEventHandler.cs
===================================================================
--- ColumnClickEventHandler.cs	(revision 62112)
+++ ColumnClickEventHandler.cs	(working copy)
@@ -29,6 +29,8 @@
 
 namespace System.Windows.Forms
 {
+#if !NET_2_0
 	[Serializable]
+#endif
 	public delegate void ColumnClickEventHandler (object sender, ColumnClickEventArgs e);
 }
Index: DrawItemEventHandler.cs
===================================================================
--- DrawItemEventHandler.cs	(revision 62112)
+++ DrawItemEventHandler.cs	(working copy)
@@ -27,6 +27,8 @@
 
 namespace System.Windows.Forms
 {
+#if !NET_2_0
 	[Serializable]
+#endif
 	public delegate void DrawItemEventHandler (object sender, DrawItemEventArgs e);
 }
Index: ItemChangedEventHandler.cs
===================================================================
--- ItemChangedEventHandler.cs	(revision 62112)
+++ ItemChangedEventHandler.cs	(working copy)
@@ -29,6 +29,8 @@
 
 namespace System.Windows.Forms
 {
+#if !NET_2_0
 	[Serializable]
+#endif
 	public delegate void ItemChangedEventHandler (object sender, ItemChangedEventArgs e);
 }
Index: ItemCheckEventHandler.cs
===================================================================
--- ItemCheckEventHandler.cs	(revision 62112)
+++ ItemCheckEventHandler.cs	(working copy)
@@ -29,6 +29,8 @@
 
 namespace System.Windows.Forms
 {
+#if !NET_2_0
 	[Serializable]
+#endif
 	public delegate void ItemCheckEventHandler (object sender, ItemCheckEventArgs e);
 }
Index: ItemDragEventHandler.cs
===================================================================
--- ItemDragEventHandler.cs	(revision 62112)
+++ ItemDragEventHandler.cs	(working copy)
@@ -29,6 +29,8 @@
 
 namespace System.Windows.Forms
 {
+#if !NET_2_0
 	[Serializable]
+#endif
 	public delegate void ItemDragEventHandler (object sender, ItemDragEventArgs e);
 }
Index: LabelEditEventHandler.cs
===================================================================
--- LabelEditEventHandler.cs	(revision 62112)
+++ LabelEditEventHandler.cs	(working copy)
@@ -30,6 +30,8 @@
 
 namespace System.Windows.Forms
 {
+#if !NET_2_0
 	[Serializable]
+#endif
 	public delegate void LabelEditEventHandler (object sender, LabelEditEventArgs e);
 }
Index: LinkClickedEventHandler.cs
===================================================================
--- LinkClickedEventHandler.cs	(revision 62112)
+++ LinkClickedEventHandler.cs	(working copy)
@@ -26,7 +26,9 @@
 
 namespace System.Windows.Forms  
 {
+#if !NET_2_0
 	[Serializable]
+#endif
 	public delegate void LinkClickedEventHandler (object sender, LinkClickedEventArgs e);
 }
 
Index: LinkLabelLinkClickedEventHandler.cs
===================================================================
--- LinkLabelLinkClickedEventHandler.cs	(revision 62112)
+++ LinkLabelLinkClickedEventHandler.cs	(working copy)
@@ -33,7 +33,9 @@
 
 namespace System.Windows.Forms 
 {
+#if !NET_2_0
 	[Serializable]
+#endif
 	public delegate void LinkLabelLinkClickedEventHandler (object sender, LinkLabelLinkClickedEventArgs e);
 	
 }
Index: MeasureItemEventHandler.cs
===================================================================
--- MeasureItemEventHandler.cs	(revision 62112)
+++ MeasureItemEventHandler.cs	(working copy)
@@ -26,6 +26,8 @@
 
 namespace System.Windows.Forms
 {
+#if !NET_2_0
 	[Serializable]
+#endif
 	public delegate void MeasureItemEventHandler (object sender, MeasureItemEventArgs e);
 }
\ No newline at end of file
Index: MethodInvoker.cs
===================================================================
--- MethodInvoker.cs	(revision 62112)
+++ MethodInvoker.cs	(working copy)
@@ -27,6 +27,8 @@
 // COMPLETE
 
 namespace System.Windows.Forms {
+#if !NET_2_0
 	[Serializable]
+#endif
 	public delegate void MethodInvoker();
 }
Index: PaintEventHandler.cs
===================================================================
--- PaintEventHandler.cs	(revision 62112)
+++ PaintEventHandler.cs	(working copy)
@@ -29,6 +29,8 @@
 
 namespace System.Windows.Forms 
 {
+#if !NET_2_0
 	[Serializable]
+#endif
 	public delegate void PaintEventHandler (object sender, PaintEventArgs e);
 }
Index: PropertyTabChangedEventHandler.cs
===================================================================
--- PropertyTabChangedEventHandler.cs	(revision 62112)
+++ PropertyTabChangedEventHandler.cs	(working copy)
@@ -27,7 +27,9 @@
 
 namespace System.Windows.Forms 
 {
+#if !NET_2_0
 	[Serializable]
+#endif
 	public delegate void PropertyTabChangedEventHandler(object s, PropertyTabChangedEventArgs e);
 }
 
Index: PropertyValueChangedEventHandler.cs
===================================================================
--- PropertyValueChangedEventHandler.cs	(revision 62112)
+++ PropertyValueChangedEventHandler.cs	(working copy)
@@ -27,6 +27,8 @@
 
 namespace System.Windows.Forms 
 {
+#if !NET_2_0
 	[Serializable]
+#endif
 	public delegate void PropertyValueChangedEventHandler(object s, PropertyValueChangedEventArgs e);
 }
Index: SelectedGridItemChangedEventHandler.cs
===================================================================
--- SelectedGridItemChangedEventHandler.cs	(revision 62112)
+++ SelectedGridItemChangedEventHandler.cs	(working copy)
@@ -27,6 +27,8 @@
 
 namespace System.Windows.Forms 
 {
+#if !NET_2_0
 	[Serializable]
+#endif
 	public delegate void SelectedGridItemChangedEventHandler(object sender, SelectedGridItemChangedEventArgs e);
 }
Index: ToolBarButtonClickEventHandler.cs
===================================================================
--- ToolBarButtonClickEventHandler.cs	(revision 62112)
+++ ToolBarButtonClickEventHandler.cs	(working copy)
@@ -31,6 +31,8 @@
 // COMPLETE
 
 namespace System.Windows.Forms {
+#if !NET_2_0
 	[Serializable]
+#endif
 	public delegate void ToolBarButtonClickEventHandler (object sender, ToolBarButtonClickEventArgs e);
 }
