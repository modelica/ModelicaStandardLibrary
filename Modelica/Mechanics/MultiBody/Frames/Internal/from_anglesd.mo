within Modelica.Mechanics.MultiBody.Frames.Internal;
function from_anglesd "Return rotational velocity vector from derivatives of angles"
  import TM = Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
  extends Modelica.Icons.Function;

  input Integer sequence[3](
    min={1,1,1},
    max={3,3,3}) = {1,2,3}
    "Sequence of rotations from frame 1 to frame 2 along axis sequence[i]";
  input SI.Angle angles[3]
    "Rotation angles around the axes defined in 'sequence'";
  input SI.AngularVelocity der_angles[3] "= der(angles)";
  output SI.AngularVelocity w[3]
    "Relative angular velocity from frame 1 into frame 2, resolved in frame 1";

algorithm
  w := Frames.axis(sequence[3])*der_angles[3] +
    TM.resolve2(TM.axisRotation(sequence[3], angles[3]), Frames.axis(sequence[2])*der_angles[2]) +
    TM.resolve2(TM.axisRotation(sequence[3], angles[3])*TM.axisRotation(sequence[2], angles[2]),
                Frames.axis(sequence[1])*der_angles[1]);

  annotation (
    Documentation(info="<html>
<p>
This function returns angular velocity&nbsp;<code>w</code> computed from
1<sup>st</sup> derivatives of the rotation angles <code>angles</code>
to rotate frame&nbsp;1 into frame&nbsp;2 along axes given by
<code>sequence</code>.
</p>
</html>"));
end from_anglesd;
