within Modelica.Mechanics.MultiBody.Joints;
model RevolutePlanarLoopConstraint
  "Revolute joint that is described by 2 positional constraints for usage in a planar loop (the ambiguous cut-force perpendicular to the loop and the ambiguous cut-torques are set arbitrarily to zero)"

  import T = Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
  import Modelica.Mechanics.MultiBody.Types;

  Interfaces.Frame_a frame_a
    "Coordinate system fixed to the joint with one cut-force and cut-torque"
    annotation (Placement(transformation(extent={{-116,-16},{-84,16}})));
  Interfaces.Frame_b frame_b
    "Coordinate system fixed to the joint with one cut-force and cut-torque"
    annotation (Placement(transformation(extent={{84,-16},{116,16}})));

  parameter Boolean animation=true
    "= true, if animation shall be enabled (show axis as cylinder)";
  parameter Modelica.Mechanics.MultiBody.Types.Axis n={0,0,1}
    "Axis of rotation resolved in frame_a (= same as in frame_b)"
    annotation (Evaluate=true);
  parameter SI.Distance cylinderLength=world.defaultJointLength
    "Length of cylinder representing the joint axis"
    annotation (Dialog(group="if animation = true", enable=animation));
  parameter SI.Distance cylinderDiameter=world.defaultJointWidth
    "Diameter of cylinder representing the joint axis"
    annotation (Dialog(group="if animation = true", enable=animation));
  input Types.Color cylinderColor=Modelica.Mechanics.MultiBody.Types.Defaults.JointColor
    "Color of cylinder representing the joint axis"
    annotation (Dialog(colorSelector=true, group="if animation = true", enable=animation));
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (Dialog(group="if animation = true", enable=animation));
protected
  outer Modelica.Mechanics.MultiBody.World world;
  parameter Real e[3](each final unit="1")=Modelica.Math.Vectors.normalizeWithAssert(n)
    "Unit vector in direction of rotation axis, resolved in frame_a (= same as in frame_b)";
  parameter Real nnx_a[3](each final unit="1")=if abs(e[1]) > 0.1 then {0,1,0} else (if abs(e[2])
       > 0.1 then {0,0,1} else {1,0,0})
    "Arbitrary vector that is not aligned with rotation axis n"
    annotation (Evaluate=true);
  parameter Real ey_a[3](each final unit="1")=Modelica.Math.Vectors.normalizeWithAssert(cross(e, nnx_a))
    "Unit vector orthogonal to axis n of revolute joint, resolved in frame_a"
    annotation (Evaluate=true);
  parameter Real ex_a[3](each final unit="1")=cross(ey_a, e)
    "Unit vector orthogonal to axis n of revolute joint and to ey_a, resolved in frame_a"
    annotation (Evaluate=true);
  Real ey_b[3](each final unit="1") "ey_a, resolved in frame_b";
  Real ex_b[3](each final unit="1") "ex_a, resolved in frame_b";
  Frames.Orientation R_rel
    "Dummy or relative orientation object from frame_a to frame_b";
  SI.Position r_rel_a[3]
    "Position vector from origin of frame_a to origin of frame_b, resolved in frame_a";
  SI.Force f_c[2] "Dummy or constraint forces in direction of ex_a, ey_a";

  Visualizers.Advanced.Shape cylinder(
    shapeType="cylinder",
    color=cylinderColor,
    specularCoefficient=specularCoefficient,
    length=cylinderLength,
    width=cylinderDiameter,
    height=cylinderDiameter,
    lengthDirection=e,
    widthDirection={0,1,0},
    r_shape=-e*(cylinderLength/2),
    r=frame_a.r_0,
    R=frame_a.R) if world.enableAnimation and animation;
equation
  assert(cardinality(frame_a) > 0,
    "Connector frame_a of revolute joint is not connected");
  assert(cardinality(frame_b) > 0,
    "Connector frame_b of revolute joint is not connected");

  // Determine relative position vector resolved in frame_a
  R_rel = Frames.relativeRotation(frame_a.R, frame_b.R);
  r_rel_a = Frames.resolve2(frame_a.R, frame_b.r_0 - frame_a.r_0);
  // r_rel_a = T.resolve1(R_rel.T, T.resolve2(frame_b.R.T, frame_b.r_0 - frame_a.r_0));

  // Constraint equations
  0 = ex_a*r_rel_a;
  0 = ey_a*r_rel_a;

  /* Transform forces and torques
     (the torques are assumed to be zero by the assumption
      of a planar joint)
  */
  frame_a.t = zeros(3);
  frame_b.t = zeros(3);

  frame_a.f = [ex_a, ey_a]*f_c;
  frame_b.f = -Frames.resolve2(R_rel, frame_a.f);

  // check that revolute joint is used in planar loop
  ex_b = Frames.resolve2(R_rel, ex_a);
  ey_b = Frames.resolve2(R_rel, ey_a);
  assert(noEvent(abs(e*r_rel_a) <= 1e-10 and abs(e*ex_b) <= 1e-10 and
      abs(e*ey_b) <= 1e-10), "
The MultiBody.Joints.RevolutePlanarLoopConstraint joint is used as cut-joint of a
planar loop. However, the revolute joint is not part of a planar loop where the
axis of the revolute joint (parameter n) is orthogonal to the possible movements.
Either use instead joint MultiBody.Joints.Revolute or correct the
definition of the axes vectors n in the revolute joints of the planar loop.
");
  annotation (
    defaultComponentName="revolute",
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-150,-110},{150,-80}},
          textString="n=%n"),
        Text(
          extent={{-150,70},{150,110}},
          textString="%name",
          textColor={0,0,255}),
        Rectangle(
          extent={{-20,10},{20,-10}},
          lineColor={64,64,64},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,-60},{-20,60}},
          lineColor={64,64,64},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={255,255,255},
          radius=10),
        Rectangle(
          extent={{20,-60},{100,60}},
          lineColor={64,64,64},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={255,255,255},
          radius=10),
        Rectangle(extent={{-100,60},{-20,-60}}, lineColor={64,64,64}, radius=10),
        Rectangle(extent={{20,60},{100,-60}}, lineColor={64,64,64}, radius=10),
        Text(
          extent={{-90,14},{-54,-11}},
          textColor={128,128,128},
          textString="a"),
        Text(
          extent={{51,11},{87,-14}},
          textColor={128,128,128},
          textString="b"),
        Line(
          points={{-90,-70},{-25,30},{25,-30},{90,70}},
          color={255,0,0},
          thickness=0.5)}),
    Documentation(info="<html>
<p>
Joint where frame_b rotates around axis n which is fixed in frame_a and
where this joint is used in a planar loop providing 2 constraint equations
on position level.
</p>

<p>
If a <strong>planar loop</strong> is present, e.g., consisting of 4 revolute joints
where the joint axes are all parallel to each other, then there is no
unique mathematical solution if all revolute joints are modelled with
Joints.Revolute and the symbolic algorithms will
fail. The reason is that, e.g., the cut-forces in the revolute joints perpendicular
to the planar loop are not uniquely defined when 3-dim. descriptions of revolute
joints are used. Usually, an error message will be printed pointing out this
situation. In this case, <strong>one</strong> revolute joint in the loop has to be replaced by
model Joints.RevolutePlanarLoopCutJoint. The
effect is that from the 5 constraints of a 3-dim. revolute joint,
3 constraints are removed and replaced by appropriate known
variables (e.g., the force in the direction of the axis of rotation is
treated as known with value equal to zero; for standard revolute joints,
this force is an unknown quantity).
</p>

</html>"));
end RevolutePlanarLoopConstraint;
