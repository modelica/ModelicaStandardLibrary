within Modelica.Electrical.QuasiStatic.Polyphase.Sources;
model VoltageSource "Constant polyphase AC voltage"
  extends Interfaces.Source;
  import Modelica.ComplexMath.j;
  import Modelica.ComplexMath.exp;
  parameter SI.Frequency f(start=1) "Frequency of the source";
  parameter SI.Voltage V[m](start=fill(1, m))
    "RMS voltage of the source";
  parameter SI.Angle phi[m]=-
      Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m)
    "Phase shift of the source";
equation
  omega = 2*Modelica.Constants.pi*f;
  v = {V[k]*exp(j*phi[k]) for k in 1:m};
  annotation (
    Icon(graphics={
        Line(points={{-50,0},{50,0}}, color={85,170,255}),
        Line(points={{-70,30},{-70,10}}, color={85,170,255}),
        Line(points={{-80,20},{-60,20}}, color={85,170,255}),
        Line(points={{60,20},{80,20}}, color={85,170,255})}),
    Documentation(info="<html>

<p>
This model describes <em>m</em> constant voltage sources, specifying the complex voltages by the RMS voltages and the phase shifts
(defaults are
<a href=\"modelica://Modelica.Electrical.Polyphase.Functions.symmetricOrientation\">-symmetricOrientation</a>).
<em>m</em> <a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sources.VoltageSource\">single-phase VoltageSources</a> are used.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sources.VoltageSource\">SinglePhase.VoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sources.VariableVoltageSource\">VariableVoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sources.CurrentSource\">CurrentSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sources.VariableCurrentSource\">VariableCurrentSource</a>
</p>
</html>"));
end VoltageSource;
