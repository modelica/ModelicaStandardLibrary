within Modelica.Clocked.Examples.Elementary.IntegerSignals;
model SubSample "Example of a SubSample block for Integer signals"
   extends Modelica.Icons.Example;

  Modelica.Clocked.IntegerSignals.Sampler.SampleClocked sample1
    annotation (Placement(transformation(extent={{-46,24},{-34,36}})));
  Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
      factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
    annotation (Placement(transformation(extent={{-62,-6},{-50,6}})));
Modelica.Clocked.IntegerSignals.Sampler.SubSample subSample1(inferFactor=false,
      factor=3)
    annotation (Placement(transformation(extent={{-22,24},{-10,36}})));
  Modelica.Blocks.Sources.IntegerTable table(table=[0,1; 0.05,2; 0.1,0; 0.15,-1;
        0.2,3])
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
equation
  connect(periodicClock.y, sample1.clock) annotation (Line(
      points={{-49.4,0},{-40,0},{-40,22.8}},
      color={175,175,175},
      pattern=LinePattern.Dot,
      thickness=0.5));
  connect(table.y, sample1.u)
    annotation (Line(points={{-59,30},{-47.2,30}}, color={255,127,0}));
  connect(sample1.y, subSample1.u)
    annotation (Line(points={{-33.4,30},{-23.2,30}}, color={255,127,0}));
  annotation (experiment(StopTime=0.2),
  Documentation(info="<html>
<p>
Elementary example for the documentation of block
<a href=\"modelica://Modelica.Clocked.IntegerSignals.Sampler.SubSample\">Modelica.Clocked.IntegerSignals.Sampler.SubSample</a>.
</p>
</html>"));
end SubSample;
