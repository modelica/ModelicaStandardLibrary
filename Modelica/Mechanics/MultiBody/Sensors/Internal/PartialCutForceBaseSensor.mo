within Modelica.Mechanics.MultiBody.Sensors.Internal;
partial model PartialCutForceBaseSensor
  "Base class to measure cut force and/or torque between two frames, defined by equations (frame_resolve must be connected exactly once)"

  extends Modelica.Icons.RoundSensor;
  Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a
    "Coordinate system a" annotation (Placement(
        transformation(extent={{-116,-16},{-84,16}})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b frame_b
    "Coordinate system b" annotation (Placement(
        transformation(extent={{84,-16},{116,16}})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_resolve frame_resolve
    "The output vector is optionally resolved in this frame (cut-force/-torque are set to zero)"
    annotation (Placement(transformation(
        origin={80,-100},
        extent={{-16,-16},{16,16}},
        rotation=270)));

  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameA resolveInFrame=
    Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a
    "Frame in which output vector is resolved (world, frame_a, or frame_resolve)";

protected
  outer Modelica.Mechanics.MultiBody.World world;
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
          extent={{-132,76},{129,124}},
          textString="%name",
          textColor={0,0,255}),
        Text(
          extent={{-118,55},{-82,30}},
          textColor={128,128,128},
          textString="a"),
        Text(
          extent={{83,55},{119,30}},
          textColor={128,128,128},
          textString="b"),
        Text(
          extent={{70,-66},{201,-91}},
          textColor={95,95,95},
          textString="resolve"),
        Line(
          points={{80,0},{80,-100}},
          color={95,95,95},
          pattern=LinePattern.Dot)}));
end PartialCutForceBaseSensor;
