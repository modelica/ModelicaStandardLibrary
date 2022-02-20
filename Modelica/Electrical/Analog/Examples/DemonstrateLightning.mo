within Modelica.Electrical.Analog.Examples;
model DemonstrateLightning
  "Demonstrate trajectory of lightning current"
  extends Modelica.Icons.Example;
  parameter Modelica.Units.SI.Time T1=10e-6 "Rise time";
  parameter Modelica.Units.SI.Time T2=350e-6 "Decay time to half value";
  Sources.LightningImpulseVoltage lightning1(
    approximation=Modelica.Electrical.Analog.Types.ImpulseApproximation.DoubleExp,

    V=100e3,
    T1=T1,
    T2=T2,
    startTime=10e-6) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-70,40})));
  Sources.LightningImpulseCurrent lightning2(
    approximation=Modelica.Electrical.Analog.Types.ImpulseApproximation.Heidler,

    I=100e3,
    T1=T1,
    T2=T2,
    startTime=10e-6) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-70,-60})));

  Basic.Ground ground1
    annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
  Basic.Ground ground2
    annotation (Placement(transformation(extent={{-80,-100},{-60,-80}})));
  Basic.Resistor resistor1(R=1) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-30,40})));
  Basic.Resistor resistor2(R=1) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-30,-60})));
  Sensors.CurrentSensor currentSensor1
    annotation (Placement(transformation(extent={{-60,70},{-40,50}})));
  Sensors.CurrentSensor currentSensor2
    annotation (Placement(transformation(extent={{-60,-30},{-40,-50}})));
 Modelica.Blocks.Continuous.Integrator integrator1
    annotation (Placement(transformation(extent={{10,70},{30,90}})));
  Modelica.Blocks.Continuous.Der der1
    annotation (Placement(transformation(extent={{10,40},{30,60}})));
  Modelica.Blocks.Continuous.Integrator integrator2
    annotation (Placement(transformation(extent={{10,-30},{30,-10}})));
  Modelica.Blocks.Continuous.Der der2
    annotation (Placement(transformation(extent={{10,-60},{30,-40}})));
equation
  connect(integrator1.u, der1.u)
    annotation (Line(points={{8,80},{0,80},{0,50},{8,50}}, color={0,0,127}));
  connect(integrator2.u, der2.u)
    annotation (Line(points={{8,-20},{0,-20},{0,-50},{8,-50}}, color={0,0,127}));
  connect(lightning2.p, ground2.p)
    annotation (Line(points={{-70,-70},{-70,-80}}, color={0,0,255}));
  connect(ground1.p,resistor1. n)
    annotation (Line(points={{-70,20},{-30,20},{-30,30}}, color={0,0,255}));
  connect(ground2.p,resistor2. n)
    annotation (Line(points={{-70,-80},{-30,-80},{-30,-70}}, color={0,0,255}));
  connect(currentSensor1.n,resistor1. p)
    annotation (Line(points={{-40,60},{-30,60},{-30,50}}, color={0,0,255}));
  connect(currentSensor1.i, der1.u) annotation (Line(points={{-50,71},{-50,80},{
          0,80},{0,50},{8,50}}, color={0,0,127}));
  connect(lightning2.n, currentSensor2.p)
    annotation (Line(points={{-70,-50},{-70,-40},{-60,-40}}, color={0,0,255}));
  connect(currentSensor2.n,resistor2. p)
    annotation (Line(points={{-40,-40},{-30,-40},{-30,-50}}, color={0,0,255}));
  connect(currentSensor2.i, der2.u) annotation (Line(points={{-50,-29},{-50,-20},
          {0,-20},{0,-50},{8,-50}}, color={0,0,127}));
  connect(lightning1.n, ground1.p)
    annotation (Line(points={{-70,30},{-70,20}}, color={0,0,255}));
  connect(lightning1.p, currentSensor1.p)
    annotation (Line(points={{-70,50},{-70,60},{-60,60}}, color={0,0,255}));
  annotation (experiment(
      StopTime=0.001,
      Interval=1e-07,
      Tolerance=1e-06), Documentation(info="<html>
<p>
Compare 2 lightning trajectories: No.1 with double exponential function, No.2 with Heidler function.
</p>
<p>Variables of interest are:</p>
<ul>
<li><code>currentSensor1.y</code></li>
<li><code>integrator1.y</code></li>
<li><code>der1.y</code></li>
<li><code>currentSensor2.y</code></li>
<li><code>integrator2.y</code></li>
<li><code>der2.y</code></li>
</ul>
</html>"));
end DemonstrateLightning;
