within Modelica.Mechanics.MultiBody.Forces.Internal;
function standardGravityAcceleration
  "Standard gravity fields (no/parallel/point field)"
  extends Modelica.Icons.Function;
  extends Modelica.Mechanics.MultiBody.Interfaces.partialGravityAcceleration;
  import Modelica.Mechanics.MultiBody.Types.GravityTypes;
  input GravityTypes gravityType "Type of gravity field" annotation(Dialog);
  input SI.Acceleration g[3]
    "Constant gravity acceleration, resolved in world frame, if gravityType=UniformGravity"
    annotation(Dialog);
  input Real mu(unit="m3/s2")
    "Field constant of point gravity field, if gravityType=PointGravity" annotation(Dialog);
algorithm
gravity := if gravityType == GravityTypes.UniformGravity then g else
           if gravityType == GravityTypes.PointGravity then
              -(mu/(r*r))*(r/Modelica.Math.Vectors.length(r)) else zeros(3);
  annotation(Inline=true, Documentation(info="<html>
<p>
This function defines the standard gravity fields for the World object.
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td><strong><em>gravityType</em></strong></td>
    <td><strong><em>gravity [m/s2]</em></strong></td>
    <td><strong><em>description</em></strong></td></tr>
<tr><td>Types.GravityType.NoGravity</td>
    <td>= {0,0,0}</td>
    <td>No gravity</td></tr>

<tr><td>Types.GravityType.UniformGravity</td>
    <td>= g</td>
    <td> Constant parallel gravity field</td></tr>

<tr><td>Types.GravityType.PointGravity</td>
    <td>= -(mu/(r*r))*r/|r|</td>
    <td> Point gravity field with spherical mass</td></tr>
</table>

</html>"));
end standardGravityAcceleration;
