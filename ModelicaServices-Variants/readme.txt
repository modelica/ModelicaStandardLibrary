This directory contains different implementations of the
ModelicaServices library (which contains models that require
a tool-specific implementation):

- Default
  The default implementation which works for every tool,
  but does not provide any functionality (e.g. no 3D visualization).

- Dymola
  An implementation for Dymola using Dymola-specific
  API-functions and variable naming.

- DymolaAndDLRVisualization
  An implementation for Dymola, where the 3D visualiation is
  optionally performed with the DLR Visualization library.


You need to select one of these implementations or provide your own one.
The selected ModelicaServices library should be included in the
library search path of your tool.


Note, all the implementations contain the tool specific annotation:

   __Dymola_Protection(hideFromBrowser=true)

in order to not show package ModelicaServices in the package browser
of Dymola (since this package should not be utilized by a user).
The package becomes visible, if option

   Edit / Options / Show protected classes in package browser

is enabled in Dymola.
