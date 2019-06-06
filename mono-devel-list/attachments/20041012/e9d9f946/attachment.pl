--- mono/metadata/icall.c.~1.559.~      2004-10-07 15:25:42.000000000 +0200
+++ mono/metadata/icall.c       2004-10-12 22:30:59.000000000 +0200
@@ -4148,7 +4148,7 @@
        mono_metadata_decode_row (&image->tables [MONO_TABLE_MEMBERREF], mono_metadata_token_index (token) - 1, cols, MONO_MEMBERREF_SIZE);
        sig = mono_metadata_blob_heap (image, cols [MONO_MEMBERREF_SIGNATURE]);
        mono_metadata_decode_blob_size (sig, &sig);
-       return (*sig == 0x6);
+       return (*sig != 0x6);
 }

 static MonoType*