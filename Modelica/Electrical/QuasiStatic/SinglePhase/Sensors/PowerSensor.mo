within Modelica.Electrical.QuasiStatic.SinglePhase.Sensors;
model PowerSensor "Power sensor"
  import Modelica.ComplexMath.conj;
  extends Modelica.Icons.RoundSensor;
  Interfaces.PositivePin currentP annotation (Placement(transformation(
          extent={{-110,-10},{-90,10}})));
  Interfaces.NegativePin currentN annotation (Placement(transformation(
          extent={{90,-10},{110,10}})));
  Interfaces.PositivePin voltageP annotation (Placement(transformation(
          extent={{-10,90},{10,110}})));
  Interfaces.NegativePin voltageN annotation (Placement(transformation(
          extent={{-10,-110},{10,-90}})));
  output SI.ComplexCurrent i;
  output SI.ComplexVoltage v;
  Modelica.ComplexBlocks.Interfaces.ComplexOutput apparentPower(re(unit="W"), im(unit="var")) "Complex apparent power = active power + j * reactive power" annotation (Placement(transformation(
        origin={-100,-110},
        extent={{-10,-10},{10,10}},
        rotation=270), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-100,-110})));
  SI.ApparentPower abs_apparentPower=Modelica.ComplexMath.abs(apparentPower) "Magnitude of complex apparent power";
  SI.Angle arg_apparentPower=Modelica.ComplexMath.arg(apparentPower) "Argument of complex apparent power";

equation
  Connections.branch(currentP.reference, currentN.reference);
  currentP.reference.gamma = currentN.reference.gamma;
  Connections.branch(voltageP.reference, voltageN.reference);
  voltageP.reference.gamma = voltageN.reference.gamma;
  Connections.branch(currentP.reference, voltageP.reference);
  currentP.reference.gamma = voltageP.reference.gamma;
  currentP.i + currentN.i = Complex(0);
  currentP.v - currentN.v = Complex(0);
  i = currentP.i;
  voltageP.i + voltageN.i = Complex(0);
  voltageP.i = Complex(0);
  v = voltageP.v - voltageN.v;
  //P + j*Q = v * conj(i);
  apparentPower = v*conj(i);
  annotation (
    Icon(graphics={
        Line(points={{0,100},{0,70}}, color={85,170,255}),
        Line(points={{0,-70},{0,-100}}, color={85,170,255}),
        Line(points={{-100,0},{100,0}}, color={85,170,255}),
        Text(
          extent={{-150,110},{150,150}},
          textString="%name",
          textColor={0,0,255}),
      Line(points={{-100,-100},{-100,-80},{-58,-38}}, color={85,170,255}),
        Text(
          extent={{-30,-10},{30,-70}},
          textColor={64,64,64},
          textString="V.A")}),Documentation(
        info="<html>

<p>
This sensor can be used to measure the complex apparent power.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.ReferenceSensor\">ReferenceSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.FrequencySensor\">FrequencySensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.PotentialSensor\">PotentialSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.VoltageSensor\">VoltageSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.VoltageRMSSensor\">VoltageRMSSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.CurrentSensor\">CurrentSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.CurrentRMSSensor\">CurrentRMSSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.MultiSensor\">MultiSensor</a>
</p>

</html>"));
end PowerSensor;
