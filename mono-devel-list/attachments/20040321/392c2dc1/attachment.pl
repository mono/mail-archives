
using System;
using System.Threading;

class Count
{
    static int x = 0;
    
    public static int Next()
    {
        lock(typeof(Count))
        {
            x++;
            return x;
        }
    }
}

class A
{
    public static int f1;
    public static int f2;
    public static int initOrder;
    public static String initThread;

    static A()
    {
        initOrder = Count.Next();
        initThread = Thread.CurrentThread.Name;
        f1 = 1;
        f2 = 2;
    }
}

class B
{
    public static int f1;
    public static int f2;
    public static int initOrder;
    public static String initThread;


    static B()
    {
        initOrder = Count.Next();
        initThread = Thread.CurrentThread.Name;
        f1 = 3;
        f2 = 4;
    }
}

class AB
{
    public static int f1;
    public static int initOrder;
    public static String initThread;


    static AB()
    {
        initOrder = Count.Next();
        initThread = Thread.CurrentThread.Name;
        int x = A.f1;
        Thread.Sleep(100);
        f1 = x + B.f2;
    }
}

class BA
{
    public static int f1;
    public static int initOrder;
    public static String initThread;


    static BA()
    {
        initOrder = Count.Next();
        initThread = Thread.CurrentThread.Name;
        int x = B.f1;
        f1 = x + A.f2;
    }
}

class Test
{
    static void t1()
    {
        Console.WriteLine(AB.f1);
    }
    static void t2()
    {
        Console.WriteLine(BA.f1);
    }
    static public void Main()
    {
        Thread thread1 = new Thread(new ThreadStart(t1));
        Thread thread2 = new Thread(new ThreadStart(t2));
        Thread thread3 = new Thread(new ThreadStart(t1));
        thread1.Name = "Thread1";
        thread2.Name = "Thread2";
        thread3.Name = "Thread3";
        thread1.Start();
        thread2.Start();
        thread3.Start();
        thread1.Join();
        thread2.Join();
        thread3.Join();
        Console.WriteLine("A: " + A.initOrder + " " + A.initThread);
        Console.WriteLine("B: " + B.initOrder + " " + B.initThread);
        Console.WriteLine("AB: " + AB.initOrder + " " + AB.initThread);
        Console.WriteLine("BA: " + BA.initOrder + " " + BA.initThread);
    }
}
