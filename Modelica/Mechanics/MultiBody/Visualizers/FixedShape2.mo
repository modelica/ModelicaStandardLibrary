within Modelica.Mechanics.MultiBody.Visualizers;
model FixedShape2
  "Visualizing an elementary shape with dynamically varying shape attributes (has two frame connectors)"

  import Modelica.Mechanics.MultiBody.Frames;
  import Modelica.Mechanics.MultiBody.Types;
  import Modelica.Units.Conversions.to_unit1;

  Interfaces.Frame_a frame_a
    "Coordinate system a (all shape definition vectors are resolved in this frame)"
     annotation (Placement(transformation(extent={{-116,-16},{-84,16}})));
  Interfaces.Frame_b frame_b "Coordinate system b"
     annotation (Placement(transformation(extent={{84,-16},{116,16}})));

  parameter Boolean animation=true "= true, if animation shall be enabled";
  parameter Types.ShapeType shapeType="box" "Type of shape"
    annotation (Dialog(group="if animation = true", enable=animation));
  input SI.Position r[3]={1,0,0}
    "Vector from frame_a to frame_b resolved in frame_a";
  input SI.Position r_shape[3]={0,0,0}
    "Vector from frame_a to shape origin, resolved in frame_a"
    annotation (Dialog(group="if animation = true", enable=animation));
  input Types.Axis lengthDirection = to_unit1(r - r_shape)
    "Vector in length direction of shape, resolved in frame_a"
    annotation (Dialog(group="if animation = true", enable=animation));
  input Types.Axis widthDirection={0,1,0}
    "Vector in width direction of shape, resolved in frame_a"
    annotation (Dialog(group="if animation = true", enable=animation));
  input SI.Length length=Modelica.Math.Vectors.length(
                                       r - r_shape) "Length of shape"
    annotation (Dialog(group="if animation = true", enable=animation));
  input SI.Distance width=0.1 "Width of shape"
    annotation (Dialog(group="if animation = true", enable=animation));
  input SI.Distance height=width "Height of shape"
    annotation (Dialog(group="if animation = true", enable=animation));
  input Types.ShapeExtra extra=0.0
    "Additional data for cylinder, cone, pipe, gearwheel and spring"
    annotation (Dialog(group="if animation = true", enable=animation));
  input Types.Color color={0,128,255} "Color of shape"
    annotation (Dialog(colorSelector=true, group="if animation = true", enable=animation));
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (Dialog(group="if animation = true", enable=animation));

protected
  outer MultiBody.World world;
  Advanced.Shape shape(
    shapeType=shapeType,
    r_shape=r_shape,
    lengthDirection=lengthDirection,
    widthDirection=widthDirection,
    length=length,
    width=width,
    height=height,
    extra=extra,
    color=color,
    specularCoefficient = specularCoefficient,
    r=frame_a.r_0,
    R=frame_a.R) if world.enableAnimation and animation;
equation
  Connections.branch(frame_a.R, frame_b.R);
  assert(cardinality(frame_a) > 0 or cardinality(frame_b) > 0, "Neither connector frame_a nor frame_b of
MultiBody.Visualizers.FixedShape2 object is connected");

  frame_b.r_0 = frame_a.r_0 + Frames.resolve1(frame_a.R, r);
  frame_b.R = frame_a.R;

  /* Force and torque balance */
  zeros(3) = frame_a.f + frame_b.f;
  zeros(3) = frame_a.t + frame_b.t + cross(r, frame_b.f);
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-150,115},{150,75}},
          textString="%name",
          textColor={0,0,255}),
        Text(
          extent={{150,-90},{-150,-60}},
          textString="r=%r"),
        Polygon(
          points={{-100,50},{-66,62},{0,46},{100,70},{80,50},{-10,28},{-100,50}},
          lineColor={255,255,255},
          fillColor={160,160,164},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{100,70},{80,50},{80,-44},{100,-16},{100,70}},
          lineColor={255,255,255},
          fillColor={160,160,164},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-100,50},{-100,-44},{-10,-24},{80,-44},{80,50},{-10,28},{-100,50}},
          lineColor={215,215,215},
          fillColor={0,127,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-86,15},{-50,-10}},
          textString="a"),
        Text(
          extent={{37,15},{73,-10}},
          textString="b")}),
    Documentation(info="<html>
<p>
Model <strong>FixedShape2</strong> defines a visual shape that is
shown at the location of its frame_a. This model is identical
to <strong>FixedShape</strong> with the only difference that an
additional frame_b is present which is parallel to frame_a.
This makes it more convenient to connect several visual
shapes together when building up more complex visual
objects. All describing data such as size and color can vary dynamically by
providing appropriate expressions in the input fields of the
parameter menu. The only exception is parameter shapeType
that cannot be changed during simulation.
The following shapes are currently supported via
parameter <strong>shapeType</strong> (e.g., shapeType=\"box\"):<br>&nbsp;
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/Shape.png\" alt=\"model Visualizers.FixedShape2\">
</div>

<p>&nbsp;<br>
The dark blue arrows in the figure above are directed along
variable <strong>lengthDirection</strong>. The light blue arrows are directed
along variable <strong>widthDirection</strong>. The <strong>coordinate systems</strong>
in the figure represent frame_a of the FixedShape component.
</p>

<p>
Additionally, <strong>external shapes</strong> can be specified as (not all options might be supported by all tools):
</p>

<ul>
<li> <strong>\"1\", \"2\",&nbsp;&hellip;</strong><br>
     define external shapes specified in DXF format in files \"1.dxf\", \"2.dxf\",&nbsp;&hellip;
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
The supported file formats are tool dependent. Most tools support at least DXF-files
but may support other format as well (such as stl, obj, 3ds).
Since visualization files contain color and other data, the corresponding
information in the model is usually ignored.
For information about DXF files, see <a href=\"https://en.wikipedia.org/wiki/AutoCAD_DXF\">Wikipedia</a>.
As a default it is assumed that the DXF coordinates are in the \"frame_a\"-system and in meters, and that the 3dfaces are two-sided.
Some tools support only 3dface (for geometry) and layer (for advanced coloring).
</p>

<p>
The sizes of any of the above components are specified by the
<strong>length</strong>, <strong>width</strong> and <strong>height</strong> variables.
Via variable <strong>extra</strong> additional data can be defined:
</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
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
<p>
Parameter <strong>color</strong> is a vector with 3 elements,
{r,&nbsp;g,&nbsp;b}, and specifies the color of the shape.
{r,&nbsp;g,&nbsp;b} are the \"red\", \"green\" and \"blue\" color parts.
Note, r, g, b are given as Integer[3] in the ranges 0&nbsp;&hellip;&nbsp;255,
respectively. The predefined type
<a href=\"modelica://Modelica.Mechanics.MultiBody.Types.Color\">MultiBody.Types.Color</a> contains a menu
definition of the colors used in the MultiBody library together with a color editor.
</p>
<p>
In the following figure the relationships between
frame_a and frame_b are shown. The origin of frame_b
with respect to frame_a is specified via parameter
vector&nbsp;<strong>r</strong>.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Parts/FixedTranslation.png\" alt=\"Parts.FixedTranslation\">
</div>
</html>"));
end FixedShape2;
