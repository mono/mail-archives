.assembly extern mscorlib
{
  .ver 1:0:5000:0
  .publickeytoken = (B7 7A 5C 56 19 34 E0 89 ) // .z\V.4..
}
.assembly 'thread-jump'
{
  .hash algorithm 0x00008004
  .ver  0:0:0:0
}
.module 'thread-jump.exe' // GUID = {DE2D75CD-6E25-4FD7-AB97-77B5E7FF5D5D}


  .class private auto ansi beforefieldinit TestClass
  	extends [mscorlib]System.Object
  {
    .field  private static  int32 count

    // method line 1
    .method public hidebysig  specialname  rtspecialname 
           instance default void '.ctor' ()  cil managed 
    {
        // Method begins at RVA 0x20ec
	// Code size 7 (0x7)
	.maxstack 8
	IL_0000:  ldarg.0 
	IL_0001:  call instance void object::'.ctor'()
	IL_0006:  ret 
    } // end of method TestClass::.ctor

    // method line 2
    .method private static  specialname  rtspecialname 
           default void '.cctor' ()  cil managed 
    {
        // Method begins at RVA 0x20f4
	// Code size 1 (0x1)
	.maxstack 8
	IL_0000:  ret 
    } // end of method TestClass::.cctor

    // method line 3
    .method public static  hidebysig 
           default void tolleMethode ()  cil managed synchronized 
    {
        // Method begins at RVA 0x20f8
	// Code size 71 (0x47)
	.maxstack 6
	.locals init (
		int32	V_0,
		int32	V_1)
	IL_0000:  ldc.i4.0 
	IL_0001:  stloc.0 
	IL_0002:  br IL_0025

	IL_0007:  ldloc.0 
	IL_0008:  ldc.i4.1 
	IL_0009:  add 
	IL_000a:  stloc.0 
	IL_000b:  ldsfld int32 TestClass::count
	IL_0010:  stloc.1 
	IL_0011:  ldloc.1 
	IL_0012:  ldc.i4.1 
	IL_0013:  add 
	IL_0014:  stloc.1 
	IL_0015:  ldc.i4 200
	IL_001a:  call void class [mscorlib]System.Threading.Thread::Sleep(int32)
	IL_001f:  ldloc.1 
	IL_0020:  stsfld int32 TestClass::count
	IL_0025:  ldloc.0 
	IL_0026:  ldc.i4.s 0x0a
	IL_0028:  blt IL_0007

	IL_002d:  ldstr "count: "
	IL_0032:  ldsflda int32 TestClass::count
	IL_0037:  call instance string int32::ToString()
	IL_003c:  call string string::Concat(string, string)
	IL_0041:  call void class [mscorlib]System.Console::WriteLine(string)
	IL_0046:  ret 
    } // end of method TestClass::tolleMethode

    // method line 4
    .method public static  hidebysig 
           default void jumpStart1 ()  cil managed 
    {
        // Method begins at RVA 0x214c
	// Code size 6 (0x6)
	.maxstack 8
//	IL_0000:  call void class TestClass::tolleMethode()
	IL_0000:  jmp void class TestClass::tolleMethode()
	IL_0005:  ret 
    } // end of method TestClass::jumpStart1

    // method line 5
    .method public static  hidebysig 
           default void jumpStart2 ()  cil managed 
    {
        // Method begins at RVA 0x2154
	// Code size 6 (0x6)
	.maxstack 8
//	IL_0000:  call void class TestClass::tolleMethode()
	IL_0000:  jmp void class TestClass::tolleMethode()
	IL_0005:  ret 
    } // end of method TestClass::jumpStart2

    // method line 6
    .method private static  hidebysig 
           default void Main ()  cil managed 
    {
        // Method begins at RVA 0x215c
	.entrypoint
	// Code size 65 (0x41)
	.maxstack 8
	.locals init (
		class [mscorlib]System.Threading.ThreadStart	V_0,
		class [mscorlib]System.Threading.ThreadStart	V_1,
		class [mscorlib]System.Threading.Thread	V_2,
		class [mscorlib]System.Threading.Thread	V_3)
	IL_0000:  ldnull 
	IL_0001:  ldftn void class TestClass::jumpStart1()
	IL_0007:  newobj instance void class [mscorlib]System.Threading.ThreadStart::'.ctor'(object, native int)
	IL_000c:  stloc.0 
	IL_000d:  ldnull 
	IL_000e:  ldftn void class TestClass::jumpStart2()
	IL_0014:  newobj instance void class [mscorlib]System.Threading.ThreadStart::'.ctor'(object, native int)
	IL_0019:  stloc.1 
	IL_001a:  ldloc.0 
	IL_001b:  newobj instance void class [mscorlib]System.Threading.Thread::'.ctor'(class [mscorlib]System.Threading.ThreadStart)
	IL_0020:  stloc.2 
	IL_0021:  ldloc.1 
	IL_0022:  newobj instance void class [mscorlib]System.Threading.Thread::'.ctor'(class [mscorlib]System.Threading.ThreadStart)
	IL_0027:  stloc.3 
	IL_0028:  ldloc.2 
	IL_0029:  callvirt instance void class [mscorlib]System.Threading.Thread::Start()
	IL_002e:  ldloc.3 
	IL_002f:  callvirt instance void class [mscorlib]System.Threading.Thread::Start()
	IL_0034:  ldloc.2 
	IL_0035:  callvirt instance void class [mscorlib]System.Threading.Thread::Join()
	IL_003a:  ldloc.3 
	IL_003b:  callvirt instance void class [mscorlib]System.Threading.Thread::Join()
	IL_0040:  ret 
    } // end of method TestClass::Main

  } // end of class TestClass

  .class private auto ansi sealed SampleDelegate
  	extends [mscorlib]System.MulticastDelegate
  {

    // method line 7
    .method public hidebysig  specialname  rtspecialname 
           instance default void '.ctor' (object 'object', native int 'method')  runtime managed 
    {
        // Method begins at RVA 0x0
          // Disassembly of native methods is not supported
    } // end of method SampleDelegate::.ctor

    // method line 8
    .method public virtual  hidebysig  newslot 
           instance default void Invoke (string message, int32 i)  runtime managed 
    {
        // Method begins at RVA 0x0
          // Disassembly of native methods is not supported
    } // end of method SampleDelegate::Invoke

    // method line 9
    .method public virtual  hidebysig  newslot 
           instance default class [mscorlib]System.IAsyncResult BeginInvoke (string message, int32 i, class [mscorlib]System.AsyncCallback callback, object 'object')  runtime managed 
    {
        // Method begins at RVA 0x0
          // Disassembly of native methods is not supported
    } // end of method SampleDelegate::BeginInvoke

    // method line 10
    .method public virtual  hidebysig  newslot 
           instance default void EndInvoke (class [mscorlib]System.IAsyncResult result)  runtime managed 
    {
        // Method begins at RVA 0x0
          // Disassembly of native methods is not supported
    } // end of method SampleDelegate::EndInvoke

  } // end of class SampleDelegate

