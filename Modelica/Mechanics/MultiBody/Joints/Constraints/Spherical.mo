within Modelica.Mechanics.MultiBody.Joints.Constraints;
model Spherical
  "Spherical cut joint and translational directions may be constrained or released"
  extends Modelica.Mechanics.MultiBody.Interfaces.PartialTwoFrames;
  import MBS = Modelica.Mechanics.MultiBody;

  parameter Boolean x_locked=true
    "= true: constraint force in x-direction, resolved in frame_a"
    annotation (Dialog(group="Constraints"), choices(checkBox=true));
  parameter Boolean y_locked=true
    "= true: constraint force in y-direction, resolved in frame_a"
    annotation (Dialog(group="Constraints"), choices(checkBox=true));
  parameter Boolean z_locked=true
    "= true: constraint force in z-direction, resolved in frame_a"
    annotation (Dialog(group="Constraints"), choices(checkBox=true));

  parameter Boolean animation=true
    "= true, if animation shall be enabled (show sphere)"
    annotation (Dialog(group="Animation"));
  parameter SI.Distance sphereDiameter=world.defaultJointLength /3
    "Diameter of sphere representing the spherical joint"
    annotation (Dialog(group="Animation", enable=animation));
  input MBS.Types.Color sphereColor=MBS.Types.Defaults.JointColor
    "Color of sphere representing the spherical joint"
    annotation (Dialog(colorSelector=true, group="Animation", enable=animation));
  input MBS.Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient
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
protected
  MBS.Frames.Orientation R_rel
    "Dummy or relative orientation object from frame_a to frame_b";
  SI.Position r_rel_a[3]
    "Position vector from origin of frame_a to origin of frame_b, resolved in frame_a";
  SI.InstantaneousPower P;

equation
  // Determine relative position vector resolved in frame_a
  R_rel = MBS.Frames.relativeRotation(frame_a.R, frame_b.R);
  r_rel_a = MBS.Frames.resolve2(frame_a.R, frame_b.r_0 - frame_a.r_0);

  // Constraint equations concerning translation
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

  //frame_a.t = zeros(3);
  frame_b.t = zeros(3);
  frame_b.f = -MBS.Frames.resolve2(R_rel, frame_a.f);
  zeros(3) = frame_a.t + MBS.Frames.resolve1(R_rel, frame_b.t) - cross(r_rel_a, frame_a.f);
  P= frame_a.t*MBS.Frames.angularVelocity2(frame_a.R)+frame_b.t*MBS.Frames.angularVelocity2(frame_b.R) + MBS.Frames.resolve1(frame_b.R,frame_b.f)*der(frame_b.r_0)+MBS.Frames.resolve1(frame_a.R,frame_a.f)*der(frame_a.r_0);
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
<p>This model does not use explicit variables e.g. state variables in order to describe the relative motion of frame_b with to respect to frame_a, but defines kinematic constraints between the frame_a and frame_b. The forces and torques at both frames are then evaluated in such a way that the constraints are satisfied. Sometimes this type of formulation is also called an implicit joint in literature.</p>
<p>As a consequence of the formulation the relative kinematics between frame_a and frame_b cannot be initialized.</p>
<p>In particular in complex multibody systems with closed loops this may help to simplify the system of non-linear equations. Please compare the translation log using the classical joint formulation and the alternative formulation used here in order to check whether this fact applies to the particular system under consideration.</p>
<p>In systems without closed loops the use of this implicit joint does not make sense or may even be disadvantageous.</p>
<p>See the subpackage <a href=\"Modelica://Modelica.Mechanics.MultiBody.Examples.Constraints\">Examples.Constraints</a> for testing the joint.</p>
</html>"));
end Spherical;
