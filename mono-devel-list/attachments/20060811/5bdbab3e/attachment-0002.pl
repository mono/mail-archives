using System;

namespace Test {
	class Test {
		static void Main() {
            for( ;; ) {
				AppDomain domain = AppDomain.CreateDomain( "dummy" );
				domain.DoCallBack( new CrossAppDomainDelegate( Callback ) );
				AppDomain.Unload( domain );
			}
		}

		public static void Callback() {
		}
	}
}
