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

Note, the tool vendors are responsible for building the binary libraries
and including them in their tools.

May 17, 2018
