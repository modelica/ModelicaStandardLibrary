within Modelica.Mechanics.MultiBody.Visualizers;
model SignalArrow
  "Visualizing an arrow with dynamically varying size in frame_a based on input signal"

  import Modelica.Mechanics.MultiBody.Types;

  extends Modelica.Mechanics.MultiBody.Interfaces.PartialVisualizer;
  parameter Boolean animation=true "= true, if animation shall be enabled";
  input SI.Position r_tail[3]={0,0,0}
    "Vector from frame_a to arrow tail, resolved in frame_a"
    annotation (Dialog(group="if animation = true", enable=animation));
  input Types.Color color={0,0,255} "Color of arrow"
    annotation (Dialog(colorSelector=true, group="if animation = true", enable=animation));
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (Dialog(group="if animation = true", enable=animation));
  parameter Types.VectorQuantity quantity=Types.VectorQuantity.RelativePosition
    "Kind of physical quantity represented by the vector"
    annotation(Dialog(group="if animation = true", enable=animation));
  input Boolean headAtOrigin=false "= true, if the vector is pointing towards the origin of vector frame"
    annotation (Dialog(group="if animation = true", enable=animation));

  Modelica.Blocks.Interfaces.RealInput r_head[3]
    "Vector resolved in frame_a"
    annotation (Placement(transformation(
        origin={0,-120},
        extent={{-20,-20},{20,20}},
        rotation=90)));

protected
  Visualizers.Advanced.Arrow arrow(
    R=frame_a.R,
    r=frame_a.r_0,
    r_tail=r_tail,
    r_head=r_head,
    color=color,
    quantity=quantity,
    headAtOrigin=headAtOrigin,
    specularCoefficient=specularCoefficient) if world.enableAnimation and animation;
equation
  frame_a.f = zeros(3);
  frame_a.t = zeros(3);

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
        Line(points={{0,-102},{0,-28}}, color={0,0,127}),
        Rectangle(
          extent={{-100,28},{20,-28}},
          lineColor={128,128,128},
          fillColor={128,128,128},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{20,60},{100,0},{20,-60},{20,60}},
          lineColor={128,128,128},
          fillColor={128,128,128},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,105},{150,65}},
          textString="%name",
          textColor={0,0,255})}),
    Documentation(info="<html>
<p>
Model <strong>SignalArrow</strong> defines an arrow that is dynamically visualized
at the location where its frame_a is attached. The
vector from the tail to the head of the arrow,
resolved in frame_a, is defined via the signal vector of
the connector <code>r_head</code> (<code><strong>Real</strong> r_head[3]</code>):<br>&nbsp;
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/Arrow.png\" alt=\"model Visualizers.SignalArrow\">
</div>
<p>
The <code>quantity</code> parameter defines what the vector represents, allowing
tools to scale e.g. forces and torques differently in a&nbsp;consistent way.
For the default value <strong>RelativePosition</strong> the obvious scaling is
1&nbsp;and the relative position is shown as is.
</p>
<p>
The tail of the arrow is defined with input <code>r_tail</code>
with respect to frame_a (vector from the origin of frame_a to the arrow tail).
</p>
</html>"));
end SignalArrow;
