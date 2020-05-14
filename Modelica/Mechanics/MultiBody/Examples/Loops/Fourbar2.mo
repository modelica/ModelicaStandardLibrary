within Modelica.Mechanics.MultiBody.Examples.Loops;
model Fourbar2
  "One kinematic loop with four bars (with UniversalSpherical joint; 1 non-linear equation)"
  extends Modelica.Icons.Example;

  output SI.Angle j1_phi "Angle of revolute joint j1";
  output SI.Position j2_s "Distance of prismatic joint j2";
  output SI.AngularVelocity j1_w "Axis speed of revolute joint j1";
  output SI.Velocity j2_v "Axis velocity of prismatic joint j2";

  inner Modelica.Mechanics.MultiBody.World world annotation (Placement(
        transformation(extent={{-100,-70},{-80,-50}})));
  Modelica.Mechanics.MultiBody.Joints.Revolute j1(
    n={1,0,0},
    stateSelect=StateSelect.always,
    phi(fixed=true),
    useAxisFlange=false,
    w(displayUnit="deg/s",
      start=5.235987755983,
      fixed=true))
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  Modelica.Mechanics.MultiBody.Joints.Prismatic j2(
    n={1,0,0},
    boxWidth=0.05,
    s(fixed=true, start=-0.2))
    annotation (Placement(transformation(extent={{-20,-70},{0,-50}})));
  Modelica.Mechanics.MultiBody.Parts.BodyCylinder b1(r={0,0.5,0.1}, diameter=0.05)
    annotation (Placement(transformation(
        origin={-30,-10},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Mechanics.MultiBody.Parts.BodyCylinder b2(r={0,0.2,0}, diameter=0.05)
    annotation (Placement(transformation(
        origin={50,-40},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Mechanics.MultiBody.Joints.UniversalSpherical universalSpherical(
    n1_a={0,1,0},
    computeRodLength=true,
    rRod_ia={-1,0.3,0.1}) annotation (Placement(transformation(extent={{20,30},{0,50}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation b3(r={1.2,0,0}, animation=false)
    annotation (Placement(transformation(extent={{-60,-70},{-40,-50}})));
  Modelica.Mechanics.MultiBody.Visualizers.FixedFrame fixedFrame(color_x={0,0,255})
    annotation (Placement(transformation(
        extent={{20,60},{40,80}})));
equation
  j1_phi = j1.phi;
  j2_s = j2.s;
  j1_w = j1.w;
  j2_v = j2.v;
  connect(j2.frame_b, b2.frame_a) annotation (Line(
      points={{0,-60},{50,-60},{50,-50}},
      color={95,95,95},
      thickness=0.5));
  connect(j1.frame_b, b1.frame_a) annotation (Line(
      points={{-40,-30},{-30,-30},{-30,-20}},
      color={95,95,95},
      thickness=0.5));
  connect(j1.frame_a, world.frame_b) annotation (Line(
      points={{-60,-30},{-70,-30},{-70,-60},{-80,-60}},
      color={95,95,95},
      thickness=0.5));
  connect(b1.frame_b, universalSpherical.frame_b) annotation (Line(
      points={{-30,0},{-30,40},{0,40}},
      color={95,95,95},
      thickness=0.5));
  connect(universalSpherical.frame_a, b2.frame_b)
    annotation (Line(
      points={{20,40},{50,40},{50,-30}},
      color={95,95,95},
      thickness=0.5));
  connect(b3.frame_a, world.frame_b)
    annotation (Line(
      points={{-60,-60},{-80,-60}},
      color={95,95,95},
      thickness=0.5));
  connect(b3.frame_b, j2.frame_a)
    annotation (Line(
      points={{-40,-60},{-20,-60}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedFrame.frame_a, universalSpherical.frame_ia) annotation (Line(
      points={{20,70},{14,70},{14,50}},
      color={95,95,95},
      thickness=0.5));
  annotation (
    experiment(StopTime=5),
    Documentation(info="<html>
<p>
This is a second version of the \"four-bar\" mechanism, see figure:
</p>

<div><img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Loops/Fourbar2.png\" alt=\"model Examples.Loops.Fourbar2\"></div>

<p>
In this case
the three revolute joints on the left top-side and the two revolute
joints on the right top side have been replaced by the joint <strong>UniversalSpherical</strong>
that is a rod connecting a spherical and a universal joint. This joint is defined
by <strong>1 constraint</strong> stating that the distance between the two spherical joints is
constant. Using this joint in a kinematic loop reduces the sizes of
non-linear algebraic equations. For this loop, only one non-linear
algebraic system of equations of order 1 remains.
</p>
<p>
At the UniversalSpherical joint an additional frame_ia fixed to the rod
is present where components can be attached to the connecting rod. In this
example just a coordinate system is attached to visualize frame_ia (coordinate
system on the right in blue color).
</p>
<p>
Another feature is that the length of the connecting rod can be
automatically calculated during <strong>initialization</strong>. In order to do this,
another initialization condition has to be given. In this example, the
initial value of the distance of the prismatic joint j2 has been fixed
(via the \"Initialization\" menu) and the rod length of joint
\"UniversalSpherical\" is computed during initialization since parameter
<strong>computeLength</strong> = <strong>true</strong> is set in the joint parameter
menu. The main advantage is that during initialization no non-linear
system of equation is solved and therefore initialization always works.
To be precise, the following trivial non-linear equation is actually solved
for rodLength:
</p>
<blockquote><pre>
rodLength*rodLength = f(angle of revolute joint, distance of prismatic joint)
</pre></blockquote>
</html>"));
end Fourbar2;
