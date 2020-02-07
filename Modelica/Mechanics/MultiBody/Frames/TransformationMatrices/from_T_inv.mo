within Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
function from_T_inv
  "Return orientation object R from inverse transformation matrix T_inv"

  extends Modelica.Icons.Function;
  input Real T_inv[3, 3]
    "Inverse transformation matrix to transform vector from frame 2 to frame 1 (v1=T_inv*v2)";
  output TransformationMatrices.Orientation R
    "Orientation object to rotate frame 1 into frame 2";
algorithm
  R := transpose(T_inv);
  annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
R = TransformationMatrices.<strong>from_T_inv</strong>(T_inv);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns a
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a>&nbsp;R
which is inverse to real input matrix T_inv.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.to_T_inv\">to_T_inv</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.from_T\">from_T</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.from_T_inv\">Frames.from_T_inv</a>.
</p>
</html>"));
end from_T_inv;
