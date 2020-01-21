within Modelica.Electrical.QuasiStatic.Polyphase.Sensors;
model FrequencySensor "Frequency sensor"
  extends Interfaces.AbsoluteSensor;
  SinglePhase.Sensors.FrequencySensor frequencySensor annotation (Placement(
        transformation(extent={{-10,-10},{10,10}})));
  Basic.PlugToPin_p plugToPin_p(final m=m, final k=1) annotation (Placement(
        transformation(extent={{-80,-10},{-60,10}})));
  Modelica.Blocks.Interfaces.RealOutput f(unit="Hz") annotation (Placement(
        transformation(extent={{100,-10},{120,10}})));
equation

  connect(plug_p, plugToPin_p.plug_p) annotation (Line(
      points={{-100,0},{-72,0}}, color={85,170,255}));
  connect(plugToPin_p.pin_p, frequencySensor.pin) annotation (Line(
      points={{-68,0},{-10,0}}, color={85,170,255}));
  connect(frequencySensor.f,f)  annotation (Line(
      points={{11,0},{110,0}}, color={0,0,127}));
  annotation (
    Icon(graphics={
        Text(
          extent={{-30,-10},{30,-70}},
          textColor={64,64,64},
          textString="Hz"), Line(points={{70,0},{100,0}}, color={0,0,127})}),
                             Documentation(info="<html>

<p>
This sensor can be used to measure the frequency of the reference system, using <em>one</em>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.FrequencySensor\">single-phase FrequencySensor</a>.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.FrequencySensor\">SinglePhase.Sensors.FrequencySensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.ReferenceSensor\">ReferenceSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.PotentialSensor\">PotentialSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.VoltageSensor\">VoltageSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.VoltageQuasiRMSSensor\">VoltageQuasiRMSSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.CurrentSensor\">CurrentSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.CurrentQuasiRMSSensor\">CurrentQuasiRMSSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.PowerSensor\">PowerSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.MultiSensor\">MultiSensor</a>
</p>

</html>"));
end FrequencySensor;
