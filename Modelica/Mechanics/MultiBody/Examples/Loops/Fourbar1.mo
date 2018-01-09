within Modelica.Mechanics.MultiBody.Examples.Loops;
model Fourbar1
  "One kinematic loop with four bars (with only revolute joints; 5 non-linear equations)"
  extends Modelica.Icons.Example;

  output SI.Angle j1_phi "angle of revolute joint j1";
  output SI.Position j2_s "distance of prismatic joint j2";
  output SI.AngularVelocity j1_w "axis speed of revolute joint j1";
  output SI.Velocity j2_v "axis velocity of prismatic joint j2";

  inner Modelica.Mechanics.MultiBody.World world annotation (Placement(
        transformation(extent={{-100,-80},{-80,-60}})));
  Modelica.Mechanics.MultiBody.Joints.Revolute j1(
    n={1,0,0},
    stateSelect=StateSelect.always,
    phi(fixed=true),
    w(displayUnit="deg/s",
      start=5.235987755982989,
      fixed=true))
    annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
  Modelica.Mechanics.MultiBody.Joints.Prismatic j2(
    n={1,0,0},
    s(start=-0.2),
    boxWidth=0.05) annotation (Placement(transformation(extent={{10,-80},{30,-60}})));
  Modelica.Mechanics.MultiBody.Parts.BodyCylinder b1(r={0,0.5,0.1}, diameter=0.05)
    annotation (Placement(transformation(
        origin={-30,-20},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Mechanics.MultiBody.Parts.BodyCylinder b2(r={0,0.2,0}, diameter=0.05)
    annotation (Placement(transformation(
        origin={50,-50},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Mechanics.MultiBody.Parts.BodyCylinder b3(r={-1,0.3,0.1}, diameter=0.05)
    annotation (Placement(transformation(extent={{80,50},{60,70}})));
  Modelica.Mechanics.MultiBody.Joints.Revolute rev(n={0,1,0})
    annotation (Placement(transformation(
        origin={50,-20},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Mechanics.MultiBody.Joints.Revolute rev1 annotation (Placement(
        transformation(extent={{60,0},{80,20}})));
  Modelica.Mechanics.MultiBody.Joints.Revolute j3(n={1,0,0}) annotation (Placement(
        transformation(extent={{-50,30},{-30,50}})));
  Modelica.Mechanics.MultiBody.Joints.Revolute j4(n={0,1,0}) annotation (Placement(
        transformation(extent={{-10,40},{10,60}})));
  Modelica.Mechanics.MultiBody.Joints.Revolute j5(n={0,0,1}) annotation (Placement(
        transformation(extent={{30,50},{50,70}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation b0(animation=false, r={1.2,0,0})
    annotation (Placement(transformation(extent={{-30,-80},{-10,-60}})));
equation
  connect(j2.frame_b, b2.frame_a) annotation (Line(
      points={{30,-70},{50,-70},{50,-60}},
      color={95,95,95},
      thickness=0.5));
  connect(j1.frame_b, b1.frame_a) annotation (Line(
      points={{-40,-40},{-30,-40},{-30,-30}},
      color={95,95,95},
      thickness=0.5));
  connect(rev.frame_a, b2.frame_b)
    annotation (Line(
      points={{50,-30},{50,-40}},
      color={95,95,95},
      thickness=0.5));
  connect(rev.frame_b, rev1.frame_a)
    annotation (Line(
      points={{50,-10},{50,10},{60,10}},
      color={95,95,95},
      thickness=0.5));
  connect(rev1.frame_b, b3.frame_a) annotation (Line(
      points={{80,10},{90,10},{90,60},{80,60}},
      color={95,95,95},
      thickness=0.5));
  connect(world.frame_b, j1.frame_a) annotation (Line(
      points={{-80,-70},{-70,-70},{-70,-40},{-60,-40}},
      color={95,95,95},
      thickness=0.5));
  connect(b1.frame_b, j3.frame_a) annotation (Line(
      points={{-30,-10},{-30,10},{-60,10},{-60,40},{-50,40}},
      color={95,95,95},
      thickness=0.5));
  connect(j3.frame_b, j4.frame_a) annotation (Line(
      points={{-30,40},{-20,40},{-20,50},{-10,50}},
      color={95,95,95},
      thickness=0.5));
  connect(j4.frame_b, j5.frame_a)
    annotation (Line(
      points={{10,50},{20,50},{20,60},{30,60}},
      color={95,95,95},
      thickness=0.5));
  connect(j5.frame_b, b3.frame_b) annotation (Line(
      points={{50,60},{60,60}},
      color={95,95,95},
      thickness=0.5));
  connect(b0.frame_a, world.frame_b)
    annotation (Line(
      points={{-30,-70},{-80,-70}},
      color={95,95,95},
      thickness=0.5));
  connect(b0.frame_b, j2.frame_a)
    annotation (Line(
      points={{-10,-70},{10,-70}},
      color={95,95,95},
      thickness=0.5));
  j1_phi = j1.phi;
  j2_s = j2.s;
  j1_w = j1.w;
  j2_v = j2.v;
  annotation (
    experiment(StopTime=5),
    Documentation(info="<html>
<p>
This is a simple kinematic loop consisting of 6 revolute joints, 1 prismatic joint
and 4 bars that is often used as basic constructing unit in mechanisms.
This example demonstrates that usually no particular knowledge
of the user is needed to handle kinematic loops.
Just connect the joints and bodies together according
to the real system. In particular <strong>no</strong> cut-joints or a spanning tree has
to be determined. In this case, the initial condition of the angular velocity
of revolute joint j1 is set to 300 deg/s in order to drive this loop.
</p>

<IMG src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Loops/Fourbar1.png\" ALT=\"model Examples.Loops.Fourbar1\">
</html>"));
end Fourbar1;
