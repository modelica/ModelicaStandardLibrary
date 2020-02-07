within Modelica.Mechanics.MultiBody.Frames;
function orientationConstraint
  "Return residues of orientation constraints (shall be zero)"
  extends Modelica.Icons.Function;
  input Orientation R "Orientation object to rotate frame 1 into frame 2";
  output Real residue[6]
    "Residues of constraints between elements of orientation object (shall be zero)";
algorithm
  residue := {R.T[:, 1]*R.T[:, 1] - 1,R.T[:, 2]*R.T[:, 2] - 1,R.T[:, 3]*R.T[:,
     3] - 1,R.T[:, 1]*R.T[:, 2],R.T[:, 1]*R.T[:, 3],R.T[:, 2]*R.T[:, 3]};
  annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
residue = Frames.<strong>orientationConstraint</strong>(R);
</pre></blockquote>

<h4>Description</h4>
<p>
The function call <code>Frames.<strong>orientationConstraint</strong>(R)</code> returns the Real residue vector
with&nbsp;6 elements that describes the constraints between the&nbsp;9 elements of the orientation matrix.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.orientationConstraint\">TransformationMatrices.orientationConstraint</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.orientationConstraint\">Quaternions.orientationConstraint</a>.
</p>
</html>"));
end orientationConstraint;
