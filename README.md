# Modelica Standard Library

Free library from the Modelica Association to model mechanical (1D/3D), electrical (analog, digital, machines), thermal, fluid, control systems and hierarchical state machines. Also numerical functions and functions for strings, files and streams are included.

## Library description

Package `Modelica` is a free library that is developed together with the Modelica language from the Modelica Association. It is also called *Modelica Standard Library*. It provides model components and standard component interfaces from many engineering domains. Each model comes with [documentation](https://modelica.github.io/Modelica/) included. The generous [license conditions](https://www.modelica.org/licenses/ModelicaLicense2) allow usage in commercial products.

Note, the usage of a Modelica library requires a Modelica simulation environment, [see the tools page](https://www.modelica.org/tools/), and that such an environment usually already includes the Modelica standard library. It is possible that the demo version of the commercial tools will not allow to simulate non-trivial examples from the library.

![ModelicaLibraries](ModelicaLibraries.png)


## Current release

Download [Modelica Standard Library v3.2.1+build.4 (2015-09-30)](../../archive/v3.2.1+build.4.zip)

#### Release notes

* [Version v3.2.1+build.4 (2015-09-30)](../../archive/v3.2.1+build.4.zip)
    * Summary:
        * Version 3.2.1 (Build 4) is backward compatible to version 3.2.1 build 3, that is models developed with versions 3.0, 3.0.1, 3.1, 3.2 or 3.2.1 will work without any changes also with version 3.2.1 build 4 (see also issue (4) below, ticket <a href="https://trac.modelica.org/Modelica/ticket/1757">1757</a>).
        * This version is a bug-fix release.
    * Short Overview:
        1. This version of the Modelica package is compatible to Modelica Specification **3.2 revision 2** (with exception of issue (3) reported below and in [ticket 1758](https://trac.modelica.org/Modelica/ticket/1758)
        2. [10 tickets](http://htmlpreview.github.com/?https://github.com/modelica/ModelicaStandardLibrary/blob/release/Modelica%203.2.1/Resources/Documentation/Version-3.2.1/ResolvedTracTickets-build-4.html") have been fixed for this release. In particular the following **critical bug** has been fixed: Ticket [1768](https://trac.modelica.org/Modelica/ticket/1768) fixes an
issue with block `CombiTimeTable`(wrong output when using fixed time step integrator with time step
greater than table resolution).
        3. Ticket [1758](https://trac.modelica.org/Modelica/ticket/1758) states that simulation of `Modelica.Fluid.Examples.HeatingSystem` fails in Dymola 2016 if option "pedantic mode for checking Modelica semantics" is set. This issue was not fixed in the library.
        4. In ticket [1757](https://trac.modelica.org/Modelica/ticket/1757) it is
(correctly) stated that the example model `PsychrometricData` was moved to another location and that this is a non-backwards compatible change. This non-backwards compatible change is
accepted, because it fixes a circular depedency (a model references
a package in which it resides), for details see ticket [1679](https://trac.modelica.org/Modelica/ticket/1679). Fixing this ticket is seen as of much higher priority, as the small
drawback that an example model is moved (and the probability is very high that this moved model is not used in any user model).
        5. In the release notes of build 3 it is stated that no models, blocks, or functions have been newly introduced. This is not correct.
    * [Detailed Release Notes](http://htmlpreview.github.com/?https://github.com/modelica/ModelicaStandardLibrary/blob/release/Modelica%203.2.1/Resources/help/Modelica.UsersGuide.ReleaseNotes.Version_3_2_1_build_4.html)
* [Version v3.2.1+build.3 (2015-07-30)](../../archive/v3.2.1+build.3.zip)
    * Summary: Version 3.2.1 (Build 3) is backward compatible to version 3.2.1 (Build 2), that is models developed with versions 3.0, 3.0.1, 3.1, 3.2 or 3.2.1 will work without any changes also with version 3.2.1 build 3. This version is a bug-fix release.
    * Short Overview:
        * This version of the Modelica package is **fully compatible** to Modelica Specification **3.2 revision 2**.
        * About [103 tickets](http://htmlpreview.github.com/?https://github.com/modelica/ModelicaStandardLibrary/blob/release/Modelica%203.2.1/Resources/Documentation/Version-3.2.1/ResolvedTracTickets-build-3.html) have been fixed for this release.
        * **No** models and blocks and functions are newly included.
    * [Detailed Release Notes](http://htmlpreview.github.com/?https://github.com/modelica/ModelicaStandardLibrary/blob/release/Modelica%203.2.1/Resources/help/Modelica.UsersGuide.ReleaseNotes.Version_3_2_1_build_3.html)
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
