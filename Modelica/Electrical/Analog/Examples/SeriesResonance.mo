within Modelica.Electrical.Analog.Examples;
model SeriesResonance "Series resonance circuit"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  Sources.SineVoltageVariableFrequencyAndAmplitude sineVoltage(
      useConstantAmplitude=true,                               phi(fixed=true))
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-40,50})));
  Basic.Ground ground1
    annotation (Placement(transformation(extent={{-50,10},{-30,30}})));
  Basic.Resistor resistor1(R=0.5) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={40,50})));
  Basic.Inductor inductor1(i(fixed=true), L=0.1/(2*pi))
    annotation (Placement(transformation(extent={{-30,60},{-10,80}})));
  Basic.Capacitor capacitor1(v(fixed=true), C=0.001/(2*pi))
    annotation (Placement(transformation(extent={{10,60},{30,80}})));
  Sensors.CurrentSensor currentSensor1
    annotation (Placement(transformation(extent={{10,20},{-10,40}})));
  Blocks.Sources.Ramp ramp(
    height=200,
    duration=1,
    offset=0,
    startTime=0)
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  Sources.CosineVoltageVariableFrequencyAndAmplitude cosineVoltage(
      useConstantAmplitude=true, phi(fixed=true)) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-40,-50})));
  Basic.Ground ground2
    annotation (Placement(transformation(extent={{-50,-90},{-30,-70}})));
  Basic.Resistor resistor2(R=0.5) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={40,-50})));
  Basic.Inductor inductor2(i(fixed=true), L=0.1/(2*pi))
    annotation (Placement(transformation(extent={{-30,-40},{-10,-20}})));
  Basic.Capacitor capacitor2(v(fixed=true), C=0.001/(2*pi))
    annotation (Placement(transformation(extent={{10,-40},{30,-20}})));
  Sensors.CurrentSensor currentSensor2
    annotation (Placement(transformation(extent={{10,-80},{-10,-60}})));
equation
  connect(sineVoltage.p, inductor1.p)
    annotation (Line(points={{-40,60},{-40,70},{-30,70}}, color={0,0,255}));
  connect(inductor1.n, capacitor1.p)
    annotation (Line(points={{-10,70},{10,70}}, color={0,0,255}));
  connect(capacitor1.n, resistor1.p)
    annotation (Line(points={{30,70},{40,70},{40,60}}, color={0,0,255}));
  connect(sineVoltage.n, ground1.p)
    annotation (Line(points={{-40,40},{-40,30}}, color={0,0,255}));
  connect(currentSensor1.p, resistor1.n)
    annotation (Line(points={{10,30},{40,30},{40,40}}, color={0,0,255}));
  connect(ramp.y, sineVoltage.f) annotation (Line(points={{-69,0},{-60,0},{-60,
          56},{-52,56}},
                       color={0,0,127}));
  connect(ground1.p, currentSensor1.n)
    annotation (Line(points={{-40,30},{-10,30}}, color={0,0,255}));
  connect(cosineVoltage.p, inductor2.p)
    annotation (Line(points={{-40,-40},{-40,-30},{-30,-30}}, color={0,0,255}));
  connect(inductor2.n, capacitor2.p)
    annotation (Line(points={{-10,-30},{10,-30}}, color={0,0,255}));
  connect(capacitor2.n, resistor2.p)
    annotation (Line(points={{30,-30},{40,-30},{40,-40}}, color={0,0,255}));
  connect(cosineVoltage.n, ground2.p)
    annotation (Line(points={{-40,-60},{-40,-70}}, color={0,0,255}));
  connect(currentSensor2.p, resistor2.n)
    annotation (Line(points={{10,-70},{40,-70},{40,-60}}, color={0,0,255}));
  connect(ground2.p, currentSensor2.n)
    annotation (Line(points={{-40,-70},{-10,-70}}, color={0,0,255}));
  connect(ramp.y, cosineVoltage.f) annotation (Line(points={{-69,0},{-60,0},{
          -60,-44},{-52,-44}}, color={0,0,127}));
  annotation (experiment(StopTime=1.0, Interval=0.0001), Documentation(info="<html>
<p>
This model demonstrates the transient behaviour of a series resonant circuit:
A sine or cosine voltage with variable frequency and constant amplitude is applied to a series connection of L, C and R.
The parameter values result in a resonance frequency of 100 Hz.
</p>
</html>"));
end SeriesResonance;
