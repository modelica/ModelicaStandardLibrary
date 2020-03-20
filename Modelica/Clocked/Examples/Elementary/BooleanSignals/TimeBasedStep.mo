within Modelica.Clocked.Examples.Elementary.BooleanSignals;
model TimeBasedStep
  "Example of using the clocked simulation time based Boolean Step source block"
   extends Modelica.Icons.Example;

  Modelica.Clocked.BooleanSignals.TimeBasedSources.Step step(
    startTime=0.2)
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
Modelica.Clocked.ClockSignals.Clocks.PeriodicRealClock
  periodicClock1(period=0.1)
  annotation (Placement(transformation(extent={{-60,-8},{-48,4}})));
  Modelica.Clocked.BooleanSignals.Sampler.AssignClock assignClock1
    annotation (Placement(transformation(extent={{-22,24},{-10,36}})));
equation
  connect(periodicClock1.y, assignClock1.clock) annotation (Line(
      points={{-47.4,-2},{-16,-2},{-16,22.8}},
      color={175,175,175},
      pattern=LinePattern.Dot,
      thickness=0.5));
  connect(step.y, assignClock1.u) annotation (Line(
      points={{-39,30},{-23.2,30}},
      color={255,0,255}));
  annotation (experiment(StopTime=1.0),
  Documentation(info="<html>
<p>
Example for block
<a href=\"modelica://Modelica.Clocked.BooleanSignals.TimeBasedSources.Step\">Modelica.Clocked.BooleanSignals.TimeBasedSources.Step</a>.
</p>
</html>"));
end TimeBasedStep;
