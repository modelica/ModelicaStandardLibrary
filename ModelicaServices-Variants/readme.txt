This directory contains different implementations of the
ModelicaServices library (which contains model that requires
a tool-specific implementation):

- Default
  The default implementation which works for every tool,
  but does not provide any functionality (e.g. no 3D visualization).

- Dymola
  An implementation for Dymola using Dymola-specific
  API-functions and variable naming.

- Dymola-And-DLR-Visualization
  An implementation for Dymola, where the 3D visualiation is
  optionally performed with the DLR Visualization library.


You need to select one of these implementations or provide your own one.
The selected ModelicaServices library should be included in the
library search path of your tool.
