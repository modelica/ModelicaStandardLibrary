within Modelica.Mechanics.MultiBody.Sensors;
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
          textColor={0,0,255}),
        Text(
          extent={{-50,-14},{50,-54}},
          textColor={64,64,64},
          textString="m")}),
    Documentation(info="<html>
<p>
The relative position vector between the origins of frame_a and frame_b are
determined and provided at the output signal connector <strong>r_rel</strong>.
</p>

<p>
Via parameter <strong>resolveInFrame</strong> it is defined, in which frame
the position vector is resolved:
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
