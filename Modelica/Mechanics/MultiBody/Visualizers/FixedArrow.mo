within Modelica.Mechanics.MultiBody.Visualizers;
model FixedArrow
  "Visualizing an arrow with dynamically varying size in frame_a"

  import Modelica.Mechanics.MultiBody.Types;
  extends Modelica.Mechanics.MultiBody.Interfaces.PartialVisualizer;
  parameter Boolean animation=true "= true, if animation shall be enabled";
  input SI.Position r_tail[3]={0,0,0}
    "Vector from frame_a to arrow tail, resolved in frame_a"
    annotation (Dialog(group="if animation = true", enable=animation));
  input Types.Axis n={1,0,0} "Vector in arrow direction, resolved in frame_a"
    annotation (Dialog(group="if animation = true", enable=animation));
  input SI.Length length=0.1 "Length of complete arrow"
    annotation (Dialog(group="if animation = true", enable=animation));
  input Types.Color color={0,0,255} "Color of arrow"
    annotation (Dialog(colorSelector=true, group="if animation = true", enable=animation));
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (Dialog(group="if animation = true", enable=animation));
  parameter Types.VectorQuantity quantity=Types.VectorQuantity.RelativePosition
    "Kind of physical quantity represented by the vector"
    annotation (Dialog(group="if animation = true", enable=animation));
  input Boolean headAtOrigin=false "= true, if the vector is pointing towards the origin of vector frame"
    annotation (Dialog(group="if animation = true", enable=animation));
protected
  Visualizers.Advanced.Vector arrowLine(
    color=color,
    specularCoefficient=specularCoefficient,
    coordinates=n*length,
    quantity=quantity,
    headAtOrigin=headAtOrigin,
    r=frame_a.r_0 + Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.resolve1(frame_a.R.T, r_tail),
    R=frame_a.R) if world.enableAnimation and animation;
equation
  frame_a.f = zeros(3);
  frame_a.t = zeros(3);

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
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
          textColor={0,0,255}),
        Text(
          extent={{-150,-75},{150,-105}},
          textString="%length")}),
    Documentation(info="<html>
<p>
Model <strong>FixedArrow</strong> defines an arrow that is
shown at the location of its frame_a.
<br>&nbsp;
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/Arrow.png\" alt=\"model Visualizers.FixedArrow\">
</div>

<p>
The direction of the arrow specified with vector
<code>n</code> is with respect to frame_a, i.e., the local frame to which the
arrow component is attached. The direction, length and color of the arrow
can vary dynamically by providing appropriate expressions in the input
fields of the parameter menu.
</p>
<p>
The <code>quantity</code> parameter defines what the vector represents, allowing
tools to scale e.g. forces and torques differently in a&nbsp;consistent way.
For the default value <strong>RelativePosition</strong> the obvious scaling is
1&nbsp;and the relative position is shown as is.
</p>
</html>"));
end FixedArrow;
