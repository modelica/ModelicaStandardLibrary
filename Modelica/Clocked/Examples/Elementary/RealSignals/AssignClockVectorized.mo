within Modelica.Clocked.Examples.Elementary.RealSignals;
model AssignClockVectorized
  "Example of a AssignClockVectorized block for Real signals"
   extends Modelica.Icons.Example;

  Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
      factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
    annotation (Placement(transformation(extent={{-54,-50},{-42,-38}})));
Modelica.Clocked.RealSignals.NonPeriodic.UnitDelay unitDelay1
  annotation (Placement(transformation(extent={{-38,58},{-58,78}})));
Modelica.Blocks.Math.Add add
  annotation (Placement(transformation(extent={{-58,28},{-38,48}})));
Modelica.Blocks.Sources.Constant const(k=1)
  annotation (Placement(transformation(extent={{-92,22},{-72,42}})));
Modelica.Clocked.RealSignals.Sampler.AssignClockVectorized
  assignClock1(n=2)
  annotation (Placement(transformation(extent={{-24,18},{-12,30}})));
Modelica.Blocks.Math.Add add1
  annotation (Placement(transformation(extent={{-58,2},{-38,22}})));
Modelica.Blocks.Sources.Constant const1(k=2)
  annotation (Placement(transformation(extent={{-92,-10},{-72,10}})));
Modelica.Clocked.RealSignals.NonPeriodic.UnitDelay unitDelay2
  annotation (Placement(transformation(extent={{-38,-28},{-58,-8}})));
equation
connect(add.u2, const.y) annotation (Line(
    points={{-60,32},{-71,32}},
    color={0,0,127}));
connect(unitDelay1.y, add.u1) annotation (Line(
    points={{-59,68},{-68,68},{-68,44},{-60,44}},
    color={0,0,127}));
connect(periodicClock.y, assignClock1.clock) annotation (Line(
    points={{-41.4,-44},{-18,-44},{-18,16.8}},
    color={175,175,175},
    pattern=LinePattern.Dot,
    thickness=0.5));
connect(const1.y, add1.u1) annotation (Line(
    points={{-71,0},{-68,0},{-68,18},{-60,18}},
    color={0,0,127}));
connect(unitDelay2.y, add1.u2) annotation (Line(
    points={{-59,-18},{-66,-18},{-66,6},{-60,6}},
    color={0,0,127}));
connect(add.y, assignClock1.u[1]) annotation (Line(
    points={{-37,38},{-32,38},{-32,23.4},{-25.2,23.4}},
    color={0,0,127}));
connect(add1.y, assignClock1.u[2]) annotation (Line(
    points={{-37,12},{-32,12},{-32,24.6},{-25.2,24.6}},
    color={0,0,127}));
connect(assignClock1.y[2], unitDelay2.u) annotation (Line(
    points={{-11.4,24.3},{-6,24.3},{-6,-18},{-36,-18}},
    color={0,0,127}));
connect(assignClock1.y[1], unitDelay1.u) annotation (Line(
    points={{-11.4,23.7},{-6,23.7},{-6,68},{-36,68}},
    color={0,0,127}));
  annotation (experiment(StopTime=0.09),
  Documentation(info="<html>
<p>
Example used to generate a figure for the documentation of block
<a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.AssignClockVectorized\">Modelica.Clocked.RealSignals.Sampler.AssignClockVectorized</a>.
</p>
</html>"));
end AssignClockVectorized;
