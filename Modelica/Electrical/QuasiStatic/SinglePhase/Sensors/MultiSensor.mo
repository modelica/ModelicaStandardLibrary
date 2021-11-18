within Modelica.Electrical.QuasiStatic.SinglePhase.Sensors;
model MultiSensor "Sensor to measure current, voltage and power"
  extends Modelica.Icons.RoundSensor;
  import Modelica.ComplexMath.conj;
  import Modelica.ComplexMath.abs;
  import Modelica.ComplexMath.arg;
  QuasiStatic.SinglePhase.Interfaces.PositivePin pc
    "Positive pin, current path"
    annotation (Placement(transformation(extent={{-90,-10},{-110,10}})));
  QuasiStatic.SinglePhase.Interfaces.NegativePin nc
    "Negative pin, current path"
    annotation (Placement(transformation(extent={{110,-10},{90,10}})));
  QuasiStatic.SinglePhase.Interfaces.PositivePin pv
    "Positive pin, voltage path"
    annotation (Placement(transformation(extent={{-10,110},{10,90}})));
  QuasiStatic.SinglePhase.Interfaces.NegativePin nv
    "Negative pin, voltage path"
    annotation (Placement(transformation(extent={{10,-110},{-10,-90}})));
  Modelica.ComplexBlocks.Interfaces.ComplexOutput i(
    redeclare final SI.Current re, redeclare final SI.Current im)
    "Current as complex output signal" annotation (Placement(transformation(
        origin={-60,-110},
        extent={{10,10},{-10,-10}},
        rotation=90), iconTransformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={-60,-110})));
  Modelica.ComplexBlocks.Interfaces.ComplexOutput v(
    redeclare final SI.Voltage re, redeclare final SI.Voltage im)
    "Voltage as complex output signal" annotation (Placement(transformation(
        origin={60,-110},
        extent={{10,10},{-10,-10}},
        rotation=90), iconTransformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={60,-110})));
  Modelica.ComplexBlocks.Interfaces.ComplexOutput apparentPower(
    redeclare final SI.ActivePower re, redeclare final SI.ReactivePower im)
    "Instantaneous apparent power as complex output signal" annotation (Placement(transformation(
        origin={-110,-60},
        extent={{-10,10},{10,-10}},
        rotation=180), iconTransformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-110,-60})));
  output SI.Current abs_i=abs(i) "Absolute of complex current";
  output SI.Angle arg_i=arg(i) "Argument of complex current";
  output SI.Voltage abs_v=abs(v) "Absolute of complex voltage";
  output SI.Angle arg_v=arg(v) "Argument of complex voltage";
  output SI.ApparentPower abs_apparentPower=abs(apparentPower) "Absolute of complex apparent power";
  output SI.Angle arg_apparentPower=arg(apparentPower) "Argument of complex apparent power";
equation
  Connections.branch(pc.reference, nc.reference);
  pc.reference.gamma = nc.reference.gamma;
  Connections.branch(pv.reference, nv.reference);
  pv.reference.gamma = nv.reference.gamma;
  Connections.branch(pc.reference, pv.reference);
  pc.reference.gamma = pv.reference.gamma;
  pc.i + nc.i = Complex(0);
  pc.v - nc.v = Complex(0);
  pv.i = Complex(0);
  nv.i = Complex(0);
  i = pc.i;
  v = pv.v - nv.v;
  apparentPower = v*conj(i);
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
      Line(points = {{0,100},{0,70}}, color={85,170,255}),
      Line(points = {{0,-70},{0,-100}}, color={85,170,255}),
      Line(points = {{-100,0},{100,0}}, color={85,170,255}),
      Line(points = {{0,70},{0,40}}),
        Text(
          extent={{-150,110},{150,150}},
          textString="%name",
          textColor={0,0,255}),
        Line(points={{-100,-60},{-80,-60},{-56,-42}},
                                                   color={85,170,255}),
        Line(points={{-60,-100},{-60,-80},{-42,-56}},
                                                   color={85,170,255}),
        Line(points={{60,-100},{60,-80},{42,-56}},
                                                color={85,170,255}),
        Text(
          extent={{-100,-20},{-60,-60}},
            textColor={64,64,64},
            textString="V.A"),
        Text(
          extent={{-80,-60},{-40,-100}},
            textString="A",
            textColor={64,64,64}),
        Text(
          extent={{40,-60},{80,-100}},
            textString="V",
            textColor={64,64,64})}),
    Documentation(info="<html>
<p>This multi sensor measures current, voltage and instantaneous electrical power of a single-phase system and has a separated voltage and current path.
The pins of the voltage path are pv and nv, the pins of the current path are pc and nc.
The internal resistance of the current path is zero, the internal resistance of the voltage path is infinite.</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.ReferenceSensor\">ReferenceSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.FrequencySensor\">FrequencySensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.PotentialSensor\">PotentialSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.VoltageSensor\">VoltageSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.VoltageRMSSensor\">VoltageRMSSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.CurrentSensor\">CurrentSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.CurrentRMSSensor\">CurrentRMSSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.PowerSensor\">PowerSensor</a>
</p>
</html>", revisions="<html>
<ul>
<li><em>20170306</em> first implementation by Anton Haumer</li>
</ul>
</html>"));
end MultiSensor;
