Mono improperly tries to free string pointers passed as the return value of
unmanaged calls via P/Invoke.  This removes the code that frees that string
pointer.

- Steven Brown <swbrown@ucsd.edu>


Index: mono/metadata/marshal.c
===================================================================
RCS file: /mono/mono/mono/metadata/marshal.c,v
retrieving revision 1.171
diff -u -r1.171 marshal.c
--- mono/metadata/marshal.c	31 May 2004 15:47:57 -0000	1.171
+++ mono/metadata/marshal.c	11 Jun 2004 04:08:03 -0000
@@ -3855,10 +3855,6 @@
 				}
 				mono_mb_emit_byte (mb, CEE_STLOC_3);
 
-				/* free the string */
-				mono_mb_emit_byte (mb, CEE_LDLOC_0);
-				mono_mb_emit_byte (mb, MONO_CUSTOM_PREFIX);
-				mono_mb_emit_byte (mb, CEE_MONO_FREE);
 				break;
 			case MONO_TYPE_CLASS:
 			case MONO_TYPE_OBJECT:
