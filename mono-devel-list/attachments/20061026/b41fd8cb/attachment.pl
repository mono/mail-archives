using System;
using System.Collections.Generic;
using System.Text;
using System.Runtime.InteropServices;
using System.Diagnostics;

namespace DxSharp {
	public class MainClass {
		static void Main() {
			IDirect3D9 d3d = Direct3DCreate9( __sdkVersion );
			
			Stopwatch watch = new Stopwatch();
			
			watch.Start();
			for( int i = 0; i < 1000000; i++ ) {
				d3d.GetAdapterCount();
				//Console.WriteLine( i );
			}
			watch.Stop();

			Console.WriteLine( "Time elapsed: {0}", watch.Elapsed );
			Console.WriteLine( "Calls/second: {0}", 1000000.0 * (double) TimeSpan.TicksPerSecond / (double) watch.ElapsedTicks );

			watch.Reset();
			watch.Start();
			for( int i = 0; i < 1000000; i++ ) {
				d3d.GetAdapterCount();
				//Console.WriteLine( i );
			}
			watch.Stop();

			Console.WriteLine( "Time elapsed: {0}", watch.Elapsed );
			Console.WriteLine( "Calls/second: {0}", 1000000.0 * (double) TimeSpan.TicksPerSecond / (double) watch.ElapsedTicks );

			//Console.WriteLine( d3d.GetAdapterCount() );
			Console.ReadKey();
		}
		
		const uint __sdkVersion = 32;
		
		[DllImport("d3d9.dll")]
		[return:MarshalAs(UnmanagedType.Interface)]
		static extern IDirect3D9 Direct3DCreate9( uint sdkVersion );
	}
	
	[ComImport, Guid("81BDCBCA-64D4-426d-AE8D-AD0147F4275C"), InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
	interface IDirect3D9 {
    /*** IDirect3D9 methods ***/
    // STDMETHOD(RegisterSoftwareDevice)(THIS_ void* pInitializeFunction) PURE;
		[PreserveSig]
		IntPtr RegisterSoftwareDevice( IntPtr initializeFunction );
    //STDMETHOD_(UINT, GetAdapterCount)(THIS) PURE;
		[PreserveSig]
		uint GetAdapterCount();
    //STDMETHOD(GetAdapterIdentifier)(THIS_ UINT Adapter,DWORD Flags,D3DADAPTER_IDENTIFIER9* pIdentifier) PURE;
		[PreserveSig]
		IntPtr GetAdapterIdentifier( uint adapter, uint flags, IntPtr identifier );
    //STDMETHOD_(UINT, GetAdapterModeCount)(THIS_ UINT Adapter,D3DFORMAT Format) PURE;
		[PreserveSig]
		uint GetAdapterModeCount( uint adapter, uint format );
    //STDMETHOD(EnumAdapterModes)(THIS_ UINT Adapter,D3DFORMAT Format,UINT Mode,D3DDISPLAYMODE* pMode) PURE;
		[PreserveSig]
		IntPtr EnumAdapterModes( uint adapter, uint format, uint mode, IntPtr pMode );
    //STDMETHOD(GetAdapterDisplayMode)(THIS_ UINT Adapter,D3DDISPLAYMODE* pMode) PURE;
		[PreserveSig]
		IntPtr GetAdapterDisplayMode( uint adapter, IntPtr mode );
    //STDMETHOD(CheckDeviceType)(THIS_ UINT Adapter,D3DDEVTYPE DevType,D3DFORMAT AdapterFormat,D3DFORMAT BackBufferFormat,BOOL bWindowed) PURE;
		[PreserveSig]
		IntPtr CheckDeviceType( uint adapter, uint devType, uint adapterFormat, uint backBufferFormat, int windowed );
    //STDMETHOD(CheckDeviceFormat)(THIS_ UINT Adapter,D3DDEVTYPE DeviceType,D3DFORMAT AdapterFormat,DWORD Usage,D3DRESOURCETYPE RType,D3DFORMAT CheckFormat) PURE;
		[PreserveSig]
		IntPtr CheckDeviceFormat( uint adapter, uint deviceType, uint adapterFormat, uint usage, uint resourceType, uint checkFormat );
    //STDMETHOD(CheckDeviceMultiSampleType)(THIS_ UINT Adapter,D3DDEVTYPE DeviceType,D3DFORMAT SurfaceFormat,BOOL Windowed,D3DMULTISAMPLE_TYPE MultiSampleType,DWORD* pQualityLevels) PURE;
		[PreserveSig]
		IntPtr CheckDeviceMultiSampleType( uint adapter, uint deviceType, uint surfaceFormat, int windowed, uint multiSampleType, IntPtr qualityLevels );
    //STDMETHOD(CheckDepthStencilMatch)(THIS_ UINT Adapter,D3DDEVTYPE DeviceType,D3DFORMAT AdapterFormat,D3DFORMAT RenderTargetFormat,D3DFORMAT DepthStencilFormat) PURE;
		[PreserveSig]
		IntPtr CheckDepthStencilMatch( uint adapter, uint deviceType, uint adapterFormat, uint renderTargetFormat, uint depthStencilFormat );
    //STDMETHOD(CheckDeviceFormatConversion)(THIS_ UINT Adapter,D3DDEVTYPE DeviceType,D3DFORMAT SourceFormat,D3DFORMAT TargetFormat) PURE;
		[PreserveSig]
		IntPtr CheckDeviceFormatConversion( uint adapter, uint deviceType, uint sourceFormat, uint targetFormat );
    //STDMETHOD(GetDeviceCaps)(THIS_ UINT Adapter,D3DDEVTYPE DeviceType,D3DCAPS9* pCaps) PURE;
		[PreserveSig]
		IntPtr GetDeviceCaps( uint adapter, uint deviceType, IntPtr caps );
	//STDMETHOD_(HMONITOR, GetAdapterMonitor)(THIS_ UINT Adapter) PURE;
		[PreserveSig]
		IntPtr GetAdapterMonitor( uint adapter );
	//STDMETHOD(CreateDevice)(THIS_ UINT Adapter,D3DDEVTYPE DeviceType,HWND hFocusWindow,DWORD BehaviorFlags,D3DPRESENT_PARAMETERS* pPresentationParameters,IDirect3DDevice9** ppReturnedDeviceInterface) PURE;
		[PreserveSig]
		IntPtr CreateDevice( uint adapter, uint deviceType, IntPtr focusWindow, uint behaviorFlags, IntPtr presentationParameters, out IntPtr deviceInterface );
	}
}
