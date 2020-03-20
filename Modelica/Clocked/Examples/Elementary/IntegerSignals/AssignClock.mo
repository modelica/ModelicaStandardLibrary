within Modelica.Clocked.Examples.Elementary.IntegerSignals;
model AssignClock "Example of an AssignClock block for Integer signals"
   extends Modelica.Icons.Example;

  Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
      factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
    annotation (Placement(transformation(extent={{-42,0},{-30,12}})));
Modelica.Clocked.IntegerSignals.Sampler.AssignClock assignClock1
  annotation (Placement(transformation(extent={{-26,22},{-14,34}})));
Modelica.Clocked.IntegerSignals.NonPeriodic.UnitDelay unitDelay1
  annotation (Placement(transformation(extent={{-38,48},{-58,68}})));
Modelica.Blocks.Sources.IntegerConstant
                                 const(k=1)
  annotation (Placement(transformation(extent={{-96,12},{-76,32}})));
Modelica.Blocks.MathInteger.Sum sum(nu=2)
  annotation (Placement(transformation(extent={{-54,22},{-42,34}})));
equation
connect(periodicClock.y, assignClock1.clock) annotation (Line(
    points={{-29.4,6},{-20,6},{-20,20.8}},
    color={175,175,175},
    pattern=LinePattern.Dot,
    thickness=0.5));
connect(assignClock1.y, unitDelay1.u) annotation (Line(
    points={{-13.4,28},{-2,28},{-2,58},{-36,58}},
    color={0,0,127}));
connect(unitDelay1.y, sum.u[1]) annotation (Line(
    points={{-59,58},{-70,58},{-70,30.1},{-54,30.1}},
    color={255,127,0}));
connect(const.y, sum.u[2]) annotation (Line(
    points={{-75,22},{-62,22},{-62,25.9},{-54,25.9}},
    color={255,127,0}));
connect(sum.y, assignClock1.u) annotation (Line(
    points={{-41.1,28},{-27.2,28}},
    color={255,127,0}));
  annotation (experiment(StopTime=0.09),
  Documentation(info="<html>
<p>
Elementary example for the documentation of block
<a href=\"modelica://Modelica.Clocked.IntegerSignals.Sampler.AssignClock\">Modelica.Clocked.IntegerSignals.Sampler.AssignClock</a>.
</p>
</html>"));
end AssignClock;
