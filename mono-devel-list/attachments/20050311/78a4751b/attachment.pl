using System;
using System.Reflection;
using System.Reflection.Emit;

public class Test
{
	public static void Main ()
	{
		AssemblyName an = new AssemblyName ();
		an.Name = "hogeasm";
		AssemblyBuilder ab = 
			AppDomain.CurrentDomain.DefineDynamicAssembly (an,
				AssemblyBuilderAccess.Save);
		ModuleBuilder mb = ab.DefineDynamicModule ("hogemod");
		TypeBuilder tb = mb.DefineType ("MyInterface",
			TypeAttributes.Interface |
			TypeAttributes.Public |
			TypeAttributes.Abstract);
		tb.DefineEvent ("MyEvent", EventAttributes.None,
			typeof (EventHandler));

		Console.WriteLine (tb.CreateType () != tb);
		Console.WriteLine (tb.CreateType () != tb);
	}
}
