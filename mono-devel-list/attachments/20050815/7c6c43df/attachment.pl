using System;
using System.Drawing;
using System.Globalization;
using System.Threading;

namespace PointCultureTest
{
	internal sealed class PointCultureTest
	{
		private sealed class MyCultureInfo : CultureInfo
		{
			internal MyCultureInfo() : base("en-US")
			{
			}

			public override object GetFormat(Type formatType)
			{
				if (formatType == typeof(NumberFormatInfo))
				{
					NumberFormatInfo nfi = (NumberFormatInfo)((NumberFormatInfo)base.GetFormat(formatType)).Clone();
					
					nfi.NegativeSign = "myNegativeSign";
					return NumberFormatInfo.ReadOnly(nfi);
				}
				else
				{
					return base.GetFormat(formatType);
				}
			}
		}

		private static void Main(string[] args)
		{
			Point p = new Point(-2, -8);

			Thread.CurrentThread.CurrentCulture = new CultureInfo("en-US");
			Console.WriteLine("Has to be:                         {X=-2,Y=-8}");
			Console.WriteLine("en-US:                             " + p.ToString());

			Thread.CurrentThread.CurrentCulture = new MyCultureInfo();
			Console.WriteLine("With CultureInfo.InvariantCulture: {X=-2,Y=-8}");
			Console.WriteLine("With CultureInfo.CurrentCulture:   {X=myNegativeSign2,Y=myNegativeSign8}");
			Console.WriteLine("MyCultureInfo:                     " + p.ToString());
			Console.ReadLine();
		}
	}
}