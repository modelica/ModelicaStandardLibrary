within Modelica.Mechanics.MultiBody.Examples;
package Rotational3DEffects
  "Demonstrates the usage of 1-dim. rotational elements with all 3-dim. effects included"
  extends Modelica.Icons.ExamplesPackage;

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
        Placement(transformation(extent={{-44,20},{-24,40}})));
    Parts.FixedRotation fixedRotation1(angle=45, n={0,1,0}) annotation (
        Placement(transformation(extent={{-16,20},{4,40}})));
    Joints.Revolute revolute(
      n={1,0,0},
      a(fixed=false),
      phi(fixed=true),
      w(fixed=true, start=10)) annotation (Placement(transformation(extent={{14,
              20},{34,40}})));
    Parts.FixedTranslation fixedTranslation(r={-0.1,0,0}) annotation (Placement(
          transformation(extent={{42,20},{62,40}})));
    Parts.BodyCylinder bodyCylinder2(diameter=0.1, r={0.2,0,0}) annotation (
        Placement(transformation(extent={{70,20},{90,40}})));
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
      color={0,128,0}) annotation (Placement(transformation(extent={{-44,-40},{
              -24,-20}})));
    Parts.FixedRotation fixedRotation2(n={0,1,0}, angle=45) annotation (
        Placement(transformation(extent={{-16,-40},{4,-20}})));
    Parts.FixedTranslation fixedTranslation1(r={-0.1,0,0}) annotation (
        Placement(transformation(extent={{24,-40},{44,-20}})));
    Parts.BodyCylinder bodyCylinder4(
      diameter=0.1,
      r={0.2,0,0},
      color={0,128,0}) annotation (Placement(transformation(extent={{56,-40},{
              76,-20}})));
    Parts.Rotor1D rotor1D(
      J=bodyCylinder4.I[1, 1],
      n={1,0,0},
      a(fixed=false),
      phi(fixed=true),
      w(fixed=true, start=10)) annotation (Placement(transformation(extent={{28,
              -70},{48,-50}})));
  equation
    connect(world.frame_b, spherical1.frame_a) annotation (Line(
        points={{-80,30},{-70,30}},
        color={95,95,95},
        thickness=0.5));
    connect(spherical1.frame_b, bodyCylinder1.frame_a) annotation (Line(
        points={{-50,30},{-44,30}},
        color={95,95,95},
        thickness=0.5));
    connect(bodyCylinder1.frame_b, fixedRotation1.frame_a) annotation (Line(
        points={{-24,30},{-16,30}},
        color={95,95,95},
        thickness=0.5));
    connect(fixedRotation1.frame_b, revolute.frame_a) annotation (Line(
        points={{4,30},{14,30}},
        color={95,95,95},
        thickness=0.5));
    connect(revolute.frame_b, fixedTranslation.frame_a) annotation (Line(
        points={{34,30},{42,30}},
        color={95,95,95},
        thickness=0.5));
    connect(fixedTranslation.frame_b, bodyCylinder2.frame_a) annotation (Line(
        points={{62,30},{70,30}},
        color={95,95,95},
        thickness=0.5));
    connect(spherical2.frame_b, bodyCylinder3.frame_a) annotation (Line(
        points={{-50,-30},{-44,-30}},
        color={95,95,95},
        thickness=0.5));
    connect(bodyCylinder3.frame_b, fixedRotation2.frame_a) annotation (Line(
        points={{-24,-30},{-16,-30}},
        color={95,95,95},
        thickness=0.5));
    connect(fixed.frame_b, spherical2.frame_a) annotation (Line(
        points={{-80,-30},{-70,-30}},
        color={95,95,95},
        thickness=0.5));
    connect(fixedTranslation1.frame_b, bodyCylinder4.frame_a) annotation (Line(
        points={{44,-30},{56,-30}},
        color={95,95,95},
        thickness=0.5));
    connect(fixedRotation2.frame_b, fixedTranslation1.frame_a) annotation (Line(
        points={{4,-30},{24,-30}},
        color={95,95,95},
        thickness=0.5));
    connect(rotor1D.frame_a, fixedRotation2.frame_b) annotation (Line(
        points={{38,-70},{38,-76},{10,-76},{10,-30},{4,-30}},
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

  model ActuatedDrive "Demonstrates usage of models Rotor1D and Mounting1D"
    extends Modelica.Icons.Example;
    Parts.BodyShape bodyCylinder(
      r={0.5,0,0},
      m=0,
      I_11=2,
      I_22=0,
      I_33=0,
      shapeType="cylinder",
      width=0.1,
      animateSphere=false,
      r_shape={0.1,0,0},
      r_CM={0,0,0}) annotation (Placement(transformation(extent={{8,0},{28,20}})));
    Joints.Revolute revolute(
      n={1,0,0},
      a(fixed=false),
      phi(fixed=true),
      w(fixed=true)) annotation (Placement(transformation(extent={{-26,0},{-6,
              20}})));
    inner World world(g=0, driveTrainMechanics3D=true) annotation (Placement(
          transformation(extent={{-60,0},{-40,20}})));
    Forces.Torque torque annotation (Placement(transformation(extent={{8,30},{
              28,50}})));
    Blocks.Sources.Sine sine[3](amplitude={1,0,0}, freqHz={1,1,1}) annotation (
        Placement(transformation(extent={{-80,60},{-60,80}})));
    inner Parts.Fixed fixed annotation (Placement(transformation(extent={{-62,-90},
              {-42,-70}})));
    Parts.Rotor1D rotor1D(
      J=2,
      phi(fixed=true),
      w(fixed=true)) annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
    Rotational.Sources.Torque torque1(useSupport=true) annotation (Placement(
          transformation(extent={{-32,-40},{-12,-20}})));
    Parts.Mounting1D mounting1D annotation (Placement(transformation(extent={{-46,
              -60},{-26,-40}})));
  equation
    connect(world.frame_b, revolute.frame_a) annotation (Line(
        points={{-40,10},{-26,10}},
        color={95,95,95},
        thickness=0.5));
    connect(revolute.frame_b, bodyCylinder.frame_a) annotation (Line(
        points={{-6,10},{8,10}},
        color={95,95,95},
        thickness=0.5));
    connect(torque.frame_b, bodyCylinder.frame_b) annotation (Line(
        points={{28,40},{38,40},{38,10},{28,10}},
        color={95,95,95},
        thickness=0.5));
    connect(torque.frame_resolve, world.frame_b) annotation (Line(
        points={{22,50},{22,64},{-30,64},{-30,10},{-40,10}},
        color={95,95,95},
        pattern=LinePattern.Dot));
    connect(torque.frame_a, world.frame_b) annotation (Line(
        points={{8,40},{-30,40},{-30,10},{-40,10}},
        color={95,95,95},
        thickness=0.5));
    connect(sine.y, torque.torque) annotation (Line(
        points={{-59,70},{12,70},{12,52}},
        color={0,0,127}));
    connect(fixed.frame_b, rotor1D.frame_a) annotation (Line(
        points={{-42,-80},{10,-80},{10,-40}},
        color={95,95,95},
        thickness=0.5));
    connect(torque1.flange, rotor1D.flange_a) annotation (Line(
        points={{-12,-30},{0,-30}}));
    connect(mounting1D.flange_b, torque1.support) annotation (Line(
        points={{-26,-50},{-22,-50},{-22,-40}}));
    connect(mounting1D.frame_a, fixed.frame_b) annotation (Line(
        points={{-36,-60},{-36,-80},{-42,-80}},
        color={95,95,95},
        thickness=0.5));
    connect(sine[1].y, torque1.tau) annotation (Line(
        points={{-59,70},{-50,70},{-50,40},{-72,40},{-72,-30},{-34,-30}},
        color={0,0,127}));
    annotation (experiment(StopTime=1.1), Documentation(info="<html>
<p>
This example demonstrates how to utilize the
<a href=\"modelica://Modelica.Mechanics.MultiBody.Parts.Rotor1D\">Rotor1D</a>
and <a href=\"modelica://Modelica.Mechanics.MultiBody.Parts.Mounting1D\">Mounting1D</a> models and
compares the implementation with a standard multi-body implementation.
Note, the solution with Rotor1D is much more efficient.
</p>
</html>"));
  end ActuatedDrive;

  model MovingActuatedDrive
    "Demonstrates usage of model Rotor1D mounted on a moving body"
    extends Modelica.Icons.Example;
    Parts.BodyShape bodyCylinder(
      r={0.5,0,0},
      m=0,
      I_11=2,
      I_22=0,
      I_33=0,
      shapeType="cylinder",
      width=0.1,
      animateSphere=false,
      r_shape={0.1,0,0},
      r_CM={0,0,0}) annotation (Placement(transformation(extent={{50,10},{70,30}})));
    Joints.Revolute revolute(
      n={1,0,0},
      a(fixed=false),
      phi(fixed=true),
      w(fixed=true)) annotation (Placement(transformation(extent={{16,10},{36,
              30}})));
    inner World world(g=0, driveTrainMechanics3D=true) annotation (Placement(
          transformation(extent={{-84,10},{-64,30}})));
    Forces.Torque torque annotation (Placement(transformation(extent={{50,40},{
              70,60}})));
    Blocks.Sources.Sine sine1[3](amplitude={1,0,0}, freqHz={1,1,1}) annotation (
       Placement(transformation(extent={{16,70},{36,90}})));
    Parts.Rotor1D rotor1D(
      J=2,
      phi(fixed=true),
      w(fixed=true)) annotation (Placement(transformation(extent={{50,-36},{70,
              -16}})));
    Rotational.Sources.Torque torque1(useSupport=true) annotation (Placement(
          transformation(extent={{18,-36},{38,-16}})));
    Parts.Mounting1D mounting1D annotation (Placement(transformation(extent={{4,
              -56},{24,-36}})));
    Joints.Revolute r1(useAxisFlange=true, n={0,1,0}) annotation (Placement(
          transformation(extent={{-32,10},{-12,30}})));
    Rotational.Sources.Position position1(useSupport=true, w(fixed=true))
      annotation (Placement(transformation(extent={{-46,60},{-26,80}})));
    Blocks.Sources.Sine sine2(amplitude=2, freqHz=1) annotation (Placement(
          transformation(extent={{-100,60},{-80,80}})));
    Parts.Mounting1D mounting1D1(n={0,1,0})
                                 annotation (Placement(transformation(extent={{
              -60,34},{-40,54}})));
    Joints.Revolute r2(useAxisFlange=true, n={0,1,0}) annotation (Placement(
          transformation(extent={{-38,-80},{-18,-60}})));
    Rotational.Sources.Position position2(useSupport=true, w(fixed=true))
      annotation (Placement(transformation(extent={{-52,-30},{-32,-10}})));
    Parts.Mounting1D mounting1D2(n={0,1,0})
                                 annotation (Placement(transformation(extent={{
              -66,-56},{-46,-36}})));
    Parts.Fixed fixed annotation (Placement(transformation(extent={{-86,-80},{-66,
              -60}})));
  equation
    connect(revolute.frame_b, bodyCylinder.frame_a) annotation (Line(
        points={{36,20},{50,20}},
        color={95,95,95},
        thickness=0.5));
    connect(torque.frame_b, bodyCylinder.frame_b) annotation (Line(
        points={{70,50},{80,50},{80,20},{70,20}},
        color={95,95,95},
        thickness=0.5));
    connect(sine1.y, torque.torque) annotation (Line(
        points={{37,80},{54,80},{54,62}},
        color={0,0,127}));
    connect(torque1.flange, rotor1D.flange_a) annotation (Line(
        points={{38,-26},{50,-26}}));
    connect(mounting1D.flange_b, torque1.support) annotation (Line(
        points={{24,-46},{28,-46},{28,-36}}));
    connect(r1.frame_a, world.frame_b) annotation (Line(
        points={{-32,20},{-64,20}},
        color={95,95,95},
        thickness=0.5));
    connect(position1.flange, r1.axis) annotation (Line(
        points={{-26,70},{-22,70},{-22,30}}));
    connect(position1.support, mounting1D1.flange_b) annotation (Line(
        points={{-36,60},{-36,44},{-40,44}}));
    connect(mounting1D1.frame_a, world.frame_b) annotation (Line(
        points={{-50,34},{-50,20},{-64,20}},
        color={95,95,95},
        thickness=0.5));
    connect(sine2.y, position1.phi_ref) annotation (Line(
        points={{-79,70},{-48,70}},
        color={0,0,127}));
    connect(r1.frame_b, revolute.frame_a) annotation (Line(
        points={{-12,20},{16,20}},
        color={95,95,95},
        thickness=0.5));
    connect(torque.frame_resolve, revolute.frame_a) annotation (Line(
        points={{64,60},{8,60},{8,20},{16,20}},
        color={95,95,95},
        pattern=LinePattern.Dot));
    connect(torque.frame_a, revolute.frame_a) annotation (Line(
        points={{50,50},{8,50},{8,20},{16,20}},
        color={95,95,95},
        thickness=0.5));
    connect(position2.flange, r2.axis) annotation (Line(
        points={{-32,-20},{-28,-20},{-28,-60}}));
    connect(position2.support, mounting1D2.flange_b) annotation (Line(
        points={{-42,-30},{-42,-46},{-46,-46}}));
    connect(fixed.frame_b, r2.frame_a) annotation (Line(
        points={{-66,-70},{-38,-70}},
        color={95,95,95},
        thickness=0.5));
    connect(fixed.frame_b, mounting1D2.frame_a) annotation (Line(
        points={{-66,-70},{-56,-70},{-56,-56}},
        color={95,95,95},
        thickness=0.5));
    connect(sine2.y, position2.phi_ref) annotation (Line(
        points={{-79,70},{-70,70},{-70,46},{-92,46},{-92,-20},{-54,-20}},
        color={0,0,127}));
    connect(r2.frame_b, rotor1D.frame_a) annotation (Line(
        points={{-18,-70},{60,-70},{60,-36}},
        color={95,95,95},
        thickness=0.5));
    connect(r2.frame_b, mounting1D.frame_a) annotation (Line(
        points={{-18,-70},{14,-70},{14,-56}},
        color={95,95,95},
        thickness=0.5));
    connect(sine1[1].y, torque1.tau) annotation (Line(
        points={{37,80},{92,80},{92,-10},{0,-10},{0,-26},{16,-26}},
        color={0,0,127}));
    annotation (experiment(StopTime=1.1),
      Documentation(info="<html>
<p>
This model demonstrates how a moving drive train modelled with 3-dim. multi-body elements
(revolute, bodyCylinder) can alternatively be modeled with component <a href=\"modelica://Modelica.Mechanics.MultiBody.Parts.Rotor1D\">rotor1D</a> to speed up
simulation. The movement of the two systems is identical and also the cut-torques in the
various frames (such as: r1.frame_b.t and r2.frame_b.t).
</p>

<p>
The driving joints (r1, r2) with rotation axis {0,1,0} are modelled to be driven by a motor torque
along the {1,0,0} axis. Basically, this means that an idealized bevel gear is used to drive the
axes of the revolute joints.
</p>
</html>"));
  end MovingActuatedDrive;

  model GearConstraint "Demonstrate usage of GearConstraint model"
    extends Modelica.Icons.Example;
    Joints.GearConstraint gearConstraint(
      ratio=10,
      phi_b(fixed=true),
      w_b(fixed=true),
      checkTotalPower=true)
                       annotation (Placement(transformation(extent={{34,40},{54,
              60}})));
    inner World world(driveTrainMechanics3D=true, g=0) annotation (Placement(
          transformation(extent={{-62,10},{-42,30}})));
    Parts.BodyCylinder cyl1(
      diameter=0.1,
      color={0,128,0},
      r={0.4,0,0}) annotation (Placement(transformation(extent={{2,40},{22,60}})));
    Parts.BodyCylinder cyl2(r={0.4,0,0}, diameter=0.2) annotation (Placement(
          transformation(extent={{70,40},{90,60}})));
    Forces.Torque torque1 annotation (Placement(transformation(extent={{-26,40},
              {-6,60}})));
    Blocks.Sources.Sine sine[3](amplitude={2,0,0}, freqHz={1,1,1}) annotation (
        Placement(transformation(extent={{-100,60},{-80,80}})));
    Parts.Fixed fixed annotation (Placement(transformation(extent={{-48,-90},{-28,
              -70}})));
    Rotational.Components.Inertia inertia1(
      J=cyl1.I[1, 1],
      a(fixed=false),
      phi(fixed=true, start=0),
      w(fixed=true, start=0)) annotation (Placement(transformation(extent={{-20,
              -40},{0,-20}})));
    Rotational.Components.IdealGear idealGear(ratio=10, useSupport=true)
      annotation (Placement(transformation(extent={{12,-40},{32,-20}})));
    Rotational.Components.Inertia inertia2(J=cyl2.I[1, 1]) annotation (
        Placement(transformation(extent={{44,-40},{64,-20}})));
    Rotational.Sources.Torque torque2(useSupport=true) annotation (Placement(
          transformation(extent={{-48,-40},{-28,-20}})));
    Parts.Mounting1D mounting1D annotation (Placement(transformation(extent={{-20,
              -70},{0,-50}})));
  equation
    connect(world.frame_b, gearConstraint.bearing) annotation (Line(
        points={{-42,20},{44,20},{44,40}},
        color={95,95,95},
        thickness=0.5));
    connect(cyl1.frame_b, gearConstraint.frame_a) annotation (Line(
        points={{22,50},{34,50}},
        color={95,95,95},
        thickness=0.5));
    connect(gearConstraint.frame_b, cyl2.frame_a) annotation (Line(
        points={{54,50},{70,50}},
        color={95,95,95},
        thickness=0.5));
    connect(torque1.frame_b, cyl1.frame_a) annotation (Line(
        points={{-6,50},{2,50}},
        color={95,95,95},
        thickness=0.5));
    connect(torque1.frame_a, world.frame_b) annotation (Line(
        points={{-26,50},{-36,50},{-36,20},{-42,20}},
        color={95,95,95},
        thickness=0.5));
    connect(sine.y, torque1.torque) annotation (Line(
        points={{-79,70},{-22,70},{-22,62}},
        color={0,0,127}));
    connect(inertia1.flange_b, idealGear.flange_a) annotation (Line(
        points={{0,-30},{12,-30}}));
    connect(idealGear.flange_b, inertia2.flange_a) annotation (Line(
        points={{32,-30},{44,-30}}));
    connect(torque2.flange, inertia1.flange_a) annotation (Line(
        points={{-28,-30},{-20,-30}}));
    connect(sine[1].y, torque2.tau) annotation (Line(
        points={{-79,70},{-72,70},{-72,-30},{-50,-30}},
        color={0,0,127}));
    connect(mounting1D.flange_b, idealGear.support) annotation (Line(
        points={{0,-60},{22,-60},{22,-40}}));
    connect(mounting1D.flange_b, torque2.support) annotation (Line(
        points={{0,-60},{4,-60},{4,-48},{-38,-48},{-38,-40}}));
    connect(fixed.frame_b, mounting1D.frame_a) annotation (Line(
        points={{-28,-80},{-10,-80},{-10,-70}},
        color={95,95,95},
        thickness=0.5));
    annotation (experiment(StopTime=5), Documentation(info="<html>
<p>
This model demonstrates the usage of the
<a href=\"Modelica.Mechanics.MultiBody.Joints.GearConstraint\">GearConstraint</a>
model to model a gearbox with multi-body elements. The formulation is compared with
a one-dimensional model that is mounted with an
<a href=\"modelica://Modelica.Mechanics.MultiBody.Parts.Mounting1D\">Mounting1D</a> element.
</p>
</html>"));
  end GearConstraint;

  model BevelGear1D
    "Demonstrates the usage of a BevelGear1D model and how to calculate the power of such an element"
    import Modelica.Mechanics.MultiBody.Frames;
    extends Modelica.Icons.Example;
    parameter Modelica.Mechanics.MultiBody.Types.Axis na={1,0,0}
      "Axis of rotation of left gear axis";
    parameter Modelica.Mechanics.MultiBody.Types.Axis nb={0,1,0}
      "Axis of rotation of right gear axis";

    inner Modelica.Mechanics.MultiBody.World world(final driveTrainMechanics3D=true) annotation (Placement(transformation(
            extent={{-80,-20},{-60,0}})));
    Modelica.Mechanics.MultiBody.Parts.Rotor1D       inertia1(
      J=1.1,
      a(fixed=false),
      phi(fixed=true, start=0),
      w(fixed=true, start=0),
      n=na)                   annotation (Placement(transformation(extent={{-30,60},
              {-10,80}})));
    Modelica.Mechanics.MultiBody.Parts.Rotor1D       inertia2(J=18.2, n=nb)
      annotation (Placement(transformation(extent={{30,60},{50,80}})));
    Modelica.Mechanics.MultiBody.Parts.BevelGear1D bevelGear(
      ratio=10,
      n_a=na,
      n_b=nb)      annotation (Placement(transformation(extent={{0,60},{20,80}})));
    Modelica.Mechanics.MultiBody.Joints.Revolute revolute1(useAxisFlange=true, n={
          1,0,0},
      stateSelect=StateSelect.always,
      phi(fixed=true),
      w(fixed=true))
      annotation (Placement(transformation(extent={{-46,0},{-26,-20}})));
    Modelica.Mechanics.MultiBody.Joints.Revolute revolute2(useAxisFlange=true, n={
          0,1,0},
      stateSelect=StateSelect.always,
      phi(fixed=true),
      w(fixed=true))
                  annotation (Placement(transformation(extent={{0,0},{20,-20}})));
    Modelica.Mechanics.MultiBody.Joints.Revolute revolute3(useAxisFlange=true, n={
          0,0,1},
      stateSelect=StateSelect.always,
      phi(fixed=true),
      w(fixed=true))
                  annotation (Placement(transformation(extent={{46,0},{66,-20}})));
    Modelica.Mechanics.Rotational.Sources.Torque torque1
      annotation (Placement(transformation(extent={{-52,-45},{-42,-35}})));
    Modelica.Mechanics.Rotational.Sources.Torque torque2
      annotation (Placement(transformation(extent={{-4,-45},{6,-35}})));
    Modelica.Mechanics.Rotational.Sources.Torque torque3
      annotation (Placement(transformation(extent={{42,-45},{52,-35}})));
    Modelica.Blocks.Sources.Sine sine1(amplitude=110, freqHz=5)
      annotation (Placement(transformation(extent={{-72,-46},{-60,-34}})));
    Modelica.Blocks.Sources.Sine sine2(amplitude=120, freqHz=6)
      annotation (Placement(transformation(extent={{-24,-46},{-12,-34}})));
    Modelica.Blocks.Sources.Sine sine3(amplitude=130, freqHz=7)
      annotation (Placement(transformation(extent={{24,-46},{36,-34}})));
    Modelica.Mechanics.MultiBody.Parts.Mounting1D mounting1D(n=na)
      annotation (Placement(transformation(extent={{-72,46},{-52,66}})));
    Modelica.Mechanics.Rotational.Sources.Torque torque(useSupport=true)
      annotation (Placement(transformation(extent={{-58,60},{-38,80}})));
    Modelica.Blocks.Sources.Sine sine4(amplitude=140, freqHz=8)
      annotation (Placement(transformation(extent={{-90,64},{-78,76}})));
    Modelica.Mechanics.MultiBody.Parts.BodyBox bodyBox(
      r={0.1,0.1,0.1},
      length=0.1,
      width=0.1)
      annotation (Placement(transformation(extent={{76,-20},{96,0}})));
    Sensors.AbsoluteAngularVelocity sensor1(resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a)
      annotation (Placement(transformation(extent={{62,42},{82,62}})));
    Sensors.CutTorque sensor2(resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a,
        animation=false)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=-90,
          origin={10,42})));
    Modelica.SIunits.AngularVelocity ws[3] = sensor1.w;
    Modelica.SIunits.Power bevelGearPower;
  equation
    bevelGearPower = (ws + der(bevelGear.flange_a.phi)*na)*bevelGear.flange_a.tau*na +
                     (ws + der(bevelGear.flange_b.phi)*nb)*bevelGear.flange_b.tau*nb +
                     ws*sensor2.torque;
    assert(abs(bevelGearPower) < 1e-3, "Error, energy balance of bevel gear is wrong");

    connect(inertia1.flange_b, bevelGear.flange_a) annotation (Line(
        points={{-10,70},{0,70}}));
    connect(bevelGear.flange_b, inertia2.flange_a) annotation (Line(
        points={{20,70},{30,70}}));
    connect(world.frame_b, revolute1.frame_a) annotation (Line(
        points={{-60,-10},{-46,-10}},
        color={95,95,95},
        thickness=0.5));
    connect(revolute1.frame_b, revolute2.frame_a) annotation (Line(
        points={{-26,-10},{0,-10}},
        color={95,95,95},
        thickness=0.5));
    connect(revolute2.frame_b, revolute3.frame_a) annotation (Line(
        points={{20,-10},{46,-10}},
        color={95,95,95},
        thickness=0.5));
    connect(torque1.flange, revolute1.axis) annotation (Line(
        points={{-42,-40},{-36,-40},{-36,-20}}));
    connect(torque2.flange, revolute2.axis) annotation (Line(
        points={{6,-40},{10,-40},{10,-20}}));
    connect(torque3.flange, revolute3.axis) annotation (Line(
        points={{52,-40},{56,-40},{56,-20}}));
    connect(sine1.y, torque1.tau) annotation (Line(
        points={{-59.4,-40},{-53,-40}},
        color={0,0,127}));
    connect(torque2.tau, sine2.y) annotation (Line(
        points={{-5,-40},{-11.4,-40}},
        color={0,0,127}));
    connect(torque3.tau, sine3.y) annotation (Line(
        points={{41,-40},{36.6,-40}},
        color={0,0,127}));
    connect(torque.flange, inertia1.flange_a) annotation (Line(
        points={{-38,70},{-30,70}}));
    connect(torque.support, mounting1D.flange_b) annotation (Line(
        points={{-48,60},{-48,56},{-52,56}}));
    connect(mounting1D.frame_a, revolute3.frame_b) annotation (Line(
        points={{-62,46},{-62,20},{72,20},{72,-10},{66,-10}},
        color={95,95,95},
        thickness=0.5));
    connect(torque.tau, sine4.y) annotation (Line(
        points={{-60,70},{-77.4,70}},
        color={0,0,127}));
    connect(revolute3.frame_b, bodyBox.frame_a) annotation (Line(
        points={{66,-10},{76,-10}},
        color={95,95,95},
        thickness=0.5));
    connect(inertia1.frame_a, revolute3.frame_b) annotation (Line(
        points={{-20,60},{-20,40},{-20,40},{-20,20},{72,20},{72,-10},{66,-10}},
        color={95,95,95},
        thickness=0.5));
    connect(inertia2.frame_a, revolute3.frame_b) annotation (Line(
        points={{40,60},{40,20},{72,20},{72,-10},{66,-10}},
        color={95,95,95},
        thickness=0.5));
    connect(bevelGear.frame_a, sensor1.frame_a) annotation (Line(
        points={{10,60},{24,60},{24,52},{62,52}},
        color={95,95,95},
        thickness=0.5));
    connect(bevelGear.frame_a, sensor2.frame_b) annotation (Line(
        points={{10,60},{10,52}},
        color={95,95,95},
        thickness=0.5));
    connect(sensor2.frame_a, revolute3.frame_b) annotation (Line(
        points={{10,32},{10,20},{72,20},{72,-10},{66,-10}},
        color={95,95,95},
        thickness=0.5));
    annotation (      Documentation(info="<html>
<p>
This model consists of a drive train with two inertias that are coupled by a bevel gear
(with 90 degree angle between the two gear flanges).
This drive train is mounted on a body that is rotated along three axes.
The drive train is modeled with 1D rotational elements that take into account 3D effects.
</p>

<p>
The bevelGear component consists of two rotational flanges (for the gear flanges) and one 3D frame
(for the support/mounting).
Since the bevelGear does not store energy, the power balance must hold (the total sum
of inflowing and outflowing energy must be zero). One has to be careful, when
computing the energy flow of hybrid 1D/3D component: The angular velocities of rotational flanges
are with respect to the support frame (so the moving body on which the drive train
is mounted). Therefore, when computing the energy flow, first the absolute angular velocities
of the flanges have to be calculated. In this example model, this is performed in the following way
(na and nb are the axes of rotations of the gear flanges, and ws is the
angular velocity of the support frame):
</p>

<pre>
    import Modelica.Mechanics.MultiBody.Frames;
    import SI=Modelica.SIunits;
    SI.Power           bevelGearPower;
    SI.AngularVelocity ws[3] = Frames.angularVelocity2(bevelGear.frame_a.R);
  <b>equation</b>
    bevelGearPower = (ws + der(bevelGear.flange_a.phi)*na)*bevelGear.flange_a.tau*na +
                     (ws + der(bevelGear.flange_b.phi)*nb)*bevelGear.flange_b.tau*nb +
                     ws*bevelGear.frame_a.t;
</pre>
<p>
The total energy flow bevelGearPower must be zero. If a relative tolerance of 1e-4 is used
for simulation, bevelGearPower is in the order of 1e-8 (and smaller for a smaller relative
tolerance).
</p>
</html>"),
      experiment(StopTime=1.0));
  end BevelGear1D;
  annotation (Documentation(info="<html>
<p>
This library demonstrates the usage of elements of the Mechanics.Rotational library
by taking into account all 3-dim. effects. The reason for this type of modeling is
to speedup the simulation drastically. This is possible if moving bodies have
rotational symmetry. A typical application area are drive trains, driving joints of
a multi-body system.
</p>
</html>"));
end Rotational3DEffects;
