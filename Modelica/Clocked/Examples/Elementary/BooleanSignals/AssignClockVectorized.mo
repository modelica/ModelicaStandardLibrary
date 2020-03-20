within Modelica.Clocked.Examples.Elementary.BooleanSignals;
model AssignClockVectorized
  "Example of an AssignClockVectorized block for Boolean signals"
   extends Modelica.Icons.Example;

  Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
      factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
    annotation (Placement(transformation(extent={{-54,-50},{-42,-38}})));
Modelica.Clocked.BooleanSignals.NonPeriodic.UnitDelay unitDelay1
  annotation (Placement(transformation(extent={{-38,58},{-58,78}})));
Modelica.Clocked.BooleanSignals.Sampler.AssignClockVectorized
  assignClock1(n=2)
  annotation (Placement(transformation(extent={{-24,18},{-12,30}})));
Modelica.Clocked.BooleanSignals.NonPeriodic.UnitDelay unitDelay2(y_start=
      true)
  annotation (Placement(transformation(extent={{-38,-28},{-58,-8}})));
Modelica.Blocks.Logical.Xor xor
  annotation (Placement(transformation(extent={{-57,28},{-37,48}})));
  Modelica.Blocks.Sources.BooleanConstant integerConstant(k=true)
    annotation (Placement(transformation(extent={{-92,21},{-72,41}})));
Modelica.Blocks.Logical.Xor xor1
  annotation (Placement(transformation(extent={{-57,2},{-37,22}})));
  Modelica.Blocks.Sources.BooleanConstant integerConstant1(k=true)
    annotation (Placement(transformation(extent={{-92,-9},{-72,11}})));
equation
connect(periodicClock.y, assignClock1.clock) annotation (Line(
    points={{-41.4,-44},{-18,-44},{-18,16.8}},
    color={175,175,175},
    pattern=LinePattern.Dot,
    thickness=0.5));
connect(xor.u1, unitDelay1.y) annotation (Line(
    points={{-59,38},{-64,38},{-64,68},{-59,68}},
    color={255,0,255}));
connect(xor.u2, integerConstant.y) annotation (Line(
    points={{-59,30},{-65,30},{-65,31},{-71,31}},
    color={255,0,255}));
connect(xor1.u1, integerConstant1.y) annotation (Line(
    points={{-59,12},{-66,12},{-66,1},{-71,1}},
    color={255,0,255}));
connect(unitDelay2.y, xor1.u2) annotation (Line(
    points={{-59,-18},{-64,-18},{-64,4},{-59,4}},
    color={255,0,255}));
connect(xor.y, assignClock1.u[1]) annotation (Line(
    points={{-36,38},{-32,38},{-32,23.4},{-25.2,23.4}},
    color={255,0,255}));
connect(xor1.y, assignClock1.u[2]) annotation (Line(
    points={{-36,12},{-32,12},{-32,24.6},{-25.2,24.6}},
    color={255,0,255}));
connect(assignClock1.y[1], unitDelay1.u) annotation (Line(
    points={{-11.4,23.7},{-2,23.7},{-2,68},{-36,68}},
    color={255,0,255}));
connect(assignClock1.y[2], unitDelay2.u) annotation (Line(
    points={{-11.4,24.3},{-2,24.3},{-2,-18},{-36,-18}},
    color={255,0,255}));
  annotation (experiment(StopTime=0.09),
  Documentation(info="<html>
<p>
Elementary example for the documentation of block
<a href=\"modelica://Modelica.Clocked.BooleanSignals.Sampler.AssignClockVectorized\">Modelica.Clocked.BooleanSignals.Sampler.AssignClockVectorized</a>.
</p>
</html>"));
end AssignClockVectorized;
