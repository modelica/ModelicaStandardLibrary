within Modelica.Mechanics.MultiBody;
package Types "Constants and types with choices, especially to build menus"
  extends Modelica.Icons.TypesPackage;

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

  type AxisLabel = Modelica.Icons.TypeString
    "Label of axis with choices" annotation (
      preferredView="text", choices(
      choice="x" "\"x\"",
      choice="y" "\"y\"",
      choice="z" "\"z\""));

  type RotationSequence = Modelica.Icons.TypeInteger[3] (min={1,1,1}, max={3,3,3})
    "Sequence of planar frame rotations with choices" annotation (
    preferredView="text",
    Evaluate=true,
    choices(
      choice={1,2,3} "{1,2,3} \"Cardan/Tait-Bryan angles\"",
      choice={3,1,3} "{3,1,3} \"Euler angles\"",
      choice={3,2,1} "{3,2,1}"));

  type Color = Modelica.Icons.TypeInteger[3] (each min=0, each max=255)
    "RGB representation of color"
    annotation (
      Dialog(colorSelector=true),
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
Type <strong>Color</strong> is an Integer vector with 3 elements,
{r, g, b}, and specifies the color of a shape.
{r,g,b} are the \"red\", \"green\" and \"blue\" color parts.
Note, r g, b are given in the range 0 .. 255.
</p>
</html>"));
  type RealColor =
               Modelica.Icons.TypeReal[3] (each min=0, each max=255)
    "RGB representation of color as Real type"
    annotation (
      Dialog(colorSelector=true),
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
Type <strong>RealColor</strong> is a Real vector with 3 elements,
{r, g, b}, and specifies the color of a shape.
{r,g,b} are the \"red\", \"green\" and \"blue\" color parts.
Note, r g, b are given in the range 0 .. 255.
</p>
</html>"));
  type SpecularCoefficient = Modelica.Icons.TypeReal(min=0)
    "Reflection of ambient light (= 0: light is completely absorbed)"
       annotation (choices(
         choice=0 "0.0 \"dull\"",
         choice=0.7 "0.7 \"medium\"",
         choice=1 "1.0 \"glossy\""),
    Documentation(info="<html>
<p>
Type <strong>SpecularCoefficient</strong> defines the reflection of
ambient light on shape surfaces. If value = 0, the light
is completely absorbed. Often, 0.7 is a reasonable value.
It might be that from some viewing directions, a body is no
longer visible, if the SpecularCoefficient value is too high.
In the following image, the different values of SpecularCoefficient
are shown for a cylinder:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/SpecularCoefficient.png\"/>
</p>
</html>"));
  type ShapeType = Modelica.Icons.TypeString
    "Type of shape (box, sphere, cylinder, pipecylinder, cone, pipe, beam, gearwheel, spring, <external shape>)"
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
      choice="modelica://PackageName/PathName.dxf"),
    Documentation(info="<html>
<p>
Type <strong>ShapeType</strong> is used to define the shape of the
visual object as parameter String. Usually, \"shapeType\" is used
as instance name. The following
values for shapeType are possible, e.g., shapeType=\"box\":
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Shape.png\" alt=\"model Visualizers.FixedShape\">
</p>

<p>
The dark blue arrows in the figure above are directed along
variable <strong>lengthDirection</strong>. The light blue arrows are directed
along variable <strong>widthDirection</strong>. The <strong>coordinate systems</strong>
in the figure represent frame_a of the Shape component.
</p>

<p>
Additionally, external shapes can be specified as (not all options might be supported by all tools):
</p>

<ul>
<li> <strong>\"1\", \"2\", ...</strong><br>
     define external shapes specified in DXF format in files \"1.dxf\", \"2.dxf\", ...
     The DXF-files must be found either in the current directory or in the directory where
     the Shape instance is stored that references the DXF file.
     This (very limited) option should not be used for new models. Example:<br>
    shapeType=\"1\".<br></li>

<li> \"<strong>modelica:</strong>//&lt;Modelica-name&gt;/&lt;relative-path-file-name&gt;\"<br>
     characterizes the file that is stored under the location of the
     &lt;Modelica-name&gt; library path with the given relative file name.
     Example:<br> shapeType = \"modelica://Modelica/Resources/Data/Shapes/Engine/piston.dxf\".<br></li>

<li> \"<strong>file:</strong>//&lt;absolute-file-name&gt;\"<br>
     characterizes an absolute file name in the file system. Example:<br>
     shapeType=\"file://C:/users/myname/shapes/piston.dxf\".</li>
</ul>

<p>
The supported file formats are tool dependent. Most tools support
at least DXF-files (a tool might support 3-dim. Face of the DXF format only),
but may support other format as well (such as stl, obj, 3ds).
Since visualization files contain color and other data, the corresponding
information in the model is usually ignored.
</p>
</html>"));
  type ShapeExtra = Modelica.Icons.TypeReal
    "Type of the additional data that can be defined for an elementary ShapeType"
       annotation (
    Documentation(info="<html>
<p>
This type is used in shapes of visual objects to define
extra data depending on the shape type. Usually, input
variable <strong>extra</strong> is used as instance name:
</p>

<table border=1 cellspacing=0 cellpadding=2>
<tr><th><strong>shapeType</strong></th><th>Meaning of parameter <strong>extra</strong></th></tr>
<tr>
  <td>\"cylinder\"</td>
  <td>if extra&nbsp;&gt;&nbsp;0, a black line is included in the
      cylinder to show the rotation of it.</td>
</tr>
<tr>
  <td>\"cone\"</td>
  <td>extra = diameter-left-side / diameter-right-side, i.e.,<br>
      extra = 1: cylinder<br>
      extra = 0: \"real\" cone.</td>
</tr>
<tr>
  <td>\"pipe\"</td>
  <td>extra = outer-diameter / inner-diameter, i.e,<br>
      extra = 1: cylinder that is completely hollow<br>
      extra = 0: cylinder without a hole.</td>
</tr>
<tr>
  <td>\"gearwheel\"</td>
  <td>extra is the number of teeth of the (external) gear.
If extra&nbsp;&lt;&nbsp;0, an internal gear is visualized with |extra| teeth.
The axis of the gearwheel is along \"lengthDirection\", and usually:
width = height = 2*radiusOfGearWheel.</td>
</tr>
<tr>
  <td>\"spring\"</td>
  <td>extra is the number of windings of the spring.
      Additionally, \"height\" is <strong>not</strong> the \"height\" but
      2*coil-width.</td>
</tr>
<tr>
  <td>external shape</td>
  <td>extra = 0: Visualization from file is not scaled.<br>
                     extra = 1: Visualization from file is scaled with \"length\", \"width\" and \"height\"
                                of the shape</td>
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
<tr><th><strong>Types.ResolveInFrameA.</strong></th><th><strong>Meaning</strong></th></tr>
<tr><td>world</td>
    <td>Resolve vector in world frame</td></tr>

<tr><td>frame_a</td>
    <td>Resolve vector in frame_a</td></tr>

<tr><td>frame_resolve</td>
    <td>Resolve vector in frame_resolve (frame_resolve must be connected)</td></tr>
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
<tr><th><strong>Types.ResolveInFrameB.</strong></th><th><strong>Meaning</strong></th></tr>
<tr><td>world</td>
    <td>Resolve vector in world frame</td></tr>

<tr><td>frame_b</td>
    <td>Resolve vector in frame_b</td></tr>

<tr><td>frame_resolve</td>
    <td>Resolve vector in frame_resolve (frame_resolve must be connected)</td></tr>
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
<tr><th><strong>Types.ResolveInFrameAB.</strong></th><th><strong>Meaning</strong></th></tr>
<tr><td>world</td>
    <td>Resolve vector in world frame</td></tr>

<tr><td>frame_a</td>
    <td>Resolve vector in frame_a</td></tr>

<tr><td>frame_b</td>
    <td>Resolve vector in frame_b</td></tr>

<tr><td>frame_resolve</td>
    <td>Resolve vector in frame_resolve (frame_resolve must be connected)</td></tr>
</table>
</html>"));

  type RotationTypes = enumeration(
      RotationAxis "Rotating frame_a around an angle with a fixed axis",
      TwoAxesVectors "Resolve two vectors of frame_b in frame_a",
      PlanarRotationSequence "Planar rotation sequence")
    "Enumeration defining in which way the fixed orientation of frame_b with respect to frame_a is specified"
      annotation (
        Documentation(Evaluate=true, info="<html>
<table border=1 cellspacing=0 cellpadding=2>
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

  type GravityTypes = enumeration(
      NoGravity "No gravity field",
      UniformGravity "Uniform gravity field",
      PointGravity "Point gravity field")
    "Enumeration defining the type of the gravity field"
      annotation (Documentation(info="<html>
<table border=1 cellspacing=0 cellpadding=2>
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
    constant Real BodyCylinderDiameterFraction=3
      "Default for body cylinder diameter as a fraction of body sphere diameter";
    constant Real JointRodDiameterFraction=2
      "Default for rod diameter as a fraction of joint sphere diameter attached to rod";

    /*
  constant Real N_to_m(unit="N/m") = 1000
    "Default force arrow scaling (length = force/N_to_m_default)";
  constant Real Nm_to_m(unit="N.m/m") = 1000
    "Default torque arrow scaling (length = torque/Nm_to_m_default)";
*/
    annotation (Documentation(info="<html>
<p>
This package contains constants used as default setting
in the MultiBody library.
</p>
</html>"));
  end Defaults;

  annotation (Documentation(info="<html>
<p>
In this package <strong>types</strong> and <strong>constants</strong> are defined that are used in the
MultiBody library. The types have additional annotation choices
definitions that define the menus to be built up in the graphical
user interface when the type is used as parameter in a declaration.
</p>
</html>"));
end Types;
