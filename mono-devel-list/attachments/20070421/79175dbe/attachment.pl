using System;
using System.Threading;

public class Test {
	public static void Main(string[] arg) {
		for (int i = 0; i < 10; i++)
			new Thread(new Test(i).Runner).Start();
	}

	int tid;
	Timer timer;

	public Test(int tid) { this.tid = tid; }

	public void Runner() {
		Console.Error.WriteLine("Thread {0} Starting", tid);
	
		timer = new Timer(Callback, null, 50, 50);
		//timer.Dispose(); // MySQL disposes right away in the usual case

		Console.Error.WriteLine("Thread {0} Finished", tid);
	}

	void Callback(object state) {
		Console.Error.WriteLine("Callback on Thread: {0}", tid);
		timer.Dispose();
	}
}
