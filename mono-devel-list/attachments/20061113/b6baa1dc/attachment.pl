using System;
using System.Runtime.Serialization;
using System.Reflection;

public class MainClass
{
        public static void Main()
        {
                AppDomain appDomain = AppDomain.CreateDomain ("Foo");
                appDomain.DoCallBack (new CrossAppDomainDelegate (CallBack));

                GetData (appDomain, "key1");
                GetData (appDomain, "key2");
                GetData (appDomain, "key3");

                Console.WriteLine ("done");
        }

        static void GetData(AppDomain dom, string key)
        {
                try {
                        object o = dom.GetData (key);
                        if (o == null) Console.WriteLine ("{0} is null", key);
                } catch (SerializationException) {
                        Console.WriteLine ("{0} failed", key);
                }
        }
                

        public static void CallBack ()
        {
                Console.WriteLine (AppDomain.CurrentDomain.FriendlyName);
                AppDomain.CurrentDomain.SetData ("key1", new MyObject ());
                AppDomain.CurrentDomain.SetData ("key2", new MySerObject ());
                AppDomain.CurrentDomain.SetData ("key3", new MyMbrObject ());
        }
}

public class MyObject
{
}

[Serializable]
public class MySerObject
{
}

public class MyMbrObject : MarshalByRefObject
{
}
