using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using System.Runtime.Serialization.Formatters.Binary;
using System.Threading;
using System.Collections;

namespace TestApp
{
    class Program
    {
        static void Main(string[] args)
        {
            int num = 5000000;
            Hashtable table = new Hashtable();
            for (int i = 0; i < num; ++i)
            {
                Object obj = new Object();
                table.Add(obj, obj);
            }
            Console.WriteLine("Done");
            Thread.Sleep(5000);
        }
    }
}
