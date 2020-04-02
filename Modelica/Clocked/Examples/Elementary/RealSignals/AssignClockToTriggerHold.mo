within Modelica.Clocked.Examples.Elementary.RealSignals;
model AssignClockToTriggerHold
  "Example of an AssignClockToTriggerHold block for Real signals"
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
Modelica.Blocks.Discrete.TriggeredSampler triggeredSampler
  annotation (Placement(transformation(extent={{10,40},{30,60}})));
Modelica.Clocked.RealSignals.Sampler.Utilities.AssignClockToTriggerHold
  clockToTrigger
  annotation (Placement(transformation(extent={{-20,20},{0,40}})));
equation
  connect(sine.y, sample1.u)
    annotation (Line(points={{-59,30},{-49.2,30}}, color={0,0,127}));
  connect(periodicClock.y, sample1.clock) annotation (Line(
      points={{-55.4,0},{-42,0},{-42,22.8}},
      color={175,175,175},
      pattern=LinePattern.Dot,
      thickness=0.5));
connect(triggeredSampler.u, sine.y) annotation (Line(
    points={{8,50},{-54,50},{-54,30},{-59,30}},
    color={0,0,127}));
  connect(sample1.y, clockToTrigger.u)
    annotation (Line(points={{-35.4,30},{-22,30}}, color={0,0,127}));
connect(triggeredSampler.trigger, clockToTrigger.y) annotation (Line(
    points={{20,38.2},{20,30},{1,30}},
    color={255,0,255}));
  annotation (experiment(StopTime=0.09),
  Documentation(info="<html>
<p>
Example used to generate a figure for the documentation of block
<a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.Utilities.AssignClockToTriggerHold\">Modelica.Clocked.RealSignals.Sampler.Utilities.AssignClockToTriggerHold</a>.
</p>
</html>"));
end AssignClockToTriggerHold;
