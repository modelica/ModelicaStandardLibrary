within Modelica.Mechanics.MultiBody.Visualizers.Internal;
model Lines
  "Visualizing a set of lines as cylinders with variable size, e.g., used to display characters (no Frame connector)"

  import Modelica.Mechanics.MultiBody;
  import Modelica.Mechanics.MultiBody.Types;
  import Modelica.Mechanics.MultiBody.Frames;
  import T = Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
  input Modelica.Mechanics.MultiBody.Frames.Orientation R=Frames.nullRotation()
    "Orientation object to rotate the world frame into the object frame" annotation(Dialog);
  input SI.Position r[3]={0,0,0}
    "Position vector from origin of world frame to origin of object frame, resolved in world frame"
     annotation(Dialog);
  input SI.Position r_lines[3]={0,0,0}
    "Position vector from origin of object frame to the origin of 'lines' frame, resolved in object frame"
     annotation(Dialog);
  input Real n_x[3](each final unit="1")={1,0,0}
    "Vector in direction of x-axis of 'lines' frame, resolved in object frame"
     annotation(Dialog);
  input Real n_y[3](each final unit="1")={0,1,0}
    "Vector in direction of y-axis of 'lines' frame, resolved in object frame"
   annotation(Dialog);
  input SI.Position lines[:, 2, 2]=zeros(0, 2, 2)
    "List of start and end points of cylinders resolved in an x-y frame defined by n_x, n_y, e.g., {[0,0;1,1], [0,1;1,0], [2,0; 3,1]}"
  annotation(Dialog);
  input SI.Length diameter(min=0) = 0.05
    "Diameter of the cylinders defined by lines"
  annotation(Dialog);
  input Modelica.Mechanics.MultiBody.Types.Color color={0,128,255}
    "Color of cylinders"
  annotation(Dialog(colorSelector=true));
  input Types.SpecularCoefficient specularCoefficient = 0.7
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (Dialog);
protected
  parameter Integer n=size(lines, 1) "Number of cylinders";
  T.Orientation R_rel=T.from_nxy(n_x, n_y);
  T.Orientation R_lines=T.absoluteRotation(R.T, R_rel);
  SI.Position r_abs[3]=r + T.resolve1(R.T, r_lines);
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape cylinders[n](
    each shapeType="cylinder",
    lengthDirection={T.resolve1(R_rel, vector([lines[i, 2, :] - lines[i, 1, :]; 0])) for i in 1:n},
    length={Modelica.Math.Vectors.length(lines[i, 2, :] - lines[i, 1, :]) for i in 1:n},
    r={r_abs + T.resolve1(R_lines, vector([lines[i, 1, :]; 0])) for i in 1:n},
    each width=diameter,
    each height=diameter,
    each widthDirection={0,1,0},
    each color=color,
    each R=R,
    each specularCoefficient=specularCoefficient);
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={128,128,128},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-24,-34},{-82,40},{-72,46},{-14,-26},{-24,-34}},
          lineColor={0,127,255},
          fillColor={0,127,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-82,-24},{-20,46},{-10,38},{-72,-32},{-82,-24}},
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
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,145},{150,105}},
          textString="%name",
          textColor={0,0,255})}),
    Documentation(info="<html>
<p>
With model <strong>Lines</strong> a set of dynamic lines is defined
that are located relatively to frame_a. Every line
is represented by a cylinder. This allows, e.g., to define simple shaped
3-dimensional characters. Note, if the lines are fixed relatively to frame_a,
it is more convenient to use model <strong>Visualizers.Internal.FixedLines</strong>.
An example for dynamic lines is shown in the following figure:<br>&nbsp;
</p>
<div><img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/Internal/FixedLines.png\" alt=\"model Visualizers.Internal.FixedLines\"></div>
<p>&nbsp;<br>
The two letters \"x\" and \"y\" are constructed with 4 lines
by providing the following data for input variable <strong>lines</strong>
</p>
<blockquote><pre>
lines = {[0, 0; 1, 1],[0, 1; 1, 0],[1.5, -0.5; 2.5, 1],[1.5, 1; 2, 0.25]}
</pre></blockquote>
<p>
Via vectors <strong>n_x</strong> and <strong>n_y</strong> a two-dimensional
coordinate system is defined. The points defined with variable
<strong>lines</strong> are with respect to this coordinate system. For example
\"[0, 0; 1, 1]\" defines a line that starts at {0,0} and ends at {1,1}.
The        and color of all line cylinders are identical
and are defined by parameters.
</p>

</html>"));

end Lines;
