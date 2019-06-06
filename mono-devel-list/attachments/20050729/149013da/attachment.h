/*
 * BinReloc - a library for creating relocatable executables
 * Written by: Hongli Lai <h.lai@chello.nl>
 * http://autopackage.org/
 *
 * This source code is public domain. You can relicense this code
 * under whatever license you want.
 *
 * See http://autopackage.org/docs/binreloc/ for
 * more information and how to use this.
 */

#ifndef __BINRELOC_H__
#define __BINRELOC_H__

#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */


typedef enum {
	/* Cannot allocate memory. */
	BR_FIND_EXE_NOMEM,
	/* Unable to open /proc/self/maps; see errno for details. */
	BR_FIND_EXE_OPEN_MAPS,
	/* Unable to read from /proc/self/maps; see errno for details. */
	BR_FIND_EXE_READ_MAPS,
	/* The file format of /proc/self/maps is invalid; kernel bug? */
	BR_FIND_EXE_INVALID_MAPS,
	/* BinReloc is disabled. */
	BR_FIND_EXE_DISABLED
} BrFindExeError;


/* Mangle symbol names to avoid symbol collisions with other ELF objects. */
#define br_init             uwTo16067537375518_br_init
#define br_init_lib         uwTo16067537375518_br_init_lib
#define br_find_exe         uwTo16067537375518_br_find_exe
#define br_find_prefix      uwTo16067537375518_br_find_prefix
#define br_find_bin_dir     uwTo16067537375518_br_find_bin_dir
#define br_find_sbin_dir    uwTo16067537375518_br_find_sbin_dir
#define br_find_data_dir    uwTo16067537375518_br_find_data_dir
#define br_find_locale_dir  uwTo16067537375518_br_find_locale_dir
#define br_find_lib_dir     uwTo16067537375518_br_find_lib_dir
#define br_find_libexec_dir uwTo16067537375518_br_find_libexec_dir
#define br_find_etc_dir     uwTo16067537375518_br_find_etc_dir
#define br_strcat           uwTo16067537375518_br_strcat
#define br_build_path       uwTo16067537375518_br_build_path
#define br_dirname          uwTo16067537375518_br_dirname


int   br_init             (BrFindExeError *error);
int   br_init_lib         ();

char *br_find_exe         (const char *default_exe);
char *br_find_prefix      (const char *default_prefix);
char *br_find_bin_dir     (const char *default_bin_dir);
char *br_find_sbin_dir    (const char *default_sbin_dir);
char *br_find_data_dir    (const char *default_data_dir);
char *br_find_locale_dir  (const char *default_locale_dir);
char *br_find_lib_dir     (const char *default_lib_dir);
char *br_find_libexec_dir (const char *default_libexec_dir);
char *br_find_etc_dir     (const char *default_etc_dir);

/* Utility functions */
char *br_strcat  (const char *str1, const char *str2);
char *br_build_path (const char *dir, const char *file);
char *br_dirname (const char *path);


#ifdef __cplusplus
}
#endif /* __cplusplus */

#endif /* __BINRELOC_H__ */
