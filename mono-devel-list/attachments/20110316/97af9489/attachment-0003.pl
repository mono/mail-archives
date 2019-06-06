
#region License
/*
GNU Affero LGPL License
Copyright (c) 2011 Stefan Steiger
 Authors: Stefan Steiger noob.mcnoobington@gmail.com
All rights reserved.

Permission to link statically without disclosing the sourcecode of your program is hereby granted.
However, corrections/bugfixes and/or changes and/or additions to this code need to be published in FULL, 
and they need to compile WITHOUT syntax error.
*/
#endregion License


using System;
using System.Runtime.InteropServices;

using Xorg.Structs;


// http://www.koders.com/csharp/fid5A7CBAABE4E399E1BED8C2C2FB6E1B36C289628D.aspx?s=zoom#L293
namespace Xorg
{


    // http://www.koders.com/csharp/fidFC528FE04222FE631D31990CC4B30889DB6ACCA8.aspx?s=socket
    public class cLinuxMouse : OS.Devices.cMouse
    {

		protected const int LEFT  = 1;
		protected const int RIGHT = 3;
		

        public override void SendLeftClick()   // Abstract Method
        {
            MouseClick(LEFT);
        }


        public override void SendRightClick()   // Abstract Method
        {
            MouseClick(RIGHT);
        }


        public override void SendDoubleClick()   // Abstract Method
        {
            SendLeftClick();
			SendLeftClick();
        }


        // http://www.linuxquestions.org/questions/programming-9/simulating-a-mouse-click-594576/
        // http://snippets.dzone.com/posts/show/2750
        protected void MouseClick(int iThisButton)
        {
            // Display *display = XOpenDisplay(NULL);
            IntPtr display = Xorg.API.XOpenDisplay(System.IntPtr.Zero);
            
			
	        // if(display == NULL)
	        if(display == IntPtr.Zero)
	        {
				Console.WriteLine("Error: Failed on XOpendisplay.");
                /*
		        fprintf(stderr, "Errore nell'apertura del Display !!!\n");
		        exit(EXIT_FAILURE);
                */
	        }
			
            // XEvent event;
            //memset(&event, 0x00, sizeof(event));
            Structs.XEvent evtEvent = new Structs.XEvent();



            // event.type = ButtonPress;
            evtEvent.type = XEventName.ButtonPress;

            //event.xbutton.button = button;
            evtEvent.ButtonEvent.button = iThisButton;

            //event.xbutton.same_screen = True;
            evtEvent.ButtonEvent.same_screen = true;

			
			System.IntPtr PointerWindow = System.IntPtr.Zero;
            //System.IntPtr PointerWindow = API.XRootWindow(display, API.XDefaultScreen(display));
            
            // XQueryPointer(display, RootWindow(display, DefaultScreen(display)), &event.xbutton.root, &event.xbutton.window, &event.xbutton.x_root, &event.xbutton.y_root, &event.xbutton.x, &event.xbutton.y, &event.xbutton.state);
            API.XQueryPointer(display, API.XRootWindow(display, API.XDefaultScreen(display)), out evtEvent.ButtonEvent.root, out evtEvent.ButtonEvent.window, out evtEvent.ButtonEvent.x_root, out evtEvent.ButtonEvent.y_root, out evtEvent.ButtonEvent.x, out evtEvent.ButtonEvent.y, out evtEvent.ButtonEvent.state);

            //event.xbutton.subwindow = event.xbutton.window;
            evtEvent.ButtonEvent.subwindow = evtEvent.ButtonEvent.window;
	        

	        //while(event.xbutton.subwindow)
            while(evtEvent.ButtonEvent.subwindow != IntPtr.Zero)
	        {             
		        //event.xbutton.window = event.xbutton.subwindow;
		        evtEvent.ButtonEvent.window = evtEvent.ButtonEvent.subwindow;
                
                // XQueryPointer(display, event.xbutton.window, &event.xbutton.root, &event.xbutton.subwindow, &event.xbutton.x_root, &event.xbutton.y_root, &event.xbutton.x, &event.xbutton.y, &event.xbutton.state);
                API.XQueryPointer(display, evtEvent.ButtonEvent.window, out evtEvent.ButtonEvent.root, out evtEvent.ButtonEvent.subwindow, out evtEvent.ButtonEvent.x_root, out evtEvent.ButtonEvent.y_root, out evtEvent.ButtonEvent.x, out evtEvent.ButtonEvent.y, out evtEvent.ButtonEvent.state);
	        }
            

            
            
            //if(XSendEvent(display, PointerWindow, True, 0xfff, &event) == 0)
            //if(API.XSendEvent(display, PointerWindow, true, (System.IntPtr)0xfff, ref evtEvent) == 0) 
            //if(API.XSendEvent(display, PointerWindow, true, Xorg.API.EventMask.ButtonPressMask, ref evtEvent) == 0) 
			if(API.XSendEvent(display, PointerWindow, true, 0xfff, ref evtEvent) == 0)
				Console.WriteLine("Error: XSendEvent failed.");

	        // XFlush(display);
            API.XFlush(display);

            //usleep(100000);
            System.Threading.Thread.Sleep(100);

            // event.type = ButtonRelease;
	        evtEvent.type = XEventName.ButtonRelease;

            //event.xbutton.state = 0x100;
            evtEvent.ButtonEvent.state = 0x100;


	        //if(XSendEvent(display, PointerWindow, True, 0xfff, &event) == 0) 
            //if(API.XSendEvent(display, PointerWindow, true, (System.IntPtr)0xfff, ref evtEvent) == 0) 
            //if(API.XSendEvent(display, PointerWindow, true, Xorg.API.EventMask.ButtonReleaseMask, ref evtEvent) == 0) 
			if(API.XSendEvent(display, PointerWindow, true, 0xfff, ref evtEvent) == 0) 
                //fprintf(stderr, "Errore nell'invio dell'evento !!!\n");
                Console.WriteLine("Error: XSendEvent failed.");

	        //XFlush(display);
	        API.XFlush(display);

	        // XCloseDisplay(display);
            API.XCloseDisplay(display);
        } // End Sub MouseClick


    } // End Class Mouse


} // End Namespace Xorg
