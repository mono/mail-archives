using System;
using System.Reflection;

namespace Test {
	class TestClass {
		public static void Main( string[] args ) {
			AppDomain newDomain = AppDomain.CreateDomain( "testDomain" );
			
			foreach( Assembly assem in newDomain.GetAssemblies() ) {
				Console.WriteLine( assem.FullName );
			}
		}
	}
}
