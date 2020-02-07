within Modelica.Mechanics.MultiBody.Frames.Quaternions;
function multipleResolve1
  "Transform several vectors from frame 2 to frame 1"
  extends Modelica.Icons.Function;
  input Quaternions.Orientation Q
    "Quaternions orientation object to rotate frame 1 into frame 2";
  input Real v2[3, :] "Vectors in frame 2";
  output Real v1[3, size(v2, 2)] "Vectors in frame 1";
algorithm
  v1 := ((2*Q[4]*Q[4] - 1)*identity(3) + 2*(outerProduct(Q[1:3],Q[1:3]) +
    Q[4]*skew(Q[1:3])))*v2;
  annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
v1 = Quaternions.<strong>multipleResolve1</strong>(Q, v2);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns vectors&nbsp;v resolved in frame&nbsp;1 (=v1) from vectors&nbsp;v
resolved in frame&nbsp;2 (=v2) using the
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.Orientation\">quaternions orientation</a>&nbsp;Q
that describes the orientation to rotate frame&nbsp;1 into frame&nbsp;2.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.multipleResolve1\">TransformationMatrices.multipleResolve1</a>.
</p>
</html>"));
end multipleResolve1;
