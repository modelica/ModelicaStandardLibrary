within Modelica.Mechanics.MultiBody.Forces;
model WorldTorque
  "External torque acting at frame_b, defined by 3 input signals and resolved in frame world, frame_b or frame_resolve"

  extends Interfaces.PartialOneFrame_b;

  Interfaces.Frame_resolve frame_resolve if
       resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.frame_resolve
    "The input signals are optionally resolved in this frame"
    annotation (Placement(transformation(
        origin={0,100},
        extent={{16,-16},{-16,16}},
        rotation=270)));
  Modelica.Blocks.Interfaces.RealInput torque[3](each final quantity="Torque", each final unit="N.m")
    "x-, y-, z-coordinates of torque resolved in frame defined by resolveInFrame"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  parameter Boolean animation=true "= true, if animation shall be enabled";
  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameB resolveInFrame=
    Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.world
    "Frame in which input torque is resolved (1: world, 2: frame_b, 3: frame_resolve)";
  input Types.Color color=Modelica.Mechanics.MultiBody.Types.Defaults.TorqueColor
    "Color of arrow"
    annotation (Dialog(colorSelector=true, group="if animation = true", enable=animation));
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (Dialog(group="if animation = true", enable=animation));

protected
  Visualizers.Advanced.DoubleArrow arrow(
    color=color,
    specularCoefficient=specularCoefficient,
    R=frame_b.R,
    r=frame_b.r_0,
    quantity=Modelica.Mechanics.MultiBody.Types.VectorQuantity.Torque,
    headAtOrigin=true,
    r_head=-frame_b.t) if world.enableAnimation and animation;
public
  Internal.BasicWorldTorque basicWorldTorque(resolveInFrame=resolveInFrame)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
protected
  Interfaces.ZeroPosition zeroPosition if
       not (resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.frame_resolve)
    annotation (Placement(transformation(extent={{20,10},{40,30}})));
equation
  connect(basicWorldTorque.frame_b, frame_b) annotation (Line(
      points={{10,0},{100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(basicWorldTorque.torque, torque) annotation (Line(
      points={{-12,0},{-120,0}}, color={0,0,127}));
  connect(frame_resolve, basicWorldTorque.frame_resolve) annotation (Line(
      points={{0,100},{0,10}},
      color={95,95,95},
      pattern=LinePattern.Dot));
  connect(zeroPosition.frame_resolve, basicWorldTorque.frame_resolve)
    annotation (Line(
      points={{20,20},{0,20},{0,10}},
      color={95,95,95},
      pattern=LinePattern.Dot));
  annotation (defaultComponentName="torque",
    Documentation(info="<html>

<p>
The <strong>3</strong> signals of the <strong>torque</strong> connector are interpreted
as the x-, y- and z-coordinates of a <strong>torque</strong> acting at the frame
connector to which frame_b of this component is attached.
Via parameter <strong>resolveInFrame</strong> it is defined, in which frame these
coordinates shall be resolved:
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th><strong>Types.ResolveInFrameB.</strong></th><th><strong>Meaning</strong></th></tr>
<tr><td>world</td>
    <td>Resolve input torque in world frame (= default)</td></tr>

<tr><td>frame_b</td>
    <td>Resolve input torque in frame_b</td></tr>

<tr><td>frame_resolve</td>
    <td>Resolve input torque in frame_resolve (frame_resolve must be connected)</td></tr>
</table>

<p>
If resolveInFrame = Types.ResolveInFrameB.frame_resolve, the torque coordinates
are with respect to the frame, that is connected to <strong>frame_resolve</strong>.
</p>

<p>
If torque={100,0,0}, and for all parameters the default setting is used,
then the interpretation is that a torque of 100 N is acting along the positive
x-axis of frame_b.
</p>

<p>
Note, the cut-force in frame_b (frame_b.f) is always set to zero.
Conceptually, a force and torque acts on the world frame in such a way that
the force and torque balance between world.frame_b and frame_b is fulfilled.
For efficiency reasons, this reaction torque is, however, not computed.
</p>

<p>
This torque component is by default visualized as a <strong>double arrow</strong>
acting at the connector to which it is connected.
The color of the arrow can be defined via
variable <strong>color</strong>. The double arrow points
in the direction defined by the
torque vector. The length of the double arrow is proportional
to the length of the torque vector using a global tool-dependent scaling factor.
</p>
<p>
An example how to use this model is given in the
following figure:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Forces/WorldTorque1.png\">
</div>

<p>
This leads to the following animation
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Forces/WorldTorque2.png\">
</div>

</html>"),
         Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-61,64},{46,27}},
          textColor={192,192,192},
          textString="resolve"),
        Text(
          extent={{-150,-40},{150,-80}},
          textString="%name",
          textColor={0,0,255}),
        Line(
          points={{0,95},{0,82}},
          color={95,95,95},
          pattern=LinePattern.Dot),
        Line(
          points={{-100,0},{-94,13},{-86,28},{-74,48},{-65,60},{-52,72},{-35,
              81},{-22,84},{-8,84},{7,80},{19,73},{32,65},{44,55},{52,47},{58,
              40}},
          thickness=0.5),
        Polygon(
          points={{94,10},{75,59},{41,24},{94,10}},
          fillPattern=FillPattern.Solid)}));
end WorldTorque;
