within Modelica.Mechanics.MultiBody.Examples;
package Rotational3DEffects
  "Demonstrates the usage of 1-dim. rotational elements with all 3-dim. effects included"
  model GyroscopicEffects
    "Demonstrates that a cylindrical body can be replaced by Rotor1D model"
    extends Modelica.Icons.Example;

    inner World world(                             driveTrainMechanics3D=true)
      annotation (Placement(transformation(extent={{-100,20},{-80,40}},
            rotation=0)));
    Joints.Spherical spherical1(
      angles_fixed=true,
      w_rel_a_fixed=true,
      z_rel_a_fixed=false)
      annotation (Placement(transformation(extent={{-70,20},{-50,40}}, rotation=
             0)));
    Parts.BodyCylinder bodyCylinder1(                             r={0.25,0,0},
        diameter=0.05) annotation (Placement(transformation(extent={{-44,20},{
              -24,40}}, rotation=0)));
    Parts.FixedRotation fixedRotation1(                             angle=45,
        n={0,1,0}) annotation (Placement(transformation(extent={{-16,20},{4,40}},
            rotation=0)));
    Joints.Revolute revolute(
      n={1,0,0},
      a(fixed=false),
      phi(fixed=true),
      w(fixed=true, start=10))
                  annotation (Placement(transformation(extent={{14,20},{34,40}},
            rotation=0)));
    Parts.FixedTranslation fixedTranslation(                             r={-0.1,
          0,0}) annotation (Placement(transformation(extent={{42,20},{62,40}},
            rotation=0)));
    Parts.BodyCylinder bodyCylinder2(                             diameter=
          0.1, r={0.2,0,0}) annotation (Placement(transformation(extent={{70,20},
              {90,40}}, rotation=0)));
    Parts.Fixed fixed
      annotation (Placement(transformation(extent={{-100,-40},{-80,-20}},
            rotation=0)));
    Joints.Spherical spherical2(
      angles_fixed=true,
      w_rel_a_fixed=true,
      z_rel_a_fixed=false)
      annotation (Placement(transformation(extent={{-70,-40},{-50,-20}},
            rotation=0)));
    Parts.BodyCylinder bodyCylinder3(
      r={0.25,0,0},
      diameter=0.05,
      color={0,128,0}) annotation (Placement(transformation(extent={{-44,-40},{
              -24,-20}}, rotation=0)));
    Parts.FixedRotation fixedRotation2(                             n={0,1,0},
        angle=45) annotation (Placement(transformation(extent={{-16,-40},{4,-20}},
            rotation=0)));
    Parts.FixedTranslation fixedTranslation1(                             r={
          -0.1,0,0}) annotation (Placement(transformation(extent={{24,-40},{44,
              -20}}, rotation=0)));
    Parts.BodyCylinder bodyCylinder4(
      diameter=0.1,
      r={0.2,0,0},
      color={0,128,0}) annotation (Placement(transformation(extent={{56,-40},{
              76,-20}}, rotation=0)));
    Parts.Rotor1D rotor1D(
      J=bodyCylinder4.I[1, 1],
      n={1,0,0},
      a(fixed=false),
      phi(fixed=true),
      w(fixed=true, start=10))
                  annotation (Placement(transformation(extent={{28,-70},{48,-50}},
            rotation=0)));
  equation
    connect(world.frame_b,spherical1. frame_a) annotation (Line(
        points={{-80,30},{-70,30}},
        color={95,95,95},
        thickness=0.5,
        smooth=Smooth.None));
    connect(spherical1.frame_b,bodyCylinder1. frame_a) annotation (Line(
        points={{-50,30},{-44,30}},
        color={95,95,95},
        thickness=0.5,
        smooth=Smooth.None));
    connect(bodyCylinder1.frame_b,fixedRotation1. frame_a) annotation (Line(
        points={{-24,30},{-16,30}},
        color={95,95,95},
        thickness=0.5,
        smooth=Smooth.None));
    connect(fixedRotation1.frame_b,revolute. frame_a) annotation (Line(
        points={{4,30},{14,30}},
        color={95,95,95},
        thickness=0.5,
        smooth=Smooth.None));
    connect(revolute.frame_b,fixedTranslation. frame_a) annotation (Line(
        points={{34,30},{42,30}},
        color={95,95,95},
        thickness=0.5,
        smooth=Smooth.None));
    connect(fixedTranslation.frame_b,bodyCylinder2. frame_a) annotation (Line(
        points={{62,30},{70,30}},
        color={95,95,95},
        thickness=0.5,
        smooth=Smooth.None));
    connect(spherical2.frame_b,bodyCylinder3. frame_a) annotation (Line(
        points={{-50,-30},{-44,-30}},
        color={95,95,95},
        thickness=0.5,
        smooth=Smooth.None));
    connect(bodyCylinder3.frame_b,fixedRotation2. frame_a) annotation (Line(
        points={{-24,-30},{-16,-30}},
        color={95,95,95},
        thickness=0.5,
        smooth=Smooth.None));
    connect(fixed.frame_b,spherical2. frame_a) annotation (Line(
        points={{-80,-30},{-70,-30}},
        color={95,95,95},
        thickness=0.5,
        smooth=Smooth.None));
    connect(fixedTranslation1.frame_b,bodyCylinder4. frame_a) annotation (Line(
        points={{44,-30},{56,-30}},
        color={95,95,95},
        thickness=0.5,
        smooth=Smooth.None));
    connect(fixedRotation2.frame_b,fixedTranslation1. frame_a) annotation (Line(
        points={{4,-30},{24,-30}},
        color={95,95,95},
        thickness=0.5,
        smooth=Smooth.None));
    connect(rotor1D.frame_a,fixedRotation2. frame_b) annotation (Line(
        points={{38,-70},{38,-76},{10,-76},{10,-30},{4,-30}},
        color={95,95,95},
        thickness=0.5,
        smooth=Smooth.None));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics),
      experiment(StopTime=5, Tolerance=1e-008),
      Documentation(info="<html>
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

  model ActuatedDrive
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
      r_CM={0,0,0})
                 annotation (Placement(transformation(extent={{8,0},{28,20}},
            rotation=0)));
    Joints.Revolute revolute(                             n={1,0,0},
      a(fixed=false),
      phi(fixed=true),
      w(fixed=true))
      annotation (Placement(transformation(extent={{-26,0},{-6,20}}, rotation=0)));
    inner World world(                             g=0, driveTrainMechanics3D=
          true) annotation (Placement(transformation(extent={{-60,0},{-40,20}},
            rotation=0)));
    Forces.Torque torque
      annotation (Placement(transformation(extent={{8,30},{28,50}}, rotation=0)));
    Blocks.Sources.Sine sine[         3](amplitude={1,0,0}, freqHz={1,1,1})
      annotation (Placement(transformation(extent={{-80,60},{-60,80}}, rotation=
             0)));
    inner Parts.Fixed fixed
                annotation (Placement(transformation(extent={{-62,-90},{-42,-70}},
            rotation=0)));
    Parts.Rotor1D rotor1D(                             J=2,
      phi(fixed=true),
      w(fixed=true))
      annotation (Placement(transformation(extent={{0,-40},{20,-20}}, rotation=
              0)));
    Rotational.Sources.Torque torque1(useSupport=true)
      annotation (Placement(transformation(extent={{-32,-40},{-12,-20}},
            rotation=0)));
    Parts.Mounting1D mounting1D
      annotation (Placement(transformation(extent={{-46,-60},{-26,-40}},
            rotation=0)));
  equation
    connect(world.frame_b,revolute. frame_a) annotation (Line(
        points={{-40,10},{-26,10}},
        color={95,95,95},
        thickness=0.5,
        smooth=Smooth.None));
    connect(revolute.frame_b,bodyCylinder. frame_a) annotation (Line(
        points={{-6,10},{8,10}},
        color={95,95,95},
        thickness=0.5,
        smooth=Smooth.None));
    connect(torque.frame_b,bodyCylinder. frame_b) annotation (Line(
        points={{28,40},{38,40},{38,10},{28,10}},
        color={95,95,95},
        thickness=0.5,
        smooth=Smooth.None));
    connect(torque.frame_resolve,world. frame_b) annotation (Line(
        points={{22,50},{22,64},{-30,64},{-30,10},{-40,10}},
        color={95,95,95},
        pattern=LinePattern.Dot,
        smooth=Smooth.None));
    connect(torque.frame_a,world. frame_b) annotation (Line(
        points={{8,40},{-30,40},{-30,10},{-40,10}},
        color={95,95,95},
        thickness=0.5,
        smooth=Smooth.None));
    connect(sine.y,torque. torque) annotation (Line(
        points={{-59,70},{12,70},{12,52}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(fixed.frame_b,rotor1D. frame_a)  annotation (Line(
        points={{-42,-80},{10,-80},{10,-40}},
        color={95,95,95},
        thickness=0.5,
        smooth=Smooth.None));
    connect(torque1.flange,rotor1D.   flange_a) annotation (Line(
        points={{-12,-30},{0,-30}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(mounting1D.flange_b,torque1.support)  annotation (Line(
        points={{-26,-50},{-22,-50},{-22,-40}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(mounting1D.frame_a,fixed. frame_b)  annotation (Line(
        points={{-36,-60},{-36,-80},{-42,-80}},
        color={95,95,95},
        thickness=0.5,
        smooth=Smooth.None));
    connect(sine[1].y,torque1. tau) annotation (Line(
        points={{-59,70},{-50,70},{-50,40},{-72,40},{-72,-30},{-34,-30}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics),
      experiment(StopTime=1.1));
  end ActuatedDrive;

  model MovingActuatedDrive
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
      r_CM={0,0,0})
                 annotation (Placement(transformation(extent={{50,10},{70,30}},
            rotation=0)));
    Joints.Revolute revolute(                             n={1,0,0},
      a(fixed=false),
      phi(fixed=true),
      w(fixed=true))
      annotation (Placement(transformation(extent={{16,10},{36,30}}, rotation=0)));
    inner World world(                             g=0, driveTrainMechanics3D=
          true) annotation (Placement(transformation(extent={{-84,10},{-64,30}},
            rotation=0)));
    Forces.Torque torque
      annotation (Placement(transformation(extent={{50,40},{70,60}}, rotation=0)));
    Blocks.Sources.Sine sine1[         3](amplitude={1,0,0}, freqHz={1,1,1})
      annotation (Placement(transformation(extent={{16,70},{36,90}}, rotation=0)));
    Parts.Rotor1D rotor1D(                             J=2,
      phi(fixed=true),
      w(fixed=true))
      annotation (Placement(transformation(extent={{50,-36},{70,-16}}, rotation=
             0)));
    Rotational.Sources.Torque torque1(useSupport=true)
      annotation (Placement(transformation(extent={{18,-36},{38,-16}}, rotation=
             0)));
    Parts.Mounting1D mounting1D
      annotation (Placement(transformation(extent={{4,-56},{24,-36}}, rotation=
              0)));
    Joints.Revolute r1(useAxisFlange=true,  n={0,1,0})
      annotation (Placement(transformation(extent={{-32,10},{-12,30}}, rotation=
             0)));
    Rotational.Sources.Position position1(useSupport=true)
      annotation (Placement(transformation(extent={{-46,60},{-26,80}}, rotation=
             0)));
    Blocks.Sources.Sine sine2(         amplitude=2, freqHz=1)
      annotation (Placement(transformation(extent={{-100,60},{-80,80}},
            rotation=0)));
    Parts.Mounting1D mounting1D1
      annotation (Placement(transformation(extent={{-60,34},{-40,54}}, rotation=
             0)));
    Joints.Revolute r2(useAxisFlange=true, n={0,1,0})
      annotation (Placement(transformation(extent={{-38,-80},{-18,-60}},
            rotation=0)));
    Rotational.Sources.Position position2(useSupport=true)
      annotation (Placement(transformation(extent={{-52,-30},{-32,-10}},
            rotation=0)));
    Parts.Mounting1D mounting1D2
      annotation (Placement(transformation(extent={{-66,-56},{-46,-36}},
            rotation=0)));
    Parts.Fixed fixed
      annotation (Placement(transformation(extent={{-86,-80},{-66,-60}},
            rotation=0)));
  equation
    connect(revolute.frame_b,bodyCylinder. frame_a) annotation (Line(
        points={{36,20},{50,20}},
        color={95,95,95},
        thickness=0.5,
        smooth=Smooth.None));
    connect(torque.frame_b,bodyCylinder. frame_b) annotation (Line(
        points={{70,50},{80,50},{80,20},{70,20}},
        color={95,95,95},
        thickness=0.5,
        smooth=Smooth.None));
    connect(sine1.y,torque. torque)
                                   annotation (Line(
        points={{37,80},{54,80},{54,62}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(torque1.flange,rotor1D.   flange_a) annotation (Line(
        points={{38,-26},{50,-26}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(mounting1D.flange_b,torque1.support)  annotation (Line(
        points={{24,-46},{28,-46},{28,-36}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(r1.frame_a,world. frame_b) annotation (Line(
        points={{-32,20},{-64,20}},
        color={95,95,95},
        thickness=0.5,
        smooth=Smooth.None));
    connect(position1.flange,r1.   axis) annotation (Line(
        points={{-26,70},{-22,70},{-22,30}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(position1.support,mounting1D1. flange_b) annotation (Line(
        points={{-36,60},{-36,44},{-40,44}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(mounting1D1.frame_a,world. frame_b) annotation (Line(
        points={{-50,34},{-50,20},{-64,20}},
        color={95,95,95},
        thickness=0.5,
        smooth=Smooth.None));
    connect(sine2.y,position1. phi_ref) annotation (Line(
        points={{-79,70},{-48,70}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(r1.frame_b,revolute. frame_a) annotation (Line(
        points={{-12,20},{16,20}},
        color={95,95,95},
        thickness=0.5,
        smooth=Smooth.None));
    connect(torque.frame_resolve,revolute. frame_a) annotation (Line(
        points={{64,60},{8,60},{8,20},{16,20}},
        color={95,95,95},
        pattern=LinePattern.Dot,
        smooth=Smooth.None));
    connect(torque.frame_a,revolute. frame_a) annotation (Line(
        points={{50,50},{8,50},{8,20},{16,20}},
        color={95,95,95},
        thickness=0.5,
        smooth=Smooth.None));
    connect(position2.flange,r2.   axis) annotation (Line(
        points={{-32,-20},{-28,-20},{-28,-60}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(position2.support,mounting1D2. flange_b) annotation (Line(
        points={{-42,-30},{-42,-46},{-46,-46}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(fixed.frame_b,r2. frame_a) annotation (Line(
        points={{-66,-70},{-38,-70}},
        color={95,95,95},
        thickness=0.5,
        smooth=Smooth.None));
    connect(fixed.frame_b,mounting1D2. frame_a) annotation (Line(
        points={{-66,-70},{-56,-70},{-56,-56}},
        color={95,95,95},
        thickness=0.5,
        smooth=Smooth.None));
    connect(sine2.y,position2. phi_ref) annotation (Line(
        points={{-79,70},{-70,70},{-70,46},{-92,46},{-92,-20},{-54,-20}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(r2.frame_b,rotor1D. frame_a) annotation (Line(
        points={{-18,-70},{60,-70},{60,-36}},
        color={95,95,95},
        thickness=0.5,
        smooth=Smooth.None));
    connect(r2.frame_b,mounting1D. frame_a) annotation (Line(
        points={{-18,-70},{14,-70},{14,-56}},
        color={95,95,95},
        thickness=0.5,
        smooth=Smooth.None));
    connect(sine1[1].y,torque1. tau) annotation (Line(
        points={{37,80},{92,80},{92,-10},{0,-10},{0,-26},{16,-26}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{
              100,100}}), graphics),
      experiment(StopTime=1.1));
  end MovingActuatedDrive;

  model GearConstraint
     extends Modelica.Icons.Example;
    Joints.GearConstraint gearConstraint(                             ratio=10)
      annotation (Placement(transformation(extent={{34,40},{54,60}}, rotation=0)));
    inner World world(                             driveTrainMechanics3D=true,
        g=0) annotation (Placement(transformation(extent={{-62,10},{-42,30}},
            rotation=0)));
    Parts.BodyCylinder cyl1(
      diameter=0.1,
      color={0,128,0},
      r={0.4,0,0}) annotation (Placement(transformation(extent={{2,40},{22,60}},
            rotation=0)));
    Parts.BodyCylinder cyl2(                             r={0.4,0,0}, diameter=
          0.2) annotation (Placement(transformation(extent={{70,40},{90,60}},
            rotation=0)));
    Forces.Torque torque1
      annotation (Placement(transformation(extent={{-26,40},{-6,60}}, rotation=
              0)));
    Blocks.Sources.Sine sine[         3](amplitude={2,0,0}, freqHz={1,1,1})
      annotation (Placement(transformation(extent={{-100,60},{-80,80}},
            rotation=0)));
    Parts.Fixed fixed
      annotation (Placement(transformation(extent={{-48,-90},{-28,-70}},
            rotation=0)));
    Rotational.Components.Inertia inertia1(
        J=cyl1.I[1, 1],
      a(fixed=false),
      phi(fixed=true),
      w(fixed=true))    annotation (Placement(transformation(extent={{-20,-40},
              {0,-20}}, rotation=0)));
    Rotational.Components.IdealGear idealGear(        ratio=10, useSupport=true)
      annotation (Placement(transformation(extent={{12,-40},{32,-20}}, rotation=
             0)));
    Rotational.Components.Inertia inertia2(        J=cyl2.I[1, 1])
      annotation (Placement(transformation(extent={{44,-40},{64,-20}}, rotation=
             0)));
    Rotational.Sources.Torque torque2(useSupport=true)
      annotation (Placement(transformation(extent={{-48,-40},{-28,-20}},
            rotation=0)));
    Parts.Mounting1D mounting1D
      annotation (Placement(transformation(extent={{-20,-70},{0,-50}}, rotation=
             0)));
  equation
    connect(world.frame_b,gearConstraint. bearing) annotation (Line(
        points={{-42,20},{44,20},{44,40}},
        color={95,95,95},
        thickness=0.5,
        smooth=Smooth.None));
    connect(cyl1.frame_b,gearConstraint. frame_a) annotation (Line(
        points={{22,50},{34,50}},
        color={95,95,95},
        thickness=0.5,
        smooth=Smooth.None));
    connect(gearConstraint.frame_b,cyl2. frame_a) annotation (Line(
        points={{54,50},{70,50}},
        color={95,95,95},
        thickness=0.5,
        smooth=Smooth.None));
    connect(torque1.frame_b,cyl1. frame_a) annotation (Line(
        points={{-6,50},{2,50}},
        color={95,95,95},
        thickness=0.5,
        smooth=Smooth.None));
    connect(torque1.frame_a,world. frame_b) annotation (Line(
        points={{-26,50},{-36,50},{-36,20},{-42,20}},
        color={95,95,95},
        thickness=0.5,
        smooth=Smooth.None));
    connect(sine.y,torque1. torque) annotation (Line(
        points={{-79,70},{-22,70},{-22,62}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(inertia1.flange_b,idealGear. flange_a) annotation (Line(
        points={{0,-30},{12,-30}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(idealGear.flange_b,inertia2. flange_a) annotation (Line(
        points={{32,-30},{44,-30}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(torque2.flange,inertia1.   flange_a) annotation (Line(
        points={{-28,-30},{-20,-30}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(sine[1].y,torque2. tau) annotation (Line(
        points={{-79,70},{-72,70},{-72,-30},{-50,-30}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(mounting1D.flange_b,idealGear.support)  annotation (Line(
        points={{0,-60},{22,-60},{22,-40}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(mounting1D.flange_b,torque2.support)  annotation (Line(
        points={{0,-60},{4,-60},{4,-48},{-38,-48},{-38,-40}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(fixed.frame_b,mounting1D. frame_a) annotation (Line(
        points={{-28,-80},{-10,-80},{-10,-70}},
        color={95,95,95},
        thickness=0.5,
        smooth=Smooth.None));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics),
      experiment(StopTime=5));
  end GearConstraint;
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
