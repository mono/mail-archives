Index: src/graphics.c
===================================================================
RCS file: /mono/libgdiplus/src/graphics.c,v
retrieving revision 1.55
diff -r1.55 graphics.c
1285c1285
<         float realY = rc->Y + font->sizeInPixels;
---
>         float realY = rc->Y;
1309c1309
<               if ((current_glyph+1 < num_widths+1) && (w + *(ppos+1)) < rc->Width)
---
>               if ((current_glyph+1 < num_widths+1) && ((w + *(ppos+1)) < rc->Width || rc->Width == 0))
1336c1336
<               if (y - rc->Y + font->sizeInPixels >= rc->Height)
---
>               if (rc->Height > 0 && y - rc->Y + font->sizeInPixels >= rc->Height)
1369,1370c1369,1370
<               boundingBox->Width = max;
<               boundingBox->Height = y;
---
>               boundingBox->Width = max + 1;
>               boundingBox->Height = y + 1;
