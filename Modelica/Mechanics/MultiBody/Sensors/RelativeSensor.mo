within Modelica.Mechanics.MultiBody.Sensors;
model RelativeSensor
  "Measure relative kinematic quantities between two frame connectors"

  extends Modelica.Mechanics.MultiBody.Sensors.Internal.PartialRelativeSensor;

  Interfaces.Frame_resolve frame_resolve if
        resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve or
        resolveInFrameAfterDifferentiation == Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve
    "If resolveInFrame = Types.ResolveInFrameAB.frame_resolve, the output signals are resolved in this frame"
     annotation (Placement(transformation(
          extent={{84,64},{116,96}})));

  parameter Boolean animation=true
    "= true, if animation shall be enabled (show arrow)";
  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB
    resolveInFrame=
    Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_a
    "Frame in which vectors are resolved before differentiation (world, frame_a, frame_b, or frame_resolve)";
  parameter Boolean get_r_rel=false
    "= true, to measure the relative position vector from the origin of frame_a to frame_b"
    annotation(HideResult=true, choices(checkBox=true));
  parameter Boolean get_v_rel=false
    "= true, to measure the relative velocity of the origin of frame_b with respect to frame_a"
    annotation(HideResult=true, choices(checkBox=true));
  parameter Boolean get_a_rel=false
    "= true, to measure the relative acceleration of the origin of frame_b with respect to frame_a"
    annotation(HideResult=true, choices(checkBox=true));
  parameter Boolean get_w_rel=false
    "= true, to measure the relative angular velocity of frame_b with respect to frame_a"
    annotation(HideResult=true, choices(checkBox=true));
  parameter Boolean get_z_rel=false
    "= true, to measure the relative angular acceleration of frame_b with respect to frame_a"
    annotation(HideResult=true, choices(checkBox=true));
  parameter Boolean get_angles=false
    "= true, to measure the 3 rotation angles"
    annotation(HideResult=true, choices(checkBox=true), Dialog(group="3 angles to rotate frame_a into frame_b along the axes defined in \"sequence\""));
  parameter Types.RotationSequence sequence(
    min={1,1,1},
    max={3,3,3}) = {1,2,3}
    "If get_angles=true: Angles are returned to rotate frame_a around axes sequence[1], sequence[2] and finally sequence[3] into frame_b"
    annotation (HideResult=true,Evaluate=true, Dialog(group="3 angles to rotate frame_a into frame_b along the axes defined in \"sequence\"", enable=get_angles));
  parameter SI.Angle guessAngle1=0
    "If get_angles=true: Select angles[1] such that abs(angles[1] - guessAngle1) is a minimum"
    annotation (HideResult=true,Dialog(group="3 angles to rotate frame_a into frame_b along the axes defined in \"sequence\"", enable=get_angles));

  input Types.Color arrowColor=Modelica.Mechanics.MultiBody.Types.Defaults.SensorColor
    "Color of relative arrow from frame_a to frame_b"
    annotation (Dialog(colorSelector=true, tab="Animation", group="if animation = true", enable=animation));
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));

  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB
    resolveInFrameAfterDifferentiation = resolveInFrame
    "Frame in which vectors are resolved after differentiation (world, frame_a, frame_b, or frame_resolve)"
    annotation(Dialog(tab="Advanced", group="if get_v_rel or get_a_rel or get_z_rel", enable=get_v_rel or get_a_rel or get_z_rel));

  Blocks.Interfaces.RealOutput r_rel[3](each final quantity="Length", each final
            unit="m") if get_r_rel
    "Relative position vector frame_b.r_0 - frame_a.r_0 resolved in frame defined by resolveInFrame"
    annotation (Placement(transformation(
        origin={-100,-110},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Blocks.Interfaces.RealOutput v_rel[3](each final quantity="Velocity", each final
            unit="m/s") if get_v_rel "Relative velocity vector"
    annotation (Placement(transformation(
        origin={-60,-110},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Blocks.Interfaces.RealOutput a_rel[3](each final quantity="Acceleration",
      each final unit="m/s2") if get_a_rel "Relative acceleration vector"
    annotation (Placement(transformation(
        origin={-20,-110},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Blocks.Interfaces.RealOutput angles[3](
    each final quantity="Angle",
    each final unit="rad",
    each displayUnit="deg") if get_angles
    "Angles to rotate frame_a into frame_b via 'sequence'"
    annotation (Placement(transformation(
        origin={20,-110},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Blocks.Interfaces.RealOutput w_rel[3](each final quantity="AngularVelocity",
      each final unit="1/s") if get_w_rel "Relative angular velocity vector"
    annotation (Placement(transformation(
        origin={60,-110},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Blocks.Interfaces.RealOutput z_rel[3](each final quantity="AngularAcceleration",
      each final unit="1/s2") if get_z_rel
    "Relative angular acceleration vector"
    annotation (Placement(transformation(
        origin={100,-110},
        extent={{10,-10},{-10,10}},
        rotation=90)));

protected
  RelativePosition relativePosition(resolveInFrame=resolveInFrame) if
                                                get_r_rel or get_v_rel or get_a_rel
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));

protected
  Blocks.Continuous.Der der1[3] if get_v_rel or get_a_rel annotation (Placement(transformation(
        extent={{-10,-10},{0,0}},
        rotation=-90,
        origin={-55,-30})));
  Blocks.Continuous.Der der2[3] if get_a_rel annotation (Placement(transformation(
        extent={{0,0},{10,10}},
        rotation=-90,
        origin={-25,-40})));
  Modelica.Mechanics.MultiBody.Sensors.RelativeAngles relativeAngles(sequence=sequence, guessAngle1=guessAngle1) if get_angles annotation (Placement(transformation(extent={{20,-25},{40,-5}})));
  RelativeAngularVelocity relativeAngularVelocity(resolveInFrame=resolveInFrame) if get_w_rel or get_z_rel
    annotation (Placement(transformation(extent={{50,-40},{70,-20}})));

protected
  Blocks.Continuous.Der der3[3] if get_z_rel annotation (Placement(transformation(
        extent={{-10,-10},{0,0}},
        rotation=-90,
        origin={95,-58})));
  Modelica.Mechanics.MultiBody.Forces.Internal.ZeroForceAndTorque zeroForce1
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  Modelica.Mechanics.MultiBody.Forces.Internal.ZeroForceAndTorque zeroForce2
    annotation (Placement(transformation(extent={{80,40},{60,60}})));
  Modelica.Mechanics.MultiBody.Forces.Internal.ZeroForceAndTorque zeroForce3 if resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve
    annotation (Placement(transformation(extent={{40,70},{20,90}})));

protected
  Modelica.Mechanics.MultiBody.Sensors.TransformRelativeVector transformVector_v_rel(frame_r_in=resolveInFrame, frame_r_out=resolveInFrameAfterDifferentiation) if get_v_rel annotation (Placement(transformation(extent={{-70,-64},{-50,-44}})));
  Modelica.Mechanics.MultiBody.Sensors.TransformRelativeVector transformVector_a_rel(frame_r_in=resolveInFrame, frame_r_out=resolveInFrameAfterDifferentiation) if get_a_rel annotation (Placement(transformation(extent={{-30,-78},{-10,-58}})));
  Modelica.Mechanics.MultiBody.Sensors.TransformRelativeVector transformVector_z_rel(frame_r_in=resolveInFrame, frame_r_out=resolveInFrameAfterDifferentiation) if get_z_rel annotation (Placement(transformation(extent={{80,-94},{100,-74}})));

protected
  outer Modelica.Mechanics.MultiBody.World world;

  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Arrow arrow(
    r=frame_a.r_0,
    r_head=frame_b.r_0 - frame_a.r_0,
    color=arrowColor,
    specularCoefficient) if world.enableAnimation and animation;
equation
  connect(relativePosition.frame_a, frame_a) annotation (Line(
      points={{-80,0},{-100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(relativePosition.frame_b, frame_b) annotation (Line(
      points={{-60,0},{100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(relativePosition.r_rel, r_rel) annotation (Line(
      points={{-70,-11},{-70,-15},{-80,-15},{-80,-30},{-100,-30},{-100,-110}}, color={0,0,127}));
  connect(zeroForce1.frame_a, frame_a)
    annotation (Line(
      points={{-80,50},{-90,50},{-90,0},{-100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(zeroForce2.frame_a, frame_b)
    annotation (Line(
      points={{80,50},{90,50},{90,0},{100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(relativePosition.r_rel, der1.u) annotation (Line(
      points={{-70,-11},{-70,-15},{-60,-15},{-60,-19}}, color={0,0,127}));
  connect(der2.u, der1.y) annotation (Line(
      points={{-20,-39},{-20,-35},{-60,-35},{-60,-30.5}}, color={0,0,127}));
  connect(relativeAngles.frame_a, frame_a) annotation (Line(
      points={{20,-15},{10,-15},{10,-84},{-90,-84},{-90,0},{-100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(relativeAngles.frame_b, frame_b) annotation (Line(
      points={{40,-15},{50,-15},{50,0},{100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(relativeAngles.angles, angles) annotation (Line(
      points={{30,-26},{30,-92},{20,-92},{20,-110}},
                                   color={0,0,127}));
  connect(relativeAngularVelocity.frame_b, frame_b) annotation (Line(
      points={{70,-30},{80,-30},{80,0},{100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(relativeAngularVelocity.frame_a, frame_a) annotation (Line(
      points={{50,-30},{10,-30},{10,-84},{-90,-84},{-90,0},{-100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(relativeAngularVelocity.w_rel, w_rel) annotation (Line(
      points={{60,-41},{60,-110}}, color={0,0,127}));
  connect(relativeAngularVelocity.w_rel, der3.u) annotation (Line(
      points={{60,-41},{60,-45},{90,-45},{90,-47}},   color={0,0,127}));
  connect(der1.y, transformVector_v_rel.r_in)
    annotation (Line(
      points={{-60,-30.5},{-60,-42}}, color={0,0,127}));
  connect(transformVector_v_rel.r_out, v_rel)
    annotation (Line(
      points={{-60,-65},{-60,-110}}, color={0,0,127}));
  connect(transformVector_v_rel.frame_a, frame_a)
    annotation (Line(
      points={{-70,-54},{-90,-54},{-90,0},{-100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(transformVector_v_rel.frame_b, frame_b)
    annotation (Line(
      points={{-50,-54},{-40,-54},{-40,0},{100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(transformVector_v_rel.frame_resolve, frame_resolve)
    annotation (Line(
      points={{-50,-46},{-46,-46},{-46,-28},{-30,-28},{-30,20},{50,20},{50,80},{100,80}},
      color={95,95,95},
      pattern=LinePattern.Dot));
  connect(frame_resolve, relativePosition.frame_resolve) annotation (Line(
      points={{100,80},{50,80},{50,20},{-30,20},{-30,8.1},{-60,8.1}},
      color={95,95,95},
      pattern=LinePattern.Dot));
  connect(frame_resolve, zeroForce3.frame_a) annotation (Line(
      points={{100,80},{40,80}},
      color={95,95,95},
      pattern=LinePattern.Dot));
  connect(relativeAngularVelocity.frame_resolve, frame_resolve) annotation (
      Line(
      points={{70,-21.9},{70,-21.9},{70,20},{50,20},{50,80},{100,80}},
      color={95,95,95},
      pattern=LinePattern.Dot));
  connect(der2.y, transformVector_a_rel.r_in) annotation (Line(
      points={{-20,-50.5},{-20,-56}}, color={0,0,127}));
  connect(transformVector_a_rel.frame_a, frame_a) annotation (Line(
      points={{-30,-68},{-40,-68},{-40,-84},{-90,-84},{-90,0},{-100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(transformVector_a_rel.frame_b, frame_b) annotation (Line(
      points={{-10,-68},{0,-68},{0,0},{100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(transformVector_a_rel.frame_resolve, frame_resolve) annotation (Line(
      points={{-10,-60},{-10,-28},{-30,-28},{-30,20},{50,20},{50,80},{100,80}},
      color={95,95,95},
      pattern=LinePattern.Dot));
  connect(transformVector_a_rel.r_out, a_rel) annotation (Line(
      points={{-20,-79},{-20,-110}}, color={0,0,127}));
  connect(der3.y, transformVector_z_rel.r_in) annotation (Line(
      points={{90,-58.5},{90,-72}},   color={0,0,127}));
  connect(transformVector_z_rel.r_out, z_rel) annotation (Line(
      points={{90,-95},{90,-100},{100,-100},{100,-110}},
                                     color={0,0,127}));
  connect(transformVector_z_rel.frame_a, frame_a) annotation (Line(
      points={{80,-84},{-90,-84},{-90,0},{-100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(transformVector_z_rel.frame_b, frame_b) annotation (Line(
      points={{100,-84},{110,-84},{110,0},{100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(transformVector_z_rel.frame_resolve, frame_resolve) annotation (Line(
      points={{100,-76},{100,-20},{70,-20},{70,20},{50,20},{50,80},{100,80}},
      color={95,95,95},
      pattern=LinePattern.Dot));
  annotation (Icon(coordinateSystem(preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
        Line(
          visible=get_r_rel,
          points={{-68,-20},{-100,-40},{-100,-100}},
          color={0,0,127}),
        Line(
          visible=get_w_rel,
          points={{60,-36},{60,-46}},
          color={0,0,127}),
        Line(
          visible=get_w_rel,
          points={{60,-76},{60,-100}},
          color={0,0,127}),
        Line(
          visible=get_a_rel,
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
          visible=get_v_rel,
          points={{-60,-36},{-60,-68}},
          color={0,0,127}),
        Line(
          visible=get_v_rel,
          points={{-60,-94},{-60,-100}},
          color={0,0,127}),
        Line(
          visible=get_z_rel,
          points={{68,-20},{100,-40},{100,-68}},
          color={0,0,127}),
        Line(
          visible=get_z_rel,
          points={{100,-94},{100,-100}},
          color={0,0,127}),
        Text(
          extent={{-132,90},{129,138}},
          textString="%name",
          textColor={0,0,255}),
        Text(
          visible=get_r_rel,
          extent={{-140,-72},{-100,-92}},
          textColor={64,64,64},
          textString="m"),
        Text(
          visible=get_v_rel,
          extent={{-90,-72},{-40,-92}},
          textColor={64,64,64},
          textString="m/s"),
        Text(
          visible=get_a_rel,
          extent={{-50,-36},{20,-56}},
          textColor={64,64,64},
          textString="m/s2"),
        Text(
          visible=get_angles,
          extent={{-6,-72},{54,-92}},
          textColor={64,64,64},
          textString="rad"),
        Text(
          visible=get_w_rel,
          extent={{34,-50},{104,-70}},
          textColor={64,64,64},
          textString="rad/s"),
        Text(
          visible=get_z_rel,
          extent={{70,-72},{160,-92}},
          textColor={64,64,64},
          textString="rad/s2")}),
    Documentation(info="<html>
<p>
Relative kinematic quantities between frame_a and frame_b are
determined and provided at the conditional output signal connectors.
For example, if parameter \"get_r_rel = <strong>true</strong>\", the connector
\"r_rel\" is enabled and contains the relative vector from
frame_a to frame_b. The following quantities can be provided
as output signals:
</p>

<ol>
<li> Relative position vector (= r_rel)</li>
<li> Relative velocity vector (= v_rel)</li>
<li> Relative acceleration vector (= a_rel)</li>
<li> Three angles to rotate frame_a into frame_b (= angles)</li>
<li> Relative angular velocity vector (= w_rel)</li>
<li> Relative angular acceleration vector (= z_rel)</li>
</ol>

<p>
Via parameter <strong>resolveInFrame</strong> it is defined, in which frame
a vector is resolved (before differentiation):
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th><strong>resolveInFrame =<br>Types.ResolveInFrameAB.</strong></th><th><strong>Meaning</strong></th></tr>
<tr><td>world</td>
    <td>Resolve vectors in world frame</td></tr>

<tr><td>frame_a</td>
    <td>Resolve vectors in frame_a</td></tr>

<tr><td>frame_b</td>
    <td>Resolve vectors in frame_b</td></tr>

<tr><td>frame_resolve</td>
    <td>Resolve vectors in frame_resolve</td></tr>
</table>

<p>
If resolveInFrame = Types.ResolveInFrameAB.frame_resolve, the conditional connector
\"frame_resolve\" is enabled and the vectors are resolved in the frame, to
which frame_resolve is connected. Note, if this connector is enabled, it must
be connected.
</p>

<p>
In the following figure the animation of a RelativeSensor
component is shown. The light blue coordinate system is
frame_a, the dark blue coordinate system is frame_b, and
the yellow arrow is the animated sensor.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Sensors/RelativeSensor.png\">
</div>

<p>
Note, derivatives
of relative kinematic quantities are always performed with
respect to the frame, in which the vector to be differentiated
is resolved. After differentiation, it is possible via parameter
<strong>resolveInFrameAfterDifferentiation</strong> (in the \"Advanced\" menu)
to resolve the differentiated
vector in another frame.
</p>
<p>
For example, if resolveInFrame = <strong>Types.ResolveInFrameAB.frame_b</strong>, then
</p>

<blockquote><pre>
r_rel = resolve2(frame_b.R, frame_b.r_0 - frame_a.r0);
v_rel = <strong>der</strong>(r_rel);
</pre></blockquote>

<p>
is returned (r_rel = resolve2(frame_b.R, frame_b.r_0 - frame_a.r0)), i.e.,
the derivative of the relative distance from frame_a to frame_b,
resolved in frame_b. If
<strong>resolveInFrameAfterDifferentiation</strong> = Types.ResolveInFrameAB.world, then
v_rel is additionally transformed to:
</p>

<blockquote><pre>
v_rel = resolve1(frame_b.R, <strong>der</strong>(r_rel))
</pre></blockquote>

<p>
The cut-force and the cut-torque in frame_resolve are
always zero, whether frame_resolve is connected or not.
</p>

<p>
If <strong>get_angles</strong> = <strong>true</strong>, the 3 angles to rotate frame_a
into frame_b along the axes defined by parameter <strong>sequence</strong>
are returned. For example, if sequence = {3,1,2} then frame_a is
rotated around angles[1] along the z-axis, afterwards it is rotated
around angles[2] along the x-axis, and finally it is rotated around
angles[3] along the y-axis and is then identical to frame_b.
The 3 angles are returned in the range
</p>
<blockquote><pre>
-&pi; &lt;= angles[i] &lt;= &pi;
</pre></blockquote>
<p>
There are <strong>two solutions</strong> for \"angles[1]\" in this range.
Via parameter <strong>guessAngle1</strong> (default = 0) the
returned solution is selected such that |angles[1] - guessAngle1| is
minimal. The relative transformation matrix between frame_a and
frame_b may be in a singular configuration with respect to \"sequence\", i.e.,
there is an infinite number of angle values leading to the same relative
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
end RelativeSensor;
