Index: Timer.cs
===================================================================
--- Timer.cs	(revision 46470)
+++ Timer.cs	(working copy)
@@ -29,122 +29,79 @@
 //
 
 using System.Runtime.InteropServices;
+using System.Collections;
 
 namespace System.Threading
 {
+
 #if NET_2_0
 	[ComVisible (true)]
 #endif
 	public sealed class Timer : MarshalByRefObject, IDisposable
 	{
-		sealed class Runner : MarshalByRefObject
-		{
-			ManualResetEvent wait;
-			AutoResetEvent start_event;
-			TimerCallback callback;
-			object state;
-			int dueTime;
-			int period;
-			bool disposed;
-			bool aborted;
 
-			public Runner (TimerCallback callback, object state, AutoResetEvent start_event)
-			{
-				this.callback = callback;
-				this.state = state;
-				this.start_event = start_event;
-				this.wait = new ManualResetEvent (false);
-			}
 
-			public int DueTime {
-				get { return dueTime; }
-				set { dueTime = value; }
-			}
+		 internal class TimerTask
+                 {
+                        internal TimerCallback timerCallback;
+                        internal object state;
+                        internal int dueTime;
+                        internal int period;
+                        internal DateTime lastSignalledTime;
+                        internal Timer timer;
+			internal bool triggered; 
+                                                                                                    
+                                                                                                    
+                                                                                                    
+                        public TimerTask(TimerCallback timercallback, object state, int dueTime, int period, Timer timer)
+                        {
+                                                                                                    
+                                this.timerCallback = timercallback;
+                                this.state = state;
+                                this.dueTime = dueTime;
+                                this.period = period;
+                                this.timer = timer;
+        	                this.lastSignalledTime = DateTime.UtcNow; //we are storing now, even                                                                  
+		 
+	    					// though we have never signalled this :)
+				this.triggered = false;
+                        }
 
-			public int Period {
-				get { return period; }
-				set { period = value == 0 ? Timeout.Infinite : value; }
-			}
 
-			bool WaitForDueTime ()
+			internal void Callback()
 			{
-				if (dueTime > 0) {
-					bool signaled;
-					do {
-						wait.Reset ();
-						signaled = wait.WaitOne (dueTime, false);
-					} while (signaled == true && !disposed && !aborted);
-
-					if (!signaled)
-						callback (state);
-
-					if (disposed)
-						return false;
-				}
-				else
-					callback (state);
-
-				return true;
-			}
-
-			public void Abort ()
+				this.lastSignalledTime = DateTime.UtcNow;
+				timerCallback(state);
+			}	
+                                                                 
+			internal bool IsDue()
 			{
-				lock (this) {
-					aborted = true;
-					wait.Set ();
-				}
-			}
-			
-			public void Dispose ()
-			{
-				lock (this) {
-					disposed = true;
-					Abort ();
-				}
-			}
+				
+				int diff = FindTimeDiff(this.lastSignalledTime);
+				if ((triggered) && (this.period>0))
+                                {
+                                	if ( diff > this.period)
+                                        	return true;
+                                }
+                                else  if (diff > this.dueTime)
+                                {
+	                	        this.triggered = true;
+					if (this.period == 0)
+						timers.Remove(this); //todo:can this be done										 //somewhere else?
+                                         return true;
+                                 }
+				 return false;
+			}					
+		
+                                   
+                }
 
-			public void Start ()
-			{
-				while (start_event.WaitOne () && !disposed) {
-					aborted = false;
+		private static Object lockObj = new Object();
+                private static ArrayList timers = null;
+                private static bool initialized = false;
+                private static bool triggeredOnce = false;
+                private static Thread t;
 
-					if (dueTime == Timeout.Infinite)
-						continue;
-
-					if (!WaitForDueTime ())
-						return;
-
-					if (aborted || (period == Timeout.Infinite))
-						continue;
-
-					bool signaled = false;
-					while (true) {
-						if (disposed)
-							return;
-
-						if (aborted)
-							break;
-
-						wait.Reset ();
-						signaled = wait.WaitOne (period, false);
-
-						if (aborted)
-							break;
-
-						if (!signaled) {
-							callback (state);
-						} else if (!WaitForDueTime ()) {
-							return;
-						}
-					}
-				}
-			}
-		}
-
-		Runner runner;
-		AutoResetEvent start_event;
-		Thread t;
-
 		public Timer (TimerCallback callback, object state, int dueTime, int period)
 		{
 			if (dueTime < -1)
@@ -153,7 +110,11 @@
 			if (period < -1)
 				throw new ArgumentOutOfRangeException ("period");
 
-			Init (callback, state, dueTime, period);
+                        if (initialized)
+                                Add(callback,state,dueTime,period,this);
+                         else
+                                Initialize(callback,state,dueTime,period);
+
 		}
 
 		public Timer (TimerCallback callback, object state, long dueTime, long period)
@@ -164,7 +125,11 @@
 			if (period < -1)
 				throw new ArgumentOutOfRangeException ("period");
 
-			Init (callback, state, (int) dueTime, (int) period);
+			if (initialized)
+                                Add(callback,state,(int)dueTime,(int)period,this);
+                         else
+                                Initialize(callback,state,(int)dueTime,(int)period);
+
 		}
 
 		public Timer (TimerCallback callback, object state, TimeSpan dueTime, TimeSpan period)
@@ -181,20 +146,38 @@
 #if NET_2_0
 		public Timer (TimerCallback callback)
 		{
-			Init (callback, this, Timeout.Infinite, Timeout.Infinite);
+			if (initialized)
+                                Add(callback,state,(int)dueTime,(int)period,this);
+                         else
+                                Initialize(callback,state,(int)dueTime,(int)period);
 		}
 #endif
 
-		void Init (TimerCallback callback, object state, int dueTime, int period)
+
+		private static void TimerLoop()
 		{
-			start_event = new AutoResetEvent (false);
-			runner = new Runner (callback, state, start_event);
-			Change (dueTime, period);
-			t = new Thread (new ThreadStart (runner.Start));
-			t.IsBackground = true;
-			t.Start ();
+			while (true)
+			{
+				ArrayList timersToTrigger = new ArrayList();
+				lock(lockObj)
+				{
+					int timeToWait = GetTimeToNextEvent();
+					if (timeToWait == -1)
+						return;// handle with some sleep..
+					Monitor.Wait(lockObj,timeToWait);
+					foreach(TimerTask timerTask in timers)
+						if (timerTask.IsDue())
+							timersToTrigger.Add(timerTask);
+				}
+				foreach(TimerTask task in timersToTrigger)
+						task.Callback();
+				if (timersToTrigger.Count > 0)
+						triggeredOnce = true;
+				timersToTrigger.Clear();
+			}
 		}
 
+
 		public bool Change (int dueTime, int period)
 		{
 			if (dueTime < -1)
@@ -203,17 +186,62 @@
 			if (period < -1)
 				throw new ArgumentOutOfRangeException ("period");
 
-			if (runner == null)
-				return false;
+			Timer thisTimer = this;				
+			for (int i=0;i<timers.Count;i++)
+			{
+				//find my timer.
+				TimerTask timerTask = (TimerTask)timers[i];
+				if (timerTask.timer == thisTimer)
+				{
+					lock(lockObj)
+					{
+						timerTask.dueTime = dueTime;
+						timerTask.period = period;
+						Monitor.Pulse(lockObj);									    }	
+					return true;	
+				}
+				
+			}
+			return false;
+		}
 
-			start_event.Reset ();
-			runner.Abort ();
-			runner.DueTime = dueTime;
-			runner.Period = period;
-			start_event.Set ();
-			return true;
+		private static int FindMinPeriod()
+		{
+			// find the minimum period out of all the elements in the timers arraylist.
+			TimerTask timerTask = (TimerTask)timers[0];
+			int minPeriod = timerTask.period;
+			for (int i=1;i<timers.Count;i++)
+			{
+				 timerTask = (TimerTask)timers[i];
+				if (timerTask.period < minPeriod)
+					minPeriod = timerTask.period;
+			}
+			return minPeriod;
 		}
 
+
+		private static int FindMinDueTime()
+		{
+		
+			TimerTask timerTask = (TimerTask)timers[0];
+			int diff = FindTimeDiff(timerTask.lastSignalledTime);
+			int minDueTime = timerTask.dueTime -diff;
+			for(int i=1;i<timers.Count;i++)
+			{
+				timerTask = (TimerTask)timers[i];
+				diff = FindTimeDiff(timerTask.lastSignalledTime);
+				if (minDueTime > (timerTask.dueTime -diff))
+					minDueTime = timerTask.dueTime;
+			}
+			return minDueTime;
+		}
+
+		private static int FindTimeDiff( DateTime time)
+		{
+			return((int)((TimeSpan)(DateTime.UtcNow-time)).TotalMilliseconds);
+		}
+		
+
 		public bool Change (long dueTime, long period)
 		{
 			if(dueTime > 4294967294)
@@ -242,17 +270,82 @@
 			return Change ((int) dueTime, (int) period);
 		}
 
+
+		private void Add(TimerCallback callback, object state, int dueTime, int period, Timer timer)
+		{
+			lock(lockObj)
+			{
+				timers.Add(new TimerTask(callback,state,dueTime,period,timer));
+				Monitor.Pulse(lockObj);		   		
+		    	}
+		}
+
+		private  void Initialize(TimerCallback callback, object state, int dueTime, int period)
+		{
+			lock(lockObj)
+			{
+				timers = new ArrayList();
+				timers.Add(new TimerTask(callback,state,dueTime,period,this));
+				t = new Thread (new ThreadStart (Timer.TimerLoop));
+				t.IsBackground = true;
+				t.Start ();
+				initialized = true;
+			}
+		}
+
+		private static int GetTimeToNextEvent()
+		{
+			int time = 0;
+			if (timers.Count == 0)
+				return -1; // all timers are gone!
+			if (!triggeredOnce)
+				time = FindMinDueTime();
+			else
+				time = FindMinPeriod();
+			return time;	
+		}
+	
+		
 		public void Dispose ()
 		{
-			if (t != null && t.IsAlive) {
-				if (t != Thread.CurrentThread)
-					t.Abort ();
-				t = null;
+			Timer timer = this;
+			lock(lockObj)
+			{
+				if (timers.Count == 1)
+				{
+					// i am the last timer to be disposed.
+					if (t != null && t.IsAlive) 
+						t = null;
+					timers = null;
+					initialized = false;
+					triggeredOnce = false;
+					
+				}
+				else
+				{
+					// then there are other timers.
+					TimerTask timerTask = GetTimerTask(timer);
+					timers.Remove(timerTask);								  	    lock (lockObj)
+					{
+						Monitor.Pulse(lockObj);
+					}	
+				  }	
 			}
-			runner.Dispose ();
-			runner = null;
-			GC.SuppressFinalize (this);
+	
 		}
+		
+		private TimerTask GetTimerTask(Timer timer)
+		{
+			
+			TimerTask timerTask;
+			for (int i=0;i<timers.Count;i++)
+			{
+				timerTask = (TimerTask)timers[i];
+				if (timerTask.timer == timer)
+					return timerTask;
+			}
+			return null;
+		}
 
 		public bool Dispose (WaitHandle notifyObject)
 		{
@@ -261,14 +354,6 @@
 			return true;
 		}
 
-		~Timer ()
-		{
-			if (t != null && t.IsAlive)
-				t.Abort ();
-
-			if (runner != null)
-				runner.Abort ();
-		}
 	}
 }
 
Index: ChangeLog
===================================================================
--- ChangeLog	(revision 46470)
+++ ChangeLog	(working copy)
@@ -1,3 +1,9 @@
+2005-06-14 Umadevi S <sumadevi@novell.com>
+	
+	* Timer.cs 
+	- Spwaning a single thread for any number of timers.
+	Thanks to Ben for  his comments to get the initial patch reviewed.	
+
 2005-06-07 Gonzalo Paniagua Javier <gonzalo@ximian.com>
 
 	* Thread.cs: check that the culture is valid for formatting
