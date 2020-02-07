within Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
function planarRotation "Return orientation object of a planar rotation"
  import Modelica.Math;
  extends Modelica.Icons.Function;
  input Real e[3](each final unit="1")
    "Normalized axis of rotation (must have length=1)";
  input SI.Angle angle
    "Rotation angle to rotate frame 1 into frame 2 along axis e";
  output TransformationMatrices.Orientation T
    "Orientation object to rotate frame 1 into frame 2";
algorithm
  T := outerProduct(e,e) + (identity(3) - outerProduct(e,e))*Math.cos(
    angle) - skew(e)*Math.sin(angle);
  annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
T = TransformationMatrices.<strong>planarRotation</strong>(e, angle);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a>&nbsp;T
that describes the orientation to rotate in the plane along unit
axis <strong>e</strong> from frame 1 into frame 2 with angle <strong>angle</strong>.
Note, \"e\" must be a unit vector. However, this is not checked in this function and the function will
return a wrong result, if length(e) is not one.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.planarRotationAngle\">planarRotationAngle</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.planarRotation\">Frames.planarRotation</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.planarRotation\">Quaternions.planarRotation</a>.
</p>
</html>"));
end planarRotation;
