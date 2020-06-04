within Modelica;
package Clocked "Clock triggered blocks for describing synchronous behavior suited for implementation of control
systems"
extends Modelica.Icons.Package;

  annotation (preferredView="info",
  Documentation(info="<html>
<p>
Library <strong>Modelica.Clocked</strong> is a Modelica package
to precisely define and synchronize sampled data systems with different sampling rates.
The library has elements to define periodic clocks and event clocks that trigger elements to sample, sub-sample, super-sample, or shift-sample partitions synchronously. Optionally, quantization effects, computational delay or noise can be simulated. Continuous-time equations can be automatically discretized and utilized in a sampled data system. The sample rate of
a partition need to be defined only at one location.
</p>

<p>
In the following
<a href=\"modelica://Modelica.Clocked.Examples.SimpleControlledDrive.ClockedWithDiscreteController\">example</a>
a simple sampled data system is shown, where the borders of the
discrete-time partition are marked by the sample and hold operators, a clocked PI
controller is used in the partition and the sample
rate is defined at one location with a clock:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Clocked/SimpleSampledSystem.png\" alt=\"Simple sampled-data system\">
</div>
<p>
The initial version of this library was developed and released under the name <strong>Modelica_Synchronous</strong> library
before the library became a package of the Modelica Standard Library using the name <strong>Modelica.Clocked</strong>.
The basic principles and components are the same as in the initial library, therefore the introductory material
for <strong>Modelica_Synchronous</strong> is still valid, in particular:
</p>
<ul>
<li> <a href=\"modelica://Modelica/Resources/Documentation/Clocked/Modelica_Synchronous.pdf\">Modelica_Synchronous.pdf</a>
     is a slide set that provides an overview of the Library.</li>
<li><a href=\"https://www.doi.org/10.3384/ecp1207627\">A Library for Synchronous Control Systems in Modelica</a> is the corresponding paper.</li>
</ul>
<p>
Furthermore:
</p>
<ul>
<li> <a href=\"modelica://Modelica.Clocked.UsersGuide\">User's Guide</a>
     discusses the most important aspects of this library.</li>
<li><a href=\"modelica://Modelica.Clocked.UsersGuide.ReleaseNotes\">Release Notes</a>
     summarizes the changes of the library releases.</li>
<li> <a href=\"modelica://Modelica.Clocked.UsersGuide.Contact\">Contact</a>
     gives author and acknowledgement information for this library.</li>
</ul>
<p>
<em>Copyright &copy; 2012-2020, Modelica Association and contributors.</em>
</p>
</html>",
revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> Aug. 28, 2012 </td>
    <td>
    <table border=\"0\">
    <tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
    </td><td valign=\"bottom\">
    Initial version implemented by M. Otter and B. Thiele released as <em>Modelica_Synchronous</em> (version 0.9) library.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
    </td></tr>
    </table>
</td></tr>

<tr><td></td><td>Several releases as <em>Modelica_Synchronous</em> library.</td></tr>

<tr><td> 2019 </td><td>The <em>Modelica_Synchronous</em> library is included as <em>Modelica.Clocked</em> in the Modelica Standard Library 4.0.0.</td></tr>

<tr><td></td><td>see <a href=\"modelica://Modelica.Clocked.UsersGuide.ReleaseNotes\">Release Notes</a>.</td></tr>

</table>
</html>"),
    Icon(
      coordinateSystem(
        extent = {{-100, -100}, {100, 100}},
        preserveAspectRatio = true),
      graphics={
        Ellipse(extent = {{-80, -80}, {80, 80}}),
        Line(points = {{80, 0}, {60, 0}}),
        Line(points = {{69.282, 40}, {51.962, 30}}),
        Line(points = {{40, 69.282}, {30, 51.962}}),
        Line(points = {{0, 80}, {0, 60}}),
        Line(points = {{-40, 69.282}, {-30, 51.962}}),
        Line(points = {{-69.282, 40}, {-51.962, 30}}),
        Line(points = {{-80, 0}, {-60, 0}}),
        Line(points = {{-69.282, -40}, {-51.962, -30}}),
        Line(points = {{-40, -69.282}, {-30, -51.962}}),
        Line(points = {{0, -80}, {0, -60}}),
        Line(points = {{40, -69.282}, {30, -51.962}}),
        Line(points = {{69.282, -40}, {51.962, -30}}),
        Line(points = {{80, 0}, {60, 0}}),
        Line(points = {{0, 0}, {-50, 50}}),
        Line(points = {{0, 0}, {40, 0}})}));
end Clocked;
