within Modelica.Electrical.QuasiStatic.Polyphase.Sensors;
model MultiSensor "Polyphase sensor to measure current, voltage and power"
  extends Modelica.Icons.RoundSensor;
  import Modelica.ComplexMath.conj;
  import Modelica.ComplexMath.abs;
  import Modelica.ComplexMath.arg;
  parameter Integer m(min=1) = 3 "Number of phases" annotation(Evaluate=true);
  QuasiStatic.Polyphase.Interfaces.PositivePlug pc(final m=m)
    "Positive plug, current path"
    annotation (Placement(transformation(extent={{-90,-10},{-110,10}})));
  QuasiStatic.Polyphase.Interfaces.NegativePlug nc(final m=m)
    "Negative plug, current path"
    annotation (Placement(transformation(extent={{110,-10},{90,10}})));
  QuasiStatic.Polyphase.Interfaces.PositivePlug pv(final m=m)
    "Positive plug, voltage path"
    annotation (Placement(transformation(extent={{-10,110},{10,90}})));
  QuasiStatic.Polyphase.Interfaces.NegativePlug nv(final m=m)
    "Negative plug, voltage path"
    annotation (Placement(transformation(extent={{10,-110},{-10,-90}})));
  Modelica.ComplexBlocks.Interfaces.ComplexOutput i[m](
    redeclare each final SI.Current re, redeclare each final SI.Current im)
    "Current as complex output signal" annotation (Placement(transformation(
        origin={-60,-110},
        extent={{10,10},{-10,-10}},
        rotation=90)));
  Modelica.ComplexBlocks.Interfaces.ComplexOutput v[m](
    redeclare each final SI.Voltage re, redeclare each final SI.Voltage im)
    "Voltage as complex output signal" annotation (Placement(transformation(
        origin={60,-110},
        extent={{10,10},{-10,-10}},
        rotation=90)));
  Modelica.ComplexBlocks.Interfaces.ComplexOutput apparentPower[m](
    redeclare each final SI.ActivePower re, redeclare each final SI.ReactivePower im)
    "Instantaneous apparent power as complex output signal" annotation (Placement(transformation(
        origin={-110,-60},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  Modelica.ComplexBlocks.Interfaces.ComplexOutput apparentPowerTotal(
    redeclare final SI.ActivePower re, redeclare final SI.ReactivePower im)
    "Sum of instantaneous apparent power as complex output signal" annotation (Placement(transformation(
        origin={110,-60},
        extent={{10,10},{-10,-10}},
        rotation=180)));
  output SI.Current abs_i[m]=abs(i) "Absolute of complex currents";
  output SI.Angle arg_i[m]=arg(i) "Argument of complex currents";
  output SI.Voltage abs_v[m]=abs(v) "Absolute of complex voltages";
  output SI.Angle arg_v[m]=arg(v) "Argument of complex voltages";
  output SI.ApparentPower abs_apparentPower[m]=abs(apparentPower) "Absolute of complex apparent power signals";
  output SI.Angle arg_apparentPower[m]=arg(apparentPower) "Argument of complex apparent power signals";
  output SI.ApparentPower abs_apparentPowerTotal=abs(apparentPowerTotal) "Absolute of sum complex apparent power";
  output SI.Angle arg_apparentPowerTotal=arg(apparentPowerTotal) "Argument of sum complex apparent power";
equation
  Connections.branch(pc.reference, nc.reference);
  pc.reference.gamma = nc.reference.gamma;
  Connections.branch(pv.reference, nv.reference);
  pv.reference.gamma = nv.reference.gamma;
  Connections.branch(pc.reference, pv.reference);
  pc.reference.gamma = pv.reference.gamma;
  pc.pin.i + nc.pin.i = fill(Complex(0), m);
  pc.pin.v - nc.pin.v = fill(Complex(0), m);
  pv.pin.i = fill(Complex(0), m);
  nv.pin.i = fill(Complex(0), m);
  i = pc.pin.i;
  v = pv.pin.v - nv.pin.v;
  apparentPower = v.*conj(i);
  apparentPowerTotal = Complex(sum(apparentPower.re),sum(apparentPower.im));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
      Line(points = {{0,100},{0,70}}, color={85,170,255}),
      Line(points = {{0,-70},{0,-100}}, color={85,170,255}),
      Line(points = {{-100,0},{100,0}}, color={85,170,255}),
      Line(points = {{0,70},{0,40}}),
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
            textColor={64,64,64}),
        Line(points={{100,-60},{80,-60},{56,-42}}, color={85,170,255}),
        Text(
          extent={{-150,110},{150,150}},
          textString="%name",
          textColor={0,0,255})}),
    Documentation(info="<html>
<p>This multi sensor measures currents, voltages and instantaneous electrical power of a polyphase system and has separated voltage and current paths.
The plugs of the voltage paths are pv and nv, the plugs of the current paths are pc and nc.
The internal resistance of each current path is zero, the internal resistance of each voltage path is infinite.</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.MultiSensor\">SinglePhase.Sensors.MultiSensor</a>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.ReferenceSensor\">ReferenceSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.FrequencySensor\">FrequencySensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.PotentialSensor\">PotentialSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.VoltageSensor\">VoltageSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.VoltageQuasiRMSSensor\">VoltageQuasiRMSSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.CurrentSensor\">CurrentSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.CurrentQuasiRMSSensor\">CurrentQuasiRMSSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.PowerSensor\">PowerSensor</a>
</p>
</html>",        revisions="<html>
<ul>
<li><em>20170306</em> first implementation by Anton Haumer</li>
</ul>
</html>"));
end MultiSensor;
