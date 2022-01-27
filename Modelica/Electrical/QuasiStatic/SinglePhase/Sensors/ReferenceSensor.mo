within Modelica.Electrical.QuasiStatic.SinglePhase.Sensors;
model ReferenceSensor "Sensor of reference angle gamma"
  extends QuasiStatic.SinglePhase.Interfaces.AbsoluteSensor;
  Modelica.Blocks.Interfaces.RealOutput gamma(unit="rad") "Reference angle" annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  gamma = pin.reference.gamma;
  annotation (Documentation(info="<html>

<p>
This sensor can be used to measure the reference angle.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.FrequencySensor\">FrequencySensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.PotentialSensor\">PotentialSensor</a>,
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
          textString="rad"),
        Line(points={{100,0},{70,0}}, color={0,0,127})}));
end ReferenceSensor;
