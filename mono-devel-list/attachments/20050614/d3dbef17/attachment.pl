Index: Timer.cs
===================================================================
--- Timer.cs	(revision 45932)
+++ Timer.cs	(working copy)
@@ -29,26 +29,31 @@
 //
 
 using System.Runtime.InteropServices;
+using System.Collections;
 
 namespace System.Threading
 {
+
+	 public delegate void RunnerCallback(object state);
+
 #if NET_2_0
 	[ComVisible (true)]
 #endif
 	public sealed class Timer : MarshalByRefObject, IDisposable
 	{
+		
 		sealed class Runner : MarshalByRefObject
 		{
 			ManualResetEvent wait;
 			AutoResetEvent start_event;
-			TimerCallback callback;
+			RunnerCallback callback;
 			object state;
 			int dueTime;
 			int period;
 			bool disposed;
 			bool aborted;
 
-			public Runner (TimerCallback callback, object state, AutoResetEvent start_event)
+			public Runner (RunnerCallback callback, object state, AutoResetEvent start_event)
 			{
 				this.callback = callback;
 				this.state = state;
@@ -141,10 +146,48 @@
 			}
 		}
 
-		Runner runner;
-		AutoResetEvent start_event;
-		Thread t;
+		 internal struct TimerObject
+                 {
+                        internal TimerCallback timerCallback;
+                        internal object state;
+                        internal int dueTime;
+                        internal int period;
+                        internal DateTime lastSignalledTime;
+                        internal int uniqueid; //timer hashcode (of the mytimer class)
+                                                                                                    
+                                                                                                    
+                                                                                                    
+                        public TimerObject(TimerCallback timercallback, object state, int dueTime, int period, int id)
+                        {
+                                                                                                    
+                                this.timerCallback = timercallback;
+                                this.state = state;
+                                this.dueTime = dueTime;
+                                this.period = period;
+                                this.uniqueid = id;
+                                this.lastSignalledTime = DateTime.Now; // we are storing now, even                                                                  
+				       					// though we have never signalled this :)
+                        }
+                                                                                                    
+                }
 
+
+
+		private static Mutex mut = new Mutex();
+                private static ArrayList timers = null;
+                private bool initialized = false;
+                private static bool triggeredOnce = false;
+                private int minDueTime = 0;
+                private int minPeriod = 0;
+                private int minDueTimeUniqueid;
+                private int minPeriodUniqueid;
+                private AutoResetEvent start_event      ;
+                private Runner runner;
+                private Thread t;
+
+
+
+
 		public Timer (TimerCallback callback, object state, int dueTime, int period)
 		{
 			if (dueTime < -1)
@@ -153,7 +196,11 @@
 			if (period < -1)
 				throw new ArgumentOutOfRangeException ("period");
 
-			Init (callback, state, dueTime, period);
+                        if (initialized)
+                                Add(callback,state,dueTime,period,this.GetHashCode());
+                         else
+                                Initialize(callback,state,dueTime,period);
+
 		}
 
 		public Timer (TimerCallback callback, object state, long dueTime, long period)
@@ -164,7 +211,11 @@
 			if (period < -1)
 				throw new ArgumentOutOfRangeException ("period");
 
-			Init (callback, state, (int) dueTime, (int) period);
+			if (initialized)
+                                Add(callback,state,(int)dueTime,(int)period,this.GetHashCode());
+                         else
+                                Initialize(callback,state,(int)dueTime,(int)period);
+
 		}
 
 		public Timer (TimerCallback callback, object state, TimeSpan dueTime, TimeSpan period)
@@ -181,20 +232,12 @@
 #if NET_2_0
 		public Timer (TimerCallback callback)
 		{
-			Init (callback, this, Timeout.Infinite, Timeout.Infinite);
+			if (initialized)
+                                Add(callback,state,(int)dueTime,(int)period,this.GetHashCode());
+                         else
+                                Initialize(callback,state,(int)dueTime,(int)period);
 		}
 #endif
-
-		void Init (TimerCallback callback, object state, int dueTime, int period)
-		{
-			start_event = new AutoResetEvent (false);
-			runner = new Runner (callback, state, start_event);
-			Change (dueTime, period);
-			t = new Thread (new ThreadStart (runner.Start));
-			t.IsBackground = true;
-			t.Start ();
-		}
-
 		public bool Change (int dueTime, int period)
 		{
 			if (dueTime < -1)
@@ -205,15 +248,101 @@
 
 			if (runner == null)
 				return false;
+			
+			int hashCode = this.GetHashCode();				
+			for (int i=0;i<timers.Count;i++)
+			{
+				//find my timer.
+				TimerObject timerObject = (TimerObject)timers[i];
+				if (timerObject.uniqueid == hashCode)
+				{
+					// looks like the easiest thing would be to remove and reinsert the 
+					// the element :) - TODO:  can work out a smarter way later
+					// if this was the minduetime or the minperiod and the new value is higher or lower
+					// we may have to refind a new mindueTime and new minPeriod.
+					
+					timerObject.dueTime = dueTime;
+					timerObject.period = period;
+					
+					if  ((timerObject.uniqueid == minDueTimeUniqueid) &&(!triggeredOnce))
+						{
+							mut.WaitOne();
+							start_event.Reset ();
+							runner.Abort ();
+							if (dueTime < minDueTime)
+							{
+									runner.DueTime = dueTime;
+									minDueTime = dueTime;
+							}
+							else
+									runner.DueTime = FindMinDueTime();
+							start_event.Set ();
+							mut.ReleaseMutex();
+						}
+					if (timerObject.uniqueid == minPeriodUniqueid)
+					{
+						mut.WaitOne();
+						start_event.Reset ();
+						runner.Abort ();
+						if (period < minPeriod)
+						{
+								runner.Period = period;
+								minPeriod = period;
+						}
+						else
+								runner.Period = FindMinPeriod();
+						start_event.Set ();
+						mut.ReleaseMutex();
+					}
+					// note : the above is not very optimized. reasons
+					// 1. we are triggering the runner twice. can make it once!
+					// 2. there can be another one with the same period but ths is the uniquieid used!
+					// 3. the add will not trigger a change again!
+							
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
+		private int FindMinPeriod()
+		{
+			// find the minimum period out of all the elements in the timers arraylist.
+			for (int i=0;i<timers.Count;i++)
+			{
+				TimerObject timerObject = (TimerObject)timers[i];
+				if (timerObject.period < minPeriod)
+				{
+					minPeriod = timerObject.period;
+					minPeriodUniqueid = timerObject.uniqueid;
+				}
+			}
+			return minPeriod;
 		}
 
+
+		private int FindMinDueTime()
+		{
+	
+			TimerObject timerObject = (TimerObject)timers[0];
+			int diff = (int) (DateTime.Now.Ticks - timerObject.lastSignalledTime.Ticks);
+			minDueTime = timerObject.dueTime -diff;
+			minDueTimeUniqueid = timerObject.uniqueid;
+			for(int i=1;i<timers.Count;i++)
+			{
+				timerObject = (TimerObject)timers[i];
+				diff = (int)(DateTime.Now.Ticks - timerObject.lastSignalledTime.Ticks);
+				if (minDueTime > (timerObject.dueTime -diff))
+				{
+					minDueTime = timerObject.dueTime;
+					minDueTimeUniqueid = timerObject.uniqueid;
+				}
+			}
+			return minDueTime;
+		}
+		
+
 		public bool Change (long dueTime, long period)
 		{
 			if(dueTime > 4294967294)
@@ -242,17 +371,171 @@
 			return Change ((int) dueTime, (int) period);
 		}
 
+
+		private void Add(TimerCallback callback, object state, int dueTime, int period, int id)
+		{
+			mut.WaitOne();
+			bool changeDueValue = false;
+			bool changePeriodValue = false;
+			if (!triggeredOnce)
+				changeDueValue = ChangeDueTime(dueTime,id);
+			changePeriodValue = ChangePeriod(period,id);
+			
+			timers.Add(new TimerObject(callback,state,dueTime,period,id));
+			if (changeDueValue || changePeriodValue)
+			    {
+					start_event.Reset ();
+					runner.Abort ();
+					runner.DueTime = dueTime;
+					runner.Period = period;
+					start_event.Set ();
+			    }
+			mut.ReleaseMutex();
+		}
+		
+		private  void Initialize(TimerCallback callback, object state, int dueTime, int period)
+		{
+			mut.WaitOne();
+			timers = new ArrayList();
+			timers.Add(new TimerObject(callback,state,dueTime,period,this.GetHashCode()));
+			minDueTime = dueTime;
+			minDueTimeUniqueid = this.GetHashCode();
+			minPeriod = period;
+			minPeriodUniqueid = this.GetHashCode();
+ 			start_event = new AutoResetEvent (false);
+			start_event.Set ();
+			runner = new Runner (new RunnerCallback(callback), state, start_event); 
+			runner.DueTime = minDueTime;
+			runner.Period = minPeriod;
+			t = new Thread (new ThreadStart (runner.Start));
+			t.IsBackground = true;
+			t.Start ();
+			initialized = true;
+			mut.ReleaseMutex();
+		}
+	
+		private bool ChangePeriod(int period, int id)
+		{
+			bool changed = false;
+			for(int i=0;i<timers.Count;i++)
+			{
+				TimerObject timerObject = (TimerObject)timers[i];
+				if (period < timerObject.period)
+				{
+					minPeriod = period;
+					minPeriodUniqueid = id;
+					changed = true;
+				}
+			}
+			return changed;
+			
+		}
+		
+		
+		private bool ChangeDueTime(int dueTime, int id)
+		{
+			bool changed = false;
+			for(int i=0;i<timers.Count;i++)
+			{
+				TimerObject timerObject = (TimerObject)timers[i];
+				int diff = (int)(DateTime.Now.Ticks - timerObject.lastSignalledTime.Ticks);
+				if (dueTime < (timerObject.dueTime -diff))
+				{
+					minDueTime = dueTime;
+					minDueTimeUniqueid = id;
+					changed = true;
+				}
+			}
+			return changed;
+		}
+		
+	
+	
+	static void RunnerCallback(object o)
+	{
+			mut.WaitOne();
+
+			triggeredOnce = true;
+			for (int i=0;i<timers.Count;i++)
+			{
+				TimerObject timerObject = (TimerObject)timers[i];
+				int diff = (int)(DateTime.Now.Ticks - timerObject.lastSignalledTime.Ticks);
+				if ( diff > timerObject.dueTime)
+				{
+					timerObject.timerCallback(timerObject.state);
+					timerObject.lastSignalledTime = DateTime.Now;
+				}
+				
+			}
+					mut.ReleaseMutex();
+	}
+	
+	
 		public void Dispose ()
 		{
-			if (t != null && t.IsAlive) {
-				if (t != Thread.CurrentThread)
-					t.Abort ();
-				t = null;
+			int hashCode = this.GetHashCode();
+			mut.WaitOne();
+			if (timers.Count == 1)
+			{
+				// i am the last timer to be disposed.
+				if (t != null && t.IsAlive) 
+				{
+					if (t != Thread.CurrentThread)
+						t.Abort ();
+					t = null;
+				}
+				runner.Dispose ();
+				runner = null;
+				GC.SuppressFinalize (this);
+				timers = null;
+				initialized = false;
+				
 			}
-			runner.Dispose ();
-			runner = null;
-			GC.SuppressFinalize (this);
+			else
+			{
+				// then there are other timers.
+				TimerObject timerObject = GetTimerObject(hashCode);
+				if (triggeredOnce)
+				{
+					// find the minperiod
+					if (timerObject.uniqueid == minPeriodUniqueid)
+					{
+							start_event.Reset ();
+							runner.Abort ();
+							runner.Period = FindMinPeriod();
+							start_event.Set ();
+					}
+					timers.Remove(timerObject);					
+				}
+				else
+				{
+					if (timerObject.uniqueid == minDueTimeUniqueid)
+					{
+						// similar to the change..
+							start_event.Reset ();
+							runner.Abort ();
+							runner.Period = FindMinPeriod();
+							start_event.Set ();
+					}
+					timers.Remove(timerObject);
+				}
+			}
+			mut.ReleaseMutex();
+	
 		}
+		
+		private TimerObject GetTimerObject(int hashCode)
+		{
+			
+			TimerObject timerObject;
+			for (int i=0;i<timers.Count;i++)
+			{
+				timerObject = (TimerObject)timers[i];
+				if (timerObject.uniqueid == hashCode)
+					return timerObject;
+			}
+			return new TimerObject();
+		}
 
 		public bool Dispose (WaitHandle notifyObject)
 		{
@@ -268,7 +551,12 @@
 
 			if (runner != null)
 				runner.Abort ();
+	
+		
 		}
+
+
+
 	}
 }
 
Index: ChangeLog
===================================================================
--- ChangeLog	(revision 45932)
+++ ChangeLog	(working copy)
@@ -1,3 +1,9 @@
+2005-06-14 Umadevi S <sumadevi@novell.com>
+	
+	* Timer.cs 
+	- Spwaning a single thread for any number of timers.
+	- Initial patch - some mutex /synchronization can be organized slightly better	
+
 2005-06-07 Gonzalo Paniagua Javier <gonzalo@ximian.com>
 
 	* Thread.cs: check that the culture is valid for formatting
