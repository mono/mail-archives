using System;
using System.Collections.Generic;

namespace TestConsole
{
    class Program
    {
        static void Main(string[] args)
        {
	  string str = null; 
	  
	  object[] methodArgs = new object[] { str };
	  
	  Program p = new Program();
	  p.GetType().GetMethod("TestMethod").Invoke(p, methodArgs);
	} 

	public Program()
	{
	}

	public void TestMethod(ref string str)
	{
          str = "test string";
	}
    }
}
