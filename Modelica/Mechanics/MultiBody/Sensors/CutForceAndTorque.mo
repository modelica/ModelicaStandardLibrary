within Modelica.Mechanics.MultiBody.Sensors;
model CutForceAndTorque "Measure cut force and cut torque vector"

  import Modelica.Mechanics.MultiBody.Types;

  Modelica.Blocks.Interfaces.RealOutput force[3](each final quantity="Force", each final unit="N")
    "Cut force resolved in frame defined by resolveInFrame"
       annotation (Placement(transformation(
        origin={-80,-110},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Modelica.Blocks.Interfaces.RealOutput torque[3]
    "Cut torque resolved in frame defined by resolveInFrame"
       annotation (Placement(transformation(
        origin={0,-110},
        extent={{10,-10},{-10,10}},
        rotation=90)));

  parameter Boolean animation=true
    "= true, if animation shall be enabled (show force and torque arrow)";
  parameter Boolean positiveSign=true
    "= true, if force and torque with positive sign is returned (= frame_a.f/.t), otherwise with negative sign (= frame_b.f/.t)";
  input Types.Color forceColor=Modelica.Mechanics.MultiBody.Types.Defaults.ForceColor
    "Color of force arrow"
    annotation (Dialog(colorSelector=true, group="if animation = true", enable=animation));
  input Types.Color torqueColor=Modelica.Mechanics.MultiBody.Types.Defaults.TorqueColor
    "Color of torque arrow"
    annotation (Dialog(colorSelector=true, group="if animation = true", enable=animation));
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (Dialog(group="if animation = true", enable=animation));

  extends Modelica.Mechanics.MultiBody.Sensors.Internal.PartialCutForceSensor;

protected
  parameter Integer csign=if positiveSign then +1 else -1;
  Visualizers.Advanced.Arrow forceArrow(
    color=forceColor,
    specularCoefficient=specularCoefficient,
    R=frame_b.R,
    r=frame_b.r_0,
    headAtOrigin=true,
    quantity=Modelica.Mechanics.MultiBody.Types.VectorQuantity.Force,
    r_head=-frame_a.f*csign) if world.enableAnimation and animation;
  Visualizers.Advanced.DoubleArrow torqueArrow(
    color=torqueColor,
    specularCoefficient=specularCoefficient,
    quantity=Modelica.Mechanics.MultiBody.Types.VectorQuantity.Torque,
    R=frame_b.R,
    r=frame_b.r_0,
    headAtOrigin=true,
    r_head=-frame_a.t*csign) if world.enableAnimation and animation;
  Internal.BasicCutForce cutForce(resolveInFrame=resolveInFrame, positiveSign=
        positiveSign)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Internal.BasicCutTorque cutTorque(resolveInFrame=resolveInFrame, positiveSign=
       positiveSign)
    annotation (Placement(transformation(extent={{-2,-10},{18,10}})));
  Modelica.Mechanics.MultiBody.Interfaces.ZeroPosition zeroPosition if
    not (resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_resolve)
    annotation (Placement(transformation(extent={{60,30},{80,50}})));
equation
  connect(cutForce.frame_a, frame_a) annotation (Line(
      points={{-60,0},{-100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(cutForce.frame_b, cutTorque.frame_a) annotation (Line(
      points={{-40,0},{-2,0}},
      color={95,95,95},
      thickness=0.5));
  connect(cutTorque.frame_b, frame_b) annotation (Line(
      points={{18,0},{100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(cutForce.force, force) annotation (Line(
      points={{-58,-11},{-58,-20},{-80,-20},{-80,-110}}, color={0,0,127}));
  connect(cutTorque.torque, torque) annotation (Line(
      points={{0,-11},{0,-110}}, color={0,0,127}));
  connect(zeroPosition.frame_resolve, cutTorque.frame_resolve) annotation (Line(
      points={{60,40},{32,40},{32,-20},{16,-20},{16,-10}},
      color={95,95,95},
      pattern=LinePattern.Dot));
  connect(zeroPosition.frame_resolve, cutForce.frame_resolve) annotation (Line(
      points={{60,40},{-26,40},{-26,-20},{-42,-20},{-42,-10}},
      color={95,95,95},
      pattern=LinePattern.Dot));
  connect(cutForce.frame_resolve, frame_resolve) annotation (Line(
      points={{-42,-10},{-42,-70},{80,-70},{80,-100}},
      color={95,95,95},
      pattern=LinePattern.Dot));
  connect(cutTorque.frame_resolve, frame_resolve) annotation (Line(
      points={{16,-10},{16,-70},{80,-70},{80,-100}},
      color={95,95,95},
      pattern=LinePattern.Dot));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{100,
            100}}), graphics={
        Line(points={{-80,-100},{-80,0}}, color={0,0,127}),
        Line(points={{0,-100},{0,-70}}, color={0,0,127}),
        Text(
          extent={{-60,-60},{0,-100}},
          textColor={64,64,64},
          textString="N.m"),
        Text(
          extent={{-120,-60},{-80,-100}},
          textColor={64,64,64},
          textString="N")}),
    Documentation(info="<html>
<p>
The cut-force and cut-torque acting between the two frames to which this
model is connected, are determined and provided at the output signal connectors
<strong>force</strong> (= frame_a.f) and <strong>torque</strong> (= frame_a.t).
If parameter <strong>positiveSign</strong> =
<strong>false</strong>, the negative cut-force and cut-torque is provided
(= frame_b.f, frame_b.t).
</p>
<p>
Via parameter <strong>resolveInFrame</strong> it is defined, in which frame
the two vectors are resolved:
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
\"frame_resolve\" is enabled and the output vectors force and torque are resolved in the frame, to
which frame_resolve is connected. Note, if this connector is enabled, it must
be connected.
</p>

<p>
In the following figure the animation of a CutForceAndTorque
sensor is shown. The dark blue coordinate system is frame_b,
and the green arrows are the cut force and the cut torque,
respectively, acting at frame_b and
with negative sign at frame_a.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Sensors/CutForceAndTorque.png\">
</div>
</html>"));
end CutForceAndTorque;
