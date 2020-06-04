within Modelica.Mechanics.MultiBody.Forces;
model Force
  "Force acting between two frames, defined by 3 input signals and resolved in frame world, frame_a, frame_b or frame_resolve"
  import Modelica.Units.Conversions.to_unit1;
  extends Modelica.Mechanics.MultiBody.Interfaces.PartialTwoFrames;
  Interfaces.Frame_resolve frame_resolve if
       resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve
    "The input signals are optionally resolved in this frame"
    annotation (Placement(transformation(
        origin={40,100},
        extent={{-16,-16},{16,16}},
        rotation=90)));
  Modelica.Blocks.Interfaces.RealInput force[3](each final quantity="Force", each final unit="N")
    "x-, y-, z-coordinates of force resolved in frame defined by resolveInFrame"
    annotation (Placement(transformation(
        origin={-60,120},
        extent={{-20,-20},{20,20}},
        rotation=270)));
  parameter Boolean animation=true "= true, if animation shall be enabled";
  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB
    resolveInFrame=
    Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_b
    "Frame in which input force is resolved (1: world, 2: frame_a, 3: frame_b, 4: frame_resolve)";
  input SI.Diameter connectionLineDiameter=world.defaultArrowDiameter
    "Diameter of line connecting frame_a and frame_b"
    annotation (Dialog(group="if animation = true", enable=animation));
  input Types.Color forceColor=Modelica.Mechanics.MultiBody.Types.Defaults.ForceColor
    "Color of force arrow" annotation (Dialog(colorSelector=true, group="if animation = true", enable=animation));
  input Types.Color connectionLineColor=Modelica.Mechanics.MultiBody.Types.Defaults.SensorColor
    "Color of line connecting frame_a and frame_b"
    annotation (Dialog(colorSelector=true, group="if animation = true", enable=animation));
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (Dialog(group="if animation = true", enable=animation));

protected
  Visualizers.Advanced.Arrow forceArrow(
    color=forceColor,
    specularCoefficient=specularCoefficient,
    quantity=Modelica.Mechanics.MultiBody.Types.VectorQuantity.Force,
    R=frame_b.R,
    r=frame_b.r_0,
    r_head=-frame_b.f,
    headAtOrigin=true) if world.enableAnimation and animation;
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
  Internal.BasicForce basicForce(resolveInFrame=resolveInFrame) annotation (Placement(transformation(extent={{0,-10},{20,10}})));
protected
  MultiBody.Interfaces.ZeroPosition zeroPosition if
       not (resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve)
    annotation (Placement(transformation(extent={{40,10},{60,30}})));
equation
  connect(basicForce.frame_a, frame_a) annotation (Line(
      points={{0,0},{-100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(basicForce.frame_b, frame_b) annotation (Line(
      points={{20,0},{100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(force, basicForce.force) annotation (Line(
      points={{-60,120},{-60,40},{4,40},{4,12}}, color={0,0,127}));
  connect(basicForce.frame_resolve, frame_resolve) annotation (Line(
      points={{14,10},{14,40},{40,40},{40,100}},
      color={95,95,95},
      pattern=LinePattern.Dot));
  connect(zeroPosition.frame_resolve, basicForce.frame_resolve) annotation (
      Line(
      points={{40,20},{27,20},{27,10},{14,10}},
      color={95,95,95},
      pattern=LinePattern.Dot));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{100,
            100}}), graphics={
        Rectangle(
          extent={{-98,99},{99,-98}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-92,61},{87,35}},
          textColor={192,192,192},
          textString="resolve"),
        Text(
          extent={{-150,-55},{150,-95}},
          textString="%name",
          textColor={0,0,255}),
        Line(
          points={{40,100},{40,0}},
          color={95,95,95},
          pattern=LinePattern.Dot),
        Polygon(
          points={{-94,0},{-64,11},{-64,-10},{-94,0}},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-60,100},{40,100}},
          color={95,95,95},
          pattern=LinePattern.Dot),
        Polygon(
          points={{94,0},{65,12},{65,-11},{94,0}},
          fillPattern=FillPattern.Solid),
        Line(points={{-64,0},{-20,0}}),
        Line(points={{20,0},{65,0}})}),
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
If force={100,0,0}, and for all parameters the default setting is used,
then the interpretation is that a force of 100 N is acting along the positive
x-axis of frame_b.
</p>

<p>
Note, the cut-torque in frame_b (frame_b.t) is always set to zero.
Additionally, a force and torque acts on frame_a in such a way that
the force and torque balance between frame_a and frame_b is fulfilled.
</p>

<p>
An example how to use this model is given in the
following figure:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Forces/Force1.png\">
</div>

<p>
This leads to the following animation (the yellow cylinder
characterizes the line between frame_a and frame_b of the
Force component, i.e., the force acts with negative sign
also on the opposite side of this cylinder, but for
clarity this is not shown in the animation):
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Forces/Force2.png\">
</div>

</html>"));
end Force;
