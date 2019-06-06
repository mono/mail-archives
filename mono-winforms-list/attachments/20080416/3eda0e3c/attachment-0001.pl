***************
*** 1561,1578 ****
  
  					XNextEvent (DisplayHandle, ref xevent);
  
- 					if (xevent.AnyEvent.type == XEventName.KeyPress) {
  						if (XFilterEvent(ref xevent, FosterParent)) {
  							// probably here we could raise WM_IME_KEYDOWN and
  							// WM_IME_KEYUP, but I'm not sure it is worthy.
  							continue;
  						}
  					}
- 					else if (xevent.AnyEvent.type == XEventName.KeyRelease)
- 						// Allow the Input Method to process key releases but also pass them on to the
- 						// keyboard event processing because certain states (Shift, Control) are not 
- 						// correctly if we don't.                                                    
- 						XFilterEvent(ref xevent, FosterParent);
  					else if (XFilterEvent (ref xevent, IntPtr.Zero))
  						continue;
  				}
--- 1568,1583 ----
  
  					XNextEvent (DisplayHandle, ref xevent);
  
+ 					if (xevent.AnyEvent.type == XEventName.KeyPress ||
+ 					    xevent.AnyEvent.type == XEventName.KeyRelease) {
+ 						// PreFilter() handles "shift key state updates.
+ 						Keyboard.PreFilter (xevent);
  						if (XFilterEvent(ref xevent, FosterParent)) {
  							// probably here we could raise WM_IME_KEYDOWN and
  							// WM_IME_KEYUP, but I'm not sure it is worthy.
  							continue;
  						}
  					}
  					else if (XFilterEvent (ref xevent, IntPtr.Zero))
  						continue;
  				}