This directory contains Microsoft Visual Studio projects to construct object
libraries from the C-code under Resources/C-Sources

- ModelicaStandardTables (.lib, .dll)
  This library contains
  Resources/C-Sources/ModelicaStandardTables.c
                     /ModelicaMatIO.c

- The LIB Release configuration builds a static library (*.lib) with /MT
  and can therefore be used with Dymola.

- The DLL Release configuration also compiles the SimulationX-specific
  ModelicaUtilities (ITI_ModelicaUtilities.cpp) and builds a dynamic
  link library (*.dll). It can therefore be used with SimulationX.