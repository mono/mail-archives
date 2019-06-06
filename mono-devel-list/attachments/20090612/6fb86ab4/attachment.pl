Index: cominterop.c
===================================================================
--- cominterop.c	(revision 135665)
+++ cominterop.c	(working copy)
@@ -1917,6 +1917,12 @@
 						mspecs[mspec_index] = g_new0 (MonoMarshalSpec, 1);
 						mspecs[mspec_index]->native = MONO_NATIVE_VARIANTBOOL;
 					}
+				} else {
+					/* increase SizeParamIndex because we've added a param */
+					if (sig_adjusted->params[param_index]->type == MONO_TYPE_ARRAY ||
+					    sig_adjusted->params[param_index]->type == MONO_TYPE_SZARRAY)
+						if (mspecs[mspec_index]->data.array_data.param_num != -1)
+							mspecs[mspec_index]->data.array_data.param_num++;
 				}
 			}
 
