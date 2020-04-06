within Modelica.Mechanics.MultiBody.Types;
type VectorQuantity = enumeration(
    Force "Force quantity",
    Torque "Torque quantity",
    Velocity "Velocity quantity",
    Acceleration "Acceleration quantity",
    AngularVelocity "Angular velocity quantity",
    AngularAcceleration "Angular acceleration quantity",
    RelativePosition "Relative position")
  "Enumeration defining the kind of physical quantity represented by the vector"
    annotation (Documentation(info="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th><strong>Types.VectorQuantity.</strong></th><th><strong>Meaning</strong></th></tr>
<tr><td>Force</td>
    <td>Vector represents a force quantity</td></tr>

<tr><td>Torque</td>
    <td>Vector represents a torque quantity</td></tr>

<tr><td>Velocity</td>
    <td>Vector represents a velocity quantity</td></tr>

<tr><td>Acceleration</td>
    <td>Vector represents an acceleration quantity</td></tr>

<tr><td>AngularVelocity</td>
    <td>Vector represents an angular velocity quantity</td></tr>

<tr><td>AngularAcceleration</td>
    <td>Vector represents an angular acceleration quantity</td></tr>

<tr><td>RelativePosition</td>
    <td>Vector represents the relative position</td></tr>
</table>
</html>"));
