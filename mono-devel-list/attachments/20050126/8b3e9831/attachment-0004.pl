Index: System.Drawing.Imaging/ImageAttributes.cs
===================================================================
--- System.Drawing.Imaging/ImageAttributes.cs	(revision 39533)
+++ System.Drawing.Imaging/ImageAttributes.cs	(working copy)
@@ -62,7 +62,7 @@
 			Status status = GDIPlus.GdipCreateImageAttributes(out nativeImageAttr);
 						
 			if (status != Status.Ok)
-				throw new Exception ("Error calling GDIPlus.GdipCreateImageAttributes:" +status);
+				throw new SystemException ("Error calling GDIPlus.GdipCreateImageAttributes:" +status);
 			
 		}
 
@@ -182,7 +182,7 @@
             				ColorAdjustType.Default, true,  colorLow.ToArgb(), colorHigh.ToArgb());
 
 			if (status != Status.Ok)
-				throw new Exception ("Error calling GDIPlus.GdipSetImageAttributesColorKeys:" +status);
+				throw new SystemException ("Error calling GDIPlus.GdipSetImageAttributesColorKeys:" +status);
 		}
 
 		public void SetColorMatrix(ColorMatrix colorMatrix) 
@@ -192,7 +192,7 @@
                                             true, colorMatrix, (ColorMatrix)null, ColorMatrixFlag.Default);
                                             
 			if (status != Status.Ok)
-				throw new Exception ("Error calling GDIPlus.SetColorMatrix:" +status);                                           
+				throw new SystemException ("Error calling GDIPlus.SetColorMatrix:" +status);                                           
 		}
 
 		public void SetColorMatrix(ColorMatrix colorMatrix, ColorMatrixFlag colorMatrixFlag) 
@@ -201,7 +201,7 @@
 			Status status = GDIPlus.GdipSetImageAttributesColorMatrix(nativeImageAttr, ColorAdjustType.Default,
                                             true, colorMatrix, (ColorMatrix)null, colorMatrixFlag);
 			if (status != Status.Ok)
-				throw new Exception ("Error calling GDIPlus.SetColorMatrix:" +status);                                                                                       
+				throw new SystemException ("Error calling GDIPlus.SetColorMatrix:" +status);                                                                                       
                                             
 		}
 
@@ -211,7 +211,7 @@
                                             true,  colorMatrix,  (ColorMatrix)null,  colorMatrixFlag);
                                             
 			if (status != Status.Ok)
-				throw new Exception ("Error calling GDIPlus.SetColorMatrix:" +status);                                                                                       
+				throw new SystemException ("Error calling GDIPlus.SetColorMatrix:" +status);                                                                                       
 		}
 		
 		void Dispose (bool disposing)
@@ -221,7 +221,7 @@
 			Status status = GDIPlus.GdipDisposeImageAttributes(nativeImageAttr);
 			
 			if (status != Status.Ok)
-				throw new Exception ("Error calling GDIPlus.GdipDisposeImageAttributes:" +status);
+				throw new SystemException ("Error calling GDIPlus.GdipDisposeImageAttributes:" +status);
 			else
 				nativeImageAttr = IntPtr.Zero;
 		}
Index: System.Drawing.Text/PrivateFontCollection.cs
===================================================================
--- System.Drawing.Text/PrivateFontCollection.cs	(revision 39533)
+++ System.Drawing.Text/PrivateFontCollection.cs	(working copy)
@@ -52,10 +52,10 @@
 		public void AddFontFile(string filename) 
 		{
 			if ( filename == null )
-				throw new Exception ("Value cannot be null, Parameter name : filename");
+				throw new SystemException ("Value cannot be null, Parameter name : filename");
 			bool exists = File.Exists(filename);
 			if (!exists)
-				throw new Exception ("The path is not of a legal form");
+				throw new SystemException ("The path is not of a legal form");
 
 			Status status = GDIPlus.GdipPrivateAddFontFile (nativeFontCollection, filename);
 			GDIPlus.CheckStatus (status);			
Index: System.Drawing/Bitmap.cs
===================================================================
--- System.Drawing/Bitmap.cs	(revision 39533)
+++ System.Drawing/Bitmap.cs	(working copy)
@@ -281,7 +281,7 @@
 			BitmapData result = new BitmapData();
 
 			if (nativeObject == (IntPtr) 0)
-				throw new Exception ("nativeObject is null");			
+				throw new SystemException ("nativeObject is null");			
 			
 			IntPtr lfBuffer = Marshal.AllocHGlobal(Marshal.SizeOf(result));
      			Marshal.StructureToPtr(result, lfBuffer, false);						
Index: System.Drawing/gdipFunctions.cs
===================================================================
--- System.Drawing/gdipFunctions.cs	(revision 39533)
+++ System.Drawing/gdipFunctions.cs	(working copy)
@@ -146,7 +146,7 @@
 				// TODO: Add more status code mappings here
 
 				case Status.GenericError:
-					throw new Exception ("Generic Error.");
+					throw new SystemException ("Generic Error.");
 
 				case Status.InvalidParameter:
 					throw new ArgumentException ("Invalid Parameter. A null reference or invalid value was found.");
@@ -179,7 +179,7 @@
 					throw new ArgumentException ("Properties not set properly.");
 
 				default:
-					throw new Exception ("Unknown Error.");
+					throw new SystemException ("Unknown Error.");
 			}
 		}
 		