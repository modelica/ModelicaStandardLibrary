within Modelica.Electrical.QuasiStatic.SinglePhase.Sensors;
model CurrentRMSSensor "Continuous current RMS sensor for single-phase system"
  extends Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.RelativeSensorElementary;
  Modelica.Blocks.Interfaces.RealOutput I(unit="A")
    "Continuous average RMS of current" annotation(
    Placement(transformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  SI.ComplexCurrent i "Complex current";
  SI.ComplexVoltage v "Complex voltage";
equation
  I = sqrt(i.re^2 + i.im^2);
  i = pin_p.i;
  v = pin_p.v - pin_n.v;
  v = Complex(0,0);
  annotation (Documentation(info="<html>
<p>
This sensor determines the continuous root mean square (<a href=\"modelica://Modelica.Electrical.QuasiStatic.UsersGuide.Overview.Introduction\">RMS</a>)
value of a single-phase current system.
</p>
<blockquote><pre>
I = abs(i)
</pre></blockquote>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.ReferenceSensor\">ReferenceSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.FrequencySensor\">FrequencySensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.PotentialSensor\">PotentialSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.VoltageSensor\">VoltageSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.VoltageRMSSensor\">VoltageRMSSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.CurrentSensor\">CurrentSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.PowerSensor\">PowerSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.MultiSensor\">MultiSensor</a>
</p>

</html>"),
       Icon(graphics={
        Text(textColor = {64, 64, 64}, extent = {{-30, -10}, {30, -70}}, textString = "A"),
        Line(points={{-70,0},{70,0}},   color={85,170,255})}));
end CurrentRMSSensor;
