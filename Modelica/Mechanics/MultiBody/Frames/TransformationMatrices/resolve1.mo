within Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
function resolve1 "Transform vector from frame 2 to frame 1"
  extends Modelica.Icons.Function;
  input TransformationMatrices.Orientation T
    "Orientation object to rotate frame 1 into frame 2";
  input Real v2[3] "Vector in frame 2";
  output Real v1[3] "Vector in frame 1";
algorithm
  v1 := transpose(T)*v2;
  annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
v1 = TransformationMatrices.<strong>resolve1</strong>(T, v2);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns vector&nbsp;v resolved in frame&nbsp;1 (=v1) from vector&nbsp;v
resolved in frame&nbsp;2 (=v2) using the
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a>&nbsp;T
that describes the orientation to rotate frame&nbsp;1 into frame&nbsp;2.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.resolve2\">resolve2</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.resolve1\">Frames.resolve1</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.resolve1\">Quaternions.resolve1</a>.
</p>
</html>"));
end resolve1;
