Index: System.Windows.Forms.dll.sources
===================================================================
--- System.Windows.Forms.dll.sources	(revision 73495)
+++ System.Windows.Forms.dll.sources	(working copy)
@@ -613,6 +613,8 @@
 System.Windows.Forms/Theme.cs
 System.Windows.Forms/ThemeClearlooks.cs
 System.Windows.Forms/ThemeEngine.cs
+System.Windows.Forms/ThemeElements.cs
+System.Windows.Forms/ThemeElementsDefault.cs
 System.Windows.Forms/ThemeGtk.cs
 System.Windows.Forms/ThemeNice.cs
 System.Windows.Forms/ThemeWin32Classic.cs
Index: System.Windows.Forms/Button.cs
===================================================================
--- System.Windows.Forms/Button.cs	(revision 73495)
+++ System.Windows.Forms/Button.cs	(working copy)
@@ -54,6 +54,34 @@
 			if (eh != null)
 				eh (this, EventArgs.Empty);
 		}
+		
+#if NET_2_0
+		internal override void Draw (PaintEventArgs pevent)
+		{
+			// System style does not use any of the new 2.0 stuff
+			if (this.FlatStyle == FlatStyle.System) {
+				base.Draw (pevent);
+				return;
+			}
+
+			// FIXME: This should be called every time something that can affect it
+			// is changed, not every paint.  Can only change so many things at a time.
+
+			// Figure out where our text and image should go
+			Rectangle text_rectangle;
+			Rectangle image_rectangle;
+
+			ThemeEngine.Current.CalculateButtonTextAndImageLayout (this, out text_rectangle, out image_rectangle);
+
+			// Draw our button
+			if (this.FlatStyle == FlatStyle.Standard)
+				ThemeEngine.Current.DrawButton (pevent.Graphics, this, text_rectangle, image_rectangle, pevent.ClipRectangle);
+			else if (this.FlatStyle == FlatStyle.Flat)
+				ThemeEngine.Current.DrawFlatButton (pevent.Graphics, this, text_rectangle, image_rectangle, pevent.ClipRectangle);
+			else if (this.FlatStyle == FlatStyle.Popup)
+				ThemeEngine.Current.DrawPopupButton (pevent.Graphics, this, text_rectangle, image_rectangle, pevent.ClipRectangle);
+		}
+#endif
 		#endregion	// Internal methods
 
 		#region Public Instance Properties
@@ -108,7 +136,7 @@
 		}
 
 		protected override bool ProcessMnemonic(char charCode) {
-			if (IsMnemonic(charCode, Text) == true) {
+			if (this.UseMnemonic && IsMnemonic(charCode, Text) == true) {
 				PerformClick();
 				return true;
 			}
Index: System.Windows.Forms/ButtonBase.cs
===================================================================
--- System.Windows.Forms/ButtonBase.cs	(revision 73495)
+++ System.Windows.Forms/ButtonBase.cs	(working copy)
@@ -39,21 +39,26 @@
 	public abstract class ButtonBase : Control
 	{
 		#region Local Variables
-		FlatStyle flat_style;
-		internal int			image_index;
+		private FlatStyle		flat_style;
+		private int			image_index;
 		internal Image			image;
 		internal ImageList		image_list;
-		internal ContentAlignment	image_alignment;
+		private ContentAlignment	image_alignment;
 		internal ContentAlignment	text_alignment;
 		private bool			is_default;
 		internal bool			is_pressed;
-		internal bool			enter_state;
+		private bool			enter_state;
 		internal StringFormat		text_format;
 		internal bool 			paint_as_acceptbutton;
-#if NET_2_0
+		
+		// Properties are 2.0, but variables used in 1.1 for common drawing code
+		private bool			auto_ellipsis;
+		private FlatButtonAppearance	flat_button_appearance;
+		private string			image_key;
+		private TextImageRelation	text_image_relation;
+		private TextFormatFlags		text_format_flags;
+		private bool			use_mnemonic;
 		private bool			use_visual_style_back_color;
-		private FlatButtonAppearance flat_button_appearance;
-#endif
 		#endregion	// Local Variables
 
 		#region ButtonBaseAccessibleObject sub-class
@@ -139,6 +144,9 @@
 			flat_style	= FlatStyle.Standard;
 #if NET_2_0
 			flat_button_appearance = new FlatButtonAppearance (this);
+			this.image_key = string.Empty;
+			this.text_image_relation = TextImageRelation.Overlay;
+			this.use_mnemonic = true;
 #endif
 			image_index	= -1;
 			image		= null;
@@ -153,6 +161,10 @@
 			text_format.LineAlignment = StringAlignment.Center;
 			text_format.HotkeyPrefix = HotkeyPrefix.Show;
 
+			text_format_flags = TextFormatFlags.HorizontalCenter;
+			text_format_flags |= TextFormatFlags.VerticalCenter;
+			text_format_flags |= TextFormatFlags.WordBreak;
+		
 			TextChanged+=new System.EventHandler(RedrawEvent);
 			SizeChanged+=new EventHandler(RedrawEvent);
 
@@ -184,25 +196,45 @@
 				Invalidate();
 			}
 		}
-#if NET_2_0
-		[MonoTODO("FlatAppearance is currently ignored on drawing.")]
+
 		[DesignerSerializationVisibility(DesignerSerializationVisibility.Content)]
 		[Browsable(true)]
-		public FlatButtonAppearance FlatAppearance
+#if NET_2_0
+		public 
+#else
+		internal
+#endif
+		FlatButtonAppearance FlatAppearance
 		{
 			get { return flat_button_appearance; }
 		}
-#endif		
+
 		[Localizable(true)]
 		[MWFDescription("Sets image to be displayed on button face"), MWFCategory("Appearance")]
 		public Image Image {
 			get {
-				return image;
+				if (this.image != null)
+					return this.image;
+
+				if (this.image_index >= 0)
+					if (this.image_list != null)
+						return this.image_list.Images[this.image_index];
+
+#if NET_2_0
+				if (!string.IsNullOrEmpty (this.image_key))
+					if (this.image_list != null)
+						return this.image_list.Images[this.image_key];
+#endif
+				return null;
 			}
-
 			set {
-				image = value;
-				Invalidate();
+				if (this.image != value) {
+					this.image = value;
+					this.image_index = -1;
+					this.image_key = string.Empty;
+					this.image_list = null;
+					Invalidate();
+				}
 			}
 		}
 
@@ -237,8 +269,12 @@
 			}
 
 			set {
-				image_index=value;
-				Invalidate();
+				if (this.image_index != value) {
+					this.image_index = value;
+					this.image = null;
+					this.image_key = string.Empty;
+					Invalidate();
+				}
 			}
 		}
 
@@ -281,6 +317,14 @@
 			set {
 				if (text_alignment != value) {
 					text_alignment = value;
+
+					text_format_flags &= ~TextFormatFlags.Bottom;
+					text_format_flags &= ~TextFormatFlags.Top;
+					text_format_flags &= ~TextFormatFlags.Left;
+					text_format_flags &= ~TextFormatFlags.Right;
+					text_format_flags &= ~TextFormatFlags.HorizontalCenter;
+					text_format_flags &= ~TextFormatFlags.VerticalCenter;
+					
 					switch(text_alignment) {
 					case ContentAlignment.TopLeft:
 						text_format.Alignment=StringAlignment.Near;
@@ -290,41 +334,49 @@
 					case ContentAlignment.TopCenter:
 						text_format.Alignment=StringAlignment.Center;
 						text_format.LineAlignment=StringAlignment.Near;
+						text_format_flags |= TextFormatFlags.HorizontalCenter;
 						break;
 
 					case ContentAlignment.TopRight:
 						text_format.Alignment=StringAlignment.Far;
 						text_format.LineAlignment=StringAlignment.Near;
+						text_format_flags |= TextFormatFlags.Right;
 						break;
 
 					case ContentAlignment.MiddleLeft:
 						text_format.Alignment=StringAlignment.Near;
 						text_format.LineAlignment=StringAlignment.Center;
+						text_format_flags |= TextFormatFlags.VerticalCenter;
 						break;
 
 					case ContentAlignment.MiddleCenter:
 						text_format.Alignment=StringAlignment.Center;
 						text_format.LineAlignment=StringAlignment.Center;
+						text_format_flags |= TextFormatFlags.VerticalCenter | TextFormatFlags.HorizontalCenter;
 						break;
 
 					case ContentAlignment.MiddleRight:
 						text_format.Alignment=StringAlignment.Far;
 						text_format.LineAlignment=StringAlignment.Center;
+						text_format_flags |= TextFormatFlags.VerticalCenter | TextFormatFlags.Right;
 						break;
 
 					case ContentAlignment.BottomLeft:
 						text_format.Alignment=StringAlignment.Near;
 						text_format.LineAlignment=StringAlignment.Far;
+						text_format_flags |= TextFormatFlags.Bottom;
 						break;
 
 					case ContentAlignment.BottomCenter:
 						text_format.Alignment=StringAlignment.Center;
 						text_format.LineAlignment=StringAlignment.Far;
+						text_format_flags |= TextFormatFlags.HorizontalCenter | TextFormatFlags.Bottom;
 						break;
 
 					case ContentAlignment.BottomRight:
 						text_format.Alignment=StringAlignment.Far;
 						text_format.LineAlignment=StringAlignment.Far;
+						text_format_flags |= TextFormatFlags.Bottom | TextFormatFlags.Right;
 						break;
 					}
 					Invalidate();
@@ -531,7 +583,17 @@
 		}
 		#endregion	// Public Instance Properties
 
-
+		#region Internal Instance Properties
+		internal bool Pressed {
+			get { return this.is_pressed; }
+		}
+		
+		// The flags to be used for MeasureText and DrawText
+		internal TextFormatFlags TextFormatFlags {
+			get { return this.text_format_flags; }
+		}
+		#endregion
+		
 		#region Internal Methods
 		private void PerformClick() {
 			OnClick(EventArgs.Empty);
@@ -539,6 +601,13 @@
 		#endregion	// Internal Methods
 
 		#region	Events
+#if NET_2_0
+		public new event EventHandler AutoSizeChanged {
+			add { base.AutoSizeChanged += value; }
+			remove { base.AutoSizeChanged -= value; }
+		}
+#endif
+
 		[Browsable(false)]
 		[EditorBrowsable (EditorBrowsableState.Never)]
 		public new event EventHandler ImeModeChanged {
@@ -549,23 +618,120 @@
 
 
 		#region .NET 2.0 Public Instance Properties
+		[DefaultValue (false)]
 #if NET_2_0
-		public bool UseVisualStyleBackColor {
-			get { return use_visual_style_back_color; }
-			set { use_visual_style_back_color = value; }
+		public 
+#else
+		internal
+#endif
+		bool AutoEllipsis {
+			get { return this.auto_ellipsis; }
+			set {
+				if (this.auto_ellipsis != value) {
+					this.auto_ellipsis = value;
+					
+					if (this.auto_ellipsis) {
+						text_format_flags |= TextFormatFlags.EndEllipsis;
+						text_format_flags &= ~TextFormatFlags.WordBreak;
+					}
+					else {
+						text_format_flags &= ~TextFormatFlags.EndEllipsis;
+						text_format_flags |= TextFormatFlags.WordBreak;
+					}
+						
+					this.Invalidate ();
+				}
+			}
 		}
 
-		[DefaultValue (false)]
-		public bool UseCompatibleTextRendering {
-			get {
-				return use_compatible_text_rendering;
+#if NET_2_0
+		[DefaultValue (true)]
+		public override bool AutoSize {
+			get { return base.AutoSize; }
+			set { base.AutoSize = value; }
+		}
+
+		public override Color BackColor {
+			get { return base.BackColor; }
+			set { base.BackColor = value; }
+		}
+		
+		[Localizable (true)]
+		public string ImageKey {
+			get { return this.image_key; }
+			set {
+				if (this.image_key != value) {
+					this.image = null;
+					this.image_index = -1;
+					this.image_key = value;
+					this.Invalidate ();
+				}
 			}
+		}
+		
+		[Localizable (true)]
+		[DefaultValue (TextImageRelation.Overlay)]
+		public 
+#else
+		internal
+#endif
+		TextImageRelation TextImageRelation {
+			get { return this.text_image_relation; }
+			set {
+				if (!Enum.IsDefined (typeof (TextImageRelation), value))
+					throw new InvalidEnumArgumentException (string.Format ("Enum argument value '{0}' is not valid for TextImageRelation", value));
 
+				if (this.text_image_relation != value) {
+					this.text_image_relation = value;
+					this.Invalidate ();
+				}
+			}
+		}
+		
+		[DefaultValue (true)]
+#if NET_2_0
+		public 
+#else
+		internal
+#endif
+		bool UseMnemonic {
+			get { return this.use_mnemonic; }
 			set {
-				use_compatible_text_rendering = value;
+				if (this.use_mnemonic != value) {
+					this.use_mnemonic = value;
+
+					if (this.use_mnemonic)
+						text_format_flags &= ~TextFormatFlags.NoPrefix;
+					else
+						text_format_flags |= TextFormatFlags.NoPrefix;
+					
+					this.Invalidate ();
+				}
 			}
 		}
 
+#if NET_2_0
+		public 
+#else
+		internal
+#endif
+		bool UseVisualStyleBackColor {
+			get { return use_visual_style_back_color; }
+			set { use_visual_style_back_color = value; }
+		}
+
+		[DefaultValue (false)]
+#if NET_2_0
+		public 
+#else
+		internal
+#endif
+		bool UseCompatibleTextRendering {
+			get { return use_compatible_text_rendering; }
+			set { use_compatible_text_rendering = value; }
+		}
+
+#if NET_2_0
 		[SettingsBindable (true)]
 		[Editor ("System.ComponentModel.Design.MultilineStringEditor, " + Consts.AssemblySystem_Design,
 			 "System.Drawing.Design.UITypeEditor, " + Consts.AssemblySystem_Drawing)]
Index: System.Windows.Forms/ChangeLog
===================================================================
--- System.Windows.Forms/ChangeLog	(revision 73495)
+++ System.Windows.Forms/ChangeLog	(working copy)
@@ -1,3 +1,18 @@
+2007-02-27  Jonathan Pobst  <monkey@jpobst.com>
+
+	* ButtonBase.cs: Add 2.0 properties.
+	* Button.cs: Override Draw for 2.0.
+	* Control.cs: Add Entered and Selected properties.
+	* FlatButtonAppearance.cs, TextFormatFlags.cs, TextImageRelation.cs,
+	TextRenderer.cs: Make internal for 1.1 to unify drawing code.
+	* Theme.cs: New abstract functions for drawing Standard, Flat, Popup
+	buttons.
+	* ThemeWin32Classic.cs: Implement layout calculations for 2.0 buttons.
+	* ThemeElements.cs: Driver code to theme class that actually draws 
+	theme elements.
+	* ThemeElementsDefault.cs: Default [win32 style] implementation of 
+	Standard, Flat, Popup buttons.
+
 2007-02-26  Jonathan Pobst  <monkey@jpobst.com>
 
 	* XplatUIStructs.cs: Add some convenience methods for POINT structure.
Index: System.Windows.Forms/Control.cs
===================================================================
--- System.Windows.Forms/Control.cs	(revision 73495)
+++ System.Windows.Forms/Control.cs	(working copy)
@@ -127,6 +127,7 @@
 		BindingContext          binding_context;
 		RightToLeft             right_to_left; // drawing direction for control
 		ContextMenu             context_menu; // Context menu associated with the control
+		internal bool		use_compatible_text_rendering;
 
 		// double buffering
 		DoubleBuffer            backbuffer;
@@ -138,7 +139,6 @@
 		ControlBindingsCollection data_bindings;
 
 #if NET_2_0
-		internal bool use_compatible_text_rendering;
 		static bool verify_thread_handle;
 		Padding padding;
 		ImageLayout backgroundimage_layout;
@@ -936,6 +936,7 @@
 			dist_bottom = 0;
 			tab_stop = true;
 			ime_mode = ImeMode.Inherit;
+			use_compatible_text_rendering = true;
 
 #if NET_2_0
 			backgroundimage_layout = ImageLayout.Tile;
@@ -1036,6 +1037,26 @@
 		#endregion 	// Public Constructors
 
 		#region Internal Properties
+		// Control is currently selected, like Focused, except maintains state
+		// when Form loses focus
+		internal bool Selected {
+		        get {
+		        	IContainerControl container;
+			
+				container = GetContainerControl();
+				
+				if (container != null && container.ActiveControl == this)
+					return true;
+					
+				return false;
+			}
+		}
+		
+		// Mouse is currently within the control's bounds
+		internal bool Entered {
+			get { return this.is_entered; }
+		}
+
 		internal bool VisibleInternal {
 			get { return is_visible; }
 		}
Index: System.Windows.Forms/FlatButtonAppearance.cs
===================================================================
--- System.Windows.Forms/FlatButtonAppearance.cs	(revision 73495)
+++ System.Windows.Forms/FlatButtonAppearance.cs	(working copy)
@@ -25,7 +25,6 @@
 // Author:
 //      Daniel Nauck    (dna(at)mono-project(dot)de)
 
-#if NET_2_0
 
 using System;
 using System.ComponentModel;
@@ -34,7 +33,10 @@
 
 namespace System.Windows.Forms
 {
-	public class FlatButtonAppearance
+#if NET_2_0
+	public 
+#endif
+	class FlatButtonAppearance
 	{
 		private Color borderColor = Color.Empty;
 		private int borderSize = 1;
@@ -141,5 +143,4 @@
 			}
 		}
 	}
-}
-#endif
\ No newline at end of file
+}
\ No newline at end of file
Index: System.Windows.Forms/TextFormatFlags.cs
===================================================================
--- System.Windows.Forms/TextFormatFlags.cs	(revision 73495)
+++ System.Windows.Forms/TextFormatFlags.cs	(working copy)
@@ -24,12 +24,14 @@
 //
 
 
-#if NET_2_0
 
 namespace System.Windows.Forms {
 	
 	[FlagsAttribute()]
-	public enum TextFormatFlags {
+#if NET_2_0
+	public 
+#endif
+	enum TextFormatFlags {
 		Left = 0,
 		Top = 0,
 		Default = 0,
@@ -59,7 +61,4 @@
 		NoPadding = 268435456,
 		LeftAndRightPadding = 536870912
 	}
-
-}
-
-#endif
+}
\ No newline at end of file
Index: System.Windows.Forms/TextImageRelation.cs
===================================================================
--- System.Windows.Forms/TextImageRelation.cs	(revision 73495)
+++ System.Windows.Forms/TextImageRelation.cs	(working copy)
@@ -27,10 +27,12 @@
 //
 
 
-#if NET_2_0
 namespace System.Windows.Forms
 {
-	public enum TextImageRelation
+#if NET_2_0
+	public 
+#endif
+	enum TextImageRelation
 	{
 		Overlay = 0,
 		ImageAboveText = 1,
@@ -39,4 +41,3 @@
 		TextBeforeImage = 8
 	}
 }
-#endif
\ No newline at end of file
Index: System.Windows.Forms/TextRenderer.cs
===================================================================
--- System.Windows.Forms/TextRenderer.cs	(revision 73495)
+++ System.Windows.Forms/TextRenderer.cs	(working copy)
@@ -26,16 +26,17 @@
 //	Jonathan Pobst (monkey@jpobst.com)
 //
 
-#if NET_2_0
 using System.Drawing;
 using System.Runtime.InteropServices;
 using System.Text;
 using System.Drawing.Text;
-using System.Windows.Forms.VisualStyles;
 
 namespace System.Windows.Forms
 {
-	public sealed class TextRenderer
+#if NET_2_0
+	public sealed 
+#endif
+	class TextRenderer
 	{
 		private static Bitmap measure_bitmap = new Bitmap (1, 1);
 
@@ -44,6 +45,7 @@
 		}
 
 		#region Public Methods
+#if NET_2_0
 		public static void DrawText (IDeviceContext dc, string text, Font font, Point pt, Color foreColor)
 		{
 			DrawTextInternal (dc, text, font, pt, foreColor, Color.Transparent, TextFormatFlags.Default, false);
@@ -113,11 +115,17 @@
 		{
 			return MeasureTextInternal (dc, text, font, proposedSize, flags, false);
 		}
+#endif
 		#endregion
 
 		#region Internal Methods That Do Stuff
+#if NET_2_0
 		internal static void DrawTextInternal (IDeviceContext dc, string text, Font font, Rectangle bounds, Color foreColor, Color backColor, TextFormatFlags flags, bool useDrawString)
+#else
+		internal static void DrawTextInternal (Graphics dc, string text, Font font, Rectangle bounds, Color foreColor, Color backColor, TextFormatFlags flags, bool useDrawString)
+#endif
 		{
+#if NET_2_0
 			if (dc == null)
 				throw new ArgumentNullException ("dc");
 
@@ -187,13 +195,19 @@
 			}
 			// Use Graphics.DrawString as a fallback method
 			else {
+#endif
 				Graphics g;
 
+#if NET_2_0
 				if (dc is Graphics)
 					g = (Graphics)dc;
 				else
 					g = Graphics.FromHdc (dc.GetHdc ());
+#else
+					g = (Graphics)dc;
 
+#endif
+
 				StringFormat sf = FlagsToStringFormat (flags);
 
 				Rectangle new_bounds = PadDrawStringRectangle (bounds, flags);
@@ -201,15 +215,22 @@
 				using (Brush b = new SolidBrush (foreColor))
 					g.DrawString (text, font, b, new_bounds, sf);
 
+#if NET_2_0
 				if (!(dc is Graphics)) {
 					g.Dispose ();
 					dc.ReleaseHdc ();
 				}
 			}
+#endif
 		}
 
+#if NET_2_0
 		internal static Size MeasureTextInternal (IDeviceContext dc, string text, Font font, Size proposedSize, TextFormatFlags flags, bool useMeasureString)
+#else
+		internal static Size MeasureTextInternal (Graphics dc, string text, Font font, Size proposedSize, TextFormatFlags flags, bool useMeasureString)
+#endif
 		{
+#if NET_2_0
 			if (!useMeasureString && (Environment.OSVersion.Platform == PlatformID.Win32NT || Environment.OSVersion.Platform == PlatformID.Win32Windows)) {
 				// Tell DrawText to calculate size instead of draw
 				flags |= (TextFormatFlags)1024;		// DT_CALCRECT
@@ -244,6 +265,7 @@
 				return retval;
 			}
 			else {
+#endif
 				Graphics g = Graphics.FromImage (measure_bitmap);
 
 				Size retval = g.MeasureString (text, font).ToSize ();
@@ -253,10 +275,13 @@
 
 				return retval;
 			}
+#if NET_2_0
 		}
+#endif
 		#endregion
 
 #region Internal Methods That Are Just Overloads
+#if NET_2_0
 		internal static void DrawTextInternal (IDeviceContext dc, string text, Font font, Point pt, Color foreColor, bool useDrawString)
 		{
 			DrawTextInternal (dc, text, font, pt, foreColor, Color.Transparent, TextFormatFlags.Default, useDrawString);
@@ -283,10 +308,14 @@
 		}
 
 		internal static void DrawTextInternal (IDeviceContext dc, string text, Font font, Rectangle bounds, Color foreColor, TextFormatFlags flags, bool useDrawString)
+#else
+		internal static void DrawTextInternal (Graphics dc, string text, Font font, Rectangle bounds, Color foreColor, TextFormatFlags flags, bool useDrawString)
+#endif
 		{
 			DrawTextInternal (dc, text, font, bounds, foreColor, Color.Transparent, flags, useDrawString);
 		}
 
+#if NET_2_0
 		internal static void DrawTextInternal (IDeviceContext dc, string text, Font font, Point pt, Color foreColor, Color backColor, TextFormatFlags flags, bool useDrawString)
 		{
 			Size sz = MeasureTextInternal (dc, text, font, useDrawString);
@@ -313,6 +342,7 @@
 			return MeasureTextInternal (dc, text, font, proposedSize, TextFormatFlags.Default, useMeasureString);
 		}
 
+#endif
 		internal static Size MeasureTextInternal (string text, Font font, Size proposedSize, TextFormatFlags flags, bool useMeasureString)
 		{
 			return MeasureTextInternal (Graphics.FromImage (measure_bitmap), text, font, proposedSize, flags, useMeasureString);
@@ -459,5 +489,4 @@
 		static extern bool SelectClipRgn(IntPtr hdc, IntPtr hrgn);
 #endregion
 	}
-}
-#endif
+}
\ No newline at end of file
Index: System.Windows.Forms/Theme.cs
===================================================================
--- System.Windows.Forms/Theme.cs	(revision 73495)
+++ System.Windows.Forms/Theme.cs	(working copy)
@@ -692,6 +692,10 @@
 		#endregion	// OwnerDraw Support
 
 		#region Button
+		public abstract void CalculateButtonTextAndImageLayout (Button b, out Rectangle textRectangle, out Rectangle imageRectangle);
+		public abstract void DrawButton (Graphics g, Button b, Rectangle textBounds, Rectangle imageBounds, Rectangle clipRectangle);
+		public abstract void DrawFlatButton (Graphics g, Button b, Rectangle textBounds, Rectangle imageBounds, Rectangle clipRectangle);
+		public abstract void DrawPopupButton (Graphics g, Button b, Rectangle textBounds, Rectangle imageBounds, Rectangle clipRectangle);
 		#endregion	// Button
 
 		#region ButtonBase
Index: System.Windows.Forms/ThemeElements.cs
===================================================================
--- System.Windows.Forms/ThemeElements.cs	(revision 0)
+++ System.Windows.Forms/ThemeElements.cs	(revision 0)
@@ -0,0 +1,51 @@
+using System;
+using System.Drawing;
+
+namespace System.Windows.Forms
+{
+	internal class ThemeElements
+	{
+		private static ThemeElementsDefault theme;
+
+		static ThemeElements ()
+		{
+			string theme_var;
+
+			theme_var = Environment.GetEnvironmentVariable ("MONO_THEME");
+
+			if (theme_var == null)
+				theme_var = "win32";
+			else
+				theme_var = theme_var.ToLower ();
+
+			theme = new ThemeElementsDefault ();
+		}
+		
+		public static void DrawButton (Graphics g, Rectangle bounds, ButtonThemeState state, Color backColor, Color foreColor)
+		{
+			theme.DrawButton (g, bounds, state, backColor, foreColor);
+		}
+
+		public static void DrawFlatButton (Graphics g, Rectangle bounds, ButtonThemeState state, Color backColor, Color foreColor, FlatButtonAppearance appearance)
+		{
+			theme.DrawFlatButton (g, bounds, state, backColor, foreColor, appearance);
+		}
+
+		public static void DrawPopupButton (Graphics g, Rectangle bounds, ButtonThemeState state, Color backColor, Color foreColor)
+		{
+			theme.DrawPopupButton (g, bounds, state, backColor, foreColor);
+		}
+	}
+
+	#region Internal Enums
+	[Flags]
+	internal enum ButtonThemeState
+	{
+		Normal = 1,
+		Entered = 2,
+		Pressed = 4,
+		Disabled = 8,
+		Default = 16
+	}
+	#endregion
+}
Index: System.Windows.Forms/ThemeElementsDefault.cs
===================================================================
--- System.Windows.Forms/ThemeElementsDefault.cs	(revision 0)
+++ System.Windows.Forms/ThemeElementsDefault.cs	(revision 0)
@@ -0,0 +1,152 @@
+using System;
+using System.Drawing;
+
+namespace System.Windows.Forms
+{
+	internal class ThemeElementsDefault
+	{
+		public ThemeElementsDefault ()
+		{
+		}
+
+		protected SystemResPool ResPool { get { return ThemeEngine.Current.ResPool; } }
+		
+		#region Buttons
+		#region Standard Button
+		public virtual void DrawButton (Graphics g, Rectangle bounds, ButtonThemeState state, Color backColor, Color foreColor)
+		{
+			bool is_themecolor = backColor.ToArgb () == ThemeEngine.Current.ColorControl.ToArgb () || backColor == Color.Empty ? true : false;
+			CPColor cpcolor = is_themecolor ? CPColor.Empty : ResPool.GetCPColor (backColor);
+			Pen pen;
+			
+			switch (state) {
+				case ButtonThemeState.Normal:
+				case ButtonThemeState.Entered:
+				case ButtonThemeState.Disabled:
+					pen = is_themecolor ? SystemPens.ControlLightLight : ResPool.GetPen (cpcolor.LightLight);
+					g.DrawLine (pen, bounds.X, bounds.Y, bounds.X, bounds.Bottom - 2);
+					g.DrawLine (pen, bounds.X + 1, bounds.Y, bounds.Right - 2, bounds.Y);
+
+					pen = is_themecolor ? SystemPens.Control : ResPool.GetPen (backColor);
+					g.DrawLine (pen, bounds.X + 1, bounds.Y + 1, bounds.X + 1, bounds.Bottom - 3);
+					g.DrawLine (pen, bounds.X + 2, bounds.Y + 1, bounds.Right - 3, bounds.Y + 1);
+
+					pen = is_themecolor ? SystemPens.ControlDark : ResPool.GetPen (cpcolor.Dark);
+					g.DrawLine (pen, bounds.X + 1, bounds.Bottom - 2, bounds.Right - 2, bounds.Bottom - 2);
+					g.DrawLine (pen, bounds.Right - 2, bounds.Y + 1, bounds.Right - 2, bounds.Bottom - 3);
+
+					pen = is_themecolor ? SystemPens.ControlDarkDark : ResPool.GetPen (cpcolor.DarkDark);
+					g.DrawLine (pen, bounds.X, bounds.Bottom - 1, bounds.Right - 1, bounds.Bottom - 1);
+					g.DrawLine (pen, bounds.Right - 1, bounds.Y, bounds.Right - 1, bounds.Bottom - 2);
+					break;
+				case ButtonThemeState.Pressed:
+					g.DrawRectangle (ResPool.GetPen (foreColor), bounds.X, bounds.Y, bounds.Width - 1, bounds.Height - 1);
+
+					bounds.Inflate (-1, -1);
+					pen = is_themecolor ? SystemPens.ControlDark : ResPool.GetPen (cpcolor.Dark);
+					g.DrawRectangle (pen, bounds.X, bounds.Y, bounds.Width - 1, bounds.Height - 1);
+					break;
+				case ButtonThemeState.Default:
+					g.DrawRectangle (ResPool.GetPen (foreColor), bounds.X, bounds.Y, bounds.Width - 1, bounds.Height - 1);
+
+					bounds.Inflate (-1, -1);
+					pen = is_themecolor ? SystemPens.ControlLightLight : ResPool.GetPen (cpcolor.LightLight);
+					g.DrawLine (pen, bounds.X, bounds.Y, bounds.X, bounds.Bottom - 2);
+					g.DrawLine (pen, bounds.X + 1, bounds.Y, bounds.Right - 2, bounds.Y);
+
+					pen = is_themecolor ? SystemPens.Control : ResPool.GetPen (backColor);
+					g.DrawLine (pen, bounds.X + 1, bounds.Y + 1, bounds.X + 1, bounds.Bottom - 3);
+					g.DrawLine (pen, bounds.X + 2, bounds.Y + 1, bounds.Right - 3, bounds.Y + 1);
+
+					pen = is_themecolor ? SystemPens.ControlDark : ResPool.GetPen (cpcolor.Dark);
+					g.DrawLine (pen, bounds.X + 1, bounds.Bottom - 2, bounds.Right - 2, bounds.Bottom - 2);
+					g.DrawLine (pen, bounds.Right - 2, bounds.Y + 1, bounds.Right - 2, bounds.Bottom - 3);
+
+					pen = is_themecolor ? SystemPens.ControlDarkDark : ResPool.GetPen (cpcolor.DarkDark);
+					g.DrawLine (pen, bounds.X, bounds.Bottom - 1, bounds.Right - 1, bounds.Bottom - 1);
+					g.DrawLine (pen, bounds.Right - 1, bounds.Y, bounds.Right - 1, bounds.Bottom - 2);
+					break;
+			}
+		}
+		#endregion
+
+		#region FlatStyle Button
+		public virtual void DrawFlatButton (Graphics g, Rectangle bounds, ButtonThemeState state, Color backColor, Color foreColor, FlatButtonAppearance appearance)
+		{
+			bool is_themecolor = backColor.ToArgb () == ThemeEngine.Current.ColorControl.ToArgb () || backColor == Color.Empty ? true : false;
+			CPColor cpcolor = is_themecolor ? CPColor.Empty : ResPool.GetCPColor (backColor);
+			Pen pen;
+			
+			switch (state) {
+				case ButtonThemeState.Normal:
+				case ButtonThemeState.Disabled:
+					// This will just use the BackColor
+					break;
+				case ButtonThemeState.Entered:
+					if (appearance.MouseOverBackColor != Color.Empty)
+						g.FillRectangle (ResPool.GetSolidBrush (appearance.MouseOverBackColor), bounds);
+					break;
+				case ButtonThemeState.Pressed:
+					if (appearance.MouseDownBackColor != Color.Empty)
+						g.FillRectangle (ResPool.GetSolidBrush (appearance.MouseDownBackColor), bounds);
+					break;
+				case ButtonThemeState.Default:
+					if (appearance.CheckedBackColor != Color.Empty)
+						g.FillRectangle (ResPool.GetSolidBrush (appearance.CheckedBackColor), bounds);
+					break;
+			}
+			
+			if (appearance.BorderColor == Color.Empty)
+				pen = is_themecolor ? SystemPens.ControlDarkDark : ResPool.GetSizedPen (cpcolor.DarkDark, appearance.BorderSize);
+			else
+				pen = ResPool.GetSizedPen (appearance.BorderColor, appearance.BorderSize);
+				
+			bounds.Width -= 1;
+			bounds.Height -= 1;
+			g.DrawRectangle (pen, bounds);
+
+			if (state == ButtonThemeState.Default || state == ButtonThemeState.Pressed) {
+				bounds.Inflate (-1, -1);
+				g.DrawRectangle (pen, bounds);
+			}
+		}
+		#endregion
+
+		#region Popup Button
+		public virtual void DrawPopupButton (Graphics g, Rectangle bounds, ButtonThemeState state, Color backColor, Color foreColor)
+		{
+			bool is_themecolor = backColor.ToArgb () == ThemeEngine.Current.ColorControl.ToArgb () || backColor == Color.Empty ? true : false;
+			CPColor cpcolor = is_themecolor ? CPColor.Empty : ResPool.GetCPColor (backColor);
+			Pen pen;
+
+			switch (state) {
+				case ButtonThemeState.Normal:
+				case ButtonThemeState.Disabled:
+				case ButtonThemeState.Pressed:
+				case ButtonThemeState.Default:
+					pen = is_themecolor ? SystemPens.ControlDarkDark : ResPool.GetPen (cpcolor.DarkDark);
+
+					bounds.Width -= 1;
+					bounds.Height -= 1;
+					g.DrawRectangle (pen, bounds);
+
+					if (state == ButtonThemeState.Default || state == ButtonThemeState.Pressed) {
+						bounds.Inflate (-1, -1);
+						g.DrawRectangle (pen, bounds);
+					}
+					break;
+				case ButtonThemeState.Entered:
+					pen = is_themecolor ? SystemPens.ControlLightLight : ResPool.GetPen (cpcolor.LightLight);
+					g.DrawLine (pen, bounds.X, bounds.Y, bounds.X, bounds.Bottom - 2);
+					g.DrawLine (pen, bounds.X + 1, bounds.Y, bounds.Right - 2, bounds.Y);
+
+					pen = is_themecolor ? SystemPens.ControlDark : ResPool.GetPen (cpcolor.Dark);
+					g.DrawLine (pen, bounds.X, bounds.Bottom - 1, bounds.Right - 1, bounds.Bottom - 1);
+					g.DrawLine (pen, bounds.Right - 1, bounds.Y, bounds.Right - 1, bounds.Bottom - 2);
+					break;
+			}
+		}
+		#endregion
+		#endregion
+	}
+}
Index: System.Windows.Forms/ThemeWin32Classic.cs
===================================================================
--- System.Windows.Forms/ThemeWin32Classic.cs	(revision 73495)
+++ System.Windows.Forms/ThemeWin32Classic.cs	(working copy)
@@ -140,6 +140,430 @@
 		}
 		#endregion	// OwnerDraw Support
 
+		#region Button
+		#region Standard Button Style
+		public override void DrawButton (Graphics g, Button b, Rectangle textBounds, Rectangle imageBounds, Rectangle clipRectangle)
+		{
+			// Draw Button Background
+			DrawButtonBackground (g, b, clipRectangle);
+
+			// If we have an image, draw it
+			if (imageBounds.Size != Size.Empty)
+				DrawButtonImage (g, b, imageBounds);
+
+			// If we're focused, draw a focus rectangle
+			if (b.Focused && b.Enabled)
+				DrawButtonFocus (g, b);
+
+			// If we have text, draw it
+			if (textBounds != Rectangle.Empty)
+				DrawButtonText (g, b, textBounds);
+		}
+
+		public virtual void DrawButtonBackground (Graphics g, Button button, Rectangle clipArea) 
+		{
+			if (button.Pressed)
+				ThemeElements.DrawButton (g, button.ClientRectangle, ButtonThemeState.Pressed, button.BackColor, button.ForeColor);
+			else if (button.Selected)
+				ThemeElements.DrawButton (g, button.ClientRectangle, ButtonThemeState.Default, button.BackColor, button.ForeColor);
+			else if (button.Entered)
+				ThemeElements.DrawButton (g, button.ClientRectangle, ButtonThemeState.Entered, button.BackColor, button.ForeColor);
+			else if (!button.Enabled)
+				ThemeElements.DrawButton (g, button.ClientRectangle, ButtonThemeState.Disabled, button.BackColor, button.ForeColor);
+			else
+				ThemeElements.DrawButton (g, button.ClientRectangle, ButtonThemeState.Normal, button.BackColor, button.ForeColor);
+		}
+
+		public virtual void DrawButtonFocus (Graphics g, Button button)
+		{
+			ControlPaint.DrawFocusRectangle (g, Rectangle.Inflate (button.ClientRectangle, -4, -4));
+		}
+
+		public virtual void DrawButtonImage (Graphics g, Button button, Rectangle imageBounds)
+		{
+			if (button.Enabled)
+				g.DrawImage (button.Image, imageBounds);
+			else
+				CPDrawImageDisabled (g, button.Image, imageBounds.Left, imageBounds.Top, ColorControl);
+		}
+
+		public virtual void DrawButtonText (Graphics g, Button button, Rectangle textBounds)
+		{
+			if (button.Pressed)
+				textBounds.Offset (1, 1);
+							
+			if (button.Enabled)
+				TextRenderer.DrawTextInternal (g, button.Text, button.Font, textBounds, button.ForeColor, button.TextFormatFlags, button.UseCompatibleTextRendering);
+			else
+				DrawStringDisabled20 (g, button.Text, button.Font, textBounds, button.BackColor, button.TextFormatFlags, button.UseCompatibleTextRendering);
+		}
+		#endregion
+
+		#region FlatStyle Button Style
+		public override void DrawFlatButton (Graphics g, Button b, Rectangle textBounds, Rectangle imageBounds, Rectangle clipRectangle)
+		{
+			// Draw Button Background
+			DrawFlatButtonBackground (g, b, clipRectangle);
+
+			// If we have an image, draw it
+			if (imageBounds.Size != Size.Empty)
+				DrawFlatButtonImage (g, b, imageBounds);
+
+			// If we're focused, draw a focus rectangle
+			if (b.Focused && b.Enabled)
+				DrawFlatButtonFocus (g, b);
+
+			// If we have text, draw it
+			if (textBounds != Rectangle.Empty)
+				DrawFlatButtonText (g, b, textBounds);
+		}
+
+		public virtual void DrawFlatButtonBackground (Graphics g, Button button, Rectangle clipArea)
+		{
+			if (button.Pressed)
+				ThemeElements.DrawFlatButton (g, button.ClientRectangle, ButtonThemeState.Pressed, button.BackColor, button.ForeColor, button.FlatAppearance);
+			else if (button.Selected)
+				ThemeElements.DrawFlatButton (g, button.ClientRectangle, ButtonThemeState.Default, button.BackColor, button.ForeColor, button.FlatAppearance);
+			else if (button.Entered)
+				ThemeElements.DrawFlatButton (g, button.ClientRectangle, ButtonThemeState.Entered, button.BackColor, button.ForeColor, button.FlatAppearance);
+			else if (!button.Enabled)
+				ThemeElements.DrawFlatButton (g, button.ClientRectangle, ButtonThemeState.Disabled, button.BackColor, button.ForeColor, button.FlatAppearance);
+			else
+				ThemeElements.DrawFlatButton (g, button.ClientRectangle, ButtonThemeState.Normal, button.BackColor, button.ForeColor, button.FlatAppearance);
+		}
+
+		public virtual void DrawFlatButtonFocus (Graphics g, Button button)
+		{
+			if (!button.Pressed) {
+				Color focus_color = ControlPaint.Light(button.BackColor);
+				g.DrawRectangle (ResPool.GetPen (focus_color), new Rectangle (button.ClientRectangle.Left + 4, button.ClientRectangle.Top + 4, button.ClientRectangle.Width - 9, button.ClientRectangle.Height - 9));
+			}
+		}
+
+		public virtual void DrawFlatButtonImage (Graphics g, Button button, Rectangle imageBounds)
+		{
+			// No changes from Standard for image for this theme
+			DrawButtonImage (g, button, imageBounds);
+		}
+
+		public virtual void DrawFlatButtonText (Graphics g, Button button, Rectangle textBounds)
+		{
+			// No changes from Standard for image for this theme
+			DrawButtonText (g, button, textBounds);
+		}
+		#endregion
+
+		#region Popup Button Style
+		public override void DrawPopupButton (Graphics g, Button b, Rectangle textBounds, Rectangle imageBounds, Rectangle clipRectangle)
+		{
+			// Draw Button Background
+			DrawPopupButtonBackground (g, b, clipRectangle);
+
+			// If we have an image, draw it
+			if (imageBounds.Size != Size.Empty)
+				DrawPopupButtonImage (g, b, imageBounds);
+
+			// If we're focused, draw a focus rectangle
+			if (b.Focused && b.Enabled)
+				DrawPopupButtonFocus (g, b);
+
+			// If we have text, draw it
+			if (textBounds != Rectangle.Empty)
+				DrawPopupButtonText (g, b, textBounds);
+		}
+
+		public virtual void DrawPopupButtonBackground (Graphics g, Button button, Rectangle clipArea)
+		{
+			if (button.Pressed)
+				ThemeElements.DrawPopupButton (g, button.ClientRectangle, ButtonThemeState.Pressed, button.BackColor, button.ForeColor);
+			else if (button.Entered)
+				ThemeElements.DrawPopupButton (g, button.ClientRectangle, ButtonThemeState.Entered, button.BackColor, button.ForeColor);
+			else if (button.Selected)
+				ThemeElements.DrawPopupButton (g, button.ClientRectangle, ButtonThemeState.Default, button.BackColor, button.ForeColor);
+			else if (!button.Enabled)
+				ThemeElements.DrawPopupButton (g, button.ClientRectangle, ButtonThemeState.Disabled, button.BackColor, button.ForeColor);
+			else
+				ThemeElements.DrawPopupButton (g, button.ClientRectangle, ButtonThemeState.Normal, button.BackColor, button.ForeColor);
+		}
+
+		public virtual void DrawPopupButtonFocus (Graphics g, Button button)
+		{
+			// No changes from Standard for image for this theme
+			DrawButtonFocus (g, button);
+		}
+
+		public virtual void DrawPopupButtonImage (Graphics g, Button button, Rectangle imageBounds)
+		{
+			// No changes from Standard for image for this theme
+			DrawButtonImage (g, button, imageBounds);
+		}
+
+		public virtual void DrawPopupButtonText (Graphics g, Button button, Rectangle textBounds)
+		{
+			// No changes from Standard for image for this theme
+			DrawButtonText (g, button, textBounds);
+		}
+		#endregion
+
+		#region Button Layout Calculations
+		public override void CalculateButtonTextAndImageLayout (Button button, out Rectangle textRectangle, out Rectangle imageRectangle)
+		{
+			Image image = button.Image;
+			string text = button.Text;
+			Rectangle content_rect = button.ClientRectangle;
+			Size text_size = TextRenderer.MeasureTextInternal (text, button.Font, content_rect.Size, button.TextFormatFlags, button.UseCompatibleTextRendering);
+			Size image_size = image == null ? Size.Empty : image.Size;
+
+			textRectangle = Rectangle.Empty;
+			imageRectangle = Rectangle.Empty;
+			
+			switch (button.TextImageRelation) {
+				case TextImageRelation.Overlay:
+					// Overlay is easy, text always goes here
+					textRectangle = Rectangle.Inflate (content_rect, -4, -4);
+
+					if (button.Pressed)
+						textRectangle.Offset (1, 1);
+						
+					// Image is dependent on ImageAlign
+					if (image == null)
+						return;
+						
+					int image_x = 0;
+					int image_y = 0;
+					int image_height = image.Height;
+					int image_width = image.Width;
+					
+					switch (button.ImageAlign) {
+						case System.Drawing.ContentAlignment.TopLeft:
+							image_x = 5;
+							image_y = 5;
+							break;
+						case System.Drawing.ContentAlignment.TopCenter:
+							image_x = (content_rect.Width - image_width) / 2;
+							image_y = 5;
+							break;
+						case System.Drawing.ContentAlignment.TopRight:
+							image_x = content_rect.Width - image_width - 5;
+							image_y = 5;
+							break;
+						case System.Drawing.ContentAlignment.MiddleLeft:
+							image_x = 5;
+							image_y = (content_rect.Height - image_height) / 2;
+							break;
+						case System.Drawing.ContentAlignment.MiddleCenter:
+							image_x = (content_rect.Width - image_width) / 2;
+							image_y = (content_rect.Height - image_height) / 2;
+							break;
+						case System.Drawing.ContentAlignment.MiddleRight:
+							image_x = content_rect.Width - image_width - 4;
+							image_y = (content_rect.Height - image_height) / 2;
+							break;
+						case System.Drawing.ContentAlignment.BottomLeft:
+							image_x = 5;
+							image_y = content_rect.Height - image_height - 4;
+							break;
+						case System.Drawing.ContentAlignment.BottomCenter:
+							image_x = (content_rect.Width - image_width) / 2;
+							image_y = content_rect.Height - image_height - 4;
+							break;
+						case System.Drawing.ContentAlignment.BottomRight:
+							image_x = content_rect.Width - image_width - 4;
+							image_y = content_rect.Height - image_height - 4;
+							break;
+						default:
+							image_x = 5;
+							image_y = 5;
+							break;
+					}
+					
+					imageRectangle = new Rectangle (image_x, image_y, image_width, image_height);
+					break;
+				case TextImageRelation.ImageAboveText:
+					content_rect.Inflate (-4, -4);
+					LayoutTextAboveOrBelowImage (content_rect, false, text_size, image_size, button.TextAlign, button.ImageAlign, out textRectangle, out imageRectangle);
+					break;
+				case TextImageRelation.TextAboveImage:
+					content_rect.Inflate (-4, -4);
+					LayoutTextAboveOrBelowImage (content_rect, true, text_size, image_size, button.TextAlign, button.ImageAlign, out textRectangle, out imageRectangle);
+					break;
+				case TextImageRelation.ImageBeforeText:
+					content_rect.Inflate (-4, -4);
+					LayoutTextBeforeOrAfterImage (content_rect, false, text_size, image_size, button.TextAlign, button.ImageAlign, out textRectangle, out imageRectangle);
+					break;
+				case TextImageRelation.TextBeforeImage:
+					content_rect.Inflate (-4, -4);
+					LayoutTextBeforeOrAfterImage (content_rect, true, text_size, image_size, button.TextAlign, button.ImageAlign, out textRectangle, out imageRectangle);
+					break;
+			}
+		}
+
+		private void LayoutTextBeforeOrAfterImage (Rectangle totalArea, bool textFirst, Size textSize, Size imageSize, System.Drawing.ContentAlignment textAlign, System.Drawing.ContentAlignment imageAlign, out Rectangle textRect, out Rectangle imageRect)
+		{
+			int element_spacing = 0;	// Spacing between the Text and the Image
+			int total_width = textSize.Width + element_spacing + imageSize.Width;
+			
+			if (!textFirst)
+				element_spacing += 2;
+				
+			// If the text is too big, chop it down to the size we have available to it
+			if (total_width > totalArea.Width) {
+				textSize.Width = totalArea.Width - element_spacing - imageSize.Width;
+				total_width = totalArea.Width;
+			}
+			
+			int excess_width = totalArea.Width - total_width;
+			int offset = 0;
+
+			Rectangle final_text_rect;
+			Rectangle final_image_rect;
+
+			HorizontalAlignment h_text = GetHorizontalAlignment (textAlign);
+			HorizontalAlignment h_image = GetHorizontalAlignment (imageAlign);
+
+			if (h_image == HorizontalAlignment.Left)
+				offset = 0;
+			else if (h_image == HorizontalAlignment.Right && h_text == HorizontalAlignment.Right)
+				offset = excess_width;
+			else if (h_image == HorizontalAlignment.Center && (h_text == HorizontalAlignment.Left || h_text == HorizontalAlignment.Center))
+				offset += (int)(excess_width / 3);
+			else
+				offset += (int)(2 * (excess_width / 3));
+
+			if (textFirst) {
+				final_text_rect = new Rectangle (totalArea.Left + offset, AlignInRectangle (totalArea, textSize, textAlign).Top, textSize.Width, textSize.Height);
+				final_image_rect = new Rectangle (final_text_rect.Right + element_spacing, AlignInRectangle (totalArea, imageSize, imageAlign).Top, imageSize.Width, imageSize.Height);
+			}
+			else {
+				final_image_rect = new Rectangle (totalArea.Left + offset, AlignInRectangle (totalArea, imageSize, imageAlign).Top, imageSize.Width, imageSize.Height);
+				final_text_rect = new Rectangle (final_image_rect.Right + element_spacing, AlignInRectangle (totalArea, textSize, textAlign).Top, textSize.Width, textSize.Height);
+			}
+
+			textRect = final_text_rect;
+			imageRect = final_image_rect;
+		}
+
+		private void LayoutTextAboveOrBelowImage (Rectangle totalArea, bool textFirst, Size textSize, Size imageSize, System.Drawing.ContentAlignment textAlign, System.Drawing.ContentAlignment imageAlign, out Rectangle textRect, out Rectangle imageRect)
+		{
+			int element_spacing = 0;	// Spacing between the Text and the Image
+			int total_height = textSize.Height + element_spacing + imageSize.Height;
+
+			if (textFirst)
+				element_spacing += 2;
+
+			if (textSize.Width > totalArea.Width)
+				textSize.Width = totalArea.Width;
+				
+			// If the there isn't enough room and we're text first, cut out the image
+			if (total_height > totalArea.Height && textFirst) {
+				imageSize = Size.Empty;
+				total_height = totalArea.Height;
+			}
+
+			int excess_height = totalArea.Height - total_height;
+			int offset = 0;
+
+			Rectangle final_text_rect;
+			Rectangle final_image_rect;
+
+			VerticalAlignment v_text = GetVerticalAlignment (textAlign);
+			VerticalAlignment v_image = GetVerticalAlignment (imageAlign);
+
+			if (v_image == VerticalAlignment.Top)
+				offset = 0;
+			else if (v_image == VerticalAlignment.Bottom && v_text == VerticalAlignment.Bottom)
+				offset = excess_height;
+			else if (v_image == VerticalAlignment.Center && (v_text == VerticalAlignment.Top || v_text == VerticalAlignment.Center))
+				offset += (int)(excess_height / 3);
+			else
+				offset += (int)(2 * (excess_height / 3));
+
+			if (textFirst) {
+				final_text_rect = new Rectangle (AlignInRectangle (totalArea, textSize, textAlign).Left, totalArea.Top + offset, textSize.Width, textSize.Height);
+				final_image_rect = new Rectangle (AlignInRectangle (totalArea, imageSize, imageAlign).Left, final_text_rect.Bottom + element_spacing, imageSize.Width, imageSize.Height);
+			}
+			else {
+				final_image_rect = new Rectangle (AlignInRectangle (totalArea, imageSize, imageAlign).Left, totalArea.Top + offset, imageSize.Width, imageSize.Height);
+				final_text_rect = new Rectangle (AlignInRectangle (totalArea, textSize, textAlign).Left, final_image_rect.Bottom + element_spacing, textSize.Width, textSize.Height);
+				
+				if (final_text_rect.Bottom > totalArea.Bottom)
+					final_text_rect.Y = totalArea.Top;
+			}
+
+			textRect = final_text_rect;
+			imageRect = final_image_rect;
+		}
+		
+		private HorizontalAlignment GetHorizontalAlignment (System.Drawing.ContentAlignment align)
+		{
+			switch (align) {
+				case System.Drawing.ContentAlignment.BottomLeft:
+				case System.Drawing.ContentAlignment.MiddleLeft:
+				case System.Drawing.ContentAlignment.TopLeft:
+					return HorizontalAlignment.Left;
+				case System.Drawing.ContentAlignment.BottomCenter:
+				case System.Drawing.ContentAlignment.MiddleCenter:
+				case System.Drawing.ContentAlignment.TopCenter:
+					return HorizontalAlignment.Center;
+				case System.Drawing.ContentAlignment.BottomRight:
+				case System.Drawing.ContentAlignment.MiddleRight:
+				case System.Drawing.ContentAlignment.TopRight:
+					return HorizontalAlignment.Right;
+			}
+
+			return HorizontalAlignment.Left;
+		}
+
+		private enum VerticalAlignment
+		{
+			Top = 0,
+			Center = 1,
+			Bottom = 2
+		}
+		
+		private VerticalAlignment GetVerticalAlignment (System.Drawing.ContentAlignment align)
+		{
+			switch (align) {
+				case System.Drawing.ContentAlignment.TopLeft:
+				case System.Drawing.ContentAlignment.TopCenter:
+				case System.Drawing.ContentAlignment.TopRight:
+					return VerticalAlignment.Top;
+				case System.Drawing.ContentAlignment.MiddleLeft:
+				case System.Drawing.ContentAlignment.MiddleCenter:
+				case System.Drawing.ContentAlignment.MiddleRight:
+					return VerticalAlignment.Center;
+				case System.Drawing.ContentAlignment.BottomLeft:
+				case System.Drawing.ContentAlignment.BottomCenter:
+				case System.Drawing.ContentAlignment.BottomRight:
+					return VerticalAlignment.Bottom;
+			}
+
+			return VerticalAlignment.Top;
+		}
+
+		internal Rectangle AlignInRectangle (Rectangle outer, Size inner, System.Drawing.ContentAlignment align)
+		{
+			int x = 0;
+			int y = 0;
+
+			if (align == System.Drawing.ContentAlignment.BottomLeft || align == System.Drawing.ContentAlignment.MiddleLeft || align == System.Drawing.ContentAlignment.TopLeft)
+				x = outer.X;
+			else if (align == System.Drawing.ContentAlignment.BottomCenter || align == System.Drawing.ContentAlignment.MiddleCenter || align == System.Drawing.ContentAlignment.TopCenter)
+				x = Math.Max (outer.X + ((outer.Width - inner.Width) / 2), outer.Left);
+			else if (align == System.Drawing.ContentAlignment.BottomRight || align == System.Drawing.ContentAlignment.MiddleRight || align == System.Drawing.ContentAlignment.TopRight)
+				x = outer.Right - inner.Width;
+			if (align == System.Drawing.ContentAlignment.TopCenter || align == System.Drawing.ContentAlignment.TopLeft || align == System.Drawing.ContentAlignment.TopRight)
+				y = outer.Y;
+			else if (align == System.Drawing.ContentAlignment.MiddleCenter || align == System.Drawing.ContentAlignment.MiddleLeft || align == System.Drawing.ContentAlignment.MiddleRight)
+				y = outer.Y + (outer.Height - inner.Height) / 2;
+			else if (align == System.Drawing.ContentAlignment.BottomCenter || align == System.Drawing.ContentAlignment.BottomRight || align == System.Drawing.ContentAlignment.BottomLeft)
+				y = outer.Bottom - inner.Height;
+
+			return new Rectangle (x, y, Math.Min (inner.Width, outer.Width), Math.Min (inner.Height, outer.Height));
+		}
+		#endregion
+		#endregion
+
 		#region ButtonBase
 		public override void DrawButtonBase(Graphics dc, Rectangle clip_area, ButtonBase button)
 		{
@@ -272,7 +696,7 @@
 			int height = button.ClientSize.Height;
 
 			if (button.ImageIndex != -1) {	 // We use ImageIndex instead of image_index since it will return -1 if image_list is null
-				i = button.image_list.Images[button.image_index];
+				i = button.image_list.Images[button.ImageIndex];
 			} else {
 				i = button.image;
 			}
@@ -280,7 +704,7 @@
 			image_width = i.Width;
 			image_height = i.Height;
 			
-			switch (button.image_alignment) {
+			switch (button.ImageAlign) {
 				case ContentAlignment.TopLeft: {
 					image_x = 5;
 					image_y = 5;
@@ -5927,6 +6351,17 @@
 			}
 		}
 
+		private void DrawStringDisabled20 (Graphics g, string s, Font font, Rectangle layoutRectangle, Color color, TextFormatFlags flags, bool useDrawString)
+		{
+			CPColor cpcolor = ResPool.GetCPColor (color);
+
+			layoutRectangle.Offset (1, 1);
+			TextRenderer.DrawTextInternal (g, s, font, layoutRectangle, cpcolor.LightLight, flags, useDrawString);
+
+			layoutRectangle.Offset (-1, -1);
+			TextRenderer.DrawTextInternal (g, s, font, layoutRectangle, cpcolor.Dark, flags, useDrawString);
+		}
+
 		public  override void CPDrawStringDisabled (Graphics dc, string s, Font font, Color color, RectangleF layoutRectangle, StringFormat format)
 		{
 			CPColor cpcolor = ResPool.GetCPColor (color);
