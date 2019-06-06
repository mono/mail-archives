using System;
using System.IO;
using System.Text;

class Latin1ToUtf8
{
	static Encoding utf8 = new UTF8Encoding(false, false);
	static Encoding utf8throw = new UTF8Encoding(false, true);
	static Encoding latin1 = Encoding.GetEncoding(28591);
	static string mwf;
	static string msvb;
	static string consts;

	static void Main(string[] args)
	{
		if (args.Length == 0 || !File.Exists(Path.Combine(args[0], "MonoIcon.png")))
		{
			Console.WriteLine("Usage: Latin1ToUtf8 <path-to-mcs>");
			return;
		}

		string dir = args[0];

		mwf = Path.Combine(dir, NativePath("class/Managed.Windows.Forms"));
		msvb = Path.Combine(dir, NativePath("class/Microsoft.VisualBasic"));
		consts = Path.Combine(dir, NativePath("build/common/Consts.cs"));
		ConvertDir(dir);

		Console.WriteLine("Done.");
	}

	static string NativePath(string path)
	{
		return Path.DirectorySeparatorChar == '/' ? path : path.Replace('/', Path.DirectorySeparatorChar);
	}

	static void ConvertDir(string path)
	{
		if (path == mwf || path == msvb)
			return;

		string[] dirs = Directory.GetDirectories(path);
		for (int i = 0; i < dirs.Length; i++)
			ConvertDir(Path.Combine(path, dirs[i]));

		string[] files = Directory.GetFiles(path, "*.cs");
		for (int i = 0; i < files.Length; i++)
			ConvertFile(Path.Combine(path, files[i]));
	}

	static unsafe void ConvertFile(string path)
	{
		if (path == consts)
			path += ".in";

		bool convert = false;
		StreamReader reader = new StreamReader(path, latin1, false);
		string fileText = reader.ReadToEnd();
		reader.Close();

		fixed (char* charPtr = fileText)
		{
			char* endPtr = charPtr + fileText.Length;
			for (char* curPtr = charPtr; curPtr < endPtr; curPtr++)
				if (curPtr[0] > '\u007F')
				{
					convert = true;
					break;
				}
		}

		if (convert)
		{
			reader = new StreamReader(path, utf8throw, false);
			try
			{
				fileText = reader.ReadToEnd();
				if (fileText[0] == '\uFEFF')
				{
					Console.WriteLine("UTF-8 BOM: " + path);
					fileText = fileText.Remove(0, 1);
				}
				else
				{
					Console.WriteLine("UTF-8: " + path);
					convert = false;
				}
			}
			catch (ArgumentException)
			{
				if (fileText[0] == '\u00EF' && fileText[1] == '\u00BB' && fileText[2] == '\u00BF')
					Console.WriteLine("Invalid BOM: " + path);
				else
					Console.WriteLine("Latin 1: " + path);
			}
			reader.Close();
		}

		if (convert)
		{
			StreamWriter writer = new StreamWriter(path, false, utf8);
			writer.Write(fileText);
			writer.Close();
		}
	}
}
