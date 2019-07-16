within Modelica.Electrical.Analog.Examples;
model SeriesResonance "Series resonance ciruit"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  Sources.SineVoltageVariableFrequencyAndAmplitude sineVoltage(
      useConstantAmplitude=true,                               phi(fixed=true))
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-40,0})));
  Basic.Ground ground
    annotation (Placement(transformation(extent={{-50,-40},{-30,-20}})));
  Basic.Resistor resistor(R=0.5)
                               annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={40,0})));
  Basic.Inductor inductor(i(fixed=true), L=0.1/(2*pi))
    annotation (Placement(transformation(extent={{-30,10},{-10,30}})));
  Basic.Capacitor capacitor(v(fixed=true), C=0.001/(2*pi))
    annotation (Placement(transformation(extent={{10,10},{30,30}})));
  Sensors.CurrentSensor currentSensor
    annotation (Placement(transformation(extent={{12,-30},{-8,-10}})));
  Blocks.Sources.Ramp ramp(
    height=200,
    duration=1,
    offset=0,
    startTime=0)
    annotation (Placement(transformation(extent={{-90,10},{-70,30}})));
equation
  connect(sineVoltage.p, inductor.p)
    annotation (Line(points={{-40,10},{-40,20},{-30,20}}, color={0,0,255}));
  connect(inductor.n, capacitor.p)
    annotation (Line(points={{-10,20},{10,20}}, color={0,0,255}));
  connect(capacitor.n, resistor.p)
    annotation (Line(points={{30,20},{40,20},{40,10}}, color={0,0,255}));
  connect(sineVoltage.n, ground.p)
    annotation (Line(points={{-40,-10},{-40,-20}}, color={0,0,255}));
  connect(currentSensor.p, resistor.n)
    annotation (Line(points={{12,-20},{40,-20},{40,-10}}, color={0,0,255}));
  connect(ramp.y, sineVoltage.f) annotation (Line(points={{-69,20},{-60,20},{-60,
          6},{-52,6}}, color={0,0,127}));
  connect(ground.p, currentSensor.n)
    annotation (Line(points={{-40,-20},{-8,-20}}, color={0,0,255}));
  annotation (experiment(Interval=0.0001), Documentation(info="<html>
<p>
This model demonstrates the transient behaviour of a series resonant circuit:
A sinusoidal voltage with variable frequency and constant amplitude is applied to a series connection of L, C and R. 
The parameter values result in a resonance frequency of 100 Hz.
</p>
</html>"));
end SeriesResonance;
