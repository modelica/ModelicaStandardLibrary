within Modelica.Mechanics.MultiBody.Sensors;
model CutTorque "Measure cut torque vector"

  Modelica.Blocks.Interfaces.RealOutput torque[3]
    "Cut torque resolved in frame defined by resolveInFrame"
       annotation (Placement(transformation(
        origin={-80,-110},
        extent={{10,-10},{-10,10}},
        rotation=90)));

  parameter Boolean animation=true
    "= true, if animation shall be enabled (show arrow)";
  parameter Boolean positiveSign=true
    "= true, if torque with positive sign is returned (= frame_a.t), otherwise with negative sign (= frame_b.t)";
  input Types.Color torqueColor=Modelica.Mechanics.MultiBody.Types.Defaults.TorqueColor
    "Color of torque arrow"
    annotation (Dialog(colorSelector=true, group="if animation = true", enable=animation));
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (Dialog(group="if animation = true", enable=animation));

  extends Modelica.Mechanics.MultiBody.Sensors.Internal.PartialCutForceSensor;

protected
  Visualizers.Advanced.DoubleArrow torqueArrow(
    color=torqueColor,
    specularCoefficient=specularCoefficient,
    quantity=Modelica.Mechanics.MultiBody.Types.VectorQuantity.Torque,
    R=frame_b.R,
    r=frame_b.r_0,
    headAtOrigin=true,
    r_head=-frame_a.t*(if positiveSign then +1 else -1)) if world.enableAnimation and animation;
  Internal.BasicCutTorque cutTorque(resolveInFrame=resolveInFrame, positiveSign=
       positiveSign)
    annotation (Placement(transformation(extent={{-62,-10},{-42,10}})));
  Modelica.Mechanics.MultiBody.Interfaces.ZeroPosition zeroPosition if
    not (resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_resolve)
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
equation
  connect(cutTorque.frame_a, frame_a) annotation (Line(
      points={{-62,0},{-100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(cutTorque.frame_b, frame_b) annotation (Line(
      points={{-42,0},{100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(cutTorque.torque, torque) annotation (Line(
      points={{-60,-11},{-60,-80},{-80,-80},{-80,-110}}, color={0,0,127}));
  connect(cutTorque.frame_resolve, frame_resolve) annotation (Line(
      points={{-44,-10},{-44,-74},{80,-74},{80,-100}},
      color={95,95,95},
      pattern=LinePattern.Dot));
  connect(zeroPosition.frame_resolve, cutTorque.frame_resolve) annotation (Line(
      points={{-20,-30},{-44,-30},{-44,-10}},
      color={95,95,95},
      pattern=LinePattern.Dot));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{100,100}}),
      graphics={
        Line(points={{-80,-100},{-80,0}}, color={0,0,127}),
        Text(
          extent={{-50,-14},{50,-54}},
          textColor={64,64,64},
          textString="N.m")}),
    Documentation(info="<html>
<p>
The cut-torque acting between the two frames to which this
model is connected, is determined and provided at the output signal connector
<strong>torque</strong> (= frame_a.t). If parameter <strong>positiveSign</strong> =
<strong>false</strong>, the negative cut-torque is provided (= frame_b.t).
</p>

<p>
Via parameter <strong>resolveInFrame</strong> it is defined, in which frame
the torque vector is resolved:
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
\"frame_resolve\" is enabled and output torque is resolved in the frame, to
which frame_resolve is connected. Note, if this connector is enabled, it must
be connected.
</p>

<p>
In the following figure the animation of a CutTorque
sensor is shown. The dark blue coordinate system is frame_b,
and the green arrow is the cut torque acting at frame_b and
with negative sign at frame_a.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Sensors/CutTorque.png\">
</div>
</html>"));
end CutTorque;
