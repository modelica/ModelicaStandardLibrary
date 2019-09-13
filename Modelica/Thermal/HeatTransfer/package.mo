within Modelica.Thermal;
package HeatTransfer "Library of 1-dimensional heat transfer with lumped elements"
  extends Modelica.Icons.Package;
  annotation (
     Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}), graphics={
      Polygon(
        origin = {13.758,27.517},
        lineColor = {128,128,128},
        fillColor = {192,192,192},
        fillPattern = FillPattern.Solid,
        points = {{-54,-6},{-61,-7},{-75,-15},{-79,-24},{-80,-34},{-78,-42},{-73,-49},{-64,-51},{-57,-51},{-47,-50},{-41,-43},{-38,-35},{-40,-27},{-40,-20},{-42,-13},{-47,-7},{-54,-5},{-54,-6}}),
    Polygon(
        origin = {13.758,27.517},
        fillColor = {160,160,164},
        fillPattern = FillPattern.Solid,
        points = {{-75,-15},{-79,-25},{-80,-34},{-78,-42},{-72,-49},{-64,-51},{-57,-51},{-47,-50},{-57,-47},{-65,-45},{-71,-40},{-74,-33},{-76,-23},{-75,-15},{-75,-15}}),
      Polygon(
        origin = {13.758,27.517},
        lineColor = {160,160,164},
        fillColor = {192,192,192},
        fillPattern = FillPattern.Solid,
        points = {{39,-6},{32,-7},{18,-15},{14,-24},{13,-34},{15,-42},{20,-49},{29,-51},{36,-51},{46,-50},{52,-43},{55,-35},{53,-27},{53,-20},{51,-13},{46,-7},{39,-5},{39,-6}}),
      Polygon(
        origin = {13.758,27.517},
        fillColor = {160,160,164},
        fillPattern = FillPattern.Solid,
        points = {{18,-15},{14,-25},{13,-34},{15,-42},{21,-49},{29,-51},{36,-51},{46,-50},{36,-47},{28,-45},{22,-40},{19,-33},{17,-23},{18,-15},{18,-15}}),
      Polygon(
        origin = {13.758,27.517},
        lineColor = {191,0,0},
        fillColor = {191,0,0},
        fillPattern = FillPattern.Solid,
        points = {{-9,-23},{-9,-10},{18,-17},{-9,-23}}),
      Line(
        origin = {13.758,27.517},
        points = {{-41,-17},{-9,-17}},
        color = {191,0,0},
        thickness = 0.5),
      Line(
        origin = {13.758,27.517},
        points = {{-17,-40},{15,-40}},
        color = {191,0,0},
        thickness = 0.5),
      Polygon(
        origin = {13.758,27.517},
        lineColor = {191,0,0},
        fillColor = {191,0,0},
        fillPattern = FillPattern.Solid,
        points = {{-17,-46},{-17,-34},{-40,-40},{-17,-46}})}),
                            Documentation(info="<html>
<p>
This package contains components to model <strong>1-dimensional heat transfer</strong>
with lumped elements. This allows especially to model heat transfer in
machines provided the parameters of the lumped elements, such as
the heat capacity of a part, can be determined by measurements
(due to the complex geometries and many materials used in machines,
calculating the lumped element parameters from some basic analytic
formulas is usually not possible).
</p>
<p>
Example models how to use this library are given in subpackage <strong>Examples</strong>.<br>
For a first simple example, see <strong>Examples.TwoMasses</strong> where two masses
with different initial temperatures are getting in contact to each
other and arriving after some time at a common temperature.<br>
<strong>Examples.ControlledTemperature</strong> shows how to hold a temperature
within desired limits by switching on and off an electric resistor.<br>
A more realistic example is provided in <strong>Examples.Motor</strong> where the
heating of an electrical motor is modelled, see the following screen shot
of this example:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Thermal/HeatTransfer/driveWithHeatTransfer.png\" alt=\"driveWithHeatTransfer\">
</p>

<p>
The <strong>filled</strong> and <strong>non-filled red squares</strong> at the left and
right side of a component represent <strong>thermal ports</strong> (connector HeatPort).
Drawing a line between such squares means that they are thermally connected.
The variables of a HeatPort connector are the temperature <strong>T</strong> at the port
and the heat flow rate <strong>Q_flow</strong> flowing into the component (if Q_flow is positive,
the heat flows into the element, otherwise it flows out of the element):
</p>
<pre>   Modelica.SIunits.Temperature  T  \"absolute temperature at port in Kelvin\";
   Modelica.SIunits.HeatFlowRate Q_flow  \"flow rate at the port in Watt\";
</pre>
<p>
Note, that all temperatures of this package, including initial conditions,
are given in Kelvin. For convenience, in subpackages <strong>HeatTransfer.Celsius</strong>,
 <strong>HeatTransfer.Fahrenheit</strong> and <strong>HeatTransfer.Rankine</strong> components are provided such that source and
sensor information is available in degree Celsius, degree Fahrenheit, or degree Rankine,
respectively. Additionally, in package <strong>SIunits.Conversions</strong> conversion
functions between the units Kelvin and Celsius, Fahrenheit, Rankine are
provided. These functions may be used in the following way:
</p>
<pre>  <strong>import</strong> SI=Modelica.SIunits;
  <strong>import</strong> Modelica.SIunits.Conversions.*;
     ...
  <strong>parameter</strong> SI.Temperature T = from_degC(25);  // convert 25 degree Celsius to Kelvin
</pre>

<p>
There are several other components available, such as AxialConduction (discretized PDE in
axial direction), which have been temporarily removed from this library. The reason is that
these components reference material properties, such as thermal conductivity, and currently
the Modelica design group is discussing a general scheme to describe material properties.
</p>
<p>
For technical details in the design of this library, see the following reference:<br>
<strong>Michael Tiller (2001)</strong>: <a href=\"http://www.amazon.de\">
Introduction to Physical Modeling with Modelica</a>.
Kluwer Academic Publishers Boston.
</p>
<p>
<strong>Acknowledgements:</strong><br>
Several helpful remarks from the following persons are acknowledged:
John Batteh, Ford Motors, Dearborn, U.S.A;
<a href=\"https://www.haumer.at/\">Anton Haumer</a>, Technical Consulting &amp; Electrical Engineering, Germany;
Ludwig Marvan, VA TECH ELIN EBG Elektronik GmbH, Wien, Austria;
Hans Olsson, Dassault Syst&egrave;mes AB, Sweden;
Hubertus Tummescheit, Lund Institute of Technology, Lund, Sweden.
</p>
<dl>
  <dt><strong>Main Authors:</strong></dt>
  <dd>
  <p>
  <a href=\"https://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  D-93049 Regensburg, Germany<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
</p>
  </dd>
</dl>
<p>
Copyright &copy; 2001-2019, Modelica Association and contributors
</p>
</html>", revisions="<html>
<ul>
<li><em>July 15, 2002</em>
       by Michael Tiller, <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
       and Nikolaus Sch&uuml;rmann:<br>
       Implemented.
</li>
<li><em>June 13, 2005</em>
       by <a href=\"https://www.haumer.at/\">Anton Haumer</a><br>
       Refined placing of connectors (cosmetic).<br>
       Refined all Examples; removed Examples.FrequencyInverter, introducing Examples.Motor<br>
       Introduced temperature dependent correction (1 + alpha*(T - T_ref)) in Fixed/PrescribedHeatFlow<br>
</li>
  <li> v1.1.1 2007/11/13 Anton Haumer<br>
       components moved to sub-packages</li>
  <li> v1.2.0 2009/08/26 Anton Haumer<br>
       added component ThermalCollector</li>

</ul>
</html>"));
end HeatTransfer;
