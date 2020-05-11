within Modelica.Mechanics.MultiBody.Forces;
model WorldForce
  "External force acting at frame_b, defined by 3 input signals and resolved in frame world, frame_b or frame_resolve"

  extends Interfaces.PartialOneFrame_b;
  Interfaces.Frame_resolve frame_resolve if
       resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.frame_resolve
    "The input signals are optionally resolved in this frame"
    annotation (Placement(transformation(
        origin={0,-100},
        extent={{-16,-16},{16,16}},
        rotation=270)));
  Modelica.Blocks.Interfaces.RealInput force[3](each final quantity="Force", each final unit="N")
    "x-, y-, z-coordinates of force resolved in frame defined by resolveInFrame"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  parameter Boolean animation=true "= true, if animation shall be enabled";
  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameB resolveInFrame=
    Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.world
    "Frame in which input force is resolved (1: world, 2: frame_b, 3: frame_resolve)";
  input Types.Color color=Modelica.Mechanics.MultiBody.Types.Defaults.ForceColor
    "Color of arrow"
    annotation (Dialog(colorSelector=true, group="if animation = true", enable=animation));
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (Dialog(group="if animation = true", enable=animation));

protected
  Visualizers.Advanced.Arrow arrow(
    color=color,
    specularCoefficient=specularCoefficient,
    R=frame_b.R,
    r=frame_b.r_0,
    headAtOrigin=true,
    quantity=Modelica.Mechanics.MultiBody.Types.VectorQuantity.Force,
    r_head=-frame_b.f) if world.enableAnimation and animation;

public
  Internal.BasicWorldForce basicWorldForce(resolveInFrame=resolveInFrame)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
protected
  Interfaces.ZeroPosition zeroPosition if
       not (resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.frame_resolve)
    annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
equation
  connect(basicWorldForce.frame_b, frame_b) annotation (Line(
      points={{10,0},{100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(basicWorldForce.force, force) annotation (Line(
      points={{-12,0},{-120,0}}, color={0,0,127}));
  connect(basicWorldForce.frame_resolve, frame_resolve) annotation (Line(
      points={{0,-10},{0,-100}},
      color={95,95,95},
      pattern=LinePattern.Dot));
  connect(zeroPosition.frame_resolve, basicWorldForce.frame_resolve)
    annotation (Line(
      points={{20,-30},{0,-30},{0,-10}},
      color={95,95,95},
      pattern=LinePattern.Dot));
  annotation (defaultComponentName="force",
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
        Text(
          extent={{-100,-40},{100,-70}},
          textColor={192,192,192},
          textString="resolve"),
        Polygon(
          points={{-100,10},{50,10},{50,31},{94,0},{50,-31},{50,-10},{-100,-10},
              {-100,10}},
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
The <strong>3</strong> signals of the <strong>force</strong> connector are interpreted
as the x-, y- and z-coordinates of a <strong>force</strong> acting at the frame
connector to which frame_b of this component is attached.
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
If force={100,0,0}, and for all parameters the default setting is used,
then the interpretation is that a force of 100 N is acting along the positive
x-axis of frame_b.
</p>

<p>
Note, the cut-torque in frame_b (frame_b.t) is always set to zero.
Conceptually, a force and torque acts on the world frame in such a way that
the force and torque balance between world.frame_b and frame_b is fulfilled.
For efficiency reasons, this reaction torque is, however, not computed.
</p>

<p>
This force component is by default visualized as an arrow
acting at the connector to which it is connected.
The color of the arrow can be defined via
variable <strong>color</strong>. The arrow
points in the direction defined by the
force signal. The length of the arrow is proportional
to the length of the force vector using a&nbsp;global tool-dependent scaling factor.
</p>
<p>
An example how to use this model is given in the
following figure:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Forces/WorldForce1.png\">
</div>

<p>
This leads to the following animation
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Forces/WorldForce2.png\">
</div>
</html>"));
end WorldForce;
