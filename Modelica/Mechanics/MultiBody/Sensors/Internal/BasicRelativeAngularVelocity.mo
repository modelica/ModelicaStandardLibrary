within Modelica.Mechanics.MultiBody.Sensors.Internal;
model BasicRelativeAngularVelocity "Basic sensor to measure relative angular velocity"
  import Modelica.Mechanics.MultiBody.Frames;
  import Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB;

  extends Modelica.Mechanics.MultiBody.Sensors.Internal.PartialRelativeBaseSensor;
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
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
      graphics={
        Text(
          extent={{-132,90},{129,138}},
          textString="%name",
          textColor={0,0,255}),
        Text(
          extent={{-50,-14},{50,-54}},
          textColor={64,64,64},
          textString="rad/s")}),
    Documentation(info="<html>
<p>
This basic sensor is aimed to be used within advanced sensors where
the relative angular velocity between frame_a and frame_b should be determined.
This vector is provided at the output signal connector&nbsp;<strong>w_rel</strong>.
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
