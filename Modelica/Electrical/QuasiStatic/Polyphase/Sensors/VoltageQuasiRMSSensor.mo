within Modelica.Electrical.QuasiStatic.Polyphase.Sensors;
model VoltageQuasiRMSSensor
  "Continuous quasi voltage RMS sensor for polyphase system"
  extends Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.RelativeSensorElementary;

  parameter Integer m(min=1) = 3 "Number of phases" annotation(Evaluate=true);
  Modelica.Blocks.Interfaces.RealOutput V
    "Continuous quasi average RMS of current" annotation (Placement(
        transformation(
        origin={0,-110},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  SinglePhase.Sensors.VoltageSensor voltageSensor[m] annotation (Placement(
        transformation(extent={{-10,-10},{10,10}})));
  QuasiStatic.Polyphase.Blocks.QuasiRMS quasiRMS(final m=m) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-50})));
  SI.ComplexVoltage v[m] = plug_p.pin.v - plug_n.pin.v "Complex voltage";
  SI.ComplexCurrent i[m] = plug_p.pin.i "Complex current";
equation
  connect(quasiRMS.y, V) annotation (Line(
      points={{0,-61},{0,-110}}, color={0,0,127}));
  connect(plugToPins_p.pin_p, voltageSensor.pin_p) annotation (Line(
      points={{-68,0},{-10,0}}, color={85,170,255}));
  connect(voltageSensor.pin_n, plugToPins_n.pin_n) annotation (Line(
      points={{10,0},{68,0}}, color={85,170,255}));
  connect(voltageSensor.v, quasiRMS.u) annotation (Line(
      points={{0,-11},{0,-38}}, color={85,170,255}));
  annotation (defaultComponentName="voltageRMSSensor",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={
        Text(
          extent={{150,-100},{-150,-70}},
          textString="m=%m"),
        Line(points={{0,-70},{0,-100}}, color={0,0,127}),
        Text(
          extent={{-30,-10},{30,-70}},
          textColor={64,64,64},
          textString="V"),
        Line(points={{70,0},{90,0}}, color={85,170,255}),
        Line(points={{-70,0},{-90,0}}, color={85,170,255})}),
    Documentation(revisions="<html>
</html>",
      info="<html>
<p>
This sensor determines the continuous quasi <a href=\"Modelica://Modelica.Blocks.Math.RootMeanSquare\">RMS</a>
value of a polyphase voltage system, by averaging the phase RMS voltage phasors <code>v</code>.
</p>
<pre>
  V = sum({abs(v[k]) for k in 1:m})/m
</pre>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.ReferenceSensor\">ReferenceSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.FrequencySensor\">FrequencySensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.PotentialSensor\">PotentialSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.VoltageSensor\">VoltageSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.VoltageQuasiRMSSensor\">VoltageQuasiRMSSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.CurrentSensor\">CurrentSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.CurrentQuasiRMSSensor\">CurrentQuasiRMSSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.PowerSensor\">PowerSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.MultiSensor\">MultiSensor</a>
</p>
</html>"));
end VoltageQuasiRMSSensor;
