using System;

[test_21(11)]
namespace MCSDoc.Tests
{
	[AttributeUsage(AttributeTargets.All)]
	public class test_21Attribute : Attribute
	{
		private int x;

		public test_21Attribute(int x)
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

	[test_21(10)]
	public class test_21Class
	{
		public test_21Class()
		{
		}
	}
}