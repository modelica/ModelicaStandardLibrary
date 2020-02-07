within Modelica.Mechanics.MultiBody.Frames;
function axisRotation
  "Return rotation object to rotate around an angle along one frame axis"

  extends Modelica.Icons.Function;
  input Integer axis(min=1, max=3) "Rotate around 'axis' of frame 1";
  input SI.Angle angle
    "Rotation angle to rotate frame 1 into frame 2 along 'axis' of frame 1";
  input SI.AngularVelocity der_angle "= der(angle)";
  output Orientation R "Orientation object to rotate frame 1 into frame 2";
algorithm
  R := Orientation(T=(if axis == 1 then [1, 0, 0; 0, Modelica.Math.cos(angle), Modelica.Math.sin(angle);
    0, -Modelica.Math.sin(angle), Modelica.Math.cos(angle)] else if axis == 2 then [Modelica.Math.cos(angle), 0, -Modelica.Math.sin(
    angle); 0, 1, 0; Modelica.Math.sin(angle), 0, Modelica.Math.cos(angle)] else [Modelica.Math.cos(angle), Modelica.Math.sin(angle),
     0; -Modelica.Math.sin(angle), Modelica.Math.cos(angle), 0; 0, 0, 1]),w= if axis == 1 then {der_angle,
    0,0} else if axis == 2 then {0,der_angle,0} else {0,0,der_angle});
  annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
R = Frames.<strong>axisRotation</strong>(axis, angle, der_angle);
</pre></blockquote>

<h4>Description</h4>
<p>
The function call <code>Frames.<strong>axisRotation</strong>(axis, angle, der_angle)</code> returns
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Orientation\">orientation object</a>&nbsp;R
that describes the orientation to rotate along unit axis <strong>axis</strong>
from frame&nbsp;1 into frame&nbsp;2 with angle <strong>angle</strong> and derivative of angle <strong>der_angle</strong>.
For example, Frames.axisRotation(2, phi, der_phi) returns the same orientation object as with the call
Frames.planarRotation({0,1,0}, phi, der_phi)
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.planarRotation\">planarRotation</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.axisRotation\">TransformationMatrices.axisRotation</a>.
</p>
</html>"));
end axisRotation;
