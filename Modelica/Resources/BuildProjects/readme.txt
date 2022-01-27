This directory contains build projects to construct object libraries
from the C-code under ../C-Sources

- ModelicaStandardTables (.lib, .dll, .a, .so, depending on tool)
  This library contains
  ../C-Sources/ModelicaStandardTables.c
  ../C-Sources/ModelicaStandardTablesUsertab.c

- ModelicaIO (.lib, .dll, .a, .so, depending on tool and OS):
  This library contains
  ../C-Sources/ModelicaIO.c

- ModelicaMatIO (.lib, .dll, .a, .so, depending on tool and OS)
  This library contains
  ../C-Sources/ModelicaMatIO.c
  ../C-Sources/snprintf.c

- zlib (.lib, .dll, .a, .so, depending on tool and OS):
  This library contains
  ../C-Sources/zlib/*.c

The intention is that interested tool vendors can build these libraries
by using the provided build projects as a start.

The tool vendors are responsible for building the binary libraries
and including them in their tools.

When building the binary libraries by VisualStudio2005 the environment
variable MODELICA_UTILITIES_INCLUDE needs to be set to the path of the
(tool-vendor-specific) ModelicaUtilities.h header file.

September 24, 2021
