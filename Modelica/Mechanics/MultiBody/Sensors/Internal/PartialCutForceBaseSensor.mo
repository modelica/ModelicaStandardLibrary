within Modelica.Mechanics.MultiBody.Sensors.Internal;
partial model PartialCutForceBaseSensor
  "Base class to measure cut force and/or torque between two frames, defined by equations (frame_resolve must be connected exactly once)"
  extends Interfaces.PartialRelativeSensor(
    break y);

  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameA resolveInFrame=
    Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a
    "Frame in which output vector is resolved (world, frame_a, or frame_resolve)";

equation
  Connections.branch(frame_a.R, frame_b.R);
  assert(cardinality(frame_a) > 0,
    "Connector frame_a of cut-force/-torque sensor object is not connected");
  assert(cardinality(frame_b) > 0,
    "Connector frame_b of cut-force/-torque sensor object is not connected");

  // frame_a and frame_b are identical
  frame_a.r_0 = frame_b.r_0;
  frame_a.R = frame_b.R;

  // force and torque balance
  zeros(3) = frame_a.f + frame_b.f;
  zeros(3) = frame_a.t + frame_b.t;
  frame_resolve.f = zeros(3);
  frame_resolve.t = zeros(3);
  annotation (
    Documentation(info="<html>
<p>
This is a base class for 3-dim. mechanical components with two frames
and one output port in order to measure the cut-force and/or
cut-torque acting between the two frames and
to provide the measured signals as output for further processing
with the blocks of package Modelica.Blocks.
</p>
</html>"),
       Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-70,0},{-101,0}}),
        Line(points={{70,0},{100,0}}),
        Text(
          extent={{-70,-69},{70,-94}},
          textColor={95,95,95},
          textString="resolve")}));
end PartialCutForceBaseSensor;
