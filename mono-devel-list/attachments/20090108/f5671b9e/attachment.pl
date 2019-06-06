using System;
using System.Reflection;
using System.Reflection.Emit;

public class MonoTest1
{
    static void Main()
    {
        try
        {
            ILTest();
        }
        catch (Exception e)
        {
            Console.WriteLine("Test1: Exception caught. Msg: " + e.Message+"  Type: "+e.GetType());
            Console.WriteLine("On the CLR Msg = SomeImportantMessgage");
            Console.WriteLine("On Mono,   Msg = nothing");
        }
    }

    public static void ILTest()
    {
        var constructor = typeof(ClassWithThrowingConstructor).GetConstructor(Type.EmptyTypes);
        var dm = new DynamicMethod(String.Empty, typeof(object), new[] { typeof(object[]) });
        
        ILGenerator il = dm.GetILGenerator();

        il.Emit(OpCodes.Newobj, constructor);
        il.Emit(OpCodes.Ret);

        var md = dm.CreateDelegate(typeof(MyDelegate)) as MyDelegate;
        md.Invoke(new object[0]);
    }

    public delegate object MyDelegate(params object[] arguments);

    public class ClassWithThrowingConstructor
    {
        public ClassWithThrowingConstructor()
        {
            throw new Exception("SomeImportantMessage");
        }
    }
}
