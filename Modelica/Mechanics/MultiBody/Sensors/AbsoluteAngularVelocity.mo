within Modelica.Mechanics.MultiBody.Sensors;
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
        Line(
          points={{0,-70},{0,-96}},
          color={95,95,95},
          pattern=LinePattern.Dot),
        Text(
          extent={{-127,77},{134,125}},
          textString="%name",
          textColor={0,0,255}),
        Text(
          extent={{-50,-14},{50,-54}},
          textColor={64,64,64},
          textString="rad/s"),
        Text(
          extent={{0,-67},{130,-92}},
          textColor={95,95,95},
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

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
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
