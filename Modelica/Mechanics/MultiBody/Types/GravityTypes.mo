within Modelica.Mechanics.MultiBody.Types;
type GravityTypes = enumeration(
    NoGravity "No gravity field",
    UniformGravity "Uniform gravity field",
    PointGravity "Point gravity field")
  "Enumeration defining the type of the gravity field"
    annotation (Documentation(info="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th><strong>Types.GravityTypes.</strong></th><th><strong>Meaning</strong></th></tr>
<tr><td>NoGravity</td>
    <td>No gravity field</td></tr>

<tr><td>UniformGravity</td>
    <td>Gravity field is described by a vector of constant gravity acceleration</td></tr>

<tr><td>PointGravity</td>
    <td>Central gravity field. The gravity acceleration vector is directed to
        the field center and the gravity is proportional to 1/r^2, where
        r is the distance to the field center.</td></tr>
</table>
</html>"));
