within Modelica.Thermal.HeatTransfer;
package Rankine "Components with Rankine input and/or output"
  extends Modelica.Icons.VariantsPackage;
  annotation (Documentation(info="<html>
<p>
The components of this package are provided for the convenience of
people working mostly with Rankine units, since all models
in package HeatTransfer are based on Kelvin units.
</p>
<p>
Note, that in package SIunits.Conversions, functions are provided
to convert between the units Kelvin, degree Celsius, degree Fahrenheit
and degree Rankine. These functions allow, e.g., a direct conversion
of units at all places where Kelvin is required as parameter.
Example:
</p>
<pre>
    <strong>import</strong> Modelica.SIunits.Conversions.from_degRk;
    Modelica.Thermal.HeatTransfer.HeatCapacitor C(T0 = from_degRk(500));
</pre>
</html>"));
end Rankine;
