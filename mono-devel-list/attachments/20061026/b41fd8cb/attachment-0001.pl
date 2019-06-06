// DxCppCli.cpp : main project file.

#include "stdafx.h"
#define INITGUID
#include <d3d9.h>

using namespace System;
using namespace System::Diagnostics;

int main(array<System::String ^> ^args)
{
    //Console::WriteLine(L"Hello World");
    
    IDirect3D9 *d3d = Direct3DCreate9( 32 );
    
	Stopwatch^ watch = gcnew Stopwatch();
	
	watch->Start();
    for( int i = 0; i < 1000000; i++ ) {
		d3d->GetAdapterCount();
	}
	watch->Stop();
	
	Console::WriteLine( "Time elapsed: {0}", watch->Elapsed );
	Console::WriteLine( "Calls/second: {0}", 1000000.0 * (double) TimeSpan::TicksPerSecond / (double) watch->ElapsedTicks );

	watch->Reset();
	watch->Start();
    for( int i = 0; i < 1000000; i++ ) {
		d3d->GetAdapterCount();
	}
	watch->Stop();
	
	Console::WriteLine( "Time elapsed: {0}", watch->Elapsed );
	Console::WriteLine( "Calls/second: {0}", 1000000.0 * (double) TimeSpan::TicksPerSecond / (double) watch->ElapsedTicks );

	Console::ReadKey();
    
    return 0;
}
