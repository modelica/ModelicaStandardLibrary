within Modelica.Mechanics.MultiBody.Sensors;
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
          textColor={0,0,255}),
        Text(
          extent={{-50,-14},{50,-54}},
          textColor={64,64,64},
          textString="rad/s")}),
    Documentation(info="<html>
<p>
The relative angular velocity between frame_a and frame_b is
determined and provided at the output signal connector <strong>w_rel</strong>.
</p>

<p>
Via parameter <strong>resolveInFrame</strong> it is defined, in which frame
the angular velocity is resolved:
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
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
