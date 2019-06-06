#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <glib/gunicode.h>
#include <glib.h>

/*
  I've included this in my utf8_additions.patch file,
  its used in a couple of my methods.
*/
static const char trailingBytesForUTF8[256] = {
	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
	1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
	2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2, 3,3,3,3,3,3,3,3,4,4,4,4,5,5,0,0
};

/*
	I've included this in my utf8_additions.patch file,
	it's used by my_g_utf8_get_char
*/
static const gulong offsetsFromUTF8[6] = { 0x00000000UL, 0x00003080UL, 0x000E2080UL,
0x03C82080UL, 0xFA082080UL, 0x82082080UL };

/* This function will go under mono utilities, 
it was requested by Kumpera to speed up (Object.c) mono_string_new
This is in my mono_utils.patch */
gboolean my_utf8_validate_and_len (const gchar *source, glong* olength, const gchar** oend);

/* I've included this in my utf8_additions.patch file, adding to eglib */
#define my_g_utf8_next_char(p) p + (trailingBytesForUTF8[(guchar)(*p)] + 1)

/* I've included this in my utf8_additions.patch file, adding to eglib */
gunichar my_g_utf8_get_char (const gchar* src);

/* I've included this in my utf8_additions.patch file, adding to eglib */
glong my_g_utf8_strlen (const gchar *p, gssize max);

/* I've included this in my utf8_validate.patch file, it would replace the g_utf8_validate method
that is currently in eglib */
gboolean my_g_utf8_validate (const gchar *str, gssize max_len, const gchar **end);

/* This method was copied from mono svn eglib imlementation.  It's here to compare to glib */
gboolean eglib_g_utf8_validate (const gchar *str, gssize max_len, const gchar **end);

/* Used in this test file only */
int TestNextAndGet (const char* src, const char* end);

int
main ()
{
	TestAll();
	return 0;
}




int
TestAll()
{
	gchar buff[5] = {0, 0, 0, 0, 0};
	guint stopPoint = 0xFFFFFFFFUL;
	gboolean nextAndGet;
	guint* count = (guint*)&buff[0];

	const gchar* glibEnd;
	glong glibLen;
	gboolean glibRet;
	glong glibMaxLen;

	glong myUtilLen;
	glong myLen;
	glong myMaxLen;

	gboolean myRet;
	gboolean myUtilRet;
	gboolean eglibRet;

	const gchar* myEnd;
	const gchar* myUtilEnd;
	const gchar* eglibEnd;

	guint totalNextAndGetDiffs = 0;

	guint totalEglibValDiffs = 0;
	guint totalEglibEndDiffs = 0;

	guint totalMyUtilValDiffs = 0;
	guint totalMyUtilEndDiffs = 0;
	guint totalMyUtilLenDiffs = 0;
	guint totalMyUtilLenDiffsOnInvalids = 0;

	guint totalMyValDiffs = 0;
	guint totalMyEndDiffs = 0;
	guint totalMyLenDiffs = 0;
	guint totalMyLenDiffsOnInvalids = 0;
	guint totalMyLenDiffsOnMaxParam = 0;

	for (; *count < stopPoint; *count+=0x01) {

		glibRet = g_utf8_validate (buff, -1, &glibEnd);
		glibLen = g_utf8_strlen (buff, -1);

		myUtilRet = my_utf8_validate_and_len(buff, &myUtilLen, &myUtilEnd);

		myRet = my_g_utf8_validate (buff, -1, &myEnd);
		myLen = my_g_utf8_strlen (buff, -1);

		eglibRet = eglib_g_utf8_validate (buff, -1, &eglibEnd);

		/* Compare Validates to glib */
		if (myUtilRet != glibRet)
			totalMyUtilValDiffs++;

		if (myRet != glibRet)
			totalMyValDiffs++;

		if (eglibRet != glibRet)
			totalEglibValDiffs++;

		/* Compare end parameter in Validate to glib's */
		if (myUtilEnd != glibEnd)
			totalMyUtilEndDiffs++;

		if (myEnd != glibEnd)
			totalMyEndDiffs++;

		if (eglibEnd != glibEnd)
			totalEglibEndDiffs++;

		if (glibRet) {
			/* Compare length to glib's. */
			if (myUtilLen != glibLen)
				totalMyUtilLenDiffs++;

			if (myLen != glibLen)
				totalMyLenDiffs++;

			//If glib says its valid.  Then we can test my_g_utf8_get_char & next_char
			nextAndGet = TestNextAndGet (buff, myEnd);
			if (nextAndGet != 1)
				totalNextAndGetDiffs++;
		}
		else {
			/* Compare length to glib's. But increment a different counter for invalid strings. */
			if (myUtilLen != glibLen)
				totalMyUtilLenDiffsOnInvalids++;

			if (myLen != glibLen)
				totalMyLenDiffsOnInvalids++;
		}

	}
	printf ("---------Results------------\n");
	printf ("(my_utf8_validate_and_len)\tValidate Diffs = %i\n", totalMyUtilValDiffs);
	printf ("(my_utf8_validate_and_len)\tEnd Diffs = %i\n", totalMyUtilEndDiffs);
	printf ("(my_utf8_validate_and_len)\tLength Diffs On Valid Strings = %i\n", totalMyUtilLenDiffs);
	printf ("(my_utf8_validate_and_len)\tLength Diffs On Invalid Strings = %i\n", totalMyUtilLenDiffsOnInvalids);

	printf ("(my_g_utf8_validate)\t\tValidate Diffs = %i\n", totalMyValDiffs);
	printf ("(my_g_utf8_validate)\t\tEnd Diffs = %i\n", totalMyEndDiffs);
	printf ("(my_g_utf8_strlen)\t\tLength Diffs On Valid Strings = %i\n", totalMyLenDiffs);
	printf ("(my_g_utf8_strlen)\t\tLength Diffs On Invalid Strings = %i\n", totalMyUtilLenDiffsOnInvalids);

	printf ("(eglib_g_utf8_validate)\t\tValidate Diffs = %i\n", totalEglibValDiffs);
	printf ("(eglib_g_utf8_validate)\t\tEnd Diffs = %i\n", totalEglibEndDiffs);

	printf ("(my_g_utf8_next_char) & (my_g_utf8_get_char)\tDiffs = %i\n", totalNextAndGetDiffs);

	return 1;
}

int
TestNextAndGet (const char* src, const char* end)
{
	int retval = 1;
	int retget = 1;
	guchar* ptr = (guchar*) src;
	guchar* ptrGlib = (guchar*) src;
	guchar* uend = (guchar*) end;
	gunichar val_utf16;
	gunichar val_utf16Glib;

	while (ptrGlib < uend)
	{
		val_utf16 = my_g_utf8_get_char (ptr);
		val_utf16Glib = g_utf8_get_char (ptrGlib);
		ptr = my_g_utf8_next_char (ptr);
		ptrGlib = g_utf8_next_char (ptrGlib);

		if (ptr != ptrGlib)
			retval = FALSE;
		if (val_utf16 != val_utf16Glib)
			retget = FALSE;
	}
	if(ptr != uend || ptrGlib != uend)
		retval = FALSE;

	if(!retval && !retget)
		return 0;
	if(retval && !retget)
		return -1;
	if(!retval && retget)
		return -2;
	return 1;
}

/**
 * g_utf8_get_char
 * @src: Pointer to UTF-8 encoded character.
 *
 * Return value: UTF-16 value of @src
 **/
gunichar
my_g_utf8_get_char (const gchar* src)
{
	gunichar ch = 0;
	guchar* ptr = (guchar*) src;
	gushort extraBytesToRead = trailingBytesForUTF8 [*ptr];

	switch (extraBytesToRead) {
	case 5: ch += *ptr++; ch <<= 6; /* remember, illegal UTF-8 */
	case 4: ch += *ptr++; ch <<= 6; /* remember, illegal UTF-8 */
	case 3: ch += *ptr++; ch <<= 6;
	case 2: ch += *ptr++; ch <<= 6;
	case 1: ch += *ptr++; ch <<= 6;
	case 0: ch += *ptr;
	}
	ch -= offsetsFromUTF8 [extraBytesToRead];
	return ch;
}

/**
 * g_utf8_validate_and_len
 * @source: Pointer to putative UTF-8 encoded string.
 *
 * Checks @source for being valid UTF-8. @utf is assumed to be
 * null-terminated.
 *
 * Return value: true if @source is valid.
 * oEnd : will equal the null terminator at the end of the string if valid.
 *    if not valid, it will equal the first charater of the invalid sequence.
 * oLengh : will equal the length to @oEnd
 **/
gboolean
my_utf8_validate_and_len (const gchar *source, glong* oLength, const gchar** oEnd)
{
	gboolean retVal = TRUE;
	gboolean lastRet = TRUE;
	guchar* ptr = (guchar*) source;
	guchar* srcPtr;
	guint length;
	guchar a;
	*oLength = 0;
	while (*ptr != 0) {
		length = trailingBytesForUTF8 [*ptr] + 1;
		srcPtr = (guchar*) ptr + length;
		switch (length) {
		default: retVal = FALSE;
		/* Everything else falls through when "TRUE"... */
		case 4: if ((a = (*--srcPtr)) < (guchar) 0x80 || a > (guchar) 0xBF) retVal = FALSE;
				if ((a == (guchar) 0xBF || a == (guchar) 0xBE) && *(srcPtr-1) == (guchar) 0xBF) {
				if (*(srcPtr-2) == (guchar) 0x8F || *(srcPtr-2) == (guchar) 0x9F ||
					*(srcPtr-2) == (guchar) 0xAF || *(srcPtr-2) == (guchar) 0xBF)
					retVal = FALSE;
				}
		case 3: if ((a = (*--srcPtr)) < (guchar) 0x80 || a > (guchar) 0xBF) retVal = FALSE;
		case 2: if ((a = (*--srcPtr)) < (guchar) 0x80 || a > (guchar) 0xBF) retVal = FALSE;

		switch (*ptr) {
		/* no fall-through in this inner switch */
		case 0xE0: if (a < (guchar) 0xA0) retVal = FALSE; break;
		case 0xED: if (a > (guchar) 0x9F) retVal = FALSE; break;
		case 0xEF: if (a == (guchar)0xB7 && (*(srcPtr+1) > (guchar) 0x8F && *(srcPtr+1) < 0xB0)) retVal = FALSE;
				   if (a == (guchar)0xBF && (*(srcPtr+1) == (guchar) 0xBE || *(srcPtr+1) == 0xBF)) retVal = FALSE; break;
		case 0xF0: if (a < (guchar) 0x90) retVal = FALSE; break;
		case 0xF4: if (a > (guchar) 0x8F) retVal = FALSE; break;
		default:   if (a < (guchar) 0x80) retVal = FALSE;
		}

		case 1: if (*ptr >= (guchar ) 0x80 && *ptr < (guchar) 0xC2) retVal = FALSE;
		}
		if (*ptr > (guchar) 0xF4)
			retVal = FALSE;
		//If the string is invalid, set the end to the invalid byte.
		if (!retVal && lastRet) {
			if (oEnd != NULL)
				*oEnd = ptr;
			lastRet = FALSE;
		}
		ptr += length;
		(*oLength)++;
	}
	if (retVal && oEnd != NULL)
		*oEnd = ptr;
	return retVal;
}
gboolean
my_g_utf8_validate (const gchar *str, gssize max_len, const gchar **end)
{
	glong byteCount = 0;
	gboolean retVal = TRUE;
	gboolean lastRet = TRUE;
	guchar* ptr = (guchar*) str;
	guchar a;
	guint length;
	guchar* srcPtr;
	if (max_len == 0)
		return 0;
	else if (max_len < 0)
		byteCount = max_len;
	while (*ptr != 0 && byteCount <= max_len) {
		length = trailingBytesForUTF8 [*ptr] + 1;
		srcPtr = (guchar*) ptr + length;
		switch (length) {
		default: retVal = FALSE;
		/* Everything else falls through when "TRUE"... */
		case 4: if ((a = (*--srcPtr)) < (guchar) 0x80 || a > (guchar) 0xBF) retVal = FALSE;
				if ((a == (guchar) 0xBF || a == (guchar) 0xBE) && *(srcPtr-1) == (guchar) 0xBF) {
				if (*(srcPtr-2) == (guchar) 0x8F || *(srcPtr-2) == (guchar) 0x9F ||
					*(srcPtr-2) == (guchar) 0xAF || *(srcPtr-2) == (guchar) 0xBF)
					retVal = FALSE;
				}
		case 3: if ((a = (*--srcPtr)) < (guchar) 0x80 || a > (guchar) 0xBF) retVal = FALSE;
		case 2: if ((a = (*--srcPtr)) < (guchar) 0x80 || a > (guchar) 0xBF) retVal = FALSE;

		switch (*ptr) {
		/* no fall-through in this inner switch */
		case 0xE0: if (a < (guchar) 0xA0) retVal = FALSE; break;
		case 0xED: if (a > (guchar) 0x9F) retVal = FALSE; break;
		case 0xEF: if (a == (guchar)0xB7 && (*(srcPtr+1) > (guchar) 0x8F && *(srcPtr+1) < 0xB0)) retVal = FALSE;
				   if (a == (guchar)0xBF && (*(srcPtr+1) == (guchar) 0xBE || *(srcPtr+1) == 0xBF)) retVal = FALSE; break;
		case 0xF0: if (a < (guchar) 0x90) retVal = FALSE; break;
		case 0xF4: if (a > (guchar) 0x8F) retVal = FALSE; break;
		default:   if (a < (guchar) 0x80) retVal = FALSE;
		}

		case 1: if (*ptr >= (guchar ) 0x80 && *ptr < (guchar) 0xC2) retVal = FALSE;
		}
		if (*ptr > (guchar) 0xF4)
			retVal = FALSE;
		//If the string is invalid, set the end to the invalid byte.
		if (!retVal && lastRet) {
			if (end != NULL)
				*end = ptr;
			lastRet = FALSE;
		}
		ptr += length;
		if(max_len > 0)
			byteCount += length;
	}
	if (retVal && end != NULL)
		*end = ptr;
	return retVal;
}

glong
my_g_utf8_strlen (const gchar *p, gssize max)
{
	glong byteCount = 0;
	guchar* ptr = (guchar*) p;
	glong length = 0;
	if (max == 0)
		return 0;
	else if (max < 0)
		byteCount = max;
	while (*ptr != 0 && byteCount <= max) {
		guint cLen = trailingBytesForUTF8 [*ptr] + 1;
		if (max > 0 && (byteCount + cLen) > max)
			return length;
		ptr += cLen;
		length++;
		if (max > 0)
			byteCount += cLen;
	}
	return length;
}

gboolean
eglib_g_utf8_validate (const gchar *utf, gssize max_len, const gchar **end)
{
	int ix;
	
	g_return_val_if_fail (utf != NULL, FALSE);

	if (max_len == -1)
		max_len = strlen (utf);
	
	/*
	 * utf is a string of 1, 2, 3 or 4 bytes.  The valid strings
	 * are as follows (in "bit format"):
	 *    0xxxxxxx                                      valid 1-byte
	 *    110xxxxx 10xxxxxx                             valid 2-byte
	 *    1110xxxx 10xxxxxx 10xxxxxx                    valid 3-byte
	 *    11110xxx 10xxxxxx 10xxxxxx 10xxxxxx           valid 4-byte
	 */
	for (ix = 0; ix < max_len;) {      /* string is 0-terminated */
		unsigned char c;
		
		c = utf[ix];
		if ((c & 0x80) == 0x00) {	/* 1-byte code, starts with 10 */
			ix++;
		} else if ((c & 0xe0) == 0xc0) {/* 2-byte code, starts with 110 */
			if (((ix+1) >= max_len) || (utf[ix+1] & 0xc0 ) != 0x80){
				if (end != NULL)
					*end = &utf [ix];
				return FALSE;
			}
			ix += 2;
		} else if ((c & 0xf0) == 0xe0) {/* 3-byte code, starts with 1110 */
			if (((ix + 2) >= max_len) || 
			    ((utf[ix+1] & 0xc0) != 0x80) ||
			    ((utf[ix+2] & 0xc0) != 0x80)){
				if (end != NULL)
					*end = &utf [ix];
				return FALSE;
			}
			ix += 3;
		} else if ((c & 0xf8) == 0xf0) {/* 4-byte code, starts with 11110 */
			if (((ix + 3) >= max_len) ||
			    ((utf[ix+1] & 0xc0) != 0x80) ||
			    ((utf[ix+2] & 0xc0) != 0x80) ||
			    ((utf[ix+3] & 0xc0) != 0x80)){
				if (end != NULL)
					*end = &utf [ix];
				return FALSE;
			}
			ix += 4;
		} else {/* unknown encoding */
			if (end != NULL)
				*end = &utf [ix];
			return FALSE;
		}
	}
	
	return TRUE;
}