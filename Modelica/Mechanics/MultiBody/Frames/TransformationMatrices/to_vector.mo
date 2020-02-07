within Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
function to_vector "Map rotation object into vector"
  extends Modelica.Icons.Function;
  input TransformationMatrices.Orientation T
    "Orientation object to rotate frame 1 into frame 2";
  output Real vec[9] "Elements of T in one vector";
algorithm
  vec := {T[1, 1],T[2, 1],T[3, 1],T[1, 2],T[2, 2],T[3, 2],T[1, 3],T[2, 3],T[
    3, 3]};
  annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
vec = TransformationMatrices.<strong>to_vector</strong>(T);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns a vector vec which contains elements of a
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a>&nbsp;T.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.to_T\">to_T</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.to_vector\">Frames.to_vector</a>.
</p>
</html>"));
end to_vector;
