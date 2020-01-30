within Modelica.Electrical.Machines.Losses;
record BrushParameters "Parameter record for brush losses"
  extends Modelica.Icons.Record;
  parameter SI.Voltage V=0
    "Total voltage drop of brushes for currents > ILinear";
  parameter SI.Current ILinear(start=0.01)
    "Current indicating linear voltage region of brush voltage drop";
  annotation (defaultComponentPrefixes="parameter ", Documentation(info="<html>
<p>
Parameter record for <a href=\"modelica://Modelica.Electrical.Machines.Losses.InductionMachines.Brush\">three-phase Brush</a> and
<a href=\"modelica://Modelica.Electrical.Machines.Losses.DCMachines.Brush\">DC Brush</a> losses.
</p>
</html>"));
end BrushParameters;
