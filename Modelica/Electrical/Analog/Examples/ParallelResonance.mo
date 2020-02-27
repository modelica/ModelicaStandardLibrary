within Modelica.Electrical.Analog.Examples;
model ParallelResonance "Parallel resonance circuit"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  Sources.SineCurrentVariableFrequencyAndAmplitude sineCurrent(
      useConstantAmplitude=true,                               phi(fixed=true))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-40,40})));
  Basic.Ground ground1
    annotation (Placement(transformation(extent={{-50,0},{-30,20}})));
  Basic.Resistor resistor1(R=0.5) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-10,70})));
  Basic.Inductor inductor1(i(fixed=true), L=0.1/(2*pi)) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-10,40})));
  Basic.Capacitor capacitor1(v(fixed=true), C=0.001/(2*pi)) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={10,40})));
  Sensors.VoltageSensor voltageSensor1 annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={40,40})));
  Blocks.Sources.Ramp ramp(
    height=200,
    duration=1,
    offset=0,
    startTime=0)
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  Sources.CosineCurrentVariableFrequencyAndAmplitude cosineCurrent(
      useConstantAmplitude=true, phi(fixed=true)) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-40,-60})));
  Basic.Ground ground2
    annotation (Placement(transformation(extent={{-50,-100},{-30,-80}})));
  Basic.Resistor resistor2(R=0.5) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-10,-30})));
  Basic.Inductor inductor2(i(fixed=true), L=0.1/(2*pi)) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-10,-60})));
  Basic.Capacitor capacitor2(v(fixed=true), C=0.001/(2*pi)) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={10,-60})));
  Sensors.VoltageSensor voltageSensor2 annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={40,-60})));
equation
  connect(sineCurrent.p, ground1.p)
    annotation (Line(points={{-40,30},{-40,20}}, color={0,0,255}));
  connect(ramp.y, sineCurrent.f) annotation (Line(points={{-69,0},{-60,0},{-60,
          34},{-52,34}},     color={0,0,127}));
  connect(ground1.p, inductor1.n)
    annotation (Line(points={{-40,20},{-10,20},{-10,30}}, color={0,0,255}));
  connect(sineCurrent.n, resistor1.p) annotation (Line(points={{-40,50},{-40,90},
          {-10,90},{-10,80}}, color={0,0,255}));
  connect(resistor1.n, inductor1.p)
    annotation (Line(points={{-10,60},{-10,50}}, color={0,0,255}));
  connect(ground1.p, capacitor1.n)
    annotation (Line(points={{-40,20},{10,20},{10,30}}, color={0,0,255}));
  connect(sineCurrent.n, capacitor1.p) annotation (Line(points={{-40,50},{-40,
          90},{10,90},{10,50}}, color={0,0,255}));
  connect(sineCurrent.n, voltageSensor1.p) annotation (Line(points={{-40,50},{
          -40,90},{40,90},{40,50}}, color={0,0,255}));
  connect(ground1.p, voltageSensor1.n)
    annotation (Line(points={{-40,20},{40,20},{40,30}}, color={0,0,255}));
  connect(cosineCurrent.p, ground2.p)
    annotation (Line(points={{-40,-70},{-40,-80}}, color={0,0,255}));
  connect(ground2.p, inductor2.n)
    annotation (Line(points={{-40,-80},{-10,-80},{-10,-70}}, color={0,0,255}));
  connect(cosineCurrent.n, resistor2.p) annotation (Line(points={{-40,-50},{-40,
          -10},{-10,-10},{-10,-20}}, color={0,0,255}));
  connect(resistor2.n, inductor2.p)
    annotation (Line(points={{-10,-40},{-10,-50}}, color={0,0,255}));
  connect(ground2.p, capacitor2.n)
    annotation (Line(points={{-40,-80},{10,-80},{10,-70}}, color={0,0,255}));
  connect(cosineCurrent.n, capacitor2.p) annotation (Line(points={{-40,-50},{
          -40,-10},{10,-10},{10,-50}}, color={0,0,255}));
  connect(cosineCurrent.n, voltageSensor2.p) annotation (Line(points={{-40,-50},
          {-40,-10},{40,-10},{40,-50}}, color={0,0,255}));
  connect(ground2.p, voltageSensor2.n)
    annotation (Line(points={{-40,-80},{40,-80},{40,-70}}, color={0,0,255}));
  connect(ramp.y, cosineCurrent.f) annotation (Line(points={{-69,0},{-60,0},{
          -60,-66},{-52,-66}}, color={0,0,127}));
  annotation (experiment(StopTime=1.0, Interval=0.0001), Documentation(info="<html>
<p>
This model demonstrates the transient behaviour of a parallel resonant circuit:
A sine or cosine current with variable frequency and constant amplitude is applied to a parallel connection of L, C and R.
The parameter values result in a resonance frequency of 100 Hz.
</p>
</html>"));
end ParallelResonance;
