within Modelica.Mechanics.MultiBody.Frames;
function resolveDyade2
  "Transform second order tensor from frame 1 to frame 2"
  extends Modelica.Icons.Function;
  input Orientation R "Orientation object to rotate frame 1 into frame 2";
  input Real D1[3, 3] "Second order tensor resolved in frame 1";
  output Real D2[3, 3] "Second order tensor resolved in frame 2";
algorithm
  D2 := R.T*D1*transpose(R.T);
  annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
D2 = Frames.<strong>resolveDyade2</strong>(R, D1);
</pre></blockquote>

<h4>Description</h4>
<p>
The function call <code>Frames.<strong>Dyade2</strong>(R12, D1)</code> returns the second order tensor D
resolved in frame&nbsp;2 (= D2) from its representation in frame&nbsp;1 (= D1) using the
orientation object R12 that describes the orientation to rotate frame&nbsp;1 into frame&nbsp;2.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.resolveDyade2\">TransformationMatrices.resolveDyade2</a>.
</p>
</html>"));
end resolveDyade2;
