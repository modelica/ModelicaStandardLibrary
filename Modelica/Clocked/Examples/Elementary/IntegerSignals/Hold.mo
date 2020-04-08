within Modelica.Clocked.Examples.Elementary.IntegerSignals;
model Hold "Example of a Hold block for Integer signals"
   extends Modelica.Icons.Example;

  Modelica.Blocks.Sources.IntegerTable table(table=[0,1; 0.05,2; 0.1,0; 0.15,-1;
        0.2,3])
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Modelica.Clocked.IntegerSignals.Sampler.SampleClocked sample1
    annotation (Placement(transformation(extent={{-52,24},{-40,36}})));
  Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
      factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
    annotation (Placement(transformation(extent={{-68,-6},{-56,6}})));
Modelica.Clocked.IntegerSignals.Sampler.Hold hold1(y_start=-1)
    annotation (Placement(transformation(extent={{-8,24},{4,36}})));
Modelica.Clocked.IntegerSignals.Sampler.ShiftSample  shiftSample1(
    shiftCounter=2)
  annotation (Placement(transformation(extent={{-30,24},{-18,36}})));
equation
  connect(periodicClock.y, sample1.clock) annotation (Line(
      points={{-55.4,0},{-46,0},{-46,22.8}},
      color={175,175,175},
      pattern=LinePattern.Dot,
      thickness=0.5));
  connect(table.y, sample1.u)
    annotation (Line(points={{-59,30},{-53.2,30}}, color={255,127,0}));
  connect(sample1.y, shiftSample1.u)
    annotation (Line(points={{-39.4,30},{-31.2,30}}, color={255,127,0}));
  connect(shiftSample1.y, hold1.u)
    annotation (Line(points={{-17.4,30},{-9.2,30}}, color={255,127,0}));
  annotation (experiment(StopTime=0.2),
  Documentation(info="<html>
<p>
Elementary example for the documentation of block
<a href=\"modelica://Modelica.Clocked.IntegerSignals.Sampler.Hold\">Modelica.Clocked.IntegerSignals.Sampler.Hold</a>.
</p>
</html>"));
end Hold;
