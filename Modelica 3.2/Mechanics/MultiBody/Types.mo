within Modelica.Mechanics.MultiBody;
package Types "Constants and types with choices, especially to build menus"
  extends Modelica.Icons.Package;

  type Axis = Modelica.Icons.TypeReal[3](each final unit="1")
    "Axis vector with choices for menus"                                      annotation (
    preferedView="text",
    Evaluate=true,
    choices(
      choice={1,0,0} "{1,0,0} \"x axis\"",
      choice={0,1,0} "{0,1,0} \"y axis\"",
      choice={0,0,1} "{0,0,1} \"z axis\"",
      choice={-1,0,0} "{-1,0,0} \"negative x axis\"",
      choice={0,-1,0} "{0,-1,0} \"negative y axis\"",
      choice={0,0,-1} "{0,0,-1} \"negative z axis\""),
    Documentation(info="<html>
</html>"));

  type AxisLabel = Modelica.Icons.TypeString
    "Label of axis with choices for menus"                                          annotation (
      preferedView="text", choices(
      choice="x" "x",
      choice="y" "y",
      choice="z" "z"));

  type RotationSequence = Modelica.Icons.TypeInteger[3] (min={1,1,1}, max={3,3,3})
    "Sequence of planar frame rotations with choices for menus" annotation (
    preferedView="text",
    Evaluate=true,
    choices(
      choice={1,2,3} "{1,2,3} \"Cardan/Tait-Bryan angles\"",
      choice={3,1,3} "{3,1,3} \"Euler angles\"",
      choice={3,2,1} "{3,2,1}"));

  type Color = Modelica.Icons.TypeInteger[3] (each min=0, each max=255)
    "RGB representation of color (will be improved with a color editor)"
    annotation (
      Dialog(colorSelector),
      choices(
        choice={0,0,0} "{0,0,0}       \"black\"",
        choice={155,0,0} "{155,0,0}     \"dark red\"",
        choice={255,0,0} "{255,0,0 }    \"red\"",
        choice={255,65,65} "{255,65,65}   \"light red\"",
        choice={0,128,0} "{0,128,0}     \"dark green\"",
        choice={0,180,0} "{0,180,0}     \"green\"",
        choice={0,230,0} "{0,230,0}     \"light green\"",
        choice={0,0,200} "{0,0,200}     \"dark blue\"",
        choice={0,0,255} "{0,0,255}     \"blue\"",
        choice={0,128,255} "{0,128,255}   \"light blue\"",
        choice={255,255,0} "{255,255,0}   \"yellow\"",
        choice={255,0,255} "{255,0,255}   \"pink\"",
        choice={100,100,100} "{100,100,100} \"dark grey\"",
        choice={155,155,155} "{155,155,155} \"grey\"",
        choice={255,255,255} "{255,255,255} \"white\""),
    Documentation(info="<html>
<p>
Type <b>Color</b> is an Integer vector with 3 elements,
{r, g, b}, and specifies the color of a shape.
{r,g,b} are the \"red\", \"green\" and \"blue\" color parts.
Note, r g, b are given in the range 0 .. 255.
</p>
</html>"));
  type RealColor =
               Modelica.Icons.TypeReal[3] (each min=0, each max=255)
    "RGB representation of color as Real type "
    annotation (
      Dialog(colorSelector),
      choices(
        choice={0,0,0} "{0,0,0}       \"black\"",
        choice={155,0,0} "{155,0,0}     \"dark red\"",
        choice={255,0,0} "{255,0,0 }    \"red\"",
        choice={255,65,65} "{255,65,65}   \"light red\"",
        choice={0,128,0} "{0,128,0}     \"dark green\"",
        choice={0,180,0} "{0,180,0}     \"green\"",
        choice={0,230,0} "{0,230,0}     \"light green\"",
        choice={0,0,200} "{0,0,200}     \"dark blue\"",
        choice={0,0,255} "{0,0,255}     \"blue\"",
        choice={0,128,255} "{0,128,255}   \"light blue\"",
        choice={255,255,0} "{255,255,0}   \"yellow\"",
        choice={255,0,255} "{255,0,255}   \"pink\"",
        choice={100,100,100} "{100,100,100} \"dark grey\"",
        choice={155,155,155} "{155,155,155} \"grey\"",
        choice={255,255,255} "{255,255,255} \"white\""),
    Documentation(info="<html>
<p>
Type <b>Color</b> is an Real vector with 3 elements,
{r, g, b}, and specifies the color of a shape.
{r,g,b} are the \"red\", \"green\" and \"blue\" color parts.
Note, r g, b are given in the range 0 .. 255.
</p>
</html>"));
  type SpecularCoefficient = Modelica.Icons.TypeReal
    "Reflection of ambient light (= 0: light is completely absorbed)"
       annotation ( min=0,
         choices(choice=0 "\"0.0 (dull)\"",choice=0.7 "\"0.7 (medium)\"", choice=1
        "\"1.0 (glossy)\""),
    Documentation(info="<html>
<p>
Type <b>SpecularCoefficient</b> defines the reflection of
ambient light on shape surfaces. If value = 0, the light
is completely absorbed. Often, 0.7 is a reasonable value.
It might be that from some viewing directions, a body is no
longer visible, if the SpecularCoefficient value is too high.
In the following image, the different values of SpecularCoefficient
are shown for a cylinder:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/MultiBody/Visualizers/SpecularCoefficient.png\"
</p>
</html>"));
  type ShapeType = Modelica.Icons.TypeString
    "Type of shape (box, sphere, cylinder, pipecylinder, cone, pipe, beam, gearwheel, spring, dxf-file)"
     annotation ( choices(
      choice="box" "\"box\"",
      choice="sphere" "\"sphere\"",
      choice="cylinder" "\"cylinder\"",
      choice="pipecylinder" "\"pipecylinder\"",
      choice="cone" "\"cone\"",
      choice="pipe" "\"pipe\"",
      choice="beam" "\"beam\"",
      choice="gearwheel" "\"gearwheel\"",
      choice="spring" "\"spring\"",
      choice="1" "File \"1.dxf\" in current directory",
      choice="2" "File \"2.dxf\" in current directory",
      choice="3" "File \"3.dxf\" in current directory",
      choice="4" "File \"4.dxf\" in current directory",
      choice="5" "File \"5.dxf\" in current directory",
      choice="6" "File \"6.dxf\" in current directory",
      choice="7" "File \"7.dxf\" in current directory",
      choice="8" "File \"8.dxf\" in current directory",
      choice="9" "File \"9.dxf\" in current directory"),
    Documentation(info="<html>
<p>
Type <b>ShapeType</b> is used to define the shape of the
visual object as parameter String. Usually, \"shapeType\" is used
as instance name. The following
values for shapeType are possible, e.g., shapeType=\"box\":
</p>
<IMG src=\"modelica://Modelica/Resources/Images/MultiBody/Shape.png\" ALT=\"model Visualizers.FixedShape\">
<p>&nbsp;<br>
The dark blue arrows in the figure above are directed along
variable <b>lengthDirection</b>. The light blue arrows are directed
along variable <b>widthDirection</b>. The <b>coordinate systems</b>
in the figure represent frame_a of the Shape component.
</p>
<p>
Additionally, external shapes are specified as DXF-files
(only 3-dim.Face is supported). External shapes must be named \"1\", \"2\"
etc.. The corresponding definitions should be in files \"1.dxf\",
\"2.dxf\" etc.Since the DXF-files contain color and dimensions for
the individual faces, the corresponding information in the model
is currently ignored. The DXF-files must be found either in the current
directory or in the directory where the Shape instance is stored
that references the DXF file.
</p>
</html>"));
  type ShapeExtra = Modelica.Icons.TypeReal
    "Reflection of ambient light (= 0: light is completely absorbed)"
       annotation ( min=0,
    Documentation(info="<html>
<p>
This type is used in shapes of visual objects to define
extra data depending on the shape type. Usually, input
variable <b>extra</b> is used as instance name:
</p>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th><b>shapeType</b></th><th>Meaning of variable <b>extra</b></th></tr>
<tr>
  <td valign=\"top\">\"cylinder\"</td>
  <td valign=\"top\">if extra &gt; 0, a black line is included in the
      cylinder to show the rotation of it.</td>
</tr>
<tr>
  <td valign=\"top\">\"cone\"</td>
  <td valign=\"top\">extra = diameter-left-side / diameter-right-side, i.e.,<br>
      extra = 1: cylinder<br>
      extra = 0: \"real\" cone.</td>
</tr>
<tr>
  <td valign=\"top\">\"pipe\"</td>
  <td valign=\"top\">extra = outer-diameter / inner-diameter, i.e, <br>
      extra = 1: cylinder that is completely hollow<br>
      extra = 0: cylinder without a hole.</td>
</tr>
<tr>
  <td valign=\"top\">\"gearwheel\"</td>
  <td valign=\"top\">extra is the number of teeth of the gear.</td>
</tr>
<tr>
  <td valign=\"top\">\"spring\"</td>
  <td valign=\"top\">extra is the number of windings of the spring.
      Additionally, \"height\" is <b>not</b> the \"height\" but
      2*coil-width.</td>
</tr>
</table>
</html>"));

  type ResolveInFrameA = enumeration(
      world "Resolve in world frame",
      frame_a "Resolve in frame_a",
      frame_resolve
        "Resolve in frame_resolve (frame_resolve must be connected)")
    "Enumeration to define the frame in which an absolute vector is resolved (world, frame_a, frame_resolve)"
                                               annotation (Documentation(info="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th><b>Types.ResolveInFrameA.</b></th><th><b>Meaning</b></th></tr>
<tr><td valign=\"top\">world</td>
    <td valign=\"top\">Resolve vector in world frame</td></tr>

<tr><td valign=\"top\">frame_a</td>
    <td valign=\"top\">Resolve vector in frame_a</td></tr>

<tr><td valign=\"top\">frame_resolve</td>
    <td valign=\"top\">Resolve vector in frame_resolve (frame_resolve must be connected)</td></tr>
</table>
</html>"));
  type ResolveInFrameB = enumeration(
      world "Resolve in world frame",
      frame_b "Resolve in frame_b",
      frame_resolve
        "Resolve in frame_resolve (frame_resolve must be connected)")
    "Enumeration to define the frame in which an absolute vector is resolved (world, frame_b, frame_resolve)"
                                               annotation (Documentation(info="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th><b>Types.ResolveInFrameB.</b></th><th><b>Meaning</b></th></tr>
<tr><td valign=\"top\">world</td>
    <td valign=\"top\">Resolve vector in world frame</td></tr>

<tr><td valign=\"top\">frame_b</td>
    <td valign=\"top\">Resolve vector in frame_b</td></tr>

<tr><td valign=\"top\">frame_resolve</td>
    <td valign=\"top\">Resolve vector in frame_resolve (frame_resolve must be connected)</td></tr>
</table>
</html>"));
  type ResolveInFrameAB = enumeration(
      world "Resolve in world frame",
      frame_a "Resolve in frame_a",
      frame_b "Resolve in frame_b",
      frame_resolve
        "Resolve in frame_resolve (frame_resolve must be connected)")
    "Enumeration to define the frame in which a relative vector is resolved (world, frame_a, frame_b, frame_resolve)"
                                               annotation (Documentation(info="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th><b>Types.ResolveInFrameAB.</b></th><th><b>Meaning</b></th></tr>
<tr><td valign=\"top\">world</td>
    <td valign=\"top\">Resolve vector in world frame</td></tr>

<tr><td valign=\"top\">frame_a</td>
    <td valign=\"top\">Resolve vector in frame_a</td></tr>

<tr><td valign=\"top\">frame_b</td>
    <td valign=\"top\">Resolve vector in frame_b</td></tr>

<tr><td valign=\"top\">frame_resolve</td>
    <td valign=\"top\">Resolve vector in frame_resolve (frame_resolve must be connected)</td></tr>
</table>
</html>"));

  type RotationTypes = enumeration(
      RotationAxis "Rotating frame_a around an angle with a fixed axis",
      TwoAxesVectors "Resolve two vectors of frame_b in frame_a",
      PlanarRotationSequence "Planar rotation sequence")
    "Enumeration defining in which way the fixed orientation of frame_b with respect to frame_a is specified"
      annotation (Evaluate=true,
        Documentation(info="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th><b>Types.RotationTypes.</b></th><th><b>Meaning</b></th></tr>
<tr><td valign=\"top\">RotationAxis</td>
    <td valign=\"top\">frame_b is defined by rotating the coordinate system along
        an axis fixed in frame_a and with a fixed angle.</td></tr>

<tr><td valign=\"top\">TwoAxesVectors</td>
    <td valign=\"top\">frame_b is defined by resolving two vectors of frame_b in frame_a.</td></tr>

<tr><td valign=\"top\">PlanarRotationSequence</td>
    <td valign=\"top\">frame_b is defined by rotating the coordinate system along
        3 consecutive axes vectors with fixed rotation angles
        (e.g., Cardan or Euler angle sequence rotation).</td></tr>
</table>
</html>"));

  type GravityTypes = enumeration(
      NoGravity "No gravity field",
      UniformGravity "Uniform gravity field",
      PointGravity "Point gravity field")
    "Enumeration defining the type of the gravity field"
      annotation (Documentation(info="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th><b>Types.GravityTypes.</b></th><th><b>Meaning</b></th></tr>
<tr><td valign=\"top\">NoGravity</td>
    <td valign=\"top\">No gravity field</td></tr>

<tr><td valign=\"top\">UniformGravity</td>
    <td valign=\"top\">Gravity field is described by a vector of constant gravity acceleration</td></tr>

<tr><td valign=\"top\">PointGravity</td>
    <td valign=\"top\">Central gravity field. The gravity acceleration vector is directed to
        the field center and the gravity is proportional to 1/r^2, where
        r is the distance to the field center.</td></tr>
</table>
</html>"));

type Init = enumeration(
      Free,
      PositionVelocity,
      SteadyState,
      Position,
      Velocity,
      VelocityAcceleration,
      PositionVelocityAcceleration);

  package Defaults "Default settings of the MultiBody library via constants"
    extends Modelica.Icons.Package;

    // Color defaults
    constant Types.Color BodyColor={0,128,255}
      "Default color for body shapes that have mass (light blue)";
    constant Types.Color RodColor={155,155,155}
      "Default color for massless rod shapes (grey)";
    constant Types.Color JointColor={255,0,0}
      "Default color for elementary joints (red)";
    constant Types.Color ForceColor={0,128,0}
      "Default color for force arrow (dark green)";
    constant Types.Color TorqueColor={0,128,0}
      "Default color for torque arrow (dark green)";
    constant Types.Color SpringColor={0,0,255}
      "Default color for a spring (blue)";
    constant Types.Color SensorColor={255,255,0}
      "Default color for sensors (yellow)";
    constant Types.Color FrameColor={0,0,0}
      "Default color for frame axes and labels (black)";
    constant Types.Color ArrowColor={0,0,255}
      "Default color for arrows and double arrows (blue)";

    // Arrow and frame defaults
    constant Real FrameHeadLengthFraction=5.0
      "Frame arrow head length / arrow diameter";
    constant Real FrameHeadWidthFraction=3.0
      "Frame arrow head width / arrow diameter";
    constant Real FrameLabelHeightFraction=3.0
      "Height of frame label / arrow diameter";
    constant Real ArrowHeadLengthFraction=4.0
      "Arrow head length / arrow diameter";
    constant Real ArrowHeadWidthFraction=3.0
      "Arrow head width / arrow diameter";

    // Other defaults
    constant SI.Diameter BodyCylinderDiameterFraction=3
      "Default for body cylinder diameter as a fraction of body sphere diameter";
    constant Real JointRodDiameterFraction=2
      "Default for rod diameter as a fraction of joint sphere diameter attached to rod";

    /*
  constant Real N_to_m(unit="N/m") = 1000
    "Default force arrow scaling (length = force/N_to_m_default)";
  constant Real Nm_to_m(unit="N.m/m") = 1000
    "Default torque arrow scaling (length = torque/Nm_to_m_default)";
*/
    annotation ( Documentation(info="<html>
<p>
This package contains constants used as default setting
in the MultiBody library.
</p>
</html>"));
  end Defaults;

  annotation ( Documentation(info="<HTML>
<p>
In this package <b>types</b> and <b>constants</b> are defined that are used in the
MultiBody library. The types have additional annotation choices
definitions that define the menus to be built up in the graphical
user interface when the type is used as parameter in a declaration.
</p>
</HTML>"));
end Types;
