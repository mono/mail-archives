using System;
using System.Threading;

namespace MonoThreadingTest
{
	public class ThreadTest
	{

		static void ThreadCallback()
		{
			Thread.GetNamedDataSlot("TEST_SEBAS");
		}

		static void Main(string[] args)
		{
			for(int nIndex = 0; nIndex < 64; nIndex++)
			{
				(new Thread(new ThreadStart(ThreadCallback))).Start();
			}

			Thread.Sleep(5000);
		}
	}
}
