within Modelica.Mechanics.MultiBody.Examples.Rotational3DEffects;
model GearConstraint "Demonstrate usage of GearConstraint model"
  extends Modelica.Icons.Example;
  Joints.GearConstraint gearConstraint(
    ratio=10,
    phi_b(fixed=true),
    w_b(fixed=true),
    checkTotalPower=true)
                     annotation (Placement(transformation(extent={{50,40},{70,60}})));
  inner World world(driveTrainMechanics3D=true, g=0) annotation (Placement(
        transformation(extent={{-50,10},{-30,30}})));
  Parts.BodyCylinder cyl1(
    diameter=0.1,
    color={0,128,0},
    r={0.4,0,0}) annotation (Placement(transformation(extent={{20,40},{40,60}})));
  Parts.BodyCylinder cyl2(r={0.4,0,0}, diameter=0.2) annotation (Placement(
        transformation(extent={{80,40},{100,60}})));
  Forces.Torque torque1 annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  Blocks.Sources.Sine sine[3](amplitude={2,0,0}, f={1,1,1}) annotation (
      Placement(transformation(extent={{-100,60},{-80,80}})));
  Parts.Fixed fixed annotation (Placement(transformation(extent={{-50,-90},{-30,-70}})));
  Rotational.Components.Inertia inertia1(
    J=cyl1.I[1, 1],
    a(fixed=false),
    phi(fixed=true, start=0),
    w(fixed=true, start=0)) annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
  Rotational.Components.IdealGear idealGear(ratio=10, useSupport=true)
    annotation (Placement(transformation(extent={{50,-40},{70,-20}})));
  Rotational.Components.Inertia inertia2(J=cyl2.I[1, 1]) annotation (
      Placement(transformation(extent={{80,-40},{100,-20}})));
  Rotational.Sources.Torque torque2(useSupport=true) annotation (Placement(
        transformation(extent={{-10,-40},{10,-20}})));
  Parts.Mounting1D mounting1D annotation (Placement(transformation(extent={{-30,-70},{-10,-50}})));
equation
  connect(world.frame_b, gearConstraint.bearing) annotation (Line(
      points={{-30,20},{60,20},{60,40}},
      color={95,95,95},
      thickness=0.5));
  connect(cyl1.frame_b, gearConstraint.frame_a) annotation (Line(
      points={{40,50},{50,50}},
      color={95,95,95},
      thickness=0.5));
  connect(gearConstraint.frame_b, cyl2.frame_a) annotation (Line(
      points={{70,50},{80,50}},
      color={95,95,95},
      thickness=0.5));
  connect(torque1.frame_b, cyl1.frame_a) annotation (Line(
      points={{10,50},{20,50}},
      color={95,95,95},
      thickness=0.5));
  connect(torque1.frame_a, world.frame_b) annotation (Line(
      points={{-10,50},{-20,50},{-20,20},{-30,20}},
      color={95,95,95},
      thickness=0.5));
  connect(sine.y, torque1.torque) annotation (Line(
      points={{-79,70},{-6,70},{-6,62}},   color={0,0,127}));
  connect(inertia1.flange_b, idealGear.flange_a) annotation (Line(
      points={{40,-30},{50,-30}}));
  connect(idealGear.flange_b, inertia2.flange_a) annotation (Line(
      points={{70,-30},{80,-30}}));
  connect(torque2.flange, inertia1.flange_a) annotation (Line(
      points={{10,-30},{20,-30}}));
  connect(sine[1].y, torque2.tau) annotation (Line(
      points={{-79,70},{-70,70},{-70,-30},{-12,-30}}, color={0,0,127}));
  connect(mounting1D.flange_b, idealGear.support) annotation (Line(
      points={{-10,-60},{60,-60},{60,-40}}));
  connect(mounting1D.flange_b, torque2.support) annotation (Line(
      points={{-10,-60},{0,-60},{0,-40}}));
  connect(fixed.frame_b, mounting1D.frame_a) annotation (Line(
      points={{-30,-80},{-20,-80},{-20,-70}},
      color={95,95,95},
      thickness=0.5));
  annotation (experiment(StopTime=5), Documentation(info="<html>
<p>
This model demonstrates the usage of the
<a href=\"modelica://Modelica.Mechanics.MultiBody.Joints.GearConstraint\">GearConstraint</a>
model to model a gearbox with multi-body elements. The formulation is compared with
a one-dimensional model that is mounted with an
<a href=\"modelica://Modelica.Mechanics.MultiBody.Parts.Mounting1D\">Mounting1D</a> element.
</p>
</html>"));
end GearConstraint;
