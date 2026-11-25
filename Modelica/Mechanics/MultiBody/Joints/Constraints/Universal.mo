within Modelica.Mechanics.MultiBody.Joints.Constraints;
model Universal
  "Universal cut-joint and translational directions may be constrained or released"
  extends Modelica.Mechanics.MultiBody.Interfaces.PartialConstraint;

  parameter Types.Axis n_a={1,0,0}
    "Axis of revolute joint 1 resolved in frame_a" annotation (Evaluate=true);
  parameter Types.Axis n_b={0,1,0}
    "Axis of revolute joint 2 resolved in frame_b" annotation (Evaluate=true);

  parameter Boolean animation=true
    "= true, if animation shall be enabled (show sphere)"
    annotation (Dialog(group="Animation"));
  parameter SI.Distance sphereDiameter=world.defaultJointLength /3
    "Diameter of sphere representing the spherical joint"
    annotation (Dialog(group="Animation", enable=animation));
  input Types.Color sphereColor=Types.Defaults.JointColor
    "Color of sphere representing the spherical joint"
    annotation (Dialog(colorSelector=true, group="Animation", enable=animation));
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (Dialog(group="Animation", enable=animation));
protected
  Real w_rel[3];

equation
  w_rel = Frames.angularVelocity1(R_rel);

  // Constraint equations concerning rotations
  frame_a.t * n_a = 0;
  frame_b.t * n_b = 0;
  n_b * Frames.resolve2(R_rel, n_a) = 0; // Constraint: R_rel shall assure orthogonality of n_a and n_b
  assert(abs(n_a*n_b) < Modelica.Constants.eps, "The two axes that constitute the Constraints.Universal joint must be different");

  annotation (
    defaultComponentName="constraint",
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-100,10},{100,-10}},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={192,192,192}),
        Ellipse(
          extent={{-80,-80},{80,80}},
          lineColor={64,64,64},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid,
          startAngle=90,
          endAngle=270),
        Ellipse(
          extent={{-60,-60},{60,60}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          startAngle=89,
          endAngle=271,
          closure=EllipseClosure.Radial),
        Line(
          points={{0,80},{0,-80}},
          thickness=0.5),
        Ellipse(
          extent={{-60,-60},{60,60}},
          lineColor={64,64,64},
          startAngle=90,
          endAngle=270,
          closure=EllipseClosure.None),
        Ellipse(
          extent={{-70,-40},{70,40}},
          lineColor={64,64,64},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid,
          startAngle=-120,
          endAngle=60),
        Ellipse(
          extent={{-50,-22},{50,24}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-100,-70},{100,-100}},
          textColor={95,95,95},
          textString="lock: x",
          visible=x_locked and not y_locked and not z_locked),
        Text(
          extent={{-100,-70},{100,-100}},
          textColor={95,95,95},
          textString="lock: y",
          visible=not x_locked and y_locked and not z_locked),
        Text(
          extent={{-100,-70},{100,-100}},
          textColor={95,95,95},
          textString="lock: z",
          visible=not x_locked and not y_locked and z_locked),
        Text(
          extent={{-100,-70},{100,-100}},
          textColor={95,95,95},
          textString="lock: x, y",
          visible=x_locked and y_locked and not z_locked),
        Text(
          extent={{-100,-70},{100,-100}},
          textColor={95,95,95},
          textString="lock: x, z",
          visible=x_locked and not y_locked and z_locked),
        Text(
          extent={{-100,-70},{100,-100}},
          textColor={95,95,95},
          textString="lock: y, z",
          visible=not x_locked and y_locked and z_locked),
        Text(
          extent={{-100,-80},{100,-110}},
          textColor={95,95,95},
          textString="lock: x, y, z",
          visible=x_locked and y_locked and z_locked),
        Ellipse(
          extent={{-50,-22},{50,24}},
          lineColor={64,64,64},
          startAngle=-113,
          endAngle=63,
          closure=EllipseClosure.None),
        Line(
          points={{40,40},{-40,-40}},
          thickness=0.5),
        Line(
          points={{0,72},{0,-20}},
          thickness=0.5),
        Line(
          points={{-90,-70},{-25,30},{25,-30},{90,70}},
          color={255,0,0},
          thickness=0.5),
        Text(
          extent={{-150,120},{150,80}},
          textColor={0,0,255},
          textString="%name")}),
    Documentation(info="<html>
<p>This model does not use explicit variables e.g. state variables in order to describe the relative motion of frame_b with respect to frame_a, but defines kinematic constraints between the frame_a and frame_b. The forces and torques at both frames are then evaluated in such a way that the constraints are satisfied. Sometimes this type of formulation is also called an implicit joint in literature.</p>
<p>As a consequence of the formulation the relative kinematics between frame_a and frame_b cannot be initialized.</p>
<p>In particular in complex multibody systems with closed loops this may help to simplify the system of non-linear equations. Please compare the translation log using the classical joint formulation and the alternative formulation used here in order to check whether this fact applies to the particular system under consideration.</p>
<p>In systems without closed loops the use of this implicit joint does not make sense or may even be disadvantageous.</p>
<p>See the subpackage <a href=\"Modelica://Modelica.Mechanics.MultiBody.Examples.Constraints\">Examples.Constraints</a> for testing the joint.</p>
</html>"));
end Universal;
