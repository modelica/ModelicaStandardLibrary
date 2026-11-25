within Modelica.Mechanics.MultiBody.Joints.Constraints;
model Revolute
  "Revolute cut-joint and translational directions may be constrained or released"
  extends Modelica.Mechanics.MultiBody.Interfaces.PartialConstraint;

  parameter Boolean animation=true
    "= true, if animation shall be enabled (show sphere)";
  parameter Types.Axis n={0,1,0}
    "Axis of rotation resolved in frame_a (= same as in frame_b)"
    annotation (Evaluate=true);

  parameter SI.Distance sphereDiameter=world.defaultJointLength /3
    "Diameter of sphere representing the spherical joint"
    annotation (Dialog(group="if animation = true", enable=animation));
  input Types.Color sphereColor=Types.Defaults.JointColor
    "Color of sphere representing the spherical joint"
    annotation (Dialog(colorSelector=true, group="if animation = true", enable=animation));
  input Types.SpecularCoefficient specularCoefficient=world.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (Dialog(group="if animation = true", enable=animation));

protected
  parameter Real e[3](each final unit="1")=Modelica.Math.Vectors.normalizeWithAssert(n)
    "Unit vector in direction of rotation axis, resolved in frame_a (= same as in frame_b)";

  parameter Real nnx_a[3](each final unit="1")=
    if abs(e[1]) > 0.1 then {0,1,0} else (if abs(e[2]) > 0.1 then {0,0,1} else {1,0,0})
    "Arbitrary vector that is not aligned with rotation axis n"
    annotation (Evaluate=true);
  parameter Real ey_a[3](each final unit="1")=
    Modelica.Math.Vectors.normalizeWithAssert(cross(e, nnx_a))
    "Unit vector orthogonal to axis n of revolute joint, resolved in frame_a"
    annotation (Evaluate=true);
  parameter Real ex_a[3](each final unit="1")=cross(ey_a, e)
    "Unit vector orthogonal to axis n of revolute joint and to ey_a, resolved in frame_a";

public
  Visualizers.Advanced.Shape sphere(
    shapeType="sphere",
    color=sphereColor,
    specularCoefficient=specularCoefficient,
    length=sphereDiameter,
    width=sphereDiameter,
    height=sphereDiameter,
    lengthDirection={1,0,0},
    widthDirection={0,1,0},
    r_shape={-0.5,0,0}*sphereDiameter,
    r=frame_a.r_0,
    R=frame_a.R) if world.enableAnimation and animation;

equation
  // Constraint equations concerning rotations
  0 = ex_a*R_rel.T*e;
  0 = ey_a*R_rel.T*e;
  frame_a.t*n=0;

  annotation ( defaultComponentName="constraint",
    Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-150,-110},{150,-80}},
          textString="n=%n"),
        Rectangle(
          extent={{-100,-60},{-30,60}},
          lineColor={64,64,64},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={255,255,255},
          radius=10),
        Rectangle(
          extent={{30,-60},{100,60}},
          lineColor={64,64,64},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={255,255,255},
          radius=10),
        Rectangle(extent={{-100,60},{-30,-60}}, lineColor={64,64,64}, radius=10),
        Rectangle(extent={{30,60},{100,-60}}, lineColor={64,64,64}, radius=10),
        Rectangle(
          extent={{-30,11},{30,-10}},
          lineColor={64,64,64},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-90,-70},{-25,30},{25,-30},{90,70}},
          color={255,0,0},
          thickness=0.5),
        Text(
          extent={{-100,40},{100,20}},
          textString="constraint"),
        Text(
          extent={{-150,110},{150,70}},
          textColor={0,0,255},
          textString="%name")}),
    Documentation(info="<html>
<p>This model does not use explicit variables e.g. state variables in order to describe the relative motion of frame_b with respect to frame_a, but defines kinematic constraints between the frame_a and frame_b. The forces and torques at both frames are then evaluated in such a way that the constraints are satisfied. Sometimes this type of formulation is also called an implicit joint in literature.</p>
<p>As a consequence of the formulation the relative kinematics between frame_a and frame_b cannot be initialized.</p>
<p>In particular in complex multibody systems with closed loops this may help to simplify the system of non-linear equations. Please compare the translation log using the classical joint formulation and the alternative formulation used here in order to check whether this fact applies to the particular system under consideration.</p>
<p>In systems without closed loops the use of this implicit joint does not make sense or may even be disadvantageous.</p>
<p>See the subpackage <a href=\"Modelica://Modelica.Mechanics.MultiBody.Examples.Constraints\">Examples.Constraints</a> for testing the joint.</p>
</html>"));
end Revolute;
