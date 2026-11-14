within Modelica.Mechanics.MultiBody.Forces.Internal;
model BasicForce
  "Force acting between two frames, defined by 3 input signals"
  extends Interfaces.PartialForce(
    break world);
  import Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB;

  Modelica.Blocks.Interfaces.RealInput force[3](each final quantity="Force", each final unit="N")
    "x-, y-, z-coordinates of force resolved in frame defined by resolveInFrame"
    annotation (Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=270,
        origin={-60,-120})));
  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB
    resolveInFrame=
    Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_b
    "Frame in which force is resolved (1: world, 2: frame_a, 3: frame_b, 4: frame_resolve)";

  SI.Position r_0[3]
    "Position vector from origin of frame_a to origin of frame_b resolved in world frame";
  SI.Force f_b_0[3] "Force frame_b.f resolved in world frame";

equation
  assert(cardinality(frame_resolve) > 0, "Connector frame_resolve must be connected at least once and frame_resolve.r_0/.R must be set");
  frame_resolve.f = zeros(3);
  frame_resolve.t = zeros(3);

  r_0 = frame_b.r_0 - frame_a.r_0;
  frame_b.t = zeros(3);

  if resolveInFrame == ResolveInFrameAB.frame_a then
    f_b_0     = -Frames.resolve1(frame_a.R, force);
    frame_b.f =  Frames.resolve2(frame_b.R, f_b_0);
  elseif resolveInFrame == ResolveInFrameAB.frame_b then
    f_b_0     = -Frames.resolve1(frame_b.R, force);
    frame_b.f = -force;
  elseif resolveInFrame == ResolveInFrameAB.world then
    f_b_0     = -force;
    frame_b.f =  Frames.resolve2(frame_b.R, f_b_0);
  elseif resolveInFrame == ResolveInFrameAB.frame_resolve then
    f_b_0     = -Frames.resolve1(frame_resolve.R, force);
    frame_b.f =  Frames.resolve2(frame_b.R, f_b_0);
  else
    assert(false, "Wrong value for parameter resolveInFrame");
    f_b_0     = zeros(3);
    frame_b.f = zeros(3);
  end if;

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{
            100,100}}), graphics={
        Line(
          points={{40,0},{40,-100},{-60,-100}},
          color={95,95,95},
          pattern=LinePattern.Dot),
        Line(points={{-80,0},{-20,0}}),
        Line(points={{20,0},{80,0}}),
        Polygon(
          points={{-94,0},{-64,11},{-64,-10},{-94,0}},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{94,0},{65,12},{65,-11},{94,0}},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-100,-40},{80,-70}},
          textColor={192,192,192},
          textString="resolve"),
        Text(
          extent={{-150,80},{150,40}},
          textString="%name",
          textColor={0,0,255})}),
    Documentation(info="<html>
<p>
The <strong>3</strong> signals of the <strong>force</strong> connector are interpreted
as the x-, y- and z-coordinates of a <strong>force</strong> acting at the frame
connector to which frame_b of this component is attached.
Via parameter <strong>resolveInFrame</strong> it is defined, in which frame these
coordinates shall be resolved:
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th><strong>Types.ResolveInFrameAB.</strong></th><th><strong>Meaning</strong></th></tr>
<tr><td>world</td>
    <td>Resolve input force in world frame</td></tr>

<tr><td>frame_a</td>
    <td>Resolve input force in frame_a</td></tr>

<tr><td>frame_b</td>
    <td>Resolve input force in frame_b (= default)</td></tr>

<tr><td>frame_resolve</td>
    <td>Resolve input force in frame_resolve (frame_resolve must be connected)</td></tr>
</table>

<p>
If resolveInFrame = ResolveInFrameAB.frame_resolve, the force coordinates
are with respect to the frame, that is connected to <strong>frame_resolve</strong>.
</p>

<p>
If resolveInFrame is not ResolveInFrameAB.frame_resolve, then the position
vector and the orientation object of frame_resolve must be set to constant
values from the outside in order that the model remains balanced
(these constant values are ignored).
</p>

</html>"));
end BasicForce;
