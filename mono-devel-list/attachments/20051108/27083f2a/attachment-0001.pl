using System;
using System.Xml;
using System.Xml.Schema;

public class Test
{
	public static void Main ()
	{
		Console.WriteLine (typeof (MyEnum).IsSerializable);
		foreach (object o in typeof (MyEnum).GetCustomAttributes (false))
			Console.WriteLine (o.GetType ());
		Console.WriteLine (typeof (XmlSchemaInference).IsSerializable);
		foreach (object o in typeof (XmlSchemaInference).GetCustomAttributes (true))
			Console.WriteLine (o.GetType ());
	}
}

public enum MyEnum
{
	Foo
}
