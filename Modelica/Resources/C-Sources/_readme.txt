All *.c files in this directory should be compiled by a tool vendor
to the object library "ModelicaExternalC" and this library should be
used in the linker when a model is compiled that uses this library
in its library annotation.

Additionally, a tool vendor has to provide library "lapack"
(>= version 3.1; download from http://www.netlib.org/lapack)
and this library should be used in the linker when a model is compiled
that uses this library in its library annotation.
