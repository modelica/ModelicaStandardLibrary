within Modelica.Mechanics.MultiBody.Frames;
function axesRotations
  "Return fixed rotation object to rotate in sequence around fixed angles along 3 axes"

  import TM = Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
  extends Modelica.Icons.Function;
  input Integer sequence[3](
    min={1,1,1},
    max={3,3,3}) = {1,2,3}
    "Sequence of rotations from frame 1 to frame 2 along axis sequence[i]";
  input SI.Angle angles[3]
    "Rotation angles around the axes defined in 'sequence'";
  input SI.AngularVelocity der_angles[3] "= der(angles)";
  output Orientation R "Orientation object to rotate frame 1 into frame 2";
algorithm
  /*
  R := absoluteRotation(absoluteRotation(axisRotation(sequence[1], angles[1],
    der_angles[1]), axisRotation(sequence[2], angles[2], der_angles[2])),
    axisRotation(sequence[3], angles[3], der_angles[3]));
*/
  R := Orientation(T=TM.axisRotation(sequence[3], angles[3])*TM.axisRotation(sequence[2], angles[2])*TM.axisRotation(sequence[1], angles[1]), w=Frames.axis(sequence[3])*der_angles[3] + TM.resolve2(TM.axisRotation(sequence[3], angles[3]), Frames.axis(sequence[2])*der_angles[2]) + TM.resolve2(TM.axisRotation(sequence[3], angles[3])*TM.axisRotation(sequence[2], angles[2]), Frames.axis(sequence[1])*der_angles[1]));
  annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
R = Frames.<strong>axesRotations</strong>(sequence, angles, der_angles);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Orientation\">orientation object</a>&nbsp;R
that describes the orientation defined by three elementary rotations in
a given <strong>sequence</strong>, each rotated by <strong>angles</strong>.
The angular velocity vector R.w is calculated from the angle derivatives
<strong>der_angles</strong>.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.axesRotations\">TransformationMatrices.axesRotations</a>.
</p>
</html>"));
end axesRotations;
