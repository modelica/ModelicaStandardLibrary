within Modelica.Electrical.QuasiStatic.SinglePhase.Sensors;
model PotentialSensor "Potential sensor"
  extends Interfaces.AbsoluteSensor;
  Modelica.ComplexBlocks.Interfaces.ComplexOutput v "Complex potential"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  SI.Voltage abs_v=Modelica.ComplexMath.abs(v) "Magnitude of complex potential";
  SI.Angle arg_v=Modelica.ComplexMath.arg(v) "Argument of complex potential";
equation
  v = pin.v;
  annotation (Documentation(info="<html>

<p>
This sensor can be used to measure the complex potential.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.ReferenceSensor\">ReferenceSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.FrequencySensor\">FrequencySensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.VoltageSensor\">VoltageSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.VoltageRMSSensor\">VoltageRMSSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.CurrentSensor\">CurrentSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.CurrentRMSSensor\">CurrentRMSSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.PowerSensor\">PowerSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.MultiSensor\">MultiSensor</a>
</p>

</html>"),
       Icon(graphics={
        Text(
          extent={{-30,-10},{30,-70}},
          textColor={64,64,64},
          textString="V"),
        Line(points={{100,0},{70,0}}, color={85,170,255})}));
end PotentialSensor;
