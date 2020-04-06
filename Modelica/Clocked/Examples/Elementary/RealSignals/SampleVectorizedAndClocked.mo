within Modelica.Clocked.Examples.Elementary.RealSignals;
model SampleVectorizedAndClocked
  "Example of a SampleVectorizedAndClocked block for Real signals"
   extends Modelica.Icons.Example;

  Modelica.Blocks.Sources.Sine sine2(
  f=2,
  offset=0.1,
  startTime=0)
    annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
  Modelica.Clocked.RealSignals.Sampler.SampleVectorizedAndClocked sample1(n=2)
    annotation (Placement(transformation(extent={{-14,24},{-2,36}})));
  Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
      factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
    annotation (Placement(transformation(extent={{-28,-6},{-16,6}})));
  Modelica.Blocks.Sources.Sine sine1(startTime=0, f=3)
    annotation (Placement(transformation(extent={{-80,-2},{-60,18}})));
equation
  connect(periodicClock.y, sample1.clock) annotation (Line(
      points={{-15.4,0},{-8,0},{-8,22.8}},
      color={175,175,175},
      pattern=LinePattern.Dot,
      thickness=0.5));
  connect(sine1.y, sample1.u[1]) annotation (Line(points={{-59,8},{-38,8},{-38,
          29.4},{-15.2,29.4}}, color={0,0,127}));
  connect(sine2.y, sample1.u[2]) annotation (Line(points={{-59,40},{-38,40},{-38,
          30.6},{-15.2,30.6}}, color={0,0,127}));
  annotation (experiment(StopTime=0.2),
  Documentation(info="<html>
<p>
Example used to generate a figure for the documentation of block
<a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.SampleVectorizedAndClocked\">Modelica.Clocked.RealSignals.Sampler.SampleVectorizedAndClocked</a>.
</p>
</html>"));
end SampleVectorizedAndClocked;
