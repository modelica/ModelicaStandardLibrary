within Modelica.Mechanics.MultiBody.Examples.Loops;
model Fourbar_analytic
  "One kinematic loop with four bars (with JointSSP joint; analytic solution of non-linear algebraic loop)"
  extends Modelica.Icons.Example;

  output SI.Angle j1_phi "Angle of revolute joint j1";
  output SI.Position j2_s "Distance of prismatic joint j2";
  output SI.AngularVelocity j1_w "Axis speed of revolute joint j1";
  output SI.Velocity j2_v "Axis velocity of prismatic joint j2";

  inner Modelica.Mechanics.MultiBody.World world(animateGravity=false)
    annotation (Placement(transformation(extent={{-100,-70},{-80,-50}})));
  Modelica.Mechanics.MultiBody.Joints.Revolute j1(
    n={1,0,0},
    stateSelect=StateSelect.always,
    phi(fixed=true),
    useAxisFlange=false,
    w(displayUnit="deg/s",
      start=5.235987755983,
      fixed=true))
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  Modelica.Mechanics.MultiBody.Parts.BodyCylinder b1(r={0,0.5,0.1}, diameter=0.05)
    annotation (Placement(transformation(
        origin={-30,-10},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation b3(r={1.2,0,0}, animation=false)
    annotation (Placement(transformation(extent={{-60,-70},{-40,-50}})));
  Modelica.Mechanics.MultiBody.Joints.Assemblies.JointSSP jointSSP(
    rod1Length=sqrt({-1,0.3,0.1}*{-1,0.3,0.1}),
    n_b={1,0,0},
    s_offset=-0.2,
    rRod2_ib={0,0.2,0},
    rod1Color={0,128,255},
    rod2Color={0,128,255},
    checkTotalPower=true) annotation (Placement(transformation(extent={{-20,0},
            {20,40}})));
  Modelica.Mechanics.MultiBody.Parts.BodyCylinder b2(
    r={0,0.2,0},
    diameter=0.05,
    animation=false) annotation (Placement(transformation(
        origin={50,10},
        extent={{10,-10},{-10,10}},
        rotation=90)));
equation
  j1_phi = j1.phi;
  j2_s = jointSSP.prismatic.distance;
  j1_w = j1.w;
  j2_v = der(jointSSP.prismatic.distance);
  connect(j1.frame_b, b1.frame_a) annotation (Line(
      points={{-40,-30},{-30,-30},{-30,-20}},
      color={95,95,95},
      thickness=0.5));
  connect(j1.frame_a, world.frame_b) annotation (Line(
      points={{-60,-30},{-70,-30},{-70,-60},{-80,-60}},
      color={95,95,95},
      thickness=0.5));
  connect(b3.frame_a, world.frame_b)
    annotation (Line(
      points={{-60,-60},{-80,-60}},
      color={95,95,95},
      thickness=0.5));
  connect(b1.frame_b, jointSSP.frame_a) annotation (Line(
      points={{-30,0},{-30,20},{-20,20}},
      color={95,95,95},
      thickness=0.5));
  connect(b3.frame_b, jointSSP.frame_b) annotation (Line(
      points={{-40,-60},{30,-60},{30,20},{20,20}},
      color={95,95,95},
      thickness=0.5));
  connect(b2.frame_a, jointSSP.frame_ib) annotation (Line(
      points={{50,20},{50,48},{16,48},{16,40}},
      color={95,95,95},
      thickness=0.5));
  annotation (
    experiment(StopTime=5),
    Documentation(info="<html>
<p>
This is a third version of the \"four-bar\" mechanism, see figure:
</p>

<div><img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Loops/Fourbar_analytic.png\" alt=\"model Examples.Loops.Fourbar_analytic\"></div>

<p>
In this case
the three revolute joints on the left top-side and the two revolute
joints on the right top side have been replaced by the assembly joint
<strong>Joints.Assemblies.JointSSP</strong>
which consists of two spherical joints and one prismatic joint.
Since JointSSP solves the non-linear constraint equation internally
analytically, no non-linear equation appears any more and a Modelica
translator can transform the system into state space
form without solving a system of equations. For more details, see
<a href=\"modelica://Modelica.Mechanics.MultiBody.UsersGuide.Tutorial.LoopStructures.AnalyticLoopHandling\">
MultiBody.UsersGuide.Tutorial.LoopStructures.AnalyticLoopHandling</a>.
</p>
</html>"));
end Fourbar_analytic;
