package Types "Constants and types with choices, especially to build menus"
  extends Modelica.Icons.Library;
  annotation (preferedView="info", Documentation(info="<HTML>
<p>
In this package <b>types</b> and <b>constants</b> are defined that are used in the
MultiBody library. The types have additional annotation choices
definitions that define the menus to be built up in the graphical
user interface when the type is used as parameter in a declaration.
</p>
</HTML>"));

  type Axis = Modelica.Icons.TypeReal[3] "Axis vector with choices for menus" annotation (
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
    annotation (preferedView="info",
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
  type SpecularCoefficient = Modelica.Icons.TypeReal
    "Reflection of ambient light (= 0: light is completely absorbed)"
       annotation (preferedView="info", min=0,
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
<img src=\"../Images/MultiBody/Visualizers/SpecularCoefficient.png\"
</p>
</html>"));
  type ShapeType = Modelica.Icons.TypeString
    "Type of shape (box, sphere, cylinder, pipecylinder, cone, pipe, beam, gearwheel, spring, dxf-file)"
     annotation (preferedView="info", choices(
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
<IMG SRC=\"../Images/MultiBody/Shape.png\" ALT=\"model Visualizers.FixedShape\">
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
       annotation (preferedView="info", min=0,
    Documentation(info="<html>
<p>
This type is used in shapes of visual objects to define
extra data depending on the shape type. Usually, input
variable <b>extra</b> is used as instance name:
</p>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th><b>shapeType</b></th><th>Meaning of variable <b>extra</b></th></tr>
<tr>
  <td>\"cylinder\"</td>
  <td>if extra &gt; 0, a black line is included in the
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
  <td>extra = outer-diameter / inner-diameter, i.e, <br>
      extra = 1: cylinder that is completely hollow<br>
      extra = 0: cylinder without a hole.</td>
</tr>
<tr>
  <td>\"gearwheel\"</td>
  <td>extra is the number of teeth of the gear.</td>
</tr>
<tr>
  <td>\"spring\"</td>
  <td>extra is the number of windings of the spring.
      Additionally, \"height\" is <b>not</b> the \"height\" but
      2*coil-width.</td>
</tr>
</table>
</html>"));

  type AngularVelocity_degs = Modelica.Icons.TypeReal(final quantity="AngularVelocity", final unit
        =    "deg/s") "Angular velocity type in deg/s";

  type AngularAcceleration_degs2 = Modelica.Icons.TypeReal (final quantity="AngularAcceleration",
        final unit="deg/s2") "Angular acceleration type in deg/s^2";

  package RotationTypes
    "Type, constants and menu choices for rotation types, as temporary solution until enumerations are available"

    annotation (Documentation(info="<html>

</html>"));

    extends Modelica.Icons.Enumeration;
    constant Integer RotationAxis=1;
    constant Integer TwoAxesVectors=2;
    constant Integer PlanarRotationSequence=3;
    type Temp
      "Temporary type of RotationTypes with choices for menus (until enumerations are available)"

      extends Modelica.Icons.TypeInteger;
      annotation (Evaluate=true, choices(
          choice=Modelica.Mechanics.MultiBody.Types.RotationTypes.RotationAxis
            "Rotation axis",
          choice=Modelica.Mechanics.MultiBody.Types.RotationTypes.TwoAxesVectors
            "Two axes vectors",
          choice=Modelica.Mechanics.MultiBody.Types.RotationTypes.PlanarRotationSequence
            "Planar rotation sequence"),
        Documentation(info="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th><b>Types.RotationTypes.</b></th><th><b>Meaning</b></th></tr>
<tr><td>RotationAxis</td>
    <td>frame_b is defined by rotating the coordinate system along
        an axis fixed in frame_a and with a fixed angle.</td></tr>

<tr><td>TwoAxesVectors</td>
    <td>frame_b is defined by resolving two vectors of frame_b in frame_a.</td></tr>

<tr><td>PlanarRotationSequence</td>
    <td>frame_b is defined by rotating the coordinate system along
        3 consecutive axes vectors with fixed rotation angles
        (e.g. Cardan or Euler angle sequence rotation).</td></tr>
</table>
</html>"));

    end Temp;
  end RotationTypes;

  package GravityTypes
    "Type, constants and menu choices for gravity fields, as temporary solution until enumerations are available"

    annotation (Documentation(info="<html>

</html>"));
    extends Modelica.Icons.Enumeration;
    constant Integer NoGravity=0;
    constant Integer UniformGravity=1;
    constant Integer PointGravity=2;

    type Temp
      "Temporary type of gravity field with choices for menus (until enumerations are available)"

      extends Modelica.Icons.TypeInteger;
      annotation (choices(
          choice=Modelica.Mechanics.MultiBody.Types.GravityTypes.NoGravity
            "no gravity",
          choice=Modelica.Mechanics.MultiBody.Types.GravityTypes.UniformGravity
            "uniform gravity",
          choice=Modelica.Mechanics.MultiBody.Types.GravityTypes.PointGravity
            "point gravity"), Documentation(info="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th><b>Types.GravityTypes.</b></th><th><b>Meaning</b></th></tr>
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

    end Temp;
  end GravityTypes;

  package Init
    "Type, constants and menu choices to define initialization, as temporary solution until enumerations are available"

    annotation (Documentation(info="<html>

</html>"));
    extends Modelica.Icons.Enumeration;

    constant Integer Free=1;
    constant Integer PositionVelocity=2;
    constant Integer SteadyState=3;
    constant Integer Position=4;
    constant Integer Velocity=5;
    constant Integer VelocityAcceleration=6;
    constant Integer PositionVelocityAcceleration=7;

    type Temp
      "Temporary type of Init with choices for menus (until enumerations are available)"

      extends Modelica.Icons.TypeInteger;
      annotation (choices(
          choice=Modelica.Mechanics.MultiBody.Types.Init.Free
            "free (no initialization)",
          choice=Modelica.Mechanics.MultiBody.Types.Init.PositionVelocity
            "initialize generalized position and velocity variables",
          choice=Modelica.Mechanics.MultiBody.Types.Init.SteadyState
            "initialize in steady state (velocity and acceleration are zero)",
          choice=Modelica.Mechanics.MultiBody.Types.Init.Position
            "initialize only generalized position variable(s)",
          choice=Modelica.Mechanics.MultiBody.Types.Init.Velocity
            "initialize only generalized velocity variable(s)",
          choice=Modelica.Mechanics.MultiBody.Types.Init.VelocityAcceleration
            "initialize generalized velocity and acceleration variables",
          choice=Modelica.Mechanics.MultiBody.Types.Init.PositionVelocityAcceleration
            "initialize generalized position, velocity and acceleration variables"),
          Documentation(info="<html>

<table border=1 cellspacing=0 cellpadding=2>
<tr><th><b>Types.Init.</b></th><th><b>Meaning</b></th></tr>
<tr><td>Free</td>
    <td>No initialization</td></tr>

<tr><td>PositionVelocity</td>
    <td>Initialize generalized position and velocity variables</td></tr>

<tr><td>SteadyState</td>
    <td>Initialize in steady state (velocity and acceleration are zero)</td></tr>

<tr><td>Position </td>
    <td>Initialize only generalized position variable(s)</td></tr>

<tr><td>Velocity</td>
    <td>Initialize only generalized velocity variable(s)</td></tr>

<tr><td>VelocityAcceleration</td>
    <td>Initialize generalized velocity and acceleration variables</td></tr>

<tr><td>PositionVelocityAcceleration</td>
    <td>Initialize generalized position, velocity and acceleration variables</td></tr>

</table>

</html>"));

    end Temp;
  end Init;

  package Defaults "Default settings of the MultiBody library via constants"
    annotation (preferedView="info", Documentation(info="<html>
<p>
This package contains constants used as default setting
in the MultiBody library.
</p>
</html>"));
    extends Modelica.Icons.Library;

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
  end Defaults;

end Types;
