within Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
function inverseRotation "Return inverse orientation object"
  extends Modelica.Icons.Function;
  input TransformationMatrices.Orientation T
    "Orientation object to rotate frame 1 into frame 2";
  output TransformationMatrices.Orientation T_inv
    "Orientation object to rotate frame 2 into frame 1";
algorithm
  T_inv := transpose(T);
  annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
T_inv = TransformationMatrices.<strong>inverseRotation</strong>(T);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a> T_inv
that describes the orientation to rotate from frame&nbsp;2 to frame&nbsp;1
from the
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a>&nbsp;T
that describes the orientation to rotate from frame&nbsp;1 into frame&nbsp;2.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.inverseRotation\">Frames.inverseRotation</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.inverseRotation\">Quaternions.inverseRotation</a>.
</p>
</html>"));
end inverseRotation;
