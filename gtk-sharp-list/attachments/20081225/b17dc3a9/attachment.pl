// EAN13Renderer.cs
// 
// Copyright (C) 2008 Christian Hoff
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of version 2 of the Lesser GNU General 
// Public License as published by the Free Software Foundation.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
// Lesser General Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public
// License along with this program; if not, write to the
// Free Software Foundation, Inc., 59 Temple Place - Suite 330,
// Boston, MA 02111-1307, USA.

namespace Bestandsverwaltung.DataWidgets.Renderer
{
	public class EAN13Renderer : Gtk.CellRenderer
	{
		public event EditedHandler Edited;
		
		public EAN13Renderer (Pango.FontDescription font, int BarcodeHeight, int PixelsPerLineUnit) : base ()
		{
			this.Font = font;
			this.BarcodeHeight = BarcodeHeight;
			this.PixelsPerLineUnit = PixelsPerLineUnit;
			
			this.Mode = Gtk.CellRendererMode.Editable;
		}
		
		private Pango.FontDescription _font;
		public Pango.FontDescription Font
		{
			get {
				return _font;
			}
			set {
				if (value == null)
					throw (new System.ArgumentNullException ());
				
				_font = value;
			}
		}
		
		private int _barcodeHeight;
		public int BarcodeHeight
		{
			get {
				return _barcodeHeight;
			}
			set {
				if (value <= 0)
					throw (new System.ArgumentOutOfRangeException ());
				
				_barcodeHeight = value;
			}
		}
		
		private int _pixelsPerLineUnit;
		public int PixelsPerLineUnit
		{
			get {
				return _pixelsPerLineUnit;
			}
			set {
				if (value <= 0)
					throw (new System.ArgumentOutOfRangeException ());
				
				_pixelsPerLineUnit = value;
			}
		}
		
		Bestandsverwaltung.Barcodes.EAN13 _ean;
		[GLib.Property ("EAN", "Get/Set ean", "This is the description")]
		public Bestandsverwaltung.Barcodes.EAN13 EAN
		{
			get {
				return _ean;
			}
			set {				
				_ean = value;
			}
		}
		
		public void RenderBarcode (Cairo.Context CairoContext, int height)
		{
			Pango.Layout PangoLayout = Pango.CairoHelper.CreateLayout (CairoContext);
			PangoLayout.FontDescription = _font;

			Cairo.Rectangle DrawingRect = new Cairo.Rectangle (0, 0, 0, height);
			Bestandsverwaltung.BarcodeImageCairo.BarcodeImage.RenderEAN13ImageWithLabel (this.EAN, CairoContext, PangoLayout, ref DrawingRect, _pixelsPerLineUnit);
			
			PangoLayout.FontDescription.Dispose ();
			PangoLayout.Context.Dispose ();
			PangoLayout.Dispose ();
		}

		protected override void Render (Gdk.Drawable drawable, Gtk.Widget widget, Gdk.Rectangle background_area, Gdk.Rectangle cell_area, Gdk.Rectangle expose_area, Gtk.CellRendererState flags)
		{
			System.Console.WriteLine ("render");
			if (_ean == null)
				return;
			
			Gdk.Rectangle pix_rect = Gdk.Rectangle.Zero;

			this.GetSize (widget, ref cell_area, out pix_rect.X, out pix_rect.Y, out pix_rect.Width, out pix_rect.Height);

			// Take care of padding
			pix_rect.X += cell_area.X + (int) this.Xpad;
			pix_rect.Y += cell_area.Y + (int) this.Ypad;
			// Remove left, right, top and buttom borders which were added to the returned width
			pix_rect.Width  -= (int) this.Xpad * 2;
			pix_rect.Height -= (int) this.Ypad * 2;
			
			Cairo.Context context = Gdk.CairoHelper.Create (drawable);
			context.Translate (pix_rect.X, pix_rect.Y);
			
			RenderBarcode (context, pix_rect.Height);
			
			(context as System.IDisposable).Dispose ();
		}
		
		public override void GetSize (Gtk.Widget widget, ref Gdk.Rectangle cell_area, out int x_offset, out int y_offset, out int width, out int height)
		{
			width = (int) this.Xpad * 2 + Bestandsverwaltung.BarcodeImageCairo.BarcodeImage.CalculateBarcodeWidth (widget.PangoContext, _font, 1);
			height = (int) this.Ypad * 2 + _barcodeHeight;
			
			if (cell_area != Gdk.Rectangle.Zero) {
				if (widget.Direction == Gtk.TextDirection.Rtl)
					x_offset =  (int) ((1.0 - this.Xalign) * (cell_area.Width - width));
				else
					x_offset = (int) (this.Xalign * (cell_area.Width - width));
				x_offset = System.Math.Max (x_offset, 0);
				
				y_offset = (int) (this.Yalign * (cell_area.Height - height));
				y_offset = System.Math.Max (y_offset, 0);
			} else {
				x_offset = 0;
				y_offset = 0;
			}
		}
		
		/*
		public override Gtk.CellEditable StartEditing (Gdk.Event evnt, Gtk.Widget widget, string path, Gdk.Rectangle background_area, Gdk.Rectangle cell_area, Gtk.CellRendererState flags)
		{
			
		}
		*/
	}
}
