within Modelica.Mechanics.MultiBody.Frames.Quaternions;
function nullRotation
  "Return quaternion orientation object that does not rotate a frame"

  extends Modelica.Icons.Function;
  output Quaternions.Orientation Q
    "Quaternions orientation object to rotate frame 1 into frame 2";
algorithm
  Q := {0,0,0,1};
  annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Q = Quaternions.<strong>nullRotation</strong>();
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns a
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.Orientation\">quaternions orientation</a>&nbsp;Q
describing the orientation object to rotate frame&nbsp;1 into frame&nbsp;2, if frame&nbsp;1 and frame&nbsp;2 are identical.
(= transformation matrix is identity matrix and angular velocity is zero).
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.nullRotation\">Frames.nullRotation</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.nullRotation\">TransformationMatrices.nullRotation</a>.
</p>
</html>"));
end nullRotation;
