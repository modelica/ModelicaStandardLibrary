within Modelica.Mechanics.MultiBody.Frames.Quaternions;
function orientationConstraint
  "Return residues of orientation constraints (shall be zero)"
  extends Modelica.Icons.Function;
  input Quaternions.Orientation Q
    "Quaternions orientation object to rotate frame 1 into frame 2";
  output Real residue[1] "Residue constraint (shall be zero)";
algorithm
  residue := {Q*Q - 1};
  annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
residue = Quaternions.<strong>orientationConstraint</strong>(Q);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns the Real residue vector with&nbsp;1 element only that describes the constraints
between the&nbsp;4 elements of the
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.Orientation\">quaternions orientation</a>&nbsp;Q.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.orientationConstraint\">Frames.orientationConstraint</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.orientationConstraint\">TransformationMatrices.orientationConstraint</a>.
</p>
</html>"));
end orientationConstraint;
