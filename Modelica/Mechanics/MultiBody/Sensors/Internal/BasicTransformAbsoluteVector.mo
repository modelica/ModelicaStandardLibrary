within Modelica.Mechanics.MultiBody.Sensors.Internal;
model BasicTransformAbsoluteVector
  "Transform absolute vector into another frame"
  import Modelica.Mechanics.MultiBody.Frames;
  import Modelica.Mechanics.MultiBody.Types.ResolveInFrameA;

  extends Modelica.Icons.RoundSensor;

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
          textColor={95,95,95},
          textString="resolve"),
        Text(
          extent={{-116,45},{-80,20}},
          textColor={95,95,95},
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
In this basic sensor model, <strong>the connector frame_resolve
is always enabled and must be connected</strong>.
</p>
</html>"));
end BasicTransformAbsoluteVector;
