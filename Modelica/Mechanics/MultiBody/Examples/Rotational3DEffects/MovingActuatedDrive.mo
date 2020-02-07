within Modelica.Mechanics.MultiBody.Examples.Rotational3DEffects;
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
        transformation(extent={{-80,10},{-60,30}})));
  Forces.Torque torque annotation (Placement(transformation(extent={{50,30},{70,50}})));
  Blocks.Sources.Sine sine1[3](amplitude={1,0,0}, f={1,1,1}) annotation (
     Placement(transformation(extent={{16,70},{36,90}})));
  Parts.Rotor1D rotor1D(
    J=2,
    phi(fixed=true),
    w(fixed=true)) annotation (Placement(transformation(extent={{50,-40},{70,-20}})));
  Rotational.Sources.Torque torque1(useSupport=true) annotation (Placement(
        transformation(extent={{20,-40},{40,-20}})));
  Parts.Mounting1D mounting1D annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
  Joints.Revolute r1(useAxisFlange=true, n={0,1,0}) annotation (Placement(
        transformation(extent={{-30,10},{-10,30}})));
  Rotational.Sources.Position position1(useSupport=true, w(fixed=true))
    annotation (Placement(transformation(extent={{-50,70},{-30,90}})));
  Blocks.Sources.Sine sine2(amplitude=2, f=1) annotation (Placement(
        transformation(extent={{-100,70},{-80,90}})));
  Parts.Mounting1D mounting1D1(n={0,1,0})
                               annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  Joints.Revolute r2(useAxisFlange=true, n={0,1,0}) annotation (Placement(
        transformation(extent={{-30,-80},{-10,-60}})));
  Rotational.Sources.Position position2(useSupport=true, w(fixed=true))
    annotation (Placement(transformation(extent={{-50,-40},{-30,-20}})));
  Parts.Mounting1D mounting1D2(n={0,1,0})
                               annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
  Parts.Fixed fixed annotation (Placement(transformation(extent={{-90,-80},{-70,-60}})));
equation
  connect(revolute.frame_b, bodyCylinder.frame_a) annotation (Line(
      points={{36,20},{50,20}},
      color={95,95,95},
      thickness=0.5));
  connect(torque.frame_b, bodyCylinder.frame_b) annotation (Line(
      points={{70,40},{80,40},{80,20},{70,20}},
      color={95,95,95},
      thickness=0.5));
  connect(sine1.y, torque.torque) annotation (Line(
      points={{37,80},{54,80},{54,52}}, color={0,0,127}));
  connect(torque1.flange, rotor1D.flange_a) annotation (Line(
      points={{40,-30},{50,-30}}));
  connect(mounting1D.flange_b, torque1.support) annotation (Line(
      points={{20,-50},{30,-50},{30,-40}}));
  connect(r1.frame_a, world.frame_b) annotation (Line(
      points={{-30,20},{-60,20}},
      color={95,95,95},
      thickness=0.5));
  connect(position1.flange, r1.axis) annotation (Line(
      points={{-30,80},{-20,80},{-20,30}}));
  connect(position1.support, mounting1D1.flange_b) annotation (Line(
      points={{-40,70},{-40,50}}));
  connect(mounting1D1.frame_a, world.frame_b) annotation (Line(
      points={{-50,40},{-50,20},{-60,20}},
      color={95,95,95},
      thickness=0.5));
  connect(sine2.y, position1.phi_ref) annotation (Line(
      points={{-79,80},{-52,80}}, color={0,0,127}));
  connect(r1.frame_b, revolute.frame_a) annotation (Line(
      points={{-10,20},{16,20}},
      color={95,95,95},
      thickness=0.5));
  connect(torque.frame_a, revolute.frame_a) annotation (Line(
      points={{50,40},{0,40},{0,20},{16,20}},
      color={95,95,95},
      thickness=0.5));
  connect(position2.flange, r2.axis) annotation (Line(
      points={{-30,-30},{-20,-30},{-20,-60}}));
  connect(position2.support, mounting1D2.flange_b) annotation (Line(
      points={{-40,-40},{-40,-50}}));
  connect(fixed.frame_b, r2.frame_a) annotation (Line(
      points={{-70,-70},{-30,-70}},
      color={95,95,95},
      thickness=0.5));
  connect(fixed.frame_b, mounting1D2.frame_a) annotation (Line(
      points={{-70,-70},{-50,-70},{-50,-60}},
      color={95,95,95},
      thickness=0.5));
  connect(sine2.y, position2.phi_ref) annotation (Line(
      points={{-79,80},{-70,80},{-70,50},{-90,50},{-90,-30},{-52,-30}}, color={0,0,127}));
  connect(r2.frame_b, rotor1D.frame_a) annotation (Line(
      points={{-10,-70},{60,-70},{60,-40}},
      color={95,95,95},
      thickness=0.5));
  connect(r2.frame_b, mounting1D.frame_a) annotation (Line(
      points={{-10,-70},{10,-70},{10,-60}},
      color={95,95,95},
      thickness=0.5));
  connect(sine1[1].y, torque1.tau) annotation (Line(
      points={{37,80},{90,80},{90,-10},{10,-10},{10,-30},{18,-30}},
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
