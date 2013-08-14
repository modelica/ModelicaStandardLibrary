This directory contains build projects to construct object libraries
from the C-code under ../C-Sources

- ModelicaStandardTables (.lib, .dll, .a, .so, depending on tool)
  This library contains
  ../C-Sources/ModelicaStandardTables.c
              /ModelicaMatIO.c

The intention is that interested tool vendors can build these libraries
by using the provided build projects as a start.

Note, the tool vendors are responsible for building the binary libaries
and including them in their tools.

July 2, 2013.
