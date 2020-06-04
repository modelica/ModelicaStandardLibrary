within Modelica.Mechanics.MultiBody.Visualizers.Advanced;
model Shape
  "Visualizing an elementary object with variable size; all data have to be set as modifiers (see info layer)"

  extends ModelicaServices.Animation.Shape;
  extends Modelica.Utilities.Internal.PartialModelicaServices.Animation.PartialShape;

    annotation (
     Icon(coordinateSystem(
         preserveAspectRatio=true,
         extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-100,-100},{80,60}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-100,60},{-80,100},{100,100},{80,60},{-100,60}},
          lineColor={0,0,255},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{100,100},{100,-60},{80,-100},{80,60},{100,100}},
          lineColor={0,0,255},
          fillColor={160,160,164},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-100,-54},{80,8}},
          textString="%shapeType"),
        Text(
          extent={{-150,150},{150,110}},
          textColor={0,0,255},
          textString="%name")}),
     Documentation(info="<html>
<p>
Model <strong>Shape</strong> defines a visual shape that is
shown at the location of its reference coordinate system, called
'object frame' below. All describing variables such
as size and color can vary dynamically (with the only exception
of parameter shapeType). The default equations in the
declarations should be modified by providing appropriate modifier
equations. Model <strong>Shape</strong> is usually used as a basic building block to
implement simpler to use graphical components.
</p>
<p>
The following shapes are supported via
parameter <strong>shapeType</strong> (e.g., shapeType=\"box\"):<br>&nbsp;
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/Shape.png\" alt=\"model Visualizers.FixedShape\">
</div>

<p>&nbsp;<br>
The dark blue arrows in the figure above are directed along
variable <strong>lengthDirection</strong>. The light blue arrows are directed
along variable <strong>widthDirection</strong>. The <strong>coordinate systems</strong>
in the figure represent frame_a of the Shape component.
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
If extra &lt; 0, an internal gear is visualized with |extra| teeth.
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
The dialog variables <code>shapeType</code>, <code>R</code>, <code>r</code>, <code>r_shape</code>,
<code>lengthDirection</code>, <code>widthDirection</code>, <code>length</code>, <code>width</code>,
<code>height</code>, <code>extra</code>, <code>color</code>, and <code>specularCoefficient</code>
are declared as (time varying) <strong>input</strong> variables.
If the default equation is not appropriate, a corresponding
modifier equation has to be provided in the
model where a <strong>Shape</strong> instance is used, e.g., in the form
</p>

<blockquote><pre>
Visualizers.Advanced.Shape shape(length = sin(time));
</pre></blockquote>
</html>"));
end Shape;
