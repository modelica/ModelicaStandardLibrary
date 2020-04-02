within Modelica.Clocked.Examples.Elementary.ClockSignals;
model ShiftSample "Example of a ShiftSample block for Clock signals"
   extends Modelica.Icons.Example;

  Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
      factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
    annotation (Placement(transformation(extent={{-56,24},{-44,36}})));
  Modelica.Clocked.ClockSignals.Sampler.ShiftSample shiftSample1(shiftCounter=4,
      resolution=3)
    annotation (Placement(transformation(extent={{-22,24},{-10,36}})));
  Modelica.Clocked.RealSignals.Sampler.SampleClocked sample1
    annotation (Placement(transformation(extent={{14,54},{26,66}})));
  Modelica.Blocks.Sources.Sine sine(f=2,
    offset=0.1,
    startTime=0)
    annotation (Placement(transformation(extent={{-26,50},{-6,70}})));
equation
  connect(periodicClock.y, shiftSample1.u) annotation (Line(
      points={{-43.4,30},{-23.2,30}},
      color={175,175,175},
      pattern=LinePattern.Dot,
      thickness=0.5));
  connect(sine.y, sample1.u)
    annotation (Line(points={{-5,60},{12.8,60}}, color={0,0,127}));
  connect(shiftSample1.y, sample1.clock) annotation (Line(
      points={{-9.4,30},{20,30},{20,52.8}},
      color={175,175,175},
      pattern=LinePattern.Dot,
      thickness=0.5));
  annotation (experiment(StopTime=0.09),
  Documentation(info="<html>
<p>
Example used to generate a figure for the documentation of block
<a href=\"modelica://Modelica.Clocked.ClockSignals.Sampler.ShiftSample\">Modelica.Clocked.ClockSignals.Sampler.ShiftSample</a>.
</p>
</html>"));
end ShiftSample;
