within Modelica.Mechanics.MultiBody.Sensors;
model RelativeVelocity
  "Measure relative velocity vector between the origins of two frame connectors"
  extends Internal.PartialRelativeSensor;
  Modelica.Blocks.Interfaces.RealOutput v_rel[3](each final quantity="Velocity", each final
            unit = "m/s")
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
  Modelica.Blocks.Continuous.Der der_r_rel[3] annotation (Placement(transformation(
        extent={{-20,-20},{0,0}},
        rotation=-90,
        origin={10,-40})));
  Modelica.Mechanics.MultiBody.Sensors.TransformRelativeVector transformRelativeVector(frame_r_in=Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_a, frame_r_out=resolveInFrame) annotation (Placement(transformation(extent={{-10,-80},{10,-60}})));
equation
  connect(relativePosition.frame_a, frame_a) annotation (Line(
      points={{-10,0},{-100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(relativePosition.frame_b, frame_b) annotation (Line(
      points={{10,0},{100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(relativePosition.r_rel, der_r_rel.u) annotation (Line(
      points={{0,-11},{0,-18}}, color={0,0,127}));
  connect(der_r_rel.y, transformRelativeVector.r_in) annotation (Line(
      points={{0,-41},{0,-58}}, color={0,0,127}));
  connect(transformRelativeVector.r_out, v_rel) annotation (Line(
      points={{0,-81},{0,-110}}, color={0,0,127}));
  connect(transformRelativeVector.frame_a, frame_a) annotation (Line(
      points={{-10,-70},{-70,-70},{-70,0},{-100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(transformRelativeVector.frame_b, frame_b) annotation (Line(
      points={{10,-70},{80,-70},{80,0},{100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(transformRelativeVector.frame_resolve, frame_resolve) annotation (Line(
      points={{10,-62},{30,-62},{30,80},{100,80}},
      color={95,95,95},
      pattern=LinePattern.Dot));
  connect(zeroPosition.frame_resolve, transformRelativeVector.frame_resolve)
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
          textColor={0,0,255}),
        Text(
          extent={{-50,-14},{50,-54}},
          textColor={64,64,64},
          textString="m/s")}),
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
