within Modelica.Clocked.Examples.Elementary.RealSignals;
model SampleWithADeffects
  "Example of a SampleWithADeffects block for Real signals"
   extends Modelica.Icons.Example;

  Modelica.Blocks.Sources.Sine sine(f=2,
    startTime=0,
    amplitude=0.95)
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Modelica.Clocked.RealSignals.Sampler.SampleWithADeffects sample1(
    noisy=true,
    limited=true,
    quantized=true,
    yMax=0.8,
    redeclare
      Modelica.Clocked.RealSignals.Sampler.Utilities.Internal.UniformNoise
      noise(noiseMax=0.2))
    annotation (Placement(transformation(extent={{-46,24},{-34,36}})));
  Modelica.Clocked.RealSignals.Sampler.AssignClock assignClock
    annotation (Placement(transformation(extent={{-22,24},{-10,36}})));
  Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
      resolution=Modelica.Clocked.Types.Resolution.ms, factor=20)
    annotation (Placement(transformation(extent={{-42,-2},{-30,10}})));
equation
  connect(sine.y, sample1.u)
    annotation (Line(points={{-59,30},{-47.2,30}}, color={0,0,127}));
  connect(sample1.y, assignClock.u)
    annotation (Line(points={{-33.4,30},{-23.2,30}}, color={0,0,127}));
  connect(periodicClock.y, assignClock.clock) annotation (Line(
      points={{-29.4,4},{-16,4},{-16,22.8}},
      color={175,175,175},
      pattern=LinePattern.Dot,
      thickness=0.5));
  annotation (experiment(StopTime=0.2),
    Documentation(info="<html>
<p>
Example used to generate a figure for the documentation of block
<a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.SampleWithADeffects\">Modelica.Clocked.RealSignals.Sampler.SampleWithADeffects</a>.
</p>
</html>"));
end SampleWithADeffects;
