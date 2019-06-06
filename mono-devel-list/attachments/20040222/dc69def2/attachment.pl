using System;
using System.Reflection;

namespace AttributeIssue {
	public class Test {
		public static void Main() {
			Console.WriteLine("This one should work fine, even on Mono built from cvs:");
			Console.WriteLine("");
			CheckTestAttribute(typeof(DecoratedClass));
			Console.WriteLine("");
			
			Console.WriteLine("This one does not return the attribute on Mono built from cvs:");
			Console.WriteLine("");
			CheckTestAttribute(typeof(DerivedDecoratedClass));
		}

		public static void CheckTestAttribute(Type type) {
			Console.WriteLine("Checking attribute on '{0}'.", type.FullName);

                        PropertyInfo[] propertyInfos = type.GetProperties(BindingFlags.Public | BindingFlags.Instance);
                        foreach (PropertyInfo property in propertyInfos) {
                                TestAttribute testAttribute = (TestAttribute)
                                        Attribute.GetCustomAttribute(property, typeof(TestAttribute), true);
                                                                                                                     
                                if (testAttribute == null) {
                                        Console.WriteLine("{0} property: Attribute not found !!!", property.Name);
                                } else {
                                        Console.WriteLine("{0} property: Attribute found", property.Name);
                                }
                        }
		}
	}

	public class DerivedDecoratedClass : DecoratedClass {
	}

	public class DecoratedClass {
		private string _dunno;

		[TestAttribute("test")]
		public string Dunno {
			get { return _dunno; }
			set { _dunno = value; }
		}
	}

	[AttributeUsage(AttributeTargets.Property, Inherited=true)]
	public class TestAttribute : Attribute {
		private string _name;

		public TestAttribute(string name) {
			Name = name;
		}

		public string Name {
			get { return _name; }
			set { _name = value; }
		}
	}
}
