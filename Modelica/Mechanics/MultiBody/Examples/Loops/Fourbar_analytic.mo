model Fourbar_analytic 
  "One kinematic loop with four bars (with JointSSP joint; analytic solution of non-linear algebraic loop)" 
  
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
This is a third version of the \"four-bar\" mechanism, see figure:
</p>
<p align=\"center\">
<IMG SRC=\"../Images/MultiBody/Examples/Loops/Fourbar_analytic.png\" ALT=\"model Examples.Loops.Fourbar_analytic\">
</p>
<p>
In this case
the three revolute joints on the left top-side and the two revolute
joints on the right top side have been replaced by the assembly joint 
<b>Joints.Assemblies.JointSSP</b>
which consists of two spherical joints and one prismatic joint.
Since JointSSP solves the non-linear constraint equation internally
analytically, no non-linear equation appears any more and a Modelica
translator, such as Dymola, can transform the system into state space
form without solving a system of equations. For more details, see
<a href=\"Modelica://Modelica.Mechanics.MultiBody.UsersGuide.Tutorial.LoopStructures.AnalyticLoopHandling\">
MultiBody.UsersGuide.Tutorial.LoopStructures.AnalyticLoopHandling</a>. 
</p>
</html>"),
    Diagram);
  
  inner Modelica.Mechanics.MultiBody.World world(animateGravity=false) 
    annotation (extent=[-80, -60; -60, -40]);
  Modelica.Mechanics.MultiBody.Joints.ActuatedRevolute j1(
    n={1,0,0},
    initType=Modelica.Mechanics.MultiBody.Types.Init.PositionVelocity,
    enforceStates=true,
    w_start=300) annotation (extent=[-54, -40; -34, -20]);
  Modelica.Mechanics.MultiBody.Parts.BodyCylinder b1(r={0,0.5,0.1}, diameter=0.05) 
    annotation (extent=[-40, -18; -20, 2], rotation=90);
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation b3(r={1.2,0,0}, animation=false) 
    annotation (extent=[-32, -60; -12, -40]);
  Modelica.Mechanics.MultiBody.Joints.Assemblies.JointSSP jointSSP(
    rod1Length=sqrt({-1,0.3,0.1}*{-1,0.3,0.1}),
    n_b={1,0,0},
    s_offset=-0.2,
    rRod2_ib={0,0.2,0},
    rod1Color={0,128,255},
    rod2Color={0,128,255},
    checkTotalPower=true) annotation (extent=[-20, 0; 0, 20]);
  Modelica.Mechanics.MultiBody.Parts.BodyCylinder b2(
    r={0,0.2,0},
    diameter=0.05,
    animation=false) annotation (extent=[20, -20; 40, 0], rotation=90);
equation 
  j1_phi = j1.phi;
  j2_s = jointSSP.prismatic.distance;
  j1_w = j1.w;
  j2_v = der(jointSSP.prismatic.distance);
  connect(j1.frame_b, b1.frame_a) annotation (points=[-33, -30; -30, -30; -30,
        -19], style(color=0, thickness=2));
  connect(j1.frame_a, world.frame_b) annotation (points=[-55, -30; -59, -30; -59,
         -50], style(color=0, thickness=2));
  connect(b3.frame_a, world.frame_b) 
    annotation (points=[-33, -50; -59, -50], style(color=0, thickness=2));
  connect(b1.frame_b, jointSSP.frame_a) annotation (points=[-30, 3; -30, 10; -21,
         10], style(color=0, thickness=2));
  connect(b3.frame_b, jointSSP.frame_b) annotation (points=[-11, -50; 8, -50; 8,
         10; 1, 10], style(color=0, thickness=2));
  connect(b2.frame_a, jointSSP.frame_ib) annotation (points=[30, -21; 30, -28;
        18, -28; 18, 28; -2, 28; -2, 21], style(color=0, thickness=2));
end Fourbar_analytic;
