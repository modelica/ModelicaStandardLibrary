within Modelica.Mechanics.MultiBody;
package Sensors "Sensors to measure variables"
  extends Modelica.Icons.SensorsPackage;

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

    input SI.Diameter arrowDiameter=world.defaultArrowDiameter
      "Diameter of absolute arrow from world frame to frame_a"
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
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
    Modelica.Mechanics.MultiBody.Sensors.AbsoluteAngles absoluteAngles(sequence=
          sequence, guessAngle1=guessAngle1) if get_angles
      annotation (Placement(transformation(extent={{-10,10},{10,-10}},
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
    Modelica.Mechanics.MultiBody.Sensors.TransformAbsoluteVector
      transformVector_a(
        frame_r_in=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.world,
        frame_r_out=resolveInFrame) if
         get_a
      annotation (Placement(transformation(extent={{-10,-70},{-30,-50}})));
    Modelica.Mechanics.MultiBody.Sensors.TransformAbsoluteVector
      transformVector_z(
        frame_r_in=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.world,
        frame_r_out=resolveInFrame) if
         get_z
      annotation (Placement(transformation(extent={{90,-80},{110,-60}})));

  protected
    outer Modelica.Mechanics.MultiBody.World world;

    Modelica.Mechanics.MultiBody.Visualizers.Advanced.Arrow arrow(
      r_head=frame_a.r_0,
      diameter=arrowDiameter,
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
    Internal.ZeroForceAndTorque zeroForce1
      annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
    Internal.ZeroForceAndTorque zeroForce2 if resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_resolve
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
            points={{-84,0},{-84,-60},{-100,-60},{-100,-100}},
            color={0,0,127}),
          Line(
            visible=get_a,
            points={{-20,-67},{-20,-100}},
            color={0,0,127}),
          Line(
            visible=get_w,
            points={{60,-36},{60,-100}},
            color={0,0,127}),
          Line(
            visible=get_z,
            points={{86,0},{86,-60},{100,-60},{100,-100}},
            color={0,0,127}),
          Line(
            visible=get_v,
            points={{-60,-36},{-60,-100}},
            color={0,0,127}),
          Line(
            visible=get_angles,
            points={{20,-67},{20,-100}},
            color={0,0,127}),
          Line(
            points={{95,0},{95,0},{70,0}},
            pattern=LinePattern.Dot),
          Text(
            extent={{-132,76},{129,124}},
            textString="%name",
            lineColor={0,0,255}),
          Text(
            visible=get_r,
            extent={{-130,-74},{-95,-90}},
            textString="r"),
          Text(
            visible=get_v,
            extent={{-95,-74},{-60,-90}},
            textString="v"),
          Text(
            visible=get_a,
            extent={{-55,-74},{-20,-90}},
            textString="a"),
          Text(
            visible=get_angles,
            extent={{-71,-35},{96,-54}},
            textString="angles"),
          Text(
            visible=get_w,
            extent={{59,-68},{105,-85}},
            textString="w"),
          Text(
            visible=get_z,
            extent={{107,-68},{153,-84}},
            textString="z"),
          Text(
            extent={{60,52},{191,27}},
            lineColor={95,95,95},
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

<table border=1 cellspacing=0 cellpadding=2>
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

<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Sensors/AbsoluteSensor.png\">
</p>

<p>
Velocity, acceleration, angular velocity and angular acceleration are
determined by differentiating them in the world frame and then transforming
them in to the frame defined by <strong>resolveInFrame</strong>.
</p>
<p>
For example, if resolveInFrame = <strong>Types.ResolveInFrameA.frame_a</strong>, then
</p>
<pre>
   v0 = <strong>der</strong>(frame_a.r0);
   v  = resolve2(frame_a.R, v0);
</pre>
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
<pre>
    -<font face=\"Symbol\">p</font> &lt;= angles[i] &lt;= <font face=\"Symbol\">p</font>
</pre>
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
<pre>
  sequence = <strong>{1,2,3}</strong>  // Cardan or Tait-Bryan angle sequence
           = <strong>{3,1,3}</strong>  // Euler angle sequence
           = <strong>{3,2,1}</strong>
</pre>
</html>"));
  end AbsoluteSensor;

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

    input SI.Diameter arrowDiameter=world.defaultArrowDiameter
      "Diameter of relative arrow from frame_a to frame_b"
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
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
    Modelica.Mechanics.MultiBody.Sensors.RelativeAngles relativeAngles(sequence=
          sequence, guessAngle1=guessAngle1) if get_angles
      annotation (Placement(transformation(extent={{20,-25},{40,-5}})));
    RelativeAngularVelocity relativeAngularVelocity(resolveInFrame=resolveInFrame) if get_w_rel or get_z_rel
      annotation (Placement(transformation(extent={{50,-40},{70,-20}})));

  protected
    Blocks.Continuous.Der der3[3] if get_z_rel annotation (Placement(transformation(
          extent={{-10,-10},{0,0}},
          rotation=-90,
          origin={95,-58})));
    Internal.ZeroForceAndTorque zeroForce1
      annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
    Internal.ZeroForceAndTorque zeroForce2
      annotation (Placement(transformation(extent={{80,40},{60,60}})));
    Internal.ZeroForceAndTorque zeroForce3 if resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve
      annotation (Placement(transformation(extent={{40,70},{20,90}})));

  protected
    Modelica.Mechanics.MultiBody.Sensors.TransformRelativeVector
      transformVector_v_rel(frame_r_in=resolveInFrame,
        frame_r_out=resolveInFrameAfterDifferentiation) if get_v_rel
      annotation (Placement(transformation(extent={{-70,-64},{-50,-44}})));
    Modelica.Mechanics.MultiBody.Sensors.TransformRelativeVector
      transformVector_a_rel(frame_r_in=resolveInFrame,
        frame_r_out=resolveInFrameAfterDifferentiation) if get_a_rel
      annotation (Placement(transformation(extent={{-30,-78},{-10,-58}})));
    Modelica.Mechanics.MultiBody.Sensors.TransformRelativeVector
      transformVector_z_rel(frame_r_in=resolveInFrame,
        frame_r_out=resolveInFrameAfterDifferentiation) if get_z_rel
      annotation (Placement(transformation(extent={{80,-94},{100,-74}})));

  protected
    outer Modelica.Mechanics.MultiBody.World world;

    Modelica.Mechanics.MultiBody.Visualizers.Advanced.Arrow arrow(
      r=frame_a.r_0,
      r_head=frame_b.r_0 - frame_a.r_0,
      diameter=arrowDiameter,
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
            points={{-84,0},{-84,-60},{-100,-60},{-100,-100}},
            color={0,0,127}),
          Line(
            visible=get_a_rel,
            points={{-20,-67},{-20,-100}},
            color={0,0,127}),
          Line(
            visible=get_w_rel,
            points={{60,-36},{60,-100}},
            color={0,0,127}),
          Line(
            visible=get_z_rel,
            points={{86,0},{86,-60},{100,-60},{100,-100}},
            color={0,0,127}),
          Line(
            visible=get_v_rel,
            points={{-60,-36},{-60,-100}},
            color={0,0,127}),
          Line(
            visible=get_angles,
            points={{20,-67},{20,-100}},
            color={0,0,127}),
          Text(
            extent={{-132,90},{129,138}},
            textString="%name",
            lineColor={0,0,255}),
          Text(
            visible=get_r_rel,
            extent={{-130,-74},{-95,-90}},
            textString="r"),
          Text(
            visible=get_v_rel,
            extent={{-95,-74},{-60,-90}},
            textString="v"),
          Text(
            visible=get_a_rel,
            extent={{-55,-74},{-20,-90}},
            textString="a"),
          Text(
            visible=get_angles,
            extent={{-71,-35},{96,-54}},
            textString="angles"),
          Text(
            visible=get_w_rel,
            extent={{63,-73},{103,-90}},
            textString="w"),
          Text(
            visible=get_z_rel,
            extent={{103,-71},{149,-87}},
            textString="z")}),
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

<table border=1 cellspacing=0 cellpadding=2>
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

<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Sensors/RelativeSensor.png\">
</p>

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

<pre>
   r_rel = resolve2(frame_b.R, frame_b.r_0 - frame_a.r0);
   v_rel = <strong>der</strong>(r_rel);
</pre>

<p>
is returned (r_rel = resolve2(frame_b.R, frame_b.r_0 - frame_a.r0)), i.e.,
the derivative of the relative distance from frame_a to frame_b,
resolved in frame_b. If
<strong>resolveInFrameAfterDifferentiation</strong> = Types.ResolveInFrameAB.world, then
v_rel is additionally transformed to:
</p>

<pre>
   v_rel = resolve1(frame_b.R, <strong>der</strong>(r_rel))
</pre>

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
<pre>
    -<font face=\"Symbol\">p</font> &lt;= angles[i] &lt;= <font face=\"Symbol\">p</font>
</pre>
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
<pre>
  sequence = <strong>{1,2,3}</strong>  // Cardan or Tait-Bryan angle sequence
           = <strong>{3,1,3}</strong>  // Euler angle sequence
           = <strong>{3,2,1}</strong>
</pre>
</html>"));
  end RelativeSensor;

  model AbsolutePosition
    "Measure absolute position vector of the origin of a frame connector"
    extends Internal.PartialAbsoluteSensor;

    Blocks.Interfaces.RealOutput r[3](
      each final quantity="Length",
      each final unit="m")
      "Absolute position vector resolved in frame defined by resolveInFrame"
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          origin={110,0})));
    Modelica.Mechanics.MultiBody.Interfaces.Frame_resolve frame_resolve if
      resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_resolve
      "Coordinate system in which output vector r is optionally resolved"
      annotation (Placement(transformation(extent={{-16,-16},{16,16}},
          rotation=-90,
          origin={0,-100})));

    parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameA resolveInFrame=
      Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a
      "Frame in which output vector r shall be resolved (world, frame_a, or frame_resolve)";

  protected
    Internal.BasicAbsolutePosition position(resolveInFrame=resolveInFrame)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

    Modelica.Mechanics.MultiBody.Interfaces.ZeroPosition zeroPosition if
      not (resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_resolve)
      annotation (Placement(transformation(extent={{20,-40},{40,-20}})));

  equation
    connect(position.frame_resolve, frame_resolve) annotation (Line(
        points={{0,-10},{0,-100}},
        color={95,95,95},
        pattern=LinePattern.Dot));
    connect(zeroPosition.frame_resolve, position.frame_resolve)
      annotation (Line(
        points={{20,-30},{0,-30},{0,-10}},
        color={95,95,95},
        pattern=LinePattern.Dot));
    connect(position.r, r) annotation (Line(
        points={{11,0},{110,0}}, color={0,0,127}));
    connect(position.frame_a, frame_a) annotation (Line(
        points={{-10,0},{-100,0}},
        color={95,95,95},
        thickness=0.5));
    annotation (Icon(coordinateSystem(
            preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
          Line(
            points={{70,0},{100,0}},
            color={0,0,127}),
          Text(
            extent={{-127,95},{134,143}},
            textString="%name",
            lineColor={0,0,255}),
          Text(
            extent={{62,46},{146,16}},
            textString="r"),
          Text(
            extent={{15,-67},{146,-92}},
            lineColor={95,95,95},
            textString="resolve"),
          Line(
            points={{0,-96},{0,-96},{0,-70},{0,-70}},
            pattern=LinePattern.Dot)}),
      Documentation(info="<html>
<p>
The absolute position vector of the origin of frame_a is
determined and provided at the output signal connector <strong>r</strong>.
</p>

<p>
Via parameter <strong>resolveInFrame</strong> it is defined, in which frame
the position vector is resolved:
</p>

<table border=1 cellspacing=0 cellpadding=2>
<tr><th><strong>resolveInFrame =<br>Types.ResolveInFrameA.</strong></th><th><strong>Meaning</strong></th></tr>
<tr><td>world</td>
    <td>Resolve vector in world frame</td></tr>

<tr><td>frame_a</td>
    <td>Resolve vector in frame_a</td></tr>

<tr><td>frame_resolve</td>
    <td>Resolve vector in frame_resolve</td></tr>
</table>

<p>
If resolveInFrame = Types.ResolveInFrameA.frame_resolve, the conditional connector
\"frame_resolve\" is enabled and r is resolved in the frame, to
which frame_resolve is connected. Note, if this connector is enabled, it must
be connected.
</p>

<h4>Example</h4>
<p>
If resolveInFrame = Types.ResolveInFrameA.frame_a, the output vector is
computed as:
</p>

<blockquote><pre>
r = MultiBody.Frames.resolve2(frame_a.R, frame_b.r_0);
</pre></blockquote>
</html>"));
  end AbsolutePosition;

  model AbsoluteVelocity
    "Measure absolute velocity vector of origin of frame connector"
    extends Internal.PartialAbsoluteSensor;

    Blocks.Interfaces.RealOutput v[3](
      each final quantity="Velocity",
      each final unit="m/s")
      "Absolute velocity vector resolved in frame defined by resolveInFrame"
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          origin={110,0})));
    Modelica.Mechanics.MultiBody.Interfaces.Frame_resolve frame_resolve if
      resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_resolve
      "Coordinate system in which output vector v is optionally resolved"
      annotation (Placement(transformation(extent={{-16,-16},{16,16}},
          rotation=-90,
          origin={0,-100})));

    parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameA resolveInFrame=
      Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a
      "Frame in which output vector v shall be resolved (world, frame_a, or frame_resolve)";

  protected
    Internal.BasicAbsolutePosition position(
      resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.world)
      annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
    Blocks.Continuous.Der der1[3] annotation (Placement(transformation(
          extent={{-20,-20},{0,0}},
          origin={10,10})));
    Modelica.Mechanics.MultiBody.Sensors.TransformAbsoluteVector tansformAbsoluteVector(
      frame_r_in=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.world,
      frame_r_out=resolveInFrame) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={50,0})));
    Modelica.Mechanics.MultiBody.Interfaces.ZeroPosition zeroPosition
      annotation (Placement(transformation(extent={{-60,-60},{-80,-40}})));
    Modelica.Mechanics.MultiBody.Interfaces.ZeroPosition zeroPosition1 if not (
      resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_resolve)
      annotation (Placement(transformation(extent={{60,-60},{80,-40}})));
  equation
    connect(position.r, der1.u) annotation (Line(
        points={{-39,0},{-12,0}}, color={0,0,127}));
    connect(position.frame_a, frame_a) annotation (Line(
        points={{-60,0},{-80,0},{-80,0},{-100,0}},
        color={95,95,95},
        thickness=0.5));
    connect(der1.y, tansformAbsoluteVector.r_in) annotation (Line(
        points={{11,0},{38,0}}, color={0,0,127}));
    connect(tansformAbsoluteVector.r_out, v) annotation (Line(
        points={{61,0},{110,0}}, color={0,0,127}));
    connect(zeroPosition.frame_resolve, position.frame_resolve) annotation (Line(
        points={{-60,-50},{-50,-50},{-50,-10}},
        color={95,95,95},
        pattern=LinePattern.Dot));
    connect(tansformAbsoluteVector.frame_a, frame_a) annotation (Line(
        points={{50,10},{50,20},{-70,20},{-70,0},{-100,0}},
        color={95,95,95},
        thickness=0.5));
    connect(tansformAbsoluteVector.frame_resolve, zeroPosition1.frame_resolve)
      annotation (Line(
        points={{49.9,-10},{50,-10},{50,-50},{60,-50}},
        color={95,95,95},
        pattern=LinePattern.Dot));
    connect(tansformAbsoluteVector.frame_resolve, frame_resolve) annotation (Line(
        points={{49.9,-10},{50,-10},{50,-50},{0,-50},{0,-100}},
        color={95,95,95},
        pattern=LinePattern.Dot));
    annotation (Icon(coordinateSystem(
            preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
          Line(
            points={{70,0},{100,0}},
            color={0,0,127}),
          Text(
            extent={{-130,72},{131,120}},
            textString="%name",
            lineColor={0,0,255}),
          Text(
            extent={{58,48},{142,18}},
            textString="v"),
          Text(
            extent={{15,-67},{146,-92}},
            lineColor={95,95,95},
            textString="resolve"),
          Line(
            points={{0,-70},{0,-95}},
            color={95,95,95},
            pattern=LinePattern.Dot)}),
      Documentation(info="<html>
<p>
The absolute velocity vector of the origin of frame_a is
determined and provided at the output signal connector <strong>v</strong>.
</p>

<p>
Via parameter <strong>resolveInFrame</strong> it is defined, in which frame
the velocity vector is resolved:
</p>

<table border=1 cellspacing=0 cellpadding=2>
<tr><th><strong>resolveInFrame =<br>Types.ResolveInFrameA.</strong></th><th><strong>Meaning</strong></th></tr>
<tr><td>world</td>
    <td>Resolve vector in world frame</td></tr>

<tr><td>frame_a</td>
    <td>Resolve vector in frame_a</td></tr>

<tr><td>frame_resolve</td>
    <td>Resolve vector in frame_resolve</td></tr>
</table>

<p>
If resolveInFrame = Types.ResolveInFrameA.frame_resolve, the conditional connector
\"frame_resolve\" is enabled and v is resolved in the frame, to
which frame_resolve is connected. Note, if this connector is enabled, it must
be connected.
</p>

<h4>Example</h4>
<p>
If resolveInFrame = Types.ResolveInFrameA.frame_a, the output vector is
computed as:
</p>

<blockquote><pre>
v0 = der(frame_a.r_0);
v  = MultiBody.Frames.resolve2(frame_a.R, v0);
</pre></blockquote>
</html>"));
  end AbsoluteVelocity;

  model AbsoluteAngles
    "Measure absolute angles between frame connector and the world frame"
    extends Internal.PartialAbsoluteSensor;

    Modelica.Blocks.Interfaces.RealOutput angles[3](
      each final quantity="Angle",
      each final unit="rad",
      each displayUnit="deg")
      "Angles to rotate world frame into frame_a via 'sequence'"
      annotation (Placement(transformation(
          origin={110,0},
          extent={{-10,-10},{10,10}})));
    parameter MultiBody.Types.RotationSequence sequence(
      min={1,1,1},
      max={3,3,3})={1,2,3}
      "Angles are returned to rotate world frame around axes sequence[1], sequence[2] and finally sequence[3] into frame_a"
      annotation (Evaluate=true);
    parameter SI.Angle guessAngle1=0
      "Select angles[1] such that abs(angles[1] - guessAngle1) is a minimum";

  equation
    frame_a.f = zeros(3);
    frame_a.t = zeros(3);
    angles = MultiBody.Frames.axesRotationsAngles(
      frame_a.R,
      sequence,
      guessAngle1);
    annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
              -100},{100,100}}), graphics={
          Text(
            extent={{-132,76},{129,124}},
            textString="%name",
            lineColor={0,0,255}),
          Line(
            points={{70,0},{100,0}},
            color={0,0,127}),
          Text(
            extent={{62,-22},{172,-44}},
            textString="angles")}), Documentation(info="<html>
<p>
This model determines the 3 angles to rotate the world frame
into frame_a along the axes defined by parameter <strong>sequence</strong>.
For example, if sequence = {3,1,2} then the world frame is
rotated around angles[1] along the z-axis, afterwards it is rotated
around angles[2] along the x-axis, and finally it is rotated around
angles[3] along the y-axis and is then identical to frame_a.
The 3 angles are returned in the range
</p>
<pre>
    -<font face=\"Symbol\">p</font> &lt;= angles[i] &lt;= <font face=\"Symbol\">p</font>
</pre>
<p>
There are <strong>two solutions</strong> for \"angles[1]\" in this range.
Via parameter <strong>guessAngle1</strong> (default = 0) the
returned solution is selected such that |angles[1] - guessAngle1| is
minimal. The transformation matrix between the world frame and
frame_a may be in a singular configuration with respect to \"sequence\", i.e.,
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
<pre>
  sequence = <strong>{1,2,3}</strong>  // Cardan or Tait-Bryan angle sequence
           = <strong>{3,1,3}</strong>  // Euler angle sequence
           = <strong>{3,2,1}</strong>
</pre>
</html>"));
  end AbsoluteAngles;

  model AbsoluteAngularVelocity
    "Measure absolute angular velocity of frame connector"
    extends Internal.PartialAbsoluteSensor;

    Blocks.Interfaces.RealOutput w[3](
      each final quantity="AngularVelocity",
      each final unit="rad/s")
      "Absolute angular velocity vector of frame_a with respect to world frame, resolved in frame defined by resolveInFrame"
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          origin={110,0})));

    Modelica.Mechanics.MultiBody.Interfaces.Frame_resolve frame_resolve if resolveInFrame ==
      Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_resolve
      "Coordinate system in which w is optionally resolved"
      annotation (Placement(transformation(extent={{-16,-16},{16,16}},
          rotation=-90,
          origin={0,-100})));

    parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameA resolveInFrame=
      Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a
      "Frame in which output vector w shall be resolved (world, frame_a, or frame_resolve)";

  protected
    Internal.BasicAbsoluteAngularVelocity angularVelocity(
      resolveInFrame=resolveInFrame)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    Modelica.Mechanics.MultiBody.Interfaces.ZeroPosition zeroPosition if
      not (resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_resolve)
      annotation (Placement(transformation(extent={{40,-40},{60,-20}})));

  equation
    connect(angularVelocity.frame_resolve, frame_resolve) annotation (Line(
        points={{0,-10},{0,-100}},
        color={95,95,95},
        pattern=LinePattern.Dot));
    connect(zeroPosition.frame_resolve, angularVelocity.frame_resolve)
      annotation (Line(
        points={{40,-30},{0,-30},{0,-10}},
        color={95,95,95},
        pattern=LinePattern.Dot));
    connect(angularVelocity.w, w) annotation (Line(
        points={{11,0},{110,0}}, color={0,0,127}));
    connect(angularVelocity.frame_a, frame_a) annotation (Line(
        points={{-10,0},{-100,0}},
        color={95,95,95},
        thickness=0.5));
    annotation (Icon(coordinateSystem(
            preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
          Line(
            points={{70,0},{100,0}},
            color={0,0,127}),
          Text(
            extent={{-127,77},{134,125}},
            textString="%name",
            lineColor={0,0,255}),
          Text(
            extent={{66,48},{150,18}},
            textString="w"),
          Line(
            points={{0,-70},{0,-96}},
            color={95,95,95},
            pattern=LinePattern.Dot),
          Text(
            extent={{15,-67},{146,-92}},
            lineColor={95,95,95},
            textString="resolve")}),
      Documentation(info="<html>
<p>
The absolute angular velocity of frame_a with respect to the
world frame is
determined and provided at the output signal connector <strong>w</strong>.
</p>

<p>
Via parameter <strong>resolveInFrame</strong> it is defined, in which frame
the angular velocity is resolved:
</p>

<table border=1 cellspacing=0 cellpadding=2>
<tr><th><strong>resolveInFrame =<br>Types.ResolveInFrameA.</strong></th><th><strong>Meaning</strong></th></tr>
<tr><td>world</td>
    <td>Resolve vector in world frame</td></tr>

<tr><td>frame_a</td>
    <td>Resolve vector in frame_a</td></tr>

<tr><td>frame_resolve</td>
    <td>Resolve vector in frame_resolve</td></tr>
</table>

<p>
If resolveInFrame = Types.ResolveInFrameA.frame_resolve, the conditional connector
\"frame_resolve\" is enabled and w is resolved in the frame, to
which frame_resolve is connected. Note, if this connector is enabled, it must
be connected.
</p>

<h4>Example</h4>
<p>
If resolveInFrame = Types.ResolveInFrameA.frame_a, the output vector is
computed as:
</p>

<blockquote><pre>
w = MultiBody.Frames.angularVelocity2(frame_a.R);
</pre></blockquote>
</html>"));
  end AbsoluteAngularVelocity;

  model RelativePosition
    "Measure relative position vector between the origins of two frame connectors"
    extends Internal.PartialRelativeSensor;

    Blocks.Interfaces.RealOutput r_rel[3]
      "Relative position vector resolved in frame defined by resolveInFrame"
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={0,-110})));
    Modelica.Mechanics.MultiBody.Interfaces.Frame_resolve frame_resolve if resolveInFrame ==
      Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve
      "Coordinate system in which r_rel is optionally resolved"
      annotation (Placement(transformation(extent={{84,64},{116,96}})));

    parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB resolveInFrame=
      Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_a
      "Frame in which output vector r_rel shall be resolved (world, frame_a, frame_b, or frame_resolve)";

  protected
    Internal.BasicRelativePosition relativePosition(resolveInFrame=resolveInFrame)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

    Modelica.Mechanics.MultiBody.Interfaces.ZeroPosition zeroPosition if
      not (resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve)
      annotation (Placement(transformation(extent={{52,20},{72,40}})));

  equation
    connect(relativePosition.frame_a, frame_a) annotation (Line(
        points={{-10,0},{-100,0}},
        color={95,95,95},
        thickness=0.5));
    connect(relativePosition.frame_b, frame_b) annotation (Line(
        points={{10,0},{100,0}},
        color={95,95,95},
        thickness=0.5));
    connect(relativePosition.frame_resolve, frame_resolve) annotation (Line(
        points={{10,8},{20,8},{20,8},{30,8},{30,80},{100,80}},
        color={95,95,95},
        pattern=LinePattern.Dot));
    connect(zeroPosition.frame_resolve, relativePosition.frame_resolve)
      annotation (Line(
        points={{52,30},{30,30},{30,8},{10,8}},
        color={95,95,95},
        pattern=LinePattern.Dot));
    connect(relativePosition.r_rel, r_rel) annotation (Line(
        points={{0,-11},{0,-110}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(
            preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
          Line(
            points={{0,-70},{0,-100}},
            color={0,0,127}),
          Text(
            extent={{-127,95},{134,143}},
            textString="%name",
            lineColor={0,0,255}),
          Text(
            extent={{18,-80},{102,-110}},
            textString="r_rel")}),
      Documentation(info="<html>
<p>
The relative position vector between the origins of frame_a and frame_b are
determined and provided at the output signal connector <strong>r_rel</strong>.
</p>

<p>
Via parameter <strong>resolveInFrame</strong> it is defined, in which frame
the position vector is resolved:
</p>

<table border=1 cellspacing=0 cellpadding=2>
<tr><th><strong>resolveInFrame =<br>Types.ResolveInFrameAB.</strong></th><th><strong>Meaning</strong></th></tr>
<tr><td>world</td>
    <td>Resolve vector in world frame</td></tr>

<tr><td>frame_a</td>
    <td>Resolve vector in frame_a</td></tr>

<tr><td>frame_b</td>
    <td>Resolve vector in frame_b</td></tr>

<tr><td>frame_resolve</td>
    <td>Resolve vector in frame_resolve</td></tr>
</table>

<p>
If resolveInFrame = Types.ResolveInFrameAB.frame_resolve, the conditional connector
\"frame_resolve\" is enabled and r_rel is resolved in the frame, to
which frame_resolve is connected. Note, if this connector is enabled, it must
be connected.
</p>

<h4>Example</h4>
<p>
If resolveInFrame = Types.ResolveInFrameAB.frame_a, the output vector is
computed as:
</p>

<blockquote><pre>
r_rel = MultiBody.Frames.resolve2(frame_a.R, frame_b.r_0 - frame_a.r_0);
</pre></blockquote>
</html>"));
  end RelativePosition;

  model RelativeVelocity
    "Measure relative velocity vector between the origins of two frame connectors"
    extends Internal.PartialRelativeSensor;
    Modelica.Blocks.Interfaces.RealOutput v_rel[3](each final quantity="Velocity", each final
              unit =                                                                        "m/s")
      "Relative velocity vector resolved in frame defined by resolveInFrame"
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={0,-110})));

    Modelica.Mechanics.MultiBody.Interfaces.Frame_resolve frame_resolve if resolveInFrame ==
      Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve
      "Coordinate system in which v_rel is optionally resolved"
      annotation (Placement(transformation(extent={{84,64},{116,96}})));

    parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB
      resolveInFrame=
    Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_a
      "Frame in which output vector v_rel shall be resolved (world, frame_a, frame_b, or frame_resolve)";

  protected
    RelativePosition relativePosition(resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_a)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    Modelica.Mechanics.MultiBody.Interfaces.ZeroPosition zeroPosition if
      not (resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve)
      annotation (Placement(transformation(extent={{50,-60},{70,-40}})));
    Modelica.Blocks.Continuous.Der der_r_rel[3]                      annotation (Placement(transformation(
          extent={{-20,-20},{0,0}},
          rotation=-90,
          origin={10,-40})));
    Modelica.Mechanics.MultiBody.Sensors.TransformRelativeVector
                           tansformRelativeVector(
        frame_r_in= Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_a,
        frame_r_out=resolveInFrame)
      annotation (Placement(transformation(extent={{-10,-80},{10,-60}})));
  equation
    connect(relativePosition.frame_a, frame_a) annotation (Line(
        points={{-10,0},{-100,0}},
        color={95,95,95},
        thickness=0.5));
    connect(relativePosition.frame_b, frame_b) annotation (Line(
        points={{10,0},{100,0}},
        color={95,95,95},
        thickness=0.5));
    connect(relativePosition.r_rel, der_r_rel.u)
                                            annotation (Line(
        points={{0,-11},{0,-18}}, color={0,0,127}));
    connect(der_r_rel.y, tansformRelativeVector.r_in) annotation (Line(
        points={{0,-41},{0,-58}}, color={0,0,127}));
    connect(tansformRelativeVector.r_out, v_rel) annotation (Line(
        points={{0,-81},{0,-110}}, color={0,0,127}));
    connect(tansformRelativeVector.frame_a, frame_a) annotation (Line(
        points={{-10,-70},{-70,-70},{-70,0},{-100,0}},
        color={95,95,95},
        thickness=0.5));
    connect(tansformRelativeVector.frame_b, frame_b) annotation (Line(
        points={{10,-70},{80,-70},{80,0},{100,0}},
        color={95,95,95},
        thickness=0.5));
    connect(tansformRelativeVector.frame_resolve, frame_resolve) annotation (Line(
        points={{10,-62},{30,-62},{30,80},{100,80}},
        color={95,95,95},
        pattern=LinePattern.Dot));
    connect(zeroPosition.frame_resolve, tansformRelativeVector.frame_resolve)
      annotation (Line(
        points={{50,-50},{30,-50},{30,-62},{10,-62}},
        color={95,95,95},
        pattern=LinePattern.Dot));
    annotation (Icon(coordinateSystem(
            preserveAspectRatio=true,  extent={{-100,-100},{100,100}}), graphics={
          Line(
            points={{0,-70},{0,-100}},
            color={0,0,127}),
          Text(
            extent={{-127,95},{134,143}},
            textString="%name",
            lineColor={0,0,255}),
          Text(
            extent={{18,-80},{102,-110}},
            textString="v_rel")}),
      Documentation(info="<html>
<p>
The relative velocity vector between the origins of frame_a and of frame_b are
determined and provided at the output signal connector <strong>v_rel</strong>.
This vector is defined as:
</p>

<blockquote><pre>
r_rel = MultiBody.Frames.resolve2(frame_a.R, frame_b.r_0 - frame_a.r_0);
v_rel = <strong>der</strong>(r_rel);
</pre></blockquote>

<p>
Via parameter <strong>resolveInFrame</strong> it is defined, in which frame
the velocity vector is resolved:
</p>

<table border=1 cellspacing=0 cellpadding=2>
<tr><th><strong>resolveInFrame =<br>Types.ResolveInFrameAB.</strong></th><th><strong>Meaning</strong></th></tr>
<tr><td>world</td>
    <td>Resolve vector in world frame</td></tr>

<tr><td>frame_a</td>
    <td>Resolve vector in frame_a</td></tr>

<tr><td>frame_b</td>
    <td>Resolve vector in frame_b</td></tr>

<tr><td>frame_resolve</td>
    <td>Resolve vector in frame_resolve</td></tr>
</table>

<p>
If resolveInFrame = Types.ResolveInFrameAB.frame_resolve, the conditional connector
\"frame_resolve\" is enabled and v_rel is resolved in the frame, to
which frame_resolve is connected. Note, if this connector is enabled, it must
be connected.
</p>

<h4>Example</h4>
<p>
If resolveInFrame = Types.ResolveInFrameAB.frame_b, the output vector is
computed as:
</p>

<blockquote><pre>
r_rel   = MultiBody.Frames.resolve2(frame_a.R, frame_b.r_0 - frame_a.r_0);
v_rel_a = <strong>der</strong>(r_rel);
v_rel   = MultiBody.Frames.resolveRelative(frame_a.R, frame_b.R, v_rel_a);
</pre></blockquote>
</html>"));
  end RelativeVelocity;

  model RelativeAngles "Measure relative angles between two frame connectors"
    extends Internal.PartialRelativeSensor
      annotation(IconMap(primitivesVisible=false));
    extends Modelica.Icons.RotationalSensor;

    Modelica.Blocks.Interfaces.RealOutput angles[3](
      each final quantity="Angle",
      each final unit="rad",
      each displayUnit="deg")
      "Angles to rotate frame_a into frame_b via 'sequence'"
      annotation (Placement(transformation(
          origin={0,-110},
          extent={{-10,-10},{10,10}},
          rotation=270)));
    parameter MultiBody.Types.RotationSequence sequence(
      min={1,1,1},
      max={3,3,3})={1,2,3}
      "Angles are returned to rotate frame_a around axes sequence[1], sequence[2] and finally sequence[3] into frame_b"
      annotation (Evaluate=true);
    parameter SI.Angle guessAngle1=0
      "Select angles[1] such that abs(angles[1] - guessAngle1) is a minimum";
    Modelica.Mechanics.MultiBody.Frames.Orientation R_rel
      "Relative orientation object from frame_a to frame_b";

  equation
    frame_a.f = zeros(3);
    frame_a.t = zeros(3);
    frame_b.f = zeros(3);
    frame_b.t = zeros(3);
    R_rel = Modelica.Mechanics.MultiBody.Frames.relativeRotation(frame_a.R, frame_b.R);
    angles = MultiBody.Frames.axesRotationsAngles(
      R_rel,
      sequence,
      guessAngle1);
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
        graphics={
          Line(
            points={{0,-70},{0,-100}},
            color={0,0,127}),
          Line(
            points={{-70,0},{-96,0},{-96,0}}),
          Line(
            points={{96,0},{70,0},{70,0}}),
          Text(
            extent={{-132,90},{129,138}},
            textString="%name",
            lineColor={0,0,255}),
          Text(
            extent={{0,-76},{110,-98}},
            textString="angles"),
          Text(
            extent={{-108,43},{-72,18}},
            lineColor={128,128,128},
            textString="a"),
          Text(
            extent={{72,43},{108,18}},
            lineColor={128,128,128},
            textString="b")}),      Documentation(info="<html>
<p>
This model determines the 3 angles to rotate frame_a
into frame_b along the axes defined by parameter <strong>sequence</strong>.
For example, if sequence = {3,1,2} then frame_a is
rotated around angles[1] along the z-axis, afterwards it is rotated
around angles[2] along the x-axis, and finally it is rotated around
angles[3] along the y-axis and is then identical to frame_b.
The 3 angles are returned in the range
</p>
<pre>
    -<font face=\"Symbol\">p</font> &lt;= angles[i] &lt;= <font face=\"Symbol\">p</font>
</pre>
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
<pre>
  sequence = <strong>{1,2,3}</strong>  // Cardan or Tait-Bryan angle sequence
           = <strong>{3,1,3}</strong>  // Euler angle sequence
           = <strong>{3,2,1}</strong>
</pre>
</html>"));
  end RelativeAngles;

  model RelativeAngularVelocity
    "Measure relative angular velocity between two frame connectors"
    extends Internal.PartialRelativeSensor;

    Blocks.Interfaces.RealOutput w_rel[3](
      each final quantity="AngularVelocity",
      each final unit = "rad/s")
      "Relative angular velocity vector between frame_a and frame_b resolved in frame defined by resolveInFrame"
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={0,-110})));
    Modelica.Mechanics.MultiBody.Interfaces.Frame_resolve frame_resolve if resolveInFrame ==
      Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve
      "Coordinate system in which w_rel is optionally resolved"
      annotation (Placement(transformation(extent={{84,64},{116,96}})));

    parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB resolveInFrame=
      Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_a
      "Frame in which output vector w_rel shall be resolved (world, frame_a, frame_b, or frame_resolve)";

  protected
    Internal.BasicRelativeAngularVelocity relativeAngularVelocity(
      resolveInFrame=resolveInFrame)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    Modelica.Mechanics.MultiBody.Interfaces.ZeroPosition zeroPosition if
      not (resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve)
      annotation (Placement(transformation(extent={{52,20},{72,40}})));

  equation
    connect(relativeAngularVelocity.frame_a, frame_a) annotation (Line(
        points={{-10,0},{-100,0}},
        color={95,95,95},
        thickness=0.5));
    connect(relativeAngularVelocity.frame_b, frame_b) annotation (Line(
        points={{10,0},{100,0}},
        color={95,95,95},
        thickness=0.5));
    connect(relativeAngularVelocity.frame_resolve, frame_resolve) annotation (Line(
        points={{10,8},{30,8},{30,80},{100,80}},
        color={95,95,95},
        pattern=LinePattern.Dot));
    connect(zeroPosition.frame_resolve, relativeAngularVelocity.frame_resolve) annotation (Line(
        points={{52,30},{30,30},{30,8},{10,8}},
        color={95,95,95},
        pattern=LinePattern.Dot));
    connect(relativeAngularVelocity.w_rel, w_rel) annotation (Line(
        points={{0,-11},{0,-110}}, color={0,0,127}));

    annotation (Icon(coordinateSystem(
            preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
          Line(
            points={{0,-70},{0,-100}},
            color={0,0,127}),
          Text(
            extent={{-127,95},{134,143}},
            textString="%name",
            lineColor={0,0,255}),
          Text(
            extent={{14,-78},{98,-108}},
            textString="w_rel")}),
      Documentation(info="<html>
<p>
The relative angular velocity between frame_a and frame_b is
determined and provided at the output signal connector <strong>w_rel</strong>.
</p>

<p>
Via parameter <strong>resolveInFrame</strong> it is defined, in which frame
the angular velocity is resolved:
</p>

<table border=1 cellspacing=0 cellpadding=2>
<tr><th><strong>resolveInFrame =<br>Types.ResolveInFrameAB.</strong></th><th><strong>Meaning</strong></th></tr>
<tr><td>world</td>
    <td>Resolve vector in world frame</td></tr>

<tr><td>frame_a</td>
    <td>Resolve vector in frame_a</td></tr>

<tr><td>frame_b</td>
    <td>Resolve vector in frame_b</td></tr>

<tr><td>frame_resolve</td>
    <td>Resolve vector in frame_resolve</td></tr>
</table>

<p>
In this basic sensor model, <strong>the connector frame_resolve
is always enabled</strong>.
If resolveInFrame = Types.ResolveInFrameAB.frame_resolve, the vector&nbsp;w_rel is
resolved in the frame to which frame_resolve is connected.
</p>

<h4>Example</h4>
<p>
If resolveInFrame = Types.ResolveInFrameAB.frame_a, the output vector is
computed as:
</p>

<blockquote><pre>
// Relative orientation object from frame_a to frame_b
R_rel = MultiBody.Frames.relativeRotation(frame_a.R, frame_b.R);

// Angular velocity resolved in frame_a
w_rel = MultiBody.Frames.angularVelocity1(R_rel);
</pre></blockquote>
</html>"));
  end RelativeAngularVelocity;

  model Distance
    "Measure the distance between the origins of two frame connectors"

    import Modelica.Mechanics.MultiBody.Frames;
    import Modelica.Mechanics.MultiBody.Types;

    extends Interfaces.PartialTwoFrames;
    extends Modelica.Icons.TranslationalSensor;
    Modelica.Blocks.Interfaces.RealOutput distance
      "Distance between the origin of frame_a and the origin of frame_b"
      annotation (Placement(transformation(
          origin={0,-110},
          extent={{10,-10},{-10,10}},
          rotation=90)));

    parameter Boolean animation=true
      "= true, if animation shall be enabled (show arrow)";
    input SI.Diameter arrowDiameter=world.defaultArrowDiameter
      "Diameter of relative arrow from frame_a to frame_b"
      annotation (Dialog(group="if animation = true", enable=animation));
    input Types.Color arrowColor=Modelica.Mechanics.MultiBody.Types.Defaults.SensorColor
      "Color of relative arrow from frame_a to frame_b"
      annotation (Dialog(colorSelector=true, group="if animation = true", enable=animation));
    input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient
      "Reflection of ambient light (= 0: light is completely absorbed)"
      annotation (Dialog(group="if animation = true", enable=animation));
    input SI.Position s_small(min=sqrt(Modelica.Constants.small))=1e-10
      "Prevent zero-division if distance between frame_a and frame_b is zero"
      annotation (Dialog(tab="Advanced"));
  protected
    Modelica.Mechanics.MultiBody.Visualizers.Advanced.Arrow arrow(
      r=frame_a.r_0,
      r_head=frame_b.r_0 - frame_a.r_0,
      diameter=arrowDiameter,
      color=arrowColor,
      specularCoefficient=specularCoefficient) if world.enableAnimation and animation;

  protected
    SI.Position r_rel_0[3] = frame_b.r_0 - frame_a.r_0
      "Position vector from frame_a to frame_b resolved in world frame";
    SI.Area L2 = r_rel_0*r_rel_0;
    SI.Area s_small2 = s_small^2;
  equation
    frame_a.f = zeros(3);
    frame_b.f = zeros(3);
    frame_a.t = zeros(3);
    frame_b.t = zeros(3);

    distance =  smooth(1,if noEvent(L2 > s_small2) then sqrt(L2) else L2/(2*s_small)*(3-L2/s_small2));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Line(points={{0,-60},{0,-100}}, color={0,0,255}),
          Line(points={{-70,0},{-101,0}}),
          Line(points={{70,0},{100,0}}),
          Text(
            extent={{-128,30},{133,78}},
            textString="%name",
            lineColor={0,0,255})}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={
          Line(points={{-70,0},{-101,0}}),
          Line(points={{70,0},{100,0}}),
          Line(points={{0,-60},{0,-100}}, color={0,0,255}),
          Text(
            extent={{-22,70},{20,46}},
            textString="s",
            lineColor={0,0,255}),
          Line(points={{-98,40},{88,40}}, color={0,0,255}),
          Polygon(
            points={{102,40},{87,46},{87,34},{102,40}},
            lineColor={0,0,255},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid)}),
      Documentation(info="<html>
<p>
The <strong>distance</strong> between the origins of frame_a
and of frame_b are determined and provided at the
output signal connector <strong>distance</strong>. This
distance is always positive. <strong>Derivatives</strong> of this
signal can be easily obtained by connecting the
block
<a href=\"modelica://Modelica.Blocks.Continuous.Der\">Modelica.Blocks.Continuous.Der</a>
to \"distance\" (this block performs analytic differentiation
of the input signal using the der(..) operator).
</p>
<p>
In the following figure the animation of a Distance
sensor is shown. The light blue coordinate system is
frame_a, the dark blue coordinate system is frame_b, and
the yellow arrow is the animated sensor.
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Sensors/Distance.png\">
</p>

<p>
If the distance is smaller as parameter <strong>s_small</strong> (in the \"advanced\" menu),
it is approximated such that its derivative is
finite for zero distance. Without such an approximation, the derivative would
be infinite and a division by zero would occur. The approximation is performed
in the following way: If distance > s_small, it is computed as sqrt(r*r) where
r is the position vector from the origin of frame_a to the origin of frame_b.
If the distance becomes smaller as s_small, the \"sqrt()\" function is approximated
by a second order polynomial, such that the function value and its first derivative
are identical for sqrt() and the polynomial at s_small. Furthermore, the polynomial
passes through zero. The effect is, that the distance function is continuous and
differentiable everywhere. The derivative at zero distance is 3/(2*s_small).
</p>
</html>"));
  end Distance;

  model CutForce "Measure cut force vector"

    Modelica.Blocks.Interfaces.RealOutput force[3](each final quantity="Force", each final unit="N")
      "Cut force resolved in frame defined by resolveInFrame"
         annotation (Placement(transformation(
          origin={-80,-110},
          extent={{10,-10},{-10,10}},
          rotation=90)));

    parameter Boolean animation=true
      "= true, if animation shall be enabled (show arrow)";
    parameter Boolean positiveSign=true
      "= true, if force with positive sign is returned (= frame_a.f), otherwise with negative sign (= frame_b.f)";

    input Real N_to_m(unit="N/m") = 1000
      "Force arrow scaling (length = force/N_to_m)"
      annotation (Dialog(group="if animation = true", enable=animation));
    input SI.Diameter forceDiameter=world.defaultArrowDiameter
      "Diameter of force arrow" annotation (Dialog(group="if animation = true", enable=animation));
    input Types.Color forceColor=Modelica.Mechanics.MultiBody.Types.Defaults.
        ForceColor "Color of force arrow"
      annotation (Dialog(colorSelector=true, group="if animation = true", enable=animation));
    input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient
      "Reflection of ambient light (= 0: light is completely absorbed)"
      annotation (Dialog(group="if animation = true", enable=animation));

    extends Modelica.Mechanics.MultiBody.Sensors.Internal.PartialCutForceSensor;

  protected
    SI.Position f_in_m[3]=frame_a.f*(if positiveSign then +1 else -1)/N_to_m
      "Force mapped from N to m for animation";
    Visualizers.Advanced.Arrow forceArrow(
      diameter=forceDiameter,
      color=forceColor,
      specularCoefficient=specularCoefficient,
      R=frame_b.R,
      r=frame_b.r_0,
      r_tail=f_in_m,
      r_head=-f_in_m) if world.enableAnimation and animation;

    Internal.BasicCutForce cutForce(resolveInFrame=resolveInFrame, positiveSign=
          positiveSign)
      annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
    Modelica.Mechanics.MultiBody.Interfaces.ZeroPosition zeroPosition if
      not (resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_resolve)
      annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
  equation
    connect(cutForce.frame_a, frame_a) annotation (Line(
        points={{-50,0},{-100,0}},
        color={95,95,95},
        thickness=0.5));
    connect(cutForce.frame_b, frame_b) annotation (Line(
        points={{-30,0},{100,0}},
        color={95,95,95},
        thickness=0.5));
    connect(cutForce.frame_resolve, frame_resolve) annotation (Line(
        points={{-32,-10},{-32,-60},{80,-60},{80,-100}},
        color={95,95,95},
        pattern=LinePattern.Dot));
    connect(cutForce.force, force) annotation (Line(
        points={{-48,-11},{-48,-60},{-80,-60},{-80,-110}}, color={0,0,127}));
    connect(zeroPosition.frame_resolve, cutForce.frame_resolve) annotation (
        Line(
        points={{0,-30},{-32,-30},{-32,-10}},
        color={95,95,95},
        pattern=LinePattern.Dot));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={Text(
            extent={{-190,-70},{-74,-96}},
            textString="force"), Line(points={{-80,-100},{-80,0}}, color={0,0,
                127})}),
      Documentation(info="<html>
<p>
The cut-force acting between the two frames to which this
model is connected, is determined and provided at the output signal connector
<strong>force</strong> (= frame_a.f). If parameter <strong>positiveSign</strong> =
<strong>false</strong>, the negative cut-force is provided (= frame_b.f).
</p>

<p>
Via parameter <strong>resolveInFrame</strong> it is defined, in which frame
the force vector is resolved:
</p>

<table border=1 cellspacing=0 cellpadding=2>
<tr><th><strong>resolveInFrame =<br>Types.ResolveInFrameA.</strong></th><th><strong>Meaning</strong></th></tr>
<tr><td>world</td>
    <td>Resolve vector in world frame</td></tr>

<tr><td>frame_a</td>
    <td>Resolve vector in frame_a</td></tr>

<tr><td>frame_resolve</td>
    <td>Resolve vector in frame_resolve</td></tr>
</table>

<p>
If resolveInFrame = Types.ResolveInFrameAB.frame_resolve, the conditional connector
\"frame_resolve\" is enabled and output force is resolved in the frame, to
which frame_resolve is connected. Note, if this connector is enabled, it must
be connected.
</p>

<p>
In the following figure the animation of a CutForce
sensor is shown. The dark blue coordinate system is frame_b,
and the green arrow is the cut force acting at frame_b and
with negative sign at frame_a.
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Sensors/CutForce.png\">
</p>
</html>"));
  end CutForce;

  model CutTorque "Measure cut torque vector"

    Modelica.Blocks.Interfaces.RealOutput torque[3]
      "Cut torque resolved in frame defined by resolveInFrame"
         annotation (Placement(transformation(
          origin={-80,-110},
          extent={{10,-10},{-10,10}},
          rotation=90)));

    parameter Boolean animation=true
      "= true, if animation shall be enabled (show arrow)";
    parameter Boolean positiveSign=true
      "= true, if torque with positive sign is returned (= frame_a.t), otherwise with negative sign (= frame_b.t)";
    input Real Nm_to_m(unit="N.m/m") = 1000
      "Torque arrow scaling (length = torque/Nm_to_m)"
      annotation (Dialog(group="if animation = true", enable=animation));
    input SI.Diameter torqueDiameter=world.defaultArrowDiameter
      "Diameter of torque arrow" annotation (Dialog(group="if animation = true", enable=animation));
    input Types.Color torqueColor=Modelica.Mechanics.MultiBody.Types.Defaults.TorqueColor
      "Color of torque arrow"
      annotation (Dialog(colorSelector=true, group="if animation = true", enable=animation));
    input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient
      "Reflection of ambient light (= 0: light is completely absorbed)"
      annotation (Dialog(group="if animation = true", enable=animation));

    extends Modelica.Mechanics.MultiBody.Sensors.Internal.PartialCutForceSensor;

  protected
    SI.Position t_in_m[3]=frame_a.t*(if positiveSign then +1 else -1)/Nm_to_m
      "Torque mapped from Nm to m for animation";
    Visualizers.Advanced.DoubleArrow torqueArrow(
      diameter=torqueDiameter,
      color=torqueColor,
      specularCoefficient=specularCoefficient,
      R=frame_b.R,
      r=frame_b.r_0,
      r_tail=t_in_m,
      r_head=-t_in_m) if world.enableAnimation and animation;
    Internal.BasicCutTorque cutTorque(resolveInFrame=resolveInFrame, positiveSign=
         positiveSign)
      annotation (Placement(transformation(extent={{-62,-10},{-42,10}})));
    Modelica.Mechanics.MultiBody.Interfaces.ZeroPosition zeroPosition if
      not (resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_resolve)
      annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  equation
    connect(cutTorque.frame_a, frame_a) annotation (Line(
        points={{-62,0},{-100,0}},
        color={95,95,95},
        thickness=0.5));
    connect(cutTorque.frame_b, frame_b) annotation (Line(
        points={{-42,0},{100,0}},
        color={95,95,95},
        thickness=0.5));
    connect(cutTorque.torque, torque) annotation (Line(
        points={{-60,-11},{-60,-80},{-80,-80},{-80,-110}}, color={0,0,127}));
    connect(cutTorque.frame_resolve, frame_resolve) annotation (Line(
        points={{-44,-10},{-44,-74},{80,-74},{80,-100}},
        color={95,95,95},
        pattern=LinePattern.Dot));
    connect(zeroPosition.frame_resolve, cutTorque.frame_resolve) annotation (Line(
        points={{-20,-30},{-44,-30},{-44,-10}},
        color={95,95,95},
        pattern=LinePattern.Dot));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{100,
              100}}), graphics={Text(
            extent={{-180,-72},{-64,-98}},
            textString="torque"), Line(points={{-80,-100},{-80,0}}, color={0,0,
                127})}),
      Documentation(info="<html>
<p>
The cut-torque acting between the two frames to which this
model is connected, is determined and provided at the output signal connector
<strong>torque</strong> (= frame_a.t). If parameter <strong>positiveSign</strong> =
<strong>false</strong>, the negative cut-torque is provided (= frame_b.t).
</p>

<p>
Via parameter <strong>resolveInFrame</strong> it is defined, in which frame
the torque vector is resolved:
</p>

<table border=1 cellspacing=0 cellpadding=2>
<tr><th><strong>resolveInFrame =<br>Types.ResolveInFrameA.</strong></th><th><strong>Meaning</strong></th></tr>
<tr><td>world</td>
    <td>Resolve vector in world frame</td></tr>

<tr><td>frame_a</td>
    <td>Resolve vector in frame_a</td></tr>

<tr><td>frame_resolve</td>
    <td>Resolve vector in frame_resolve</td></tr>
</table>

<p>
If resolveInFrame = Types.ResolveInFrameAB.frame_resolve, the conditional connector
\"frame_resolve\" is enabled and output torque is resolved in the frame, to
which frame_resolve is connected. Note, if this connector is enabled, it must
be connected.
</p>

<p>
In the following figure the animation of a CutTorque
sensor is shown. The dark blue coordinate system is frame_b,
and the green arrow is the cut torque acting at frame_b and
with negative sign at frame_a.
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Sensors/CutTorque.png\">
</p>
</html>"));
  end CutTorque;

  model CutForceAndTorque "Measure cut force and cut torque vector"

    import Modelica.Mechanics.MultiBody.Types;

    Modelica.Blocks.Interfaces.RealOutput force[3](each final quantity="Force", each final unit="N")
      "Cut force resolved in frame defined by resolveInFrame"
         annotation (Placement(transformation(
          origin={-80,-110},
          extent={{10,-10},{-10,10}},
          rotation=90)));
    Modelica.Blocks.Interfaces.RealOutput torque[3]
      "Cut torque resolved in frame defined by resolveInFrame"
         annotation (Placement(transformation(
          origin={0,-110},
          extent={{10,-10},{-10,10}},
          rotation=90)));

    parameter Boolean animation=true
      "= true, if animation shall be enabled (show force and torque arrow)";
    parameter Boolean positiveSign=true
      "= true, if force and torque with positive sign is returned (= frame_a.f/.t), otherwise with negative sign (= frame_b.f/.t)";
    input Real N_to_m(unit="N/m") = 1000
      "Force arrow scaling (length = force/N_to_m)"
      annotation (Dialog(group="if animation = true", enable=animation));
    input Real Nm_to_m(unit="N.m/m") = 1000
      "Torque arrow scaling (length = torque/Nm_to_m)"
      annotation (Dialog(group="if animation = true", enable=animation));
    input SI.Diameter forceDiameter=world.defaultArrowDiameter
      "Diameter of force arrow" annotation (Dialog(group="if animation = true", enable=animation));
    input SI.Diameter torqueDiameter=forceDiameter "Diameter of torque arrow"
                                  annotation (Dialog(group="if animation = true", enable=animation));
    input Types.Color forceColor=Modelica.Mechanics.MultiBody.Types.Defaults.ForceColor
      "Color of force arrow"
      annotation (Dialog(colorSelector=true, group="if animation = true", enable=animation));
    input Types.Color torqueColor=Modelica.Mechanics.MultiBody.Types.Defaults.TorqueColor
      "Color of torque arrow"
      annotation (Dialog(colorSelector=true, group="if animation = true", enable=animation));
    input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient
      "Reflection of ambient light (= 0: light is completely absorbed)"
      annotation (Dialog(group="if animation = true", enable=animation));

    extends Modelica.Mechanics.MultiBody.Sensors.Internal.PartialCutForceSensor;

  protected
    parameter Integer csign=if positiveSign then +1 else -1;
    SI.Position f_in_m[3]=frame_a.f*csign/N_to_m
      "Force mapped from N to m for animation";
    SI.Position t_in_m[3]=frame_a.t*csign/Nm_to_m
      "Torque mapped from Nm to m for animation";
    Visualizers.Advanced.Arrow forceArrow(
      diameter=forceDiameter,
      color=forceColor,
      specularCoefficient=specularCoefficient,
      R=frame_b.R,
      r=frame_b.r_0,
      r_tail=f_in_m,
      r_head=-f_in_m) if world.enableAnimation and animation;
    Visualizers.Advanced.DoubleArrow torqueArrow(
      diameter=torqueDiameter,
      color=torqueColor,
      specularCoefficient=specularCoefficient,
      R=frame_b.R,
      r=frame_b.r_0,
      r_tail=t_in_m,
      r_head=-t_in_m) if world.enableAnimation and animation;
    Internal.BasicCutForce cutForce(resolveInFrame=resolveInFrame, positiveSign=
          positiveSign)
      annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
    Internal.BasicCutTorque cutTorque(resolveInFrame=resolveInFrame, positiveSign=
         positiveSign)
      annotation (Placement(transformation(extent={{-2,-10},{18,10}})));
    Modelica.Mechanics.MultiBody.Interfaces.ZeroPosition zeroPosition if
      not (resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_resolve)
      annotation (Placement(transformation(extent={{60,30},{80,50}})));
  equation
    connect(cutForce.frame_a, frame_a) annotation (Line(
        points={{-60,0},{-100,0}},
        color={95,95,95},
        thickness=0.5));
    connect(cutForce.frame_b, cutTorque.frame_a) annotation (Line(
        points={{-40,0},{-2,0}},
        color={95,95,95},
        thickness=0.5));
    connect(cutTorque.frame_b, frame_b) annotation (Line(
        points={{18,0},{100,0}},
        color={95,95,95},
        thickness=0.5));
    connect(cutForce.force, force) annotation (Line(
        points={{-58,-11},{-58,-20},{-80,-20},{-80,-110}}, color={0,0,127}));
    connect(cutTorque.torque, torque) annotation (Line(
        points={{0,-11},{0,-110}}, color={0,0,127}));
    connect(zeroPosition.frame_resolve, cutTorque.frame_resolve) annotation (Line(
        points={{60,40},{32,40},{32,-20},{16,-20},{16,-10}},
        color={95,95,95},
        pattern=LinePattern.Dot));
    connect(zeroPosition.frame_resolve, cutForce.frame_resolve) annotation (Line(
        points={{60,40},{-26,40},{-26,-20},{-42,-20},{-42,-10}},
        color={95,95,95},
        pattern=LinePattern.Dot));
    connect(cutForce.frame_resolve, frame_resolve) annotation (Line(
        points={{-42,-10},{-42,-70},{80,-70},{80,-100}},
        color={95,95,95},
        pattern=LinePattern.Dot));
    connect(cutTorque.frame_resolve, frame_resolve) annotation (Line(
        points={{16,-10},{16,-70},{80,-70},{80,-100}},
        color={95,95,95},
        pattern=LinePattern.Dot));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{100,
              100}}), graphics={
          Line(points={{-80,-100},{-80,0}}, color={0,0,127}),
          Line(points={{0,-100},{0,-70}}, color={0,0,127}),
          Text(
            extent={{-188,-70},{-72,-96}},
            textString="force"),
          Text(
            extent={{-56,-70},{60,-96}},
            textString="torque")}),
      Documentation(info="<html>
<p>
The cut-force and cut-torque acting between the two frames to which this
model is connected, are determined and provided at the output signal connectors
<strong>force</strong> (= frame_a.f) and <strong>torque</strong> (= frame_a.t).
If parameter <strong>positiveSign</strong> =
<strong>false</strong>, the negative cut-force and cut-torque is provided
(= frame_b.f, frame_b.t).
</p>
<p>
Via parameter <strong>resolveInFrame</strong> it is defined, in which frame
the two vectors are resolved:
</p>

<table border=1 cellspacing=0 cellpadding=2>
<tr><th><strong>resolveInFrame =<br>Types.ResolveInFrameA.</strong></th><th><strong>Meaning</strong></th></tr>
<tr><td>world</td>
    <td>Resolve vector in world frame</td></tr>

<tr><td>frame_a</td>
    <td>Resolve vector in frame_a</td></tr>

<tr><td>frame_resolve</td>
    <td>Resolve vector in frame_resolve</td></tr>
</table>

<p>
If resolveInFrame = Types.ResolveInFrameAB.frame_resolve, the conditional connector
\"frame_resolve\" is enabled and the output vectors force and torque are resolved in the frame, to
which frame_resolve is connected. Note, if this connector is enabled, it must
be connected.
</p>

<p>
In the following figure the animation of a CutForceAndTorque
sensor is shown. The dark blue coordinate system is frame_b,
and the green arrows are the cut force and the cut torque,
respectively, acting at frame_b and
with negative sign at frame_a.
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Sensors/CutForceAndTorque.png\">
</p>
</html>"));
  end CutForceAndTorque;

  model Power "Measure power flowing from frame_a to frame_b"
    extends Modelica.Icons.RotationalSensor;

    extends Modelica.Mechanics.MultiBody.Interfaces.PartialTwoFrames;
    Modelica.Blocks.Interfaces.RealOutput power(quantity="Power",unit="W")
      "Power at frame_a as output signal"
      annotation (Placement(transformation(
          origin={-80,-110},
          extent={{10,-10},{-10,10}},
          rotation=90)));

  equation
    Connections.branch(frame_a.R, frame_b.R);
    frame_a.r_0 = frame_b.r_0;
    frame_a.R = frame_b.R;
    zeros(3) = frame_a.f + frame_b.f;
    zeros(3) = frame_a.t + frame_b.t;
    power = frame_a.f*Frames.resolve2(frame_a.R, der(frame_a.r_0))
       + frame_a.t*Frames.angularVelocity2(frame_a.R);
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Line(points={{-70,0},{-101,0}}),
          Line(points={{70,0},{100,0}}),
          Line(points={{-80,0},{-80,-100}}, color={0,0,127}),
          Text(
            extent={{-60,-92},{16,-114}},
            textString="power"),
          Text(
            extent={{-128,126},{126,68}},
            textString="%name",
            lineColor={0,0,255})}),
      Documentation(info="<html>
<p>
This component provides the power flowing from frame_a to frame_b
as output signal <strong>power</strong>.
</p>
</html>"));
  end Power;

  model TransformAbsoluteVector "Transform absolute vector in to another frame"
    extends Modelica.Icons.RotationalSensor;

    Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a
      "Coordinate system from which absolute kinematic quantities are measured"
      annotation (Placement(
          transformation(extent={{-116,-16},{-84,16}})));

    Modelica.Mechanics.MultiBody.Interfaces.Frame_resolve frame_resolve if
     (frame_r_in  == Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_resolve) or
     (frame_r_out == Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_resolve)
      "Coordinate system in which r_in or r_out is optionally resolved"
      annotation (Placement(transformation(extent={{84,-16},{116,16}})));

    Blocks.Interfaces.RealInput r_in[3]
      "Input vector resolved in frame defined by frame_r_in"
      annotation (Placement(transformation(extent={{-20,-20},{20,20}},
          rotation=-90,
          origin={0,120})));
    Blocks.Interfaces.RealOutput r_out[3]
      "Input vector r_in resolved in frame defined by frame_r_out"
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={0,-110})));

    parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameA frame_r_in=
    Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a
      "Frame in which vector r_in is resolved (world, frame_a, or frame_resolve)";
    parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameA frame_r_out=
                    frame_r_in
      "Frame in which vector r_in shall be resolved and provided as r_out (world, frame_a, or frame_resolve)";

  protected
    Internal.BasicTransformAbsoluteVector basicTransformVector(frame_r_in=
          frame_r_in, frame_r_out=frame_r_out)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    Modelica.Mechanics.MultiBody.Interfaces.ZeroPosition zeroPosition if
      not (frame_r_in == Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_resolve or
           frame_r_out == Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_resolve)
      annotation (Placement(transformation(extent={{40,18},{60,38}})));

  equation
    connect(basicTransformVector.frame_a, frame_a) annotation (Line(
        points={{-10,0},{-100,0}},
        color={95,95,95},
        thickness=0.5));
    connect(basicTransformVector.frame_resolve, frame_resolve) annotation (Line(
        points={{10,0},{100,0}},
        color={95,95,95},
        pattern=LinePattern.Dot));
    connect(zeroPosition.frame_resolve, basicTransformVector.frame_resolve)
      annotation (Line(
        points={{40,28},{32,28},{32,0},{10,0}},
        color={95,95,95},
        pattern=LinePattern.Dot));
    connect(basicTransformVector.r_out, r_out) annotation (Line(
        points={{0,-11},{0,-110}}, color={0,0,127}));
    connect(basicTransformVector.r_in, r_in) annotation (Line(
        points={{0,12},{0,120}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(
            preserveAspectRatio=true,  extent={{-100,-100},{100,100}}),
          graphics={
          Line(
            points={{0,-70},{0,-100}},
            color={0,0,127}),
          Line(
            points={{0,100},{0,70}},
            color={0,0,127}),
          Text(
            extent={{-104,124},{-18,96}},
            textString="r_in"),
          Text(
            extent={{-124,-76},{2,-104}},
            textString="r_out"),
          Line(
            points={{95,0},{95,0},{70,0},{70,0}},
            pattern=LinePattern.Dot),
          Text(
            extent={{58,47},{189,22}},
            lineColor={95,95,95},
            textString="resolve"),
          Line(
            points={{-70,0},{-96,0},{-96,0}}),
          Text(
            extent={{-116,45},{-80,20}},
            lineColor={95,95,95},
            textString="a")}),
      Documentation(info="<html>
<p>
The input vector \"Real r_in[3]\" is assumed to be an absolute kinematic quantity
of frame_a that is defined to be resolved in the frame defined
with parameter \"frame_r_in\". This model resolves vector r_in in the
coordinate system defined with parameter \"frame_r_out\" and returns the
transformed output vector as \"Real r_out[3]\";
</p>
</html>"));
  end TransformAbsoluteVector;

  model TransformRelativeVector "Transform relative vector in to another frame"
    extends Internal.PartialRelativeSensor;

    Modelica.Mechanics.MultiBody.Interfaces.Frame_resolve frame_resolve if
     (frame_r_in  == Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve) or
     (frame_r_out == Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve)
      "Coordinate system in which r_in or r_out is optionally resolved"
      annotation (Placement(transformation(extent={{84,64},{116,96}})));

    Blocks.Interfaces.RealInput r_in[3]
      "Input vector resolved in frame defined by frame_r_in"
      annotation (Placement(transformation(extent={{-20,-20},{20,20}},
          rotation=-90,
          origin={0,120})));
    Blocks.Interfaces.RealOutput r_out[3]
      "Input vector r_in resolved in frame defined by frame_r_out"
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={0,-110})));

    parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB frame_r_in=
    Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_a
      "Frame in which vector r_in is resolved (world, frame_a, frame_b, or frame_resolve)";
    parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB frame_r_out=
                    frame_r_in
      "Frame in which vector r_in shall be resolved and provided as r_out (world, frame_a, frame_b, or frame_resolve)";

  protected
    Modelica.Mechanics.MultiBody.Sensors.Internal.BasicTransformRelativeVector
      basicTransformVector(
        frame_r_in=frame_r_in,
        frame_r_out=frame_r_out)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    Modelica.Mechanics.MultiBody.Interfaces.ZeroPosition zeroPosition if
      not (frame_r_in == Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve or
           frame_r_out == Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve)
      annotation (Placement(transformation(extent={{48,10},{68,30}})));

  equation
    connect(basicTransformVector.frame_a, frame_a) annotation (Line(
        points={{-10,0},{-100,0}},
        color={95,95,95},
        thickness=0.5));
    connect(basicTransformVector.frame_b, frame_b) annotation (Line(
        points={{10,0},{100,0}},
        color={95,95,95},
        thickness=0.5));
    connect(basicTransformVector.frame_resolve, frame_resolve) annotation (Line(
        points={{10,8},{20,8},{20,8},{32,8},{32,80},{100,80}},
        color={95,95,95},
        pattern=LinePattern.Dot));
    connect(zeroPosition.frame_resolve, basicTransformVector.frame_resolve)
      annotation (Line(
        points={{48,20},{32,20},{32,8},{10,8}},
        color={95,95,95},
        pattern=LinePattern.Dot));
    connect(basicTransformVector.r_out, r_out) annotation (Line(
        points={{0,-11},{0,-110}}, color={0,0,127}));
    connect(basicTransformVector.r_in, r_in) annotation (Line(
        points={{0,12},{0,120}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(
            preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
          Line(
            points={{0,-70},{0,-100}},
            color={0,0,127}),
          Line(
            points={{0,100},{0,70}},
            color={0,0,127}),
          Text(
            extent={{-104,124},{-18,96}},
            textString="r_in"),
          Text(
            extent={{-124,-76},{2,-104}},
            textString="r_out"),
          Text(
            extent={{70,126},{200,100}},
            lineColor={95,95,95},
            textString="resolve")}),
      Documentation(info="<html>
<p>
The input vector \"Real r_in[3]\" is assumed to be a relative kinematic quantity
between frame_a and frame_b
that is defined to be resolved in the frame defined
with parameter \"frame_r_in\". This model resolves vector r_in in the
coordinate system defined with parameter \"frame_r_out\" and returns the
transformed output vector as \"Real r_out[3]\";
</p>
</html>"));
  end TransformRelativeVector;

  package Internal "Internal package, should not be used by user"
    extends Modelica.Icons.InternalPackage;
    partial model PartialAbsoluteSensor "Base class for absolute sensor models"
      extends Modelica.Icons.RotationalSensor;

      Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a
        "Coordinate system a of which the absolute kinematic quantities are measured" annotation (Placement(
            transformation(extent={{-116,-16},{-84,16}})));

    equation
      assert(cardinality(frame_a) > 0, "Connector frame_a must be connected at least once");

      annotation (Icon(coordinateSystem(preserveAspectRatio=true,
              extent={{-100,-100},{100,100}}), graphics={Text(
              extent={{-108,43},{-72,18}},
              lineColor={128,128,128},
              textString="a"), Line(
              points={{-70,0},{-96,0},{-96,0}})}), Documentation(info="<html>
<p>
This is a base class of a 3-dim. mechanical component with one frame
<strong>frame_a</strong> in order to measure an absolute quantity of this
connector.
This partial class can be used for sensors defined either by components or by equations.
</p>
</html>"));
    end PartialAbsoluteSensor;

    model PartialAbsoluteBaseSensor
      "Base class for absolute sensor models defined by equations (frame_resolve must be connected exactly once)"
      extends Modelica.Icons.RotationalSensor;

      Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a
        "Coordinate system from which kinematic quantities are measured" annotation (Placement(
            transformation(extent={{-116,-16},{-84,16}})));

      Modelica.Mechanics.MultiBody.Interfaces.Frame_resolve frame_resolve
        "Coordinate system in which output vector(s) is optionally resolved"
        annotation (Placement(transformation(extent={{-16,-16},{16,16}},
            rotation=-90,
            origin={0,-100})));

    equation
      assert(cardinality(frame_a) > 0, "Connector frame_a must be connected at least once");
      assert(cardinality(frame_resolve) == 1, "Connector frame_resolve must be connected exactly once");
      frame_a.f = zeros(3);
      frame_a.t = zeros(3);
      frame_resolve.f = zeros(3);
      frame_resolve.t = zeros(3);

      annotation (Icon(coordinateSystem(preserveAspectRatio=true,
              extent={{-100,-100},{100,100}}), graphics={
            Text(
              extent={{-108,43},{-72,18}},
              lineColor={95,95,95},
              textString="a"),
            Line(
              points={{-70,0},{-96,0},{-96,0}}),
            Line(
              points={{0,15},{0,-15}},
              color={0,0,127},
              origin={85,0},
              rotation=90),
            Line(
              points={{0,-95},{0,-95},{0,-70},{0,-70}},
              pattern=LinePattern.Dot),
            Text(
              extent={{0,-75},{131,-100}},
              lineColor={95,95,95},
              textString="resolve")}), Documentation(info="<html>
<p>
Partial base class for absolute sensor models defined by equations.
The connector frame_resolve is always enabled and must be connected exactly once.
</p>
</html>"));
    end PartialAbsoluteBaseSensor;

    partial model PartialRelativeSensor
      "Base class for relative sensor models"
      extends Modelica.Icons.RotationalSensor;

      Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a
        "Coordinate system a" annotation (Placement(
            transformation(extent={{-116,-16},{-84,16}})));
      Modelica.Mechanics.MultiBody.Interfaces.Frame_b frame_b
        "Coordinate system b" annotation (Placement(
            transformation(extent={{84,-16},{116,16}})));

    equation
      assert(cardinality(frame_a) > 0, "Connector frame_a must be connected at least once");
      assert(cardinality(frame_b) > 0, "Connector frame_b must be connected at least once");
      annotation (Icon(coordinateSystem(preserveAspectRatio=true,
              extent={{-100,-100},{100,100}}), graphics={
            Text(
              extent={{-108,43},{-72,18}},
              lineColor={128,128,128},
              textString="a"),
            Text(
              extent={{72,43},{108,18}},
              lineColor={128,128,128},
              textString="b"),
            Line(
              points={{-70,0},{-96,0},{-96,0}}),
            Line(
              points={{96,0},{70,0},{70,0}}),
            Line(
              points={{60,36},{60,36},{60,80},{95,80}},
              pattern=LinePattern.Dot)}), Documentation(info="<html>
<p>
This is a base class of a 3-dim. mechanical component with two frames
<strong>frame_a</strong> and <strong>frame_b</strong>
in order to measure a relative quantity between these two connectors.
This partial class can be used for sensors defined either by components or by equations.
</p>
</html>"));
    end PartialRelativeSensor;

    model PartialRelativeBaseSensor
      "Base class for relative sensor models defined by equations (frame_resolve must be connected exactly once)"
      extends Modelica.Icons.RotationalSensor;

      Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a
        "Coordinate system a (measurement is between frame_a and frame_b)" annotation (Placement(
            transformation(extent={{-116,-16},{-84,16}})));
      Modelica.Mechanics.MultiBody.Interfaces.Frame_b frame_b
        "Coordinate system b (measurement is between frame_a and frame_b)" annotation (Placement(
            transformation(extent={{84,-16},{116,16}})));

      Modelica.Mechanics.MultiBody.Interfaces.Frame_resolve frame_resolve
        "Coordinate system in which vector is optionally resolved"
        annotation (Placement(transformation(extent={{84,64},{116,96}})));

    equation
      assert(cardinality(frame_a) > 0, "Connector frame_a must be connected at least once");
      assert(cardinality(frame_b) > 0, "Connector frame_b must be connected at least once");
      assert(cardinality(frame_resolve) == 1, "Connector frame_resolve must be connected exactly once");
      frame_a.f = zeros(3);
      frame_a.t = zeros(3);
      frame_b.f = zeros(3);
      frame_b.t = zeros(3);
      frame_resolve.f = zeros(3);
      frame_resolve.t = zeros(3);

      annotation (Icon(coordinateSystem(preserveAspectRatio=true,
              extent={{-100,-100},{100,100}}), graphics={
            Text(
              extent={{-108,43},{-72,18}},
              lineColor={128,128,128},
              textString="a"),
            Text(
              extent={{72,41},{108,16}},
              lineColor={128,128,128},
              textString="b"),
            Line(
              points={{-70,0},{-96,0},{-96,0}}),
            Line(
              points={{96,0},{70,0},{70,0}}),
            Line(
              points={{0,-70},{0,-100}},
              color={0,0,127}),
            Line(
              points={{60,36},{60,36},{60,80},{95,80}},
              pattern=LinePattern.Dot)}), Documentation(info="<html>
<p>
Partial base class for relative sensor models defined by equations.
The connector frame_resolve is always enabled and must be connected exactly once.
</p>
</html>"));
    end PartialRelativeBaseSensor;

    model BasicAbsolutePosition
      "Basic sensor to measure absolute position vector"
      import Modelica.Mechanics.MultiBody.Types.ResolveInFrameA;
      extends Modelica.Mechanics.MultiBody.Sensors.Internal.PartialAbsoluteBaseSensor;
      Modelica.Blocks.Interfaces.RealOutput r[3](
        each final quantity="Length", each final unit = "m")
        "Absolute position vector frame_a.r_0 resolved in frame defined by resolveInFrame"
        annotation (Placement(transformation(
            origin={110,0},
            extent={{-10,-10},{10,10}})));

      parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameA resolveInFrame=
        Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a
        "Frame in which output vector r is resolved (world, frame_a, or frame_resolve)";

    equation
      if resolveInFrame == ResolveInFrameA.world then
        r = frame_a.r_0;
      elseif resolveInFrame == ResolveInFrameA.frame_a then
        r = Frames.resolve2(frame_a.R, frame_a.r_0);
      elseif resolveInFrame == ResolveInFrameA.frame_resolve then
        r = Frames.resolve2(frame_resolve.R, frame_a.r_0);
      else
        assert(false, "Wrong value for parameter resolveInFrame");
        r = zeros(3);
      end if;
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
              extent={{61,47},{145,17}},
              textString="r"), Text(
              extent={{-127,75},{134,123}},
              textString="%name",
              lineColor={0,0,255})}), Documentation(info="<html>
<p>
This basic sensor is aimed to be used within advanced sensors where
the absolute position vector of the origin of frame_a should be determined.
This vector is provided at the output signal connector&nbsp;<strong>r</strong>.
</p>

<p>
Via parameter <strong>resolveInFrame</strong> it is defined in which frame
the position vector is resolved:
</p>

<table border=1 cellspacing=0 cellpadding=2>
<tr><th><strong>resolveInFrame =<br>Types.ResolveInFrameA.</strong></th><th><strong>Meaning</strong></th></tr>
<tr><td>world</td>
    <td>Resolve vector in world frame</td></tr>

<tr><td>frame_a</td>
    <td>Resolve vector in frame_a</td></tr>

<tr><td>frame_resolve</td>
    <td>Resolve vector in frame_resolve</td></tr>
</table>

<p>
In this basic sensor model, <strong>the connector frame_resolve
is always enabled and must be connected</strong>.
If resolveInFrame = Types.ResolveInFrameA.frame_resolve, the vector&nbsp;r is
resolved in the frame to which frame_resolve is connected.
</p>

<h4>Example</h4>
<p>
If resolveInFrame = Types.ResolveInFrameA.frame_a, the output vector is
computed as:
</p>

<blockquote><pre>
r = MultiBody.Frames.resolve2(frame_a.R, frame_b.r_0);
</pre></blockquote>
</html>"));
    end BasicAbsolutePosition;

    model BasicAbsoluteAngularVelocity "Basic sensor to measure absolute angular velocity"
      import Modelica.Mechanics.MultiBody.Frames;
      import Modelica.Mechanics.MultiBody.Types.ResolveInFrameA;

      extends
        Modelica.Mechanics.MultiBody.Sensors.Internal.PartialAbsoluteBaseSensor;
      Modelica.Blocks.Interfaces.RealOutput w[3](each final quantity="AngularVelocity",each final unit = "rad/s")
        "Absolute angular velocity vector"
        annotation (Placement(transformation(
            origin={110,0},
            extent={{-10,-10},{10,10}})));
      parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameA
        resolveInFrame=
      Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a
        "Frame in which output vector w is resolved (world, frame_a, or frame_resolve)";

    equation
       if resolveInFrame == ResolveInFrameA.world then
          w = Frames.angularVelocity1(frame_a.R);
       elseif resolveInFrame == ResolveInFrameA.frame_a then
          w = Frames.angularVelocity2(frame_a.R);
       elseif resolveInFrame == ResolveInFrameA.frame_resolve then
          w = Frames.resolveRelative(Frames.angularVelocity1(frame_a.R), frame_a.R, frame_resolve.R);
       else
          assert(false, "Wrong value for parameter resolveInFrame");
          w = zeros(3);
       end if;
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
              extent={{62,48},{146,18}},
              textString="w"), Text(
              extent={{-130,76},{131,124}},
              textString="%name",
              lineColor={0,0,255})}), Documentation(info="<html>
<p>
This basic sensor is aimed to be used within advanced sensors where
the absolute angular velocity of frame_a should be determined.
This vector is provided at the output signal connector&nbsp;<strong>w</strong>.
</p>

<p>
Via parameter <strong>resolveInFrame</strong> it is defined, in which frame
the angular velocity is resolved:
</p>

<table border=1 cellspacing=0 cellpadding=2>
<tr><th><strong>resolveInFrame =<br>Types.ResolveInFrameA.</strong></th><th><strong>Meaning</strong></th></tr>
<tr><td>world</td>
    <td>Resolve vector in world frame</td></tr>

<tr><td>frame_a</td>
    <td>Resolve vector in frame_a</td></tr>

<tr><td>frame_resolve</td>
    <td>Resolve vector in frame_resolve</td></tr>
</table>

<p>
In this basic sensor model, <strong>the connector frame_resolve
is always enabled and must be connected</strong>.
If resolveInFrame = Types.ResolveInFrameA.frame_resolve, the vector&nbsp;w is
resolved in the frame to which frame_resolve is connected.
</p>

<h4>Example</h4>
<p>
If resolveInFrame = Types.ResolveInFrameA.frame_a, the output vector is
computed as:
</p>

<blockquote><pre>
w = MultiBody.Frames.angularVelocity2(frame_a.R);
</pre></blockquote>
</html>"));
    end BasicAbsoluteAngularVelocity;

    model BasicRelativePosition
      "Basic sensor to measure relative position vector"
      import Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB;
      extends
        Modelica.Mechanics.MultiBody.Sensors.Internal.PartialRelativeBaseSensor;
      Modelica.Blocks.Interfaces.RealOutput r_rel[3](each final quantity="Length", each final
                unit = "m")
        "Relative position vector frame_b.r_0 - frame_a.r_0 resolved in frame defined by resolveInFrame"
        annotation (Placement(transformation(
            origin={0,-110},
            extent={{-10,-10},{10,10}},
            rotation=270)));

      parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB
        resolveInFrame=
      Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_a
        "Frame in which output vector r_rel is resolved (world, frame_a, frame_b, or frame_resolve)";

    equation
       if resolveInFrame == ResolveInFrameAB.frame_a then
          r_rel = Frames.resolve2(frame_a.R, frame_b.r_0 - frame_a.r_0);
       elseif resolveInFrame == ResolveInFrameAB.frame_b then
          r_rel = Frames.resolve2(frame_b.R, frame_b.r_0 - frame_a.r_0);
       elseif resolveInFrame == ResolveInFrameAB.world then
          r_rel = frame_b.r_0 - frame_a.r_0;
       elseif resolveInFrame == ResolveInFrameAB.frame_resolve then
          r_rel = Frames.resolve2(frame_resolve.R, frame_b.r_0 - frame_a.r_0);
       else
          assert(false, "Wrong value for parameter resolveInFrame");
          r_rel = zeros(3);
       end if;
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
              extent={{12,-76},{96,-106}},
              textString="r_rel"), Text(
              extent={{-127,95},{134,143}},
              textString="%name",
              lineColor={0,0,255})}), Documentation(info="<html>
<p>
This basic sensor is aimed to be used within advanced sensors where
the relative position vector between the origins of frame_a and frame_b should be determined.
This vector is provided at the output signal connector&nbsp;<strong>r_rel</strong>.
</p>

<p>
Via parameter <strong>resolveInFrame</strong> it is defined in which frame
the position vector is resolved:
</p>

<table border=1 cellspacing=0 cellpadding=2>
<tr><th><strong>resolveInFrame =<br>Types.ResolveInFrameAB.</strong></th><th><strong>Meaning</strong></th></tr>
<tr><td>world</td>
    <td>Resolve vector in world frame</td></tr>

<tr><td>frame_a</td>
    <td>Resolve vector in frame_a</td></tr>

<tr><td>frame_b</td>
    <td>Resolve vector in frame_b</td></tr>

<tr><td>frame_resolve</td>
    <td>Resolve vector in frame_resolve</td></tr>
</table>

<p>
In this basic sensor model, <strong>the connector frame_resolve
is always enabled and must be connected</strong>.
If resolveInFrame = Types.ResolveInFrameAB.frame_resolve, the vector&nbsp;r_rel is
resolved in the frame to which frame_resolve is connected.
</p>

<h4>Example</h4>
<p>
If resolveInFrame = Types.ResolveInFrameAB.frame_a, the output vector is
computed as:
</p>

<blockquote><pre>
r_rel = MultiBody.Frames.resolve2(frame_a.R, frame_b.r_0 - frame_a.r_0);
</pre></blockquote>
</html>"));
    end BasicRelativePosition;

    model BasicRelativeAngularVelocity "Basic sensor to measure relative angular velocity"
      import Modelica.Mechanics.MultiBody.Frames;
      import Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB;

      extends
        Modelica.Mechanics.MultiBody.Sensors.Internal.PartialRelativeBaseSensor;
      Modelica.Blocks.Interfaces.RealOutput w_rel[3](each final quantity="AngularVelocity",each final unit = "rad/s")
        "Relative angular velocity vector"
        annotation (Placement(transformation(
            origin={0,-110},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB
        resolveInFrame=
      Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_a
        "Frame in which output vector w_rel is resolved (world, frame_a, frame_b, or frame_resolve)";

    protected
      Modelica.Mechanics.MultiBody.Frames.Orientation R_rel
        "Relative orientation object from frame_a to frame_b";
    equation
       R_rel = Frames.relativeRotation(frame_a.R, frame_b.R);
       if resolveInFrame == ResolveInFrameAB.frame_a then
          w_rel = Frames.angularVelocity1(R_rel);
       elseif resolveInFrame == ResolveInFrameAB.frame_b then
          w_rel = Frames.angularVelocity2(R_rel);
       elseif resolveInFrame == ResolveInFrameAB.world then
          w_rel = Frames.resolve1(frame_a.R, Frames.angularVelocity1(R_rel));
       elseif resolveInFrame == ResolveInFrameAB.frame_resolve then
          w_rel = Frames.resolveRelative(Frames.angularVelocity1(R_rel), frame_a.R, frame_resolve.R);
       else
          assert(false, "Wrong value for parameter resolveInFrame");
          w_rel = zeros(3);
       end if;
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
              extent={{12,-76},{96,-106}},
              textString="w_rel"), Text(
              extent={{-132,90},{129,138}},
              textString="%name",
              lineColor={0,0,255})}), Documentation(info="<html>
<p>
This basic sensor is aimed to be used within advanced sensors where
the relative angular velocity between frame_a and frame_b should be determined.
This vector is provided at the output signal connector&nbsp;<strong>w_rel</strong>.
</p>

<p>
Via parameter <strong>resolveInFrame</strong> it is defined, in which frame
the angular velocity is resolved:
</p>

<table border=1 cellspacing=0 cellpadding=2>
<tr><th><strong>resolveInFrame =<br>Types.ResolveInFrameAB.</strong></th><th><strong>Meaning</strong></th></tr>
<tr><td>world</td>
    <td>Resolve vector in world frame</td></tr>

<tr><td>frame_a</td>
    <td>Resolve vector in frame_a</td></tr>

<tr><td>frame_b</td>
    <td>Resolve vector in frame_b</td></tr>

<tr><td>frame_resolve</td>
    <td>Resolve vector in frame_resolve</td></tr>
</table>

<p>
In this basic sensor model, <strong>the connector frame_resolve
is always enabled and must be connected</strong>.
If resolveInFrame = Types.ResolveInFrameAB.frame_resolve, the vector&nbsp;w_rel is
resolved in the frame to which frame_resolve is connected.
</p>

<h4>Example</h4>
<p>
If resolveInFrame = Types.ResolveInFrameAB.frame_a, the output vector is
computed as:
</p>

<blockquote><pre>
// Relative orientation object from frame_a to frame_b
R_rel = MultiBody.Frames.relativeRotation(frame_a.R, frame_b.R);

// Angular velocity resolved in frame_a
w_rel = MultiBody.Frames.angularVelocity1(R_rel);
</pre></blockquote>
</html>"));
    end BasicRelativeAngularVelocity;

    model BasicTransformAbsoluteVector
      "Transform absolute vector into another frame"
      import Modelica.Mechanics.MultiBody.Frames;
      import Modelica.Mechanics.MultiBody.Types.ResolveInFrameA;

      extends Modelica.Icons.RotationalSensor;

      parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameA frame_r_in=
        Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a
        "Frame in which vector r_in is resolved (world, frame_a, or frame_resolve)";
      parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameA frame_r_out=
        frame_r_in
        "Frame in which vector r_out (= r_in in other frame) is resolved (world, frame_a, or frame_resolve)";

      Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a
        "Coordinate system from which absolute kinematic quantities are measured"
        annotation (Placement(
            transformation(extent={{-116,-16},{-84,16}})));

      Modelica.Mechanics.MultiBody.Interfaces.Frame_resolve frame_resolve
        "Coordinate system in which vector is optionally resolved"
        annotation (Placement(transformation(extent={{-16,-16},{16,16}},
            origin={100,0})));

      Blocks.Interfaces.RealInput r_in[3]
        "Input vector resolved in frame defined by frame_r_in"
        annotation (Placement(transformation(extent={{-20,-20},{20,20}},
            rotation=-90,
            origin={0,120})));
      Blocks.Interfaces.RealOutput r_out[3]
        "Input vector r_in resolved in frame defined by frame_r_out"
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={0,-110})));

    protected
      Modelica.Mechanics.MultiBody.Frames.Orientation R1
        "Orientation object from world frame to frame in which r_in is resolved";
    equation
      assert(cardinality(frame_a) > 0, "Connector frame_a must be connected at least once");
      assert(cardinality(frame_resolve) == 1, "Connector frame_resolve must be connected exactly once");
      frame_a.f = zeros(3);
      frame_a.t = zeros(3);
      frame_resolve.f = zeros(3);
      frame_resolve.t = zeros(3);

      if frame_r_out == frame_r_in then
        r_out = r_in;
        R1 = Frames.nullRotation();
      else
        if frame_r_in == ResolveInFrameA.world then
          R1 = Frames.nullRotation();
        elseif frame_r_in == ResolveInFrameA.frame_a then
          R1 = frame_a.R;
        elseif frame_r_in == ResolveInFrameA.frame_resolve then
          R1 = frame_resolve.R;
        else
          assert(false, "Wrong value for parameter frame_r_in");
          R1 = Frames.nullRotation();
        end if;

        if frame_r_out == ResolveInFrameA.world then
          r_out = Frames.resolve1(R1, r_in);
        elseif frame_r_out == ResolveInFrameA.frame_a then
          r_out = Frames.resolveRelative(r_in, R1, frame_a.R);
        elseif frame_r_out == ResolveInFrameA.frame_resolve then
          r_out = Frames.resolveRelative(r_in, R1, frame_resolve.R);
        else
          assert(false, "Wrong value for parameter frame_r_out");
          r_out = zeros(3);
        end if;
      end if;

      annotation (Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100,
                -100},{100,100}}), graphics={
            Text(
              extent={{-128,-84},{-2,-112}},
              textString="r_out"),
            Text(
              extent={{-108,137},{-22,109}},
              textString="r_in"),
            Line(
              points={{0,100},{0,70}},
              color={0,0,127}),
            Line(
              points={{0,-70},{0,-100}},
              color={0,0,127}),
            Text(
              extent={{58,47},{189,22}},
              lineColor={95,95,95},
              textString="resolve"),
            Text(
              extent={{-116,45},{-80,20}},
              lineColor={95,95,95},
              textString="a"),
            Line(
              points={{-70,0},{-96,0},{-96,0}}),
            Line(
              points={{95,0},{95,0},{70,0},{70,0}},
              pattern=LinePattern.Dot)}), Documentation(info="<html>
<p>
This basic sensor transforms an absolute vector <strong>r_in</strong>,
resolved in frame defined by frame_r_in,
into another frame specified by frame_r_out.
This output vector is provided at the output signal connector <strong>r_out</strong>.
</p>

<p>
Via parameters <strong>frame_r_in</strong> and <strong>frame_r_out</strong> it is
defined in which frame the position vector is resolved:
</p>

<table border=1 cellspacing=0 cellpadding=2>
<tr><th><strong>resolveInFrame =<br>Types.ResolveInFrameA.</strong></th><th><strong>Meaning</strong></th></tr>
<tr><td>world</td>
    <td>Resolve vector in world frame</td></tr>

<tr><td>frame_a</td>
    <td>Resolve vector in frame_a</td></tr>

<tr><td>frame_resolve</td>
    <td>Resolve vector in frame_resolve</td></tr>
</table>

<p>
In this basic sensor model, <strong>the connector frame_resolve
is always enabled and must be connected</strong>.
</p>
</html>"));
    end BasicTransformAbsoluteVector;

    model BasicTransformRelativeVector
      "Transform relative vector into another frame"
      import Modelica.Mechanics.MultiBody.Frames;
      import Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB;
      extends
        Modelica.Mechanics.MultiBody.Sensors.Internal.PartialRelativeBaseSensor;
      parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB frame_r_in=
      Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_a
        "Frame in which vector r_in is resolved (world, frame_a, frame_b, or frame_resolve)";
      parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB frame_r_out=
        frame_r_in
        "Frame in which vector r_out (= r_in in other frame) is resolved (world, frame_a, frame_b, or frame_resolve)";

      Blocks.Interfaces.RealInput r_in[3]
        "Input vector resolved in frame defined by frame_r_in"
        annotation (Placement(transformation(extent={{-20,-20},{20,20}},
            rotation=-90,
            origin={0,120})));
      Blocks.Interfaces.RealOutput r_out[3]
        "Input vector r_in resolved in frame defined by frame_r_out"
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={0,-110})));

    protected
      Modelica.Mechanics.MultiBody.Frames.Orientation R1
        "Orientation object from world frame to frame in which r_in is resolved";
    equation
       if frame_r_out == frame_r_in then
          r_out = r_in;
          R1 = Frames.nullRotation();
       else
          if frame_r_in == ResolveInFrameAB.world then
             R1 = Frames.nullRotation();
          elseif frame_r_in == ResolveInFrameAB.frame_a then
             R1 = frame_a.R;
          elseif frame_r_in == ResolveInFrameAB.frame_b then
             R1 = frame_b.R;
          else
             R1 = frame_resolve.R;
          end if;

          if frame_r_out == ResolveInFrameAB.world then
             r_out = Frames.resolve1(R1, r_in);
          elseif frame_r_out == ResolveInFrameAB.frame_a then
             r_out = Frames.resolveRelative(r_in, R1, frame_a.R);
          elseif frame_r_out == ResolveInFrameAB.frame_b then
             r_out = Frames.resolveRelative(r_in, R1, frame_b.R);
          else
             r_out = Frames.resolveRelative(r_in, R1, frame_resolve.R);
          end if;
       end if;
      annotation (Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100,
                -100},{100,100}}), graphics={
            Text(
              extent={{-128,-92},{-2,-120}},
              textString="r_out"),
            Text(
              extent={{-108,144},{-22,116}},
              textString="r_in"),
            Line(
              points={{0,100},{0,70}},
              color={0,0,127})}), Documentation(info="<html>
<p>
This basic sensor transforms a relative vector <strong>r_in</strong>,
resolved in frame defined by frame_r_in,
into another frame specified by frame_r_out.
This output vector is provided at the output signal connector <strong>r_out</strong>.
</p>

<p>
Via parameters <strong>frame_r_in</strong> and <strong>frame_r_out</strong> it is
defined in which frame the position vector is resolved:
</p>

<table border=1 cellspacing=0 cellpadding=2>
<tr><th><strong>resolveInFrame =<br>Types.ResolveInFrameAB.</strong></th><th><strong>Meaning</strong></th></tr>
<tr><td>world</td>
    <td>Resolve vector in world frame</td></tr>

<tr><td>frame_a</td>
    <td>Resolve vector in frame_a</td></tr>

<tr><td>frame_b</td>
    <td>Resolve vector in frame_b</td></tr>

<tr><td>frame_resolve</td>
    <td>Resolve vector in frame_resolve</td></tr>
</table>

<p>
In this basic sensor model, <strong>the connector frame_resolve
is always enabled and must be connected</strong>.
</p>
</html>"));
    end BasicTransformRelativeVector;

    model ZeroForceAndTorque "Set force and torque to zero"
       extends Modelica.Blocks.Icons.Block;
      Interfaces.Frame_a frame_a
        annotation (Placement(transformation(extent={{-116,-16},{-84,16}})));
    equation
      frame_a.f = zeros(3);
      frame_a.t = zeros(3);
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
              extent={{-74,24},{80,-20}},
              textString="f = t = 0")}), Documentation(info="<html>
<p>Set force and torque vectors on frame connector frame_a to zero.</p>
<!--a placeholder to fulfill minimum documentation length-->
</html>"));
    end ZeroForceAndTorque;

    partial model PartialCutForceSensor
      "Base class to measure cut force and/or torque between two frames, defined by components"

      extends Modelica.Icons.RotationalSensor;
      Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a
        "Coordinate system a" annotation (Placement(
            transformation(extent={{-116,-16},{-84,16}})));
      Modelica.Mechanics.MultiBody.Interfaces.Frame_b frame_b
        "Coordinate system b" annotation (Placement(
            transformation(extent={{84,-16},{116,16}})));
      Modelica.Mechanics.MultiBody.Interfaces.Frame_resolve frame_resolve if
             resolveInFrame==Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_resolve
        "Output vectors are optionally resolved in this frame (cut-force/-torque are set to zero)"
        annotation (Placement(transformation(
            origin={80,-100},
            extent={{-16,-16},{16,16}},
            rotation=270)));

      parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameA resolveInFrame=
        Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a
        "Frame in which output vector(s) is/are resolved (world, frame_a, or frame_resolve)";

    protected
      outer Modelica.Mechanics.MultiBody.World world;
    equation
      assert(cardinality(frame_a) > 0,
        "Connector frame_a of cut-force/-torque sensor object is not connected");
      assert(cardinality(frame_b) > 0,
        "Connector frame_b of cut-force/-torque sensor object is not connected");

      annotation (
        Documentation(info="<html>
<p>
This is a base class for 3-dim. mechanical components with two frames
and one output port in order to measure the cut-force and/or
cut-torque acting between the two frames and
to provide the measured signals as output for further processing
with the blocks of package Modelica.Blocks.
</p>
</html>"), Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}}), graphics={
            Line(points={{-70,0},{-101,0}}),
            Line(points={{70,0},{100,0}}),
            Text(
              extent={{-132,76},{129,124}},
              textString="%name",
              lineColor={0,0,255}),
            Text(
              extent={{-118,55},{-82,30}},
              lineColor={128,128,128},
              textString="a"),
            Text(
              extent={{83,55},{119,30}},
              lineColor={128,128,128},
              textString="b"),
            Text(
              extent={{70,-66},{201,-91}},
              lineColor={95,95,95},
              textString="resolve"),
            Line(
              points={{80,0},{80,-100}},
              color={95,95,95},
              pattern=LinePattern.Dot)}));
    end PartialCutForceSensor;

    partial model PartialCutForceBaseSensor
      "Base class to measure cut force and/or torque between two frames, defined by equations (frame_resolve must be connected exactly once)"

      extends Modelica.Icons.RotationalSensor;
      Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a
        "Coordinate system a" annotation (Placement(
            transformation(extent={{-116,-16},{-84,16}})));
      Modelica.Mechanics.MultiBody.Interfaces.Frame_b frame_b
        "Coordinate system b" annotation (Placement(
            transformation(extent={{84,-16},{116,16}})));
      Modelica.Mechanics.MultiBody.Interfaces.Frame_resolve frame_resolve
        "The output vector is optionally resolved in this frame (cut-force/-torque are set to zero)"
        annotation (Placement(transformation(
            origin={80,-100},
            extent={{-16,-16},{16,16}},
            rotation=270)));

      parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameA resolveInFrame=
        Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a
        "Frame in which output vector is resolved (world, frame_a, or frame_resolve)";

    protected
      outer Modelica.Mechanics.MultiBody.World world;
    equation
      Connections.branch(frame_a.R, frame_b.R);
      assert(cardinality(frame_a) > 0,
        "Connector frame_a of cut-force/-torque sensor object is not connected");
      assert(cardinality(frame_b) > 0,
        "Connector frame_b of cut-force/-torque sensor object is not connected");

      // frame_a and frame_b are identical
      frame_a.r_0 = frame_b.r_0;
      frame_a.R = frame_b.R;

      // force and torque balance
      zeros(3) = frame_a.f + frame_b.f;
      zeros(3) = frame_a.t + frame_b.t;
      frame_resolve.f = zeros(3);
      frame_resolve.t = zeros(3);
      annotation (
        Documentation(info="<html>
<p>
This is a base class for 3-dim. mechanical components with two frames
and one output port in order to measure the cut-force and/or
cut-torque acting between the two frames and
to provide the measured signals as output for further processing
with the blocks of package Modelica.Blocks.
</p>
</html>"), Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}}), graphics={
            Line(points={{-70,0},{-101,0}}),
            Line(points={{70,0},{100,0}}),
            Text(
              extent={{-132,76},{129,124}},
              textString="%name",
              lineColor={0,0,255}),
            Text(
              extent={{-118,55},{-82,30}},
              lineColor={128,128,128},
              textString="a"),
            Text(
              extent={{83,55},{119,30}},
              lineColor={128,128,128},
              textString="b"),
            Text(
              extent={{70,-66},{201,-91}},
              lineColor={95,95,95},
              textString="resolve"),
            Line(
              points={{80,0},{80,-100}},
              color={95,95,95},
              pattern=LinePattern.Dot)}));
    end PartialCutForceBaseSensor;

    model BasicCutForce
      "Basic sensor to measure cut force vector (frame_resolve must be connected)"
      import Modelica.Mechanics.MultiBody.Types.ResolveInFrameA;
      import Modelica.Mechanics.MultiBody.Frames;
      extends Modelica.Mechanics.MultiBody.Sensors.Internal.PartialCutForceBaseSensor;

      Modelica.Blocks.Interfaces.RealOutput force[3](each final quantity="Force", each final unit="N")
        "Cut force resolved in frame defined by resolveInFrame"
           annotation (Placement(transformation(
            origin={-80,-110},
            extent={{10,-10},{-10,10}},
            rotation=90)));
      parameter Boolean positiveSign=true
        "= true, if force with positive sign is returned (= frame_a.f), otherwise with negative sign (= frame_b.f)";
    protected
      parameter Integer csign=if positiveSign then +1 else -1;
    equation
      if resolveInFrame == ResolveInFrameA.world then
        force = Frames.resolve1(frame_a.R, frame_a.f)*csign;
      elseif resolveInFrame == ResolveInFrameA.frame_a then
        force = frame_a.f*csign;
      elseif resolveInFrame == ResolveInFrameA.frame_resolve then
        force = Frames.resolveRelative(frame_a.f, frame_a.R, frame_resolve.R)*csign;
      else
        assert(false,"Wrong value for parameter resolveInFrame");
        force = zeros(3);
      end if;
      annotation (
         Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={Text(
              extent={{-190,-70},{-74,-96}},
              textString="force"), Line(points={{-80,-100},{-80,0}}, color={0,0,
                  127})}),
        Documentation(info="<html>
<p>
This basic sensor is aimed to be used within advanced sensors where
the cut-force acting between the two frames is determined to which this
model is connected.
This cut-force is provided at the output signal connector
<strong>force</strong> (= frame_a.f). If parameter <strong>positiveSign</strong> =
<strong>false</strong>, the negative cut-force is provided (= frame_b.f).
</p>
<p>
Via parameter <strong>resolveInFrame</strong> it is defined in which frame
the force vector is resolved:
</p>

<table border=1 cellspacing=0 cellpadding=2>
<tr><th><strong>resolveInFrame =<br>Types.ResolveInFrameA.</strong></th><th><strong>Meaning</strong></th></tr>
<tr><td>world</td>
    <td>Resolve vector in world frame</td></tr>

<tr><td>frame_a</td>
    <td>Resolve vector in frame_a</td></tr>

<tr><td>frame_resolve</td>
    <td>Resolve vector in frame_resolve</td></tr>
</table>

<p>
In this basic sensor model, <strong>the connector frame_resolve
is always enabled and must be connected</strong>.
If resolveInFrame = Types.ResolveInFrameA.frame_resolve, the vector force is
resolved in the frame to which frame_resolve is connected.
</p>

<p>
In the following figure the animation of a CutForce
sensor is shown. The dark blue coordinate system is frame_b,
and the green arrow is the cut force acting at frame_b and
with negative sign at frame_a.
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Sensors/CutForce.png\">
</p>
</html>"));
    end BasicCutForce;

    model BasicCutTorque
      "Basic sensor to measure cut torque vector (frame_resolve must be connected)"

      import Modelica.Mechanics.MultiBody.Types.ResolveInFrameA;
      import Modelica.Mechanics.MultiBody.Frames;

      extends
        Modelica.Mechanics.MultiBody.Sensors.Internal.PartialCutForceBaseSensor;
      Modelica.Blocks.Interfaces.RealOutput torque[3](each final quantity="Torque", each final unit=
            "N.m") "Cut torque resolved in frame defined by resolveInFrame"
           annotation (Placement(transformation(
            origin={-80,-110},
            extent={{10,-10},{-10,10}},
            rotation=90)));

      parameter Boolean positiveSign=true
        "= true, if torque with positive sign is returned (= frame_a.t), otherwise with negative sign (= frame_b.t)";

    protected
      parameter Integer csign=if positiveSign then +1 else -1;
    equation
       if resolveInFrame == ResolveInFrameA.world then
          torque = Frames.resolve1(frame_a.R, frame_a.t)*csign;
       elseif resolveInFrame == ResolveInFrameA.frame_a then
          torque = frame_a.t*csign;
       elseif resolveInFrame == ResolveInFrameA.frame_resolve then
          torque = Frames.resolveRelative(frame_a.t, frame_a.R, frame_resolve.R)*csign;
       else
          assert(false,"Wrong value for parameter resolveInFrame");
          torque = zeros(3);
       end if;
      annotation (
         Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={Text(
              extent={{-190,-70},{-74,-96}},
              textString="torque"), Line(points={{-80,-100},{-80,0}}, color={0,
                  0,127})}), Documentation(info="<html>
<p>
This basic sensor is aimed to be used within advanced sensors where
the cut-torque acting between the two frames is determined to which this
model is connected.
This cut-torque is provided at the output signal connector
<strong>torque</strong> (= frame_a.f). If parameter <strong>positiveSign</strong> =
<strong>false</strong>, the negative cut-torque is provided (= frame_b.f).
</p>
<p>
Via parameter <strong>resolveInFrame</strong> it is defined in which frame
the torque vector is resolved:
</p>

<table border=1 cellspacing=0 cellpadding=2>
<tr><th><strong>resolveInFrame =<br>Types.ResolveInFrameA.</strong></th><th><strong>Meaning</strong></th></tr>
<tr><td>world</td>
    <td>Resolve vector in world frame</td></tr>

<tr><td>frame_a</td>
    <td>Resolve vector in frame_a</td></tr>

<tr><td>frame_resolve</td>
    <td>Resolve vector in frame_resolve</td></tr>
</table>

<p>
In this basic sensor model, <strong>the connector frame_resolve
is always enabled and must be connected</strong>.
If resolveInFrame = Types.ResolveInFrameA.frame_resolve, the vector torque is
resolved in the frame to which frame_resolve is connected.
</p>

<p>
In the following figure the animation of a CutTorque
sensor is shown. The dark blue coordinate system is frame_b,
and the green arrow is the cut torque acting at frame_b and
with negative sign at frame_a.
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Sensors/CutTorque.png\">
</p>
</html>"));
    end BasicCutTorque;
    annotation (Documentation(info="<html>
<p>
Package with classes that are used within package Sensors.
The classes in this package should not be directly used by a user.
</p>
</html>"));
  end Internal;

  model TansformAbsoluteVector
    "Obsolete model will be removed in future versions, use TransformAbsoluteVector instead!"
    extends Modelica.Icons.ObsoleteModel;
    extends TransformAbsoluteVector;
    annotation(obsolete = "Obsolete model due to misspelled class name - use Modelica.Mechanics.MultiBody.Sensors.TransformAbsoluteVector instead", Documentation(info="<html>
<!--a placeholder to fulfill minimum documentation length-->
</html>"));
  end TansformAbsoluteVector;

  model TansformRelativeVector
    "Obsolete model will be removed in future versions, use TransformRelativeVector instead!"
    extends Modelica.Icons.ObsoleteModel;
    extends TransformRelativeVector;
    annotation(obsolete = "Obsolete model due to misspelled class name - use Modelica.Mechanics.MultiBody.Sensors.TransformRelativeVector instead", Documentation(info="<html>
<!--a placeholder to fulfill minimum documentation length-->
</html>"));
  end TansformRelativeVector;

  annotation (Documentation(info="<html>
<p>
Package <strong>Sensors</strong> contains <strong>ideal measurement</strong>
components to determine absolute and relative kinematic
quantities, as well as cut-forces, cut-torques and power. All
measured quantities can be provided in every desired
coordinate system.
</p>
</html>"));
end Sensors;
