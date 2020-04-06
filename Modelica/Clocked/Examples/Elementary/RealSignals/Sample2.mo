within Modelica.Clocked.Examples.Elementary.RealSignals;
model Sample2
  "Example of a Sample block with discontinuous Real input signals"
 extends Modelica.Icons.Example;
  Clocked.RealSignals.Sampler.Sample sample1
    annotation (Placement(transformation(extent={{-46,24},{-34,36}})));
  Clocked.RealSignals.Sampler.AssignClock assignClock
    annotation (Placement(transformation(extent={{-22,24},{-10,36}})));
  Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(factor=20,
      resolution=Modelica.Clocked.Types.Resolution.ms)
    annotation (Placement(transformation(extent={{-42,-2},{-30,10}})));
Modelica.Blocks.Sources.Step step(startTime=0.1)
  annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
equation
  connect(sample1.y, assignClock.u)
    annotation (Line(points={{-33.4,30},{-23.2,30}}, color={0,0,127}));
  connect(periodicClock.y, assignClock.clock) annotation (Line(
      points={{-29.4,4},{-16,4},{-16,22.8}},
      color={175,175,175},
      pattern=LinePattern.Dot,
      thickness=0.5));
  connect(step.y, sample1.u)
    annotation (Line(points={{-59,30},{-47.2,30}}, color={0,0,127}));
  annotation (experiment(StopTime=0.2),
  Documentation(info="<html>
<p>
Example used to generate a figure for the documentation of block
<a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.Sample\">Modelica.Clocked.RealSignals.Sampler.Sample</a>.
</p>
</html>"));
end Sample2;
