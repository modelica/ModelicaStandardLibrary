within Modelica.Mechanics.MultiBody.Visualizers;
model FixedShape
  "Visualizing an elementary shape with dynamically varying shape attributes (has one frame connector)"
  import Modelica.Mechanics.MultiBody.Types;
  extends Modelica.Mechanics.MultiBody.Interfaces.PartialVisualizer;

  parameter Boolean animation=true "= true, if animation shall be enabled";
  parameter Types.ShapeType shapeType="box" "Type of shape"
    annotation (Dialog(group="if animation = true", enable=animation));
  input SI.Position r_shape[3]={0,0,0}
    "Vector from frame_a to shape origin, resolved in frame_a"
    annotation (Dialog(group="if animation = true", enable=animation));
  input Types.Axis lengthDirection={1,0,0}
    "Vector in length direction of shape, resolved in frame_a"
    annotation (Dialog(group="if animation = true", enable=animation));
  input Types.Axis widthDirection={0,1,0}
    "Vector in width direction of shape, resolved in frame_a"
    annotation (Dialog(group="if animation = true", enable=animation));
  input SI.Distance length(start=1) "Length of shape"
    annotation (Dialog(group="if animation = true", enable=animation));
  input SI.Distance width(start=0.1) "Width of shape"
    annotation (Dialog(group="if animation = true", enable=animation));
  input SI.Distance height(start=0.1) "Height of shape"
    annotation (Dialog(group="if animation = true", enable=animation));
  input Modelica.Mechanics.MultiBody.Types.Color color={0,128,255}
    "Color of shape"
    annotation (Dialog(colorSelector=true, group="if animation = true", enable=animation));
  input Types.ShapeExtra extra=0.0
    "Additional data for cylinder, cone, pipe, gearwheel and spring"
    annotation (Dialog(group="if animation = true", enable=animation));
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (Dialog(group="if animation = true", enable=animation));

protected
  Advanced.Shape vis(
    shapeType=shapeType,
    r_shape=r_shape,
    lengthDirection=lengthDirection,
    widthDirection=widthDirection,
    length=length,
    width=width,
    height=height,
    color=color,
    extra=extra,
    specularCoefficient=specularCoefficient,
    r=frame_a.r_0,
    R=frame_a.R) if world.enableAnimation and animation;
equation
  // No forces and torques
  frame_a.f = zeros(3);
  frame_a.t = zeros(3);
  annotation (
    Documentation(info="<html>
<p>
Model <strong>FixedShape</strong> defines a visual shape that is
shown at the location of its frame_a.
All describing data such as size and color can vary dynamically by
providing appropriate expressions in the input fields of the
parameter menu. The only exception is parameter shapeType
that cannot be changed during simulation.
The following shapes are currently supported via
parameter <strong>shapeType</strong> (e.g., shapeType=\"box\"):<br>&nbsp;
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/Shape.png\" alt=\"model Visualizers.FixedShape\">
</div>

<p>
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
Some tools support only 3dface (for geometry) and layer (for advanced coloring).</p>

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
Note, r, g and b are given as Integer[3] in the ranges 0&nbsp;&hellip;&nbsp;255,
respectively. The predefined type
<a href=\"modelica://Modelica.Mechanics.MultiBody.Types.Color\">MultiBody.Types.Color</a> contains a menu
definition of the colors used in the MultiBody library together with a color editor.
</p>
</html>"),
         Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Polygon(
          points={{-100,32},{-64,46},{2,30},{72,54},{50,32},{-10,12},{-100,32}},
          lineColor={215,215,215},
          fillColor={160,160,160},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{72,54},{50,32},{50,-60},{72,-32},{72,54}},
          lineColor={215,215,215},
          fillColor={160,160,164},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,-65},{150,-95}},
          textString="%shapeType"),
        Text(
          extent={{-150,100},{150,60}},
          textString="%name",
          textColor={0,0,255}),
        Polygon(
          points={{-100,32},{-100,-60},{-10,-42},{50,-60},{50,32},{-10,12},{-100,32}},
          lineColor={215,215,215},
          fillColor={0,127,255},
          fillPattern=FillPattern.Solid)}));
end FixedShape;
