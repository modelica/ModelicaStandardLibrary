within Modelica.Electrical.QuasiStatic.Polyphase.Sensors;
model CurrentSensor "Current Sensor"
  extends Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.RelativeSensorElementary;

  QuasiStatic.SinglePhase.Sensors.CurrentSensor currentSensor[m]
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  SI.Current abs_i[m]=Modelica.ComplexMath.abs(i)
    "Magnitude of complex current";
  SI.Angle arg_i[m]=Modelica.ComplexMath.arg(i)
    "Argument of complex current";
  ComplexBlocks.Interfaces.ComplexOutput i[m](redeclare each final SI.Current re, redeclare each final SI.Current im) "Current as complex output signal"
    annotation (Placement(transformation(
        origin={0,-110},
        extent={{10,10},{-10,-10}},
        rotation=90)));
equation
  connect(plugToPins_p.pin_p, currentSensor.pin_p) annotation (Line(points=
          {{-68,0},{-53.5,0},{-53.5,0},{-39,0},{-39,0},{-10,0}}, color={85,
          170,255}));
  connect(currentSensor.pin_n, plugToPins_n.pin_n) annotation (Line(points=
          {{10,0},{39,0},{39,0},{68,0}}, color={85,170,255}));
  connect(currentSensor.i,i)  annotation (Line(points={{0,-11},{0,-35.75},{
          0,-35.75},{0,-60.5},{0,-60.5},{0,-110}}, color={85,170,255}));
  annotation (Documentation(info="<html>

<p>
This sensor can be used to measure <em>m</em> complex currents, using <em>m</em>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.CurrentSensor\">single-phase CurrentSensors</a>.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.CurrentSensor\">SinglePhase.Sensors.CurrentSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.ReferenceSensor\">ReferenceSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.FrequencySensor\">FrequencySensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.PotentialSensor\">PotentialSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.VoltageSensor\">VoltageSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.VoltageQuasiRMSSensor\">VoltageQuasiRMSSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.CurrentQuasiRMSSensor\">CurrentQuasiRMSSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.PowerSensor\">PowerSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.MultiSensor\">MultiSensor</a>
</p>

</html>"),
       Icon(graphics={
        Text(
          extent={{-30,-10},{30,-70}},
          textColor={64,64,64},
          textString="A"),
        Line(points={{70,0},{90,0}}, color={85,170,255}),
        Line(points={{-70,0},{-90,0}}, color={85,170,255}),
        Line(points={{100,0},{-100,0}},color={85,170,255})}));
end CurrentSensor;
