within Modelica.Mechanics.MultiBody.Sensors.Internal;
model BasicRelativePosition
  "Basic sensor to measure relative position vector"
  import Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB;
  extends Modelica.Mechanics.MultiBody.Sensors.Internal.PartialRelativeBaseSensor;
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
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
      graphics={
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
This basic sensor is aimed to be used within advanced sensors where
the relative position vector between the origins of frame_a and frame_b should be determined.
This vector is provided at the output signal connector&nbsp;<strong>r_rel</strong>.
</p>

<p>
Via parameter <strong>resolveInFrame</strong> it is defined in which frame
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
