within Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
function orientationConstraint
  "Return residues of orientation constraints (shall be zero)"
  extends Modelica.Icons.Function;
  input TransformationMatrices.Orientation T
    "Orientation object to rotate frame 1 into frame 2";
  output Real residue[6]
    "Residues of constraints between elements of orientation object (shall be zero)";
algorithm
  residue := {T[:, 1]*T[:, 1] - 1,T[:, 2]*T[:, 2] - 1,T[:, 3]*T[:, 3] - 1,T[
    :, 1]*T[:, 2],T[:, 1]*T[:, 3],T[:, 2]*T[:, 3]};
  annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
residue = TransformationMatrices.<strong>orientationConstraint</strong>(T);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns the Real residue vector with&nbsp;6 elements that describes the constraints
between the&nbsp;9 elements of the
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a>&nbsp;T.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.orientationConstraint\">Frames.orientationConstraint</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.orientationConstraint\">Quaternions.orientationConstraint</a>.
</p>
</html>"));
end orientationConstraint;
