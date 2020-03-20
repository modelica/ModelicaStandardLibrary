within Modelica.Clocked.Examples.Elementary.BooleanSignals;
model TickBasedPulse
  "Example of using the clock tick based Boolean Pulse source block"
   extends Modelica.Icons.Example;

Modelica.Clocked.ClockSignals.Clocks.PeriodicRealClock
  periodicClock1(period=0.1)
  annotation (Placement(transformation(extent={{-60,-8},{-48,4}})));
  Modelica.Clocked.BooleanSignals.Sampler.AssignClock assignClock1
    annotation (Placement(transformation(extent={{-22,24},{-10,36}})));
  Modelica.Clocked.BooleanSignals.TickBasedSources.Pulse pulse(
    widthTicks=2,
    periodTicks=4,
    startTick=2)
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
equation
  connect(periodicClock1.y, assignClock1.clock) annotation (Line(
      points={{-47.4,-2},{-16,-2},{-16,22.8}},
      color={175,175,175},
      pattern=LinePattern.Dot,
      thickness=0.5));
  connect(pulse.y, assignClock1.u) annotation (Line(
      points={{-39,30},{-23.2,30}},
      color={255,0,255}));
  annotation (experiment(StopTime=1.0),
  Documentation(info="<html>
<p>
Example for block
<a href=\"modelica://Modelica.Clocked.BooleanSignals.TickBasedSources.Pulse\">Modelica.Clocked.BooleanSignals.TickBasedSources.Pulse</a>.
</p>
</html>"));
end TickBasedPulse;
