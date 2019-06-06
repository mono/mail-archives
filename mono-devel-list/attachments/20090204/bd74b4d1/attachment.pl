Index: src/text-pango-private.h
===================================================================
--- src/text-pango-private.h	(revision 125661)
+++ src/text-pango-private.h	(working copy)
@@ -36,17 +36,18 @@
 #include "graphics-private.h"
 #include "stringformat-private.h"
 
+#define PANGO_MAX (G_MAXINT / PANGO_SCALE)
+#define MAKE_SAFE_FOR_PANGO(x)	((x) > G_MAXINT/PANGO_SCALE ? G_MAXINT/PANGO_SCALE : ((x) < G_MININT/PANGO_SCALE ? G_MININT/PANGO_SCALE : (x)))
 
 #define	GDIP_WINDOWS_ACCELERATOR	'&'
-#define GDIP_PANGOHACK_ACCELERATOR	((char)1)
 
 #define text_DrawString			pango_DrawString
 #define text_MeasureString		pango_MeasureString
 #define text_MeasureCharacterRanges	pango_MeasureCharacterRanges
 
 
-PangoLayout* gdip_pango_setup_layout (cairo_t *ct, GDIPCONST WCHAR *stringUnicode, int length, GDIPCONST GpFont *font, 
-	GDIPCONST RectF *rc, RectF *box, GDIPCONST GpStringFormat *format);
+PangoLayout* gdip_pango_setup_layout (GpGraphics *graphics, GDIPCONST WCHAR *stringUnicode, int length, GDIPCONST GpFont *font, 
+	GDIPCONST RectF *rc, RectF *box, GDIPCONST GpStringFormat *format, int **charsRemoved);
 
 GpStatus pango_DrawString (GpGraphics *graphics, GDIPCONST WCHAR *stringUnicode, int length, GDIPCONST GpFont *font, 
 	GDIPCONST RectF *rc, GDIPCONST GpStringFormat *format, GpBrush *brush) GDIP_INTERNAL;
Index: src/text-pango.c
===================================================================
--- src/text-pango.c	(revision 125661)
+++ src/text-pango.c	(working copy)
@@ -46,45 +46,151 @@
 	return list;
 }
 
-static void
-gdip_process_accelerators (gchar *text, int length, PangoAttrList *list)
+void
+gdip_set_array_values (int *array, int value, int num)
 {
 	int i;
-	for (i = 0; i < length; i++) {
-		if (*(text + i) == GDIP_WINDOWS_ACCELERATOR) {
-			/* don't show the prefix character */
-			*(text + i) = GDIP_PANGOHACK_ACCELERATOR;
-			/* if the next character is an accelerator then skip over it (&& == &) */
-			if ((i < length - 1) && (*(text + i + 1) == GDIP_WINDOWS_ACCELERATOR)) {
-				i++;
-			} else if (list) {
-				/* add an attribute on the next character */
+	for (i = 0; i < num; i++)
+		array [i] = value;
+}
+
+static GString *
+gdip_process_string (gchar *text, int length, int removeAccelerators, int trimSpace, PangoAttrList *list, int **charsRemoved)
+{
+	int i, j;
+	int nonws = 0;
+	gchar *iter;
+	gchar *iter2;
+	gunichar ch;
+    GString *res = g_string_sized_new (length);
+
+	/* fast version: just check for final newline and remove */
+	if (!removeAccelerators && !trimSpace) {
+		j = length;
+		if (j > 0 && text [j-1] == '\n') {
+			j--;
+			if (j > 0 && text [j-1] == '\r')
+				j--;
+		}
+		g_string_append_len (res, text, j);
+		if (j == 0 && length > 0) {
+			g_string_append_c (res, ' ');
+			j++;
+		}
+		if (charsRemoved && *charsRemoved) {
+			int prevj = (g_utf8_prev_char (res->str + j) - res->str);
+			gdip_set_array_values (*charsRemoved + prevj, length - j, j - prevj);
+		}
+		return res;
+	}
+
+	iter = text;
+	i = 0;
+	j = 0;
+	while (iter - text < length) {
+		ch = g_utf8_get_char (iter);
+		if (ch == GDIP_WINDOWS_ACCELERATOR && removeAccelerators && (iter - text < length - 1)) {
+			nonws = 1;
+			iter2 = g_utf8_next_char (iter);
+			i += iter2 - iter;
+			iter = iter2;
+			ch = g_utf8_get_char (iter);
+			/* add an attribute on the next character */
+			if (list && (iter - text < length) && (ch != GDIP_WINDOWS_ACCELERATOR)) {
 				PangoAttribute *attr = pango_attr_underline_new (PANGO_UNDERLINE_LOW);
-				attr->start_index = i + 1;
-				attr->end_index = i + 2;
+				attr->start_index = j;
+				attr->end_index = j + g_utf8_next_char (iter) - iter;
 				pango_attr_list_insert (list, attr);
 			}
+		} else if (!g_unichar_isspace (ch)) {
+			nonws = 1;
+		} else if (trimSpace && ch != '\r' && ch != '\n') {
+			/* unless specified we don't consider the trailing spaces, unless there is just one space (#80680) */
+			for (iter2 = g_utf8_next_char (iter); iter2 - text < length; iter2 = g_utf8_next_char (iter2)) {
+				ch = g_utf8_get_char (iter2);
+				if (ch == '\r' || ch == '\n')
+					break;
+				if (!g_unichar_isspace (ch)) {
+					g_string_append_len (res, iter, iter2 - iter);
+					if (charsRemoved && *charsRemoved)
+						gdip_set_array_values ((*charsRemoved)+j, i - j, iter2 - iter);
+					j += iter2 - iter;
+					break;
+				}
+			}
+			i += iter2 - iter;
+			iter = iter2;
+			continue;
+		} else if ((ch == '\r' && (iter - text == length - 2) && (*g_utf8_next_char (iter) == '\n')) || (ch == '\n' && iter - text == length - 1)) {
+			/* in any case, ignore a final newline as pango will add an extra line to the measurement while gdi+ does not */
+			i = length;
+			break;
 		}
+		iter2 = g_utf8_next_char (iter);
+		g_string_append_len (res, iter, iter2 - iter);
+		/* save these for string lengths later */
+		if (charsRemoved && *charsRemoved)
+			gdip_set_array_values ((*charsRemoved)+j, i - j, iter2 - iter);
+		j += iter2 - iter;
+		i += iter2 - iter;
+		iter = iter2;
 	}
+	/* always ensure that at least one space is measured */
+	if (!nonws && trimSpace) {
+		g_string_append_c (res, ' ');
+		j++;
+	}
+	if (charsRemoved && *charsRemoved && j > 0) {
+		int prevj = (g_utf8_prev_char (res->str + j) - res->str);
+		gdip_set_array_values (*charsRemoved + prevj, i - j, j - prevj);
+	}
+	return res;
 }
 
 PangoLayout*
-gdip_pango_setup_layout (cairo_t *ct, GDIPCONST WCHAR *stringUnicode, int length, GDIPCONST GpFont *font, 
-	GDIPCONST RectF *rc, RectF *box, GDIPCONST GpStringFormat *format)
+gdip_pango_setup_layout (GpGraphics *graphics, GDIPCONST WCHAR *stringUnicode, int length, GDIPCONST GpFont *font, 
+	GDIPCONST RectF *rc, RectF *box, GDIPCONST GpStringFormat *format, int **charsRemoved)
 {
 	GpStringFormat *fmt;
 	PangoLayout *layout;
 	PangoContext *context;
-	PangoMatrix matrix = PANGO_MATRIX_INIT;
-	PangoRectangle logical;
+	PangoRectangle logical;   /* logical size of text (used for alignment) */
+	PangoRectangle ink;       /* ink size of text (to pixel boundaries) */
 	PangoAttrList *list = NULL;
+    GString *ftext;
+	PangoTabArray *tabs;
+	PangoLayoutIter *iter;
+	int i;
+	int FrameWidth;     /* rc->Width (or rc->Height if vertical) */
+	int FrameHeight;    /* rc->Height (or rc->Width if vertical) */
+	int FrameX;         /* rc->X (or rc->Y if vertical) */
+	int FrameY;         /* rc->Y (or rc->X if vertical) */
+	int y0;             /* y0,y1,clipNN used for checking line positions vs. clip rectangle */
+	int y1;
+	double clipx1;
+	double clipx2;
+	double clipy1;
+	double clipy2;
+	int trimSpace;      /* whether or not to trim the space */
 
 	gchar *text = ucs2_to_utf8 (stringUnicode, length);
 	if (!text)
 		return NULL;
+    length = strlen (text);
 
-//g_warning ("layout >%s< (%d) [x %g, y %g, w %g, h %g] [font %s, %g points]", text, length, rc->X, rc->Y, rc->Width, rc->Height, font->face, font->emSize);
+	if (charsRemoved) {
+		(*charsRemoved) = GdipAlloc (sizeof (int) * length);
+		if (!*charsRemoved) {
+			GdipFree (text);
+			return NULL;
+		}
+		memset (*charsRemoved, 0, sizeof (int) * length);
+	}
 
+	/* TODO - Digit substitution */
+
+// g_warning ("layout >%s< (%d) [x %g, y %g, w %g, h %g] [font %s, %g points]", text, length, rc->X, rc->Y, rc->Width, FrameHeight, font->face, font->emSize);
+
 	/* a NULL format is valid, it means get the generic default values (and free them later) */
 	if (!format) {
 		GpStatus status = GdipStringFormatGetGenericDefault ((GpStringFormat **)&fmt);
@@ -96,36 +202,49 @@
 		fmt = (GpStringFormat *)format;
 	}
 
-	/* unless specified we don't consider the trailing spaces, unless there is just one space (#80680) */
-	if ((fmt->formatFlags & StringFormatFlagsMeasureTrailingSpaces) == 0) {
-		while ((length > 0) && (isspace (*(text + length - 1))))
-			length--;
-		if (length == 0)
-			length = 1;
-	}
+	layout = pango_cairo_create_layout (graphics->ct);
 
-	layout = pango_cairo_create_layout (ct);
-
 	/* context is owned by Pango (i.e. not referenced counted) do not free */
 	context = pango_layout_get_context (layout);
 
 	pango_layout_set_font_description (layout, gdip_get_pango_font_description ((GpFont*) font));
 
-	if ((rc->Width <= 0.0) || (fmt->formatFlags & StringFormatFlagsNoWrap)) {
+	if (fmt->formatFlags & StringFormatFlagsDirectionVertical) {
+		FrameWidth = MAKE_SAFE_FOR_PANGO (SAFE_FLOAT_TO_UINT32 (rc->Height));
+		FrameHeight = MAKE_SAFE_FOR_PANGO (SAFE_FLOAT_TO_UINT32 (rc->Width));
+		FrameX = SAFE_FLOAT_TO_UINT32 (rc->Y);
+		FrameY = SAFE_FLOAT_TO_UINT32 (rc->X);
+	} else {
+		FrameWidth = MAKE_SAFE_FOR_PANGO (SAFE_FLOAT_TO_UINT32 (rc->Width));
+		FrameHeight = MAKE_SAFE_FOR_PANGO (SAFE_FLOAT_TO_UINT32 (rc->Height));
+		FrameX = SAFE_FLOAT_TO_UINT32 (rc->X);
+		FrameY = SAFE_FLOAT_TO_UINT32 (rc->Y);
+	}
+	//g_warning("FW: %d\tFH: %d", FrameWidth, FrameHeight);
+
+	if ((FrameWidth <= 0) || (fmt->formatFlags & StringFormatFlagsNoWrap)) {
 		pango_layout_set_width (layout, -1);
+		//g_warning ("Setting width: %d", -1);
 	} else {
-		/* minus one to deal with our AA offset */
-		int width = rc->Width - 1;
-		/* TODO incomplete (missing height adjustment) */
-		if ((fmt->formatFlags & StringFormatFlagsNoFitBlackBox) == 0)
-			width -= 2;
-		pango_layout_set_width (layout, width * PANGO_SCALE);
+		pango_layout_set_width (layout, FrameWidth * PANGO_SCALE);
+		//g_warning ("Setting width: %d", FrameWidth * PANGO_SCALE);
 	}
+
+	if (fmt->formatFlags & StringFormatFlagsNoWrap)
+		pango_layout_set_single_paragraph_mode (layout, TRUE);
+
+	if ((rc->Width != 0) && (rc->Height != 0) && ((fmt->formatFlags & StringFormatFlagsNoClip) == 0)) {
+// g_warning ("\tclip [%g %g %g %g]", rc->X, rc->Y, rc->Width, rc->Height);
+		/* We do not call cairo_reset_clip because we want to take previous clipping into account */
+		/* Use rc instead of frame variables because this is pre-transform */
+		gdip_cairo_rectangle (graphics, rc->X, rc->Y, rc->Width, rc->Height, TRUE);
+		cairo_clip (graphics->ct);
+	}
 	
-	if (fmt->formatFlags & StringFormatFlagsDirectionRightToLeft) {
-		/* with GDI+ the API not the renderer makes the direction decision */
-		pango_layout_set_auto_dir (layout, FALSE);
-		pango_context_set_base_dir (context, PANGO_DIRECTION_RTL);
+	/* with GDI+ the API not the renderer makes the direction decision */
+	pango_layout_set_auto_dir (layout, FALSE);
+	if (!(fmt->formatFlags & StringFormatFlagsDirectionRightToLeft) != !(fmt->formatFlags & StringFormatFlagsDirectionVertical)) {
+		pango_context_set_base_dir (context, PANGO_DIRECTION_WEAK_RTL);
 		pango_layout_context_changed (layout);
 
 		/* horizontal alignment */
@@ -141,6 +260,8 @@
 			break;
 		}
 	} else {
+		/* pango default base dir is WEAK_LTR, which is what we want */
+
 		/* horizontal alignment */
 		switch (fmt->alignment) {
 		case StringAlignmentNear:
@@ -158,8 +279,17 @@
 #ifdef PANGO_VERSION_CHECK
 #if PANGO_VERSION_CHECK(1,16,0)
 	if (fmt->formatFlags & StringFormatFlagsDirectionVertical) {
+		if (fmt->formatFlags & StringFormatFlagsDirectionRightToLeft) {
+			cairo_rotate (graphics->ct, M_PI/2.0);
+			cairo_translate (graphics->ct, 0, -FrameHeight);
+			pango_cairo_update_context (graphics->ct, context);
+		} else {
+			cairo_rotate (graphics->ct, 3.0*M_PI/2.0);
+			cairo_translate (graphics->ct, -FrameWidth, 0);
+			pango_cairo_update_context (graphics->ct, context);
+		}
 		/* only since Pango 1.16 */
-		pango_context_set_base_gravity (context, PANGO_GRAVITY_EAST);
+		pango_context_set_base_gravity (context, PANGO_GRAVITY_AUTO);
 		pango_context_set_gravity_hint (context, PANGO_GRAVITY_HINT_STRONG);
 		pango_layout_context_changed (layout);
 	}
@@ -169,38 +299,27 @@
 	/* TODO - StringFormatFlagsDisplayFormatControl
 		scan and replace them ??? */
 
-	/* TODO - StringFormatFlagsLineLimit */
-
-	if ((rc->Width != 0) && (rc->Height != 0) && ((fmt->formatFlags & StringFormatFlagsNoClip) == 0)) {
-//g_warning ("\tclip [%g %g %g %g]", rc->X, rc->Y, rc->Width, rc->Height);
-		/* We do not call cairo_reset_clip because we want to take previous clipping into account */
-		cairo_rectangle (ct, rc->X, rc->Y, rc->Width + 0.5, rc->Height + 0.5);
-		cairo_clip (ct);
-	}
-
+	/* Trimming options seem to apply only to the end of the string - gdi+ will still wrap 
+	 * with preference to word first, then character.  Unfortunately, pango doesn't have
+	 * any way to differentiate wrapping behavior from trimming behavior that I could find */
+	pango_layout_set_wrap (layout, PANGO_WRAP_WORD_CHAR);
 	switch (fmt->trimming) {
 	case StringTrimmingNone:
-		pango_layout_set_wrap (layout, PANGO_WRAP_WORD_CHAR);
 		pango_layout_set_ellipsize (layout, PANGO_ELLIPSIZE_NONE);
 		break;
 	case StringTrimmingCharacter:
-		pango_layout_set_wrap (layout, PANGO_WRAP_CHAR);
 		pango_layout_set_ellipsize (layout, PANGO_ELLIPSIZE_NONE);
 		break;
 	case StringTrimmingWord:
-		pango_layout_set_wrap (layout, PANGO_WRAP_WORD);
 		pango_layout_set_ellipsize (layout, PANGO_ELLIPSIZE_NONE);
 		break;
 	case StringTrimmingEllipsisCharacter:
-		pango_layout_set_wrap (layout, PANGO_WRAP_CHAR);
 		pango_layout_set_ellipsize (layout, PANGO_ELLIPSIZE_END);
 		break;
 	case StringTrimmingEllipsisWord:
-		pango_layout_set_wrap (layout, PANGO_WRAP_WORD);
 		pango_layout_set_ellipsize (layout, PANGO_ELLIPSIZE_END);
 		break;
 	case StringTrimmingEllipsisPath:
-		pango_layout_set_wrap (layout, PANGO_WRAP_WORD_CHAR);
 		pango_layout_set_ellipsize (layout, PANGO_ELLIPSIZE_MIDDLE);
 		break;
 	}
@@ -233,59 +352,138 @@
 		}
 	}
 
+	if (fmt->numtabStops > 0) {
+		float tabPosition;
+		tabs = pango_tab_array_new (fmt->numtabStops, TRUE);
+		tabPosition = fmt->firstTabOffset;
+		for (i = 0; i < fmt->numtabStops; i++) {
+			tabPosition += fmt->tabStops[i];
+			pango_tab_array_set_tab (tabs, i, PANGO_TAB_LEFT, (gint)min (tabPosition, PANGO_MAX) * PANGO_SCALE);
+		}
+		pango_layout_set_tabs (layout, tabs);
+		pango_tab_array_free (tabs);
+	}
+
+	//g_warning ("length before ws removal: %d", length);
+	trimSpace = (fmt->formatFlags & StringFormatFlagsMeasureTrailingSpaces) == 0;
 	switch (fmt->hotkeyPrefix) {
 	case HotkeyPrefixHide:
 		/* we need to remove any accelerator from the string */
-		gdip_process_accelerators (text, length, NULL);
+		ftext = gdip_process_string (text, length, 1, trimSpace, NULL, charsRemoved);
 		break;
 	case HotkeyPrefixShow:
 		/* optimization: is seems that we never see the hotkey when using an underline font */
 		if (font->style & FontStyleUnderline) {
 			/* so don't bother drawing it (and simply add the '&' character) */
-			gdip_process_accelerators (text, length, NULL);
+			ftext = gdip_process_string (text, length, 1, trimSpace, NULL, charsRemoved);
 		} else {
 			/* find accelerator and add attribute to the next character (unless it's the prefix too) */
 			if (!list)
 				list = gdip_get_layout_attributes (layout);
-			gdip_process_accelerators (text, length, list);
+			ftext = gdip_process_string (text, length, 1, trimSpace, list, charsRemoved);
 		}
 		break;
 	default:
+		ftext = gdip_process_string (text, length, 0, trimSpace, NULL, charsRemoved);
 		break;
 	}
+	length = ftext->len;
+	//g_warning ("length after ws removal: %d", length);
 
 	if (list) {
 		pango_layout_set_attributes (layout, list);
 		pango_attr_list_unref (list);
 	}
 
-	pango_layout_set_text (layout, text, length);
+// g_warning("\tftext>%s< (%d)", ftext->str, -1);
+	pango_layout_set_text (layout, ftext->str, ftext->len);
 	GdipFree (text);
+    g_string_free (ftext, TRUE);
 
-	pango_layout_get_pixel_extents (layout, NULL, &logical);
-//g_warning ("\tlogical\t[x %d, y %d, w %d, h %d]", logical.x, logical.y, logical.width, logical.height);
+	/* Trim the text after the last line for ease of counting lines/characters */
+	/* Also prevents drawing whole lines outside the boundaries if NoClip was specified */
+	/* In case of pre-existing clipping, use smaller of clip rectangle or our specified height */
+	if (FrameHeight > 0) {
+		cairo_clip_extents (graphics->ct, &clipx1, &clipy1, &clipx2, &clipy2);
+		if (clipy2 > 0)
+			clipy2 = min (clipy2, FrameHeight + FrameY);
+		else
+			clipy2 = FrameHeight + FrameY;
+		iter = pango_layout_get_iter (layout);
+		do {
+			if (iter == NULL)
+				break;
+			pango_layout_iter_get_line_yrange (iter, &y0, &y1);
+			//g_warning("yrange: %d  %d  clipy2: %f", y0 / PANGO_SCALE, y1 / PANGO_SCALE, clipy2);
+			/* StringFormatFlagsLineLimit */
+			if (((fmt->formatFlags & StringFormatFlagsLineLimit) && y1 / PANGO_SCALE > clipy2) || (y0 / PANGO_SCALE > clipy2)) {
+				PangoLayoutLine *line = pango_layout_iter_get_line_readonly (iter);
+				pango_layout_set_text (layout, pango_layout_get_text (layout), line->start_index);
+				break;
+			}
+		} while (pango_layout_iter_next_line (iter));
+		pango_layout_iter_free (iter);
+	}
 
-	box->X = rc->X;
-	box->Y = rc->Y;
-	box->Height = logical.height;
-	/* add an extra pixel for our AA hack + 2 more if we don't draw on the box itself */
-	box->Width = logical.width + (fmt->formatFlags & StringFormatFlagsNoFitBlackBox) ? 1 : 3;
-//g_warning ("\tbox\t[x %g, y %g, w %g, h %g]", box->X, box->Y, box->Width, box->Height);
+	pango_layout_get_pixel_extents (layout, &ink, &logical);
+ //g_warning ("\tlogical\t[x %d, y %d, w %d, h %d][x %d, y %d, w %d, h %d]", logical.x, logical.y, logical.width, logical.height, ink.x, ink.y, ink.width, ink.height);
 
+	if ((fmt->formatFlags & StringFormatFlagsNoFitBlackBox) == 0) {
+		/* By default don't allow overhang - ink space may be larger than logical space */
+		if (fmt->formatFlags & StringFormatFlagsDirectionVertical) {
+			box->X = min (ink.y, logical.y);
+			box->Y = min (ink.x, logical.x);
+			box->Height = max (ink.width, logical.width);
+			box->Width = max (ink.height, logical.height);
+		} else {
+			box->X = min (ink.x, logical.x);
+			box->Y = min (ink.y, logical.y);
+			box->Height = max (ink.height, logical.height);
+			box->Width = max (ink.width, logical.width);
+		}
+	} else {
+		/* Allow overhang */
+		if (fmt->formatFlags & StringFormatFlagsDirectionVertical) {
+			box->X = logical.y;
+			box->Y = logical.x;
+			box->Height = logical.width;
+			box->Width = logical.height;
+		} else {
+			box->X = logical.x;
+			box->Y = logical.y;
+			box->Height = logical.height;
+			box->Width = logical.width;
+		}
+	}
+ //g_warning ("\tbox\t[x %g, y %g, w %g, h %g]", box->X, box->Y, box->Width, box->Height);
+
 	/* vertical alignment*/
-	switch (fmt->lineAlignment) {
-	case StringAlignmentNear:
-		break;
-	case StringAlignmentCenter:
-		box->Y += (rc->Height - logical.height) / 2;
-		break;
-	case StringAlignmentFar:
-		box->Y += (rc->Height - logical.height);
-		break;
+	if (fmt->formatFlags & StringFormatFlagsDirectionVertical) {
+		switch (fmt->lineAlignment) {
+		case StringAlignmentNear:
+			break;
+		case StringAlignmentCenter:
+			box->X += (rc->Width - box->Width) / 2;
+			break;
+		case StringAlignmentFar:
+			box->X += (rc->Width - box->Width);
+			break;
+		}
+	} else {
+		switch (fmt->lineAlignment) {
+		case StringAlignmentNear:
+			break;
+		case StringAlignmentCenter:
+			box->Y += (rc->Height - box->Height) / 2;
+			break;
+		case StringAlignmentFar:
+			box->Y += (rc->Height - box->Height);
+			break;
+		}
 	}
-//g_warning ("va-box\t[x %g, y %g, w %g, h %g]", box->X, box->Y, box->Width, box->Height);
+// g_warning ("va-box\t[x %g, y %g, w %g, h %g]", box->X, box->Y, box->Width, box->Height);
 
-	pango_cairo_update_layout (ct, layout);
+	pango_cairo_update_layout (graphics->ct, layout);
 
 	return layout;
 }
@@ -297,22 +495,22 @@
 	PangoLayout *layout;
 	RectF box;
 
+	/* Setup cairo */
+	if (brush) {
+		gdip_brush_setup (graphics, brush);
+	} else {
+		cairo_set_source_rgb (graphics->ct, 0., 0., 0.);
+	}
+
 	cairo_save (graphics->ct);
 
-	layout = gdip_pango_setup_layout (graphics->ct, stringUnicode, length, font, rc, &box, format);
+	layout = gdip_pango_setup_layout (graphics, stringUnicode, length, font, rc, &box, format, NULL);
 	if (!layout) {
 		cairo_restore (graphics->ct);
 		return OutOfMemory;
 	}
 
-	/* Setup cairo */
-	if (brush) {
-		gdip_brush_setup (graphics, brush);
-	} else {
-		cairo_set_source_rgb (graphics->ct, 0., 0., 0.);
-	}
-
-	gdip_cairo_move_to (graphics, box.X, box.Y, FALSE, TRUE);
+	gdip_cairo_move_to (graphics, rc->X, rc->Y, FALSE, TRUE);
 	pango_cairo_show_layout (graphics->ct, layout);
 
 	g_object_unref (layout);
@@ -325,25 +523,96 @@
 	GDIPCONST GpStringFormat *format, RectF *boundingBox, int *codepointsFitted, int *linesFilled)
 {
 	PangoLayout *layout;
+	PangoLayoutLine *line;
+	PangoRectangle logical;
+	PangoLayoutIter *iter;
+	int *charsRemoved = NULL;
 
 	cairo_save (graphics->ct);
 
-	layout = gdip_pango_setup_layout (graphics->ct, stringUnicode, length, font, rc, boundingBox, format);
+	layout = gdip_pango_setup_layout (graphics, stringUnicode, length, font, rc, boundingBox, format, &charsRemoved);
 	if (!layout) {
 		cairo_restore (graphics->ct);
 		return OutOfMemory;
 	}
 		
 	if (codepointsFitted) {
-		// TODO - dummy (total) value returned
-		*codepointsFitted = length;
+		int charsFitted;
+		int lastIndex;
+		int y0;
+		int y1;
+		double min_x;
+		double max_x;
+		double max_y;
+		const char *layoutText;
+		if (boundingBox && format && (format->formatFlags & StringFormatFlagsDirectionVertical)) {
+			min_x = boundingBox->Y;
+			max_x = boundingBox->Y + boundingBox->Height;
+			max_y = boundingBox->X + boundingBox->Width;
+		} else if (boundingBox) {
+			min_x = boundingBox->X;
+			max_x = boundingBox->X + boundingBox->Width;
+			max_y = boundingBox->Y + boundingBox->Height;
+		} else if (format && (format->formatFlags & StringFormatFlagsDirectionVertical)) {
+			min_x = rc->Y;
+			max_x = rc->Y + rc->Height;
+			max_y = rc->X + rc->Width;
+		} else {
+			min_x = rc->X;
+			max_x = rc->X + rc->Width;
+			max_y = rc->Y + rc->Height;
+		}
+		lastIndex = 0;
+		iter = pango_layout_get_iter (layout);
+		do {
+			if (iter == NULL)
+				break;
+			pango_layout_iter_get_line_yrange (iter, &y0, &y1);
+			if (y0 / PANGO_SCALE >= max_y)
+				break;
+			if (pango_layout_iter_at_last_line (iter)) {
+				do {
+					pango_layout_iter_get_char_extents (iter, &logical);
+					/* check both max and min to catch right-to-left text, also width may be negative */
+					if ((logical.x / PANGO_SCALE > max_x || (logical.x + logical.width) / PANGO_SCALE > max_x) || (logical.x / PANGO_SCALE < min_x || (logical.x + logical.width) / PANGO_SCALE < min_x))
+						break;
+					lastIndex = pango_layout_iter_get_index (iter);
+				} while (pango_layout_iter_next_char (iter));
+				break;
+			} else {
+				line = pango_layout_iter_get_line_readonly (iter);
+				lastIndex = line->start_index + line->length - 1;
+			}
+		} while (pango_layout_iter_next_line (iter));
+		pango_layout_iter_free (iter);
+		layoutText = pango_layout_get_text (layout);
+		/* this can happen when the string ends in a newline */
+		if (lastIndex >= strlen (layoutText))
+			lastIndex = strlen (layoutText) - 1;
+		/* Add back in any & characters removed and the final newline characters (if any) */
+		charsFitted = g_utf8_strlen (layoutText, lastIndex + 1) + charsRemoved [lastIndex];
+		//g_warning("lastIndex: %d\t\tcharsRemoved: %d", lastIndex, charsRemoved[lastIndex]);
+		/* safe because of null termination */
+		switch (layoutText [lastIndex + 1]) {
+			case '\r':
+				charsFitted++;
+				if (layoutText [lastIndex + 2] == '\n')
+					charsFitted++;
+				break;
+			case '\n':
+				charsFitted++;
+				break;
+		}
+		*codepointsFitted = charsFitted;
 	}
 
+	GdipFree (charsRemoved);
+
 	if (linesFilled) {
 		*linesFilled = pango_layout_get_line_count (layout);
-//g_warning ("linesFilled %d", *linesFilled);
+// g_warning ("linesFilled %d", *linesFilled);
 	}
-//else g_warning ("linesFilled %d", pango_layout_get_line_count (layout));
+// else g_warning ("linesFilled %d", pango_layout_get_line_count (layout));
 
 	g_object_unref (layout);
 	cairo_restore (graphics->ct);
@@ -361,7 +630,7 @@
 
 	cairo_save (graphics->ct);
 
-	layout = gdip_pango_setup_layout (graphics->ct, stringUnicode, length, font, layoutRect, &boundingBox, format);
+	layout = gdip_pango_setup_layout (graphics, stringUnicode, length, font, layoutRect, &boundingBox, format, NULL);
 	if (!layout) {
 		cairo_restore (graphics->ct);
 		return OutOfMemory;
@@ -402,7 +671,16 @@
 			charRect.Y = (float)box.y / PANGO_SCALE;
 			charRect.Width = (float)box.width / PANGO_SCALE;
 			charRect.Height = (float)box.height / PANGO_SCALE;
-//g_warning ("[%d] [%d : %d-%d] %c [x %g y %g w %g h %g]", i, j, start, end, (char)stringUnicode[j], charRect.X, charRect.Y, charRect.Width, charRect.Height);
+			/* Normalize values (width/height can be negative) */
+			if (charRect.Width < 0) {
+				charRect.Width = -charRect.Width;
+				charRect.X -= charRect.Width;
+			}
+			if (charRect.Height < 0) {
+				charRect.Height = -charRect.Height;
+				charRect.Y -= charRect.Height;
+			}
+// g_warning ("[%d] [%d : %d-%d] %c [x %g y %g w %g h %g]", i, j, start, end, (char)stringUnicode[j], charRect.X, charRect.Y, charRect.Width, charRect.Height);
 			status = GdipCombineRegionRect (regions [i], &charRect, CombineModeUnion);
 			if (status != Ok)
 				break;
Index: src/graphics-path.c
===================================================================
--- src/graphics-path.c	(revision 125661)
+++ src/graphics-path.c	(working copy)
@@ -1212,7 +1212,7 @@
 	PangoLayout* layout; 
 
 	cairo_save (cr);
-	layout = gdip_pango_setup_layout (cr, string, length, font, layoutRect, &box, format);
+	layout = gdip_pango_setup_layout (cr, string, length, font, layoutRect, &box, format, NULL);
 	pango_cairo_layout_path (cr, layout);
 	g_object_unref (layout);
 	cairo_restore (cr);
