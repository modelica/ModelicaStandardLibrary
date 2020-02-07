within Modelica.Mechanics.MultiBody.Sensors.Internal;
model BasicAbsoluteAngularVelocity "Basic sensor to measure absolute angular velocity"
  import Modelica.Mechanics.MultiBody.Frames;
  import Modelica.Mechanics.MultiBody.Types.ResolveInFrameA;

  extends Modelica.Mechanics.MultiBody.Sensors.Internal.PartialAbsoluteBaseSensor;
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
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
      graphics={
        Text(
          extent={{-130,76},{131,124}},
          textString="%name",
          textColor={0,0,255}),
        Text(
          extent={{-50,-14},{50,-54}},
          textColor={64,64,64},
          textString="rad/s")}),
    Documentation(info="<html>
<p>
This basic sensor is aimed to be used within advanced sensors where
the absolute angular velocity of frame_a should be determined.
This vector is provided at the output signal connector&nbsp;<strong>w</strong>.
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
