within Modelica.Electrical.QuasiStatic.Polyphase.Sensors;
model PotentialSensor "Potential sensor"
  extends Interfaces.AbsoluteSensor;
  QuasiStatic.SinglePhase.Sensors.PotentialSensor potentialSensor[m]
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Basic.PlugToPins_p plugToPins_p(final m=m) annotation (Placement(
        transformation(extent={{-80,-10},{-60,10}})));
  Modelica.ComplexBlocks.Interfaces.ComplexOutput v[m] "Potential as complex output signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  SI.Voltage abs_v[m]=Modelica.ComplexMath.abs(v)
    "Magnitude of complex potential";
  SI.Angle arg_v[m]=Modelica.ComplexMath.arg(v)
    "Argument of complex potential";

equation
  connect(potentialSensor.v,v)  annotation (Line(points={{11,0},{35.75,0},{
          35.75,0},{60.5,0},{60.5,0},{110,0}}, color={85,170,255}));
  connect(plug_p, plugToPins_p.plug_p) annotation (Line(
      points={{-100,0},{-72,0}}, color={85,170,255}));
  connect(plugToPins_p.pin_p, potentialSensor.pin) annotation (Line(
      points={{-68,0},{-10,0}}, color={85,170,255}));
  annotation (Documentation(info="<html>

<p>
This sensor can be used to measure <em>m</em> complex potentials, using <em>m</em>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.PotentialSensor\">single-phase PotentialSensors</a>.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.PotentialSensor\">SinglePhase.Sensors.PotentialSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.ReferenceSensor\">ReferenceSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.FrequencySensor\">FrequencySensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.VoltageSensor\">VoltageSensor</a>,
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
          textString="V"), Line(points={{70,0},{100,0}}, color={85,170,255})}));
end PotentialSensor;
