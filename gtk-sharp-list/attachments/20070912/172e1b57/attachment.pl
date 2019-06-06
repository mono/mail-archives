Try using entry1.ModifyBase() instead.

On Mon, 2007-09-10 at 12:29 -0300, Adrian Gonzalez Alonso wrote:
> Just to give you an overview, I have a splash/login window with a
> fixed container and two widgets on it. An image widget that covers the
> whole window (logo and some nice gradients) and an entry widget over
> it to enter the user and then password (as some linux distribution
> does)
> 
> The problem is that the entry widget has some white background that
> does not fit very well with the image (which is green).
> If there anyway to make it transparent or to manually set the color?
> 
> I've tried :
> 
> entry1.ModifyBg( Gtk.StateType.Normal, new Gdk.Color( 0xff, 0, 0 );
> 
> which should set the background to red, this did not happen.

