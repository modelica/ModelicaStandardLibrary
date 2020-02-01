within Modelica.Electrical.QuasiStatic.Polyphase.Examples;
model BalancingStar "Balancing an unsymmetrical star-connected load"
  extends Modelica.Icons.Example;
  constant Integer m=3 "Number of phases";
  parameter SI.Voltage V=100 "Source Voltage";
  parameter SI.Frequency f=50 "Source frequency";
  parameter SI.Resistance R=10 "Load resistance";
  parameter SI.Inductance L=(R*sqrt(3))/(2*Modelica.Constants.pi*f)
    "Load inductance";
  parameter SI.Capacitance C=1/(R*sqrt(3))/(2*Modelica.Constants.pi*f)
    "Load capacitance";
  output SI.ComplexCurrent i[m]={resistor.i, inductor.i, capacitor.i}
    "Phase currents";
  QuasiStatic.Polyphase.Sources.VoltageSource voltageSource(
    m=m,
    f=f,
    V=fill(V, m),
    phi=-Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m),
    gamma(fixed=true, start=0)) annotation (Placement(transformation(
        origin={-80,-20},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  QuasiStatic.Polyphase.Basic.Star star(m=m) annotation (Placement(
        transformation(
        origin={-80,-50},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  QuasiStatic.SinglePhase.Basic.Ground ground
    annotation (Placement(transformation(extent={{-90,-90},{-70,-70}})));
  QuasiStatic.Polyphase.Basic.PlugToPin_p plugToPin_p1(m=m, k=1)
    annotation (Placement(transformation(extent={{0,40},{20,60}})));
  QuasiStatic.Polyphase.Basic.PlugToPin_p plugToPin_p2(k=2, m=m)
    annotation (Placement(transformation(extent={{0,0},{20,20}})));
  QuasiStatic.Polyphase.Basic.PlugToPin_p plugToPin_p3(k=3, m=m)
    annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
  QuasiStatic.Polyphase.Sensors.PowerSensor powerSensor(m=m)
    annotation (Placement(transformation(extent={{-70,0},{-50,20}})));
  QuasiStatic.Polyphase.Sensors.CurrentSensor currentSensor(m=m)
    annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  QuasiStatic.SinglePhase.Basic.Resistor resistor(R_ref=R)
    annotation (Placement(transformation(extent={{30,-40},{50,-20}})));
  QuasiStatic.SinglePhase.Basic.Capacitor capacitor(C=C)
    annotation (Placement(transformation(extent={{30,0},{50,20}})));
  QuasiStatic.SinglePhase.Basic.Inductor inductor(L=L)
    annotation (Placement(transformation(extent={{30,40},{50,60}})));
  QuasiStatic.Polyphase.Basic.Star star2(m=m) annotation (Placement(
        transformation(
        origin={90,-50},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  QuasiStatic.Polyphase.Basic.PlugToPin_n plugToPin_n1(m=m, k=1) annotation (
      Placement(transformation(
        origin={70,50},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  QuasiStatic.Polyphase.Basic.PlugToPin_n plugToPin_n2(k=2, m=m) annotation (
      Placement(transformation(
        origin={70,10},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  QuasiStatic.Polyphase.Basic.PlugToPin_n plugToPin_n3(k=3, m=m) annotation (
      Placement(transformation(
        origin={70,-30},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  QuasiStatic.SinglePhase.Sensors.CurrentSensor currentSensor0 annotation (
      Placement(transformation(
        origin={-30,-60},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.ComplexBlocks.ComplexMath.ComplexToPolar complexToPolar[m]
    annotation (Placement(transformation(
        origin={-30,-20},
        extent={{-10,-10},{10,10}},
        rotation=270)));
equation
  connect(ground.pin, star.pin_n)
    annotation (Line(points={{-80,-70},{-80,-60}}, color={85,170,255}));
  connect(star.plug_p, voltageSource.plug_n)
    annotation (Line(points={{-80,-40},{-80,-30}}, color={85,170,255}));
  connect(voltageSource.plug_p, powerSensor.currentP) annotation (Line(
        points={{-80,-10},{-80,10},{-70,10}}, color={85,170,255}));
  connect(powerSensor.currentN, currentSensor.plug_p)
    annotation (Line(points={{-50,10},{-40,10}}, color={85,170,255}));
  connect(powerSensor.voltageP, powerSensor.currentP) annotation (Line(
        points={{-60,20},{-70,20},{-70,10}}, color={85,170,255}));
  connect(powerSensor.voltageN, star.plug_p) annotation (Line(points={{-60,
          0},{-60,-40},{-80,-40}}, color={85,170,255}));
  connect(currentSensor.plug_n, plugToPin_p2.plug_p)
    annotation (Line(points={{-20,10},{8,10}}, color={85,170,255}));
  connect(currentSensor.plug_n, plugToPin_p3.plug_p) annotation (Line(
        points={{-20,10},{-20,10},{-10,10},{-10,-30},{8,-30}}, color={85,170,255}));
  connect(currentSensor.plug_n, plugToPin_p1.plug_p) annotation (Line(
        points={{-20,10},{-20,10},{-10,10},{-10,50},{8,50}}, color={85,170,255}));
  connect(plugToPin_p1.pin_p, inductor.pin_p)
    annotation (Line(points={{12,50},{30,50}}, color={85,170,255}));
  connect(plugToPin_p2.pin_p, capacitor.pin_p)
    annotation (Line(points={{12,10},{30,10}}, color={85,170,255}));
  connect(plugToPin_p3.pin_p, resistor.pin_p)
    annotation (Line(points={{12,-30},{30,-30}}, color={85,170,255}));
  connect(inductor.pin_n, plugToPin_n1.pin_n)
    annotation (Line(points={{50,50},{68,50}}, color={85,170,255}));
  connect(capacitor.pin_n, plugToPin_n2.pin_n)
    annotation (Line(points={{50,10},{68,10}}, color={85,170,255}));
  connect(resistor.pin_n, plugToPin_n3.pin_n)
    annotation (Line(points={{50,-30},{68,-30}}, color={85,170,255}));
  connect(plugToPin_n1.plug_n, star2.plug_p) annotation (Line(points={{72,50},{90,
          50},{90,-40}}, color={85,170,255}));
  connect(plugToPin_n2.plug_n, star2.plug_p) annotation (Line(points={{72,10},{90,
          10},{90,-40}}, color={85,170,255}));
  connect(plugToPin_n3.plug_n, star2.plug_p) annotation (Line(points={{72,-30},{
          90,-30},{90,-40}}, color={85,170,255}));
  connect(star2.pin_n, currentSensor0.pin_p)
    annotation (Line(points={{90,-60},{-20,-60}}, color={85,170,255}));
  connect(currentSensor0.pin_n, star.pin_n)
    annotation (Line(points={{-40,-60},{-80,-60}}, color={85,170,255}));
  connect(currentSensor.i, complexToPolar.u)
    annotation (Line(points={{-30,-1},{-30,-1},{-30,-8}}, color={85,170,255}));
  annotation (Documentation(info="<html>
<p>
For the unsymmetrical load (resistor, capacitor and inductor) the parameters inductance L and capacitance C
are chosen such way that the neutral current (see currentSensor0) is zero.
</p>
<p>
P.Vaske, Berechnung von Drehstromschaltungen (German, Calculation of polyphase circuits), Teubner 1973, page 42, example 18
</p>
</html>"),
       experiment(StopTime=1.0, Interval=0.001));
end BalancingStar;
