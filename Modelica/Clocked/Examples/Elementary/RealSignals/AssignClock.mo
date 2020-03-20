within Modelica.Clocked.Examples.Elementary.RealSignals;
model AssignClock "Example of a AssignClock block for Real signals"
   extends Modelica.Icons.Example;

  Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
      factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
    annotation (Placement(transformation(extent={{-42,0},{-30,12}})));
Modelica.Clocked.RealSignals.Sampler.AssignClock assignClock1
  annotation (Placement(transformation(extent={{-26,22},{-14,34}})));
Modelica.Clocked.RealSignals.NonPeriodic.UnitDelay unitDelay1
  annotation (Placement(transformation(extent={{-38,48},{-58,68}})));
Modelica.Blocks.Math.Add add
  annotation (Placement(transformation(extent={{-58,18},{-38,38}})));
Modelica.Blocks.Sources.Constant const(k=1)
  annotation (Placement(transformation(extent={{-92,12},{-72,32}})));
equation
connect(periodicClock.y, assignClock1.clock) annotation (Line(
    points={{-29.4,6},{-20,6},{-20,20.8}},
    color={175,175,175},
    pattern=LinePattern.Dot,
    thickness=0.5));
connect(add.u2, const.y) annotation (Line(
    points={{-60,22},{-71,22}},
    color={0,0,127}));
connect(assignClock1.y, unitDelay1.u) annotation (Line(
    points={{-13.4,28},{-2,28},{-2,58},{-36,58}},
    color={0,0,127}));
connect(unitDelay1.y, add.u1) annotation (Line(
    points={{-59,58},{-68,58},{-68,34},{-60,34}},
    color={0,0,127}));
connect(add.y, assignClock1.u) annotation (Line(
    points={{-37,28},{-27.2,28}},
    color={0,0,127}));
  annotation (experiment(StopTime=0.09),
  Documentation(info="<html>
<p>
Example used to generate a figure for the documentation of block
<a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.AssignClock\">Modelica.Clocked.RealSignals.Sampler.AssignClock</a>.
</p>
</html>"));
end AssignClock;
