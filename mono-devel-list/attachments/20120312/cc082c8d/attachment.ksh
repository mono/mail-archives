using System;
using System.IO;
using System.Text;

namespace UnicodeFileRepro
{
    class Program
    {
        static void Main(string[] args)
        {
            const string logName = "unicode-file-repro.out";
            const string UnicodeDirName = "ベートーヴェン";
            if (args.Length == 1 && (args[0].Contains("?") || args[0].Contains("help")))
            {
                PrintUsage();
                return;
            }

            bool saveReproDir = args.Length == 1 && args[0] == "savereprodir";

            string rootPath = Path.Combine(Path.GetTempPath(), Guid.NewGuid().ToString());
            Console.WriteLine("Performing test in '{0}'.  save this dir: {1}", rootPath, saveReproDir);

            try
            {
                using (StreamWriter sw = new StreamWriter(logName))
                {
                    DirectoryInfo info = Directory.CreateDirectory(rootPath);

                    // create a sub folder under the root dir that has unicode chars
                    Directory.CreateDirectory(Path.Combine(rootPath, UnicodeDirName));

                    // retrieve the file system infos for the root dir
                    FileSystemInfo[] infos = info.GetFileSystemInfos();
                    if (!infos[0].Name.Equals(UnicodeDirName, StringComparison.OrdinalIgnoreCase))
                    {
                        // The sub folder retrieved from GetFileSystemInfos does not have the same
                        // name that it was created with.  Log the error.
                        byte[] expectedBytes = Encoding.Unicode.GetBytes(UnicodeDirName);
                        byte[] actualBytes = Encoding.Unicode.GetBytes(infos[0].Name);
                        string errorString = String.Format(
                           "Sub folder name retrieved from file system does not match. expected: '{0}' ({1}), actual: '{2}' ({3})",
                           UnicodeDirName,
                           ByteArrayToString(expectedBytes),
                           infos[0].Name,
                           ByteArrayToString(actualBytes));
                        sw.WriteLine(errorString);
                        Console.WriteLine("Failed to create sub folder with unicode chars and then retrieve sub folder with same name");
                        Console.WriteLine("Check '{0}' for details", logName);
                    }
                    else
                    {
                        Console.WriteLine("Sub folder retrieved successfully");
                    }
                }
            }
            finally
            {
                if (!saveReproDir && Directory.Exists(rootPath)) { Directory.Delete(rootPath, true); }
            }
        }

        public static string ByteArrayToString(byte[] bytes)
        {
            StringBuilder s = new StringBuilder();

            for (int i = 0; i < bytes.Length; i++)
            {
                s.Append(bytes[i].ToString("X2"));
            }

            return s.ToString();
        }

        public static void PrintUsage()
        {
            Console.WriteLine(
                "Attempts to create a subdirectory underneath the temp dir that contains unicode chars in its name." +
                "Then GetFileSystemInfos() is called on the temp dir.  The retrieved FileSystemInfo's name is compared " +
                "to the name it was created with and the results are printed and saved.");
            Console.WriteLine();
            Console.WriteLine(
                "Only 1 optional argument can be supplied, \"savereprodir\". If this is set then the temp dir " +
                "will not be deleted at the end of the program.");
        }
    }
}
