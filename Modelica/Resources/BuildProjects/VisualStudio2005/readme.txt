This directory contains Microsoft Visual Studio projects to construct object
libraries from the C-code under Resources/C-Sources

- ModelicaStandardTables.lib
  This library contains
  ../../C-Sources/ModelicaStandardTables.c
  ../../C-Sources/ModelicaStandardTablesUsertab.c

- ModelicaIO.lib
  This library contains
  ../../C-Sources/ModelicaIO.c

- ModelicaMatIO.lib
  This library contains
  ../../C-Sources/ModelicaMatIO.c
  ../../C-Sources/snprintf.c

- zlib.lib
  This library contains
  ../../C-Sources/zlib/*.c

- The LIB Release configuration builds a static library (*.lib) with /MT
  and can therefore be used with Dymola.
