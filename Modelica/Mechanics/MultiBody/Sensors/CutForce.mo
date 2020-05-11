within Modelica.Mechanics.MultiBody.Sensors;
model CutForce "Measure cut force vector"

  Modelica.Blocks.Interfaces.RealOutput force[3](each final quantity="Force", each final unit="N")
    "Cut force resolved in frame defined by resolveInFrame"
       annotation (Placement(transformation(
        origin={-80,-110},
        extent={{10,-10},{-10,10}},
        rotation=90)));

  parameter Boolean animation=true
    "= true, if animation shall be enabled (show arrow)";
  parameter Boolean positiveSign=true
    "= true, if force with positive sign is returned (= frame_a.f), otherwise with negative sign (= frame_b.f)";

  input Types.Color forceColor=Modelica.Mechanics.MultiBody.Types.Defaults.
      ForceColor "Color of force arrow"
    annotation (Dialog(colorSelector=true, group="if animation = true", enable=animation));
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (Dialog(group="if animation = true", enable=animation));

  extends Modelica.Mechanics.MultiBody.Sensors.Internal.PartialCutForceSensor;

protected
  Visualizers.Advanced.Arrow forceArrow(
    color=forceColor,
    specularCoefficient=specularCoefficient,
    R=frame_b.R,
    r=frame_b.r_0,
    headAtOrigin=true,
    quantity=Modelica.Mechanics.MultiBody.Types.VectorQuantity.Force,
    r_head=-frame_a.f*(if positiveSign then +1 else -1)) if world.enableAnimation and animation;

  Internal.BasicCutForce cutForce(resolveInFrame=resolveInFrame, positiveSign=
        positiveSign)
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  Modelica.Mechanics.MultiBody.Interfaces.ZeroPosition zeroPosition if
    not (resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_resolve)
    annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
equation
  connect(cutForce.frame_a, frame_a) annotation (Line(
      points={{-50,0},{-100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(cutForce.frame_b, frame_b) annotation (Line(
      points={{-30,0},{100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(cutForce.frame_resolve, frame_resolve) annotation (Line(
      points={{-32,-10},{-32,-60},{80,-60},{80,-100}},
      color={95,95,95},
      pattern=LinePattern.Dot));
  connect(cutForce.force, force) annotation (Line(
      points={{-48,-11},{-48,-60},{-80,-60},{-80,-110}}, color={0,0,127}));
  connect(zeroPosition.frame_resolve, cutForce.frame_resolve) annotation (
      Line(
      points={{0,-30},{-32,-30},{-32,-10}},
      color={95,95,95},
      pattern=LinePattern.Dot));
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
The cut-force acting between the two frames to which this
model is connected, is determined and provided at the output signal connector
<strong>force</strong> (= frame_a.f). If parameter <strong>positiveSign</strong> =
<strong>false</strong>, the negative cut-force is provided (= frame_b.f).
</p>

<p>
Via parameter <strong>resolveInFrame</strong> it is defined, in which frame
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
If resolveInFrame = Types.ResolveInFrameAB.frame_resolve, the conditional connector
\"frame_resolve\" is enabled and output force is resolved in the frame, to
which frame_resolve is connected. Note, if this connector is enabled, it must
be connected.
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
end CutForce;
