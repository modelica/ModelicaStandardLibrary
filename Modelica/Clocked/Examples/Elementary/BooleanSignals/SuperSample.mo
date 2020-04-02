within Modelica.Clocked.Examples.Elementary.BooleanSignals;
model SuperSample "Example of a SuperSample block for Boolean signals"
   extends Modelica.Icons.Example;

  Modelica.Clocked.BooleanSignals.Sampler.SampleClocked sample1
    annotation (Placement(transformation(extent={{-46,24},{-34,36}})));
  Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
      factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
    annotation (Placement(transformation(extent={{-62,-6},{-50,6}})));
Modelica.Clocked.BooleanSignals.Sampler.SuperSample superSample1(inferFactor=
        false, factor=3)
    annotation (Placement(transformation(extent={{-22,24},{-10,36}})));
  Modelica.Blocks.Sources.BooleanTable table(table={0.05,0.15})
    annotation (Placement(transformation(extent={{-78,20},{-58,40}})));
equation
  connect(periodicClock.y, sample1.clock) annotation (Line(
      points={{-49.4,0},{-40,0},{-40,22.8}},
      color={175,175,175},
      pattern=LinePattern.Dot,
      thickness=0.5));
  connect(table.y, sample1.u)
    annotation (Line(points={{-57,30},{-47.2,30}}, color={255,0,255}));
  connect(superSample1.u, sample1.y)
    annotation (Line(points={{-23.2,30},{-33.4,30}}, color={255,0,255}));
  annotation (experiment(StopTime=0.2),
  Documentation(info="<html>
<p>
Elementary example for the documentation of block
<a href=\"modelica://Modelica.Clocked.BooleanSignals.Sampler.SuperSample\">Modelica.Clocked.BooleanSignals.Sampler.SuperSample</a>.
</p>
</html>"));
end SuperSample;
