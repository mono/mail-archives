using System;
using System.IO;
using System.Text;

class Latin1ToUtf8
{
	static Encoding utf8 = new UTF8Encoding(false, true);
	static Encoding latin1 = Encoding.GetEncoding(28591);

	static void Main(string[] args)
	{
		if (args.Length == 0 || !File.Exists(Path.Combine(args[0], "all.sln")))
		{
			Console.WriteLine("Usage: Latin1ToUtf8 <path-to-vbnc>");
			return;
		}

		ConvertDir(args[0]);
		Console.WriteLine("Done.");
	}

	static void ConvertDir(string path)
	{
		string[] dirs = Directory.GetDirectories(path);
		for (int i = 0; i < dirs.Length; i++)
			ConvertDir(Path.Combine(path, dirs[i]));

		string[] files = Directory.GetFiles(path, "*.vb");
		for (int i = 0; i < files.Length; i++)
			ConvertFile(Path.Combine(path, files[i]));
	}

	static unsafe void ConvertFile(string path)
	{
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
			reader = new StreamReader(path, utf8, false);
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

		if (fileText.IndexOf('\uFEFF') != -1)
			Console.WriteLine("Embedded BOM: " + path);
		if (fileText.IndexOf("\u00EF\u00BB\u00BF") != -1)
			Console.WriteLine("Embedded UTF-8 BOM: " + path);

		if (convert)
		{
			StreamWriter writer = new StreamWriter(path, false, utf8);
			writer.Write(fileText);
			writer.Close();
		}
	}
}
