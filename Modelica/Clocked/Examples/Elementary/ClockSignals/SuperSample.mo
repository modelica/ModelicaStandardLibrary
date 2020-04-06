within Modelica.Clocked.Examples.Elementary.ClockSignals;
model SuperSample "Example of a SuperSample block for Clock signals"
   extends Modelica.Icons.Example;

  Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
      factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
    annotation (Placement(transformation(extent={{-56,24},{-44,36}})));
Modelica.Clocked.ClockSignals.Sampler.SuperSample superSample1(factor=3)
    annotation (Placement(transformation(extent={{-26,24},{-14,36}})));
  Modelica.Clocked.RealSignals.Sampler.SampleClocked sample1
    annotation (Placement(transformation(extent={{10,56},{22,68}})));
  Modelica.Blocks.Sources.Sine sine(f=2,
    offset=0.1,
    startTime=0)
    annotation (Placement(transformation(extent={{-30,52},{-10,72}})));
equation
  connect(periodicClock.y, superSample1.u) annotation (Line(
      points={{-43.4,30},{-27.2,30}},
      color={175,175,175},
      pattern=LinePattern.Dot,
      thickness=0.5));
  connect(sine.y, sample1.u)
    annotation (Line(points={{-9,62},{8.8,62}}, color={0,0,127}));
  connect(superSample1.y, sample1.clock) annotation (Line(
      points={{-13.4,30},{2,30},{16,30},{16,54.8}},
      color={175,175,175},
      pattern=LinePattern.Dot,
      thickness=0.5));
  annotation (experiment(StopTime=0.08),
  Documentation(info="<html>
<p>
Example used to generate a figure for the documentation of block
<a href=\"modelica://Modelica.Clocked.ClockSignals.Sampler.SuperSample\">Modelica.Clocked.ClockSignals.Sampler.SuperSample</a>.
</p>
</html>"));
end SuperSample;
