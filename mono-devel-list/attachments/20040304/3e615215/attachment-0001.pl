using System;
using System.CodeDom;
using System.CodeDom.Compiler;
using System.Collections.Specialized;
using System.Globalization;
using System.IO;
using System.Reflection;

class A
{
    public A()
    {
        Console.WriteLine("creating A...");
    }
    
    ~A()
    {
        Console.WriteLine("finalizing A...");
        for (int i = 0; i < 10000; ++i)
        {
            Console.WriteLine("{0}", i);
            System.Threading.Thread.Sleep(100);
        }
        Console.WriteLine("finalized A.");
    }
    
    public static void Main()
    {
        AppDomain newDomain = AppDomain.CreateDomain("TypeGatheringDomain", AppDomain.CurrentDomain.Evidence, new AppDomainSetup());
        TypedValueGatherer typedValueGatherer = (TypedValueGatherer) 
            newDomain.CreateInstanceAndUnwrap(
                    typeof(TypedValueGatherer).Assembly.FullName, 
                    typeof(TypedValueGatherer).FullName, false, BindingFlags.Public | BindingFlags.Instance, 
                    null, new object[0], CultureInfo.InvariantCulture, new object[0], 
                    AppDomain.CurrentDomain.Evidence);

        object testValue = typedValueGatherer.GetTypedValue();
        Console.WriteLine("testValue: {0}", testValue);
        // unload newly created AppDomain
        Console.WriteLine("unloading...");
        AppDomain.Unload(newDomain);
        Console.WriteLine("unloaded.");
    }
    
    private class TypedValueGatherer : MarshalByRefObject {
        public object GetTypedValue() {
            A a = new A();
            return 3;
        }
    }
}
