within Modelica.Electrical.Machines.Losses.DCMachines;
function brushVoltageDrop "Voltage drop of carbon brushes"
  extends Modelica.Icons.Function;
  input Machines.Losses.BrushParameters brushParameters "Brush loss parameters";
  input SI.Current i "Actual current";
  output SI.Voltage v "Voltage drop";
algorithm
  if (brushParameters.V <= 0) then
    v := 0;
  else
    v := if (i > +brushParameters.ILinear) then +brushParameters.V else
      if (i < -brushParameters.ILinear) then -brushParameters.V else
      brushParameters.V*i/brushParameters.ILinear;
  end if;
  annotation (Documentation(info="<html>
<p>
Calculates the voltage drop of carbon brushes, according to
<a href=\"modelica://Modelica.Electrical.Machines.Losses.DCMachines.Brush\">Brush</a> losses,
e.g., used for initial equations.
</p>
</html>"));
end brushVoltageDrop;
