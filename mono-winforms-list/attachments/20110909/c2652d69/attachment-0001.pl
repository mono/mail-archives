--- src/font.c.orig	2011-01-13 22:28:19.000000000 +0000
+++ src/font.c	2011-09-09 15:21:35.000000000 +0100
@@ -626,11 +627,32 @@
 		PangoContext *context = pango_cairo_font_map_create_context ((PangoCairoFontMap*)map);
 		PangoFont *pf = pango_font_map_load_font (map, context, gdip_get_pango_font_description (font));
 
+#if 0
 		FT_Face face = pango_fc_font_lock_face ((PangoFcFont*)pf);
+#else
+		cairo_scaled_font_t* scaled_ft = pango_cairo_font_get_scaled_font ((PangoCairoFont*)pf);
+		if (!scaled_ft) {
+			static int flag = 0;
+			if (flag == 0) {
+				g_warning ("couldn't lock the font face. this may be due to a missing fonts.conf on the system.");
+				flag = 1;
+			}
+			status = FontFamilyNotFound;
+		}
+
+		FT_Face face = NULL;
+
+		if (status == Ok)
+			face = cairo_ft_scaled_font_lock_face (scaled_ft);
+#endif
 		if (face) {
 			gdip_get_fontfamily_details_from_freetype (family, face);
 
+#if 0
 			pango_fc_font_unlock_face ((PangoFcFont*)pf);
+#else
+			cairo_ft_scaled_font_unlock_face (scaled_ft);
+#endif
 		} else {
 			status = FontFamilyNotFound;
 		}
