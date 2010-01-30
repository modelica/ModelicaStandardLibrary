within Modelica.Electrical.QuasiStationary.Examples;
model BalancingDelta "Balancing an unsymmetrical delta-connected load"
//P.Vaske, Berechnung von Drehstromschaltungen, Teubner 1973, Seite 43, Beispiel 23
  extends Modelica.Icons.Example;
  parameter Integer m=3;
  parameter Modelica.SIunits.Voltage V_LL = 100;
  parameter Modelica.SIunits.Frequency f = 50;
  parameter Modelica.SIunits.Resistance R = 10;
  parameter Modelica.SIunits.Inductance L = (R*sqrt(3))/(2*Modelica.Constants.pi*f);
  parameter Modelica.SIunits.Capacitance C = 1/(R*sqrt(3))/(2*Modelica.Constants.pi*f);
  MultiPhase.Sources.VoltageSource voltageSource(
    m=m,
    f=f,
    V=fill(V_LL, m),
    phi={-(j - 1)*2*Modelica.Constants.pi/m for j in 1:m}) 
    annotation (Placement(transformation(
        origin={-70,-20},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  MultiPhase.Basic.Star star(m=m) 
    annotation (Placement(transformation(
        origin={-70,-50},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  SinglePhase.Basic.Ground ground 
    annotation (Placement(transformation(extent={{-80,-90},{-60,-70}}, rotation=
           0)));
  MultiPhase.Basic.PlugToPin_p plugToPin_p1(m=m, k=1) 
    annotation (Placement(transformation(extent={{12,70},{32,90}}, rotation=0)));
  MultiPhase.Basic.PlugToPin_p plugToPin_p2(k=2, m=m) 
    annotation (Placement(transformation(extent={{10,0},{30,20}}, rotation=0)));
  MultiPhase.Basic.PlugToPin_p plugToPin_p3(k=3, m=m) 
    annotation (Placement(transformation(extent={{10,-70},{30,-50}}, rotation=0)));
  MultiPhase.Sensors.PowerSensor powerSensor(m=m) 
    annotation (Placement(transformation(extent={{-60,0},{-40,20}}, rotation=0)));
  MultiPhase.Sensors.CurrentSensor currentSensor(m=m) 
    annotation (Placement(transformation(extent={{-30,0},{-10,20}}, rotation=0)));
  SinglePhase.Basic.Resistor resistor(R_ref=R) 
    annotation (Placement(transformation(
        origin={70,30},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  SinglePhase.Basic.Capacitor capacitor(C=C) 
    annotation (Placement(transformation(
        origin={40,32},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  SinglePhase.Basic.Inductor inductor(L=L) 
    annotation (Placement(transformation(
        origin={40,-38},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  SinglePhase.Sensors.CurrentSensor currentSensor12 
    annotation (Placement(transformation(
        origin={40,62},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  SinglePhase.Sensors.CurrentSensor currentSensor23 
    annotation (Placement(transformation(
        origin={40,-8},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  SinglePhase.Sensors.CurrentSensor currentSensor31 
    annotation (Placement(transformation(
        origin={70,-10},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.ComplexBlocks.ComplexMath.ComplexToPolar complexToPolar[m] 
    annotation (Placement(transformation(
        origin={-20,-20},
        extent={{-10,-10},{10,10}},
        rotation=270)));
equation
  connect(ground.pin, star.pin_n) annotation (Line(points={{-70,-70},{-70,-60}},
        color={85,170,255}));
  connect(star.plug_p, voltageSource.plug_n) annotation (Line(points={{-70,-40},
          {-70,-30}}, color={85,170,255}));
  connect(voltageSource.plug_p, powerSensor.currentP) annotation (Line(points={
          {-70,-10},{-70,10},{-60,10}}, color={85,170,255}));
  connect(powerSensor.currentP, powerSensor.voltageP) annotation (Line(points={
          {-60,10},{-60,20},{-50,20}}, color={85,170,255}));
  connect(powerSensor.currentN, currentSensor.plug_p) 
    annotation (Line(points={{-40,10},{-30,10}}, color={85,170,255}));
  connect(powerSensor.voltageN, star.plug_p) annotation (Line(points={{-50,0},{-50,
          -40},{-70,-40}},                     color={85,170,255}));
  connect(currentSensor.plug_n, plugToPin_p2.plug_p) 
    annotation (Line(points={{-10,10},{18,10}}, color={85,170,255}));
  connect(currentSensor.plug_n, plugToPin_p1.plug_p) annotation (Line(points={{
          -10,10},{0,10},{0,80},{20,80}}, color={85,170,255}));
  connect(currentSensor.plug_n, plugToPin_p3.plug_p) annotation (Line(points={{
          -10,10},{0,10},{0,-60},{18,-60}}, color={85,170,255}));
  connect(currentSensor12.pin_p, plugToPin_p1.pin_p) annotation (Line(points={{
          40,72},{40,80},{24,80}}, color={85,170,255}));
  connect(currentSensor12.pin_n, capacitor.pin_p) annotation (Line(points={{40,
          52},{40,42}}, color={85,170,255}));
  connect(capacitor.pin_n, plugToPin_p2.pin_p) annotation (Line(points={{40,22},
          {40,10},{22,10}}, color={85,170,255}));
  connect(plugToPin_p2.pin_p, currentSensor23.pin_p) annotation (Line(points={{22,10},
          {40,10},{40,2}},        color={85,170,255}));
  connect(currentSensor23.pin_n, inductor.pin_p) annotation (Line(points={{40,
          -18},{40,-28}}, color={85,170,255}));
  connect(inductor.pin_n, plugToPin_p3.pin_p) annotation (Line(points={{40,-48},
          {40,-60},{22,-60}}, color={85,170,255}));
  connect(plugToPin_p1.pin_p, resistor.pin_n) annotation (Line(points={{24,80},
          {70,80},{70,40}}, color={85,170,255}));
  connect(resistor.pin_p, currentSensor31.pin_n) 
    annotation (Line(points={{70,20},{70,0}},            color={85,170,255}));
  connect(currentSensor31.pin_p, plugToPin_p3.pin_p) annotation (Line(points={{
          70,-20},{70,-60},{22,-60}}, color={85,170,255}));
  connect(currentSensor.y, complexToPolar.u) annotation (Line(
      points={{-20,-1},{-20,-4.5},{-20,-8},{-20,-8}},
      color={85,170,255},
      smooth=Smooth.None));
  annotation (Diagram(graphics={Text(
          extent={{-100,-80},{100,-100}},
          lineColor={0,0,255},
          textString=
            "L and C are choosen such way that the 3 source currents are balanced")}));
end BalancingDelta;
