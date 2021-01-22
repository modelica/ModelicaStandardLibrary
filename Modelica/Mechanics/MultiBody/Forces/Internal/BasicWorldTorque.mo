within Modelica.Mechanics.MultiBody.Forces.Internal;
model BasicWorldTorque
  "External torque acting at frame_b, defined by 3 input signals"
  import Modelica.Mechanics.MultiBody.Types.ResolveInFrameB;
  extends Interfaces.PartialOneFrame_b;
  Interfaces.Frame_resolve frame_resolve
    "The input signals are optionally resolved in this frame"
    annotation (Placement(transformation(
        origin={0,100},
        extent={{16,-16},{-16,16}},
        rotation=270)));

  Modelica.Blocks.Interfaces.RealInput torque[3](each final quantity="Torque", each final unit="N.m")
    "x-, y-, z-coordinates of torque resolved in frame defined by resolveInFrame"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameB
    resolveInFrame=
    Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.world
    "Frame in which torque is resolved (1: world, 2: frame_b, 3: frame_resolve)";

equation
   assert(cardinality(frame_resolve) > 0, "Connector frame_resolve must be connected at least once and frame_resolve.r_0/.R must be set");
   frame_resolve.f = zeros(3);
   frame_resolve.t = zeros(3);

   if resolveInFrame == ResolveInFrameB.world then
      frame_b.t = -Frames.resolve2(frame_b.R, torque);
   elseif resolveInFrame == ResolveInFrameB.frame_b then
      frame_b.t = -torque;
   elseif resolveInFrame == ResolveInFrameB.frame_resolve then
      frame_b.t = -Frames.resolveRelative(torque, frame_resolve.R, frame_b.R);
   else
      assert(false, "Wrong value for parameter resolveInFrame");
      frame_b.t = zeros(3);
   end if;
   frame_b.f = zeros(3);
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Ellipse(
          extent={{-100,-110},{100,50}},
          lineColor={0,0,0},
          startAngle=40,
          endAngle=160,
          closure=EllipseClosure.None),
        Text(
          extent={{-100,90},{100,60}},
          textColor={192,192,192},
          textString="resolve"),
        Text(
          extent={{-150,-40},{150,-80}},
          textString="%name",
          textColor={0,0,255}),
        Line(
          points={{0,95},{0,50}},
          color={95,95,95},
          pattern=LinePattern.Dot),
        Polygon(
          points={{91,1},{64,56},{36,28},{91,1}},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p>
The 3 signals of the <strong>torque</strong> connector are interpreted
as the x-, y- and z-coordinates of a <strong>torque</strong> acting at the frame
connector to which this component is attached.
Via parameter <strong>resolveInFrame</strong> it is defined, in which frame these
coordinates shall be resolved:
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th><strong>Types.ResolveInFrameB.</strong></th><th><strong>Meaning</strong></th></tr>
<tr><td>world</td>
    <td>Resolve input torque in world frame (= default)</td></tr>

<tr><td>frame_b</td>
    <td>Resolve input torque in frame_b</td></tr>

<tr><td>frame_resolve</td>
    <td>Resolve input torque in frame_resolve (frame_resolve must be connected)</td></tr>
</table>

<p>
If resolveInFrame = Types.ResolveInFrameB.frame_resolve, the torque coordinates
are with respect to the frame, that is connected to <strong>frame_resolve</strong>.
</p>

<p>
If resolveInFrame is not Types.ResolveInFrameB.frame_resolve, then the position
vector and the orientation object of frame_resolve must be set to constant
values from the outside in order that the model remains balanced
(these constant values are ignored).
</p>

</html>"));
end BasicWorldTorque;
