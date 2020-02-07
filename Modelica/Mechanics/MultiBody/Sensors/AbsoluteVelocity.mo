within Modelica.Mechanics.MultiBody.Sensors;
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
  Modelica.Mechanics.MultiBody.Sensors.TransformAbsoluteVector transformAbsoluteVector(frame_r_in=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.world, frame_r_out=resolveInFrame) annotation (Placement(transformation(
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
  connect(der1.y, transformAbsoluteVector.r_in) annotation (Line(
      points={{11,0},{38,0}}, color={0,0,127}));
  connect(transformAbsoluteVector.r_out, v) annotation (Line(
      points={{61,0},{110,0}}, color={0,0,127}));
  connect(zeroPosition.frame_resolve, position.frame_resolve) annotation (Line(
      points={{-60,-50},{-50,-50},{-50,-10}},
      color={95,95,95},
      pattern=LinePattern.Dot));
  connect(transformAbsoluteVector.frame_a, frame_a) annotation (Line(
      points={{50,10},{50,20},{-70,20},{-70,0},{-100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(transformAbsoluteVector.frame_resolve, zeroPosition1.frame_resolve)
    annotation (Line(
      points={{49.9,-10},{50,-10},{50,-50},{60,-50}},
      color={95,95,95},
      pattern=LinePattern.Dot));
  connect(transformAbsoluteVector.frame_resolve, frame_resolve) annotation (Line(
      points={{49.9,-10},{50,-10},{50,-50},{0,-50},{0,-100}},
      color={95,95,95},
      pattern=LinePattern.Dot));
  annotation (Icon(coordinateSystem(
          preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
        Line(
          points={{70,0},{100,0}},
          color={0,0,127}),
        Line(
          points={{0,-70},{0,-95}},
          color={95,95,95},
          pattern=LinePattern.Dot),
        Text(
          extent={{-130,72},{131,120}},
          textString="%name",
          textColor={0,0,255}),
        Text(
          extent={{-50,-14},{50,-54}},
          textColor={64,64,64},
          textString="m/s"),
        Text(
          extent={{0,-67},{130,-92}},
          textColor={95,95,95},
          textString="resolve")}),
    Documentation(info="<html>
<p>
The absolute velocity vector of the origin of frame_a is
determined and provided at the output signal connector <strong>v</strong>.
</p>

<p>
Via parameter <strong>resolveInFrame</strong> it is defined, in which frame
the velocity vector is resolved:
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
