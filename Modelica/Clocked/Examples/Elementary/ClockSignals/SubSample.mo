within Modelica.Clocked.Examples.Elementary.ClockSignals;
model SubSample "Example of a SubSample block for Clock signals"
   extends Modelica.Icons.Example;

  Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
      factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
    annotation (Placement(transformation(extent={{-56,24},{-44,36}})));
Modelica.Clocked.ClockSignals.Sampler.SubSample subSample1(factor=3)
    annotation (Placement(transformation(extent={{-22,24},{-10,36}})));
  Modelica.Clocked.RealSignals.Sampler.SampleClocked sample1
    annotation (Placement(transformation(extent={{16,52},{28,64}})));
  Modelica.Blocks.Sources.Sine sine(f=2,
    offset=0.1,
    startTime=0)
    annotation (Placement(transformation(extent={{-24,48},{-4,68}})));
equation
  connect(periodicClock.y, subSample1.u) annotation (Line(
      points={{-43.4,30},{-23.2,30}},
      color={175,175,175},
      pattern=LinePattern.Dot,
      thickness=0.5));
  connect(sine.y, sample1.u) annotation (Line(points={{-3,58},{14.8,58},{
          14.8,58}}, color={0,0,127}));
  connect(subSample1.y, sample1.clock) annotation (Line(
      points={{-9.4,30},{22,30},{22,50.8}},
      color={175,175,175},
      pattern=LinePattern.Dot,
      thickness=0.5));
  annotation (experiment(StopTime=0.2),
  Documentation(info="<html>
<p>
Example used to generate a figure for the documentation of block
<a href=\"modelica://Modelica.Clocked.ClockSignals.Sampler.SubSample\">Modelica.Clocked.ClockSignals.Sampler.SubSample</a>.
</p>
</html>"));
end SubSample;
