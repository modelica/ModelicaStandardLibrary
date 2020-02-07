within Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
function to_T_inv
  "Return inverse transformation matrix T_inv from orientation object R"

  extends Modelica.Icons.Function;
  input TransformationMatrices.Orientation R
    "Orientation object to rotate frame 1 into frame 2";
  output Real T_inv[3, 3]
    "Inverse transformation matrix to transform vector from frame 2 into frame 1 (v1=T_inv*v2)";
algorithm
  T_inv := transpose(R);
  annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
T_inv = TransformationMatrices.<strong>to_T_inv</strong>(R);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns a real matrix&nbsp;T_inv
which is inverse to a
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a>&nbsp;R.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.from_T_inv\">from_T_inv</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.to_T\">to_T</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.to_T_inv\">Frames.to_T_inv</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.to_T_inv\">Quaternions.to_T_inv</a>.
</p>
</html>"));
end to_T_inv;
