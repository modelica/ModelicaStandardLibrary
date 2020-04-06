within Modelica.Clocked.Examples.Elementary.BooleanSignals;
model SampleClocked
  "Example of a SampleClocked block for Boolean signals"
   extends Modelica.Icons.Example;

  Modelica.Blocks.Sources.BooleanStep
                               step(startTime=0.1)
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Modelica.Clocked.BooleanSignals.Sampler.SampleClocked sample1
    annotation (Placement(transformation(extent={{-46,24},{-34,36}})));
  Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
      factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
    annotation (Placement(transformation(extent={{-62,-6},{-50,6}})));
equation
  connect(periodicClock.y, sample1.clock) annotation (Line(
      points={{-49.4,0},{-40,0},{-40,22.8}},
      color={175,175,175},
      pattern=LinePattern.Dot,
      thickness=0.5));
  connect(sample1.u, step.y)
    annotation (Line(points={{-47.2,30},{-59,30}}, color={255,0,255}));
  annotation (experiment(StopTime=0.2),
  Documentation(info="<html>
<p>
Elementary example for the documentation of block
<a href=\"modelica://Modelica.Clocked.BooleanSignals.Sampler.SampleClocked\">Modelica.Clocked.BooleanSignals.Sampler.SampleClocked</a>.
</p>
</html>"));
end SampleClocked;
