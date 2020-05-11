within Modelica.Mechanics.MultiBody.Sensors;
model AbsoluteSensor
  "Measure absolute kinematic quantities of frame connector"

  Blocks.Interfaces.RealOutput r[3](
    each final quantity="Length",
    each final unit="m") if get_r
    "Absolute position vector frame_a.r_0 resolved in frame defined by resolveInFrame"
    annotation (Placement(transformation(
        origin={-100,-110},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Blocks.Interfaces.RealOutput v[3](
    each final quantity="Velocity",
    each final unit="m/s") if get_v "Absolute velocity vector"
    annotation (Placement(transformation(
        origin={-60,-110},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Blocks.Interfaces.RealOutput a[3](
    each final quantity="Acceleration",
    each final unit="m/s2") if get_a "Absolute acceleration vector"
    annotation (Placement(transformation(
        origin={-20,-110},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Blocks.Interfaces.RealOutput angles[3](
    each final quantity="Angle",
    each final unit="rad",
    each displayUnit="deg") if get_angles
    "Angles to rotate world frame into frame_a via 'sequence'"
    annotation (Placement(transformation(
        origin={20,-110},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Blocks.Interfaces.RealOutput w[3](each final quantity="AngularVelocity",
      each final unit="1/s") if get_w "Absolute angular velocity vector"
    annotation (Placement(transformation(
        origin={60,-110},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Blocks.Interfaces.RealOutput z[3](each final quantity="AngularAcceleration",
      each final unit="1/s2") if get_z "Absolute angular acceleration vector"
    annotation (Placement(transformation(
        origin={100,-110},
        extent={{10,-10},{-10,10}},
        rotation=90)));

  extends Modelica.Mechanics.MultiBody.Sensors.Internal.PartialAbsoluteSensor;

  Interfaces.Frame_resolve frame_resolve if resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_resolve
    "If resolveInFrame = Types.ResolveInFrameA.frame_resolve, the output signals are resolved in this frame"
     annotation (Placement(transformation(
          extent={{84,-16},{116,16}})));

  parameter Boolean animation=true
    "= true, if animation shall be enabled (show arrow)";
  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameA resolveInFrame=
      Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a
    "Frame in which vectors are resolved (world, frame_a, or frame_resolve)";
  parameter Boolean get_r=false
    "= true, to measure the absolute position vector of the origin of frame_a"
    annotation(HideResult=true, choices(checkBox=true));
  parameter Boolean get_v=false
    "= true, to measure the absolute velocity of the origin of frame_a"
    annotation(HideResult=true, choices(checkBox=true));
  parameter Boolean get_a=false
    "= true, to measure the absolute acceleration of the origin of frame_a"
    annotation(HideResult=true, choices(checkBox=true));
  parameter Boolean get_w=false
    "= true, to measure the absolute angular velocity of frame_a"
    annotation(HideResult=true, choices(checkBox=true));
  parameter Boolean get_z=false
    "= true, to measure the absolute angular acceleration of frame_a"
    annotation(HideResult=true, choices(checkBox=true));
  parameter Boolean get_angles=false
    "= true, to measure the 3 rotation angles"
    annotation(HideResult=true, choices(checkBox=true), Dialog(group="3 angles to rotate the world frame into frame_a along the axes defined in \"sequence\""));
  parameter Types.RotationSequence sequence(
    min={1,1,1},
    max={3,3,3}) = {1,2,3}
    "If get_angles=true: Angles are returned to rotate world frame around axes sequence[1], sequence[2] and finally sequence[3] into frame_a"
    annotation (HideResult=true,Evaluate=true, Dialog(group="3 angles to rotate the world frame into frame_a along the axes defined in \"sequence\"", enable=get_angles));
  parameter SI.Angle guessAngle1=0
    "If get_angles=true: Select angles[1] such that abs(angles[1] - guessAngle1) is a minimum"
    annotation (HideResult=true,Dialog(group="3 angles to rotate the world frame into frame_a along the axes defined in \"sequence\"", enable=get_angles));

  input Types.Color arrowColor=Modelica.Mechanics.MultiBody.Types.Defaults.SensorColor
    "Color of absolute arrow from world frame to frame_b"
    annotation (Dialog(colorSelector=true, tab="Animation", group="if animation = true", enable=animation));
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));

protected
  AbsolutePosition position(resolveInFrame=resolveInFrame) if get_r
    annotation (Placement(transformation(extent={{10,10},{-10,30}},
        rotation=90,
        origin={-80,-60})));

protected
  AbsoluteVelocity velocity(resolveInFrame=resolveInFrame) if get_v
                                                           annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-60,-60})));
  Modelica.Mechanics.MultiBody.Sensors.AbsoluteAngles absoluteAngles(sequence=sequence, guessAngle1=guessAngle1) if get_angles annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={20,-60})));
  AbsoluteAngularVelocity angularVelocity(resolveInFrame=resolveInFrame) if get_w
    annotation (Placement(transformation(extent={{-10,-10},{10,-30}},
        rotation=-90,
        origin={70,-60})));

protected
  Blocks.Continuous.Der der1[3] if get_a annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={-20,-34})));
protected
  Blocks.Continuous.Der der2[3] if get_z annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={100,-46})));

protected
  Modelica.Mechanics.MultiBody.Sensors.TransformAbsoluteVector transformVector_a(frame_r_in=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.world, frame_r_out=resolveInFrame) if get_a annotation (Placement(transformation(extent={{-10,-70},{-30,-50}})));
  Modelica.Mechanics.MultiBody.Sensors.TransformAbsoluteVector transformVector_z(frame_r_in=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.world, frame_r_out=resolveInFrame) if get_z annotation (Placement(transformation(extent={{90,-80},{110,-60}})));

protected
  outer Modelica.Mechanics.MultiBody.World world;

  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Arrow arrow(
    r_head=frame_a.r_0,
    color=arrowColor,
    specularCoefficient) if world.enableAnimation and animation;

protected
  AbsoluteVelocity absoluteVelocity(resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.world) if get_a
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-20,-12})));
  AbsoluteAngularVelocity absoluteAngularVelocity(resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.world) if
       get_z
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Mechanics.MultiBody.Forces.Internal.ZeroForceAndTorque zeroForce1
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  Modelica.Mechanics.MultiBody.Forces.Internal.ZeroForceAndTorque zeroForce2 if resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_resolve
    annotation (Placement(transformation(extent={{80,20},{60,40}})));
equation
  connect(zeroForce1.frame_a, frame_a)
                                  annotation (Line(
      points={{-60,30},{-80,30},{-80,0},{-100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(absoluteAngles.angles, angles) annotation (Line(
      points={{20,-71},{20,-90},{20,-90},{20,-110}}, color={0,0,127}));
  connect(angularVelocity.frame_a, frame_a) annotation (Line(
      points={{50,-50},{50,-40},{20,-40},{20,0},{-100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(angularVelocity.w, w) annotation (Line(
      points={{50,-71},{50,-94},{60,-94},{60,-110}}, color={0,0,127}));
  connect(frame_resolve, position.frame_resolve) annotation (Line(
      points={{100,0},{114,0},{114,-90},{-80,-90},{-80,-60},{-90,-60}},
      color={95,95,95},
      pattern=LinePattern.Dot));
  connect(frame_resolve,zeroForce2. frame_a) annotation (Line(
      points={{100,0},{90,0},{90,30},{80,30}},
      color={95,95,95},
      pattern=LinePattern.Dot));
  connect(angularVelocity.frame_resolve, frame_resolve) annotation (
      Line(
      points={{60,-60},{66,-60},{66,-90},{114,-90},{114,0},{100,0}},
      color={95,95,95},
      pattern=LinePattern.Dot));
  connect(transformVector_a.frame_a, frame_a) annotation (Line(
      points={{-10,-60},{0,-60},{0,-40},{20,-40},{20,0},{-100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(transformVector_a.frame_resolve, frame_resolve) annotation (Line(
      points={{-30,-60},{-40,-60},{-40,-90},{114,-90},{114,0},{100,0}},
      color={95,95,95},
      pattern=LinePattern.Dot));
  connect(transformVector_a.r_out, a) annotation (Line(
      points={{-20,-71},{-20,-110}}, color={0,0,127}));
  connect(der2.y, transformVector_z.r_in) annotation (Line(
      points={{100,-52.6},{100,-58}}, color={0,0,127}));
  connect(transformVector_z.r_out, z) annotation (Line(
      points={{100,-81},{100,-110}}, color={0,0,127}));
  connect(transformVector_z.frame_a, frame_a) annotation (Line(
      points={{90,-70},{80,-70},{80,-40},{20,-40},{20,0},{-100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(transformVector_z.frame_resolve, frame_resolve) annotation (Line(
      points={{110,-70},{110,-70},{114,-70},{114,0},{100,0}},
      color={95,95,95},
      pattern=LinePattern.Dot));
  connect(frame_a, position.frame_a) annotation (Line(
      points={{-100,0},{-80,0},{-80,-40},{-100,-40},{-100,-50}},
      color={95,95,95},
      thickness=0.5));
  connect(absoluteAngles.frame_a, frame_a) annotation (Line(
      points={{20,-50},{20,0},{-100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(position.r, r) annotation (Line(
      points={{-100,-71},{-100,-110}}, color={0,0,127}));
  connect(velocity.frame_a, frame_a) annotation (Line(
      points={{-60,-50},{-60,-40},{-80,-40},{-80,0},{-100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(velocity.frame_resolve, frame_resolve) annotation (Line(
      points={{-50,-60},{-40,-60},{-40,-90},{114,-90},{114,0},{100,0}},
      color={95,95,95},
      pattern=LinePattern.Dot));
  connect(velocity.v, v) annotation (Line(
      points={{-60,-71},{-60,-110}}, color={0,0,127}));
  connect(der1.y, transformVector_a.r_in) annotation (Line(
      points={{-20,-40.6},{-20,-48}}, color={0,0,127}));
  connect(absoluteVelocity.v, der1.u) annotation (Line(
      points={{-20,-23},{-20,-26.8}}, color={0,0,127}));
  connect(absoluteVelocity.frame_a, frame_a) annotation (Line(
      points={{-20,-2},{-20,0},{-100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(absoluteAngularVelocity.frame_a, frame_a) annotation (Line(
      points={{40,0},{-100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(absoluteAngularVelocity.w, der2.u) annotation (Line(
      points={{61,0},{80,0},{80,-30},{100,-30},{100,-38.8}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={
        Line(
          visible=get_r,
          points={{-68,-20},{-100,-40},{-100,-100}},
          color={0,0,127}),
        Line(
          visible=get_v,
          points={{-60,-36},{-60,-68}},
          color={0,0,127}),
        Line(
          visible=get_v,
          points={{-60,-94},{-60,-100}},
          color={0,0,127}),
        Line(
          visible=get_a,
          points={{-20,-67},{-20,-100}},
          color={0,0,127}),
        Line(
          visible=get_angles,
          points={{20,-67},{20,-72}},
          color={0,0,127}),
        Line(
          visible=get_angles,
          points={{20,-94},{20,-100}},
          color={0,0,127}),
        Line(
          visible=get_w,
          points={{60,-36},{60,-48}},
          color={0,0,127}),
        Line(
          visible=get_w,
          points={{60,-76},{60,-100}},
          color={0,0,127}),
        Line(
          visible=get_z,
          points={{68,-20},{100,-40},{100,-68}},
          color={0,0,127}),
        Line(
          visible=get_z,
          points={{100,-94},{100,-100}},
          color={0,0,127}),
        Line(
          points={{95,0},{95,0},{70,0}},
          pattern=LinePattern.Dot),
        Text(
          extent={{-132,76},{129,124}},
          textString="%name",
          textColor={0,0,255}),
        Text(
          visible=get_r,
          extent={{-140,-72},{-100,-92}},
          textColor={64,64,64},
          textString="m"),
        Text(
          visible=get_v,
          extent={{-90,-72},{-40,-92}},
          textColor={64,64,64},
          textString="m/s"),
        Text(
          visible=get_a,
          extent={{-50,-36},{20,-56}},
          textColor={64,64,64},
          textString="m/s2"),
        Text(
          visible=get_angles,
          extent={{-6,-72},{54,-92}},
          textColor={64,64,64},
          textString="rad"),
        Text(
          visible=get_w,
          extent={{34,-50},{104,-70}},
          textColor={64,64,64},
          textString="rad/s"),
        Text(
          visible=get_z,
          extent={{70,-72},{160,-92}},
          textColor={64,64,64},
          textString="rad/s2"),
        Text(
          extent={{60,52},{191,27}},
          textColor={95,95,95},
          textString="resolve")}),
    Documentation(info="<html>
<p>
Absolute kinematic quantities of frame_a are
determined and provided at the conditional output signal connectors.
For example, if parameter \"get_r = <strong>true</strong>\", the connector
\"r\" is enabled and contains the absolute vector from the world frame
to the origin of frame_a. The following quantities can be provided
as output signals:
</p>

<ol>
<li> Absolute position vector (= r)</li>
<li> Absolute velocity vector (= v)</li>
<li> Absolute acceleration vector (= a)</li>
<li> Three angles to rotate world frame into frame_a (= angles)</li>
<li> Absolute angular velocity vector (= w)</li>
<li> Absolute angular acceleration vector (= z)</li>
</ol>

<p>
Via parameter <strong>resolveInFrame</strong> it is defined, in which frame
a vector is resolved:
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th><strong>resolveInFrame =<br>Types.ResolveInFrameA.</strong></th><th><strong>Meaning</strong></th></tr>
<tr><td>world</td>
    <td>Resolve vectors in world frame</td></tr>

<tr><td>frame_a</td>
    <td>Resolve vectors in frame_a</td></tr>

<tr><td>frame_resolve</td>
    <td>Resolve vectors in frame_resolve</td></tr>
</table>

<p>
If resolveInFrame = Types.ResolveInFrameA.frame_resolve, the conditional connector
\"frame_resolve\" is enabled and the vectors are resolved in the frame, to
which frame_resolve is connected. Note, if this connector is enabled, it must
be connected.
</p>

<p>
In the following figure the animation of an AbsoluteSensor
component is shown. The light blue coordinate system is
frame_a and the yellow arrow is the animated sensor.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Sensors/AbsoluteSensor.png\">
</div>

<p>
Velocity, acceleration, angular velocity and angular acceleration are
determined by differentiating them in the world frame and then transforming
them in to the frame defined by <strong>resolveInFrame</strong>.
</p>
<p>
For example, if resolveInFrame = <strong>Types.ResolveInFrameA.frame_a</strong>, then
</p>
<blockquote><pre>
v0 = <strong>der</strong>(frame_a.r0);
v  = resolve2(frame_a.R, v0);
</pre></blockquote>
<p>
is returned, i.e., the derivative of the absolute distance from the
world frame to the origin of frame_a, resolved in frame_a.
</p>

<p>
The cut-force and the cut-torque in frame_resolve are
always zero, whether frame_resolve is connected or not.
</p>

<p>
If <strong>get_angles</strong> = <strong>true</strong>, the 3 angles to rotate the world
frame into frame_a along the axes defined by parameter <strong>sequence</strong>
are returned. For example, if sequence = {3,1,2} then the world frame is
rotated around angles[1] along the z-axis, afterwards it is rotated
around angles[2] along the x-axis, and finally it is rotated around
angles[3] along the y-axis and is then identical to frame_a.
The 3 angles are returned in the range
</p>
<blockquote><pre>
-&pi; &lt;= angles[i] &lt;= &pi;
</pre></blockquote>
<p>
There are <strong>two solutions</strong> for \"angles[1]\" in this range.
Via parameter <strong>guessAngle1</strong> (default = 0) the
returned solution is selected such that |angles[1] - guessAngle1| is
minimal. The absolute transformation matrix of frame_a
may be in a singular configuration with respect to \"sequence\", i.e.,
there is an infinite number of angle values leading to the same absolute
transformation matrix. In this case, the returned solution is
selected by setting angles[1] = guessAngle1. Then angles[2]
and angles[3] can be uniquely determined in the above range.
</p>
<p>
The parameter <strong>sequence</strong> has the restriction that
only values 1,2,3 can be used and that sequence[1] &ne; sequence[2]
and sequence[2] &ne; sequence[3]. Often used values are:
</p>
<blockquote><pre>
sequence = <strong>{1,2,3}</strong>  // Cardan or Tait-Bryan angle sequence
         = <strong>{3,1,3}</strong>  // Euler angle sequence
         = <strong>{3,2,1}</strong>
</pre></blockquote>
</html>"));
end AbsoluteSensor;
