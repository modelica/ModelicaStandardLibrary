within Modelica.Mechanics.MultiBody.Sensors.Internal;
model BasicCutForce
  "Basic sensor to measure cut force vector (frame_resolve must be connected)"
  import Modelica.Mechanics.MultiBody.Types.ResolveInFrameA;
  import Modelica.Mechanics.MultiBody.Frames;
  extends Modelica.Mechanics.MultiBody.Sensors.Internal.PartialCutForceBaseSensor;

  Modelica.Blocks.Interfaces.RealOutput force[3](each final quantity="Force", each final unit="N")
    "Cut force resolved in frame defined by resolveInFrame"
       annotation (Placement(transformation(
        origin={-80,-110},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  parameter Boolean positiveSign=true
    "= true, if force with positive sign is returned (= frame_a.f), otherwise with negative sign (= frame_b.f)";
protected
  parameter Integer csign=if positiveSign then +1 else -1;
equation
  if resolveInFrame == ResolveInFrameA.world then
    force = Frames.resolve1(frame_a.R, frame_a.f)*csign;
  elseif resolveInFrame == ResolveInFrameA.frame_a then
    force = frame_a.f*csign;
  elseif resolveInFrame == ResolveInFrameA.frame_resolve then
    force = Frames.resolveRelative(frame_a.f, frame_a.R, frame_resolve.R)*csign;
  else
    assert(false,"Wrong value for parameter resolveInFrame");
    force = zeros(3);
  end if;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
      graphics={
        Line(points={{-80,-100},{-80,0}}, color={0,0,127}),
        Text(
          extent={{-50,-14},{50,-54}},
          textColor={64,64,64},
          textString="N")}),
    Documentation(info="<html>
<p>
This basic sensor is aimed to be used within advanced sensors where
the cut-force acting between the two frames is determined to which this
model is connected.
This cut-force is provided at the output signal connector
<strong>force</strong> (= frame_a.f). If parameter <strong>positiveSign</strong> =
<strong>false</strong>, the negative cut-force is provided (= frame_b.f).
</p>
<p>
Via parameter <strong>resolveInFrame</strong> it is defined in which frame
the force vector is resolved:
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
If resolveInFrame = Types.ResolveInFrameA.frame_resolve, the vector force is
resolved in the frame to which frame_resolve is connected.
</p>

<p>
In the following figure the animation of a CutForce
sensor is shown. The dark blue coordinate system is frame_b,
and the green arrow is the cut force acting at frame_b and
with negative sign at frame_a.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Sensors/CutForce.png\">
</div>
</html>"));
end BasicCutForce;
