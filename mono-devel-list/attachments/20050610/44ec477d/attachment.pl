2005-06-09  Michael Cadilhac  <michael.cadilhac@lrde.epita.fr>

	* monoburg.c: Make the `usage' message more verbose.

2005-06-09  Michael Cadilhac  <michael.cadilhac@lrde.epita.fr>

	* monoburg.c: Add a `-n' option to precise the top #define used in
	the generated header.

2005-06-09  Michael Cadilhac  <michael.cadilhac@lrde.epita.fr>

	* parser.y,
	* monoburg.c,
	* monoburg.h: Rename "warn_cpp" function to "warn_cxx".

2005-06-09  Michael Cadilhac  <michael.cadilhac@lrde.epita.fr>

	* monoburg.c: Output MB_TERM* and MB_NTERM* in enums `MBTerms' and
	`MBNTerms'.

2005-06-09  Michael Cadilhac  <michael.cadilhac@lrde.epita.fr>

	* parser.y: Do not output "#line" directives when reading rules.

2005-06-09  Michael Cadilhac  <michael.cadilhac@lrde.epita.fr>

	* parser.y: Search through `include_dirs' paths for file to include.
	* monoburg.h,
	* monoburg.c: Add a `-I' option to precise include directories.

2005-06-09  Michael Cadilhac  <michael.cadilhac@lrde.epita.fr>

	* parser.y: Add `#line' directives output on `%include', CODE and
	in `yyparsetail'.
	* monoburg.c: Add `#line' directives output just before the call to
	`yyparse'.

2005-06-04  Michael Cadilhac  <michael.cadilhac@lrde.epita.fr>

	* config.h.in: New.
	* configure.ac: Output PACKAGE infos in config.h.
	* monoburg.c: Add `-v' and `--version' options.
	* Makefile.am: Fix distribution and cleaning rules.
	* monoburg.h: Include `config.h'.

2005-06-04  Michael Cadilhac  <michael.cadilhac@lrde.epita.fr>

	* parser.y:  Add  a  `%include'  directive  which  includes  files
	verbatim. Syntax is:
	%include filename
	without double quote or anything.
	
	This directive could be used anywhere.
	
	* parser.y (yyerror):   Enhance    verbosity   on   error  message
	accordingly.

	* monoburg.h: Add the info about included file storage.
	* monoburg.c: Update accordingly use of `inputfd'.

2005-06-04  Michael Cadilhac  <michael.cadilhac@lrde.epita.fr>

	* parser.y: Add  a  `%namespace' directive   which makes  monoburg
	output  functions in  a  namespace. This  directive could  produce
	nested namespaces. Syntax is:
	%namespace namespace1_name
	%namespace namespace2_name
	without double quote or anything.
	
	This directive  can only be  used in the  `rule' part of  the burg
	file.

	The user is warned that  the code produced will only be compilable
	with a C++ compiler.
	
	* parser.y (yylex):  Remove  a warning  when comparing  a `sizeof'
	with an int.
	
	* monoburg.c,
	* monoburg.h: Add `%namespace' handling.

2005-06-04  Michael Cadilhac  <michael.cadilhac@lrde.epita.fr>

	* monoburg.c:  Add   a  `--with-references'   option  which  makes
	monoburg to  produce `mono_burg_emit_*' functions  that takes tree
	as a `MBTREE&'.
	
	The user is warned that the code produced will only be compilable
	with a C++ compiler.
	
	* monoburg.c (emit_emmitter_func): Add fake use of arguments of 
	`emit' functions produced to avoid `unused parameter' warning when
	compiling output.

2005-06-04  Michael Cadilhac  <michael.cadilhac@lrde.epita.fr>

	* parser.y:  Add an optional `;' at  the end of an  empty rule, in
	the style of yacc(1).

2005-06-04  Michael Cadilhac  <michael.cadilhac@lrde.epita.fr>

	* monoburg.c: Add a `--without-exported-symbols' option which
	makes monoburg avoid defining external symbols as much as
	possible.
	Remove the weaker `--without-debug-tables'.

2005-06-04  Michael Cadilhac  <michael.cadilhac@lrde.epita.fr>

	* parser.y: Update according to mono-project repository.
	* monoburg.vcproj: New. Add according to mono-project repository.

2005-05-26  Sebastien Pouliot  <sebastien@ximian.com>

        * monoburg.vcproj: Project file for monobug.

2005-01-18  Zoltan Varga  <vargaz@freemail.hu>

        * monoburg.y (yyparsetail): Handle the case when the burg file does
        not end with an empty line.

2004-11-07  Benoit Perrot <benoit@lrde.epita.fr>

	* monoburg.c (emit_header): Extract includes emission.

2004-11-07  Benoit Perrot <benoit@lrde.epita.fr>

	* monoburg.c (emit_state): Do not forward define MBState type. 
	
2004-11-07  Benoit Perrot <benoit@lrde.epita.fr>

	* monoburg.c: Do not emit debug string tables when
	`--without-debug-tables' is specified.

2004-11-07  Benoit Perrot <benoit@lrde.epita.fr>

	* monoburg.c: Support long options; prefer `--without-glib' to
	`-g'.

2004-10-13  Benoit Perrot <benoit@lrde.epita.fr>

	* TODO: New.

2004-10-13  Benoit Perrot <benoit@lrde.epita.fr>

	* monoburg.c: Emit `stdio.h' and `stdlib.h' inclusions when `-g'
	is specified to kill warnings.

2004-10-13  Benoit Perrot <benoit@lrde.epita.fr>

	* monoburg.c: Emit code to generate a file that does not need glib to 
	compile. Add `-g' option to control this emission.

2004-10-06  Benoit Perrot <benoit@lrde.epita.fr>

	* monoburg.y: Rename to...
	* parser.y: This, and let automake automaticaly invoke bison to
	create `parser.c'.
	* Makefile.am: Let autoconf add the correct extension to the
	generated binary. Distribute `sample.brg' as a test.
	* config/Makefile.am: New.
	* configure.ac: New.
