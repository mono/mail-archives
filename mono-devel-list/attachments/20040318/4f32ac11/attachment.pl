// test-custom_attribute.cs  -- NUnit Test Case for testing the EnumBuilder class using a dynamically created assemly
// Keerti Narayan  keertiln@rediffmail.com

using System;
using System.Reflection;
using System.Reflection.Emit;
using System.Collections;
using System.Threading;
using NUnit.Framework;


namespace MonoTest.System.Reflection.Emit {
	[TestFixture]
	public class EnumBuiderTest : Assertion {
		[SetUp]
		public void BuildAssembly_1() {
			
			// Creating an Assembly with a name!!
			AssemblyName myAN = new AssemblyName();
			myAN.Name = "EmittedAssembly1";

			//Creating the Assembly itself
			AppDomain myDomain = Thread.GetDomain();
			AssemblyBuilder myA = myDomain.DefineDynamicAssembly(myAN,AssemblyBuilderAccess.RunAndSave);
			ModuleBuilder myMod = myA.DefineDynamicModule("EmittedModule","EmittedModule.mod");

			//Creating the Enum with one literal of value = 1 using the EnumBuilder. Surprise!!!

			EnumBuilder myEnum = myMod.DefineEnum("MyNameSpace.MyEnum",TypeAttributes.Public,typeof(Int32));
			FieldBuilder fib = myEnum.DefineLiteral("FieldNumberOne",1);
			myEnum.CreateType();
			myA.Save("Ass1.dll");
		}
		[Test]
		public void TestAssembly_1() { // Just tests the attributes of the built ASS_1
			Assembly a = Assembly.LoadFrom("Ass1.dll");
			Type t = a.GetType("MyNameSpace.MyEnum");

			//checking the assembly of the build with the Assembly attrib of EnumBuilder
			//the hash code must b unique
			//AssertEquals("Comparing the Assembly",a.GetHashCode(),1499);
			AssertEquals("Comparing the AssemblyQualifiedName",t.AssemblyQualifiedName,
					"MyNameSpace.MyEnum, EmittedAssembly1, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null");

	}
		[Test]
		public void TestAssembly_2() {
			Assembly a = Assembly.LoadFrom("Ass1.dll");
			Type t = a.GetType("MyNameSpace.MyEnum");

	
			//Checks the Attributes of the enum which is only public
			//doubt: doesn't look necessary cos there are individual fields which reflect these attributes
			
			//AssertEquals("Comparing the Attributes of the type",t.Attributes.
			AssertEquals("Comparing the BaseType of the Enum",t.BaseType,"System.Enum"); //cannot seem to set right this one
			AssertEquals("Comparing the Full Name",t.FullName,"MyNameSpace.MyEnum");
		}	

		public void TestAssembly_3() {
			Assembly a = Assembly.LoadFrom("Ass1.dll");
			Type t = a.GetType("MyNameSpace.MyEnum");

			Guid g = t.GUID;
			//AssertEquals("Comparing the GUID field",g.ToString(),"510625a9-1301-34d8-bcd0-abd6345e8ab4");
			AssertEquals("Comparing the HasElementType property",t.HasElementType,false);
		}

		public void TestAssembly_4() {
			Assembly a = Assembly.LoadFrom("Ass1.dll");
			Type t = a.GetType("MyNameSpace.MyEnum");


			AssertEquals("Comparing the IsAbstract field",t.IsAbstract,false);
		}

		public void TestAssembly_5() {
			Assembly a = Assembly.LoadFrom("Ass1.dll");
			Type t = a.GetType("MyNameSpace.MyEnum");

			AssertEquals("Comparing the IsAnsiClass field",t.IsAnsiClass,true);
		}

		public void TestAssembly_6() {
			Assembly a = Assembly.LoadFrom("Ass1.dll");
			Type t = a.GetType("MyNameSpace.MyEnum");

			AssertEquals("Comparing the IsArray field",t.IsArray,false);
		}

		public void TestAssembly_7() {
			Assembly a = Assembly.LoadFrom("Ass1.dll");
			Type t = a.GetType("MyNameSpace.MyEnum");

			AssertEquals("Comparing the IsAutoClass field",t.IsAutoClass,false);
			AssertEquals("Comparing the IsAutoLayout field",t.IsAutoLayout,true);
			AssertEquals("Comparing the IsByRef field",t.IsByRef,false);
			AssertEquals("Comparing the IsClass field",t.IsClass,false);
			AssertEquals("Comparing the IsComObject field",t.IsCOMObject,false);
			AssertEquals("Comparing the IsContextful field",t.IsContextful,false);
			AssertEquals("Comparing the IsEnum field",t.IsEnum,true);
			AssertEquals("Comparing the IsExplicitLayout field",t.IsExplicitLayout,false);			
			AssertEquals("Comparing the IsImport field",t.IsImport,false);
			AssertEquals("Comparing the IsInterface field",t.IsInterface,false);
			AssertEquals("Comparing the IsLayoutSequential field",t.IsLayoutSequential,false);
			AssertEquals("Comparing the IsMarshalByRef field",t.IsMarshalByRef,false);
			AssertEquals("Comparing the IsNestedAssembly field",t.IsNestedAssembly,false);
			AssertEquals("Comparing the IsNestedFamily field",t.IsNestedFamily,false);
			AssertEquals("Comparing the IsNestedPublic field",t.IsNestedPublic,false);
			AssertEquals("Comparing the IsNestedPrivate field",t.IsNestedPrivate ,false);
			AssertEquals("Comparing the IsNotPublic field",t.IsNotPublic,false);
			AssertEquals("Comparing the IsPrimitive field",t.IsPrimitive,false);
			AssertEquals("Comparing the IsPointer field",t.IsPointer,false);
			AssertEquals("Comparing the IsPublic field",t.IsPublic,true);
			AssertEquals("Comparing the IsSerializable field",t.IsSerializable,true);
			AssertEquals("Comparing the IsSealed field",t.IsSealed,true);
			AssertEquals("Comparing the IsUnicode field",t.IsUnicodeClass,false);
			AssertEquals("Comparing the requires special handling field",t.IsSpecialName,false);
			AssertEquals("Comparing the IsValueType field",t.IsValueType,true);
			//AssertEquals("Comparing the Member type field","TypeInfo",t.MemberType);
		}

		public void TestAssembly_8() {
			Assembly a = Assembly.LoadFrom("Ass1.dll");
			Type t = a.GetType("MyNameSpace.MyEnum");


			Module m = t.Module;
			AssertEquals("Comparing the Module name field",m.Name,"emittedmodule.mod");
			AssertEquals("Comparing the Enum Name field",t.Name,"MyEnum");
			AssertEquals("Comparing the Enum NameSpace  field",t.Namespace,"MyNameSpace");
			Type t1 = t.UnderlyingSystemType;
			AssertEquals("Comparing the TypeToken field ",t1.ToString(),"System.Int32"); // this must give System.Int32 shouldn't it ?
		}

		[Test] //Test the DefineLiteral() and the CreateType()
		public void TestAssembly_1_Methods() { // Just test a couple of methods on the literal FieldNumberOne
			Assembly a = Assembly.LoadFrom("Ass1.dll");
			Type t = a.GetType("MyNameSpace.MyEnum");
			FieldInfo fi = t.GetField("FieldNumberOne");
			Object o = fi.GetValue(t);
				
			AssertEquals("Checking the value of the Field to be 1 ",o.ToString(),"1");
			AssertEquals("Checking if the field is a Literal ",fi.IsLiteral,true);
			AssertEquals("Checking if the field is Public" ,fi.IsPublic,true );
			AssertEquals("Checking if the field is Static",fi.IsStatic,true);
		}

		[Test]// for now this will be in limbo!
		public void TestEnumBuilderEquals() {
		}
		
		[Test] //test some FindInterfaces() with a pre-define list of 4 interfaces. a bad test but can be extended for a larger number
		public void TestEnumBuilderOverridenMethods() {
			
			Assembly a = Assembly.LoadFrom("Ass1.dll");
			Type t = a.GetType("MyNameSpace.MyEnum");
					
			TypeFilter myFilter = new TypeFilter(MyInterfaceFilter);
			String[] myInterfaceList = new String[4] {"System.Collections.IEnumerable",
														 "System.Collections.ICollection",
														 "System.Collections.IDictionary",
														 "System.Collections.ICollection"};
			for(int index=0; index < myInterfaceList.Length; index++) {
				Type[] myInterfaces = t.FindInterfaces(myFilter, myInterfaceList[index]);
				if (myInterfaces.Length > 0) {
					Console.WriteLine("\n{0} implements the interface {1}.", t, myInterfaceList[index]);    
					for(int j =0;j < myInterfaces.Length;j++)
						Console.WriteLine("Interfaces supported: {0}.", myInterfaces[j].ToString());
						Fail("This failed");
				}
				else
					Console.WriteLine("\n{0} does not implement the interface {1}.",t,myInterfaceList[index]);    
			}
		}

		public static bool MyInterfaceFilter(Type typeObj,Object criteriaObj) {
			if(typeObj.ToString() == criteriaObj.ToString())
				return true;
			else
				return false;
		}
	
	}
}
	



			
		



				



	

				
	

