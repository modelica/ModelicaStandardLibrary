within Modelica.Clocked.Examples.Elementary.BooleanSignals;
model AssignClock "Example of an AssignClock block for Boolean signals"
   extends Modelica.Icons.Example;

  Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
      factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
    annotation (Placement(transformation(extent={{-42,0},{-30,12}})));
Modelica.Clocked.BooleanSignals.Sampler.AssignClock assignClock1
  annotation (Placement(transformation(extent={{-26,22},{-14,34}})));
Modelica.Clocked.BooleanSignals.NonPeriodic.UnitDelay unitDelay1
  annotation (Placement(transformation(extent={{-38,48},{-58,68}})));
Modelica.Blocks.Logical.Xor xor
  annotation (Placement(transformation(extent={{-59,18},{-39,38}})));
  Modelica.Blocks.Sources.BooleanConstant integerConstant(k=true)
    annotation (Placement(transformation(extent={{-96,3},{-76,23}})));
equation
connect(periodicClock.y, assignClock1.clock) annotation (Line(
    points={{-29.4,6},{-20,6},{-20,20.8}},
    color={175,175,175},
    pattern=LinePattern.Dot,
    thickness=0.5));
connect(assignClock1.y, unitDelay1.u) annotation (Line(
    points={{-13.4,28},{-2,28},{-2,58},{-36,58}},
    color={0,0,127}));
connect(assignClock1.u, xor.y) annotation (Line(
    points={{-27.2,28},{-38,28}},
    color={255,0,255}));
connect(integerConstant.y, xor.u2) annotation (Line(
    points={{-75,13},{-68.5,13},{-68.5,20},{-61,20}},
    color={255,0,255}));
connect(unitDelay1.y, xor.u1) annotation (Line(
    points={{-59,58},{-70,58},{-70,28},{-61,28}},
    color={255,0,255}));
  annotation (experiment(StopTime=0.09),
  Documentation(info="<html>
<p>
Elementary example for the documentation of block
<a href=\"modelica://Modelica.Clocked.BooleanSignals.Sampler.AssignClock\">Modelica.Clocked.BooleanSignals.Sampler.AssignClock</a>.
</p>
</html>"));
end AssignClock;
