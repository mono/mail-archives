// 
// CGDirectDisplay.cs: Implements the managed CGDirectDisplay
//
// Authors: Mono Team
// Kenneth J. Pouncey
//     
// Copyright 2009 Novell, Inc
//
// Permission is hereby granted, free of charge, to any person obtaining
// a copy of this software and associated documentation files (the
// "Software"), to deal in the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to
// permit persons to whom the Software is furnished to do so, subject to
// the following conditions:
// 
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

using System;
using System.Drawing;
using System.Runtime.InteropServices;

using MonoMac.ObjCRuntime;
using MonoMac.Foundation;

namespace MonoMac.CoreGraphics
{



// 
//    [StructLayout (LayoutKind.Sequential)]
//    struct CGPatternCallbacks {
//        internal uint version;
//        internal DrawPatternCallback draw;
//        internal ReleaseInfoCallback release;
//    }

	public static class CGDirectDisplay
	{

		public static int NullDisplay ()
		{
			return 0;
		}

		[DllImport(Constants.CoreGraphicsLibrary)]
		static extern int CGMainDisplayID ();
		public static int MainDisplayID ()
		{
			return CGMainDisplayID ();
		}
		
		/* Return the OpenGL display mask for `display', or 0 is `display' is an
   			invalid display. */
		[DllImport(Constants.CoreGraphicsLibrary)]
		static extern int CGDisplayIDToOpenGLDisplayMask (int displayID);
		public static int IDToOpenGLDisplayMask (int displayID)
		{
			return CGDisplayIDToOpenGLDisplayMask (displayID);
		}

		/* Return the display for the OpenGL display mask `mask', or
		   `kCGNullDirectDisplay' if the bits set dont't match a display. A mask
		   with multiple bits set returns an arbitrary match. */
		[DllImport(Constants.CoreGraphicsLibrary)]
		static extern int CGOpenGLDisplayMaskToDisplayID (int displayID);
		public static int OpenGLDisplayMaskToID (int displayID)
		{
			return CGOpenGLDisplayMaskToDisplayID (displayID);
		}
		
		
		/* Mechanisms used to find screen IDs.
        
        The following functions take an array length (`maxDisplays') and array of
        pointers to CGDirectDisplayIDs (`displays'). The array is filled in with
        the displays meeting the specified criteria; no more than `maxDisplays'.
        will be stored in `displays'. The number of displays meeting the criteria
        is returned in `matchingDisplayCount'.
        
        If the `displays' array is NULL, only the number of displays meeting the
        specified criteria is returned in `matchingDisplayCount'. 
        */

		[DllImport(Constants.CoreGraphicsLibrary)]
		static extern unsafe CGError CGGetDisplaysWithPoint (PointF point,  int maxDisplays,  uint[] array,  uint* matchingDisplayCount );
		public static CGError GetDisplays (PointF point,  int maxDisplays,  uint[] displays, out  uint matchingDisplayCount )
		{
                unsafe
                {
					fixed( uint* disCount_ptr = &matchingDisplayCount)
					{
						CGError status = CGGetDisplaysWithPoint (point, maxDisplays, displays,  disCount_ptr);
						matchingDisplayCount = *disCount_ptr;
						return status;
					}
                }
		
		}
		
		[DllImport(Constants.CoreGraphicsLibrary)]
		static extern unsafe CGError CGGetDisplaysWithOpenGLDisplayMask ( uint mask,  int maxDisplays,  uint[] array,  uint* matchingDisplayCount );
		public static CGError GetDisplays (int mask,  int maxDisplays,  uint[] displays, out  uint matchingDisplayCount )
		{
                unsafe
                {
					fixed( uint* disCount_ptr = &matchingDisplayCount)
					{
						CGError status = CGGetDisplaysWithOpenGLDisplayMask (( uint)mask, maxDisplays, displays,  disCount_ptr);
						matchingDisplayCount = *disCount_ptr;
						return status;
					}
                }
		
		}
		
		/* Return a list of active displays.
		
		   If `activeDisplays' is NULL, then `maxDisplays' is ignored, and
		   `displayCount' is set to the number of displays. Otherwise, the list of
		   active displays is stored in `activeDisplays'; no more than `maxDisplays'
		   will be stored in `activeDisplays'.
		
		   The first display returned in the list is the main display (the one with
		   the menu bar). When mirroring, this will be the largest drawable display
		   in the mirror set, or, if all displays are the same size, the one with
		   the deepest pixel depth. */		
		
		[DllImport(Constants.CoreGraphicsLibrary)]
		static extern unsafe CGError CGGetActiveDisplayList ( int maxDisplays,  uint[] array,  uint* displayCount );
		public static CGError GetActiveDisplays (int maxDisplays,  uint[] displays, out  uint displayCount )
		{
                unsafe
                {
					fixed( uint* disCount_ptr = &displayCount)
					{
						CGError status = CGGetActiveDisplayList (maxDisplays, displays,  disCount_ptr);
						displayCount = *disCount_ptr;
						return status;
					}
                }
		
		}

		/* Return a list of online displays.
		
		   If `onlineDisplays' is NULL, then `maxDisplays' is ignored, and
		   `displayCount' is set to the number of displays. Otherwise, the list of
		   online displays is stored in `onlineDisplays'; no more than `maxDisplays'
		   will be stored in `onlineDisplays'.
		
		   With hardware mirroring, a display may be online but not necessarily
		   active or drawable. Programs which manipulate display settings such as
		   the palette or gamma tables need access to all displays in use, including
		   hardware mirrors which are not drawable. */
		
		[DllImport(Constants.CoreGraphicsLibrary)]
		static extern unsafe CGError CGGetOnlineDisplayList ( int maxDisplays,  uint[] array,  uint* displayCount );
		public static CGError GetOnlineDisplays (int maxDisplays,  uint[] displays, out  uint displayCount )
		{
                unsafe
                {
					fixed( uint* disCount_ptr = &displayCount)
					{
						CGError status = CGGetOnlineDisplayList (maxDisplays, displays,  disCount_ptr);
						displayCount = *disCount_ptr;
						return status;
					}
                }
		
		}
		
		/* Return the screen size and screen origin of `display' in global
		   coordinates, or `CGRectZero' if `display' is invalid. */		
		[DllImport(Constants.CoreGraphicsLibrary)]
		static extern RectangleF CGDisplayBounds (int displayID);
		public static RectangleF Bounds (int displayID)
		{
			return CGDisplayBounds(displayID);
		
		}
		
		/* Return the width in pixels of `display'. */
		[DllImport(Constants.CoreGraphicsLibrary)]
		static extern int CGDisplayPixelsWide (int displayID);
		public static int PixelsWide (int displayID)
		{
			return CGDisplayPixelsWide (displayID);
		
		}	
		
		/* Return the height in pixels of `display'. */
		[DllImport(Constants.CoreGraphicsLibrary)]
		static extern int CGDisplayPixelsHigh (int displayID);
		public static int PixelsHigh (int displayID)
		{
			return CGDisplayPixelsHigh (displayID);
		
		}	
		
		/* Return true if `display' is captured; false otherwise. */
		[DllImport(Constants.CoreGraphicsLibrary)]
		static extern bool CGDisplayIsCaptured (int displayID);
		public static bool IsCaptured (int displayID)
		{
			return CGDisplayIsCaptured (displayID);
		
		}			
		
		/* Capture `display' for exclusive use by an application. */
		[DllImport(Constants.CoreGraphicsLibrary)]
		static extern CGError CGDisplayCapture (int displayID);
		public static CGError Capture (int displayID)
		{
			return CGDisplayCapture (displayID);
		
		}			
		
		/* Capture `display' for exclusive use by an application, using the options
   			specified by `options'. */
		[DllImport(Constants.CoreGraphicsLibrary)]
		static extern CGError CGDisplayCaptureWithOptions (int displayID, int options);
		public static CGError Capture (int displayID, CaptureOptions options)
		{
			return CGDisplayCaptureWithOptions (displayID, (int)options);
		
		}	
		
		/* Release the captured display `display'. */
		[DllImport(Constants.CoreGraphicsLibrary)]
		static extern CGError CGDisplayRelease (int displayID);
		public static CGError Release (int displayID)
		{
			return CGDisplayRelease (displayID);
		
		}	
		
		/* Capture all displays. This operation provides an immersive environment
		   for an appplication, and prevents other applications from trying to
		   adjust to display changes. */
		[DllImport(Constants.CoreGraphicsLibrary)]
		static extern CGError CGCaptureAllDisplays ();
		public static CGError CaptureAllDisplays ()
		{
			return CGCaptureAllDisplays ();
		
		}
		
		/* Release all captured displays and restore the display modes to the user's
		   preferences. May be used in conjunction with `CGDisplayCapture' or
		   `CGCaptureAllDisplays'. */
		[DllImport(Constants.CoreGraphicsLibrary)]
		static extern CGError CGReleaseAllDisplays ();
		public static CGError ReleaseAllDisplays ()
		{
			return CGReleaseAllDisplays ();
		
		}
		
		/* Returns window ID of the shield window for the captured display `display',
		   or NULL if the display is not not shielded. */
		[DllImport(Constants.CoreGraphicsLibrary)]
		static extern int CGShieldingWindowID (int display);
		public static int ShieldingWindowID (int display)
		{
			return CGShieldingWindowID (display);
		
		}
		
		/* Returns the window level of the shield window for the captured display
		   `display'. */
		[DllImport(Constants.CoreGraphicsLibrary)]
		static extern int CGShieldingWindowLevel ();
		public static int ShieldingWindowLevel ()
		{
			return CGShieldingWindowLevel ();
		
		}

		/* Return an image containing the contents of the display identified by
   			`displayID'. */
		[DllImport(Constants.CoreGraphicsLibrary)]
		static extern IntPtr CGDisplayCreateImage (int display);
		public static CGImage CreateImage (int display)
		{
			return new CGImage(CGDisplayCreateImage (display), true);
		
		}	
		
		/* Return an image containing the contents of the rectangle `rect',
		   specified in display space, of the display identified by `displayID'. The
		   actual rectangle used is the rectangle returned from
		   `CGRectIntegral(rect)'. */
		[DllImport(Constants.CoreGraphicsLibrary)]
		static extern IntPtr CGDisplayCreateImageForRect (int display, RectangleF rect);
		public static CGImage CreateImage (int display, RectangleF rect)
		{
			return new CGImage(CGDisplayCreateImageForRect (display, rect), true);
		
		}	
		
		
	}
	
}
