Index: CriticialFinalizerObject.cs
===================================================================
--- CriticialFinalizerObject.cs	(revision 41077)
+++ CriticialFinalizerObject.cs	(working copy)
@@ -35,7 +35,7 @@
                 {
                 }

-		[ReliabilityContract (Consistency.WillNotCorruptState, CER.Success)]
+		[ReliabilityContract (Consistency.WillNotCorruptState, Cer.Success)]
 		~CriticalFinalizerObject ()
 		{
 		}
