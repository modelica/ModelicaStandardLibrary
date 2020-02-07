within Modelica.Mechanics.MultiBody.Frames;
function planarRotation "Return orientation object of a planar rotation"
  import Modelica.Math;
  extends Modelica.Icons.Function;
  input Real e[3](each final unit="1")
    "Normalized axis of rotation (must have length=1)";
  input SI.Angle angle
    "Rotation angle to rotate frame 1 into frame 2 along axis e";
  input SI.AngularVelocity der_angle "= der(angle)";
  output Orientation R "Orientation object to rotate frame 1 into frame 2";
algorithm
  R := Orientation(T=outerProduct(e,e) + (identity(3) - outerProduct(e,e))*
    Math.cos(angle) - skew(e)*Math.sin(angle),w= e*der_angle);

  annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
R = Frames.<strong>planarRotation</strong>(e, angle, der_angle);
</pre></blockquote>

<h4>Description</h4>
<p>
The function call <code>Frames.<strong>planarRotation</strong>(e, angle, der_angle)</code> returns
orientation object R that describes the orientation to rotate in the plane along unit
axis <strong>e</strong> from frame&nbsp;1 into frame&nbsp;2 with angle <strong>angle</strong> and derivative of angle <strong>der_angle</strong>.
Note, \"e\" must be a unit vector. However, this is not checked in this function and the function will
return a wrong result, if length(e) is not one.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.planarRotationAngle\">planarRotationAngle</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.planarRotation\">TransformationMatrices.planarRotation</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.planarRotation\">Quaternions.planarRotation</a>.
</p>
</html>"));
end planarRotation;
