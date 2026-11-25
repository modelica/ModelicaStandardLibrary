within Modelica.Mechanics.MultiBody.Joints.Constraints;
model Spherical
  "Spherical cut joint and translational directions may be constrained or released"
  extends Modelica.Mechanics.MultiBody.Interfaces.PartialConstraint;

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

  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape sphere(
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
  //frame_a.t = zeros(3);
  frame_b.t = zeros(3);

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
          extent={{-60,-60},{60,60}},
          fillPattern=FillPattern.Solid,
          fillColor={192,192,192},
          lineColor={0,0,0},
          closure=EllipseClosure.Radial,
          startAngle=60,
          endAngle=300),
        Ellipse(
          extent={{-44,-44},{44,44}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          closure=EllipseClosure.Radial,
          startAngle=55,
          endAngle=305),
        Ellipse(
          extent={{-44,-44},{44,44}},
          startAngle=60,
          endAngle=300,
          lineColor={0,0,0},
          closure=EllipseClosure.None),
        Ellipse(
          extent={{-26,26},{26,-26}},
          fillPattern=FillPattern.Sphere,
          fillColor={192,192,192},
          lineColor={0,0,0}),
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
          extent={{-100,-70},{100,-100}},
          textColor={95,95,95},
          textString="lock: x, y, z",
          visible=x_locked and y_locked and z_locked),
        Line(
          points={{-90,-70},{-25,30},{25,-30},{90,70}},
          color={255,0,0},
          thickness=0.5),
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
end Spherical;
