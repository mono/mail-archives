using System;
using System.Runtime.InteropServices;

public class MonoCrash {

  [DllImport("gobject-2.0")]
  public static extern void g_type_init ();

  [DllImport("gtkembedmoz", CharSet = CharSet.Ansi)]
  public static extern int gtk_moz_embed_set_profile_path(string aDir, string aName);

  [DllImport("gtkembedmoz")]
  public static extern int gtk_moz_embed_new();

  public static void Main() {
    MonoCrash monoCrash = new MonoCrash();
  }

  public MonoCrash() {
    g_type_init();

    // Mozilla's profile code will get us into nsProfileLock.cpp,
    // which wraps many signals.  If we don't call this, we don't
    // crash, but then Mozilla can't use SSL.
    string profilePath = string.Format("{0}/{1}", Environment.GetEnvironmentVariable("HOME"), ".SharpWT");
    gtk_moz_embed_set_profile_path(profilePath, "SharpWT-Mozilla");

    // Create a Mozilla widget, but don't bother doing anything
    // with it, as it doesn't matter.
    gtk_moz_embed_new();

    // Cause a null pointer dereference, which causes mono to
    // crash.
    System.Console.Error.WriteLine("Causing a null pointer dereference.");
    try {
      // Cause a null pointer dereference.
      Object foo = null;
      foo.GetType();
    }
    catch(Exception ex) {
      System.Console.Error.WriteLine("Survived to see an exception: {0}", ex);
    }

    // If we get here, the bug is fixed.
    System.Console.Error.WriteLine("Survived!");
  }
}
