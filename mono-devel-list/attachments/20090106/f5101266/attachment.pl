using System;
using System.Collections.Generic;
using System.Text;
using System.Reflection;
using System.Runtime.InteropServices;
using System.Diagnostics;


namespace helloworld_cs
{
    class Program
    {

        static IntPtr getBaseAddress()
        {
            IntPtr baseAddress = new IntPtr();
            ProcessModuleCollection modules = Process.GetCurrentProcess().Modules;

            Assembly assembly = Assembly.GetExecutingAssembly();

            bool foundBaseAddress = false;
            foreach (ProcessModule procModule in modules)
            {
                if (procModule.FileName.Equals(assembly.Location))
                {
                    Console.WriteLine("module: " + procModule.FileName + " | assembly: " + assembly.Location);
                    baseAddress = procModule.BaseAddress;
                    foundBaseAddress = true;
                }
            }

            if (!foundBaseAddress)
                throw new ApplicationException(string.Format("Failed to find assembly: {0}", assembly.Location));

            return baseAddress;
        }


        unsafe static void Main(string[] args)
        {
         
            IntPtr baseAddr = getBaseAddress();

            for (int offset = 0x211c; offset < 0x2169; offset++)
            {
            
                    Console.WriteLine("Addr = {0:X}\tByte = {1:X}",
                         baseAddr.ToInt32() + offset, Marshal.ReadByte(new IntPtr(baseAddr.ToInt32() + offset)));
            }

        }
    }

}

