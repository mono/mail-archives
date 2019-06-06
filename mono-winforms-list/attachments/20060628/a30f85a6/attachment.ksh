Index: AccessibleRole.cs
===================================================================
--- AccessibleRole.cs	(revision 62112)
+++ AccessibleRole.cs	(working copy)
@@ -90,6 +90,12 @@
 		WhiteSpace	= 59,
 		PageTabList	= 60,
 		Clock		= 61,
-		Default		= -1
+		Default		= -1,
+#if NET_2_0
+		SplitButton	= 62,
+		IpAddress	= 63,
+		OutlineButton	= 64
+#endif
+
 	}
 }
Index: AccessibleStates.cs
===================================================================
--- AccessibleStates.cs	(revision 62112)
+++ AccessibleStates.cs	(working copy)
@@ -62,6 +62,12 @@
 		AlertMedium	= 0x08000000,
 		AlertHigh	= 0x10000000,
 		Protected	= 0x20000000,
-		Valid		= 0x3FFFFFFF
+#if NET_2_0
+		[Obsolete]
+#endif
+		Valid		= 0x3FFFFFFF,
+#if NET_2_0
+		HasPopup	= 0x40000000
+#endif
 	}
 }
Index: AnchorStyles.cs
===================================================================
--- AnchorStyles.cs	(revision 62112)
+++ AnchorStyles.cs	(working copy)
@@ -30,7 +30,9 @@
 
 namespace System.Windows.Forms {
 	[Flags]
+#if !NET_2_0
 	[Serializable]
+#endif
 	[Editor("System.Windows.Forms.Design.AnchorEditor, " + Consts.AssemblySystem_Design, typeof(System.Drawing.Design.UITypeEditor))]
 	public enum AnchorStyles {
 		None	= 0x00000000,
Index: ArrangeDirection.cs
===================================================================
--- ArrangeDirection.cs	(revision 62112)
+++ ArrangeDirection.cs	(working copy)
@@ -29,6 +29,9 @@
 using System.Runtime.InteropServices;
 
 namespace System.Windows.Forms {
+#if NET_2_0
+	[Flags]
+#endif
 	[ComVisible(true)]
 	public enum ArrangeDirection {
 		Left		= 0,
Index: ArrangeStartingPosition.cs
===================================================================
--- ArrangeStartingPosition.cs	(revision 62112)
+++ ArrangeStartingPosition.cs	(working copy)
@@ -27,6 +27,9 @@
 // COMPLETE
 
 namespace System.Windows.Forms {
+#if NET_2_0
+	[Flags]
+#endif
 	public enum ArrangeStartingPosition {
 		BottomLeft	= 0,
 		BottomRight	= 1,
Index: ColorDepth.cs
===================================================================
--- ColorDepth.cs	(revision 62112)
+++ ColorDepth.cs	(working copy)
@@ -27,7 +27,9 @@
 // COMPLETE
 
 namespace System.Windows.Forms {
+#if !NET_2_0
 	[Serializable]
+#endif
 	public enum ColorDepth {
 		Depth4Bit	= 4,
 		Depth8Bit	= 8,
Index: ControlStyles.cs
===================================================================
--- ControlStyles.cs	(revision 62112)
+++ ControlStyles.cs	(working copy)
@@ -45,6 +45,10 @@
 		AllPaintingInWmPaint	= 0x00002000,
 		CacheText		= 0x00004000,
 		EnableNotifyMessage	= 0x00008000,
-		DoubleBuffer		= 0x00010000
+		DoubleBuffer		= 0x00010000,
+#if NET_2_0
+		OptimizedDoubleBuffer	= 0x00020000,
+		UseTextForAccessibility	= 0x00040000
+#endif
 	}
 }
Index: DataGridViewImageCellLayout.cs
===================================================================
--- DataGridViewImageCellLayout.cs	(revision 62112)
+++ DataGridViewImageCellLayout.cs	(working copy)
@@ -29,10 +29,10 @@
 namespace System.Windows.Forms {
 
 	public enum DataGridViewImageCellLayout {
-		Normal,
-		NotSet,
-		Stretch,
-		Zoom
+		NotSet = 0,
+		Normal = 1,
+		Stretch = 2,
+		Zoom = 3
 	}
 
 }
Index: DrawMode.cs
===================================================================
--- DrawMode.cs	(revision 62112)
+++ DrawMode.cs	(working copy)
@@ -26,7 +26,9 @@
 
 namespace System.Windows.Forms 
 {
+#if !NET_2_0
 	[Serializable]
+#endif
 	public enum DrawMode 
 	{
 		Normal = 0,
Index: FormBorderStyle.cs
===================================================================
--- FormBorderStyle.cs	(revision 62112)
+++ FormBorderStyle.cs	(working copy)
@@ -29,7 +29,9 @@
 namespace System.Windows.Forms
 {
 	[ComVisible (true)]
+#if !NET_2_0
 	[Serializable]
+#endif
 	public enum FormBorderStyle
 	{
 		None = 0,
Index: FormStartPosition.cs
===================================================================
--- FormStartPosition.cs	(revision 62112)
+++ FormStartPosition.cs	(working copy)
@@ -28,7 +28,9 @@
 namespace System.Windows.Forms
 {
 	[ComVisible (true)]
+#if !NET_2_0
 	[Serializable]
+#endif
 	public enum FormStartPosition
 	{
 		Manual = 0,
Index: FormWindowState.cs
===================================================================
--- FormWindowState.cs	(revision 62112)
+++ FormWindowState.cs	(working copy)
@@ -29,7 +29,9 @@
 namespace System.Windows.Forms
 {
 	[ComVisible (true)]
+#if !NET_2_0
 	[Serializable]
+#endif
 	public enum FormWindowState
 	{
 		Normal = 0,
Index: GridItemType.cs
===================================================================
--- GridItemType.cs	(revision 62112)
+++ GridItemType.cs	(working copy)
@@ -27,7 +27,9 @@
 
 namespace System.Windows.Forms 
 {
+#if !NET_2_0
 	[Serializable]
+#endif
 	public enum GridItemType 
 	{
 		Property	= 0,
Index: HelpNavigator.cs
===================================================================
--- HelpNavigator.cs	(revision 62112)
+++ HelpNavigator.cs	(working copy)
@@ -33,6 +33,9 @@
 		Index		= -2147483645,
 		Find		= -2147483644,
 		AssociateIndex	= -2147483643,
-		KeywordIndex	= -2147483642
+		KeywordIndex	= -2147483642,
+#if NET_2_0
+		TopicID		= -2147483641
+#endif
 	}
 }
Index: ImeMode.cs
===================================================================
--- ImeMode.cs	(revision 62112)
+++ ImeMode.cs	(working copy)
@@ -42,6 +42,9 @@
 		Alpha		= 8,
 		HangulFull	= 9,
 		Hangul		= 10,
-		Inherit		= -1
+		Inherit		= -1,
+#if NET_2_0
+		Close		= 11
+#endif
 	}
 }
Index: ItemActivation.cs
===================================================================
--- ItemActivation.cs	(revision 62112)
+++ ItemActivation.cs	(working copy)
@@ -30,7 +30,9 @@
 
 namespace System.Windows.Forms
 {
+#if !NET_2_0
 	[Serializable]
+#endif
 	public enum ItemActivation
 	{
 		OneClick  = 1,
Index: ItemBoundsPortion.cs
===================================================================
--- ItemBoundsPortion.cs	(revision 62112)
+++ ItemBoundsPortion.cs	(working copy)
@@ -26,7 +26,9 @@
 
 namespace System.Windows.Forms
 {
+#if !NET_2_0
 	[Serializable]
+#endif
 	public enum ItemBoundsPortion
 	{
 		Entire = 0,
Index: Keys.cs
===================================================================
--- Keys.cs	(revision 62112)
+++ Keys.cs	(working copy)
@@ -216,6 +216,19 @@
 		Shift		= 0x00010000,
 		Control		= 0x00020000,
 		Alt		= 0x00040000,
-		Modifiers	= unchecked((int)0xFFFF0000)
+		Modifiers	= unchecked((int)0xFFFF0000),
+#if NET_2_0
+		IMEAccept	= 0x0000001E,
+		Oem1		= 0x000000BA,
+		Oem102		= 0x000000E2,
+		Oem2		= 0x000000BF,
+		Oem3		= 0x000000C0,
+		Oem4		= 0x000000DB,
+		Oem5		= 0x000000DC,
+		Oem6		= 0x000000DD,
+		Oem7		= 0x000000DE,
+		Packet		= 0x000000E7,
+		Sleep		= 0x0000005F
+#endif
 	}
 }
Index: ListViewAlignment.cs
===================================================================
--- ListViewAlignment.cs	(revision 62112)
+++ ListViewAlignment.cs	(working copy)
@@ -26,7 +26,9 @@
 
 namespace System.Windows.Forms
 {
+#if !NET_2_0
 	[Serializable]
+#endif
 	public enum ListViewAlignment
 	{
 		Default = 0,
Index: PictureBoxSizeMode.cs
===================================================================
--- PictureBoxSizeMode.cs	(revision 62112)
+++ PictureBoxSizeMode.cs	(working copy)
@@ -27,10 +27,13 @@
 namespace System.Windows.Forms {
 
 	public enum PictureBoxSizeMode {
-		Normal,
-		StretchImage,
-		AutoSize,
-		CenterImage
+		Normal = 0,
+		StretchImage = 1,
+		AutoSize = 2,
+		CenterImage = 3,
+#if NET_2_0
+		Zoom = 4
+#endif
 	}
 }
 
Index: PropertySort.cs
===================================================================
--- PropertySort.cs	(revision 62112)
+++ PropertySort.cs	(working copy)
@@ -29,7 +29,9 @@
 
 namespace System.Windows.Forms
 {
+#if !NET_2_0
 	[Serializable]
+#endif
 	[ComVisible(true)]
 	public enum PropertySort
 	{
Index: SelectionMode.cs
===================================================================
--- SelectionMode.cs	(revision 62112)
+++ SelectionMode.cs	(working copy)
@@ -29,7 +29,9 @@
 
 namespace System.Windows.Forms 
 {
+#if !NET_2_0
 	[Serializable]
+#endif
 	[ComVisible(true)]
 	public enum SelectionMode
 	{
Index: Shortcut.cs
===================================================================
--- Shortcut.cs	(revision 62112)
+++ Shortcut.cs	(working copy)
@@ -42,6 +42,9 @@
 		Alt8		= 0x040038,
 		Alt9		= 0x040039,
 		AltBksp		= 0x040008,
+#if NET_2_0
+		AltDownArrow	= 0x040028,
+#endif
 		AltF1		= 0x040070,
 		AltF10		= 0x040079,
 		AltF11		= 0x04007A,
@@ -54,6 +57,11 @@
 		AltF7		= 0x040076,
 		AltF8		= 0x040077,
 		AltF9		= 0x040078,
+#if NET_2_0
+		AltLeftArrow	= 0x040025,
+		AltRightArrow	= 0x040027,
+		AltUpArrow	= 0x040026,
+#endif
 		Ctrl0		= 0x020030,
 		Ctrl1		= 0x020031,
 		Ctrl2		= 0x020032,
Index: SizeGripStyle.cs
===================================================================
--- SizeGripStyle.cs	(revision 62112)
+++ SizeGripStyle.cs	(working copy)
@@ -28,7 +28,9 @@
 
 namespace System.Windows.Forms
 {
+#if !NET_2_0
 	[Serializable]
+#endif
 	public enum SizeGripStyle
 	{
 		Auto = 0,
Index: SortOrder.cs
===================================================================
--- SortOrder.cs	(revision 62112)
+++ SortOrder.cs	(working copy)
@@ -28,7 +28,9 @@
 
 namespace System.Windows.Forms
 {
+#if !NET_2_0
 	[Serializable]
+#endif
 	public enum SortOrder
 	{
 		None = 0,
Index: StructFormat.cs
===================================================================
--- StructFormat.cs	(revision 62112)
+++ StructFormat.cs	(working copy)
@@ -27,7 +27,9 @@
 
 namespace System.Windows.Forms
 {
+#if !NET_2_0
 	[Serializable]
+#endif
 	public enum StructFormat
 	{
 		Ansi = 1,
Index: TextFormatFlags.cs
===================================================================
--- TextFormatFlags.cs	(revision 62112)
+++ TextFormatFlags.cs	(working copy)
@@ -41,7 +41,6 @@
 		WordBreak = 16,
 		SingleLine = 32,
 		ExpandTabs = 64,
-		TabStop = 128,
 		NoClipping = 256,
 		ExternalLeading = 512,
 		NoPrefix = 2048,
Index: ToolBarAppearance.cs
===================================================================
--- ToolBarAppearance.cs	(revision 62112)
+++ ToolBarAppearance.cs	(working copy)
@@ -32,7 +32,9 @@
 
 namespace System.Windows.Forms
 {
+#if !NET_2_0
 	[Serializable]
+#endif
 	public enum ToolBarAppearance
 	{
 		Normal = 0,
Index: ToolBarButtonStyle.cs
===================================================================
--- ToolBarButtonStyle.cs	(revision 62112)
+++ ToolBarButtonStyle.cs	(working copy)
@@ -31,7 +31,9 @@
 
 namespace System.Windows.Forms
 {
+#if !NET_2_0
 	[Serializable]
+#endif
 	public enum ToolBarButtonStyle
 	{
 		PushButton = 1,
Index: ToolBarTextAlign.cs
===================================================================
--- ToolBarTextAlign.cs	(revision 62112)
+++ ToolBarTextAlign.cs	(working copy)
@@ -31,7 +31,9 @@
 
 namespace System.Windows.Forms
 {
+#if !NET_2_0
 	[Serializable]
+#endif
 	public enum ToolBarTextAlign
 	{
 		Underneath = 0,
Index: View.cs
===================================================================
--- View.cs	(revision 62112)
+++ View.cs	(working copy)
@@ -26,12 +26,17 @@
 
 namespace System.Windows.Forms
 {
+#if !NET_2_0
 	[Serializable]
+#endif
 	public enum View
 	{
 		LargeIcon = 0,
 		Details = 1,
 		SmallIcon = 2,
-		List = 3
+		List = 3,
+#if NET_2_0
+		Tile = 4
+#endif
 	}
 }
