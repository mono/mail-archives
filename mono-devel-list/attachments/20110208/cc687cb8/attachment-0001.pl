using System;
using System.IO;
using System.Text;
using System.Runtime.InteropServices;
using ProcImage;

namespace ProcImage
{
    [StructLayout(LayoutKind.Sequential, Pack=4)]
    public class ProcessImage
    {
        [MarshalAs(UnmanagedType.ByValArray, SizeConst = 6)] 
        public  int[] control;
    
        public byte bytedata;
       
        public Int16 worddata;
       
        public int intdata;
    
        public float floatdata;
    
        public bool booldata;
		// Array of unknown size causes SIGABRT in Mono
		public  string[] sigabort;
    }
}

    class Program
    {
		static IntPtr len = IntPtr.Zero;
        public static ProcessImage prc = new ProcessImage();
		public static ProcessImage prc2 = new ProcessImage();

        static void Main(string[] args)
        {
			Console.Write("Allocate Memory ...");
			len = Marshal.AllocHGlobal(Marshal.SizeOf(new ProcessImage().GetType()));
			Console.WriteLine(" done");
		
			Console.Write("Invoke PtrToStructure 1st...");
			prc = (ProcessImage)Marshal.PtrToStructure(len, typeof(ProcessImage));
			Console.WriteLine(" done");
		
			prc.sigabort = new string[2];
			prc.sigabort[0] = "Hallo";
			prc.sigabort[1] = "Test";
		
			Console.Write("Invoke StructureToPtr ...");
			Marshal.StructureToPtr(prc, len, false);
			Console.WriteLine(" done");
		
			Console.Write("Invoke PtrToStructure 2nd...");
			prc2 = (ProcessImage)Marshal.PtrToStructure(len, typeof(ProcessImage));
			Console.WriteLine(" done");
		
			Console.WriteLine(prc2.sigabort[1]);
        }
    }