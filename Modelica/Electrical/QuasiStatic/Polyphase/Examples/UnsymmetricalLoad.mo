within Modelica.Electrical.QuasiStatic.Polyphase.Examples;
model UnsymmetricalLoad "Unsymmetrical three-phase load"
  extends Modelica.Icons.Example;
  import Modelica.ComplexMath.abs;
  output SI.Current i1_d=symmetricalComponents_1.abs_y[1]
    "With neutral, direct component";
  output SI.Current i1_i=symmetricalComponents_1.abs_y[2]
    "With neutral, inverse component";
  output SI.Current i1_0=symmetricalComponents_1.abs_y[3]
    "With neutral, zero component";
  output SI.Current i1_n=abs(currentSensorN.i)
    "With neutral, neutral current";
  output SI.Current i2_d=symmetricalComponents_2.abs_y[1]
    "Without neutral, direct component";
  output SI.Current i2_i=symmetricalComponents_2.abs_y[2]
    "Without neutral, inverse component";
  output SI.Current i2_0=symmetricalComponents_2.abs_y[3]
    "Without neutral, zero component";
  output SI.Voltage v2_n=abs(voltageSensorN.v)
    "Without neutral, neutral voltage";

  Sources.VoltageSource voltageSource1(
    m=3,
    f=50,
    V=fill(400/sqrt(3), 3),
    gamma(fixed=true, start=0))
                            annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-70,80})));
  Basic.Star star1_1(m=3) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-70,50})));
  SinglePhase.Basic.Ground ground1
    annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
  Sources.VoltageSource voltageSource2(
    m=3,
    f=50,
    V=fill(400/sqrt(3), 3),
    gamma(fixed=true, start=0))
                            annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-70,-20})));
  Basic.Star star2_1(m=3) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-70,-50})));
  SinglePhase.Basic.Ground ground2
    annotation (Placement(transformation(extent={{-80,-100},{-60,-80}})));
  Sensors.CurrentSensor currentSensor1(m=3)
    annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
  Blocks.SymmetricalComponents symmetricalComponents_1(m=3) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-50,50})));
  Sensors.CurrentSensor currentSensor2(m=3)
    annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
  Blocks.SymmetricalComponents symmetricalComponents_2(m=3) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-50,-50})));
  SinglePhase.Basic.Resistor resistor1_1(R_ref=110)
    annotation (Placement(transformation(extent={{-10,80},{10,100}})));
  SinglePhase.Basic.Resistor resistor1_2(R_ref=100)
    annotation (Placement(transformation(extent={{-10,60},{10,80}})));
  SinglePhase.Basic.Resistor resistor1_3(R_ref=60)
    annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  SinglePhase.Basic.Inductor inductor1_2(L=0.25)
    annotation (Placement(transformation(extent={{20,60},{40,80}})));
  SinglePhase.Basic.Capacitor capacitor1_3(C=35e-6)
    annotation (Placement(transformation(extent={{-10,20},{10,40}})));
  SinglePhase.Basic.Resistor resistor2_1(R_ref=110)
    annotation (Placement(transformation(extent={{-10,-20},{10,0}})));
  SinglePhase.Basic.Resistor resistor2_2(R_ref=100)
    annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
  SinglePhase.Basic.Resistor resistor2_3(R_ref=60)
    annotation (Placement(transformation(extent={{-10,-60},{10,-40}})));
  SinglePhase.Basic.Inductor inductor2_2(L=0.25)
    annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
  SinglePhase.Basic.Capacitor capacitor2_3(C=35e-6)
    annotation (Placement(transformation(extent={{-10,-80},{10,-60}})));
  Basic.PlugToPins_p plugToPins_p_1(m=3)
    annotation (Placement(transformation(extent={{-40,100},{-20,80}})));
  Basic.PlugToPins_p plugToPins_p_2(m=3)
    annotation (Placement(transformation(extent={{-40,0},{-20,-20}})));
  Basic.PlugToPins_n plugToPins_n_1(m=3)
    annotation (Placement(transformation(extent={{70,100},{50,80}})));
  Basic.PlugToPins_n plugToPins_n_2(m=3)
    annotation (Placement(transformation(extent={{72,0},{52,-20}})));
  Basic.Star star1_2(m=3) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={80,50})));
  Basic.Star star2_2(m=3) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={80,-50})));
  SinglePhase.Sensors.CurrentSensor currentSensorN
    annotation (Placement(transformation(extent={{70,30},{50,10}})));
  SinglePhase.Sensors.VoltageSensor voltageSensorN
    annotation (Placement(transformation(extent={{70,-70},{50,-90}})));
equation
  connect(voltageSource1.plug_n, star1_1.plug_p)
    annotation (Line(points={{-70,70},{-70,65},{-70,60}}, color={85,170,255}));
  connect(star1_1.pin_n, ground1.pin)
    annotation (Line(points={{-70,40},{-70,20}}, color={85,170,255}));
  connect(voltageSource2.plug_n, star2_1.plug_p) annotation (Line(points={{-70,-30},
          {-70,-35},{-70,-40}}, color={85,170,255}));
  connect(star2_1.pin_n, ground2.pin)
    annotation (Line(points={{-70,-60},{-70,-80}}, color={85,170,255}));
  connect(voltageSource1.plug_p, currentSensor1.plug_p)
    annotation (Line(points={{-70,90},{-65,90},{-60,90}}, color={85,170,255}));
  connect(voltageSource2.plug_p, currentSensor2.plug_p) annotation (Line(points=
         {{-70,-10},{-65,-10},{-60,-10}}, color={85,170,255}));
  connect(resistor1_2.pin_n, inductor1_2.pin_p)
    annotation (Line(points={{10,70},{20,70}}, color={85,170,255}));
  connect(resistor1_3.pin_p, capacitor1_3.pin_p)
    annotation (Line(points={{-10,50},{-10,30}}, color={85,170,255}));
  connect(resistor1_3.pin_n, capacitor1_3.pin_n)
    annotation (Line(points={{10,50},{10,40},{10,30}}, color={85,170,255}));
  connect(resistor2_2.pin_n, inductor2_2.pin_p)
    annotation (Line(points={{10,-30},{20,-30}}, color={85,170,255}));
  connect(resistor2_3.pin_n, capacitor2_3.pin_n)
    annotation (Line(points={{10,-50},{10,-60},{10,-70}}, color={85,170,255}));
  connect(resistor2_3.pin_p, capacitor2_3.pin_p) annotation (Line(points={{-10,-50},
          {-10,-70},{-10,-70}}, color={85,170,255}));
  connect(currentSensor1.plug_n, plugToPins_p_1.plug_p)
    annotation (Line(points={{-40,90},{-36,90},{-32,90}}, color={85,170,255}));
  connect(currentSensor2.plug_n, plugToPins_p_2.plug_p) annotation (Line(points=
         {{-40,-10},{-32,-10},{-32,-10}}, color={85,170,255}));
  connect(plugToPins_p_1.pin_p[1], resistor1_1.pin_p) annotation (Line(points={{-28,
          90.6667},{-19,90},{-10,90}}, color={85,170,255}));
  connect(plugToPins_p_1.pin_p[2], resistor1_2.pin_p) annotation (Line(points={{
          -28,90},{-18,90},{-18,70},{-10,70}}, color={85,170,255}));
  connect(plugToPins_p_1.pin_p[3], resistor1_3.pin_p) annotation (Line(points={{-28,
          89.3333},{-22,89.3333},{-22,50},{-10,50}}, color={85,170,255}));
  connect(plugToPins_p_2.pin_p[1], resistor2_1.pin_p) annotation (Line(points={{-28,
          -9.33333},{-20,-9.33333},{-20,-10},{-10,-10}}, color={85,170,255}));
  connect(plugToPins_p_2.pin_p[2], resistor2_2.pin_p) annotation (Line(points={{
          -28,-10},{-18,-10},{-18,-30},{-10,-30}}, color={85,170,255}));
  connect(plugToPins_p_2.pin_p[3], resistor2_3.pin_p) annotation (Line(points={{-28,
          -10.6667},{-22,-10.6667},{-22,-50},{-10,-50}}, color={85,170,255}));
  connect(plugToPins_n_1.pin_n[1], resistor1_1.pin_n) annotation (Line(points={{58,
          90.6667},{34,90},{10,90}}, color={85,170,255}));
  connect(plugToPins_n_1.pin_n[2], inductor1_2.pin_n) annotation (Line(points={{
          58,90},{48,90},{48,70},{40,70}}, color={85,170,255}));
  connect(plugToPins_n_1.pin_n[3], resistor1_3.pin_n) annotation (Line(points={{58,
          89.3333},{52,89.3333},{52,50},{10,50}}, color={85,170,255}));
  connect(plugToPins_n_2.pin_n[1], resistor2_1.pin_n) annotation (Line(points={{60,
          -9.33333},{36,-10},{10,-10}}, color={85,170,255}));
  connect(plugToPins_n_2.pin_n[2], inductor2_2.pin_n) annotation (Line(points={{
          60,-10},{48,-10},{48,-30},{40,-30}}, color={85,170,255}));
  connect(plugToPins_n_2.pin_n[3], resistor2_3.pin_n) annotation (Line(points={{60,
          -10.6667},{52,-10.6667},{52,-50},{10,-50}}, color={85,170,255}));
  connect(plugToPins_n_1.plug_n, star1_2.plug_p)
    annotation (Line(points={{62,90},{80,90},{80,60}}, color={85,170,255}));
  connect(plugToPins_n_2.plug_n, star2_2.plug_p)
    annotation (Line(points={{64,-10},{80,-10},{80,-40}}, color={85,170,255}));
  connect(star1_2.pin_n, currentSensorN.pin_p)
    annotation (Line(points={{80,40},{80,20},{70,20}}, color={85,170,255}));
  connect(currentSensorN.pin_n, ground1.pin)
    annotation (Line(points={{50,20},{-10,20},{-70,20}}, color={85,170,255}));
  connect(star2_2.pin_n, voltageSensorN.pin_p)
    annotation (Line(points={{80,-60},{80,-80},{70,-80}}, color={85,170,255}));
  connect(voltageSensorN.pin_n, ground2.pin) annotation (Line(points={{50,-80},{
          -10,-80},{-70,-80}}, color={85,170,255}));
  connect(currentSensor1.i, symmetricalComponents_1.u)
    annotation (Line(points={{-50,79},{-50,62}}, color={85,170,255}));
  connect(currentSensor2.i, symmetricalComponents_2.u) annotation (Line(points={
          {-50,-21},{-50,-29.5},{-50,-38}}, color={85,170,255}));
  annotation (Documentation(info="<html>
<p>
This example shows an unsymmetrical load, in the upper with neutral connection (the single-phase current sensor measures the neutral current) and in the lower without neutral connection (the single-phase voltage sensor measures the neutral displacement).
</p>
</html>"),
  experiment(StopTime=1.0, Interval=0.001));
end UnsymmetricalLoad;
