// Assembly references:
// * System
// * System.Drawing

using System.Drawing;
using System.Drawing.Imaging;

namespace MonoGdiTest
{
	class Program
	{
		static void Main(string[] args)
		{
			Bitmap bmp = new Bitmap(20, 20, PixelFormat.Format32bppArgb);
			// Next line throws Exception("Generic Error [GDI+ status: GenericError]")
			bmp.Save("MonoGdiTest.png", ImageFormat.Png);
		}
	}
}