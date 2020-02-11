within Modelica.Mechanics.MultiBody.Forces.Internal;
model BasicWorldForce
  "External force acting at frame_b, defined by 3 input signals"
  import Modelica.Mechanics.MultiBody.Types.ResolveInFrameB;
  extends Interfaces.PartialOneFrame_b;
  Interfaces.Frame_resolve frame_resolve
    "The input signals are optionally resolved in this frame"
    annotation (Placement(transformation(
        origin={0,-100},
        extent={{-16,-16},{16,16}},
        rotation=270)));

  Modelica.Blocks.Interfaces.RealInput force[3](each final quantity="Force", each final unit="N")
    "x-, y-, z-coordinates of force resolved in frame defined by resolveInFrame"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameB
    resolveInFrame=
    Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.world
    "Frame in which force is resolved (1: world, 2: frame_b, 3: frame_resolve)";

equation
   assert(cardinality(frame_resolve) > 0, "Connector frame_resolve must be connected at least once and frame_resolve.r_0/.R must be set");
   frame_resolve.f = zeros(3);
   frame_resolve.t = zeros(3);

   if resolveInFrame == ResolveInFrameB.world then
      frame_b.f = -Frames.resolve2(frame_b.R, force);
   elseif resolveInFrame == ResolveInFrameB.frame_b then
      frame_b.f = -force;
   elseif resolveInFrame == ResolveInFrameB.frame_resolve then
      frame_b.f = -Frames.resolveRelative(force, frame_resolve.R, frame_b.R);
   else
      assert(false, "Wrong value for parameter resolveInFrame");
      frame_b.f = zeros(3);
   end if;
   frame_b.t = zeros(3);
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Text(
          extent={{-100,-40},{100,-70}},
          textColor={192,192,192},
          textString="resolve"),
        Polygon(
          points={{-100,10},{50,10},{50,31},{94,0},{50,-31},{50,-10},{-100,
              -10},{-100,10}},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,80},{150,40}},
          textString="%name",
          textColor={0,0,255}),
        Line(
          points={{0,-10},{0,-95}},
          color={95,95,95},
          pattern=LinePattern.Dot)}),
    Documentation(info="<html>
<p>
The 3 signals of the <strong>force</strong> connector are interpreted
as the x-, y- and z-coordinates of a <strong>force</strong> acting at the frame
connector to which this component is attached.
Via parameter <strong>resolveInFrame</strong> it is defined, in which frame these
coordinates shall be resolved:
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th><strong>Types.ResolveInFrameB.</strong></th><th><strong>Meaning</strong></th></tr>
<tr><td>world</td>
    <td>Resolve input force in world frame (= default)</td></tr>

<tr><td>frame_b</td>
    <td>Resolve input force in frame_b</td></tr>

<tr><td>frame_resolve</td>
    <td>Resolve input force in frame_resolve (frame_resolve must be connected)</td></tr>
</table>

<p>
If resolveInFrame = Types.ResolveInFrameB.frame_resolve, the force coordinates
are with respect to the frame, that is connected to <strong>frame_resolve</strong>.
</p>

<p>
If resolveInFrame is not Types.ResolveInFrameB.frame_resolve, then the position
vector and the orientation object of frame_resolve must be set to constant
values from the outside in order that the model remains balanced
(these constant values are ignored).
</p>

</html>"));
end BasicWorldForce;
