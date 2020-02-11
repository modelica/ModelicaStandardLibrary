within Modelica.Mechanics.MultiBody.Frames;
function to_vector "Map rotation object into vector"
  extends Modelica.Icons.Function;
  input Orientation R "Orientation object to rotate frame 1 into frame 2";
  output Real vec[9] "Elements of R in one vector";
algorithm
  vec := {R.T[1, 1],R.T[2, 1],R.T[3, 1],R.T[1, 2],R.T[2, 2],R.T[3, 2],R.T[1,
    3],R.T[2, 3],R.T[3, 3]};
  annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
vec = Frames.<strong>to_vector</strong>(R);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns a vector vec which contains elements of a transformation matrix&nbsp;T
computed from an
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Orientation\">orientation object</a>&nbsp;R.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.to_T\">to_T</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.to_vector\">TransformationMatrices.to_vector</a>.
</p>
</html>"));
end to_vector;
