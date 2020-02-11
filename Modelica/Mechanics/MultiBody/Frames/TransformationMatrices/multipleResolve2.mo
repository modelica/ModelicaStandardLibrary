within Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
function multipleResolve2
  "Transform several vectors from frame 1 to frame 2"

  extends Modelica.Icons.Function;
  input TransformationMatrices.Orientation T
    "Orientation object to rotate frame 1 into frame 2";
  input Real v1[3, :] "Vectors in frame 1";
  output Real v2[3, size(v1, 2)] "Vectors in frame 2";
algorithm
  v2 := T*v1;
  annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
v2 = TransformationMatrices.<strong>multipleResolve2</strong>(T, v1);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns vectors&nbsp;v resolved in frame&nbsp;2 (=v2) from vectors&nbsp;v
resolved in frame&nbsp;1 (=v1) using the
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a>&nbsp;T
that describes the orientation to rotate frame&nbsp;1 into frame&nbsp;2.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.multipleResolve2\">Quaternions.multipleResolve2</a>.
</p>
</html>"));
end multipleResolve2;
