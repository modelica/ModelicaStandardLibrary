within Modelica.Mechanics.MultiBody.Frames.Quaternions;
function planarRotation
  "Return quaternion orientation object of a planar rotation"
  import Modelica.Math;
  extends Modelica.Icons.Function;
  input Real e[3](each final unit="1")
    "Normalized axis of rotation (must have length=1)";
  input SI.Angle angle
    "Rotation angle to rotate frame 1 into frame 2 along axis e";
  output Quaternions.Orientation Q
    "Quaternions orientation object to rotate frame 1 into frame 2 along axis e";
algorithm
  Q := vector([e*Math.sin(angle/2); Math.cos(angle/2)]);
  annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Q = Quaternions.<strong>planarRotation</strong>(e, angle);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.Orientation\">quaternions orientation</a>&nbsp;Q
that describes the orientation to rotate in the plane along unit
axis <strong>e</strong> from frame 1 into frame 2 with angle <strong>angle</strong>.
Note, \"e\" must be a unit vector. However, this is not checked in this function and the function will
return a wrong result, if length(e) is not one.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.planarRotation\">Frames.planarRotation</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.planarRotation\">TransformationMatrices.planarRotation</a>.
</p>
</html>"));
end planarRotation;
