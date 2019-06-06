using System;

class A
{
    public A()
    {
        Console.WriteLine("creating A...");
    }
    
    ~A()
    {
        Console.WriteLine("finalizing A...");
        for (int i = 0; i < 100; ++i)
        {
            Console.WriteLine("{0}", i);
            System.Threading.Thread.Sleep(100);
        }
        Console.WriteLine("finalized A.");
    }
    
    public static void Main()
    {
        A a = new A();
    }
}
