within Modelica.Mechanics.MultiBody.Visualizers.Internal;
model FixedLines
  "Visualizing a set of lines as cylinders (e.g., used to display characters)"

  import Modelica.Mechanics.MultiBody;
  import Modelica.Mechanics.MultiBody.Types;
  extends Modelica.Mechanics.MultiBody.Interfaces.PartialVisualizer;

  parameter Boolean animation=true "= true, if animation shall be enabled";
  input Real scale(min=0) = 1
    "The 'lines' are visualized 'scale' times bigger"
    annotation (Dialog(group="if animation = true", enable=animation));
  input SI.Position lines[:,2,2]={[0,0; 1,1],[0,1; 1,0]}
    "List of start and end points of cylinders resolved along n_x and n_y"
    annotation (Dialog(group="if animation = true", enable=animation));
  input SI.Distance diameter(min=0) = 0.05
    "Diameter of the cylinders defined by lines"
    annotation (Dialog(group="if animation = true", enable=animation));
  input SI.Position r_lines[3]={0,0,0}
    "Position vector from origin of frame_a to the origin of the 'lines' frame, resolved in frame_a"
    annotation (Dialog(group="if animation = true", enable=animation));
  input Real n_x[3](each final unit="1")={1,0,0}
    "Vector in direction of x-axis of 'lines' frame, resolved in frame_a."
    annotation (Dialog(group="if animation = true", enable=animation));
  input Real n_y[3](each final unit="1")={0,1,0}
    "Vector in direction of y-axis of 'lines' frame, resolved in frame_a."
    annotation (Dialog(group="if animation = true", enable=animation));
  input MultiBody.Types.Color color={0,128,255} "Color of cylinders"
    annotation (Dialog(colorSelector=true, group="if animation = true", enable=animation));
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (Dialog(group="if animation = true", enable=animation));

protected
  Lines x_label(
    lines=scale*lines,
    diameter=scale*diameter,
    color=color,
    specularCoefficient = specularCoefficient,
    r_lines=r_lines,
    n_x=n_x,
    n_y=n_y,
    r=frame_a.r_0,
    R=frame_a.R) if world.enableAnimation and animation;
equation
  frame_a.f = zeros(3);
  frame_a.t = zeros(3);
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={128,128,128},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,145},{150,105}},
          textString="%name",
          textColor={0,0,255}),
        Polygon(
          points={{-82,-24},{-20,46},{-10,38},{-72,-32},{-82,-24}},
          lineColor={0,127,255},
          fillColor={0,127,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-24,-34},{-82,40},{-72,46},{-14,-26},{-24,-34}},
          lineColor={0,127,255},
          fillColor={0,127,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{42,-18},{10,40},{20,48},{50,-6},{42,-18}},
          lineColor={0,127,255},
          fillColor={0,127,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{10,-68},{84,48},{96,42},{24,-72},{10,-68}},
          lineColor={0,127,255},
          fillColor={0,127,255},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p>
With model <strong>FixedLines</strong> a set of lines is defined
that are located relatively to frame_a. Every line
is represented by a cylinder. This allows to define simple shaped
3-dimensional characters. An example is shown in the
following figure:<br>&nbsp;
</p>
<div><img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/Internal/FixedLines.png\" alt=\"model Visualizers.Internal.FixedLines\"></div>
<p>&nbsp;<br>
The two letters \"x\" and \"y\" are constructed with 4 lines
by providing the following data for parameter <strong>lines</strong>
</p>
<blockquote><pre>
lines = {[0, 0; 1, 1],[0, 1; 1, 0],[1.5, -0.5; 2.5, 1],[1.5, 1; 2, 0.25]}
</pre></blockquote>
<p>
Via parameter vectors <strong>n_x</strong> and <strong>n_y</strong> a two-dimensional
coordinate system is defined. The points defined with parameter
<strong>lines</strong> are with respect to this coordinate system. For example
\"[0, 0; 1, 1]\" defines a line that starts at {0,0} and ends at {1,1}.
The diameter and color of all line cylinders are identical.
</p>
</html>"));
end FixedLines;
