within Modelica.Mechanics.MultiBody.Joints.Constraints;
model Prismatic
  "Prismatic cut-joint and translational directions may be constrained or released"
  extends Modelica.Mechanics.MultiBody.Interfaces.PartialTwoFrames;

  parameter Boolean x_locked=true
    "= true: constraint force in x-direction, resolved in frame_a"
    annotation (Dialog(group="Constraints"),choices(checkBox=true));
  parameter Boolean y_locked=true
    "= true: constraint force in y-direction, resolved in frame_a"
    annotation (Dialog(group="Constraints"),choices(checkBox=true));
  parameter Boolean z_locked=true
    "= true: constraint force in z-direction, resolved in frame_a"
    annotation (Dialog(group="Constraints"),choices(checkBox=true));

  parameter Boolean animation=true
    "= true, if animation shall be enabled (show sphere)";
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
  Frames.Orientation R_rel
    "Dummy or relative orientation object from frame_a to frame_b";
  SI.Position r_rel_a[3]
    "Position vector from origin of frame_a to origin of frame_b, resolved in frame_a";
  SI.InstantaneousPower P;

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
  // Determine relative position vector resolved in frame_a
  R_rel = Frames.relativeRotation(frame_a.R, frame_b.R);
  r_rel_a = Frames.resolve2(frame_a.R, frame_b.r_0 - frame_a.r_0);

  // Constraint equations concerning rotations
  // Same logic as for overdetermined connection graph loops to get good residuals.
  zeros(3)=Modelica.Mechanics.MultiBody.Frames.Orientation.equalityConstraint(frame_a.R, frame_b.R);

  // Constraint equations concerning translations
  if x_locked then
    r_rel_a[1]=0;
  else
    frame_a.f[1]=0;
  end if;

  if y_locked then
    r_rel_a[2]=0;
  else
    frame_a.f[2]=0;
  end if;

  if z_locked then
    r_rel_a[3]=0;
  else
    frame_a.f[3]=0;
  end if;

  zeros(3) = frame_a.t + Frames.resolve1(R_rel, frame_b.t) + cross(r_rel_a,
    Frames.resolve1(R_rel, frame_b.f));
  zeros(3) = Frames.resolve1(R_rel, frame_b.f) + frame_a.f;
  P = frame_a.t*Frames.angularVelocity2(frame_a.R) + frame_b.t*
    Frames.angularVelocity2(frame_b.R) + frame_b.f*Frames.resolve2(frame_b.R,
    der(frame_b.r_0)) + frame_a.f*Frames.resolve2(frame_a.R, der(frame_a.r_0));

  annotation (
    defaultComponentName="constraint",
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-30,-30},{100,20}},
          pattern=LinePattern.None,
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255}),
        Rectangle(
          extent={{-100,-50},{-30,41}},
          pattern=LinePattern.None,
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255}),
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
        Rectangle(
          extent={{-100,40},{-30,50}},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255}),
        Rectangle(
          extent={{-30,20},{100,30}},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255}),
        Line(points={{100,-30},{100,30}}),
        Line(points={{-30,-50},{-30,50}}),
        Line(
          points={{-90,-70},{-25,30},{25,-30},{90,70}},
          color={255,0,0},
          thickness=0.5),
        Text(
          extent={{-150,100},{150,60}},
          textColor={0,0,255},
          textString="%name")}),
    Documentation(info="<html>
<p>This model does not use explicit variables e.g. state variables in order to describe the relative motion of frame_b with respect to frame_a, but defines kinematic constraints between the frame_a and frame_b. The forces and torques at both frames are then evaluated in such a way that the constraints are satisfied.  Sometimes this type of formulation is also called an implicit joint in literature.</p>
<p>As a consequence of the formulation the relative kinematics between frame_a and frame_b cannot be initialized.</p>
<p>In particular in complex multibody systems with closed loops this may help to simplify the system of non-linear equations. Please compare the translation log using the classical joint formulation and the alternative formulation used here in order to check whether this fact applies to the particular system under consideration.</p>
<p>In systems without closed loops the use of this implicit joint does not make sense or may even be disadvantageous.</p>
<p>See the subpackage <a href=\"Modelica://Modelica.Mechanics.MultiBody.Examples.Constraints\">Examples.Constraints</a> for testing the joint.</p>
</html>",revisions="<html><p><strong>Release Notes:</strong></p>
<ul>
  <li><em>February 4, 2021</em><br>
         Improved numeric stability by re-using <a href=\"Modelica://Modelica.Mechanics.MultiBody.Frames.Orientation.equalityConstraint\">equalityConstraint</a> from connection handling as constraint.
         This ensures that the constraint has non-singular Jacobian and only one solution.
  </li>
</ul>
</html>"));
end Prismatic;
