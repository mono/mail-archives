On Tue, 2007-10-09 at 16:27 -0400, David Siegel wrote:
> I'm loading icons of various sizes as Pixbufs using iconThem.LoadIcon
> (string icon_name, int size, int flags). All Pixbufs created this way
> are eventually dereferenced, but they don't seem to be getting freed
> and my memory usage increases by about a few megabytes a minute under
> heavy usage. Is this a bug in gtk-sharp? It seems like the GC should
> be freeing these Pixbufs.

They might be just sitting around waiting to be GC'd by the runtime.
Just as a test, try calling GC.Collect() to see if it makes a
difference.  If not, then perhaps there is a memory leak.

