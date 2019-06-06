I ran a page from a MS based ASP.NET application under Mono's ASP.NET, and didn't get what I expected.

The problem was caused by an #Include directive. Our Mono implementation is case sensitive, whereas the MS version isn't.

What's the call on a compatibility issue like this? Bug or not?

I bring it up, since it can break a page that works on another system. (And MS's own example uses: <!-- #Include virtual=".\include\header.inc" --> )

Below is the I'm-too-tired-to-think change I made.

Regards,
Ivan

Index: class/System.Web/System.Web.Compilation/AspParser.cs
===================================================================
RCS file: /mono/mcs/class/System.Web/System.Web.Compilation/AspParser.cs,v
retrieving revision 1.17
diff -u -r1.17 AspParser.cs
--- class/System.Web/System.Web.Compilation/AspParser.cs        24 Jun 2004 20:58:16 -0000      1.17
+++ class/System.Web/System.Web.Compilation/AspParser.cs        9 Jul 2004 08:08:18 -0000
@@ -184,7 +184,7 @@
                        str = str.Substring (2).Trim ();
                        int len = str.Length;
                        int lastQuote = str.LastIndexOf ('"');
-                       if (len < 10 || lastQuote != len - 1 || !str.StartsWith("#include "))
+                       if (len < 10 || lastQuote != len - 1 || !str.ToLower().StartsWith("#include "))
                                return false;

                        str = str.Substring (9).Trim ();

