within Modelica.Electrical.QuasiStatic.SinglePhase.Sources;
model VoltageSource "Constant AC voltage"
  extends Interfaces.Source;
  parameter SI.Frequency f(start=1) "Frequency of the source";
  parameter SI.Voltage V(start=1) "RMS voltage of the source";
  parameter SI.Angle phi(start=0) "Phase shift of the source";
equation
  omega = 2*Modelica.Constants.pi*f;
  v = Complex(V*cos(phi), V*sin(phi));
  annotation (Icon(graphics={
        Line(points={{-50,0},{50,0}}, color={85,170,255}),
        Line(points={{-70,30},{-70,10}}, color={85,170,255}),
        Line(points={{-80,20},{-60,20}}, color={85,170,255}),
        Line(points={{60,20},{80,20}}, color={85,170,255})}),
                                         Documentation(info="<html>

<p>
This is a constant voltage source, specifying the complex voltage by the RMS voltage and the phase shift.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sources.VariableVoltageSource\">VariableVoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sources.CurrentSource\">CurrentSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sources.VariableCurrentSource\">VariableCurrentSource</a>
</p>
</html>"));
end VoltageSource;
