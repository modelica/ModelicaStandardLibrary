within Modelica.Mechanics.MultiBody.Examples.Loops;
model Engine1a "Model of one cylinder engine"
  extends Modelica.Icons.Example;
  extends Utilities.Engine1Base;
  Modelica.Mechanics.MultiBody.Joints.Revolute b1(
    n={1,0,0},
    cylinderLength=0.02,
    cylinderDiameter=0.05)
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Joints.RevolutePlanarLoopConstraint b2(
    n={1,0,0},
    cylinderLength=0.02,
    cylinderDiameter=0.05) annotation (Placement(transformation(extent={{40,-30},{60,-50}})));
  Modelica.Mechanics.MultiBody.Joints.Prismatic cylinder(
    boxWidth=0.02,
    n={0,-1,0},
    s(start=0.15)) annotation (Placement(transformation(
        origin={50,80},
        extent={{-10,-10},{10,10}},
        rotation=270)));
equation
  connect(cylPosition.frame_b, cylinder.frame_a) annotation (Line(
      points={{-70,50},{-70,94},{50,94},{50,90}},
      color={95,95,95},
      thickness=0.5));
  connect(b2.frame_a, mid.frame_b) annotation (Line(
      points={{40,-40},{30,-40}},
      color={95,95,95},
      thickness=0.5));
  connect(b2.frame_b, connectingRod.frame_b) annotation (Line(
      points={{60,-40},{90,-40},{90,-30}},
      color={95,95,95},
      thickness=0.5));
  connect(connectingRod.frame_a, b1.frame_b) annotation (Line(
      points={{90,-10},{90,0},{60,0}},
      color={95,95,95},
      thickness=0.5));
  connect(b1.frame_a, piston.frame_b) annotation (Line(
      points={{40,0},{30,0},{30,20},{90,20},{90,30}},
      color={95,95,95},
      thickness=0.5));
  connect(cylinder.frame_b, piston.frame_a) annotation (Line(
      points={{50,70},{50,60},{90,60},{90,50}},
      color={95,95,95},
      thickness=0.5));
  annotation (experiment(StopTime=5), Documentation(info="<html>
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
</p><div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Loops/Engine.png\" alt=\"model Examples.Loops.Engine\">
</div></html>"));
end Engine1a;
