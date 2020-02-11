within Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
function multipleResolve1
  "Transform several vectors from frame 2 to frame 1"

  extends Modelica.Icons.Function;
  input TransformationMatrices.Orientation T
    "Orientation object to rotate frame 1 into frame 2";
  input Real v2[3, :] "Vectors in frame 2";
  output Real v1[3, size(v2, 2)] "Vectors in frame 1";
algorithm
  v1 := transpose(T)*v2;
  annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
v1 = TransformationMatrices.<strong>multipleResolve1</strong>(T, v2);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns vectors&nbsp;v resolved in frame&nbsp;1 (=v1) from vectors&nbsp;v
resolved in frame&nbsp;2 (=v2) using the
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a>&nbsp;T
that describes the orientation to rotate frame&nbsp;1 into frame&nbsp;2.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.multipleResolve1\">Quaternions.multipleResolve1</a>.
</p>
</html>"));
end multipleResolve1;
