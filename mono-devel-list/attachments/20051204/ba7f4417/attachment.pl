Index: mcs/class/System.Drawing/System.Drawing/Graphics.cs
===================================================================
--- mcs/class/System.Drawing/System.Drawing/Graphics.cs	(revision 53896)
+++ mcs/class/System.Drawing/System.Drawing/Graphics.cs	(working copy)
@@ -387,8 +387,10 @@
 				throw new ArgumentNullException ("points");
 			
 			Status status;
+			int numberOfPoints = numberOfSegments + 1;
+			
 			status = GDIPlus.GdipDrawCurve3 (nativeObject, pen.nativeObject,
-							points, points.Length, offset,
+							points, numberOfPoints, offset,
 							numberOfSegments, 0.5f);
 			GDIPlus.CheckStatus (status);
 		}
@@ -401,8 +403,10 @@
 				throw new ArgumentNullException ("points");
 			
 			Status status;
+			int numberOfPoints = numberOfSegments + 1;
+			
 			status = GDIPlus.GdipDrawCurve3I (nativeObject, pen.nativeObject,
-							points, points.Length, offset,
+							points, numberOfPoints, offset,
 							numberOfSegments, tension);
 			GDIPlus.CheckStatus (status);
 		}
@@ -416,8 +420,10 @@
 				throw new ArgumentNullException ("points");
 			
 			Status status;
+			int numberOfPoints = numberOfSegments + 1;
+			
 			status = GDIPlus.GdipDrawCurve3 (nativeObject, pen.nativeObject,
-							points, points.Length, offset,
+							points, numberOfPoints, offset,
 							numberOfSegments, tension);
 			GDIPlus.CheckStatus (status);
 		}
