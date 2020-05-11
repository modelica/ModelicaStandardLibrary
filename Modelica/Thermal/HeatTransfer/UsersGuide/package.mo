within Modelica.Thermal.HeatTransfer;
package UsersGuide "User's Guide"
  extends Modelica.Icons.Information;

  annotation (
    preferredView="info",
    DocumentationClass=true,
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

<div>
<img src=\"modelica://Modelica/Resources/Images/Thermal/HeatTransfer/driveWithHeatTransfer.png\" alt=\"driveWithHeatTransfer\">
</div>

<p>
The <strong>filled</strong> and <strong>non-filled red squares</strong> at the left and
right side of a component represent <strong>thermal ports</strong> (connector HeatPort).
Drawing a line between such squares means that they are thermally connected.
The variables of a HeatPort connector are the temperature <strong>T</strong> at the port
and the heat flow rate <strong>Q_flow</strong> flowing into the component (if Q_flow is positive,
the heat flows into the element, otherwise it flows out of the element):
</p>
<blockquote><pre>
Modelica.Units.SI.Temperature  T  \"Absolute temperature at port in Kelvin\";
Modelica.Units.SI.HeatFlowRate Q_flow  \"Flow rate at the port in Watt\";
</pre></blockquote>
<p>
Note, that all temperatures of this package, including initial conditions,
are given in Kelvin. For convenience, in subpackages <strong>HeatTransfer.Celsius</strong>,
 <strong>HeatTransfer.Fahrenheit</strong> and <strong>HeatTransfer.Rankine</strong> components are provided such that source and
sensor information is available in degree Celsius, degree Fahrenheit, or degree Rankine,
respectively. Additionally, in package <strong>Modelica.Units.Conversions</strong> conversion
functions between the units Kelvin and Celsius, Fahrenheit, Rankine are
provided. These functions may be used in the following way:
</p>
<blockquote><pre>
<strong>import</strong> Modelica.Units.SI;
<strong>import</strong> Modelica.Units.Conversions.from_degC;
...
<strong>parameter</strong> SI.Temperature T = from_degC(25);  // convert 25 degree Celsius to Kelvin
</pre></blockquote>

<p>
There are several other components available, such as AxialConduction (discretized PDE in
axial direction), which have been temporarily removed from this library. The reason is that
these components reference material properties, such as thermal conductivity, and currently
the Modelica design group is discussing a general scheme to describe material properties.
</p>
<p>
For technical details in the design of this library, see
[<a href=\"modelica://Modelica.Thermal.HeatTransfer.UsersGuide.References\">Tiller2001</a>].</p>
</html>"));
end UsersGuide;
