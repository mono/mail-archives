using System;
using System.IO;

class Program
{
	static void Main (string[] args)
	{
		if (args.Length != 1) {
			Console.Error.WriteLine ("glwt.exe topdir");
			return;
		}

		Recurse (new DirectoryInfo (args [0]));
	}

	static void Recurse (DirectoryInfo info)
	{
		try {
			foreach (FileInfo file in info.GetFiles ()) {
				try {
					File.GetLastWriteTimeUtc (file.FullName);
				} catch (ArgumentOutOfRangeException) {
					Console.WriteLine ("fix me: {0}", file.FullName);
				}
			}
		} catch (UnauthorizedAccessException) {
		} catch (IOException) {
		}

		try {
			foreach (DirectoryInfo child in info.GetDirectories ()) {
				Recurse (child);
			}
		} catch (UnauthorizedAccessException) {
		} catch (IOException) {
		}
	}
}
	
