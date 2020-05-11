within Modelica.Mechanics.MultiBody.Forces;
model ForceAndTorque
  "Force and torque acting between two frames, defined by 3+3 input signals and resolved in frame world, frame_a, frame_b or frame_resolve"

  import Modelica.Mechanics.MultiBody.Types;
  import Modelica.Units.Conversions.to_unit1;

  extends Modelica.Mechanics.MultiBody.Interfaces.PartialTwoFrames;

  Blocks.Interfaces.RealInput force[3](each final quantity="Force", each final unit="N")
    "x-, y-, z-coordinates of force resolved in frame defined by resolveInFrame"
    annotation (Placement(transformation(
        origin={-80,120},
        extent={{-20,-20},{20,20}},
        rotation=270)));
  Blocks.Interfaces.RealInput torque[3](each final quantity="Torque", each final unit="N.m")
    "x-, y-, z-coordinates of torque resolved in frame defined by resolveInFrame"
    annotation (Placement(transformation(
        origin={0,120},
        extent={{-20,-20},{20,20}},
        rotation=270)));
  Interfaces.Frame_resolve frame_resolve if
       resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve
    "The input signals are optionally resolved in this frame"
    annotation (Placement(transformation(
        origin={80,100},
        extent={{-16,-16},{16,16}},
        rotation=90)));

  parameter Boolean animation=true "= true, if animation shall be enabled";
  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB
    resolveInFrame=
    Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_b
    "Frame in which input force and torque are resolved (1: world, 2: frame_a, 3: frame_b, 4: frame_resolve)";
  input SI.Diameter connectionLineDiameter=world.defaultArrowDiameter
    "Diameter of line connecting frame_a and frame_b"
    annotation (Dialog(group="if animation = true", enable=animation));
  input Types.Color forceColor=Modelica.Mechanics.MultiBody.Types.Defaults.ForceColor
    "Color of force arrow" annotation (Dialog(colorSelector=true, group="if animation = true", enable=animation));
  input Types.Color torqueColor=Modelica.Mechanics.MultiBody.Types.Defaults.TorqueColor
    "Color of torque arrow" annotation (Dialog(colorSelector=true, group="if animation = true", enable=animation));
  input Types.Color connectionLineColor=Modelica.Mechanics.MultiBody.Types.Defaults.SensorColor
    "Color of line connecting frame_a and frame_b"
    annotation (Dialog(colorSelector=true, group="if animation = true", enable=animation));
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (Dialog(group="if animation = true", enable=animation));

protected
  Visualizers.Advanced.Arrow forceArrow(
    specularCoefficient=specularCoefficient,
    quantity=Modelica.Mechanics.MultiBody.Types.VectorQuantity.Force,
    R=frame_b.R,
    r=frame_b.r_0,
    headAtOrigin=true,
    r_head=-frame_b.f) if world.enableAnimation and animation;
  Visualizers.Advanced.DoubleArrow torqueArrow(
    color=torqueColor,
    specularCoefficient=specularCoefficient,
    quantity=Modelica.Mechanics.MultiBody.Types.VectorQuantity.Torque,
    R=frame_b.R,
    r=frame_b.r_0,
    headAtOrigin=true,
    r_head=-frame_b.t) if world.enableAnimation and animation;
  Visualizers.Advanced.Shape connectionLine(
    shapeType="cylinder",
    lengthDirection = to_unit1(basicForce.r_0),
    widthDirection={0,1,0},
    length=Modelica.Math.Vectors.length(basicForce.r_0),
    width=connectionLineDiameter,
    height=connectionLineDiameter,
    color=connectionLineColor,
    specularCoefficient=specularCoefficient,
    r=frame_a.r_0) if world.enableAnimation and animation;

public
  Internal.BasicForce basicForce(resolveInFrame=resolveInFrame)
    annotation (Placement(transformation(extent={{-84,-10},{-64,10}})));
  Internal.BasicTorque basicTorque(resolveInFrame=resolveInFrame)
    annotation (Placement(transformation(extent={{-4,10},{16,30}})));
protected
  Interfaces.ZeroPosition zeroPosition if
       not (resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve)
    annotation (Placement(transformation(extent={{20,30},{40,50}})));
equation
  connect(basicForce.frame_a, frame_a) annotation (Line(
      points={{-84,0},{-100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(basicForce.frame_b, frame_b) annotation (Line(
      points={{-64,0},{100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(basicTorque.frame_b, frame_b) annotation (Line(
      points={{16,20},{68,20},{68,0},{100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(basicTorque.frame_a, frame_a) annotation (Line(
      points={{-4,20},{-90,20},{-90,0},{-100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(basicForce.force, force) annotation (Line(
      points={{-80,12},{-80,120}}, color={0,0,127}));
  connect(basicTorque.torque, torque) annotation (Line(
      points={{0,32},{0,120}}, color={0,0,127}));
  connect(basicTorque.frame_resolve, frame_resolve) annotation (Line(
      points={{10,30},{10,80},{80,80},{80,100}},
      color={95,95,95},
      pattern=LinePattern.Dot));
  connect(basicForce.frame_resolve, frame_resolve) annotation (Line(
      points={{-70,10},{-70,80},{80,80},{80,100}},
      color={95,95,95},
      pattern=LinePattern.Dot));
  connect(zeroPosition.frame_resolve, basicTorque.frame_resolve) annotation (
      Line(
      points={{20,40},{10,40},{10,30}},
      color={95,95,95},
      pattern=LinePattern.Dot));
  connect(zeroPosition.frame_resolve, basicForce.frame_resolve) annotation (
      Line(
      points={{20,40},{-70,40},{-70,10}},
      color={95,95,95},
      pattern=LinePattern.Dot));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
        Rectangle(
          extent={{-98,99},{99,-98}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-59,55},{72,30}},
          textColor={192,192,192},
          textString="resolve"),
        Text(
          extent={{-150,-55},{150,-95}},
          textString="%name",
          textColor={0,0,255}),
        Polygon(
          points={{100,21},{84,55},{69,39},{100,21}},
          fillPattern=FillPattern.Solid),
        Line(
          points={{80,100},{80,0}},
          color={95,95,95},
          pattern=LinePattern.Dot),
        Polygon(
          points={{-95,1},{-64,11},{-64,-10},{-95,1}},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-100,20},{-86,53},{-70,42},{-100,20}},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-80,100},{80,100}},
          color={95,95,95},
          pattern=LinePattern.Dot),
        Polygon(
          points={{94,0},{65,12},{65,-11},{94,0}},
          fillPattern=FillPattern.Solid),
        Line(points={{-64,0},{-20,0}}),
        Line(points={{20,0},{65,0}}),
        Line(points={{-79,47},{-70,61},{-59,72},{-45,81},{-32,84},{-20,85}}),
        Line(points={{76,47},{66,60},{55,69},{49,74},{41,80},{31,84},{20,85}}),
        Text(
          extent={{-144,124},{-106,102}},
          textString="f"),
        Text(
          extent={{20,124},{58,102}},
          textString="t")}),
    Documentation(info="<html>
<p>
The <strong>3</strong> signals of the <strong>force</strong> connector and the
<strong>3</strong> signals of the <strong>torque</strong> connector
are interpreted
as the x-, y- and z-coordinates of a <strong>force</strong> and of a
<strong>torque</strong> acting at the frame
connector to which frame_b of this component is attached.
Via parameter <strong>resolveInFrame</strong> it is defined, in which frame these
coordinates shall be resolved:
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th><strong>Types.ResolveInFrameAB.</strong></th><th><strong>Meaning</strong></th></tr>
<tr><td>world</td>
    <td>Resolve input force/torque in world frame</td></tr>

<tr><td>frame_a</td>
    <td>Resolve input force/torque in frame_a</td></tr>

<tr><td>frame_b</td>
    <td>Resolve input force/torque in frame_b (= default)</td></tr>

<tr><td>frame_resolve</td>
    <td>Resolve input force/torque in frame_resolve (frame_resolve must be connected)</td></tr>
</table>

<p>
If resolveInFrame = ResolveInFrameAB.frame_resolve, the force and torque coordinates
are with respect to the frame, that is connected to <strong>frame_resolve</strong>.
</p>

<p>
If force={100,0,0}, and for all parameters the default setting is used,
then the interpretation is that a force of 100 N is acting along the positive
x-axis of frame_b.
</p>

<p>
Note, a force and torque acts on frame_a in such a way that
the force and torque balance between frame_a and frame_b is fulfilled.
</p>

<p>
An example how to use this model is given in the
following figure:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Forces/ForceAndTorque1.png\">
</div>

<p>
This leads to the following animation (the yellow cylinder
characterizes the line between frame_a and frame_b of the
ForceAndTorque component, i.e., the force and torque acts with
negative sign
also on the opposite side of this cylinder, but for
clarity this is not shown in the animation):
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Forces/ForceAndTorque2.png\">
</div>

</html>"));
end ForceAndTorque;
