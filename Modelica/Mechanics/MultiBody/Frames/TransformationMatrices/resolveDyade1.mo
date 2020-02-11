within Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
function resolveDyade1
  "Transform second order tensor from frame 2 to frame 1"
  extends Modelica.Icons.Function;
  input TransformationMatrices.Orientation T
    "Orientation object to rotate frame 1 into frame 2";
  input Real D2[3, 3] "Second order tensor resolved in frame 2";
  output Real D1[3, 3] "Second order tensor resolved in frame 1";
algorithm
  D1 := transpose(T)*D2*T;
  annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
D1 = TransformationMatrices.<strong>resolveDyade1</strong>(T, D2);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns the second order tensor&nbsp;D
resolved in frame&nbsp;1 (= D1) from its representation in frame&nbsp;2 (= D2) using the
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a>&nbsp;T
that describes the orientation to rotate frame&nbsp;1 into frame&nbsp;2.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.resolveDyade1\">Frames.resolveDyade1</a>.
</p>
</html>"));
end resolveDyade1;
