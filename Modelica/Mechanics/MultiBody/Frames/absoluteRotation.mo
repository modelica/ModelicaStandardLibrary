within Modelica.Mechanics.MultiBody.Frames;
function absoluteRotation
  "Return absolute orientation object from another absolute and a relative orientation object"

  extends Modelica.Icons.Function;
  input Orientation R1 "Orientation object to rotate frame 0 into frame 1";
  input Orientation R_rel "Orientation object to rotate frame 1 into frame 2";
  output Orientation R2 "Orientation object to rotate frame 0 into frame 2";
algorithm
  R2 := Orientation(T=R_rel.T*R1.T,w= resolve2(R_rel, R1.w) + R_rel.w);
  annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
R2 = Frames.<strong>absoluteRotation</strong>(R1,R_rel);
</pre></blockquote>

<h4>Description</h4>
<p>
The function call <code>Frames.<strong>absoluteRotation</strong>(R1,R_rel)</code> returns
orientation object R2 that describes the orientation frame&nbsp;0 to frame&nbsp;2
from the orientation object R1 that describes the orientation to rotate from frame&nbsp;0 to frame&nbsp;1 and
from the relative orientation object R_rel that describes the orientation to rotate from frame&nbsp;1 to frame&nbsp;2.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.absoluteRotation\">TransformationMatrices.absoluteRotation</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.absoluteRotation\">Quaternions.absoluteRotation</a>.
</p>
</html>"));
end absoluteRotation;
