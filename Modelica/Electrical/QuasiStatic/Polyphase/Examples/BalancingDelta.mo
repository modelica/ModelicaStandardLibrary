within Modelica.Electrical.QuasiStatic.Polyphase.Examples;
model BalancingDelta "Balancing an unsymmetrical delta-connected load"
  extends Modelica.Icons.Example;
  parameter Integer m=3 "Number of phases" annotation(Evaluate=true);
  parameter SI.Voltage V_LL=100 "Source voltage line-to-line";
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
    V=fill(V_LL, m),
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
    annotation (Placement(transformation(extent={{2,70},{22,90}})));
  QuasiStatic.Polyphase.Basic.PlugToPin_p plugToPin_p2(k=2, m=m)
    annotation (Placement(transformation(extent={{0,0},{20,20}})));
  QuasiStatic.Polyphase.Basic.PlugToPin_p plugToPin_p3(k=3, m=m)
    annotation (Placement(transformation(extent={{0,-70},{20,-50}})));
  QuasiStatic.Polyphase.Sensors.PowerSensor powerSensor(m=m)
    annotation (Placement(transformation(extent={{-70,0},{-50,20}})));
  QuasiStatic.Polyphase.Sensors.CurrentSensor currentSensor(m=m)
    annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  QuasiStatic.SinglePhase.Basic.Resistor resistor(R_ref=R) annotation (
      Placement(transformation(
        origin={60,30},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  QuasiStatic.SinglePhase.Basic.Capacitor capacitor(C=C) annotation (Placement(
        transformation(
        origin={30,32},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  QuasiStatic.SinglePhase.Basic.Inductor inductor(L=L) annotation (Placement(
        transformation(
        origin={30,-38},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  QuasiStatic.SinglePhase.Sensors.CurrentSensor currentSensor12 annotation (
      Placement(transformation(
        origin={30,62},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  QuasiStatic.SinglePhase.Sensors.CurrentSensor currentSensor23 annotation (
      Placement(transformation(
        origin={30,-8},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  QuasiStatic.SinglePhase.Sensors.CurrentSensor currentSensor31 annotation (
      Placement(transformation(
        origin={60,-10},
        extent={{-10,-10},{10,10}},
        rotation=90)));
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
  connect(powerSensor.currentP, powerSensor.voltageP) annotation (Line(
        points={{-70,10},{-70,20},{-60,20}}, color={85,170,255}));
  connect(powerSensor.currentN, currentSensor.plug_p)
    annotation (Line(points={{-50,10},{-40,10}}, color={85,170,255}));
  connect(powerSensor.voltageN, star.plug_p) annotation (Line(points={{-60,0},{-60,
          -40},{-80,-40}}, color={85,170,255}));
  connect(currentSensor.plug_n, plugToPin_p2.plug_p)
    annotation (Line(points={{-20,10},{8,10}}, color={85,170,255}));
  connect(currentSensor.plug_n, plugToPin_p1.plug_p) annotation (Line(
        points={{-20,10},{-10,10},{-10,80},{10,80}}, color={85,170,255}));
  connect(currentSensor.plug_n, plugToPin_p3.plug_p) annotation (Line(
        points={{-20,10},{-10,10},{-10,-60},{8,-60}}, color={85,170,255}));
  connect(currentSensor12.pin_p, plugToPin_p1.pin_p) annotation (Line(
        points={{30,72},{30,80},{14,80}}, color={85,170,255}));
  connect(currentSensor12.pin_n, capacitor.pin_p)
    annotation (Line(points={{30,52},{30,42}}, color={85,170,255}));
  connect(capacitor.pin_n, plugToPin_p2.pin_p) annotation (Line(points={{30,22},
          {30,10},{12,10}}, color={85,170,255}));
  connect(plugToPin_p2.pin_p, currentSensor23.pin_p)
    annotation (Line(points={{12,10},{30,10},{30,2}}, color={85,170,255}));
  connect(currentSensor23.pin_n, inductor.pin_p)
    annotation (Line(points={{30,-18},{30,-28}}, color={85,170,255}));
  connect(inductor.pin_n, plugToPin_p3.pin_p) annotation (Line(points={{30,-48},
          {30,-60},{12,-60}}, color={85,170,255}));
  connect(plugToPin_p1.pin_p, resistor.pin_n) annotation (Line(points={{14,80},{
          60,80},{60,40}}, color={85,170,255}));
  connect(resistor.pin_p, currentSensor31.pin_n)
    annotation (Line(points={{60,20},{60,0}}, color={85,170,255}));
  connect(currentSensor31.pin_p, plugToPin_p3.pin_p) annotation (Line(
        points={{60,-20},{60,-60},{12,-60}}, color={85,170,255}));
  connect(currentSensor.i, complexToPolar.u) annotation (Line(
      points={{-30,-1},{-30,-8}}, color={85,170,255}));
  annotation (Documentation(info="<html>
<p>
For the unsymmetrical load (resistor, capacitor and inductor) the parameters inductance L and capacitance C
are chosen such way that the magnitudes of the three-phase currents (see currentSensor12, currentSensor23, currentSensor31) are equal.
</p>
<p>
P.Vaske, Berechnung von Drehstromschaltungen (German, Calculation of polyphase circuits), Teubner 1973, page 43, example 23
</p>
</html>"),
       experiment(StopTime=1.0, Interval=0.001));
end BalancingDelta;
