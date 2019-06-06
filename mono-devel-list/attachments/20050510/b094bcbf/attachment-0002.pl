using System;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Runtime.InteropServices;
using System.Reflection;
using System.Windows.Forms;

namespace GdiPlusStream
{
	public class Form1 : System.Windows.Forms.Form
	{
		[DllImportAttribute("gdiplus.dll", ExactSpelling=true, CharSet=CharSet.Unicode)]
		private static extern int GdipLoadImageFromStream([MarshalAs(UnmanagedType.CustomMarshaler, MarshalTypeRef=typeof(ComIStreamMarshaler))] UCOMIStream stream, out IntPtr image);

		[DllImportAttribute("gdiplus.dll", ExactSpelling=true, CharSet=CharSet.Unicode)]
		internal static extern int GdipSaveImageToStream(HandleRef image, [MarshalAs(UnmanagedType.CustomMarshaler, MarshalTypeRef=typeof(ComIStreamMarshaler))] UCOMIStream stream, [In()] ref Guid clsidEncoder, HandleRef encoderParams);

		private System.Windows.Forms.Button button1;
		private System.Windows.Forms.Button button2;
		private System.Windows.Forms.PictureBox pictureBox1;
		private System.ComponentModel.Container components = null;

		public Form1()
		{
			InitializeComponent();
		}

		protected override void Dispose( bool disposing )
		{
			if( disposing )
			{
				if (components != null) 
				{
					components.Dispose();
				}
			}
			base.Dispose( disposing );
		}

		#region Windows Form Designer generated code
		private void InitializeComponent()
		{
			this.button1 = new System.Windows.Forms.Button();
			this.button2 = new System.Windows.Forms.Button();
			this.pictureBox1 = new System.Windows.Forms.PictureBox();
			this.SuspendLayout();
			// 
			// button1
			// 
			this.button1.Location = new System.Drawing.Point(0, 0);
			this.button1.Name = "button1";
			this.button1.Size = new System.Drawing.Size(136, 23);
			this.button1.TabIndex = 0;
			this.button1.Text = "Load from load.bmp";
			this.button1.Click += new System.EventHandler(this.button1_Click);
			// 
			// button2
			// 
			this.button2.Location = new System.Drawing.Point(0, 32);
			this.button2.Name = "button2";
			this.button2.Size = new System.Drawing.Size(136, 23);
			this.button2.TabIndex = 1;
			this.button2.Text = "Save to save.png";
			this.button2.Click += new System.EventHandler(this.button2_Click);
			// 
			// pictureBox1
			// 
			this.pictureBox1.Location = new System.Drawing.Point(0, 64);
			this.pictureBox1.Name = "pictureBox1";
			this.pictureBox1.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage;
			this.pictureBox1.TabIndex = 2;
			this.pictureBox1.TabStop = false;
			// 
			// Form1
			// 
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
			this.ClientSize = new System.Drawing.Size(292, 266);
			this.Controls.Add(this.pictureBox1);
			this.Controls.Add(this.button2);
			this.Controls.Add(this.button1);
			this.Name = "Form1";
			this.Text = "Form1";
			this.Load += new System.EventHandler(this.Form1_Load);
			this.ResumeLayout(false);

		}
		#endregion

		[STAThread]
		static void Main() 
		{
			Application.Run(new Form1());
		}

		private void Form1_Load(object sender, System.EventArgs e)
		{
		}

		private void button1_Click(object sender, System.EventArgs e)
		{
			FileStream fileStream = new FileStream(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "load.bmp"), FileMode.Open, FileAccess.Read);
			try
			{
				pictureBox1.Image = LoadImageFromStream(fileStream);
				// pictureBox1.Image = new Bitmap(fileStream);
			}
			finally
			{
				// GDI+ requires the stream
				// fileStream.Close();
			}
		}

		private void button2_Click(object sender, System.EventArgs e)
		{
			FileStream fileStream = new FileStream(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "save.png"), FileMode.Create, FileAccess.Write);
			try
			{
				SaveImageToStream(pictureBox1.Image, fileStream, ImageFormat.Png);
				// pictureBox1.Image.Save(fileStream, ImageFormat.Png);
			}
			finally
			{
				fileStream.Close();
			}
		}

		private static Image LoadImageFromStream(Stream stream)
		{
			IntPtr nativeImage = IntPtr.Zero;
			int result;

			// Recommended
			if (!stream.CanSeek)
			{
				byte[] buffer = new byte[256];
				int index = 0;
				int count;

				do
				{
					if (buffer.Length < index + 256)
					{
						byte[] newBuffer = new byte[buffer.Length * 2];
						Array.Copy(buffer, newBuffer, buffer.Length);
						buffer = newBuffer;
					}
					count = stream.Read(buffer, index, 256);
					index += count;
				}
				while (count != 0);

				stream = new MemoryStream(buffer, 0, index);
			}

			result = GdipLoadImageFromStream(new ComIStreamWrapper(stream), out nativeImage);

			if (result != 0)
			{
				throw new Exception("GDI+ Error " + result.ToString());
			}

			try
			{
				// .NET Framework
				return (Image)(typeof(Image).InvokeMember("CreateImageObject", BindingFlags.InvokeMethod | BindingFlags.NonPublic | BindingFlags.Static, null, null, new object[] {nativeImage}));
			}
			catch
			{
				// Mono
				return (Image)Activator.CreateInstance(typeof(Bitmap), BindingFlags.CreateInstance | BindingFlags.NonPublic | BindingFlags.Instance, null, new object[] {nativeImage}, null);
			}
		}

		private void SaveImageToStream(Image image, Stream stream, ImageFormat format)
		{
			ImageCodecInfo[] encoders = ImageCodecInfo.GetImageEncoders();			
			ImageCodecInfo encoder = null;
			Guid guid;
			IntPtr nativeImage;
			int result;

			try
			{
				// .NET Framework
				nativeImage = (IntPtr)(typeof(Image).InvokeMember("nativeImage", BindingFlags.GetField | BindingFlags.NonPublic | BindingFlags.Instance, null, image, new object[] {}));
			}
			catch
			{
				// Mono
				nativeImage = (IntPtr)(typeof(Image).InvokeMember("nativeObject", BindingFlags.GetField | BindingFlags.NonPublic | BindingFlags.Instance, null, image, new object[] {}));
			}

			for (int i = 0; i < encoders.Length; i++)
			{
				if (encoders[i].FormatID.Equals(format.Guid))
				{
					encoder = encoders[i];
					break;
				}
			}

			guid = encoder.Clsid;

			result = GdipSaveImageToStream(new HandleRef(this, nativeImage), new ComIStreamWrapper(stream), ref guid, new HandleRef(null, IntPtr.Zero));

			if (result != 0)
			{
				throw new Exception("GDI+ Error " + result.ToString());
			}
		}
	}
}