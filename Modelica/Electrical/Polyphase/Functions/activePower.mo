within Modelica.Electrical.Polyphase.Functions;
function activePower "Calculate active power of voltage and current input"
  extends Modelica.Icons.Function;
  input Modelica.SIunits.Voltage v[:] "Phase voltages";
  input Modelica.SIunits.Current i[size(v, 1)] "Phase currents";
  output Modelica.SIunits.Power p "Active power";
algorithm
  p := sum(v .* i);
  annotation (Inline=true, Documentation(info="<html>
<p>
Calculates instantaneous power from polyphase voltages and currents.
In quasi-static operation, instantaneous power equals active power;
</p>
</html>"));
end activePower;
