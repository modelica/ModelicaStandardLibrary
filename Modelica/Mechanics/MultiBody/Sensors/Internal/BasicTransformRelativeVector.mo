within Modelica.Mechanics.MultiBody.Sensors.Internal;
model BasicTransformRelativeVector
  "Transform relative vector into another frame"
  import Modelica.Mechanics.MultiBody.Frames;
  import Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB;
  extends Modelica.Mechanics.MultiBody.Sensors.Internal.PartialRelativeBaseSensor;
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
is always enabled and must be connected</strong>.
</p>
</html>"));
end BasicTransformRelativeVector;
