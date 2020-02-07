within Modelica.Mechanics.MultiBody.Frames;
function relativeRotation "Return relative orientation object"
  extends Modelica.Icons.Function;
  input Orientation R1 "Orientation object to rotate frame 0 into frame 1";
  input Orientation R2 "Orientation object to rotate frame 0 into frame 2";
  output Orientation R_rel
    "Orientation object to rotate frame 1 into frame 2";
algorithm
  R_rel := Orientation(T=R2.T*transpose(R1.T),w= R2.w - resolve2(R2, resolve1(
     R1, R1.w)));
  annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
R_rel = Frames.<strong>relativeRotation</strong>(R1,R2);
</pre></blockquote>

<h4>Description</h4>
<p>
The function call <code>Frames.<strong>relativeRotation</strong>(R1,R2)</code> returns
orientation object R_rel that describes the orientation to rotate frame&nbsp;1 to frame&nbsp;2
from the orientation object R1 that describes the orientation to rotate from frame&nbsp;0 to frame&nbsp;1 and
from the orientation object R2 that describes the orientation to rotate from frame&nbsp;0 to frame&nbsp;2.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.relativeRotation\">TransformationMatrices.relativeRotation</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.relativeRotation\">Quaternions.relativeRotation</a>.
</p>
</html>"));
end relativeRotation;
