within Modelica.Mechanics.Rotational.Examples;
model OneWayClutchDisengaged "Drive train with disengaged one-way clutch"
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
  Modelica.Mechanics.Rotational.Sources.ConstantTorque torqueLoad(tau_constant=-0.3) annotation (Placement(transformation(extent={{90,-10},{70,10}})));
  Modelica.Blocks.Sources.Sine signalTorque(
    amplitude=10,
    offset=-torqueLoad.tau_constant,
    f=2) annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Modelica.Blocks.Sources.Constant signalEngagement(k=0)
    annotation (Placement(transformation(extent={{-20,30},{0,50}})));
equation
  connect(torque.flange, inertiaIn.flange_a) annotation (Line(points={{-30,0},{-20,0}}));
  connect(signalTorque.y, torque.tau) annotation (Line(points={{-59,0},{-52,0}}, color={0,0,127}));
  connect(inertiaIn.flange_b, oneWayClutch.flange_a) annotation (Line(points={{0,0},{10,0}}));
  connect(oneWayClutch.flange_b, inertiaOut.flange_a) annotation (Line(points={{30,0},{40,0}}));
  connect(signalEngagement.y, oneWayClutch.f_normalized) annotation (Line(points={{1,40},{20,40},{20,11}}, color={0,0,127}));
  connect(inertiaOut.flange_b, torqueLoad.flange) annotation (Line(points={{60,0},{70,0}}));
  annotation (
    experiment(StopTime=2, Interval=0.001), Documentation(info="<html>
<p>
The drive train consists of a one-way clutch and driving and driven inertias.
To demonstrate the behavior of the clutch&#39;s freewheel only, the clutch stays
disengaged for all the time.
The sine torque is applied on the driving inertia forcing inertia&#39;s speed change.
On the driven side there is applied constant load torque only.
</p>
<p>
Simulate for 2&nbsp;seconds and compare inertias&#39; velocities <code>inertiaIn.w</code>
and <code>inertiaOut.w</code> to each other.
</p>
</html>"));
end OneWayClutchDisengaged;
