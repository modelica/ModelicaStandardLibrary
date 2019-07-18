within Modelica.Electrical.QuasiStatic.Polyphase.Functions;
function activePower
  "Calculate active power of complex input voltage and current"
  extends Modelica.Icons.Function;
  input Modelica.SIunits.ComplexVoltage v[:]
    "QuasiStatic voltage phasors";
  input Modelica.SIunits.ComplexCurrent i[size(v, 1)]
    "QuasiStatic current phasors";
  output Modelica.SIunits.Power p "Active power";
algorithm
  p := sum(Modelica.ComplexMath.real({v[k]*Modelica.ComplexMath.conj(i[k])
    for k in 1:size(v, 1)}));
  annotation (Inline=true, Documentation(info="<html>
<p>
Calculates instantaneous power from polyphase voltages and currents.
In quasi-static operation, instantaneous power equals active power;
</p>
</html>"));
end activePower;
