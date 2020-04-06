within Modelica.Clocked.Examples.Elementary.IntegerSignals;
model SampleClocked
  "Example of a SampleClocked block for Integer signals"
   extends Modelica.Icons.Example;

  Modelica.Blocks.Sources.IntegerStep
                               step(startTime=0.1, offset=1)
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Modelica.Clocked.IntegerSignals.Sampler.SampleClocked sample1
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
  connect(step.y, sample1.u)
    annotation (Line(points={{-59,30},{-47.2,30}}, color={255,127,0}));
  annotation (experiment(StopTime=0.2),
  Documentation(info="<html>
<p>
Elementary example for the documentation of block
<a href=\"modelica://Modelica.Clocked.IntegerSignals.Sampler.SampleClocked\">Modelica.Clocked.IntegerSignals.Sampler.SampleClocked</a>.
</p>
</html>"));
end SampleClocked;
