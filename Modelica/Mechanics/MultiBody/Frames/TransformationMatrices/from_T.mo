within Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
function from_T "Return orientation object R from transformation matrix T"
  extends Modelica.Icons.Function;
  input Real T[3, 3]
    "Transformation matrix to transform vector from frame 1 to frame 2 (v2=T*v1)";
  output TransformationMatrices.Orientation R
    "Orientation object to rotate frame 1 into frame 2";
algorithm
  R := T;
  annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
R = TransformationMatrices.<strong>from_T</strong>(T);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns a
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a>&nbsp;R
which is equal to a real input matrix&nbsp;T.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.from_T_inv\">from_T_inv</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.to_T\">to_T</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.from_T\">Frames.from_T</a>.
</p>
</html>"));
end from_T;
