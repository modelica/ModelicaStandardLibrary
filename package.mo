package Modelica "Modelica Standard Library"
annotation (
  Coordsys(
    extent=[0, 0; 169, 405], 
    grid=[1, 1], 
    component=[20, 20]), 
  Window(
    x=0.01, 
    y=0, 
    width=0.17, 
    height=0.59, 
    library=1, 
    autolayout=1), 
  Documentation(info="
<HTML>
<p> 
Package <b>Modelica</b> is a <b>standardized</b> and <b>pre-defined</b> package
that is developed together with the Modelica language from the
Modelica Design Group, see 
<a href=\"http://www.Modelica.org\">http://www.Modelica.org</a>.
It is also called <b>Modelica Standard Library</b>.
It provides constants, types, connectors, partial models and model 
components 
in various disciplines.
</p>

<p>
The Modelica package is <b>free</b> software and can be redistributed and/or
modified under the terms of the Modelica License and the accompanying 
disclaimer, displayed at the end of this documentation. 
</p>

<p>
The Modelica package consists currently of the following subpackages
</p>

<pre>
   <b>Constants</b>   Mathematical and physical constants (pi, eps, h, ...)
   <b>Icons</b>       Icon definitions of general interest
   <b>Math</b>        Mathematical functions (such as sin, cos)
   <b>SIunits</b>     SI-unit type definitions (such as Voltage, Torque)
    
   <b>Blocks</b>      Input/output blocks.
   <b>Electrical</b>  Electric and electronic components.
   <b>Mechanics</b>   Mechanical components (currently only 1D-rotational).
</pre>

<p>
In the near future these packages will be extended and more sublibraries
will be added, especially for thermo-hydraulic systems, 1D-translational
and 3D-mechanical systems, electric power devices etc.
</p>

<p>
In the Modelica package the following conventions are used: 
</p>

<ul>
<li>
The first two numbers of the version number characterize the
version of the Modelica language, for which the package is
designed. The remaining numbers characterize the version of the
library. E.g. library version 1.3.1 means that the Modelica Standard
Library is based on Modelica 1.3 and that this is the first (1)
version of the library.<br><br>
</li>

<li>
Class and instance names are written in upper and lower case 
letters, e.g., \"ElectricCurrent\". An underscore is only used 
at the end of a name to characterize a lower or upper index, 
e.g., body_low_up.<br><br>
</li>

<li>
Type names start always with an upper case letter. 
Instance names start always with a lower case letter with only 
a few exceptions, such as \"T\" for a temperature instance,
if this is common sense.<br><br>
</li>

<li>
A package XXX has its interface definitions in subpackage 
XXX.Interfaces, e.g., Electrical.Interfaces. <br><br>
</li>

<li>
Preferred instance names for connectors:
<pre>
  p,n: positive and negative side of a partial model. 
  a,b: side \"a\" and side \"b\" of a partial model 
       (= connectors are completely equivalent). 
</pre>
</li>
</ul>
<br><br>

<dl>
<dt><b>Main Author:</b>
<dd>People from the Modelica Design Group<br>
    Homepage: <a href=\"http://www.Modelica.org\">http://www.Modelica.org</a>
</dl>
<br>

<p><b>Release Notes:</b></p>
<ul>
<li><i>Version 1.3.1 (Dec. 13, 1999)</i><br>
First official release of the library.</li>
</ul>
<br>

<p><b>THE MODELICA PACKAGE LICENSE</b> (Version 1.0 of June 29, 1999)</p>

<p>
The Modelica package (including its accompanying C-files) are permitted to
be redistributed and used in source and binary forms, with or without
modification, provided that the following conditions are met:
</p>
<ol>
<li>
The author and copyright notices in the source files, these
license conditions and the disclaimer below are (a) retained
and (b) reproduced in the documentation provided with the
distribution.
</li>

<li>
Modifications of the original source files are allowed, provided
that a prominent notice is inserted in each changed file and the
accompanying documentation, stating how and when the file
was modified, and provided that the conditions under (1) are met.
</li>

<li>
It is not allowed to charge a fee for the original version
or a modified version of the Modelica package, besides
a reasonable fee for distribution and support. The Modelica package 
may be distributed in aggregate with other (possibly commercial) 
programs as part of a larger (possibly commercial) software 
distribution provided that it is not advertised as a product of your own.
</li>
</ol>
<br>

<p><b>DISCLAIMER</b></p>

<p>
The Modelica package in its original or in a modified form is provided
\"as is\" and the copyright holder assumes no responsibility for its contents
what so ever. Any express or implied warranties, including, but not 
limited to, the implied warranties of merchantability and fitness for a
particular purpose are <b>disclaimed</b>. <b>In no event</b> shall the 
copyright holders, or any party who modify and/or redistribute the package,
<b>be liable</b> for any direct, indirect, incidental, special, exemplary, or
consequential damages, arising in any way out of the use of this software,
even if advised of the possibility of such damage.
</p>
<br>

<p><b>Copyright (C) 1999, Modelica Design Group.</b></p>

</HTML>
"), 
  Coordsys(
    extent=[0, 0; 517, 370], 
    grid=[2, 2], 
    component=[20, 20]), 
  Window(
    x=0.01, 
    y=0.14, 
    width=0.51, 
    height=0.62, 
    library=1, 
    autolayout=1));
end Modelica;
