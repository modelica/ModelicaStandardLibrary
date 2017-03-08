All *.c files in this directory should be compiled by a tool vendor
to the following object libraries

- ModelicaExternalC (.lib, .dll, .a, .so, depending on tool and OS) containing:
  ModelicaFFT.c
  ModelicaInternal.c
  ModelicaRandom.c
  ModelicaStrings.c
  win32_dirent.c (for Visual C++ on Windows)

- ModelicaIO (.lib, .dll, .a, .so, depending on tool and OS) containing:
  ModelicaIO.c

- ModelicaMatIO (.lib, .dll, .a, .so, depending on tool and OS) containing:
  ModelicaMatIO.c

- ModelicaStandardTables (.lib, .dll, .a, .so, depending on tool and OS) containing:
  ModelicaStandardTables.c

- zlib (.lib, .dll, .a, .so, depending on tool and OS) containing:
  zlib/*.c

When the library annotation "ModelicaExternalC", "ModelicaIO" or
"ModelicaStandardTables" is utilized in an external Modelica function, then the
respective object library should be provided by the linker or should be
dynamically linked to the simulation environment.

For backwards-compatibility with the Modelica Standard Library (MSL) v3.2.1, a
tool vendor supporting MSL v3.2.1 and later releases has to provide the library
"ModelicaStandardTables" in such a way that the required library dependencies
(i.e., libraries "ModelicaIO", "ModelicaMatIO" and "zlib") are automatically
resolved. For instance, this can be achieved by building shared object
libraries (.dll, .so) and dynamically linking library "ModelicaStandardTables" to
"ModelicaIO", "ModelicaIO" to "ModelicaMatIO" and "ModelicaMatIO" to "zlib".

If dynamic link libraries (*.dll) are to be built by Visual C++ on Windows the
following linker optimization options in the Release configuration shall be set
- /OPT:NOREF (non-working default is /OPT:REF)
- /LTCG (non-working default for Visual Studio 2015 is /LTCG:incremental)
This is required for the projects including gconstructor.h, i.e.,
ModelicaExternalC.dll and ModelicaStandardTables.dll.

Build projects for the object libraries are provided under
  ../BuildProjects

Additionally, a tool vendor has to provide library "lapack"
(>= v3.1; download from http://www.netlib.org/lapack)
and this library should be used in the linker when a model is compiled
that uses this library in its library annotation.

March 08, 2017.
