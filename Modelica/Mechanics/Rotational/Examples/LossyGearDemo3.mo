within Modelica.Mechanics.Rotational.Examples;
model LossyGearDemo3
  "Example that failed in the previous version of the LossyGear version"
  extends Modelica.Icons.Example;

  Modelica.Mechanics.Rotational.Components.LossyGear gear(
    ratio=1,
    lossTable=[0, 0.25, 0.25, 0.625, 2.5],
    useSupport=false) annotation (Placement(transformation(extent={{-10,0},
            {10,20}})));
  Modelica.Mechanics.Rotational.Components.Inertia Inertia1(w(start=10), J=
        0.001) annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  Modelica.Mechanics.Rotational.Sources.Torque torque1(useSupport=false)
    annotation (Placement(transformation(extent={{-68,0},{-48,20}})));
  Modelica.Mechanics.Rotational.Sources.Torque torque2(useSupport=false)
    annotation (Placement(transformation(extent={{68,0},{48,20}})));
  Modelica.Blocks.Sources.Step step(height=0) annotation (Placement(
        transformation(extent={{-100,0},{-80,20}})));
  Modelica.Blocks.Sources.Step step1(
    startTime=0.5,
    height=1,
    offset=0) annotation (Placement(transformation(
        origin={90,10},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  Modelica.Mechanics.Rotational.Components.Inertia Inertia2(
    J=0.001,
    phi(fixed=true, start=0),
    w(start=10, fixed=true)) annotation (Placement(transformation(extent={{
            20,0},{40,20}})));
equation
  connect(Inertia1.flange_b, gear.flange_a)
    annotation (Line(points={{-20,10},{-16,10},{-10,10}}));
  connect(torque1.flange, Inertia1.flange_a)
    annotation (Line(points={{-48,10},{-40,10}}));
  connect(step.y, torque1.tau)
    annotation (Line(points={{-79,10},{-70,10}}, color={0,0,127}));
  connect(gear.flange_b, Inertia2.flange_a)
    annotation (Line(points={{10,10},{20,10}}));
  connect(Inertia2.flange_b, torque2.flange)
    annotation (Line(points={{40,10},{48,10}}));
  connect(step1.y, torque2.tau) annotation (Line(
      points={{79,10},{74.5,10},{74.5,10},{70,10}}, color={0,0,127}));
  annotation (
    Documentation(info="<html>
<p>
This example demonstrates a situation where the driving side of the
LossyGear model is not obvious.
The version of LossyGear up to version 3.1 of package Modelica failed in this case
(no convergence of the event iteration).
</p>
</html>"),
       experiment(StopTime=1.0, Interval=0.001));
end LossyGearDemo3;
