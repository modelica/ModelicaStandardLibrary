model PlanarLoops_analytic
  "Mechanism with three planar kinematic loops and one degree-of-freedom with analytic loop handling (with JointRRR joints)"

  import SI = Modelica.SIunits;
  extends Modelica.Icons.Example;
  parameter SI.Length rh[3]={0.5,0,0};
  parameter SI.Length rv[3]={0,0.5,0};

  parameter SI.Length r1b[3]={0.1,0.5,0};
  parameter SI.Length r1a[3]=r1b + rh - rv;

  parameter SI.Length r2b[3]={0.1,0.6,0};
  parameter SI.Length r2a[3]=r2b + rh - r1b;

  parameter SI.Length r3b[3]={0,0.55,0};
  parameter SI.Length r3a[3]=r3b + rh - r2b;

  annotation (
    experiment(StopTime=5),
    Documentation(info="<html>
<p>
It is demonstrated how the Modelica.Mechanics.MultiBody.Joints.Assemblies.JointRRR joint can be
used to solve the non-linear equations of coupled planar loops analytically.
In the mechanism below no non-linear equation occurs any more from the tool
view, since these equations are solved analytically in the JointRRR joints.
For more details, see
<a href=\"Modelica://Modelica.Mechanics.MultiBody.UsersGuide.Tutorial.LoopStructures.AnalyticLoopHandling\">
MultiBody.UsersGuide.Tutorial.LoopStructures.AnalyticLoopHandling</a>.
</p>
<p align=\"center\">
<IMG SRC=\"../Images/MultiBody/Examples/Loops/PlanarLoops.png\" ALT=\"model Examples.Loops.PlanarLoops\">
</p>
</html>"),
    Diagram,
    Coordsys(grid=[1, 1], component=[20, 20]));

  inner Modelica.Mechanics.MultiBody.World world annotation (extent=[-86,-60;
        -66,-40]);
  Modelica.Mechanics.MultiBody.Joints.Assemblies.JointRRR jointRRR1(
    rRod1_ia=r1a,
    rRod2_ib=r1b,
    checkTotalPower=true) annotation (extent=[-40,-20; 0,20], rotation=-90);
  Modelica.Mechanics.MultiBody.Joints.ActuatedRevolute rev(initType=Modelica.Mechanics.MultiBody.Types.Init.Velocity)
    annotation (extent=[-66,-20; -46,0],   rotation=90);
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation rod1(r=rv)
    annotation (extent=[-66,20; -46,40],   rotation=90);
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation rod2(r=rh)
    annotation (extent=[-50,-60; -30,-40],   rotation=0);
  Modelica.Mechanics.MultiBody.Parts.Body body1(
    m=1,
    cylinderColor={155,155,155},
    r_CM=jointRRR1.rRod1_ia/2)
    annotation (extent=[-4,50; 16,70],    rotation=90);
  Modelica.Mechanics.Rotational.Position position
    annotation (extent=[-90,-20; -70,0]);
  Modelica.Blocks.Sources.Sine sine(amplitude=0.7)
    annotation (extent=[-106,20; -86,40],   rotation=-90);
  Modelica.Mechanics.MultiBody.Joints.Assemblies.JointRRR jointRRR2(
    rRod1_ia=r2a,
    rRod2_ib=r2b,
    checkTotalPower=true) annotation (extent=[10,-20; 50,20], rotation=-90);
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation rod3(r=rh)
    annotation (extent=[0, -60; 20, -40], rotation=0);
  Modelica.Mechanics.MultiBody.Parts.Body body2(
    m=1,
    cylinderColor={155,155,155},
    r_CM=jointRRR2.rRod1_ia/2) annotation (extent=[45,51; 65,71],   rotation=90);
  Modelica.Mechanics.MultiBody.Joints.Assemblies.JointRRR jointRRR3(
    rRod1_ia=r3a,
    rRod2_ib=r3b,
    checkTotalPower=true) annotation (extent=[60,-20; 100,20],rotation=-90);
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation rod4(r=rh)
    annotation (extent=[40, -60; 60, -40], rotation=0);
  Modelica.Mechanics.MultiBody.Parts.Body body3(
    m=1,
    cylinderColor={155,155,155},
    r_CM=jointRRR3.rRod1_ia/2) annotation (extent=[98,52; 118,72],  rotation=90);
equation
  connect(world.frame_b, rev.frame_a) annotation (points=[-66,-50; -56,-50; -56,
        -20], style(
      color=10,
      rgbcolor={95,95,95},
      thickness=2));
  connect(rod1.frame_a, rev.frame_b)
    annotation (points=[-56,20; -56,0],   style(color=0, thickness=2));
  connect(rod1.frame_b, jointRRR1.frame_a) annotation (points=[-56,40; -56,50;
        -20,50; -20,20], style(
      color=10,
      rgbcolor={95,95,95},
      thickness=2));
  connect(rod2.frame_a, world.frame_b)
    annotation (points=[-50,-50; -66,-50], style(
      color=10,
      rgbcolor={95,95,95},
      thickness=2));
  connect(rod2.frame_b, jointRRR1.frame_b) annotation (points=[-30,-50; -20,-50;
        -20,-20], style(
      color=10,
      rgbcolor={95,95,95},
      thickness=2));
  connect(jointRRR1.frame_ia, body1.frame_a) annotation (points=[0,16; 6,16; 6,
        50], style(
      color=10,
      rgbcolor={95,95,95},
      thickness=2));
  connect(position.flange_b, rev.axis)
    annotation (points=[-70,-10; -66,-10],   style(color=0));
  connect(rod3.frame_a, rod2.frame_b)
    annotation (points=[0,-50; -30,-50], style(
      color=10,
      rgbcolor={95,95,95},
      thickness=2));
  connect(rod3.frame_b, jointRRR2.frame_b) annotation (points=[20,-50; 30,-50;
        30,-20], style(
      color=10,
      rgbcolor={95,95,95},
      thickness=2));
  connect(jointRRR2.frame_ia, body2.frame_a) annotation (points=[50,16; 55,16;
        55,51], style(
      color=10,
      rgbcolor={95,95,95},
      thickness=2));
  connect(jointRRR1.frame_im, jointRRR2.frame_a) annotation (points=[0,
        1.22461e-015; 12,1.22461e-015; 12,25; 30,25; 30,20], style(
      color=10,
      rgbcolor={95,95,95},
      thickness=2));
  connect(rod3.frame_b, rod4.frame_a)
    annotation (points=[20,-50; 40,-50], style(
      color=10,
      rgbcolor={95,95,95},
      thickness=2));
  connect(rod4.frame_b, jointRRR3.frame_b) annotation (points=[60,-50; 80,-50;
        80,-20], style(
      color=10,
      rgbcolor={95,95,95},
      thickness=2));
  connect(jointRRR2.frame_im, jointRRR3.frame_a) annotation (points=[50,
        1.22461e-015; 60,1.22461e-015; 60,26; 80,26; 80,20], style(
      color=10,
      rgbcolor={95,95,95},
      thickness=2));
  connect(jointRRR3.frame_ia, body3.frame_a) annotation (points=[100,16; 108,16;
        108,52], style(
      color=10,
      rgbcolor={95,95,95},
      thickness=2));
  connect(sine.y, position.phi_ref) annotation(points=[-96,19; -96,-10; -92,-10],
      style(color=3, rgbcolor={0,0,255}));
end PlanarLoops_analytic;
