using System;
using System.Threading;
using System.Collections;

namespace MonoThreadingTest
{
	public class WorkerThread
	{
		private AutoResetEvent autoEvent = new AutoResetEvent(false);
		private Thread thread = null;
		private int timeout = 0;
		private int index = -1;
		public WaitHandle MyEvent
		{
			get { return autoEvent; }
		}

		public WorkerThread(int index, int timeout)
		{
			this.index = index;
			this.timeout = timeout;
			thread = new Thread(new ThreadStart(ThreadCallback));
			thread.Start();
		}


		private void ThreadCallback()
		{
			Thread.Sleep(timeout);
			autoEvent.Set();
		}

		static void Main(string[] args)
		{
			int threadCount = 64;

			Random rd = new Random();

			WaitHandle[] handles = new WaitHandle[threadCount];
			for(int nIndex = 0; nIndex < threadCount; nIndex++)
			{
				WorkerThread wt = new WorkerThread(nIndex, 1000 * rd.Next(1, 5));
				handles[nIndex] = wt.MyEvent;
			}
			
			ArrayList results = new ArrayList();

			for(int nIndex = 0; nIndex < threadCount; nIndex++)
			{
				int nWaitAnyResult = WaitHandle.WaitAny(handles);
				System.Console.WriteLine("WaitAny Result: " + nWaitAnyResult);
				results.Add(nWaitAnyResult);
			}

			bool bSuccess = (results.Count == threadCount);
			if(bSuccess)
			{
				for(int nIndex = 0; nIndex < threadCount; nIndex++)
				{
					if(!results.Contains(nIndex))
					{
						bSuccess = false;
						break;
					}
				}
			}

			if(bSuccess)
			{
				System.Console.WriteLine("TEST DONE - SUCCESS!");
			}
			else
			{
				System.Diagnostics.Debug.Assert(false, "TEST FAILED!");
				System.Console.WriteLine("TEST FAILED!");
			}
	
		}
	}
}
