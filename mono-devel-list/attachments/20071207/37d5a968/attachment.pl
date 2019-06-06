using System;
using System.Collections.Generic;
using System.Text;

namespace MonoSVN
{
    class Program
    {
        static void Main(string[] args)
        {
            System.IO.DriveInfo di = new System.IO.DriveInfo(args[0]);
            Console.WriteLine(di.DriveFormat);
            while (true) {
                Console.WriteLine("{0}\t{1}\t{2}", di.AvailableFreeSpace, di.TotalFreeSpace, di.TotalSize);
                System.Threading.Thread.Sleep(1000);
            }
        }
    }
}
namespace System {
    public class MonoTODOAttribute : Attribute
    {
        public MonoTODOAttribute(string description) { }
    }
}