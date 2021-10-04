within Modelica.Electrical.QuasiStatic.SinglePhase.Sensors;
model VoltageRMSSensor "Continuous voltage RMS sensor for single-phase system"
  extends Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.RelativeSensorElementary;
  Modelica.Blocks.Interfaces.RealOutput V(unit="V")
    "Continuous average RMS of voltage" annotation(
    Placement(transformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  SI.ComplexVoltage v "Complex voltage";
  SI.ComplexCurrent i "Complex current";
equation
  V = sqrt(v.re^2 + v.im^2);
  v = pin_p.v - pin_n.v;
  i = pin_p.i;
  i = Complex(0,0);
  annotation (Documentation(info="<html>
<p>
This sensor determines the continuous root mean square (<a href=\"modelica://Modelica.Electrical.QuasiStatic.UsersGuide.Overview.Introduction\">RMS</a>)
value of a single-phase voltage system.
</p>
<blockquote><pre>
V = abs(v)
</pre></blockquote>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.ReferenceSensor\">ReferenceSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.FrequencySensor\">FrequencySensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.PotentialSensor\">PotentialSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.VoltageSensor\">VoltageSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.CurrentSensor\">CurrentSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.CurrentRMSSensor\">CurrentRMSSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.PowerSensor\">PowerSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.MultiSensor\">MultiSensor</a>
</p>

</html>"),
       Icon(graphics={
        Text(textColor = {64, 64, 64}, extent = {{-30, -10}, {30, -70}}, textString = "V"),
        Line(points={{-100,0},{-70,0}}, color={85,170,255}),
        Line(points={{70,0},{100,0}},   color={85,170,255})}));
end VoltageRMSSensor;
