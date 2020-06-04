within Modelica.Mechanics.MultiBody.Joints;
model Revolute
  "Revolute joint (1 rotational degree-of-freedom, 2 potential states, optional axis flange)"

  Modelica.Mechanics.Rotational.Interfaces.Flange_a axis if useAxisFlange
    "1-dim. rotational flange that drives the joint"
    annotation (Placement(transformation(extent={{10,90},{-10,110}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b support if useAxisFlange
    "1-dim. rotational flange of the drive support (assumed to be fixed in the world frame, NOT in the joint)"
    annotation (Placement(transformation(extent={{-70,90},{-50,110}})));

  Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a
    "Coordinate system fixed to the joint with one cut-force and cut-torque"
    annotation (Placement(transformation(extent={{-116,-16},{-84,16}})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b frame_b
    "Coordinate system fixed to the joint with one cut-force and cut-torque"
    annotation (Placement(transformation(extent={{84,-16},{116,16}})));

  parameter Boolean useAxisFlange=false "= true, if axis flange is enabled"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean animation=true
    "= true, if animation shall be enabled (show axis as cylinder)";
  parameter Modelica.Mechanics.MultiBody.Types.Axis n={0,0,1}
    "Axis of rotation resolved in frame_a (= same as in frame_b)"
    annotation (Evaluate=true);
  parameter SI.Distance cylinderLength=world.defaultJointLength
    "Length of cylinder representing the joint axis"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
  parameter SI.Distance cylinderDiameter=world.defaultJointWidth
    "Diameter of cylinder representing the joint axis"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
  input Modelica.Mechanics.MultiBody.Types.Color cylinderColor=Modelica.Mechanics.MultiBody.Types.Defaults.JointColor
    "Color of cylinder representing the joint axis"
    annotation (Dialog(colorSelector=true, tab="Animation", group="if animation = true", enable=animation));
  input Modelica.Mechanics.MultiBody.Types.SpecularCoefficient
    specularCoefficient = world.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
  parameter StateSelect stateSelect=StateSelect.prefer
    "Priority to use joint angle phi and w=der(phi) as states" annotation(Dialog(tab="Advanced"));

  SI.Angle phi(start=0, final stateSelect=stateSelect)
    "Relative rotation angle from frame_a to frame_b"
     annotation (unassignedMessage="
The rotation angle phi of a revolute joint cannot be determined.
Possible reasons:
- A non-zero mass might be missing on either side of the parts
  connected to the revolute joint.
- Too many StateSelect.always are defined and the model
  has less degrees of freedom as specified with this setting
  (remove all StateSelect.always settings).
");
  SI.AngularVelocity w(start=0, stateSelect=stateSelect)
    "First derivative of angle phi (relative angular velocity)";
  SI.AngularAcceleration a(start=0)
    "Second derivative of angle phi (relative angular acceleration)";
  SI.Torque tau "Driving torque in direction of axis of rotation";
  SI.Angle angle "= phi";

protected
  outer Modelica.Mechanics.MultiBody.World world;
  parameter Real e[3](each final unit="1")=Modelica.Math.Vectors.normalizeWithAssert(n)
    "Unit vector in direction of rotation axis, resolved in frame_a (= same as in frame_b)";
  Frames.Orientation R_rel
    "Relative orientation object from frame_a to frame_b or from frame_b to frame_a";
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

protected
  Modelica.Mechanics.Rotational.Components.Fixed fixed
    "support flange is fixed to ground"
    annotation (Placement(transformation(extent={{-70,70},{-50,90}})));
  Rotational.Interfaces.InternalSupport internalAxis(tau=tau)
    annotation (Placement(transformation(extent={{-10,90},{10,70}})));
  Rotational.Sources.ConstantTorque constantTorque(tau_constant=0) if not useAxisFlange
    annotation (Placement(transformation(extent={{40,70},{20,90}})));
equation
  Connections.branch(frame_a.R, frame_b.R);

  assert(cardinality(frame_a) > 0,
    "Connector frame_a of revolute joint is not connected");
  assert(cardinality(frame_b) > 0,
    "Connector frame_b of revolute joint is not connected");

  angle = phi;
  w = der(phi);
  a = der(w);

  // relationships between quantities of frame_a and of frame_b
  frame_b.r_0 = frame_a.r_0;

  if Connections.rooted(frame_a.R) then
    R_rel = Frames.planarRotation(e, phi, w);
    frame_b.R = Frames.absoluteRotation(frame_a.R, R_rel);
    frame_a.f = -Frames.resolve1(R_rel, frame_b.f);
    frame_a.t = -Frames.resolve1(R_rel, frame_b.t);
  else
    R_rel = Frames.planarRotation(-e, phi, w);
    frame_a.R = Frames.absoluteRotation(frame_b.R, R_rel);
    frame_b.f = -Frames.resolve1(R_rel, frame_a.f);
    frame_b.t = -Frames.resolve1(R_rel, frame_a.t);
  end if;

  // d'Alemberts principle
  tau = -frame_b.t*e;

  // Connection to internal connectors
  phi = internalAxis.phi;

  connect(fixed.flange, support) annotation (Line(
      points={{-60,80},{-60,100}}));
  connect(internalAxis.flange, axis) annotation (Line(
      points={{0,80},{0,100}}));
  connect(constantTorque.flange, internalAxis.flange) annotation (Line(
      points={{20,80},{0,80}}));
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
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
        Text(
          extent={{-90,14},{-54,-11}},
          textColor={128,128,128},
          textString="a"),
        Text(
          extent={{51,11},{87,-14}},
          textColor={128,128,128},
          textString="b"),
        Line(
          visible=useAxisFlange,
          points={{-20,80},{-20,60}}),
        Line(
          visible=useAxisFlange,
          points={{20,80},{20,60}}),
        Rectangle(
          visible=useAxisFlange,
          extent={{-10,100},{10,50}},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={192,192,192}),
        Polygon(
          visible=useAxisFlange,
          points={{-10,30},{10,30},{30,50},{-30,50},{-10,30}},
          lineColor={64,64,64},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-30,11},{30,-10}},
          lineColor={64,64,64},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Polygon(
          visible=useAxisFlange,
          points={{10,30},{30,50},{30,-50},{10,-30},{10,30}},
          lineColor={64,64,64},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,-110},{150,-80}},
          textString="n=%n"),
        Text(
          visible=useAxisFlange,
          extent={{-150,-155},{150,-115}},
          textString="%name",
          textColor={0,0,255}),
        Line(
          visible=useAxisFlange,
          points={{-20,70},{-60,70},{-60,60}}),
        Line(
          visible=useAxisFlange,
          points={{20,70},{50,70},{50,60}}),
        Line(
          visible=useAxisFlange,
          points={{-90,100},{-30,100}}),
        Line(
          visible=useAxisFlange,
          points={{-30,100},{-50,80}}),
        Line(
          visible=useAxisFlange,
          points={{-49,100},{-70,80}}),
        Line(
          visible=useAxisFlange,
          points={{-70,100},{-90,80}}),
        Text(
          visible=not useAxisFlange,
          extent={{-150,70},{150,110}},
          textString="%name",
          textColor={0,0,255})}),
    Documentation(info="<html>

<p>
Joint where frame_b rotates around axis n which is fixed in frame_a.
The two frames coincide when the rotation angle \"phi = 0\".
</p>

<p>
Optionally, two additional 1-dimensional mechanical flanges
(flange \"axis\" represents the driving flange and
flange \"support\" represents the bearing) can be enabled via
parameter <strong>useAxisFlange</strong>. The enabled axis flange can be
driven with elements of the
<a href=\"modelica://Modelica.Mechanics.Rotational\">Modelica.Mechanics.Rotational</a>
library.

</p>

<p>
In the \"Advanced\" menu it can be defined via parameter <strong>stateSelect</strong>
that the rotation angle \"phi\" and its derivative shall be definitely
used as states by setting stateSelect=StateSelect.always.
Default is StateSelect.prefer to use the joint angle and its
derivative as preferred states. The states are usually selected automatically.
In certain situations, especially when closed kinematic loops are present,
it might be slightly more efficient, when using the StateSelect.always setting.
</p>
<p>
If a <strong>planar loop</strong> is present, e.g., consisting of 4 revolute joints
where the joint axes are all parallel to each other, then there is no
longer a unique mathematical solution and the symbolic algorithms will
fail. Usually, an error message will be printed pointing out this
situation. In this case, one revolute joint of the loop has to be replaced
by a Joints.RevolutePlanarLoopConstraint joint. The
effect is that from the 5 constraints of a usual revolute joint,
3 constraints are removed and replaced by appropriate known
variables (e.g., the force in the direction of the axis of rotation is
treated as known with value equal to zero; for standard revolute joints,
this force is an unknown quantity).
</p>

<p>
In the following figure the animation of a revolute
joint is shown. The light blue coordinate system is
frame_a and the dark blue coordinate system is
frame_b of the joint. The black arrow is parameter
vector \"n\" defining the translation axis
(here: n = {0,0,1}, phi.start = 45<sup>o</sup>).
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Joints/Revolute.png\">
</div>

</html>"));
end Revolute;
