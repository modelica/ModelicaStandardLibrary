within Modelica.Mechanics.MultiBody.Frames.Quaternions;
function resolve2 "Transform vector from frame 1 to frame 2"
  extends Modelica.Icons.Function;
  input Quaternions.Orientation Q
    "Quaternions orientation object to rotate frame 1 into frame 2";
  input Real v1[3] "Vector in frame 1";
  output Real v2[3] "Vector in frame 2";
algorithm
  v2 := 2*((Q[4]*Q[4] - 0.5)*v1 + (Q[1:3]*v1)*Q[1:3] - Q[4]*cross(Q[1:3],
    v1));
  annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
v2 = Quaternions.<strong>resolve2</strong>(Q, v1);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns vector&nbsp;v resolved in frame&nbsp;2 (=v2) from vector&nbsp;v
resolved in frame&nbsp;1 (=v1) using the
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.Orientation\">quaternions orientation</a>&nbsp;Q
that describes the orientation to rotate frame&nbsp;1 into frame&nbsp;2.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.resolve1\">resolve1</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.resolve2\">Frames.resolve2</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.resolve2\">TransformationMatrices.resolve2</a>.
</p>
</html>"));
end resolve2;
