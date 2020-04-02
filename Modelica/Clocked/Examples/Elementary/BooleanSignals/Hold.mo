within Modelica.Clocked.Examples.Elementary.BooleanSignals;
model Hold "Example of a Hold block for Boolean signals"
   extends Modelica.Icons.Example;

  Modelica.Blocks.Sources.BooleanTable table(table={0.05,0.15})
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Modelica.Clocked.BooleanSignals.Sampler.SampleClocked sample1
    annotation (Placement(transformation(extent={{-52,24},{-40,36}})));
  Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
      factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
    annotation (Placement(transformation(extent={{-68,-6},{-56,6}})));
Modelica.Clocked.BooleanSignals.Sampler.Hold hold1(y_start=false)
    annotation (Placement(transformation(extent={{-8,24},{4,36}})));
Modelica.Clocked.BooleanSignals.Sampler.ShiftSample shiftSample1(shiftCounter=2)
    annotation (Placement(transformation(extent={{-30,24},{-18,36}})));
equation
  connect(periodicClock.y, sample1.clock) annotation (Line(
      points={{-55.4,0},{-46,0},{-46,22.8}},
      color={175,175,175},
      pattern=LinePattern.Dot,
      thickness=0.5));
  connect(table.y, sample1.u)
    annotation (Line(points={{-59,30},{-53.2,30}}, color={255,127,0}));
  connect(shiftSample1.u, sample1.y)
    annotation (Line(points={{-31.2,30},{-39.4,30}}, color={255,0,255}));
  connect(hold1.u, shiftSample1.y)
    annotation (Line(points={{-9.2,30},{-17.4,30}}, color={255,0,255}));
  annotation (experiment(StopTime=0.2),
  Documentation(info="<html>
<p>
Elementary example for the documentation of block
<a href=\"modelica://Modelica.Clocked.BooleanSignals.Sampler.Hold\">Modelica.Clocked.BooleanSignals.Sampler.Hold</a>.
</p>
</html>"));
end Hold;
