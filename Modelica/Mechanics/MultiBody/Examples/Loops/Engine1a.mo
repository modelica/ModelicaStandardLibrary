within Modelica.Mechanics.MultiBody.Examples.Loops;
model Engine1a "Model of one cylinder engine"
  extends Modelica.Icons.Example;
  Modelica.Mechanics.MultiBody.Parts.BodyCylinder piston(diameter=0.1, r={0,-0.1,
        0}) annotation (Placement(transformation(
        origin={30,40},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Mechanics.MultiBody.Parts.BodyBox connectingRod(
    widthDirection={1,0,0},
    width=0.02,
    height=0.06,
    r={0,-0.2,0},
    color={0,0,200}) annotation (Placement(transformation(
        origin={50,-10},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Modelica.Mechanics.MultiBody.Joints.Revolute b2(
    n={1,0,0},
    cylinderLength=0.02,
    cylinderDiameter=0.05) annotation (Placement(transformation(extent={{20,0},{40,20}})));
  Modelica.Mechanics.MultiBody.Joints.Revolute bearing(
    useAxisFlange=true,
    n={1,0,0},
    cylinderLength=0.02,
    cylinderDiameter=0.05) annotation (Placement(transformation(extent={{-60,-100},{-40,-80}})));
  inner Modelica.Mechanics.MultiBody.World world annotation (Placement(
        transformation(extent={{-100,-100},{-80,-80}})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(
    stateSelect=StateSelect.always,
    phi(fixed=true, start=0),
    w(fixed=true, start=10),
    J=1) annotation (Placement(transformation(extent={{-60,-70},{-40,-50}})));
  Modelica.Mechanics.MultiBody.Parts.BodyBox crank4(
    height=0.05,
    widthDirection={1,0,0},
    width=0.02,
    r={0,-0.1,0}) annotation (Placement(transformation(
        origin={70,-80},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Modelica.Mechanics.MultiBody.Parts.BodyCylinder crank1(diameter=0.05, r={0.1,
        0,0}) annotation (Placement(transformation(extent={{-30,-100},{-10,-80}})));
  Modelica.Mechanics.MultiBody.Parts.BodyCylinder crank3(r={0.1,0,0}, diameter=
        0.03) annotation (Placement(transformation(extent={{30,-80},{50,-60}})));
  Modelica.Mechanics.MultiBody.Parts.BodyBox crank2(
    r={0,0.1,0},
    height=0.05,
    widthDirection={1,0,0},
    width=0.02) annotation (Placement(transformation(
        origin={0,-80},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Joints.RevolutePlanarLoopConstraint b1(
    n={1,0,0},
    cylinderLength=0.02,
    cylinderDiameter=0.05) annotation (Placement(transformation(extent={{20,-20},{40,-40}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation mid(r={0.05,0,0})
    annotation (Placement(transformation(extent={{10,-44},{30,-64}})));
  Modelica.Mechanics.MultiBody.Joints.Prismatic cylinder(
    boxWidth=0.02,
    n={0,-1,0},
    s(start=0.15)) annotation (Placement(transformation(
        origin={30,70},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation cylPosition(animation=
        false, r={0.15,0.45,0}) annotation (Placement(transformation(extent={{-60,70},{-40,90}})));
equation
  connect(world.frame_b, bearing.frame_a) annotation (Line(
      points={{-80,-90},{-60,-90}},
      color={95,95,95},
      thickness=0.5));
  connect(crank2.frame_a, crank1.frame_b) annotation (Line(
      points={{-4.44089e-016,-90},{-10,-90}},
      color={95,95,95},
      thickness=0.5));
  connect(crank2.frame_b, crank3.frame_a) annotation (Line(
      points={{0,-70},{30,-70}},
      color={95,95,95},
      thickness=0.5));
  connect(bearing.frame_b, crank1.frame_a) annotation (Line(
      points={{-40,-90},{-30,-90}},
      color={95,95,95},
      thickness=0.5));
  connect(cylPosition.frame_b, cylinder.frame_a) annotation (Line(
      points={{-40,80},{30,80}},
      color={95,95,95},
      thickness=0.5));
  connect(world.frame_b, cylPosition.frame_a) annotation (Line(
      points={{-80,-90},{-70,-90},{-70,80},{-60,80}},
      color={95,95,95},
      thickness=0.5));
  connect(crank3.frame_b, crank4.frame_a) annotation (Line(
      points={{50,-70},{70,-70}},
      color={95,95,95},
      thickness=0.5));
  connect(b1.frame_a, mid.frame_b) annotation (Line(
      points={{20,-30},{10,-30},{10,-44},{30,-44},{30,-54}},
      color={95,95,95},
      thickness=0.5));
  connect(b1.frame_b, connectingRod.frame_b) annotation (Line(
      points={{40,-30},{50,-30},{50,-20}},
      color={95,95,95},
      thickness=0.5));
  connect(connectingRod.frame_a, b2.frame_b) annotation (Line(
      points={{50,0},{50,10},{40,10}},
      color={95,95,95},
      thickness=0.5));
  connect(b2.frame_a, piston.frame_b) annotation (Line(
      points={{20,10},{10,10},{10,24},{30,24},{30,30}},
      color={95,95,95},
      thickness=0.5));
  connect(inertia.flange_b, bearing.axis)
    annotation (Line(points={{-40,-60},{-40,-80},{-50,-80}}));
  connect(mid.frame_a, crank2.frame_b) annotation (Line(
      points={{10,-54},{10,-70},{0,-70}},
      color={95,95,95},
      thickness=0.5));
  connect(cylinder.frame_b, piston.frame_a) annotation (Line(
      points={{30,60},{30,50}},
      color={95,95,95},
      thickness=0.5));
  annotation (Diagram(coordinateSystem(extent={{-100,-100},{100,100}})),
    experiment(StopTime=5), Documentation(info="<html>
<p>
This is a model of the mechanical part of one cylinder of an engine.
The combustion is not modelled. The \"inertia\" component at the lower
left part is the output inertia of the engine driving the gearbox.
The angular velocity of the output inertia has a start value of 10 rad/s
in order to demonstrate the movement of the engine.
</p>
<p>
The engine is modeled solely by revolute and prismatic joints.
Since this results in a <strong>planar</strong> loop there is the well known
difficulty that the cut-forces perpendicular to the loop cannot be
uniquely computed, as well as the cut-torques within the plane.
This ambiguity is resolved by using the option <strong>planarCutJoint</strong>
in the <strong>Advanced</strong> menu of one revolute joint in every planar loop
(here: joint b1). This option sets the cut-force in direction of the
axis of rotation, as well as the cut-torques perpendicular to the axis
of rotation at this joint to zero and makes the problem mathematically
well-formed.
</p>
<p>
An animation of this example is shown in the figure below.
</p>

<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Loops/Engine.png\" alt=\"model Examples.Loops.Engine\">
</html>"));
end Engine1a;
