using System;
using System.Reflection;
using System.Security;
using System.Security.Permissions;

namespace AllocateStringTest
{
	public class AllocateStringTest
	{
		public delegate string AllocateStringDelegate(int length);

		private static void DoTest(AllocateStringDelegate allocateStringDelegate, bool check)
		{
			string s;

			try
			{
				if (allocateStringDelegate == null)
					allocateStringDelegate = GetAllocateStringDelegate(check);

				Console.WriteLine(allocateStringDelegate.Method.Name);
				s = allocateStringDelegate(10);
				Console.WriteLine(s.Length);
			}
			catch (Exception e)
			{
				Console.WriteLine("Exception: " + e.GetType().FullName);
			}
			Console.WriteLine();
		}

		private static AllocateStringDelegate GetAllocateStringDelegate(bool check)
		{
			MethodInfo allocateStringMethod;

			allocateStringMethod = GetAllocateStringMethod("FastAllocateString");
			if (allocateStringMethod == null)
				allocateStringMethod = GetAllocateStringMethod("InternalAllocateStr");
			if (allocateStringMethod != null && check)
			{
				try
				{
					new ReflectionPermission(ReflectionPermissionFlag.MemberAccess).Demand();
				}
				catch (SecurityException)				
				{
					allocateStringMethod = null;
				}
			}

			if (allocateStringMethod != null)
				// this will throw MethodAccessException
				return (AllocateStringDelegate)Delegate.CreateDelegate(typeof(AllocateStringDelegate), allocateStringMethod);
			else
				return new AllocateStringDelegate(AllocateStringFallback);
		}

		private static MethodInfo GetAllocateStringMethod(string name)
		{
			Type stringType = typeof(string);
			Type[] types = new Type[] {typeof(int)};
			MethodInfo allocateStringMethod;

			// no exception is thrown simply returns null
			if ((allocateStringMethod = stringType.GetMethod(name, BindingFlags.Static | BindingFlags.NonPublic | BindingFlags.ExactBinding,  null, types, null)) != null &&
				allocateStringMethod.ReturnType == stringType)
				return allocateStringMethod;
			else
				return null;
		}

		public static string AllocateStringFallback(int length)
		{
			return new string((char)0, length);
		}

		public static void Main(string[] args)
		{
			AllocateStringDelegate allocateStringDelegate;

			allocateStringDelegate = GetAllocateStringDelegate(false);

			Console.WriteLine("FullTrust");
			DoTest(null, false);
			new ReflectionPermission(ReflectionPermissionFlag.TypeInformation).Deny();
			Console.WriteLine("No TypeInformation");
			DoTest(null, false);
			CodeAccessPermission.RevertDeny();
			new ReflectionPermission(ReflectionPermissionFlag.MemberAccess).Deny();
			Console.WriteLine("No MemberAccess");
			DoTest(null, true);
			Console.WriteLine("No MemberAccess without check");
			DoTest(null, false);
			CodeAccessPermission.RevertDeny();
			new SecurityPermission(SecurityPermissionFlag.Execution).PermitOnly();
			Console.WriteLine("Only Execution");
			DoTest(null, false);
			Console.WriteLine("Only Execution with delegate");
			DoTest(allocateStringDelegate, false);
			Console.ReadLine();
		}
	}
}
