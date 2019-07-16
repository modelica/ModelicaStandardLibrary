within Modelica.Electrical.Analog.Examples;
model ParallelResonance "Parallel resonance ciruit"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  Sources.SineCurrentVariableFrequencyAndAmplitude sineCurrent(
      useConstantAmplitude=true,                               phi(fixed=true))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-40,0})));
  Basic.Ground ground
    annotation (Placement(transformation(extent={{-50,-40},{-30,-20}})));
  Basic.Resistor resistor(R=0.5)
                               annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-10,30})));
  Basic.Inductor inductor(i(fixed=true), L=0.1/(2*pi))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-10,0})));
  Basic.Capacitor capacitor(v(fixed=true), C=0.001/(2*pi))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={10,0})));
  Sensors.VoltageSensor voltageSensor
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={40,0})));
  Blocks.Sources.Ramp ramp(
    height=200,
    duration=1,
    offset=0,
    startTime=0)
    annotation (Placement(transformation(extent={{-90,-30},{-70,-10}})));
equation
  connect(sineCurrent.p, ground.p)
    annotation (Line(points={{-40,-10},{-40,-20}}, color={0,0,255}));
  connect(ramp.y, sineCurrent.f) annotation (Line(points={{-69,-20},{-60,-20},{
          -60,-6},{-52,-6}}, color={0,0,127}));
  connect(ground.p, inductor.n)
    annotation (Line(points={{-40,-20},{-10,-20},{-10,-10}}, color={0,0,255}));
  connect(sineCurrent.n, resistor.p) annotation (Line(points={{-40,10},{-40,50},
          {-10,50},{-10,40}}, color={0,0,255}));
  connect(resistor.n, inductor.p)
    annotation (Line(points={{-10,20},{-10,10}}, color={0,0,255}));
  connect(ground.p, capacitor.n)
    annotation (Line(points={{-40,-20},{10,-20},{10,-10}}, color={0,0,255}));
  connect(sineCurrent.n, capacitor.p) annotation (Line(points={{-40,10},{-40,50},
          {10,50},{10,10}}, color={0,0,255}));
  connect(sineCurrent.n, voltageSensor.p) annotation (Line(points={{-40,10},{
          -40,50},{40,50},{40,10}}, color={0,0,255}));
  connect(ground.p, voltageSensor.n)
    annotation (Line(points={{-40,-20},{40,-20},{40,-10}}, color={0,0,255}));
  annotation (experiment(Interval=0.0001), Documentation(info="<html>
<p>
This model demonstrates the transient behaviour of a parallel resonant circuit:
A sinusoidal current with variable frequency and constant amplitude is applied to a parallel connection of L, C and R. 
The parameter values result in a resonance frequency of 100 Hz.
</p>
</html>"));
end ParallelResonance;
