within Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
function to_T "Return transformation matrix T from orientation object R"
  extends Modelica.Icons.Function;
  input TransformationMatrices.Orientation R
    "Orientation object to rotate frame 1 into frame 2";
  output Real T[3, 3]
    "Transformation matrix to transform vector from frame 1 to frame 2 (v2=T*v1)";
algorithm
  T := R;
  annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
T = TransformationMatrices.<strong>to_T</strong>(R);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns a real matrix&nbsp;T which is equal to a
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Orientation\">transformation matrix</a>&nbsp;R.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.from_T\">from_T</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.to_T_inv\">to_T_inv</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.to_T\">Frames.to_T</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.to_T\">Quaternions.to_T</a>.
</p>
</html>"));
end to_T;
