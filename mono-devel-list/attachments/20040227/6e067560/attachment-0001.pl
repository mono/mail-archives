// created on 2004-02-26 at 09:24
using System;
using System.Reflection;
using System.Reflection.Emit;

public class MainClass
{
	public static void Main(string[] args)
	{
		try {
			
		
		int compiledTime = 0;
		int dynTime = 0;
		int begin;
		int end;
		long res1 = 0 ;
		long res2 = 0;
		EmitTestFactory factory = new EmitTestFactory();
		
		EmitTestBase compiled = factory.getEmitTest(false);
		EmitTestBase dynamic = factory.getEmitTest(true);
		


		
		for ( int i = 0; i<=200; i++)
		{
			begin =  Environment.TickCount;
			res1 = compiled.EmitTest();
			end = Environment.TickCount;		
			compiledTime += end - begin;
		}
		
		compiledTime = compiledTime / 200;
		Console.WriteLine("Time for the compiled call {0}ms" , compiledTime);
		
		for ( int i = 0; i<=200; i++)
		{
			begin =  Environment.TickCount;
			res2 = dynamic.EmitTest();
			end = Environment.TickCount;
			dynTime += end - begin;
		}
		

		dynTime = dynTime / 200;
		
		Console.WriteLine("Time for the dynamic call {0}ms ",dynTime);
		Console.WriteLine(res1);
		Console.WriteLine(res2);
		
		Console.WriteLine("Compiled vs Dynamic : {0}%", (int)(dynTime /compiledTime* 100));
		}
		catch (Exception e) 
		{
			//System.Diagnostics.Debugger.Break();
			Console.WriteLine(e.Message + "\n" +  e.StackTrace);
		
			
		
		}
		
		
		
	}
	
}

public class EmitTestFactory
{
	public EmitTestBase getEmitTest(bool dynamic)
	{
		if (dynamic)
		{
			Type t = this.CreateType();
			asmBuilder.Save("Test.dll");
			return (EmitTestBase)Activator.CreateInstance(t);
			//return new EmitTest1();
		}
		else
		{
			return new EmitTest1();
		}
	}
	
	private AssemblyBuilder asmBuilder;
	private Type CreateType()
	{
			// Get the current application domain for the current thread.
			AppDomain currentDomain = AppDomain.CurrentDomain;
		       
			AssemblyName asmName = new AssemblyName();
			asmName.Name = "Test.dll";


			// Define a dynamic assembly in the current application domain.			
			asmBuilder = currentDomain.DefineDynamicAssembly (asmName, AssemblyBuilderAccess.RunAndSave);

			// Define a dynamic module in this assembly.			
			ModuleBuilder modBuilder = asmBuilder.DefineDynamicModule("DynModule", asmName.Name);
		
					// Define a runtime class with specified name and attributes.
			TypeBuilder builder = modBuilder.DefineType("EmitTest2" ,
							TypeAttributes.Public , 
							typeof(EmitTestBase), 
							new Type[]{typeof(EmitTestInter)});


//Define default constructor
			ConstructorBuilder ctorBuilder = builder.DefineConstructor(MethodAttributes.Public,
										   CallingConventions.Standard,
										   new Type[] {});
			ILGenerator ctorILGen = ctorBuilder.GetILGenerator();
			
		

			ctorILGen.Emit(OpCodes.Ldarg_0);
			ctorILGen.Emit(OpCodes.Call, 
				       typeof(EmitTestBase).GetConstructor(BindingFlags.Instance | 
									     BindingFlags.NonPublic, 
				       null, 
				       new Type[]{},
				       null));
			ctorILGen.Emit(OpCodes.Ret);
		


			MethodBuilder methodBuilder = builder.DefineMethod("EmitTest", MethodAttributes.Public | MethodAttributes.Virtual ,
									       typeof(long), 
									       new Type[]{}); 
		    
			builder.DefineMethodOverride(methodBuilder, typeof(EmitTestInter).GetMethod("EmitTest"));
			ILGenerator iLGen = methodBuilder.GetILGenerator();
	
			Label IL_001c = iLGen.DefineLabel();
			Label IL_0010 = iLGen.DefineLabel();
			Label IL_000c = iLGen.DefineLabel();
			Label IL_0008 = iLGen.DefineLabel();
			

		
		
//		.method public hidebysig virtual instance void 
//        EmitTest() cil managed
//{
//  // Code size       40 (0x28)
//  .maxstack  2

//  .locals init ([0] int32 i,
//           [1] int64 j)

			LocalBuilder i = iLGen.DeclareLocal(typeof(int));
			LocalBuilder j = iLGen.DeclareLocal(typeof(int));	
			LocalBuilder e = iLGen.DeclareLocal(typeof(long));	
//  IL_0000:  ldc.i4     0xffff8000
//  IL_0005:  stloc.0
			iLGen.Emit(OpCodes.Ldc_I4, (int)0);
			iLGen.Emit(OpCodes.Stloc_0);			
//  IL_0006:  br.s       IL_001c
			iLGen.Emit(OpCodes.Br_S, IL_001c);
// IL_0008:  ldc.i4.0
//  IL_0009:  stloc.1
			iLGen.MarkLabel(IL_0008);
			iLGen.Emit(OpCodes.Ldc_I4, (int)0);
			iLGen.Emit(OpCodes.Stloc_1);		
//  IL_000a:  br.s       IL_0010
			iLGen.Emit(OpCodes.Br_S, IL_0010);
			

//  IL_000c:  ldloc.1
//  IL_000d:  ldc.i4.1
//  IL_000e:  add
//  IL_000f:  stloc.1
			iLGen.MarkLabel(IL_000c);

			iLGen.Emit(OpCodes.Ldloc_2);
			iLGen.Emit(OpCodes.Ldc_I4_1);
			iLGen.Emit(OpCodes.Conv_U8);

			iLGen.Emit(OpCodes.Add);
			iLGen.Emit(OpCodes.Stloc_2);

			iLGen.Emit(OpCodes.Ldloc_1);
			iLGen.Emit(OpCodes.Ldc_I4_1);
			iLGen.Emit(OpCodes.Add);
			iLGen.Emit(OpCodes.Stloc_1);
//  IL_0010:  ldloc.1
//  IL_0011:  ldc.i4     0x7fff
//  IL_0016:  ble.s      IL_000c
			iLGen.MarkLabel(IL_0010);	
			iLGen.Emit(OpCodes.Ldloc_1);
			iLGen.Emit(OpCodes.Ldc_I4, (int)200);
			iLGen.Emit(OpCodes.Ble_S, IL_000c);		
//  IL_0018:  ldloc.0
//  IL_0019:  ldc.i4.1
//  IL_001a:  add
//  IL_001b:  stloc.0
			iLGen.Emit(OpCodes.Ldloc_0);
			iLGen.Emit(OpCodes.Ldc_I4_1);
			iLGen.Emit(OpCodes.Add);
			iLGen.Emit(OpCodes.Stloc_0);
			
//  IL_001c:  ldloc.0
//  IL_001d:  ldc.i4     0x7fff
//  IL_0022:  ble.s      IL_0008
			iLGen.MarkLabel(IL_001c);	
			iLGen.Emit(OpCodes.Ldloc_0);
			iLGen.Emit(OpCodes.Ldc_I4, (int)Int16.MaxValue);
			iLGen.Emit(OpCodes.Ble_S, IL_0008);
//	IL_0024:  ret

//			iLGen.EmitWriteLine(e);
			iLGen.Emit(OpCodes.Ldloc_2);
			iLGen.Emit(OpCodes.Ret);
//} // end of method EmitTest1::EmitTest



		return builder.CreateType();
	}
}


interface EmitTestInter
{
	 long EmitTest();
}

public abstract class EmitTestBase : EmitTestInter
{
	abstract public long  EmitTest();
}

public class EmitTest1 : EmitTestBase
{
	public override long EmitTest()
	{
		int i;
		int j;
		long e = 0;
		for  (i = 0; i <= Int16.MaxValue; i++)
			for ( j = 0; j <= 200; j++)
				e++;
		//	Console.WriteLine(e);	
		return e;
	}
}
