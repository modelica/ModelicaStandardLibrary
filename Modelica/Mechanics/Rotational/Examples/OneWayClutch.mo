within Modelica.Mechanics.Rotational.Examples;
model OneWayClutch "Drive train with actively engaged one-way clutch"
  extends Modelica.Icons.Example;

  Modelica.Mechanics.Rotational.Components.Inertia inertiaIn(
    J=1,
    phi(fixed=true, start=0),
    w(fixed=true, start=-0.5)) annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  Modelica.Mechanics.Rotational.Components.Inertia inertiaOut(
    J=1,
    phi(fixed=true, start=0),
    w(fixed=true, start=0)) annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Mechanics.Rotational.Components.OneWayClutch oneWayClutch(
    peak=25,
    fn_max=3,
    startForward(fixed=true),
    stuck(fixed=true)) annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  Modelica.Mechanics.Rotational.Sources.Torque torque
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  Modelica.Blocks.Sources.Sine signalTorque(
    amplitude=10,
    f=3) annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Modelica.Blocks.Sources.Pulse signalEngagement(
    amplitude=1,
    width=50,
    period=1.3,
    startTime=0.3) annotation (Placement(transformation(extent={{-20,30},{0,50}})));
equation
  connect(torque.flange, inertiaIn.flange_a) annotation (Line(points={{-30,0},{-20,0}}));
  connect(signalTorque.y, torque.tau) annotation (Line(points={{-59,0},{-52,0}}, color={0,0,127}));
  connect(inertiaIn.flange_b, oneWayClutch.flange_a) annotation (Line(points={{0,0},{10,0}}));
  connect(oneWayClutch.flange_b, inertiaOut.flange_a) annotation (Line(points={{30,0},{40,0}}));
  connect(signalEngagement.y, oneWayClutch.f_normalized) annotation (Line(points={{1,40},{20,40},{20,11}}, color={0,0,127}));
  annotation (
    experiment(StopTime=2, Interval=0.001), Documentation(info="<html>
<p>
The drive train consists of a one-way clutch and driving and driven inertias.
The one-way clutch is engaged periodically thus forcing both the inertias to
match their rotational velocity.
When disengaged, only the freewheel functionality of the one-way clutch is
available and is active as long as the relative angular velocity w_rel becomes zero.
</p>
<p>
Simulate for 2&nbsp;seconds and compare inertias&#39; velocities <code>inertiaIn.w</code>
and <code>inertiaOut.w</code> to each other.
Check also the engagement of the clutch <code>oneWayClutch.f_normalized</code>
and its lossy power <code>oneWayClutch.lossPower</code>.
</p>
</html>"));
end OneWayClutch;
