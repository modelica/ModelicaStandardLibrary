within Modelica.Electrical.Batteries.ParameterRecords.TransientData;
record RCData "Parameters of RC-elements"
  extends Modelica.Electrical.Batteries.Icons.TransientCellRecord(
    CellType="RC elements");
  parameter Modelica.SIunits.Resistance R "Resistance of RC-element";
  parameter Modelica.SIunits.Temperature T_ref=293.15 "Reference temperature";
  parameter Modelica.SIunits.LinearTemperatureCoefficient alpha=0 "Temperature coefficient of resistance at T_ref";
  parameter Modelica.SIunits.Capacitance C "Capacitance of RC-element (=T/R)";
  annotation(defaultComponentPrefixes="parameter", defaultComponentName="rcData",
  Documentation(info="<html>
<p>Parameters for RC-elements of battery models</p>
<h4>Note</h4>
<p>Capacitance C can be calculated from time constant T by C = T/R.</p>
</html>"));
end RCData;
