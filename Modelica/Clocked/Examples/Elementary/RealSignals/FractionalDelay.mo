within Modelica.Clocked.Examples.Elementary.RealSignals;
model FractionalDelay
  "Example of a FractionalDelay block for Real signals"
   extends Modelica.Icons.Example;

  Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
      factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
    annotation (Placement(transformation(extent={{-68,-6},{-56,6}})));
  Modelica.Blocks.Sources.Sine sine(f=2,
    offset=0.1,
    startTime=0)
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Modelica.Clocked.RealSignals.Sampler.SampleClocked sample1
    annotation (Placement(transformation(extent={{-48,24},{-36,36}})));
Modelica.Clocked.RealSignals.NonPeriodic.FractionalDelay
  fractionalDelay(shift=3, resolution=2)
  annotation (Placement(transformation(extent={{-26,20},{-6,40}})));
equation
  connect(sine.y, sample1.u)
    annotation (Line(points={{-59,30},{-49.2,30}}, color={0,0,127}));
  connect(periodicClock.y, sample1.clock) annotation (Line(
      points={{-55.4,0},{-42,0},{-42,22.8}},
      color={175,175,175},
      pattern=LinePattern.Dot,
      thickness=0.5));
  connect(fractionalDelay.u, sample1.y)
    annotation (Line(points={{-28,30},{-35.4,30}}, color={0,0,127}));
  annotation (experiment(StopTime=0.09),
  Documentation(info="<html>
<p>
Example used to generate a figure for the documentation of block
<a href=\"modelica://Modelica.Clocked.RealSignals.NonPeriodic.FractionalDelay\">Modelica.Clocked.RealSignals.NonPeriodic.FractionalDelay</a>.
</p>
</html>"));
end FractionalDelay;
