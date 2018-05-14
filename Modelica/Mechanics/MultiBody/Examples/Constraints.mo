within Modelica.Mechanics.MultiBody.Examples;
package Constraints "Examples with constraint joints"
extends Modelica.Icons.ExamplesPackage;

  model PrismaticConstraint
    "Body attached by one spring and two prismatic joints or constrained to environment"
    extends Modelica.Icons.Example;
    parameter Boolean animation=true "True, if animation shall be enabled";

    Joints.Prismatic jointPrismatic_x(stateSelect=StateSelect.always,
      n={1,0,0},
      s(fixed=true),
      v(fixed=true))
      annotation (Placement(transformation(extent={{80,-30},{60,-10}})));
    Joints.Prismatic jointPrismatic_y(stateSelect=StateSelect.always,
      n={0,1,0},
      s(fixed=true),
      v(fixed=true))
      annotation (Placement(transformation(extent={{40,-30},{20,-10}})));
    Joints.Constraints.Prismatic constraint(x_locked=false, y_locked=
          false)
      annotation (Placement(transformation(extent={{60,10},{40,30}})));
    Modelica.Mechanics.MultiBody.Sensors.RelativeSensor sensorConstraintRelative(
      resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_a,
      get_r_rel=true,
      get_a_rel=false,
      get_angles=true)
      annotation (Placement(transformation(extent={{60,60},{40,40}})));
    Modelica.Mechanics.MultiBody.Parts.BodyShape bodyOfJoint(
      m=1,
      I_11=1,
      I_22=1,
      I_33=1,
      r={0.4,0,0},
      r_CM={0.2,0,0},
      width=0.05,
      r_0(start={0.2,-0.5,0.1}, each fixed=false),
      v_0(each fixed=false),
      angles_fixed=false,
      w_0_fixed=false,
      angles_start={0.17453292519943,0.95993108859688,1.1868238913561},
      final color={0,0,255})
      annotation (Placement(transformation(extent={{-10,10},{10,-10}},rotation=180,
          origin={-10,-20})));
    Modelica.Mechanics.MultiBody.Parts.BodyShape bodyOfConstraint(
      I_11=1,
      I_22=1,
      I_33=1,
      width=0.05,
      w_0_fixed=false,
      final color={0,128,0},
      r=bodyOfJoint.r,
      r_CM=bodyOfJoint.r_CM,
      m=bodyOfJoint.m,
      angles_fixed=false,
      angles_start={0.17453292519943,0.95993108859688,1.1868238913561})
      annotation (Placement(transformation(extent={{-10,10},{10,-10}},rotation=180,
          origin={-10,20})));
    Modelica.Mechanics.MultiBody.Forces.Spring springOfJoint(
      c=20,
      s_unstretched=0,
      width=0.1,
      coilWidth=0.005,
      numberOfWindings=5) annotation (Placement(transformation(
          origin={-50,-20},
          extent={{-10,-10},{10,10}})));
    Modelica.Mechanics.MultiBody.Forces.Spring springOfConstraint(
      width=0.1,
      coilWidth=0.005,
      c=springOfJoint.c,
      s_unstretched=springOfJoint.s_unstretched,
      numberOfWindings=springOfJoint.numberOfWindings)
                          annotation (Placement(transformation(
          origin={-50,20},
          extent={{-10,-10},{10,10}})));
    inner Modelica.Mechanics.MultiBody.World world annotation (Placement(
          transformation(extent={{-100,-100},{-80,-80}})));
    Modelica.Mechanics.MultiBody.Parts.FixedRotation fixedRotation(
      r={0.2,-0.3,0.2},
      rotationType=Modelica.Mechanics.MultiBody.Types.RotationTypes.PlanarRotationSequence,
      angles={10,55,68})
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=90,
          origin={90,-50})));

    Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation(animation=
         false, r={0.8,0,0.3})
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
  rotation=90,
          origin={-70,-50})));
    Joints.FreeMotionScalarInit freeMotionScalarInit(
      use_r=true,
      use_v=true,
      v_rel_a_2(fixed=true, start=0),
      v_rel_a_3(fixed=true, start=0),
      use_w=true,
      w_rel_b_1(fixed=false),
      w_rel_b_2(fixed=false),
      w_rel_b_3(fixed=false),
      angle_d_3(fixed=false),
      r_rel_a_2(fixed=true, start=0),
      r_rel_a_3(fixed=true, start=0),
      angle_1(fixed=false))
      annotation (Placement(transformation(extent={{60,70},{40,90}})));
  equation
    connect(fixedTranslation.frame_a, world.frame_b)
      annotation (Line(
        points={{-70,-60},{-70,-90},{-80,-90}},
        color={95,95,95},
        thickness=0.5));
    connect(bodyOfConstraint.frame_b, springOfConstraint.frame_b)
                                           annotation (Line(
        points={{-20,20},{-40,20}},
        color={95,95,95},
        thickness=0.5));
    connect(world.frame_b, fixedRotation.frame_a) annotation (Line(
        points={{-80,-90},{90,-90},{90,-60}},
        color={95,95,95},
        thickness=0.5));
    connect(fixedRotation.frame_b, constraint.frame_a) annotation (Line(
        points={{90,-40},{90,20},{60,20}},
        color={95,95,95},
        thickness=0.5));
    connect(constraint.frame_a,sensorConstraintRelative. frame_a)
                                                        annotation (Line(
        points={{60,20},{70,20},{70,50},{60,50}},
        color={95,95,95},
        thickness=0.5));
    connect(bodyOfJoint.frame_b, springOfJoint.frame_b)
                                           annotation (Line(
        points={{-20,-20},{-40,-20}},
        color={95,95,95},
        thickness=0.5));
    connect(sensorConstraintRelative.frame_b, constraint.frame_b) annotation (
        Line(
        points={{40,50},{30,50},{30,20},{40,20}},
        color={95,95,95},
        thickness=0.5));
    connect(fixedTranslation.frame_b, springOfJoint.frame_a)
                                                annotation (Line(
        points={{-70,-40},{-70,-20},{-60,-20}},
        color={95,95,95},
        thickness=0.5));
    connect(fixedTranslation.frame_b, springOfConstraint.frame_a)
                                                     annotation (Line(
        points={{-70,-40},{-70,20},{-60,20}},
        color={95,95,95},
        thickness=0.5));
    connect(bodyOfConstraint.frame_a, constraint.frame_b) annotation (Line(
        points={{0,20},{40,20}},
        color={95,95,95},
        thickness=0.5));
    connect(jointPrismatic_x.frame_b, jointPrismatic_y.frame_a)
                                                    annotation (Line(
        points={{60,-20},{40,-20}},
        color={95,95,95},
        thickness=0.5));
    connect(fixedRotation.frame_b, jointPrismatic_x.frame_a) annotation (Line(
        points={{90,-40},{90,-20},{80,-20}},
        color={95,95,95},
        thickness=0.5));
    connect(bodyOfJoint.frame_a, jointPrismatic_y.frame_b) annotation (Line(
        points={{0,-20},{20,-20}},
        color={95,95,95},
        thickness=0.5));
    connect(freeMotionScalarInit.frame_a, fixedRotation.frame_b) annotation (
        Line(
        points={{60,80},{90,80},{90,-40}},
        color={95,95,95},
        thickness=0.5));
    connect(freeMotionScalarInit.frame_b, bodyOfConstraint.frame_a) annotation (
       Line(
        points={{40,80},{10,80},{10,20},{0,20}},
        color={95,95,95},
        thickness=0.5));
    annotation (
      experiment(StopTime=10),
      Documentation(info="<html>
<p>This example demonstrates the functionality of <strong>constraint</strong> representing <strong>prismatic joint</strong>. Each of two bodies is at one of its end connected by spring to the world. The other end is also connected to the world either by two serial coupled prismatic joints or by appropriate constraint. Therefore, the body can only perform translation in two directions specified in the two joints depending on working forces.</p>
<p><strong>Simulation results</strong></p>
<p>After simulating the model, see the animation of the multibody system and compare movement of body connected by joint (blue colored) with movement of that one connected by constraint (of green color). Additionally, the outputs from <code>sensorConstraintRelative</code> depict both position and angle deviations in the constraining element.</p>
</html>"));
  end PrismaticConstraint;

  model RevoluteConstraint
    "Body attached by one spring and revolute joint or constrained to environment"
    extends Modelica.Icons.Example;
    parameter Boolean animation=true "= true, if animation shall be enabled";
    Modelica.Mechanics.MultiBody.Joints.Revolute joint(stateSelect=StateSelect.always,
      n={0,1,0},
      phi(fixed=true),
      w(fixed=true))
      annotation (Placement(transformation(extent={{60,-30},{40,-10}})));
    Joints.Constraints.Revolute constraint(n=joint.n)
      annotation (Placement(transformation(extent={{60,10},{40,30}})));
    Modelica.Mechanics.MultiBody.Sensors.RelativeSensor sensorConstraintRelative(
      resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_a,
      get_r_rel=true,
      get_a_rel=false,
      get_angles=true)
      annotation (Placement(transformation(extent={{60,60},{40,40}})));
    Modelica.Mechanics.MultiBody.Parts.BodyShape bodyOfJoint(
      m=1,
      I_11=1,
      I_22=1,
      I_33=1,
      r={0.4,0,0},
      r_CM={0.2,0,0},
      width=0.05,
      r_0(start={0.2,-0.5,0.1}, each fixed=false),
      v_0(each fixed=false),
      angles_fixed=false,
      w_0_fixed=false,
      angles_start={0.17453292519943,0.95993108859688,1.1868238913561},
      final color={0,0,255})
      annotation (Placement(transformation(extent={{-10,10},{10,-10}},rotation=180,
          origin={-10,-20})));
    Modelica.Mechanics.MultiBody.Parts.BodyShape bodyOfConstraint(
      I_11=1,
      I_22=1,
      I_33=1,
      width=0.05,
      r_0(start={0.2,-0.5,0.1}, each fixed=false),
      v_0(each fixed=false),
      angles_fixed=false,
      w_0_fixed=false,
      final color={0,128,0},
      r=bodyOfJoint.r,
      r_CM=bodyOfJoint.r_CM,
      m=bodyOfJoint.m,
      angles_start={0.17453292519943,0.95993108859688,1.1868238913561})
      annotation (Placement(transformation(extent={{-10,10},{10,-10}},rotation=180,
          origin={-10,20})));
    Modelica.Mechanics.MultiBody.Forces.Spring springOfJoint(
      c=20,
      s_unstretched=0,
      width=0.1,
      coilWidth=0.005,
      numberOfWindings=5) annotation (Placement(transformation(
          origin={-50,-20},
          extent={{-10,-10},{10,10}})));
    Modelica.Mechanics.MultiBody.Forces.Spring springOfConstraint(
      width=0.1,
      coilWidth=0.005,
      c=springOfJoint.c,
      s_unstretched=springOfJoint.s_unstretched,
      numberOfWindings=springOfJoint.numberOfWindings)
                          annotation (Placement(transformation(
          origin={-50,20},
          extent={{-10,-10},{10,10}})));
    inner Modelica.Mechanics.MultiBody.World world annotation (Placement(
          transformation(extent={{-100,-100},{-80,-80}})));
    Modelica.Mechanics.MultiBody.Parts.FixedRotation fixedRotation(
      r={0.2,-0.3,0.2},
      rotationType=Modelica.Mechanics.MultiBody.Types.RotationTypes.PlanarRotationSequence,
      angles={10,55,68})
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=90,
          origin={90,-50})));

    Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation(animation=
         false, r={0.8,0,0.3})
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
  rotation=90,
          origin={-70,-50})));
    Joints.FreeMotionScalarInit freeMotionScalarInit(
      use_angle=true,
      use_angle_d=true,
      angle_2(start=0, fixed=true),
      angle_d_2(start=0, fixed=true))
      annotation (Placement(transformation(extent={{60,70},{40,90}})));
  equation
    connect(fixedTranslation.frame_a, world.frame_b)
      annotation (Line(
        points={{-70,-60},{-70,-90},{-80,-90}},
        color={95,95,95},
        thickness=0.5));
    connect(bodyOfConstraint.frame_b, springOfConstraint.frame_b)
                                           annotation (Line(
        points={{-20,20},{-40,20}},
        color={95,95,95},
        thickness=0.5));
    connect(world.frame_b, fixedRotation.frame_a) annotation (Line(
        points={{-80,-90},{90,-90},{90,-60}},
        color={95,95,95},
        thickness=0.5));
    connect(fixedRotation.frame_b, constraint.frame_a) annotation (Line(
        points={{90,-40},{90,20},{60,20}},
        color={95,95,95},
        thickness=0.5));
    connect(constraint.frame_a,sensorConstraintRelative. frame_a)
                                                        annotation (Line(
        points={{60,20},{70,20},{70,50},{60,50}},
        color={95,95,95},
        thickness=0.5));
    connect(bodyOfJoint.frame_b, springOfJoint.frame_b)
                                           annotation (Line(
        points={{-20,-20},{-40,-20}},
        color={95,95,95},
        thickness=0.5));
    connect(joint.frame_b, bodyOfJoint.frame_a) annotation (
        Line(
        points={{40,-20},{0,-20}},
        color={95,95,95},
        thickness=0.5));
    connect(sensorConstraintRelative.frame_b, constraint.frame_b) annotation (
        Line(
        points={{40,50},{30,50},{30,20},{40,20}},
        color={95,95,95},
        thickness=0.5));
    connect(fixedTranslation.frame_b, springOfJoint.frame_a)
                                                annotation (Line(
        points={{-70,-40},{-70,-20},{-60,-20}},
        color={95,95,95},
        thickness=0.5));
    connect(fixedTranslation.frame_b, springOfConstraint.frame_a)
                                                     annotation (Line(
        points={{-70,-40},{-70,20},{-60,20}},
        color={95,95,95},
        thickness=0.5));
    connect(bodyOfConstraint.frame_a, constraint.frame_b) annotation (Line(
        points={{0,20},{40,20}},
        color={95,95,95},
        thickness=0.5));
    connect(joint.frame_a, fixedRotation.frame_b) annotation (Line(
        points={{60,-20},{90,-20},{90,-40}},
        color={95,95,95},
        thickness=0.5));
    connect(freeMotionScalarInit.frame_a, fixedRotation.frame_b) annotation (
        Line(
        points={{60,80},{90,80},{90,-40}},
        color={95,95,95},
        thickness=0.5));
    connect(bodyOfConstraint.frame_a, freeMotionScalarInit.frame_b) annotation (
       Line(
        points={{0,20},{10,20},{10,80},{40,80}},
        color={95,95,95},
        thickness=0.5));
    annotation (
      experiment(StopTime=10),
      Documentation(info="<html>
<p>This example demonstrates the functionality of <strong>constraint</strong> representing <strong>revolute joint</strong>. Each of two bodies is at one of its end connected by spring to the world. The other end is also connected to the world either by revolute joint or by appropriate constraint. Therefore, the body can only perform rotation about the revolute axis depending on working forces.</p>
<p><strong>Simulation results</strong></p>
<p>After simulating the model, see the animation of the multibody system and compare movement of body connected by joint (blue colored) with movement of that one connected by constraint (of green color). Additionally, the outputs from <code>sensorConstraintRelative</code> depict both position and angle deviations in the constraining element.</p>
</html>"));
  end RevoluteConstraint;

  model SphericalConstraint
    "Body attached by one spring and spherical joint or constrained to environment"
    extends Modelica.Icons.Example;
    parameter Boolean animation=true "= true, if animation shall be enabled";
    Joints.Spherical joint(
      angles_fixed=true,
      w_rel_a_fixed=true,
      enforceStates=true)
      annotation (Placement(transformation(extent={{60,-30},{40,-10}})));
    Joints.Constraints.Spherical constraint
      annotation (Placement(transformation(extent={{60,10},{40,30}})));
    Modelica.Mechanics.MultiBody.Sensors.RelativeSensor sensorConstraintRelative(
      resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_a,
      get_r_rel=true,
      get_a_rel=false,
      get_angles=true)
      annotation (Placement(transformation(extent={{60,60},{40,40}})));
    Modelica.Mechanics.MultiBody.Parts.BodyShape bodyOfJoint(
      m=1,
      I_11=1,
      I_22=1,
      I_33=1,
      r={0.4,0,0},
      r_CM={0.2,0,0},
      width=0.05,
      r_0(start={0.2,-0.5,0.1}, each fixed=false),
      v_0(each fixed=false),
      angles_fixed=false,
      w_0_fixed=false,
      angles_start={0.17453292519943,0.95993108859688,1.1868238913561},
      final color={0,0,255})
      annotation (Placement(transformation(extent={{-10,10},{10,-10}},rotation=180,
          origin={-10,-20})));
    Modelica.Mechanics.MultiBody.Parts.BodyShape bodyOfConstraint(
      I_11=1,
      I_22=1,
      I_33=1,
      width=0.05,
      r_0(start={0.2,-0.5,0.1}, each fixed=false),
      v_0(each fixed=false),
      angles_fixed=false,
      w_0_fixed=false,
      final color={0,128,0},
      r=bodyOfJoint.r,
      r_CM=bodyOfJoint.r_CM,
      m=bodyOfJoint.m,
      angles_start={0.17453292519943,0.95993108859688,1.1868238913561})
      annotation (Placement(transformation(extent={{-10,10},{10,-10}},rotation=180,
          origin={-10,20})));
    Modelica.Mechanics.MultiBody.Forces.Spring springOfJoint(
      c=20,
      s_unstretched=0,
      width=0.1,
      coilWidth=0.005,
      numberOfWindings=5) annotation (Placement(transformation(
          origin={-50,-20},
          extent={{-10,-10},{10,10}})));
    Modelica.Mechanics.MultiBody.Forces.Spring springOfConstraint(
      width=0.1,
      coilWidth=0.005,
      c=springOfJoint.c,
      s_unstretched=springOfJoint.s_unstretched,
      numberOfWindings=springOfJoint.numberOfWindings)
                          annotation (Placement(transformation(
          origin={-50,20},
          extent={{-10,-10},{10,10}})));
    inner Modelica.Mechanics.MultiBody.World world annotation (Placement(
          transformation(extent={{-100,-100},{-80,-80}})));
    Modelica.Mechanics.MultiBody.Parts.FixedRotation fixedRotation(
      r={0.2,-0.3,0.2},
      rotationType=Modelica.Mechanics.MultiBody.Types.RotationTypes.PlanarRotationSequence,
      angles={10,55,68})
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=90,
          origin={90,-50})));

    Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation(animation=
         false, r={0.8,0,0.3})
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
  rotation=90,
          origin={-70,-50})));
    Joints.FreeMotionScalarInit freeMotionScalarInit(
      use_angle=true,
      use_angle_d=true,
      angle_1(fixed=true),
      angle_2(fixed=true),
      angle_3(fixed=true),
      angle_d_1(fixed=true),
      angle_d_2(fixed=true),
      angle_d_3(fixed=true))
      annotation (Placement(transformation(extent={{60,70},{40,90}})));
  equation
    connect(fixedTranslation.frame_a, world.frame_b)
      annotation (Line(
        points={{-70,-60},{-70,-90},{-80,-90}},
        color={95,95,95},
        thickness=0.5));
    connect(bodyOfConstraint.frame_b, springOfConstraint.frame_b)
                                           annotation (Line(
        points={{-20,20},{-40,20}},
        color={95,95,95},
        thickness=0.5));
    connect(world.frame_b, fixedRotation.frame_a) annotation (Line(
        points={{-80,-90},{90,-90},{90,-60}},
        color={95,95,95},
        thickness=0.5));
    connect(fixedRotation.frame_b, constraint.frame_a) annotation (Line(
        points={{90,-40},{90,20},{60,20}},
        color={95,95,95},
        thickness=0.5));
    connect(constraint.frame_a,sensorConstraintRelative. frame_a)
                                                        annotation (Line(
        points={{60,20},{70,20},{70,50},{60,50}},
        color={95,95,95},
        thickness=0.5));
    connect(bodyOfJoint.frame_b, springOfJoint.frame_b)
                                           annotation (Line(
        points={{-20,-20},{-40,-20}},
        color={95,95,95},
        thickness=0.5));
    connect(joint.frame_b, bodyOfJoint.frame_a) annotation (
        Line(
        points={{40,-20},{0,-20}},
        color={95,95,95},
        thickness=0.5));
    connect(sensorConstraintRelative.frame_b, constraint.frame_b) annotation (
        Line(
        points={{40,50},{30,50},{30,20},{40,20}},
        color={95,95,95},
        thickness=0.5));
    connect(fixedTranslation.frame_b, springOfJoint.frame_a)
                                                annotation (Line(
        points={{-70,-40},{-70,-20},{-60,-20}},
        color={95,95,95},
        thickness=0.5));
    connect(fixedTranslation.frame_b, springOfConstraint.frame_a)
                                                     annotation (Line(
        points={{-70,-40},{-70,20},{-60,20}},
        color={95,95,95},
        thickness=0.5));
    connect(bodyOfConstraint.frame_a, constraint.frame_b) annotation (Line(
        points={{0,20},{40,20}},
        color={95,95,95},
        thickness=0.5));
    connect(joint.frame_a, fixedRotation.frame_b) annotation (Line(
        points={{60,-20},{90,-20},{90,-40}},
        color={95,95,95},
        thickness=0.5));
    connect(bodyOfConstraint.frame_a, freeMotionScalarInit.frame_b) annotation (
       Line(
        points={{0,20},{10,20},{10,80},{40,80}},
        color={95,95,95},
        thickness=0.5));
    connect(freeMotionScalarInit.frame_a, fixedRotation.frame_b) annotation (
        Line(
        points={{60,80},{90,80},{90,-40}},
        color={95,95,95},
        thickness=0.5));
    annotation (
      experiment(StopTime=10),
      Documentation(info="<html>
<p>This example demonstrates the functionality of <strong>constraint</strong> representing <strong>spherical joint</strong>. Each of two bodies is at one of its end connected by spring to the world. The other end is also connected to the world either by spherical joint or by appropriate constraint. Therefore, the body can only perform spherical movement depending on working forces.</p>
<p><strong>Simulation results</strong></p>
<p>After simulating the model, see the animation of the multibody system and compare movement of body connected by joint (blue colored) with movement of that one connected by constraint (of green color). Additionally, the outputs from <code>sensorConstraintRelative</code> depict position deviations in the constraining element.</p>
</html>"));
  end SphericalConstraint;

  model UniversalConstraint
    "Body attached by one spring and universal joint or constrained to environment"
    extends Modelica.Icons.Example;
    parameter Boolean animation=true "= true, if animation shall be enabled";
    Joints.Universal joint(
      n_a={0,0,1},
      n_b={1,0,0},
      stateSelect=StateSelect.always,
      phi_a(fixed=true),
      phi_b(fixed=true),
      w_a(fixed=true),
      w_b(fixed=true))
      annotation (Placement(transformation(extent={{60,-30},{40,-10}})));
    Joints.Constraints.Universal constraint(n_a=joint.n_a, n_b=joint.n_b)
      annotation (Placement(transformation(extent={{60,10},{40,30}})));
    Modelica.Mechanics.MultiBody.Sensors.RelativeSensor sensorConstraintRelative(
      resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_a,
      get_r_rel=true,
      get_a_rel=false,
      get_angles=true,
      sequence={3,2,1})
      annotation (Placement(transformation(extent={{60,60},{40,40}})));
    Modelica.Mechanics.MultiBody.Parts.BodyShape bodyOfJoint(
      m=1,
      I_11=1,
      I_22=1,
      I_33=1,
      r={0.4,0,0},
      r_CM={0.2,0,0},
      width=0.05,
      r_0(start={0.2,-0.5,0.1}, each fixed=false),
      v_0(each fixed=false),
      angles_fixed=false,
      w_0_fixed=false,
      angles_start={0.17453292519943,0.95993108859688,1.1868238913561},
      final color={0,0,255})
      annotation (Placement(transformation(extent={{-10,10},{10,-10}},rotation=180,
          origin={10,-20})));
    Modelica.Mechanics.MultiBody.Parts.BodyShape bodyOfConstraint(
      I_11=1,
      I_22=1,
      I_33=1,
      width=0.05,
      r_0(start={0.2,-0.5,0.1}, each fixed=false),
      v_0(each fixed=false),
      angles_fixed=false,
      w_0_fixed=false,
      final color={0,128,0},
      r=bodyOfJoint.r,
      r_CM=bodyOfJoint.r_CM,
      m=bodyOfJoint.m,
      angles_start={0.17453292519943,0.95993108859688,1.1868238913561})
      annotation (Placement(transformation(extent={{-10,10},{10,-10}},rotation=180,
          origin={10,20})));
    Modelica.Mechanics.MultiBody.Forces.Spring springOfJoint(
      c=20,
      s_unstretched=0,
      width=0.1,
      coilWidth=0.005,
      numberOfWindings=5) annotation (Placement(transformation(
          origin={-50,-20},
          extent={{-10,-10},{10,10}})));
    Modelica.Mechanics.MultiBody.Forces.Spring springOfConstraint(
      width=0.1,
      coilWidth=0.005,
      c=springOfJoint.c,
      s_unstretched=springOfJoint.s_unstretched,
      numberOfWindings=springOfJoint.numberOfWindings)
                          annotation (Placement(transformation(
          origin={-50,20},
          extent={{-10,-10},{10,10}})));
    inner Modelica.Mechanics.MultiBody.World world annotation (Placement(
          transformation(extent={{-100,-100},{-80,-80}})));
    Modelica.Mechanics.MultiBody.Parts.FixedRotation fixedRotation(
      r={0.2,-0.3,0.2},
      rotationType=Modelica.Mechanics.MultiBody.Types.RotationTypes.PlanarRotationSequence,
      angles={10,55,68})
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=90,
          origin={90,-50})));

    Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation(animation=
         false, r={0.8,0,0.3})
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
  rotation=90,
          origin={-70,-50})));
    Parts.FixedTranslation fixedTranslationOfJoint(r={0.1,0.15,0.2})
      annotation (Placement(transformation(extent={{-10,-30},{-30,-10}})));
    Parts.FixedTranslation fixedTranslationOfConstraint(r=fixedTranslationOfJoint.r)
      annotation (Placement(transformation(extent={{-10,10},{-30,30}})));
    Joints.FreeMotionScalarInit freeMotionScalarInit(
      use_angle=true,
      use_angle_d=true,
      angle_1(fixed=true),
      angle_3(fixed=true),
      angle_d_1(fixed=true),
      angle_d_3(fixed=true),
      sequence_start={1,2,3})
      annotation (Placement(transformation(extent={{60,70},{40,90}})));
  equation
    connect(fixedTranslation.frame_a, world.frame_b)
      annotation (Line(
        points={{-70,-60},{-70,-90},{-80,-90}},
        color={95,95,95},
        thickness=0.5));
    connect(world.frame_b, fixedRotation.frame_a) annotation (Line(
        points={{-80,-90},{90,-90},{90,-60}},
        color={95,95,95},
        thickness=0.5));
    connect(fixedRotation.frame_b, constraint.frame_a) annotation (Line(
        points={{90,-40},{90,20},{60,20}},
        color={95,95,95},
        thickness=0.5));
    connect(constraint.frame_a,sensorConstraintRelative. frame_a)
                                                        annotation (Line(
        points={{60,20},{70,20},{70,50},{60,50}},
        color={95,95,95},
        thickness=0.5));
    connect(joint.frame_b, bodyOfJoint.frame_a) annotation (
        Line(
        points={{40,-20},{20,-20}},
        color={95,95,95},
        thickness=0.5));
    connect(fixedTranslation.frame_b, springOfJoint.frame_a)
                                                annotation (Line(
        points={{-70,-40},{-70,-20},{-60,-20}},
        color={95,95,95},
        thickness=0.5));
    connect(fixedTranslation.frame_b, springOfConstraint.frame_a)
                                                     annotation (Line(
        points={{-70,-40},{-70,20},{-60,20}},
        color={95,95,95},
        thickness=0.5));
    connect(bodyOfConstraint.frame_a, constraint.frame_b) annotation (Line(
        points={{20,20},{40,20}},
        color={95,95,95},
        thickness=0.5));
    connect(joint.frame_a, fixedRotation.frame_b) annotation (Line(
        points={{60,-20},{90,-20},{90,-40}},
        color={95,95,95},
        thickness=0.5));
    connect(bodyOfJoint.frame_b, fixedTranslationOfJoint.frame_a) annotation (
        Line(
        points={{0,-20},{-10,-20}},
        color={95,95,95},
        thickness=0.5));
    connect(bodyOfConstraint.frame_b, fixedTranslationOfConstraint.frame_a)
      annotation (Line(
        points={{0,20},{-10,20}},
        color={95,95,95},
        thickness=0.5));
    connect(springOfJoint.frame_b, fixedTranslationOfJoint.frame_b) annotation (
        Line(
        points={{-40,-20},{-30,-20}},
        color={95,95,95},
        thickness=0.5));
    connect(springOfConstraint.frame_b, fixedTranslationOfConstraint.frame_b)
      annotation (Line(
        points={{-40,20},{-30,20}},
        color={95,95,95},
        thickness=0.5));
    connect(fixedRotation.frame_b, freeMotionScalarInit.frame_a) annotation (
        Line(
        points={{90,-40},{90,80},{60,80}},
        color={95,95,95},
        thickness=0.5));
    connect(bodyOfConstraint.frame_a, freeMotionScalarInit.frame_b) annotation (
       Line(
        points={{20,20},{30,20},{30,80},{40,80}},
        color={95,95,95},
        thickness=0.5));
    connect(bodyOfConstraint.frame_a, sensorConstraintRelative.frame_b) annotation (Line(
        points={{20,20},{30,20},{30,50},{40,50}},
        color={95,95,95},
        thickness=0.5));
    annotation (
      experiment(StopTime=10),
      Documentation(info="<html>
<p>This example demonstrates the functionality of <strong>constraint</strong> representing <strong>universal joint</strong>. Each of two bodies is at one of its end connected by spring to the world. The other end is also connected to the world either by universal joint or by appropriate constraint. Therefore, the body can only perform rotation about two revolute axes depending on working forces.</p>
<p><strong>Simulation results</strong></p>
<p>After simulating the model, see the animation of the multibody system and compare movement of body connected by joint (blue colored) with movement of that one connected by constraint (of green color). Additionally, the outputs from <code>sensorConstraintRelative</code> depict position deviations in the constraining element.</p>
</html>"));
  end UniversalConstraint;
  annotation (Documentation(info="<html>
<p>
This package is a collection of simulatable models involving constraints in a multibody system.
The examples mainly show comparison of constraints to the standard joints.
</p>
</html>"));
end Constraints;
