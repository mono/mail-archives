Index: mono/metadata/reflection.c
===================================================================
--- mono/metadata/reflection.c	(revision 44532)
+++ mono/metadata/reflection.c	(working copy)
@@ -849,8 +849,10 @@
 			if (ex_block->extype) {
 				clause->data.catch_class = mono_class_from_mono_type (ex_block->extype->type);
 			} else {
-				/* FIXME: handle filters */
-				clause->data.filter_offset = 0;
+				if (ex_block->type == MONO_EXCEPTION_CLAUSE_FILTER)
+					clause->data.filter_offset = ex_block->filter_offset;
+				else
+					clause->data.filter_offset = 0;
 			}
 			finally_start = ex_block->start + ex_block->len;
 
@@ -998,8 +1000,10 @@
 					if (ex_block->extype) {
 						val = mono_metadata_token_from_dor (mono_image_typedef_or_ref (assembly, ex_block->extype->type));
 					} else {
-						/* FIXME: handle filters */
-						val = 0;
+						if (ex_block->type == MONO_EXCEPTION_CLAUSE_FILTER)
+							val = ex_block->filter_offset;
+						else
+							val = 0;
 					}
 					val = GUINT32_TO_LE (val);
 					mono_image_add_stream_data (&assembly->code, (char*)&val, sizeof (guint32));

