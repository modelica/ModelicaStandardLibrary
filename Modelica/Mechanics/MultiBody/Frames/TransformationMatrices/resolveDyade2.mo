within Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
function resolveDyade2
  "Transform second order tensor from frame 1 to frame 2"
  extends Modelica.Icons.Function;
  input TransformationMatrices.Orientation T
    "Orientation object to rotate frame 1 into frame 2";
  input Real D1[3, 3] "Second order tensor resolved in frame 1";
  output Real D2[3, 3] "Second order tensor resolved in frame 2";
algorithm
  D2 := T*D1*transpose(T);
  annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
D2 = TransformationMatrices.<strong>resolveDyade2</strong>(T, D1);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns the second order tensor&nbsp;D
resolved in frame&nbsp;2 (= D2) from its representation in frame&nbsp;1 (= D1) using the
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a>&nbsp;T
that describes the orientation to rotate frame&nbsp;1 into frame&nbsp;2.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.resolveDyade2\">Frames.resolveDyade2</a>.
</p>
</html>"));
end resolveDyade2;
