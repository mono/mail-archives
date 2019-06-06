
using System;
using System.Runtime.InteropServices;

using Xorg.Structs;


// http://www.koders.com/csharp/fid5A7CBAABE4E399E1BED8C2C2FB6E1B36C289628D.aspx?s=zoom#L293
namespace Xorg
{


    // http://www.koders.com/csharp/fidFC528FE04222FE631D31990CC4B30889DB6ACCA8.aspx?s=socket
    public class API
    {
		
		
	    [Flags]
        internal enum EventMask
        {
            NoEventMask             = 0,
            KeyPressMask            = 1<<0,
		    KeyReleaseMask          = 1<<1,
		    ButtonPressMask         = 1<<2,
		    ButtonReleaseMask       = 1<<3,
		    EnterWindowMask         = 1<<4,
		    LeaveWindowMask         = 1<<5,
		    PointerMotionMask       = 1<<6,
		    PointerMotionHintMask   = 1<<7,
		    Button1MotionMask       = 1<<8,
		    Button2MotionMask       = 1<<9,
		    Button3MotionMask       = 1<<10,
		    Button4MotionMask       = 1<<11,
		    Button5MotionMask       = 1<<12,
		    ButtonMotionMask        = 1<<13,
		    KeymapStateMask         = 1<<14,
		    ExposureMask            = 1<<15,
		    VisibilityChangeMask    = 1<<16,
		    StructureNotifyMask     = 1<<17,
		    ResizeRedirectMask      = 1<<18,
            SubstructureNotifyMask  = 1<<19,
		    SubstructureRedirectMask= 1<<20,
		    FocusChangeMask         = 1<<21,
		    PropertyChangeMask      = 1<<22,
		    ColormapChangeMask      = 1<<23,
		    OwnerGrabButtonMask     = 1<<24
        }


        protected const string m_strSharedObjectName = "libX11";
        protected const string m_strSharedObjectName_Video = "libXxf86vm";

		// For AIX shared object, use "dump -Tv /path/to/foo.o"
		// For an ELF shared library, use "readelf -s /path/to/libfoo.so"
		// or (if you have GNU nm) "nm -D /path/to/libfoo.so"
		// For a Windows DLL, use "dumpbin /EXPORTS foo.dll".
		
		
		// nm -D $(locate libX11 | sed '/\/usr\/lib/!d;' | grep ".so$")
		// nm -D $(locate "libX11.so" | grep ".so$")
		// nm -D $(locate "libX11.so" | grep ".so$") | grep "DisplayHeight"
		
		
		[DllImport(m_strSharedObjectName, EntryPoint = "XOpenDisplay")]
        internal extern static IntPtr XOpenDisplay(IntPtr display);
		
		[DllImport(m_strSharedObjectName, EntryPoint = "XDefaultScreen")]
        internal extern static int XDefaultScreen(IntPtr display);
		
		[DllImport(m_strSharedObjectName, EntryPoint = "XDisplayHeight")]
        internal extern static int DisplayHeight(IntPtr display, int screen_number);
		
		[DllImport(m_strSharedObjectName, EntryPoint = "XDisplayWidth")]
        internal extern static int DisplayWidth(IntPtr display, int screen_number);
		
        [DllImport(m_strSharedObjectName, EntryPoint = "XRootWindow")]
        internal extern static IntPtr XRootWindow(IntPtr display, int screen_number);

        [DllImport(m_strSharedObjectName, EntryPoint = "XCloseDisplay")]
        internal extern static int XCloseDisplay(IntPtr display);
        
        [DllImport(m_strSharedObjectName, EntryPoint = "XSynchronize")]
        internal extern static IntPtr XSynchronize(IntPtr display, bool onoff);

        [DllImport(m_strSharedObjectName, EntryPoint = "XGrabServer")]
        internal extern static void XGrabServer(IntPtr display);

        [DllImport(m_strSharedObjectName, EntryPoint = "XUngrabServer")]
        internal extern static void XUngrabServer(IntPtr display);

        [DllImport(m_strSharedObjectName)]
        internal extern static int XFlush(IntPtr display);

        [DllImport(m_strSharedObjectName, EntryPoint = "XFree")]
        internal extern static int XFree(IntPtr data);

        //[DllImport(m_strSharedObjectName, EntryPoint = "XSendEvent")]
        //internal extern static int XSendEvent(IntPtr display, IntPtr window, bool propagate, IntPtr event_mask, ref XEvent send_event);

		[DllImport(m_strSharedObjectName, EntryPoint = "XSendEvent")]
        internal extern static int XSendEvent(IntPtr display, IntPtr window, bool propagate, int event_mask, ref XEvent send_event);

		//[DllImport (m_strSharedObjectName, EntryPoint="XSendEvent")]
		//internal extern static int XSendEvent(IntPtr display, IntPtr window, bool propagate, EventMask event_mask, ref XEvent send_event);
		//internal extern static int XSendEvent(IntPtr display, IntPtr window, bool propagate, EventMask event_mask, ref XClientMessageEvent send_event);
		
        [DllImport(m_strSharedObjectName, EntryPoint = "XQueryPointer")]
        internal extern static bool XQueryPointer(IntPtr display, IntPtr window, out IntPtr root, out IntPtr child, out int root_x, out int root_y, out int win_x, out int win_y, out int keys_buttons);

        [DllImport(m_strSharedObjectName, EntryPoint = "XWarpPointer")]
        internal extern static uint XWarpPointer(IntPtr display, IntPtr src_w, IntPtr dest_w, int src_x, int src_y, uint src_width, uint src_height, int dest_x, int dest_y);
        
        [DllImport(m_strSharedObjectName, EntryPoint = "XGetWindowProperty")]
        internal extern static int XGetWindowProperty(IntPtr display, IntPtr window, IntPtr atom, IntPtr long_offset, IntPtr long_length, bool delete, IntPtr req_type, out IntPtr actual_type, out int actual_format, out IntPtr nitems, out IntPtr bytes_after, ref IntPtr prop);
        

    } // End Class Mouse


} // End Namespace Xorg
