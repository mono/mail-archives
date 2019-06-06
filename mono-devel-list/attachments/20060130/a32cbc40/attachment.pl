using System;
using System.ComponentModel;
using System.ComponentModel.Design;

namespace Test {
	class MainClass {
		public static void Main() {
			TestContainer container = new TestContainer();
			Console.WriteLine( "// Results should be not null" );
			
			container.Add( new TestComponent() );
			
			Console.ReadLine();
		}
	}
	
	class TestService {
	}
	
	class TestContainer : Container {
		ServiceContainer _services = new ServiceContainer();
		
		public TestContainer() {
			_services.AddService( typeof(TestService), new TestService() );
		}
		
		protected override object GetService( Type serviceType ) {
			return _services.GetService( serviceType );
		}
	}
	
	class TestComponent : Component {
		public override ISite Site {
			get {
				return base.Site;
			}
			set {
				base.Site = value;
				
				if( value != null ) {
					Console.WriteLine( "ISite request result is {0}",
						(value.GetService( typeof(ISite) ) == null) ? "null" : "not null" );
					Console.WriteLine( "TestService request result is {0}",
						(value.GetService( typeof(TestService) ) == null) ? "null" : "not null" );
				}
			}
		}
	}
}


