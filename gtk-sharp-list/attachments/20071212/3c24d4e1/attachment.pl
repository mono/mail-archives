Hi Anders,

Out of curiosity, what kind of errors were you getting?  Because I got
something like "Xlib: unexpected async reply (sequence 0x3a296)!"
recently when changing a Gdk.Cursor.  Just earlier this week, actually.

The weird thing was that we were doing something like:

widget.GdkWindow.Cursor = some_boolean_test ? new Gdk.Cursor
(CursorType.SbHDoubleArrow) : null;

And when I changed it from ?: to if/else (for the purpose of doing some
Console.WriteLine() debugging) then it fixed the issue.  Really, really
strange.  I wondered if Mono generates code significantly different
for ?: and if/else.  Normally these type of Xlib errors are the result
of multi-threading bugs.

In our situation, it was happening in a MotionNotifyEvent handler.

/ Cody

On Tue, 2007-12-11 at 16:28 +0100, Anders Rune Jensen wrote:
> Hi
> 
> I spend god knows how long tracking this strange bug down. It appears
> that changing the cursor in an expose event on a widget fails randomly
> while doing the exact same thing in a realized event works fine. Fails
> as in crashing the program with X error. While I shouldn't have hooked
> into the expose event, any idea what might have caused the problem
> other that gtk gets overloaded and this triggers a rare race
> condition?
> 
> from:
> 
> 			widget.Expose += delegate {
> 				widget.GdkWindow.Cursor = new Gdk.Cursor(Gdk.CursorType.Hand2);
> 			};
> 
> to:
> 
> 			widget.Realized += delegate {
> 				widget.GdkWindow.Cursor = new Gdk.Cursor(Gdk.CursorType.Hand2);
> 			};
> 
> Seems the web page is outdated also:
> 
> This page refers to 2.4 as latest:
> 
>    http://www.mono-project.com/GtkSharp
> 
> While this mentions 2.8.4?
> 
>    http://www.monodevelop.com/Download
> 
> And latest in ubuntu is 2.10.2?
> 
> There's also a link to
> http://svn.myrealbox.com/source/trunk/gtk-sharp/ which doesn't work
> anymore.
> 

