within Modelica.Mechanics.MultiBody.Examples.Loops;
model PlanarLoops_analytic
  "Mechanism with three planar kinematic loops and one degree-of-freedom with analytic loop handling (with JointRRR joints)"
  extends Modelica.Icons.Example;
  parameter SI.Length rh[3]={0.5,0,0}
    "Position vector from 'lower left' revolute to 'lower right' revolute joint for all the 3 loops";
  parameter SI.Length rv[3]={0,0.5,0}
    "Position vector from 'lower left' revolute to 'upper left' revolute joint in the first loop";

  parameter SI.Length r1b[3]={0.1,0.5,0}
    "Position vector from 'lower right' revolute to 'upper right' revolute joint in the first loop";
  final parameter SI.Length r1a[3]=r1b + rh - rv
    "Position vector from 'upper left' revolute to 'upper right' revolute joint in the first loop";

  parameter SI.Length r2b[3]={0.1,0.6,0}
    "Position vector from 'lower right' revolute to 'upper right' revolute joint in the second loop";
  final parameter SI.Length r2a[3]=r2b + rh - r1b
    "Position vector from 'upper left' revolute to 'upper right' revolute joint in the second loop";

  parameter SI.Length r3b[3]={0,0.55,0}
    "Position vector from 'lower right' revolute to 'upper right' revolute joint in the third loop";
  final parameter SI.Length r3a[3]=r3b + rh - r2b
    "Position vector from 'upper left' revolute to 'upper right' revolute joint in the third loop";

  inner Modelica.Mechanics.MultiBody.World world annotation (Placement(
        transformation(extent={{-120,-80},{-100,-60}})));
  Modelica.Mechanics.MultiBody.Joints.Assemblies.JointRRR jointRRR1(
    rRod1_ia=r1a,
    rRod2_ib=r1b,
    checkTotalPower=true) annotation (Placement(transformation(
        origin={-20,-10},
        extent={{-20,-20},{20,20}},
        rotation=270)));
  Modelica.Mechanics.MultiBody.Joints.Revolute rev(useAxisFlange=true,w(fixed=true))
    annotation (Placement(transformation(
        origin={-60,-10},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation rod1(r=rv)
    annotation (Placement(transformation(
        extent={{-50,10},{-30,30}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation rod2(r=rh)
    annotation (Placement(transformation(extent={{-50,-60},{-30,-40}})));
  Modelica.Mechanics.MultiBody.Parts.Body body1(
    m=1,
    cylinderColor={155,155,155},
    r_CM=jointRRR1.rRod1_ia/2)
    annotation (Placement(transformation(
        origin={4,40},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Mechanics.Rotational.Sources.Position position(useSupport=true)
    annotation (Placement(transformation(extent={{-100,-20},{-80,0}})));
  Modelica.Blocks.Sources.Sine sine(amplitude=0.7, f=1)
    annotation (Placement(transformation(
        origin={-110,30},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Mechanics.MultiBody.Joints.Assemblies.JointRRR jointRRR2(
    rRod1_ia=r2a,
    rRod2_ib=r2b,
    checkTotalPower=true) annotation (Placement(transformation(
        origin={30,-10},
        extent={{-20,-20},{20,20}},
        rotation=270)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation rod3(r=rh)
    annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
  Modelica.Mechanics.MultiBody.Parts.Body body2(
    m=1,
    cylinderColor={155,155,155},
    r_CM=jointRRR2.rRod1_ia/2) annotation (Placement(transformation(
        origin={55,41},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Mechanics.MultiBody.Joints.Assemblies.JointRRR jointRRR3(
    rRod1_ia=r3a,
    rRod2_ib=r3b,
    checkTotalPower=true) annotation (Placement(transformation(
        origin={80,-10},
        extent={{-20,-20},{20,20}},
        rotation=270)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation rod4(r=rh)
    annotation (Placement(transformation(extent={{50,-60},{70,-40}})));
  Modelica.Mechanics.MultiBody.Parts.Body body3(
    m=1,
    cylinderColor={155,155,155},
    r_CM=jointRRR3.rRod1_ia/2) annotation (Placement(transformation(
        origin={104,40},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Parts.Mounting1D mounting1D
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-90,-50})));
equation
  connect(world.frame_b, rev.frame_a) annotation (Line(
      points={{-100,-70},{-60,-70},{-60,-20}},
      color={95,95,95},
      thickness=0.5));
  connect(rod1.frame_a, rev.frame_b)
    annotation (Line(
      points={{-50,20},{-60,20},{-60,0}},
      thickness=0.5));
  connect(rod1.frame_b, jointRRR1.frame_a) annotation (Line(
      points={{-30,20},{-20,20},{-20,10}},
      color={95,95,95},
      thickness=0.5));
  connect(rod2.frame_a, world.frame_b)
    annotation (Line(
      points={{-50,-50},{-60,-50},{-60,-70},{-100,-70}},
      color={95,95,95},
      thickness=0.5));
  connect(rod2.frame_b, jointRRR1.frame_b) annotation (Line(
      points={{-30,-50},{-20,-50},{-20,-30}},
      color={95,95,95},
      thickness=0.5));
  connect(jointRRR1.frame_ia, body1.frame_a) annotation (Line(
      points={{0,6},{4,6},{4,30}},
      color={95,95,95},
      thickness=0.5));
  connect(rod3.frame_a, rod2.frame_b)
    annotation (Line(
      points={{0,-50},{-30,-50}},
      color={95,95,95},
      thickness=0.5));
  connect(rod3.frame_b, jointRRR2.frame_b) annotation (Line(
      points={{20,-50},{30,-50},{30,-30}},
      color={95,95,95},
      thickness=0.5));
  connect(jointRRR2.frame_ia, body2.frame_a) annotation (Line(
      points={{50,6},{55,6},{55,31}},
      color={95,95,95},
      thickness=0.5));
  connect(jointRRR1.frame_im, jointRRR2.frame_a) annotation (Line(
      points={{0,-10},{12,-10},{12,10},{30,10}},
      color={95,95,95},
      thickness=0.5));
  connect(rod3.frame_b, rod4.frame_a)
    annotation (Line(
      points={{20,-50},{50,-50}},
      color={95,95,95},
      thickness=0.5));
  connect(rod4.frame_b, jointRRR3.frame_b) annotation (Line(
      points={{70,-50},{80,-50},{80,-30}},
      color={95,95,95},
      thickness=0.5));
  connect(jointRRR2.frame_im, jointRRR3.frame_a) annotation (Line(
      points={{50,-10},{60,-10},{60,10},{80,10}},
      color={95,95,95},
      thickness=0.5));
  connect(jointRRR3.frame_ia, body3.frame_a) annotation (Line(
      points={{100,6},{104,6},{104,30}},
      color={95,95,95},
      thickness=0.5));
  connect(sine.y, position.phi_ref) annotation (Line(points={{-110,19},{-110,-10},{-102,-10}},
                      color={0,0,127}));
  connect(mounting1D.flange_b, position.support) annotation (Line(
      points={{-90,-40},{-90,-20}}));
  connect(mounting1D.frame_a, world.frame_b) annotation (Line(
      points={{-80,-50},{-60,-50},{-60,-70},{-100,-70}},
      color={95,95,95},
      thickness=0.5));
  connect(position.flange, rev.axis) annotation (Line(
      points={{-80,-10},{-70,-10}}));
  annotation (
    experiment(StopTime=5),
    Documentation(info="<html>
<p>
It is demonstrated how the Modelica.Mechanics.MultiBody.Joints.Assemblies.JointRRR joint can be
used to solve the non-linear equations of coupled planar loops analytically.
In the mechanism below no non-linear equation occurs any more from the tool
view, since these equations are solved analytically in the JointRRR joints.
For more details, see
<a href=\"modelica://Modelica.Mechanics.MultiBody.UsersGuide.Tutorial.LoopStructures.AnalyticLoopHandling\">
MultiBody.UsersGuide.Tutorial.LoopStructures.AnalyticLoopHandling</a>.
</p>

<p>
In the following figure the parameter vectors of this example are visualized in the
animation view.
</p>

<div><img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Loops/PlanarLoops2.png\" alt=\"model Examples.Loops.PlanarLoops2\"></div>
</html>"),
    Diagram(coordinateSystem(extent={{-120,-100},{120,100}})),
    Icon(coordinateSystem(extent={{-120,-100},{120,100}})));
end PlanarLoops_analytic;
