within Modelica.Mechanics.MultiBody.Forces;
model WorldForceAndTorque
  "External force and torque acting at frame_b, defined by 3+3 input signals and resolved in frame world, frame_b or in frame_resolve"

  import Modelica.Mechanics.MultiBody.Types;
  extends Interfaces.PartialOneFrame_b;
  Interfaces.Frame_resolve frame_resolve if
       resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.frame_resolve
    "The input signals are optionally resolved in this frame"
    annotation (Placement(transformation(
        origin={0,100},
        extent={{16,-16},{-16,16}},
        rotation=270)));
  Blocks.Interfaces.RealInput force[3](each final quantity="Force", each final unit=
                   "N")
    "x-, y-, z-coordinates of force resolved in frame defined by resolveInFrame"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  Blocks.Interfaces.RealInput torque[3](each final quantity="Torque", each final unit=
                   "N.m")
    "x-, y-, z-coordinates of torque resolved in frame defined by resolveInFrame"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));

  parameter Boolean animation=true "= true, if animation shall be enabled";
  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameB resolveInFrame=
    Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.world
    "Frame in which input force and torque are resolved (1: world, 2: frame_b, 3: frame_resolve)";

  input Types.Color forceColor=Modelica.Mechanics.MultiBody.Types.Defaults.ForceColor
    "Color of force arrow" annotation (Dialog(colorSelector=true, group="if animation = true", enable=animation));
  input Types.Color torqueColor=Modelica.Mechanics.MultiBody.Types.Defaults.TorqueColor
    "Color of torque arrow" annotation (Dialog(colorSelector=true, group="if animation = true", enable=animation));
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
  Visualizers.Advanced.DoubleArrow torqueArrow(
    color=torqueColor,
    specularCoefficient=specularCoefficient,
    quantity=Modelica.Mechanics.MultiBody.Types.VectorQuantity.Torque,
    R=frame_b.R,
    r=frame_b.r_0,
    r_head=-frame_b.t,
    headAtOrigin=true) if world.enableAnimation and animation;
public
  Internal.BasicWorldForce basicWorldForce(resolveInFrame=resolveInFrame)
    annotation (Placement(transformation(extent={{18,-50},{38,-70}})));
  Internal.BasicWorldTorque basicWorldTorque(resolveInFrame=resolveInFrame)
    annotation (Placement(transformation(extent={{-10,50},{10,70}})));
protected
  Interfaces.ZeroPosition zeroPosition if
       not (resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.frame_resolve)
    annotation (Placement(transformation(extent={{58,70},{78,90}})));
equation
  connect(basicWorldForce.frame_b, frame_b) annotation (Line(
      points={{38,-60},{60,-60},{60,0},{100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(basicWorldForce.force, force) annotation (Line(
      points={{16,-60},{-120,-60}}, color={0,0,127}));
  connect(basicWorldTorque.frame_b, frame_b)
    annotation (Line(
      points={{10,60},{60,60},{60,0},{100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(basicWorldTorque.torque, torque)
    annotation (Line(
      points={{-12,60},{-120,60}}, color={0,0,127}));
  connect(basicWorldForce.frame_resolve, frame_resolve) annotation (Line(
      points={{28,-50},{28,80},{0,80},{0,100}},
      color={95,95,95},
      pattern=LinePattern.Dot));
  connect(basicWorldTorque.frame_resolve, frame_resolve)
    annotation (Line(
      points={{0,70},{0,100}},
      color={95,95,95},
      pattern=LinePattern.Dot));
  connect(zeroPosition.frame_resolve, basicWorldTorque.frame_resolve)
    annotation (Line(
      points={{58,80},{0,80},{0,70}},
      color={95,95,95},
      pattern=LinePattern.Dot));
  connect(zeroPosition.frame_resolve, basicWorldForce.frame_resolve)
    annotation (Line(
      points={{58,80},{40,80},{40,-40},{28,-40},{28,-50}},
      color={95,95,95},
      pattern=LinePattern.Dot));
  annotation (defaultComponentName="forceAndTorque",
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
        Text(
          extent={{-63,56},{44,19}},
          textColor={192,192,192},
          textString="resolve"),
        Text(
          extent={{-150,-75},{150,-115}},
          textString="%name",
          textColor={0,0,255}),
        Line(
          points={{-100,60},{-86,68},{-80,72},{-70,78},{-64,82},{-46,86},{-34,
              88},{-16,88},{-2,86},{12,80},{24,74},{34,68},{46,58},{52,54},{
              58,48}},
          thickness=0.5),
        Polygon(
          points={{89,17},{64,76},{30,41},{89,17}},
          fillPattern=FillPattern.Solid),
        Line(
          points={{0,95},{0,-26}},
          color={95,95,95},
          pattern=LinePattern.Dot),
        Line(
          points={{0,0},{96,0}},
          color={95,95,95},
          pattern=LinePattern.Dot),
        Polygon(
          points={{-104,-48},{54,0},{46,20},{96,0},{66,-42},{60,-22},{-96,-72},
              {-104,-48}},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p>
The <strong>3</strong> signals of the <strong>force</strong> and <strong>torque</strong>
connector are interpreted
as the x-, y- and z-coordinates of a <strong>force</strong> and
<strong>torque</strong> acting at the frame
connector to which frame_b of this component is attached.
Via parameter <strong>resolveInFrame</strong> it is defined, in which frame these
coordinates shall be resolved:
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th><strong>Types.ResolveInFrameB.</strong></th><th><strong>Meaning</strong></th></tr>
<tr><td>world</td>
    <td>Resolve input force and torque in world frame (= default)</td></tr>

<tr><td>frame_b</td>
    <td>Resolve input force and torque in frame_b</td></tr>

<tr><td>frame_resolve</td>
    <td>Resolve input force and torque in frame_resolve
                    (frame_resolve must be connected)</td></tr>
</table>

<p>
If resolveInFrame = Types.ResolveInFrameB.frame_resolve, the force and
torque coordinates
are with respect to the frame, that is connected to <strong>frame_resolve</strong>.
</p>

<p>
If force={100,0,0}, and for all parameters the default setting is used,
then the interpretation is that a force of 100 N is acting along the positive
x-axis of frame_b.
</p>

<p>
Conceptually, a force and torque acts on the world frame in such a way that
the force and torque balance between world.frame_b and frame_b is fulfilled.
For efficiency reasons, this reaction torque is, however, not computed.
</p>

<p>
The force and torque are by default visualized as an arrow (force)
and as a double arrow (torque) acting at the connector to which
they are connected. The colors of the arrows can be defined via
<strong>forceColor</strong> and <strong>torqueColor</strong>. The arrows
point in the directions defined by the
force and torque vectors. The lengths of the arrows are proportional
to the length of the force and torque vectors, respectively, using tool-dependent
scaling factors.
</p>
<p>
An example how to use this model is given in the
following figure:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Forces/WorldForceAndTorque1.png\">
</div>

<p>
This leads to the following animation
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Forces/WorldForceAndTorque2.png\">
</div>

</html>"));
end WorldForceAndTorque;
