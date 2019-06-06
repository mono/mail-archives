using System;
using System.Collections;

namespace test
{
    class Program
    {
        static void Main(string[] args)
        {
            WaitForEnter();
        }

        private static void WaitForEnter()
        {
            Console.WriteLine("Command:");

            while (true)
            {
                Console.Write("> ");
                string line = Console.ReadLine();

                string[] args = line.Split(' ');

                if (args.Length <= 0) continue;

                switch (args[0].ToLower())
                {
                    case "exit": return;
                    
                    case "1": Case1(args); break;
                    
                    case "2": Case2(args); break;


                    case "mem":
                        Console.WriteLine("Memory now: {0}", GC.GetTotalMemory(false));
                        break;
                    case "gc":
                        Gcs(args);
                        break;
                    default:
                        Console.WriteLine("Unknown command");
                        break;
                }
            }
        }

        private static void Gcs(string[] args)
        {
            int loop = (args.Length == 2) ? Int32.Parse(args[1]) : 1;

            for (int i = 0; i < loop; ++i)
            {
                Console.WriteLine("Memory {1} now : {0}", GC.GetTotalMemory(false), i);
                Console.WriteLine("Memory {1} after GC: {0}", GC.GetTotalMemory(true), i);
            }
        }

        private const int OneMeg = 1024 * 1024;

        private static void Case1(string[] args)
        {
            int loop = (args.Length >= 2) ? Int32.Parse(args[1]) : 5;
            int size = (args.Length >= 3) ? Int32.Parse(args[2]) : 10 * OneMeg;

            ArrayList container = new ArrayList();

            for (int i = 0; i < loop; ++i)
            {
                int[] s1 = new int[size];

                for (int j = 0; j < size; ++j)
                {
                    s1[j] = j;
                }

                container.Add(s1);

                Console.Write("Iteration {0}, press enter for next", i);
                Console.ReadLine();
            }

            // Explicit in case it helps
            container = null;
        }

        private static void Case2(string[] args)
        {
            int loop = (args.Length >= 2) ? Int32.Parse(args[1]) : 5;
            int size = (args.Length >= 3) ? Int32.Parse(args[2]) : 10 * OneMeg;

            ArrayList container = new ArrayList();

            for (int i = 0; i < loop; ++i)
            {
                int[] s1 = new int[size];

                for (int j = 0; j < size; ++j)
                {
                    s1[j] = j;
                }

                container.Add(s1);

                Console.WriteLine("Iteration {0}", i);
            }

            // Explicit in case it helps
            container = null;
        }

        
    }
}
