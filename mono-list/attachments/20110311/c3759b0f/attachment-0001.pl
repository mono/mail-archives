//
// Create some files in the current directory:
// $ touch normal readonly .hidden
// $ chmod -w readonly
//
// The following program should show all of them.
// $ dmcs Program.cs
// $ mono ./Program.exe
//

namespace DirectoryEnumerateFilesTest
{
    using System;
    using System.IO;

    internal static class Program
    {
        internal static void Main(string[] args)
        {
            try
            {
                string path = ".";
                string pattern = "*.*";
                foreach (string item in Directory.EnumerateFiles(path, pattern))
                {
                    Console.WriteLine(item);
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex);
            }
        }
    }
}
