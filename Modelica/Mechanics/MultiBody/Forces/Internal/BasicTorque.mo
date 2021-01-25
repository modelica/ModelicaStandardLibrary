within Modelica.Mechanics.MultiBody.Forces.Internal;
model BasicTorque
  "Torque acting between two frames, defined by 3 input signals"
  import Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB;
  extends Modelica.Mechanics.MultiBody.Interfaces.PartialTwoFrames;
  Interfaces.Frame_resolve frame_resolve
    "The input signals are optionally resolved in this frame"
    annotation (Placement(transformation(
        origin={40,100},
        extent={{-16,-16},{16,16}},
        rotation=90)));

  Modelica.Blocks.Interfaces.RealInput torque[3](each final quantity="Torque", each final unit="N.m")
    "x-, y-, z-coordinates of torque resolved in frame defined by resolveInFrame"
    annotation (Placement(transformation(
        origin={-60,120},
        extent={{-20,-20},{20,20}},
        rotation=270)));
  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB
    resolveInFrame=
    Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_b
    "Frame in which torque is resolved (1: world, 2: frame_a, 3: frame_b, 4: frame_resolve)";

  SI.Position r_0[3]
    "Position vector from origin of frame_a to origin of frame_b resolved in world frame";
  SI.Torque t_b_0[3] "frame_b.t resolved in world frame";

equation
  assert(cardinality(frame_resolve) > 0, "Connector frame_resolve must be connected at least once and frame_resolve.r_0/.R must be set");
  frame_resolve.f = zeros(3);
  frame_resolve.t = zeros(3);

  r_0 = frame_b.r_0 - frame_a.r_0;
  frame_a.f = zeros(3);
  frame_b.f = zeros(3);

   if resolveInFrame == ResolveInFrameAB.frame_a then
      t_b_0     = -Frames.resolve1(frame_a.R, torque);
      frame_b.t =  Frames.resolve2(frame_b.R, t_b_0);
   elseif resolveInFrame == ResolveInFrameAB.frame_b then
      t_b_0     = -Frames.resolve1(frame_b.R, torque);
      frame_b.t = -torque;
   elseif resolveInFrame == ResolveInFrameAB.world then
      t_b_0     = -torque;
      frame_b.t =  Frames.resolve2(frame_b.R, t_b_0);
   elseif resolveInFrame == ResolveInFrameAB.frame_resolve then
      t_b_0     = -Frames.resolve1(frame_resolve.R, torque);
      frame_b.t =  Frames.resolve2(frame_b.R, t_b_0);
   else
      assert(false, "Wrong value for parameter resolveInFrame");
      t_b_0     = zeros(3);
      frame_b.t = zeros(3);
   end if;

   // torque balance
   zeros(3) = frame_a.t + Frames.resolve2(frame_a.R, t_b_0);
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Ellipse(
          extent={{-100,-140},{100,60}},
          lineColor={0,0,0},
          startAngle=100,
          endAngle=140,
          closure=EllipseClosure.None),
        Ellipse(
          extent={{-100,-140},{100,60}},
          lineColor={0,0,0},
          startAngle=40,
          endAngle=80,
          closure=EllipseClosure.None),
        Text(
          extent={{-80,90},{100,60}},
          textColor={192,192,192},
          textString="resolve"),
        Text(
          extent={{-150,-30},{150,-70}},
          textString="%name",
          textColor={0,0,255}),
        Polygon(
          points={{92,0},{82,36},{60,22},{92,0}},
          fillPattern=FillPattern.Solid),
        Line(
          points={{40,100},{80,20}},
          color={95,95,95},
          pattern=LinePattern.Dot),
        Polygon(
          points={{-92,0},{-82,36},{-60,22},{-92,0}},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-60,100},{40,100}},
          color={95,95,95},
          pattern=LinePattern.Dot)}),
    Documentation(info="<html>
<p>
The <strong>3</strong> signals of the <strong>torque</strong> connector are interpreted
as the x-, y- and z-coordinates of a <strong>torque</strong> acting at the frame
connector to which frame_b of this component is attached.
Via parameter <strong>resolveInFrame</strong> it is defined, in which frame these
coordinates shall be resolved:
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th><strong>Types.ResolveInFrameAB.</strong></th><th><strong>Meaning</strong></th></tr>
<tr><td>world</td>
    <td>Resolve input torque in world frame</td></tr>

<tr><td>frame_a</td>
    <td>Resolve input torque in frame_a</td></tr>

<tr><td>frame_b</td>
    <td>Resolve input torque in frame_b (= default)</td></tr>

<tr><td>frame_resolve</td>
    <td>Resolve input torque in frame_resolve (frame_resolve must be connected)</td></tr>
</table>

<p>
If resolveInFrame = ResolveInFrameAB.frame_resolve, the torque coordinates
are with respect to the frame, that is connected to <strong>frame_resolve</strong>.
</p>

<p>
If resolveInFrame is not ResolveInFrameAB.frame_resolve, then the position
vector and the orientation object of frame_resolve must be set to constant
values from the outside in order that the model remains balanced
(these constant values are ignored).
</p>
</html>"));
end BasicTorque;
