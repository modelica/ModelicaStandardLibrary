within Modelica.Mechanics.MultiBody.Frames;
function resolveDyade1
  "Transform second order tensor from frame 2 to frame 1"
  extends Modelica.Icons.Function;
  input Orientation R "Orientation object to rotate frame 1 into frame 2";
  input Real D2[3, 3] "Second order tensor resolved in frame 2";
  output Real D1[3, 3] "Second order tensor resolved in frame 1";
algorithm
  D1 := transpose(R.T)*D2*R.T;
  annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
D1 = Frames.<strong>resolveDyade1</strong>(R, D2);
</pre></blockquote>

<h4>Description</h4>
<p>
The function call <code>Frames.<strong>Dyade1</strong>(R12, D2)</code> returns the second order tensor D
resolved in frame&nbsp;1 (= D1) from its representation in frame&nbsp;2 (= D2) using the
orientation object R12 that describes the orientation to rotate frame&nbsp;1 into frame&nbsp;2.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.resolveDyade1\">TransformationMatrices.resolveDyade1</a>.
</p>
</html>"));
end resolveDyade1;
