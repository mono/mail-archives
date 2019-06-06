using System;
using System.Collections;

namespace Blech
{

public struct ValueTypeWithRefMember
{
	public string s;
}

public struct ValueType
{
	public ValueTypeWithRefMember nest;
	public int i;
	public string name;
}

public class Runner
{
	public static void Main()
	{
		ArrayList values = new ArrayList();
		for (int i = 0; i < 100; i++)
		{
			ValueType vt;
			vt.nest.s = i.ToString();
			vt.i = i;
			vt.name = String.Format("this is instance {0}", i);
			values.Add(vt);
		}
		GC.Collect();
		foreach (ValueType vt in values)
		{
			Console.WriteLine("nested == '{0}', name == {1}", vt.nest.s, vt.name);
			int i = -1;
			try
			{
				i = Int32.Parse(vt.nest.s);
			}
			catch (FormatException) { }
			if (i != vt.i)
			{
				Console.WriteLine("FAILED");
				return;
			}
		}
		Console.WriteLine("PASSED");
	}
}

//===========================================================================
}

