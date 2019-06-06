using System;

[test_188(11)]
namespace MCSDoc.Tests
{
	[AttributeUsage(AttributeTargets.All)]
	public class test_188Attribute : Attribute
	{
		private int x;

		public test_188Attribute(int x)
		{
			this.x = x;
		}

		public int X
		{
			get
			{
				return x;
			}
		}
	}

	[test_188(10)]
	public class test_188Class
	{
		public test_188Class()
		{
		}
	}
}