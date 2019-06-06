Index: System.IO.Ports/WinSerialStream.cs
===================================================================
--- System.IO.Ports/WinSerialStream.cs	(revision 132343)
+++ System.IO.Ports/WinSerialStream.cs	(working copy)
@@ -279,9 +279,11 @@
 					if (Marshal.GetLastWin32Error () != FileIOPending)
 						ReportIOError (null);
 				
-					if (!GetOverlappedResult (handle, read_overlapped, ref bytes_read, true))
-						ReportIOError (null);
-			
+					while (bytes_read == 0) {
+						if (!GetOverlappedResult (handle, read_overlapped, ref bytes_read, true))
+							ReportIOError (null);
+						Thread.Sleep (10);
+					}
 				}
 			}
 
