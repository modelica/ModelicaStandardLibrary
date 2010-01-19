within Modelica.Mechanics.MultiBody.Examples.Loops;
model Fourbar2
  "One kinematic loop with four bars (with UniversalSpherical joint; 1 non-linear equation)"

  import SI = Modelica.SIunits;
  extends Modelica.Icons.Example;

  output SI.Angle j1_phi "angle of revolute joint j1";
  output SI.Position j2_s "distance of prismatic joint j2";
  output SI.AngularVelocity j1_w "axis speed of revolute joint j1";
  output SI.Velocity j2_v "axis velocity of prismatic joint j2";

  inner Modelica.Mechanics.MultiBody.World world annotation (Placement(
        transformation(extent={{-80,-80},{-60,-60}}, rotation=0)));
  Modelica.Mechanics.MultiBody.Joints.Revolute j1(useAxisFlange=true,
    n={1,0,0},
    stateSelect=StateSelect.always,
    phi(fixed=true),
    w(displayUnit="deg/s",
      start=5.235987755982989,
      fixed=true))
                 annotation (Placement(transformation(extent={{-54,-40},{-34,
            -20}}, rotation=0)));
  Modelica.Mechanics.MultiBody.Joints.Prismatic j2(
    n={1,0,0},
    boxWidth=0.05,
    s(fixed=true, start=-0.2))
    annotation (Placement(transformation(extent={{12,-80},{32,-60}}, rotation=0)));
  Modelica.Mechanics.MultiBody.Parts.BodyCylinder b1(r={0,0.5,0.1}, diameter=0.05)
    annotation (Placement(transformation(
        origin={-30,0},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Mechanics.MultiBody.Parts.BodyCylinder b2(r={0,0.2,0}, diameter=0.05)
    annotation (Placement(transformation(
        origin={50,-50},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Mechanics.MultiBody.Joints.UniversalSpherical universalSpherical(
    n1_a={0,1,0},
    computeRodLength=true,
    rRod_ia={-1,0.3,0.1}) annotation (Placement(transformation(extent={{0,18},{
            -20,38}}, rotation=0)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation b3(r={1.2,0,0}, animation=false)
    annotation (Placement(transformation(extent={{-32,-80},{-12,-60}}, rotation=
           0)));
  Modelica.Mechanics.MultiBody.Visualizers.FixedFrame fixedFrame(color_x={0,0,255})
    annotation (Placement(transformation(
        origin={-6,70},
        extent={{-10,-10},{10,10}},
        rotation=90)));
equation
  j1_phi = j1.phi;
  j2_s = j2.s;
  j1_w = j1.w;
  j2_v = j2.v;
  connect(j2.frame_b, b2.frame_a) annotation (Line(
      points={{32,-70},{50,-70},{50,-60}},
      color={95,95,95},
      thickness=0.5));
  connect(j1.frame_b, b1.frame_a) annotation (Line(
      points={{-34,-30},{-30,-30},{-30,-10}},
      color={95,95,95},
      thickness=0.5));
  connect(j1.frame_a, world.frame_b) annotation (Line(
      points={{-54,-30},{-60,-30},{-60,-70}},
      color={95,95,95},
      thickness=0.5));
  connect(b1.frame_b, universalSpherical.frame_b) annotation (Line(
      points={{-30,10},{-30,28},{-20,28}},
      color={95,95,95},
      thickness=0.5));
  connect(universalSpherical.frame_a, b2.frame_b)
    annotation (Line(
      points={{0,28},{50,28},{50,-40}},
      color={95,95,95},
      thickness=0.5));
  connect(b3.frame_a, world.frame_b)
    annotation (Line(
      points={{-32,-70},{-60,-70}},
      color={95,95,95},
      thickness=0.5));
  connect(b3.frame_b, j2.frame_a)
    annotation (Line(
      points={{-12,-70},{12,-70}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedFrame.frame_a, universalSpherical.frame_ia) annotation (Line(
      points={{-6,60},{-6,49},{-6,49},{-6,38}},
      color={95,95,95},
      thickness=0.5));
  annotation (
    experiment(StopTime=5),
    Documentation(info="<html>
<p>
This is a second version of the \"four-bar\" mechanism, see figure:
</p>
<p align=\"center\">
<IMG SRC=\"../Images/MultiBody/Examples/Loops/Fourbar2.png\" ALT=\"model Examples.Loops.Fourbar2\">
</p>
<p>
In this case
the three revolute joints on the left top-side and the two revolute
joints on the right top side have been replaced by the joint <b>UniversalSpherical</b>
that is a rod connecting a spherical and a universal joint. This joint is defined
by <b>1 constraint</b> stating that the distance between the two spherical joints is
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
automatically calculated during <b>initialization</b>. In order to do this,
another initialization condition has to be given. In this example, the
initial value of the distance of the prismatic joint j2 has been fixed
(via the \"Initialization\" menu) and the rod length of joint
\"UniversalSpherical\" is computed during initialization since parameter
<b>computeLength</b> = <b>true</b> is set in the joint parameter
menu. The main advantage is that during initialization no non-linear
system of equation is solved and therefore initialization always works.
To be precise, the following trivial non-linear equation is actually solved
for rodLength:
</p>
<pre>
   rodLength*rodLength = f(angle of revolute joint, distance of prismatic joint)
</pre>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}),
            graphics));
end Fourbar2;
