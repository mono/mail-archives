// Magoria
// Copyright B) 2004 Chris Seaton
// Licensed under the GPL - see gpl.txt

using System;
using System.IO;

#if GDK
	using Gdk;
#else
	using System.Drawing;
	using System.Drawing.Imaging;
#endif

using Phantas;

namespace Magoria.Responses
{
	class Thumbnail : Phantas.Responses.File
	{
		string SourcePath;
		int Size;
		
		string Type;
		
		public Thumbnail(Server Server, string SourcePath, int Size)
			: base(Server, null)
		{
			this.SourcePath = SourcePath;
			this.Size = Size;
			
			switch (Server.MIME.FromFileName(SourcePath).SubType)
			{
				case "jpeg":
					Type = "jpeg";
					break;
				case "png":
					Type = "png";
					break;
				case "gif": goto case "png";
			}
			
			// Generate the thumbnail file name
			
			string FileTitle = SourcePath;
			
			foreach (char Illegal in new char[]{'&', ':', '\\', '/'})
				FileTitle = FileTitle.Replace(Illegal.ToString(), "&" + ((int) Illegal).ToString("X"));
			
			FileTitle = FileTitle + "&thumbnailsize=" + Size.ToString();
			FileTitle = FileTitle + "." + Type;
			
			base.Path = System.IO.Path.Combine(System.IO.Path.Combine((Server as Server).DataDirectory, "thumbnails"), FileTitle);
			
			CreateThumbnail();
		}
		
		void CreateThumbnail()
		{
			FileInfo SourceInfo = new FileInfo(SourcePath);
			FileInfo ThumbnailInfo = new FileInfo(Path);
			
			// See if the current thumbnail is up to date
			
			if (!ThumbnailInfo.Exists || (ThumbnailInfo.LastWriteTime < SourceInfo.LastWriteTime))
			{
				// We have to create a new thumbnail
				
				#if GDK
					Pixbuf Source = new Pixbuf(SourcePath);
					Pixbuf Thumbnail;
				#else
					Bitmap Source = new Bitmap(SourcePath);
					Bitmap Thumbnail;
				#endif
				
				if ((Source.Width <= Size) && (Source.Height <= Size))
				{
					Thumbnail = Source;
				}
				else
				{
					float WidthToHeight = (float) Source.Height / Source.Width;
					
					int Width = Size;
					int Height = (int) (Width * WidthToHeight);
					
					if (Height > Size)
					{
						Height = Size;
						Width = (int) (Height / WidthToHeight);
					}
					
					#if GDK
						Thumbnail = new Pixbuf(Source.Colorspace, Source.HasAlpha, Source.BitsPerSample, Width, Height);
						Source.Scale(Thumbnail, 0, 0, Width, Height, 0, 0, (double) Width / Source.Width, (double) Height / Source.Height, InterpType.Bilinear);
					#else
						Thumbnail = new Bitmap(Source, new Size(Width, Height));
					#endif
				}
				
				#if GDK
					Thumbnail.Savev(Path, Type, null, null);
				#else
					Thumbnail.Save(Path, ImageFormat.Jpeg);
				#endif
				
				// Explicit deallocation of the bitmaps
				
				Source.Dispose();
				Thumbnail.Dispose();
			}
		}
	}
}
