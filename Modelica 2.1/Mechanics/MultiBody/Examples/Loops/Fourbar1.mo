encapsulated model Fourbar1
  "One kinematic loop with four bars (with only revolute joints; 5 non-linear equations)"

  import Modelica;
  import Modelica.Mechanics.MultiBody;
  import SI = Modelica.SIunits;
  extends Modelica.Icons.Example;

  output SI.Angle j1_phi "angle of revolute joint j1";
  output SI.Position j2_s "distance of prismatic joint j2";
  output SI.AngularVelocity j1_w "axis speed of revolute joint j1";
  output SI.Velocity j2_v "axis velocity of prismatic joint j2";
  annotation (
    experiment(StopTime=5),
    Documentation(info="<html>
<p>
This is a simple kinematic loop consisting of 6 revolute joints, 1 prismatic joint
and 4 bars that is often used as basic constructing unit in mechanisms.
This example demonstrates that usually no particular knowledge
of the user is needed to handle kinematic loops.
Just connect the joints and bodies together according
to the real system. In particular <b>no</b> cut-joints or a spanning tree has
to be determined. In this case, the initial condition of the angular velocity
of revolute joint j1 is set to 300 deg/s in order to drive this loop.
</p>
<p align=\"center\">
<IMG SRC=\"../Images/MultiBody/Examples/Loops/Fourbar1.png\" ALT=\"model Examples.Loops.Fourbar1\">
</p>
</html>
"), Diagram);

  inner MultiBody.World world annotation (extent=[-100, -80; -80, -60]);
  MultiBody.Joints.Revolute j1(
    n={1,0,0},
    initType=MultiBody.Types.Init.PositionVelocity,
    enforceStates=true,
    w_start=300) annotation (extent=[-54, -40; -34, -20]);
  MultiBody.Joints.Prismatic j2(
    n={1,0,0},
    s_start=-0.2,
    boxWidth=0.05) annotation (extent=[10, -80; 30, -60]);
  MultiBody.Parts.BodyCylinder b1(r={0,0.5,0.1}, diameter=0.05)
    annotation (extent=[-40, -8; -20, 12], rotation=90);
  MultiBody.Parts.BodyCylinder b2(r={0,0.2,0}, diameter=0.05)
    annotation (extent=[40, -60; 60, -40], rotation=90);
  MultiBody.Parts.BodyCylinder b3(r={-1,0.3,0.1}, diameter=0.05)
    annotation (extent=[38, 20; 18, 40]);
  MultiBody.Joints.Revolute rev(n={0,1,0})
    annotation (extent=[40, -32; 60, -12], rotation=90);
  MultiBody.Joints.Revolute rev1 annotation (extent=[60, 0; 80, 20]);
  MultiBody.Joints.Revolute j3(n={1,0,0}) annotation (extent=[-60, 40; -40, 60]);
  MultiBody.Joints.Revolute j4(n={0,1,0}) annotation (extent=[-32, 60; -12, 80]);
  MultiBody.Joints.Revolute j5(n={0,0,1}) annotation (extent=[0, 70; 20, 90]);
  MultiBody.Parts.FixedTranslation b0(animation=false, r={1.2,0,0})
    annotation (extent=[-40, -80; -20, -60]);
equation
  connect(j2.frame_b, b2.frame_a) annotation (points=[31, -70; 50, -70; 50, -61],
       style(color=0, thickness=2));
  connect(j1.frame_b, b1.frame_a) annotation (points=[-33, -30; -30, -30; -30,
        -9], style(color=0, thickness=2));
  connect(rev.frame_a, b2.frame_b)
    annotation (points=[50, -33; 50, -39], style(color=0, thickness=2));
  connect(rev.frame_b, rev1.frame_a)
    annotation (points=[50, -11; 50, 10; 59, 10], style(color=0, thickness=2));
  connect(rev1.frame_b, b3.frame_a) annotation (points=[81, 10; 90, 10; 90, 30;
         39, 30], style(color=0, thickness=2));
  connect(world.frame_b, j1.frame_a) annotation (points=[-79, -70; -66, -70; -66,
         -30; -55, -30], style(color=0, thickness=2));
  connect(b1.frame_b, j3.frame_a) annotation (points=[-30, 13; -30, 28; -72, 28;
         -72, 50; -61, 50], style(color=0, thickness=2));
  connect(j3.frame_b, j4.frame_a) annotation (points=[-39, 50; -34, 50; -42, 70;
         -33, 70], style(color=0, thickness=2));
  connect(j4.frame_b, j5.frame_a)
    annotation (points=[-11, 70; -1, 70; -1, 80], style(color=0, thickness=2));
  connect(j5.frame_b, b3.frame_b) annotation (points=[21, 80; 30, 80; 30, 54; 4,
         54; 4, 30; 17, 30], style(color=0, thickness=2));
  connect(b0.frame_a, world.frame_b)
    annotation (points=[-41, -70; -79, -70], style(color=0, thickness=2));
  connect(b0.frame_b, j2.frame_a)
    annotation (points=[-19, -70; 9, -70], style(color=0, thickness=2));
  j1_phi = j1.phi;
  j2_s = j2.s;
  j1_w = j1.w;
  j2_v = j2.v;
end Fourbar1;
