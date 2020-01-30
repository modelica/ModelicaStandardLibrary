within Modelica.Electrical.QuasiStatic.Polyphase.Sensors;
model VoltageSensor "Voltage sensor"
  extends Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.RelativeSensorElementary;

  QuasiStatic.SinglePhase.Sensors.VoltageSensor voltageSensor[m]
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  SI.Voltage abs_v[m]=Modelica.ComplexMath.abs(v)
    "Magnitude of complex voltage";
  SI.Angle arg_v[m]=Modelica.ComplexMath.arg(v)
    "Argument of complex voltage";
  ComplexBlocks.Interfaces.ComplexOutput v[m](redeclare each final SI.Voltage re, redeclare each final SI.Voltage im) "Voltage as complex output signal"
    annotation (Placement(transformation(
        origin={0,-110},
        extent={{10,10},{-10,-10}},
        rotation=90)));
equation
  connect(plugToPins_p.pin_p, voltageSensor.pin_p) annotation (Line(points={{-68,0},{-53.5,0},{-53.5,0},{-39,0},{-39,0},{-10,0}}, color={85,170,255}));
  connect(voltageSensor.pin_n, plugToPins_n.pin_n) annotation (Line(points={{10,0},{39,0},{39,0},{68,0}}, color={85,170,255}));
  connect(voltageSensor.v,v)  annotation (Line(points={{0,-11},{0,-110}}, color={85,170,255}));
  annotation (Documentation(info="<html>

<p>
This sensor can be used to measure <em>m</em> complex voltages, using <em>m</em>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.VoltageSensor\">single-phase VoltageSensors</a>.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.VoltageSensor\">SinglePhase.Sensors.VoltageSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.ReferenceSensor\">ReferenceSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.FrequencySensor\">FrequencySensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.PotentialSensor\">PotentialSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.VoltageQuasiRMSSensor\">VoltageQuasiRMSSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.CurrentSensor\">CurrentSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.CurrentQuasiRMSSensor\">CurrentQuasiRMSSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.PowerSensor\">PowerSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.MultiSensor\">MultiSensor</a>
</p>

</html>"),
       Icon(graphics={
        Text(
          extent={{-30,-10},{30,-70}},
          textColor={64,64,64},
          textString="V"),
        Line(points={{0,-100},{0,-80},{0,-70}},    color={85,170,255}),
        Line(points={{-70,0},{-90,0}}, color={85,170,255}),
        Line(points={{70,0},{90,0}}, color={85,170,255})}));
end VoltageSensor;
