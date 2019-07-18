within Modelica.Electrical.Batteries.ParameterRecords;
record RCData "Parameters of RC-elements"
  extends Modelica.Icons.Record;
  parameter Modelica.SIunits.Resistance R "Resistance of RC-element";
  parameter Modelica.SIunits.Time T "Time constant of RC-element";
  parameter Modelica.SIunits.Capacitance C=if R<=0 then 0 else T/R "Capacitance of RC-element";
  annotation(defaultComponentPrefixes="parameter", defaultComponentName="rcData",
  Documentation(info="<html>
<p>Parameters for RC-elements of battery models:</p>
<ul>
<li><code>R</code> .. Resistance of RC-element</li>
<li><code>T</code> .. Time constant of RC-element; if <code>C</code> is specified, <code>T</code> can be neglected</li>
<li><code>C</code> .. Capacitance of RC-element; either specified explicitly or calculated from <code>T</code> and <code>R</code></li>
</ul>
</html>"));
end RCData;
