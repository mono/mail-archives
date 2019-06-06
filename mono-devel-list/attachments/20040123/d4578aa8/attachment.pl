? Test/System.Drawing/cairo-logo.png
? gdiplus/fontcollection.c
Index: System.Drawing/FontFamily.cs
===================================================================
RCS file: /cvs/public/mcs/class/System.Drawing/System.Drawing/FontFamily.cs,v
retrieving revision 1.7
diff -u -r1.7 FontFamily.cs
--- System.Drawing/FontFamily.cs	13 Nov 2003 22:40:00 -0000	1.7
+++ System.Drawing/FontFamily.cs	23 Jan 2004 17:21:14 -0000
@@ -19,15 +19,39 @@
 		static FontFamily genericSerif;
 
 		string name;
-		
+
+		internal IntPtr nativeFontFamily = IntPtr.Zero;
+				
+		internal FontFamily (IntPtr ptr)
+		{
+			nativeFontFamily = ptr;
+		}
+		
+		//Need to come back here, is Arial.ttf the right thing to do
+		internal FontFamily ()
+		{
+			Console.WriteLine("constructor of fontfamily, internal fontfamily()");
+			
+			Status status = GDIPlus.GdipCreateFontFamilyFromName( "Arial.ttf", IntPtr.Zero, out nativeFontFamily);
+						
+			if (status != Status.Ok)
+			{
+				nativeFontFamily = IntPtr.Zero;
+				throw new Exception ("Error calling GDIPlus.GdipCreateFontFamilyFromName: " +status);
+			}
+			Console.WriteLine("font created " + nativeFontFamily);									
+		}
+
 		public FontFamily(GenericFontFamilies genericFamily) {
 		}
 		
-		public FontFamily(string familyName) {
+		public FontFamily(string familyName) 
+		{
 			name = familyName;
 		}
 		
-		public FontFamily(string familyName, FontCollection collection) {
+		public FontFamily(string familyName, FontCollection collection) 
+		{
 			name = familyName;
 		}
 		
@@ -88,3 +112,4 @@
 		}
 	}
 }
+
Index: System.Drawing/gdipFunctions.cs
===================================================================
RCS file: /cvs/public/mcs/class/System.Drawing/System.Drawing/gdipFunctions.cs,v
retrieving revision 1.24
diff -u -r1.24 gdipFunctions.cs
--- System.Drawing/gdipFunctions.cs	23 Jan 2004 13:07:28 -0000	1.24
+++ System.Drawing/gdipFunctions.cs	23 Jan 2004 17:21:15 -0000
@@ -3,7 +3,7 @@
 //
 // Author: 
 // Alexandre Pigolkine (pigolkine@gmx.de)
-// Jordi Mas i Hernàndez (jmas@softcatala.org)
+// Jordi Mas i HernÃ ndez (jmas@softcatala.org)
 //
 
 using System;
@@ -464,7 +464,33 @@
 				[DllImport ("gdiplus.dll")]     
 				internal static extern Status GdipSetImageAttributesColorMatrix(IntPtr imageattr,
                              ColorAdjustType type, bool enableFlag, ColorMatrix colorMatrix,
-                               ColorMatrix grayMatrix,  ColorMatrixFlag flags);                                
+                               ColorMatrix grayMatrix,  ColorMatrixFlag flags); 
+
+		// FontCollection
+		[DllImport ("gdiplus.dll")]
+		internal static extern Status GdipGetFontCollectionFamilyCount( IntPtr collection, out int found );
+		
+		[DllImport ("gdiplus.dll")]
+		internal static extern Status GdipGetFontCollectionFamilyList( IntPtr collection, int getCount, out IntPtr [] familyList, out int retCount );

		// Have tried above function with 
		//internal static extern Status GdipGetFontCollectionFamilyList( IntPtr collection, int getCount, [Out] FontFamily [] familyList, out int retCount );
		//but the code in this case throw exception of the effect, Object reference not found

+		
+		[DllImport ("gdiplus.dll")]
+		internal static extern Status GdipNewInstalledFontCollection( out IntPtr collection );
+		
+		[DllImport ("gdiplus.dll")]
+		internal static extern Status GdipNewPrivateFontCollection( out IntPtr collection );
+		
+		[DllImport ("gdiplus.dll")]
+		internal static extern Status GdipDeletePrivateFontCollection( IntPtr collection );
+		
+		[DllImport ("gdiplus.dll")]
+		internal static extern Status GdipPrivateAddFontFile( IntPtr collection, string fileName );
+		
+		[DllImport ("gdiplus.dll")]
+		internal static extern Status GdipPrivateAddMemoryFont( IntPtr collection,  IntPtr mem, int length );
+
+		//FontFamily
+		[DllImport ("gdiplus.dll")]
+		internal static extern Status GdipCreateFontFamilyFromName( string familyName, IntPtr collection,  out IntPtr fontFamily);                               
 				
 
 #endregion      
Index: System.Drawing.Text/FontCollection.cs
===================================================================
RCS file: /cvs/public/mcs/class/System.Drawing/System.Drawing.Text/FontCollection.cs,v
retrieving revision 1.4
diff -u -r1.4 FontCollection.cs
--- System.Drawing.Text/FontCollection.cs	14 Jul 2003 06:26:50 -0000	1.4
+++ System.Drawing.Text/FontCollection.cs	23 Jan 2004 17:21:15 -0000
@@ -1,36 +1,80 @@
-//
-// System.Drawing.Text.FontCollection.cs
-//
-// (C) 2002 Ximian, Inc.  http://www.ximian.com
-// Author: Everaldo Canuto everaldo.canuto@bol.com.br
-//
-using System;
-
-namespace System.Drawing.Text {
-
-	public abstract class FontCollection : IDisposable {
-		internal IFontCollection implementation;
-		
-		// methods
-		[MonoTODO]
-		public void Dispose()
-		{
-			throw new NotImplementedException ();
-		}
-
-		[MonoTODO]
-		protected virtual void Dispose (bool disposing)
-		{
-			throw new NotImplementedException ();
-		}
-
-		// properties
-		[MonoTODO]
-		public FontFamily[] Families
-		{
-			get { return implementation.Families; }
-		}
-
-	}
-
-}
+//
+// System.Drawing.Text.FontCollection.cs
+//
+// (C) 2002 Ximian, Inc.  http://www.ximian.com
+// Author: Everaldo Canuto everaldo.canuto@bol.com.br
+//			Sanjay Gupta (gsanjay@novell.com)
+//
+using System;
+using System.Drawing;
+
+namespace System.Drawing.Text {
+
+	public abstract class FontCollection : IDisposable {
+		
+		//internal IFontCollection implementation;
+		internal IntPtr nativeFontCollection = IntPtr.Zero;
+				
+		internal FontCollection ()
+		{ }
+        
+		internal FontCollection (IntPtr ptr)
+		{
+			nativeFontCollection = ptr;
+		}
+
+		// methods
+		public void Dispose()
+		{
+			Dispose (true);
+			System.GC.SuppressFinalize (this);
+		}
+
+		[MonoTODO]
+		protected virtual void Dispose (bool disposing)
+		{
+			//Nothing for now
+		}
+
+		// properties
+		public FontFamily[] Families
+		{
+			get { 
+				int found;
+				int returned;
+				Status status;
+				
+				Console.WriteLine("came to Families method of FontCollection");
+				
+				status = GDIPlus.GdipGetFontCollectionFamilyCount( nativeFontCollection, out found);
+				if (status != Status.Ok){
+					throw new Exception ("Error calling GDIPlus.GdipGetFontCollectionFamilyCount: " +status);
+				}
+				
+				Console.WriteLine("FamilyFont count returned in Families method of FontCollection " + found);
+				
+				IntPtr [] family = new IntPtr [found];
+				
+				status = GDIPlus.GdipGetFontCollectionFamilyList( nativeFontCollection, found, out family, out returned);
+				if (status != Status.Ok){
+					throw new Exception ("Error calling GDIPlus.GdipGetFontCollectionFamilyList: " +status);
+				}
+				
+				FontFamily [] familyList = new FontFamily[returned];
+				Console.WriteLine("No of FontFamilies returned in Families method of FontCollection " + returned);
+				
+				for( int i = 0 ; i < returned ; i++ )
+					familyList [i] = new FontFamily( family[i] );
+				//return implementation.Families;
+				return familyList; 
+			}
+		}
+
+		~FontCollection()
+		{
+			Dispose (false);
+		}
+
+	}
+
+}
Index: System.Drawing.Text/InstalledFontCollection.cs
===================================================================
RCS file: /cvs/public/mcs/class/System.Drawing/System.Drawing.Text/InstalledFontCollection.cs,v
retrieving revision 1.5
diff -u -r1.5 InstalledFontCollection.cs
--- System.Drawing.Text/InstalledFontCollection.cs	12 Oct 2003 21:04:06 -0000	1.5
+++ System.Drawing.Text/InstalledFontCollection.cs	23 Jan 2004 17:21:15 -0000
@@ -4,6 +4,7 @@
 // (C) 2002 Ximian, Inc.  http://www.ximian.com
 // Author: Everaldo Canuto everaldo.canuto@bol.com.br
 //         Alexandre Pigolkine ( pigolkine@gmx.de)
+//			Sanjay Gupta (gsanjay@novell.com)
 //
 using System;
 using System.Drawing;
@@ -11,12 +12,20 @@
 namespace System.Drawing.Text {
 
 	public sealed class InstalledFontCollection : FontCollection {
-		//internal static IFontCollectionFactory	factory = Factories.GetFontCollectionFactory();
+		
+		internal InstalledFontCollection (IntPtr ptr): base (ptr)
+		{}
 
-		// constructors
-		[MonoTODO]
-		public InstalledFontCollection() {
-			//implementation = factory.InstalledFontCollection();
+		public InstalledFontCollection ()
+		{
+			Status status = GDIPlus.GdipNewInstalledFontCollection(out nativeFontCollection);
+						
+			if (status != Status.Ok){
+				nativeFontCollection = IntPtr.Zero;
+				throw new Exception ("Error calling GDIPlus.GdipNewInstalledFontCollection: " +status);
+			}
+			Console.WriteLine("Installed fonts are " + nativeFontCollection);				
 		}
 	}
 }
+
Index: System.Drawing.Text/PrivateFontCollection.cs
===================================================================
RCS file: /cvs/public/mcs/class/System.Drawing/System.Drawing.Text/PrivateFontCollection.cs,v
retrieving revision 1.4
diff -u -r1.4 PrivateFontCollection.cs
--- System.Drawing.Text/PrivateFontCollection.cs	22 Jun 2003 20:57:28 -0000	1.4
+++ System.Drawing.Text/PrivateFontCollection.cs	23 Jan 2004 17:21:15 -0000
@@ -5,6 +5,7 @@
 // Author: Everaldo Canuto everaldo.canuto@bol.com.br
 //
 using System;
+using System.Drawing;
 using System.Runtime.InteropServices;
 
 namespace System.Drawing.Text {
@@ -13,9 +14,18 @@
 	public sealed class PrivateFontCollection : FontCollection {
 
 		// constructors
-		[MonoTODO]
-		public PrivateFontCollection() {
-			throw new NotImplementedException ();
+		internal PrivateFontCollection (IntPtr ptr): base (ptr)
+		{}
+
+		public PrivateFontCollection ()
+		{
+			Status status = GDIPlus.GdipNewPrivateFontCollection(out nativeFontCollection);
+						
+			if (status != Status.Ok)
+			{
+				nativeFontCollection = IntPtr.Zero;
+				throw new Exception ("Error calling GDIPlus.GdipNewPrivateFontCollection: " +status);
+			}
 		}
 		
 		// methods
@@ -34,3 +44,4 @@
 	}
 
 }
+
Index: gdiplus/gdip.h
===================================================================
RCS file: /cvs/public/mcs/class/System.Drawing/gdiplus/gdip.h,v
retrieving revision 1.9
diff -u -r1.9 gdip.h
--- gdiplus/gdip.h	20 Jan 2004 04:44:52 -0000	1.9
+++ gdiplus/gdip.h	23 Jan 2004 17:21:16 -0000
@@ -276,6 +276,14 @@
         byte *Types;
 } GpPathData;
 
+typedef struct {
+        int Count;        
+} GpFontCollection;
+
+typedef struct {
+        int Count;        
+} GpFontFamily;
+
 /*
  * Functions
  * 
@@ -434,5 +442,14 @@
 /* Memory */
 void *GdipAlloc (int size);
 void GdipFree (void *ptr);
+
+/*Font Collection */
+GpStatus GdipGetFontCollectionFamilyCount(GpFontCollection *collection, int *found);
+GpStatus GdipGetFontCollectionFamilyList(GpFontCollection *collection, int getCount, GpFontFamily *familyList, int *retCount );
+GpStatus GdipNewInstalledFontCollection(GpFontCollection **collection);
+GpStatus GdipNewPrivateFontCollection(GpFontCollection **collection);
+GpStatus GdipDeletePrivateFontCollection(GpFontCollection **collection);
+GpStatus GdipPrivateAddFontFile(GpFontCollection *collection, const char* fileName);
+GpStatus GdipPrivateAddMemoryFont(GpFontCollection *collection, const void* buffer, int length);
 
 #endif /* _GDIP_H */
