within Modelica.Mechanics.MultiBody.Frames.Quaternions;
function inverseRotation "Return inverse quaternions orientation object"
  extends Modelica.Icons.Function;
  input Quaternions.Orientation Q
    "Quaternions orientation object to rotate frame 1 into frame 2";
  output Quaternions.Orientation Q_inv
    "Quaternions orientation object to rotate frame 2 into frame 1";
algorithm
  Q_inv := {-Q[1],-Q[2],-Q[3],Q[4]};
  annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Q_inv = Quaternions.<strong>inverseRotation</strong>(Q);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.Orientation\">quaternions orientation</a>&nbsp;Q_inv
that describes the orientation to rotate from frame&nbsp;2 to frame&nbsp;1
from the
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.Orientation\">quaternions orientation</a>&nbsp;Q
that describes the orientation to rotate from frame&nbsp;1 into frame&nbsp;2.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.inverseRotation\">Frames.inverseRotation</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.inverseRotation\">TransformationMatrices.inverseRotation</a>.

</p>
</html>"));
end inverseRotation;
