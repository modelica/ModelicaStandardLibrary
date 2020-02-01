within Modelica.Thermal.HeatTransfer;
package Celsius "Components with Celsius input and/or output"
  extends Modelica.Icons.VariantsPackage;

  annotation (Documentation(info="<html>
<p>
The components of this package are provided for the convenience of
people working mostly with Celsius units, since all models
in package HeatTransfer are based on Kelvin units.
</p>
<p>
Note, that in package <code>Modelica.Units.Conversions</code>, functions are provided
to convert between the units Kelvin, degree Celsius, degree Fahrenheit,
and degree Rankine. These functions allow, e.g., a direct conversion
of units at all places where Kelvin is required as parameter.
Example:
</p>
<blockquote><pre>
<strong>import</strong> Modelica.Units.Conversions.from_degC;
Modelica.Thermal.HeatTransfer.HeatCapacitor C(T0 = from_degC(20));
</pre></blockquote>
</html>"));
end Celsius;
