within Modelica.Clocked.Examples.Elementary.RealSignals;
model TimeBasedRamp
  "Example of using the clocked time based Ramp source block"
   extends Modelica.Icons.Example;
Modelica.Clocked.RealSignals.Sampler.AssignClock assignClock1
  annotation (Placement(transformation(extent={{-24,24},{-12,36}})));
Modelica.Clocked.ClockSignals.Clocks.PeriodicRealClock
  periodicClock1(period=0.1)
  annotation (Placement(transformation(extent={{-70,-18},{-58,-6}})));
Modelica.Clocked.RealSignals.TimeBasedSources.Ramp
                                              ramp(duration=0.5)
  annotation (Placement(transformation(extent={{-72,20},{-52,40}})));
equation

connect(periodicClock1.y, assignClock1.clock) annotation (Line(
    points={{-57.4,-12},{-18,-12},{-18,22.8}},
    color={175,175,175},
    pattern=LinePattern.Dot,
    thickness=0.5));
connect(ramp.y, assignClock1.u) annotation (Line(
    points={{-51,30},{-25.2,30}},
    color={0,0,127}));
annotation (experiment(StopTime=1.0), Documentation(info="<html>
<p>
Example for block
<a href=\"modelica://Modelica.Clocked.RealSignals.TimeBasedSources.Ramp\">Modelica.Clocked.RealSignals.TimeBasedSources.Ramp</a>.
</p>
</html>"));
end TimeBasedRamp;
