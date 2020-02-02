within Modelica.Electrical.QuasiStatic.Polyphase.Sensors;
model PowerSensor "Power sensor"
  extends Modelica.Icons.RoundSensor;
  parameter Integer m(min=1) = 3 "Number of phases" annotation(Evaluate=true);
  SI.AngularVelocity omega=der(currentP.reference.gamma);
  Interfaces.PositivePlug currentP(final m=m) annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}})));
  Interfaces.NegativePlug currentN(final m=m) annotation (Placement(
        transformation(extent={{90,-10},{110,10}})));
  Interfaces.PositivePlug voltageP(final m=m) annotation (Placement(
        transformation(extent={{-10,90},{10,110}})));
  Interfaces.NegativePlug voltageN(final m=m) annotation (Placement(
        transformation(extent={{-10,-110},{10,-90}})));
  Modelica.ComplexBlocks.Interfaces.ComplexOutput apparentPower "Total apparent power as complex output signal" annotation (Placement(transformation(
        origin={-100,-110},
        extent={{-10,-10},{10,10}},
        rotation=270), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-100,-110})));
  Basic.PlugToPins_p plugToPinsCurrentP(final m=m) annotation (Placement(
        transformation(extent={{-80,-10},{-60,10}})));
  Basic.PlugToPins_p plugToPinsVoltageP(final m=m) annotation (Placement(
        transformation(
        origin={0,70},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Basic.PlugToPins_n plugToPinsCurrentN(final m=m) annotation (Placement(
        transformation(extent={{80,-10},{60,10}})));
  Basic.PlugToPins_n plugToPinsVoltageN(final m=m) annotation (Placement(
        transformation(
        origin={0,-70},
        extent={{-10,10},{10,-10}},
        rotation=90)));
  QuasiStatic.SinglePhase.Sensors.PowerSensor powerSensor[m]
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.ComplexBlocks.ComplexMath.Sum sum(final nin=m) annotation (
      Placement(transformation(
        origin={-80,-70},
        extent={{-10,-10},{10,10}},
        rotation=270)));

  SI.ApparentPower abs_apparentPower=Modelica.ComplexMath.abs(apparentPower) "Magnitude of complex apparent power";
  SI.Angle arg_apparentPower=Modelica.ComplexMath.arg(apparentPower) "Argument of complex apparent power";

equation
  connect(plugToPinsCurrentP.plug_p, currentP) annotation (Line(points={{-72,
          0},{-79,0},{-86,0},{-100,0}}, color={85,170,255}));
  connect(currentN, plugToPinsCurrentN.plug_n) annotation (Line(points={{
          100,0},{93,0},{86,0},{72,0}}, color={85,170,255}));
  connect(voltageP, plugToPinsVoltageP.plug_p)
    annotation (Line(points={{0,100},{0,100},{0,72}}, color={85,170,255}));
  connect(plugToPinsVoltageN.plug_n, voltageN) annotation (Line(points={{0,
          -72},{0,-72},{0,-100}}, color={85,170,255}));
  connect(plugToPinsCurrentP.pin_p, powerSensor.currentP) annotation (Line(
        points={{-68,0},{-53.5,0},{-53.5,0},{-39,0},{-39,0},{-10,0}}, color={85,170,255}));
  connect(powerSensor.currentN, plugToPinsCurrentN.pin_n) annotation (Line(
        points={{10,0},{24.5,0},{24.5,0},{39,0},{39,0},{68,0}}, color={85,
          170,255}));
  connect(powerSensor.voltageP, plugToPinsVoltageP.pin_p) annotation (Line(
        points={{0,10},{0,10},{0,68},{0,68}}, color={85,170,255}));
  connect(powerSensor.voltageN, plugToPinsVoltageN.pin_n) annotation (Line(
        points={{0,-10},{0,-10},{0,-68},{0,-68}}, color={85,170,255}));
  connect(powerSensor.apparentPower, sum.u) annotation (Line(points={{-10,-11},{-10,-40},{-80,-40},{-80,-58}}, color={85,170,255}));
  connect(sum.y, apparentPower) annotation (Line(points={{-80,-81},{-80,-90},{-100,-90},{-100,-110}}, color={85,170,255}));
  annotation (
    Icon(graphics={
        Line(points={{0,100},{0,70}}, color={85,170,255}),
        Line(points={{0,-70},{0,-100}}, color={85,170,255}),
        Text(
          textColor={0,0,255},
          extent={{-150,110},{150,150}},
          textString="%name"),
        Line(points={{-100,0},{100,0}}, color={85,170,255}),
      Line(points={{-100,-100},{-100,-80},{-58,-38}}, color={85,170,255}),
        Text(
          extent={{-30,-10},{30,-70}},
          textColor={64,64,64},
          textString="V.A")}),
    Documentation(info="<html>

<p>
This sensor can be used to measure <em>m</em> complex apparent power values, using <em>m</em>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.PowerSensor\">single-phase PowerSensors</a>.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.PowerSensor\">SinglePhase.Sensors.PowerSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.ReferenceSensor\">ReferenceSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.FrequencySensor\">FrequencySensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.PotentialSensor\">PotentialSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.VoltageSensor\">VoltageSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.VoltageQuasiRMSSensor\">VoltageQuasiRMSSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.CurrentSensor\">CurrentSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.CurrentQuasiRMSSensor\">CurrentQuasiRMSSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.MultiSensor\">MultiSensor</a>
</p>

</html>"));
end PowerSensor;
