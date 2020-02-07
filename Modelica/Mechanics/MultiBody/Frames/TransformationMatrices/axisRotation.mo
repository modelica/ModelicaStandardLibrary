within Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
function axisRotation
  "Return rotation object to rotate around one frame axis"
  extends Modelica.Icons.Function;
  input Integer axis(min=1, max=3) "Rotate around 'axis' of frame 1";
  input SI.Angle angle
    "Rotation angle to rotate frame 1 into frame 2 along 'axis' of frame 1";
  output TransformationMatrices.Orientation T
    "Orientation object to rotate frame 1 into frame 2";
algorithm
  T := if axis == 1 then [1, 0, 0; 0, Modelica.Math.cos(angle), Modelica.Math.sin(angle); 0, -Modelica.Math.sin(angle),
     Modelica.Math.cos(angle)] else if axis == 2 then [Modelica.Math.cos(angle), 0, -Modelica.Math.sin(angle); 0, 1, 0;
     Modelica.Math.sin(angle), 0, Modelica.Math.cos(angle)] else [Modelica.Math.cos(angle), Modelica.Math.sin(angle), 0;
    -Modelica.Math.sin(angle), Modelica.Math.cos(angle), 0; 0, 0, 1];
  annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
T = TransformationMatrices.<strong>axisRotation</strong>(axis, angle);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a>&nbsp;T
that describes the orientation to rotate along unit axis <strong>axis</strong>
from frame 1 into frame 2 with angle <strong>angle</strong>.
For example, TransformationMatrices.axisRotation(2, phi) returns the same orientation object as with the call
TransformationMatrices.planarRotation({0,1,0}, phi)
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.planarRotation\">planarRotation</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.axisRotation\">Frames.axisRotation</a>.
</p>
</html>"));
end axisRotation;
