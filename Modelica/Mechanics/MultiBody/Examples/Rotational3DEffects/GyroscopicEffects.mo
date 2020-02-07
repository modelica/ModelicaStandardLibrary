within Modelica.Mechanics.MultiBody.Examples.Rotational3DEffects;
model GyroscopicEffects
  "Demonstrates that a cylindrical body can be replaced by Rotor1D model"
  extends Modelica.Icons.Example;

  inner World world(driveTrainMechanics3D=true) annotation (Placement(
        transformation(extent={{-100,20},{-80,40}})));
  Joints.Spherical spherical1(
    angles_fixed=true,
    w_rel_a_fixed=true,
    z_rel_a_fixed=false) annotation (Placement(transformation(extent={{-70,20},
            {-50,40}})));
  Parts.BodyCylinder bodyCylinder1(r={0.25,0,0}, diameter=0.05) annotation (
      Placement(transformation(extent={{-40,20},{-20,40}})));
  Parts.FixedRotation fixedRotation1(angle=45, n={0,1,0}) annotation (
      Placement(transformation(extent={{-10,20},{10,40}})));
  Joints.Revolute revolute(
    n={1,0,0},
    a(fixed=false),
    phi(fixed=true),
    w(fixed=true, start=10)) annotation (Placement(transformation(extent={{20,20},{40,40}})));
  Parts.FixedTranslation fixedTranslation(r={-0.1,0,0}) annotation (Placement(
        transformation(extent={{50,20},{70,40}})));
  Parts.BodyCylinder bodyCylinder2(diameter=0.1, r={0.2,0,0}) annotation (
      Placement(transformation(extent={{80,20},{100,40}})));
  Parts.Fixed fixed annotation (Placement(transformation(extent={{-100,-40},{
            -80,-20}})));
  Joints.Spherical spherical2(
    angles_fixed=true,
    w_rel_a_fixed=true,
    z_rel_a_fixed=false) annotation (Placement(transformation(extent={{-70,-40},
            {-50,-20}})));
  Parts.BodyCylinder bodyCylinder3(
    r={0.25,0,0},
    diameter=0.05,
    color={0,128,0}) annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
  Parts.FixedRotation fixedRotation2(n={0,1,0}, angle=45) annotation (
      Placement(transformation(extent={{-10,-40},{10,-20}})));
  Parts.FixedTranslation fixedTranslation1(r={-0.1,0,0}) annotation (
      Placement(transformation(extent={{50,-40},{70,-20}})));
  Parts.BodyCylinder bodyCylinder4(
    diameter=0.1,
    r={0.2,0,0},
    color={0,128,0}) annotation (Placement(transformation(extent={{80,-40},{100,-20}})));
  Parts.Rotor1D rotor1D(
    J=bodyCylinder4.I[1, 1],
    n={1,0,0},
    a(fixed=false),
    phi(fixed=true),
    w(fixed=true, start=10)) annotation (Placement(transformation(extent={{20,-40},{40,-60}})));
equation
  connect(world.frame_b, spherical1.frame_a) annotation (Line(
      points={{-80,30},{-70,30}},
      color={95,95,95},
      thickness=0.5));
  connect(spherical1.frame_b, bodyCylinder1.frame_a) annotation (Line(
      points={{-50,30},{-40,30}},
      color={95,95,95},
      thickness=0.5));
  connect(bodyCylinder1.frame_b, fixedRotation1.frame_a) annotation (Line(
      points={{-20,30},{-10,30}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedRotation1.frame_b, revolute.frame_a) annotation (Line(
      points={{10,30},{20,30}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute.frame_b, fixedTranslation.frame_a) annotation (Line(
      points={{40,30},{50,30}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedTranslation.frame_b, bodyCylinder2.frame_a) annotation (Line(
      points={{70,30},{80,30}},
      color={95,95,95},
      thickness=0.5));
  connect(spherical2.frame_b, bodyCylinder3.frame_a) annotation (Line(
      points={{-50,-30},{-40,-30}},
      color={95,95,95},
      thickness=0.5));
  connect(bodyCylinder3.frame_b, fixedRotation2.frame_a) annotation (Line(
      points={{-20,-30},{-10,-30}},
      color={95,95,95},
      thickness=0.5));
  connect(fixed.frame_b, spherical2.frame_a) annotation (Line(
      points={{-80,-30},{-70,-30}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedTranslation1.frame_b, bodyCylinder4.frame_a) annotation (Line(
      points={{70,-30},{80,-30}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedRotation2.frame_b, fixedTranslation1.frame_a) annotation (Line(
      points={{10,-30},{50,-30}},
      color={95,95,95},
      thickness=0.5));
  connect(rotor1D.frame_a, fixedRotation2.frame_b) annotation (Line(
      points={{30,-40},{30,-30},{10,-30}},
      color={95,95,95},
      thickness=0.5));
  annotation (experiment(StopTime=5, Tolerance=1e-008), Documentation(info="<html>
<p>
This example consists of a body that is attached to the world system
with a spherical joint. On this body, a \"rotor\", i.e., a body with rotational
symmetry is present. Two kinds of models are shown:
</p>

<ul>
<li> In the upper part of the diagram layer, only multi-body components are used.</li>
<li> In the lower part of the diagram layer, the same model is implemented,
     but by a different modeling of the cylindrical body:
     The cylindrical body is included, but it is rigidly attached to its mount.
     This part takes into account the movement of the center of mass and of
     the inertia tensor of the cylindrical body. Note, since the cylindrical body
     has rotational symmetry, its center of mass and its inertia tensor is independent
     of the angle of the inertia and can therefore be rigidly attached to its mount.
     Additionally, with a \"MultiBody.Parts.Rotor1D\" model, a primarily 1-dim.
     inertia is included that takes into account the additional effects when the
     cylindrical body is moving relatively to its mounts</li>
</ul>

<p>
The simulation reveals that both the kinematic movement and the reaction forces on the
environment (object \"world\" and \"fixed\" respectively) are identical for both models.
</p>

<p>
A typical usage scenario is to model a complete drive train of a vehicle, including
the automatic gearbox, with elements of the \"Mechanics.Rotational\" library, but using
the \"Rotor1D\" model instead of the \"Rotational.Components.Inertia\" component.
This drive train model can be mounted on a 3-dim. multi-body model of the vehicle.
Additionally, one rigid body has to be fixed to the vehicle that has the mass, center
of mass and inertia tensor of the complete drive train. Both models together, give
exactly the same effect, as if every part of the drive train would have been modelled
solely with mult-body components. One benefit of this modeling is that the simulation
is much faster.
</p>

</html>"));
end GyroscopicEffects;
