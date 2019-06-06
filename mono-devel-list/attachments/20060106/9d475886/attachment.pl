using System;
using System.Globalization;
using System.IO;

namespace GetTempFileNameOverflow
{
	class GetTempFileNameOverflow
	{
		static void Main(string[] args)
		{
			string tempPath;
			string path;
			int num;

			tempPath = Path.GetTempPath();
			for (num = 0; num <= ushort.MaxValue; num++)
			{
				path = Path.Combine(tempPath, "tmp" + num.ToString("X", CultureInfo.InvariantCulture) + ".tmp"); 
				File.Create(path).Close();
			}
			Console.WriteLine(Path.GetTempFileName());
			Console.ReadLine();
		}
	}
}
