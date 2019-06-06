// Bug #56300

using System;
using System.Collections;

namespace Test 
{
	public interface IIndexer { object this[int index] { get; set; } }
	
	public class Test : IIndexer
	{
		object[] InnerList;
		object IIndexer.this[int index] { 
			get { return InnerList[index]; }
			set { InnerList[index] = value; }
		}

		public static void Main() {
			foreach (Attribute a in typeof(Test).GetCustomAttributes(false))
				if (a is System.Reflection.DefaultMemberAttribute)
					throw new Exception("Class 'Test' has a DefaultMemberAttribute");
		}
	}
}
