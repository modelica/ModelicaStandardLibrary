within Modelica.Clocked.Examples.Elementary.RealSignals;
model SuperSampleInterpolated
  "Example of a SuperSampleInterpolated block for Real signals"
   extends Modelica.Icons.Example;

  Modelica.Blocks.Sources.Sine sine(f=2,
    offset=0.1,
    startTime=0)
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Modelica.Clocked.RealSignals.Sampler.SampleClocked sample1
    annotation (Placement(transformation(extent={{-46,24},{-34,36}})));
  Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
      factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
    annotation (Placement(transformation(extent={{-62,-6},{-50,6}})));
Modelica.Clocked.RealSignals.Sampler.SuperSampleInterpolated superSampleIpo(
    inferFactor=false, factor=3)
  annotation (Placement(transformation(extent={{-22,24},{-10,36}})));
equation
  connect(sine.y, sample1.u)
    annotation (Line(points={{-59,30},{-47.2,30}}, color={0,0,127}));
  connect(periodicClock.y, sample1.clock) annotation (Line(
      points={{-49.4,0},{-40,0},{-40,22.8}},
      color={175,175,175},
      pattern=LinePattern.Dot,
      thickness=0.5));
  connect(sample1.y, superSampleIpo.u)
    annotation (Line(points={{-33.4,30},{-23.2,30}}, color={0,0,127}));
  annotation (experiment(StopTime=0.06),
  Documentation(info="<html>
<p>
Example used to generate a figure for the documentation of block
<a href=\"modelica:/Modelica.Clocked.RealSignals.Sampler.SuperSampleInterpolated\">Modelica.Clocked.RealSignals.Sampler.SuperSampleInterpolated</a>.
</p>
</html>"));
end SuperSampleInterpolated;
