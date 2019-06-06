using System;
using System.Collections.Generic;

namespace MonoEmbed
{
	public class Test
	{
		public List<int> ListField;

		static void Main ()
		{
		}

		public static void Dump (List<int> list)
		{
			Console.WriteLine (list);
			Console.WriteLine (list.Count);
		}
	}
}
