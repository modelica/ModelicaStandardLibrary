within Modelica.Mechanics.MultiBody.Frames;
function resolve2 "Transform vector from frame 1 to frame 2"
  extends Modelica.Icons.Function;
  input Orientation R "Orientation object to rotate frame 1 into frame 2";
  input Real v1[3] "Vector in frame 1";
  output Real v2[3] "Vector in frame 2";
algorithm
  v2 := R.T*v1;
  annotation (derivative(noDerivative=R) = Internal.resolve2_der,
      InlineAfterIndexReduction=true,
    Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
v2 = Frames.<strong>resolve2</strong>(R, v1);
</pre></blockquote>

<h4>Description</h4>
<p>
The function call <code>Frames.<strong>resolve2</strong>(R12, v1)</code> returns vector v
resolved in frame&nbsp;2 (= v2) from vector v resolved in frame&nbsp;1 (= v1) using the
orientation object R12 that describes the orientation  to rotate frame&nbsp;1 into frame&nbsp;2.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.resolve1\">resolve1</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.resolve2\">TransformationMatrices.resolve2</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.resolve2\">Quaternions.resolve2</a>.
</p>
</html>"));
end resolve2;
