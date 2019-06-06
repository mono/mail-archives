using System;
using System.Collections;
using System.IO;
using System.Text;
using System.Threading;
using Novell.Directory.Ldap;

namespace PerfTest
{
	/// <summary>
	/// Summary description for Class1.
	/// </summary>
	class PerfTest
	{
		const int	 LDAPPORT	= 389;
		const string SEARCHBASE		= "";
		const string AUTH_PATTERN	= "";
		const string LDAP_SERVER	= "";

		const String USER = "";
		const String PASS = "";
		const String UID  = "uid=";

		const int COUNT = 2000;

		static string[] attrs = new string[2] {"cn", "mailHost"};

		static Object comp_lock = new object();
		static int completed = 0;

		static int[] runner = new int[COUNT];
		static int[] ldap   = new int[COUNT];

		

		[STAThread]
		static void Main(string[] args)
		{

			for(int i=0; i<COUNT; i++)
			{
				runner[i]	= 0;
				ldap[i]		= 0;
				mysql[i]	= 0;
				pop[i]		= 0;

				ThreadPool.QueueUserWorkItem(new WaitCallback(Runner), i);
			}

			int count =0;
			int workers =0;
			int comps =0;
			while(completed < COUNT)
			{
				Thread.Sleep(1000);
				count++;
				if(count % 10 == 0)
				{
					Console.WriteLine();
					ThreadPool.GetAvailableThreads(out workers, out comps);
					Console.WriteLine("workers: " + workers + "comps: " + comps);
					Console.WriteLine();
					for(int i=0; i<COUNT; i++)
					{
						if(runner[i] == 0)
							Console.WriteLine(i + " still active");
					}

				}
			}
			Console.WriteLine();

			calculate("runner", runner);
			calculate("ldap", ldap);
		}

		public static void calculate(string name, int[] recorder)
		{
			int total = 0;
			float average = 0;

			foreach(int i in recorder)
			{
				total = total + i;
			}

			average = (float)total / recorder.Length;

			Console.WriteLine(name + ": " + total + " : " + average);
		}

		public static void complete(int id, int time)
		{
			runner[id] = time;

			lock(comp_lock)
			{
				completed++;
			}
		}

		public static void Runner(Object stateinfo)
		{
			int id = (int)stateinfo;
			int method_start, start = System.Environment.TickCount;

			method_start = System.Environment.TickCount;
			ldapCall(id, USER, PASS);
			ldap[id] = System.Environment.TickCount - method_start;
			

			complete(id, System.Environment.TickCount - start);
		}

		public static void ldapCall(int id, string username, string password)
		{
			//using (StreamWriter sw = new StreamWriter("perf/" + id +".txt")) 
			//{
				//sw.WriteLine("start");
				//sw.Flush();
				StringBuilder result = new StringBuilder();

				LdapConnection conn = new LdapConnection();
				
				try
				{
					//sw.WriteLine("prepped");
					//sw.Flush();
					conn.Connect( LDAP_SERVER , LDAPPORT);
					//sw.WriteLine("connected");
					//sw.Flush();
					conn.Bind( String.Format(AUTH_PATTERN, username) ,password);
					//sw.WriteLine("bound");
					//sw.Flush();
					
					if(conn.Bound)
					{
						LdapSearchResults lsc = conn.Search( SEARCHBASE, LdapConnection.SCOPE_SUB, UID + username, attrs, false);

						if(lsc.hasMore())
						{
							LdapEntry entry = lsc.next();

							// get the backend mail server this user is on
							result.Append( entry.getAttribute(attrs[1]).StringValue );

							result.Append(':');

							// Zoom uses 10 digits we only want the last 9
							result.Append(  entry.getAttribute(attrs[0]).StringValue.Substring(1));
						}
					}
					
				}
				catch(Exception ex)
				{
					Console.WriteLine(ex.Message);
					Console.WriteLine(ex.StackTrace);

					Console.WriteLine("Recalling LDAPCall");
					ldapCall(id, username, password);

					
					//sw.Flush();
				}
				finally
				{

					conn.Disconnect();
					//sw.WriteLine("closed");
					//sw.Flush();

				}
			//}
		}
	}
}
