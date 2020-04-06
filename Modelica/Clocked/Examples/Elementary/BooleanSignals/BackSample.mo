within Modelica.Clocked.Examples.Elementary.BooleanSignals;
model BackSample "Example of a BackSample block for Boolean signals"
   extends Modelica.Icons.Example;

  Modelica.Clocked.BooleanSignals.Sampler.SampleClocked sample1
    annotation (Placement(transformation(extent={{-46,24},{-34,36}})));
  Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
      factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
    annotation (Placement(transformation(extent={{-62,-6},{-50,6}})));
  Modelica.Clocked.BooleanSignals.Sampler.ShiftSample shiftSample1(
      shiftCounter=4, resolution=3)
    annotation (Placement(transformation(extent={{-18,24},{-6,36}})));
Modelica.Clocked.BooleanSignals.Sampler.BackSample backSample1(
  backCounter=4,
  resolution=3,
  y_start=true)
  annotation (Placement(transformation(extent={{14,24},{26,36}})));
  Modelica.Blocks.Sources.BooleanTable table(table={0.05,0.15})
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
equation
  connect(periodicClock.y, sample1.clock) annotation (Line(
      points={{-49.4,0},{-40,0},{-40,22.8}},
      color={175,175,175},
      pattern=LinePattern.Dot,
      thickness=0.5));
  connect(sample1.u, table.y)
    annotation (Line(points={{-47.2,30},{-59,30}}, color={255,0,255}));
  connect(shiftSample1.u, sample1.y)
    annotation (Line(points={{-19.2,30},{-33.4,30}}, color={255,0,255}));
connect(backSample1.u, shiftSample1.y) annotation (Line(
    points={{12.8,30},{-5.4,30}},
    color={255,0,255}));
  annotation (experiment(StopTime=0.09),
  Documentation(info="<html>
<p>
Elementary example for the documentation of block
<a href=\"modelica://Modelica.Clocked.BooleanSignals.Sampler.BackSample\">Modelica.Clocked.BooleanSignals.Sampler.BackSample</a>.
</p>
</html>"));
end BackSample;
