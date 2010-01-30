within Modelica.Electrical.QuasiStationary.Examples;
model BalancingStar "Balancing an unsymmetrical star-connected load"
//P.Vaske, Berechnung von Drehstromschaltungen, Teubner 1973, Seite 42, Beispiel 18
  extends Modelica.Icons.Example;
  parameter Integer m=3;
  parameter Modelica.SIunits.Voltage V = 100;
  parameter Modelica.SIunits.Frequency f = 50;
  parameter Modelica.SIunits.Resistance R = 10;
  parameter Modelica.SIunits.Inductance L = (R*sqrt(3))/(2*Modelica.Constants.pi*f);
  parameter Modelica.SIunits.Capacitance C = 1/(R*sqrt(3))/(2*Modelica.Constants.pi*f);
  MultiPhase.Sources.VoltageSource voltageSource(
    m=m,
    f=f,
    V=fill(V, m),
    phi={-(j - 1)*2*Modelica.Constants.pi/m for j in 1:m}) 
    annotation (Placement(transformation(
        origin={-80,-20},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  MultiPhase.Basic.Star star(m=m) 
    annotation (Placement(transformation(
        origin={-80,-50},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  SinglePhase.Basic.Ground ground 
    annotation (Placement(transformation(extent={{-90,-90},{-70,-70}}, rotation=
           0)));
  MultiPhase.Basic.PlugToPin_p plugToPin_p1(m=m, k=1) 
    annotation (Placement(transformation(extent={{-10,40},{10,60}}, rotation=0)));
  MultiPhase.Basic.PlugToPin_p plugToPin_p2(k=2, m=m) 
    annotation (Placement(transformation(extent={{-10,0},{10,20}}, rotation=0)));
  MultiPhase.Basic.PlugToPin_p plugToPin_p3(k=3, m=m) 
    annotation (Placement(transformation(extent={{-10,-40},{10,-20}}, rotation=
            0)));
  MultiPhase.Sensors.PowerSensor powerSensor(m=m) 
    annotation (Placement(transformation(extent={{-70,0},{-50,20}}, rotation=0)));
  MultiPhase.Sensors.CurrentSensor currentSensor(m=m) 
    annotation (Placement(transformation(extent={{-40,0},{-20,20}}, rotation=0)));
  SinglePhase.Basic.Resistor resistor(R_ref=R) 
    annotation (Placement(transformation(extent={{20,-40},{40,-20}}, rotation=0)));
  SinglePhase.Basic.Capacitor capacitor(C=C) 
    annotation (Placement(transformation(extent={{20,0},{40,20}}, rotation=0)));
  SinglePhase.Basic.Inductor inductor(L=L) 
    annotation (Placement(transformation(extent={{20,40},{40,60}}, rotation=0)));
  MultiPhase.Basic.Star star2(m=m) 
    annotation (Placement(transformation(
        origin={80,-50},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  MultiPhase.Basic.PlugToPin_n plugToPin_n1(m=m, k=1) 
    annotation (Placement(transformation(
        origin={60,50},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  MultiPhase.Basic.PlugToPin_n plugToPin_n2(k=2, m=m) 
    annotation (Placement(transformation(
        origin={60,10},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  MultiPhase.Basic.PlugToPin_n plugToPin_n3(k=3, m=m) 
    annotation (Placement(transformation(
        origin={60,-30},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  SinglePhase.Sensors.CurrentSensor currentSensor0 
    annotation (Placement(transformation(
        origin={-30,-60},
        extent={{-10,-10},{10,10}},
        rotation=180)));
equation
  connect(ground.pin, star.pin_n) annotation (Line(points={{-80,-70},{-80,-60}},
        color={85,170,255}));
  connect(star.plug_p, voltageSource.plug_n) annotation (Line(points={{-80,-40},
          {-80,-30}}, color={85,170,255}));
  connect(voltageSource.plug_p, powerSensor.currentP) annotation (Line(points={
          {-80,-10},{-80,10},{-70,10}}, color={85,170,255}));
  connect(powerSensor.currentN, currentSensor.plug_p) 
    annotation (Line(points={{-50,10},{-40,10}}, color={85,170,255}));
  connect(powerSensor.voltageP, powerSensor.currentP) annotation (Line(points={
          {-60,20},{-70,20},{-70,10}}, color={85,170,255}));
  connect(powerSensor.voltageN, star.plug_p) annotation (Line(points={{-60,
          -5.55112e-016},{-60,-40},{-80,-40}}, color={85,170,255}));
  connect(currentSensor.plug_n, plugToPin_p2.plug_p) 
    annotation (Line(points={{-20,10},{-2,10}}, color={85,170,255}));
  connect(currentSensor.plug_n, plugToPin_p3.plug_p) annotation (Line(points={{
          -20,10},{-20,-30},{-2,-30}}, color={85,170,255}));
  connect(currentSensor.plug_n, plugToPin_p1.plug_p) annotation (Line(points={{
          -20,10},{-20,50},{-2,50}}, color={85,170,255}));
  connect(plugToPin_p1.pin_p, inductor.pin_p) 
    annotation (Line(points={{2,50},{20,50}}, color={85,170,255}));
  connect(plugToPin_p2.pin_p, capacitor.pin_p) 
    annotation (Line(points={{2,10},{20,10}}, color={85,170,255}));
  connect(plugToPin_p3.pin_p, resistor.pin_p) 
    annotation (Line(points={{2,-30},{20,-30}}, color={85,170,255}));
  connect(inductor.pin_n, plugToPin_n1.pin_n) 
    annotation (Line(points={{40,50},{58,50}}, color={85,170,255}));
  connect(capacitor.pin_n, plugToPin_n2.pin_n) 
    annotation (Line(points={{40,10},{58,10}}, color={85,170,255}));
  connect(resistor.pin_n, plugToPin_n3.pin_n) 
    annotation (Line(points={{40,-30},{58,-30}}, color={85,170,255}));
  connect(plugToPin_n1.plug_n, star2.plug_p) annotation (Line(points={{62,50},{
          80,50},{80,-40}}, color={85,170,255}));
  connect(plugToPin_n2.plug_n, star2.plug_p) annotation (Line(points={{62,10},{
          80,10},{80,-40}}, color={85,170,255}));
  connect(plugToPin_n3.plug_n, star2.plug_p) annotation (Line(points={{62,-30},
          {80,-30},{80,-40}}, color={85,170,255}));
  connect(star2.pin_n, currentSensor0.pin_p) 
    annotation (Line(points={{80,-60},{-20,-60}}, color={85,170,255}));
  connect(currentSensor0.pin_n, star.pin_n) annotation (Line(points={{-40,-60},
          {-80,-60}}, color={85,170,255}));
  annotation (Diagram(graphics={Text(
          extent={{-100,-80},{100,-100}},
          lineColor={0,0,255},
          textString=
               "L and C are choosen such way that the neutral current is 0")}));
end BalancingStar;
