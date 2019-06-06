using System;
using System.Runtime.Serialization;
using System.Reflection;

public delegate void TestFixtureRunFinishedDelegate(string testRunName, bool passed);

public class MainClass
{
        public static void DoTest(string testRunName, bool passed)
        {
                Console.WriteLine("DoTest, '{0}', {1}", testRunName, passed);
        }

        public static void Main()
        {
                AppDomain appDomain = AppDomain.CreateDomain ("Foo");
                appDomain.SetData("TheMethod", new TestFixtureRunFinishedDelegate(DoTest));
                appDomain.DoCallBack (new CrossAppDomainDelegate (CallBack));
                Console.WriteLine ("done");
        }

        public static void CallBack ()
        {
                Console.WriteLine (AppDomain.CurrentDomain.FriendlyName);
                (AppDomain.CurrentDomain.GetData("TheMethod") as TestFixtureRunFinishedDelegate)("Hello, World", true);
        }
}
