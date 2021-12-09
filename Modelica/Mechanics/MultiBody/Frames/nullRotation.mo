within Modelica.Mechanics.MultiBody.Frames;
function nullRotation
  "Return orientation object that does not rotate a frame"
  extends Modelica.Icons.Function;
  output Orientation R
    "Orientation object such that frame 1 and frame 2 are identical";
algorithm
  R := Orientation(T=identity(3),w= zeros(3));
  annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
R = Frames.<strong>nullRotation</strong>();
</pre></blockquote>

<h4>Description</h4>
<p>
The function call <code>Frames.<strong>nullRotation</strong>()</code> returns an orientation matrix&nbsp;R
describing the orientation object to rotate frame&nbsp;1 into frame&nbsp;2, if frame&nbsp;1 and frame&nbsp;2 are identical.
(= transformation matrix is identity matrix and angular velocity is zero).
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.nullRotation\">TransformationMatrices.nullRotation</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.nullRotation\">Quaternions.nullRotation</a>.
</p>
</html>"));
end nullRotation;
