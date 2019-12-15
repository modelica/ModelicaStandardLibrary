within Modelica.Electrical.Batteries.ParameterRecords;
record RCData "Parameters of RC-elements"
  extends Modelica.Icons.Record;
  parameter Modelica.SIunits.Resistance R "Resistance of RC-element";
  parameter Modelica.SIunits.Time T "Time constant of RC-element; if C is specified, T is not applied";
  parameter Modelica.SIunits.Capacitance C=if R<=0 then 0 else T/R "Capacitance of RC-element";
  annotation(defaultComponentPrefixes="parameter", defaultComponentName="rcData",
  Documentation(info="<html>
<p>Parameters for RC-elements of battery models</p>
</html>"));
end RCData;
