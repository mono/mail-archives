/* runs $INTERPRETER $ORIGIN/../$PREFIXPATH where:

   $INTERPRETER is defined below
   $ORIGIN is the absolute path of wherever this binary is placed on the system
   $PREFIXPATH is by default "lib/$SELFNAME/$SELFNAME"

   and
   
   $SELFNAME is whatever this binary is named

   but you can override $PREFIXPATH from the command line.
   
 */


#define INTERPRETER "mono"
#define SETCWD 1	/* change working dir? */

#ifndef PREFIXPATH
# define PREFIXPATH "lib/%s/%s"
#endif

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>

#include "binreloc.h"

int main(int argc, char **argv)
{
    BrFindExeError error;
    if (!br_init(&error))
    {
	fprintf(stderr, "%s: unable to locate myself: %d\n", argv[0], error);
	exit(1);
    }

    char *prefix = br_find_prefix("");
    if (*prefix == '\0') exit(1);

    char *selfname = br_find_exe("");
    if (*selfname == '\0') exit(1);
    selfname = strrchr(selfname, '/') + 1;
    
    char *prefixpath = malloc(strlen(PREFIXPATH) - 4 + (strlen(selfname) * 2) + 1);
    sprintf(prefixpath, PREFIXPATH, selfname, selfname);
    
    char *path = br_build_path(prefix, prefixpath);
    char **newargv = malloc(sizeof(char*) * argc + 3);
    newargv[0] = INTERPRETER;
    newargv[1] = path;
    
    int i;
    for (i = 1; i < argc; i++)
	newargv[i + 1] = argv[i];
    newargv[i + 1] = NULL;

    setenv("CURRENT_PREFIX", prefix, 1);

    if (SETCWD)
    {
	char *tmp = strdup(path);
	*strrchr(tmp, '/') = 0;
	chdir(tmp);
    }

    printf("%s\n", path);
    execvp(INTERPRETER, newargv);
    perror(selfname);

    return errno;
}
