within Modelica.Clocked.Examples.Elementary.RealSignals;
model TimeBasedStep
  "Example of using the clocked simulation time based Step source block"
   extends Modelica.Icons.Example;
Modelica.Clocked.RealSignals.TimeBasedSources.Step
                                              step(startTime=0.2)
  annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
Modelica.Clocked.RealSignals.Sampler.AssignClock assignClock1
  annotation (Placement(transformation(extent={{-24,24},{-12,36}})));
Modelica.Clocked.ClockSignals.Clocks.PeriodicRealClock
  periodicClock1(period=0.1)
  annotation (Placement(transformation(extent={{-70,-18},{-58,-6}})));
equation

connect(step.y, assignClock1.u) annotation (Line(
    points={{-39,30},{-25.2,30}},
    color={0,0,127}));
connect(periodicClock1.y, assignClock1.clock) annotation (Line(
    points={{-57.4,-12},{-18,-12},{-18,22.8}},
    color={175,175,175},
    pattern=LinePattern.Dot,
    thickness=0.5));
annotation (experiment(StopTime=1.0), Documentation(info="<html>
<p>
Example for block
<a href=\"modelica://Modelica.Clocked.RealSignals.TimeBasedSources.Step\">Modelica.Clocked.RealSignals.TimeBasedSources.Step</a>.
</p>
</html>"));
end TimeBasedStep;
