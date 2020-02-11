within Modelica.Mechanics.MultiBody.Types;
type Axis = Modelica.Icons.TypeReal[3](each final unit="1")
  "Axis vector with choices" annotation (
  preferredView="text",
  Evaluate=true,
  choices(
    choice={1,0,0} "{1,0,0} \"x axis\"",
    choice={0,1,0} "{0,1,0} \"y axis\"",
    choice={0,0,1} "{0,0,1} \"z axis\"",
    choice={-1,0,0} "{-1,0,0} \"negative x axis\"",
    choice={0,-1,0} "{0,-1,0} \"negative y axis\"",
    choice={0,0,-1} "{0,0,-1} \"negative z axis\""),
  Documentation(info="<html>
<p>
Type definition of an axis vector with scroll down menu that provides
the most often used axes vectors along the coordinate axes of a frame.
For an example see parameter \"n\" in model
<a href=\"modelica://Modelica.Mechanics.MultiBody.Joints.Revolute\">Joints.Revolute</a>.
</p>
</html>"));
