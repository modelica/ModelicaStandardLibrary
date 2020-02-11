within Modelica.Mechanics.MultiBody.Types;
type RotationTypes = enumeration(
    RotationAxis "Rotating frame_a around an angle with a fixed axis",
    TwoAxesVectors "Resolve two vectors of frame_b in frame_a",
    PlanarRotationSequence "Planar rotation sequence")
  "Enumeration defining in which way the fixed orientation of frame_b with respect to frame_a is specified"
    annotation (
      Documentation(Evaluate=true, info="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th><strong>Types.RotationTypes.</strong></th><th><strong>Meaning</strong></th></tr>
<tr><td>RotationAxis</td>
    <td>frame_b is defined by rotating the coordinate system along
        an axis fixed in frame_a and with a fixed angle.</td></tr>

<tr><td>TwoAxesVectors</td>
    <td>frame_b is defined by resolving two vectors of frame_b in frame_a.</td></tr>

<tr><td>PlanarRotationSequence</td>
    <td>frame_b is defined by rotating the coordinate system along
        3 consecutive axes vectors with fixed rotation angles
        (e.g., Cardan or Euler angle sequence rotation).</td></tr>
</table>
</html>"));
