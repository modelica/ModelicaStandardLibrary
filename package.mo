package Modelica "Modelica Standard Library"


extends Icons.Library;


annotation (
  Window(
    x=0.02,
    y=0.01,
    width=0.2,
    height=0.57,
    library=1,
    autolayout=1),
  Documentation(info="
<HTML>
<p>
Package <b>Modelica</b> is a <b>standardized</b> and <b>pre-defined</b> package
that is developed together with the Modelica language from the
Modelica Association, see
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
   <b>Mechanics</b>   Mechanical components
               (currently: 1D-rotational and 1D-translational components)
   <b>Thermal</b>     Thermal components
               (currently: 1-D heat transfer with lumped elements)
</pre>

<p>
In the Modelica package the following conventions are used:
</p>

<ul>
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
<dd>People from the Modelica Association<br>
    Homepage: <a href=\"http://www.Modelica.org\">http://www.Modelica.org</a>
</dl>
<br>

<p><b>Release Notes:</b></p>
<ul>
<li><i>Version 1.5 (December 16, 2002)</i><br>
    Encapsulated all example models, added new package
    <b>Thermal.HeatTransfer</b> for modeling of lumped
    heat transfer, added model <b>LossyGear</b> in Mechanics.Rotational
    to model gear efficiency and bearing friction according to a new
    theory in a robust way, added 10 new models in Electrical.Analog and
    added several other new models and improved existing models. In total,
    55 new components have been added. A
    <a href=\"../Documentation/ChangeNotes1.5.html\">description</a>
    of the changes is available.
    </li>
<li><i>Version 1.4.1 (June 28, 2001)</i><br>
    Several minor bugs fixed. New models:
    Modelica.Blocks.Interfaces.IntegerInPort/IntegerOutPort,
    Modelica.Blocks.Math.TwoInputs/TwoOutputs
    Modelica.Electrical.Analog.Ideal.IdealOpAmp3Pin,
    Modelica.Mechanics.Rotational.Move,
    Modelica.Mechanics.Translational.Move.
    </li>

<li><i>Version 1.4.1beta1 (February 12, 2001)</i><br>
    Adapted to Modelica 1.4</li>

<li><i>Version 1.3.2beta2 (June 20, 2000)</i><br>
    <ul>
    <li>New subpackage Modelica.Mechanics.<b>Translational</b></li>

    <li>Changes to Modelica.Mechanics.<b>Rotational</b>:<br>
       New elements:
<pre>
   IdealGearR2T    Ideal gear transforming rotational in translational motion.
   Position        Forced movement of a flange with a reference angle
                   given as input signal
   RelativeStates  Definition of relative state variables
</pre>
</li>

    <li>Changes to Modelica.<b>SIunits</b>:<br>
      Introduced new types:<br>
      type Temperature = ThermodynamicTemperature;<br>
      types DerDensityByEnthalpy, DerDensityByPressure,
      DerDensityByTemperature, DerEnthalpyByPressure,
      DerEnergyByDensity, DerEnergyByPressure<br>
      Attribute \"final\" removed from min and max values
      in order that these values can still be changed to narrow
      the allowed range of values.<br>
      Quantity=\"Stress\" removed from type \"Stress\", in order
      that a type \"Stress\" can be connected to a type \"Pressure\".</li>

    <li>Changes to Modelica.<b>Icons</b>:<br>
       New icons for motors and gearboxes.</li>

    <li>Changes to Modelica.<b>Blocks.Interfaces</b>:<br>
       Introduced a replaceable signal type into
       Blocks.Interfaces.InPort/OutPort:
<pre>
   replaceable type SignalType = Real
</pre>
       in order that the type of the signal of an input/output block
       can be changed to a physical type, for example:

<pre>
   Sine sin1(outPort(redeclare type SignalType=Modelica.SIunits.Torque))
</pre>
      </li></ul>
</li>


<li><i>Version 1.3.1 (Dec. 13, 1999)</i><br>
First official release of the library.</li>
</ul>
<br>

<p><b>THE MODELICA LICENSE</b> (Version 1.1 of June 30, 2000)</p>

<p>Redistribution and use in source and binary forms, with or without
modification are permitted, provided that the following conditions are met:
<ol>
<li>
The author and copyright notices in the source files, these license conditions
and the disclaimer below are (a) retained and (b) reproduced in the documentation
provided with the distribution.</li>

<li>
Modifications of the original source files are allowed, provided that a
prominent notice is inserted in each changed file and the accompanying
documentation, stating how and when the file was modified, and provided
that the conditions under (1) are met.</li>

<li>
It is not allowed to charge a fee for the original version or a modified
version of the software, besides a reasonable fee for distribution and support.
Distribution in aggregate with other (possibly commercial) programs
as part of a larger (possibly commercial) software distribution is permitted,
provided that it is not advertised as a product of your own.</li>
</ol>

<p><b>DISCLAIMER</b>
<p>The software (sources, binaries, etc.) in their original or in a modified
form are provided
\"as is\" and the copyright holders assume no responsibility for its contents
what so ever. Any express or implied warranties, including, but not
limited to, the implied warranties of merchantability and fitness for a
particular purpose are <b>disclaimed</b>. <b>In no event</b> shall the
copyright holders, or any party who modify and/or redistribute the package,
<b>be liable</b> for any direct, indirect, incidental, special, exemplary, or
consequential damages, arising in any way out of the use of this software,
even if advised of the possibility of such damage.
</p>
<br>

<p><b>Copyright &copy; 1999-2002, Modelica Association.</b></p>

</HTML>
"));
end Modelica;
