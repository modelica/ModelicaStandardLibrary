within Modelica.Clocked.Examples.Elementary.IntegerSignals;
model SampleVectorizedAndClocked
  "Example of a SampleVectorizedAndClocked block for Integer signals"
   extends Modelica.Icons.Example;

  Modelica.Blocks.Sources.IntegerStep
                               step2(offset=1, startTime=0.04)
    annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
  Modelica.Clocked.IntegerSignals.Sampler.SampleVectorizedAndClocked sample1(n=2)
    annotation (Placement(transformation(extent={{-14,24},{-2,36}})));
  Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
      factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
    annotation (Placement(transformation(extent={{-28,-6},{-16,6}})));
  Modelica.Blocks.Sources.IntegerStep
                               step1(startTime=0.08)
    annotation (Placement(transformation(extent={{-80,-2},{-60,18}})));
equation
  connect(periodicClock.y, sample1.clock) annotation (Line(
      points={{-15.4,0},{-8,0},{-8,22.8}},
      color={175,175,175},
      pattern=LinePattern.Dot,
      thickness=0.5));
  connect(step1.y, sample1.u[1]) annotation (Line(points={{-59,8},{-38,8},{-38,
          29.4},{-15.2,29.4}}, color={255,127,0}));
  connect(step2.y, sample1.u[2]) annotation (Line(points={{-59,40},{-38,40},{-38,
          30.6},{-15.2,30.6}}, color={255,127,0}));
  annotation (experiment(StopTime=0.2),
  Documentation(info="<html>
<p>
Elementary example for the documentation of block
<a href=\"modelica://Modelica.Clocked.IntegerSignals.Sampler.SampleVectorizedAndClocked\">Modelica.Clocked.IntegerSignals.Sampler.SampleVectorizedAndClocked</a>.
</p>
</html>"));
end SampleVectorizedAndClocked;
