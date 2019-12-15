within Modelica.Thermal.FluidHeatFlow;
package Sources "Ideal fluid sources, e.g., ambient, volume flow"
  extends Modelica.Icons.SourcesPackage;
  annotation (Documentation(info="<html>
<p>
This package contains different types of sources:
</p>
<ul>
<li>Ambient with constant or prescribed pressure and temperature</li>
<li>AbsolutePressure to define pressure level of a closed cooling cycle.</li>
<li>Constant and prescribed volume flow</li>
<li>Constant and prescribed pressure increase</li>
<li>Simple pump with mechanical flange</li>
</ul>
<p>
Thermodynamic equations are defined in partial models (package BaseClasses).
All fans / pumps are considered without losses, they do not change enthalpy flow.
</p>
</html>"));
end Sources;
