# Modelica Standard Library

Free library from the Modelica Association to model mechanical (1D/3D), electrical (analog, digital, machines), thermal, fluid, control systems and hierarchical state machines. Also numerical functions and functions for strings, files and streams are included.

## Library description

Package `Modelica` is a free library that is developed together with the Modelica language from the Modelica Association. It is also called *Modelica Standard Library*. It provides model components and standard component interfaces from many engineering domains. Each model comes with [documentation](https://modelica.github.io/Modelica/) included. The generous [license conditions](https://www.modelica.org/licenses/ModelicaLicense2) allow usage in commercial products.

Note, the usage of a Modelica library requires a Modelica simulation environment, [see the tools page](https://www.modelica.org/tools/), and that such an environment usually already includes the Modelica standard library. It is possible that the demo version of the commerical tools will not allow to simulate non-trivial examples from the library.

![ModelicaLibraries](ModelicaLibraries.png)


## Current release

Download [Modelica Standard Library v3.2.1 (2013-08-14)](../../archive/v3.2.1+build.2.zip)

#### Release notes

* [Version v3.2.1 (2013-08-14)](../../archive/v3.2.1+build.2.zip)
  * Summary: Version 3.2.1 (Build 2) is backward compatible to version 3.2, that is models developed with versions 3.0, 3.0.1, 3.1, or 3.2 will work without any changes also with version 3.2.1. This is a "clean-up" with major emphasis on quality improvement and tool compatibility. The goal is that all Modelica tools will support this package and will interpret it in the same way. This version of the Modelica package is **fully compatible** to Modelica Specification **3.2 Revision 2**. 60 models and blocks and 90 functions were newly included.
  * [Detailed Release Notes](http://htmlpreview.github.com/?https://github.com/modelica/ModelicaStandardLibrary/blob/release/Modelica%203.2.1/Resources/help/Modelica.UsersGuide.ReleaseNotes.Version_3_2_1.html)
* [Version v3.2 (2010-10-25)](../../archive/v3.2.zip)
  * Summary: Version 3.2 (Build 5) is the new major release of the Modelica Standard Library. About 360 new models/blocks and 300 new functions are added, including 7 new sublibraries
  * [Detailed Release Notes](http://htmlpreview.github.com/?https://github.com/modelica/ModelicaStandardLibrary/blob/release/Modelica%203.2.1/Resources/help/Modelica.UsersGuide.ReleaseNotes.Version_3_2.html)
* [Version v3.1 (2009-08-14)](../../archive/v3.1.zip)
  * Summary: Version 3.1 is slightly based on the Modelica Specification 3.1.
  * [Detailed Release Notes](http://htmlpreview.github.com/?https://github.com/modelica/ModelicaStandardLibrary/blob/release/Modelica%203.2.1/Resources/help/Modelica.UsersGuide.ReleaseNotes.Version_3_1.html)
* [Version v3.0.1 (2009-01-27)](../../archive/v3.0.1.zip)
  * Summary: Slightly improved version of the Modelica Standard Library 3.0 (several new components added, existing components improved, bugs corrected, backward compatible).
  * [Detailed Release Notes](http://htmlpreview.github.com/?https://github.com/modelica/ModelicaStandardLibrary/blob/release/Modelica%203.2.1/Resources/help/Modelica.UsersGuide.ReleaseNotes.Version_3_0_1.html)
* [Version v3.0 (2008-03-01)](../../archive/v3.0.zip)
  * Summary: Version 3.0 is not backward compatible to previous versions. A conversion script is provided to transform models and libraries of previous versions to the new version.
  * [Detailed Release Notes](http://htmlpreview.github.com/?https://github.com/modelica/ModelicaStandardLibrary/blob/release/Modelica%203.2//Resources/help/Modelica.UsersGuide.ReleaseNotes.Version_3_0.html)
* [Version v2.2.2 (2007-08-31)](../../archive/v2.2.2.zip)
  * Summary: Version 2.2.2 is backward compatible to version 2.2.1 and 2.2 with the following exceptions:
    * Removal of package Modelica.Media.Interfaces.PartialTwoPhaseMediumWithCache (this was not yet utilized).
    * Removal of the media packages in Modelica.Media.IdealGases.SingleGases that are not type compatible to Modelica.Media.Interfaces.PartialMedium, because a FluidConstants record definition is missing.
  * [Detailed Release Notes](http://htmlpreview.github.com/?https://github.com/modelica/ModelicaStandardLibrary/blob/release/Modelica%203.2.1/Resources/help/Modelica.UsersGuide.ReleaseNotes.Version_2_2_2.html)
* [Version v2.2.1 (2006-03-24)](../../archive/v2.2.1.zip)
  * Summary: Version 2.2.1 is backward compatible to version 2.2. In this version, no new libraries have been added.
  * [Detailed Release Notes](http://htmlpreview.github.com/?https://github.com/modelica/ModelicaStandardLibrary/blob/release/Modelica%203.2//Resources/help/Modelica.UsersGuide.ReleaseNotes.Version_2_2_1.html)
* [Version v2.2 (2005-04-06)](../../archive/v2.2.zip)
  * Summary: Version 2.2 is backward compatible to version 2.1. Two new packages have been added, `Modelica.Media` and `Modelica.Thermal.FluidHeatFlow`.
  * [Detailed Release Notes](http://htmlpreview.github.com/?https://github.com/modelica/ModelicaStandardLibrary/blob/release/Modelica%203.2.1/Resources/help/Modelica.UsersGuide.ReleaseNotes.Version_2_2.html)
* [Version v2.1 (2004-11-11)](../../archive/v2.1.zip)
  * Summary: This is a major change with respect to previous versions of the Modelica Standard Library, because many new libraries and components are included and because the input/output blocks (Modelica.Blocks) have been considerably simplified.
  * [Detailed Release Notes](http://htmlpreview.github.com/?https://github.com/modelica/ModelicaStandardLibrary/blob/release/Modelica%203.2.1/Resources/help/Modelica.UsersGuide.ReleaseNotes.Version_2_1.html)
* [Version v1.6 (2004-06-21)](../../archive/v1.6.zip)
  * Summary: Added 1 new library (Electrical.MultiPhase), 17 new components, improved 3 existing components in the Modelica.Electrical library and improved 3 types in the Modelica.SIunits library.
  * [Detailed Release Notes](http://htmlpreview.github.com/?https://github.com/modelica/ModelicaStandardLibrary/blob/release/Modelica%203.2.1/Resources/help/Modelica.UsersGuide.ReleaseNotes.Version_1_6.html)


## License

This Modelica package is free software and the use is completely at your own risk;
it can be redistributed and/or modified under the terms of the [Modelica License 2](https://modelica.org/licenses/ModelicaLicense2).

## Development and contribution
The devolopment is organised by the [Modelica Association](https://www.modelica.org/association).

You may report any issues by using the [Modelica Issue Tracker](https://trac.modelica.org/Modelica/newticket).
