within Modelica.Mechanics.MultiBody.Frames;
function to_T_inv
  "Return inverse transformation matrix T_inv from orientation object R"

  extends Modelica.Icons.Function;
  input Orientation R "Orientation object to rotate frame 1 into frame 2";
  output Real T_inv[3, 3]
    "Inverse transformation matrix to transform vector from frame 2 into frame 1 (v1=T_inv*v2)";
algorithm
  T_inv := transpose(R.T);
  annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
T_inv = Frames.<strong>to_T_inv</strong>(R);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns a real matrix T_inv
<!--<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a>&nbsp;T_inv-->
computed from an
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Orientation\">orientation object</a>&nbsp;R.
The matrix T_inv is considered to be an inverse transformation matrix.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.from_T_inv\">from_T_inv</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.to_T\">to_T</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.to_T_inv\">TransformationMatrices.to_T_inv</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.to_T_inv\">Quaternions.to_T_inv</a>.
</p>
</html>"));
end to_T_inv;
