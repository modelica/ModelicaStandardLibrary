within Modelica.Mechanics.MultiBody;
package Visualizers "3-dimensional visual objects used for animation"
  extends Modelica.Icons.Package;

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

<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Shape.png\" alt=\"model Visualizers.FixedShape\">
</p>

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
<p>
Parameter <strong>color</strong> is a vector with 3 elements,
{r,&nbsp;g,&nbsp;b}, and specifies the color of the shape.
{r,&nbsp;g,&nbsp;b} are the \"red\", \"green\" and \"blue\" color parts.
Note, r, g and b are given as Integer[3] in the ranges 0&nbsp;&hellip;&nbsp;255,
respectively. The predefined type
<a href=\"modelica://Modelica.Mechanics.MultiBody.Types.Color\">MultiBody.Types.Color</a> contains a menu
definition of the colors used in the MultiBody library together with a color editor.
</p>
</html>"), Icon(coordinateSystem(
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

  model FixedShape2
    "Visualizing an elementary shape with dynamically varying shape attributes (has two frame connectors)"

    import Modelica.Mechanics.MultiBody.Frames;
    import Modelica.Mechanics.MultiBody.Types;
    import Modelica.SIunits.Conversions.to_unit1;

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

<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Shape.png\" alt=\"model Visualizers.FixedShape2\">
</p>

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

<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/FixedTranslation.png\" alt=\"Parts.FixedTranslation\">
</p>
</html>"));
  end FixedShape2;

  model FixedFrame
    "Visualizing a coordinate system including axes labels (visualization data may vary dynamically)"

    import Modelica.Mechanics.MultiBody.Types;
    extends Modelica.Mechanics.MultiBody.Interfaces.PartialVisualizer;
    parameter Boolean animation=true "= true, if animation shall be enabled";
    parameter Boolean showLabels=true "= true, if labels shall be shown"
      annotation (Dialog(group="if animation = true", enable=animation));
    input SI.Distance length=0.5 "Length of axes arrows"
      annotation (Dialog(group="if animation = true", enable=animation));
    input SI.Distance diameter=length/world.defaultFrameDiameterFraction
      "Diameter of axes arrows" annotation (Dialog(group="if animation = true", enable=animation));
    input Types.Color color_x=Modelica.Mechanics.MultiBody.Types.Defaults.
        FrameColor "Color of x-arrow"
      annotation (Dialog(colorSelector=true,group="if animation = true", enable=animation));
    input Types.Color color_y=color_x "Color of y-arrow"
      annotation (Dialog(colorSelector=true,group="if animation = true", enable=animation));
    input Types.Color color_z=color_x "Color of z-arrow"
      annotation (Dialog(colorSelector=true,group="if animation = true", enable=animation));
    input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient
      "Reflection of ambient light (= 0: light is completely absorbed)"
      annotation (Dialog(group="if animation = true", enable=animation));
  protected
    parameter Boolean animation2 = world.enableAnimation and animation;
    parameter Boolean showLabels2= world.enableAnimation and animation and showLabels;

    // Parameters to define axes
    SI.Length headLength=min(length, diameter*Types.Defaults.FrameHeadLengthFraction);
    SI.Length headWidth=diameter*Types.Defaults.FrameHeadWidthFraction;
    SI.Length lineLength=max(0, length - headLength);
    SI.Length lineWidth=diameter;

    // Parameters to define axes labels
    SI.Length scaledLabel=Modelica.Mechanics.MultiBody.Types.Defaults.FrameLabelHeightFraction*diameter;
    SI.Length labelStart=1.05*length;

    // x-axis
    Visualizers.Advanced.Shape x_arrowLine(
      shapeType="cylinder",
      length=lineLength,
      width=lineWidth,
      height=lineWidth,
      lengthDirection={1,0,0},
      widthDirection={0,1,0},
      color=color_x,
      specularCoefficient=specularCoefficient,
      r=frame_a.r_0,
      R=frame_a.R) if animation2;
    Visualizers.Advanced.Shape x_arrowHead(
      shapeType="cone",
      length=headLength,
      width=headWidth,
      height=headWidth,
      lengthDirection={1,0,0},
      widthDirection={0,1,0},
      color=color_x,
      specularCoefficient=specularCoefficient,
      r=frame_a.r_0 + Frames.resolve1(frame_a.R, {lineLength,0,0}),
      R=frame_a.R) if animation2;
    Visualizers.Internal.Lines x_label(
      lines=scaledLabel*{[0, 0; 1, 1],[0, 1; 1, 0]},
      diameter=diameter,
      color=color_x,
      specularCoefficient=specularCoefficient,
      r_lines={labelStart,0,0},
      n_x={1,0,0},
      n_y={0,1,0},
      r=frame_a.r_0,
      R=frame_a.R) if showLabels2;

    // y-axis
    Visualizers.Advanced.Shape y_arrowLine(
      shapeType="cylinder",
      length=lineLength,
      width=lineWidth,
      height=lineWidth,
      lengthDirection={0,1,0},
      widthDirection={1,0,0},
      color=color_y,
      specularCoefficient=specularCoefficient,
      r=frame_a.r_0,
      R=frame_a.R) if animation2;
    Visualizers.Advanced.Shape y_arrowHead(
      shapeType="cone",
      length=headLength,
      width=headWidth,
      height=headWidth,
      lengthDirection={0,1,0},
      widthDirection={1,0,0},
      color=color_y,
      specularCoefficient=specularCoefficient,
      r=frame_a.r_0 + Frames.resolve1(frame_a.R, {0,lineLength,0}),
      R=frame_a.R) if animation2;
    Visualizers.Internal.Lines y_label(
      lines=scaledLabel*{[0, 0; 1, 1.5],[0, 1.5; 0.5, 0.75]},
      diameter=diameter,
      color=color_y,
      specularCoefficient=specularCoefficient,
      r_lines={0,labelStart,0},
      n_x={0,1,0},
      n_y={-1,0,0},
      r=frame_a.r_0,
      R=frame_a.R) if showLabels2;

    // z-axis
    Visualizers.Advanced.Shape z_arrowLine(
      shapeType="cylinder",
      length=lineLength,
      width=lineWidth,
      height=lineWidth,
      lengthDirection={0,0,1},
      widthDirection={0,1,0},
      color=color_z,
      specularCoefficient=specularCoefficient,
      r=frame_a.r_0,
      R=frame_a.R) if animation2;
    Visualizers.Advanced.Shape z_arrowHead(
      shapeType="cone",
      length=headLength,
      width=headWidth,
      height=headWidth,
      lengthDirection={0,0,1},
      widthDirection={0,1,0},
      color=color_z,
      specularCoefficient=specularCoefficient,
      r=frame_a.r_0 + Frames.resolve1(frame_a.R, {0,0,lineLength}),
      R=frame_a.R) if animation2;
    Visualizers.Internal.Lines z_label(
      lines=scaledLabel*{[0, 0; 1, 0],[0, 1; 1, 1],[0, 1; 1, 0]},
      diameter=diameter,
      color=color_z,
      specularCoefficient=specularCoefficient,
      r_lines={0,0,labelStart},
      n_x={0,0,1},
      n_y={0,1,0},
      r=frame_a.r_0,
      R=frame_a.R) if showLabels2;
  equation
    frame_a.f = zeros(3);
    frame_a.t = zeros(3);
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,127,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-2,92},{-14,52},{10,52},{-2,92},{-2,92}},
            lineColor={0,191,0},
            fillColor={0,191,0},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-2,-18},{-2,52}},
            color={0,191,0},
            thickness=0.5),
          Text(
            extent={{16,93},{67,43}},
            textColor={0,191,0},
            textString="y"),
          Text(
            extent={{43,11},{92,-38}},
            textString="x"),
          Polygon(
            points={{98,-70},{74,-44},{64,-60},{98,-70}},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-2,-18},{72,-54}},
            thickness=0.5),
          Line(
            points={{-72,-54},{-2,-18}},
            thickness=0.5,
            color={0,0,255}),
          Text(
            extent={{-87,13},{-38,-36}},
            textString="z",
            textColor={0,0,255}),
          Text(
            extent={{-150,145},{150,105}},
            textString="%name",
            textColor={0,0,255}),
          Polygon(points={{-98,-68},{-66,-60},{-78,-46},{-98,-68}}, lineColor={0,0,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid)}),
      Documentation(info="<html>
<p>
Model <strong>FixedFrame</strong> visualizes the three axes of
its coordinate system <strong>frame_a</strong> together with appropriate axes
labels. A typical example is shown in the following figure:
<br>&nbsp;
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/FixedFrame.png\" alt=\"model Visualizers.FixedFrame\">
</p>

<p>
The sizes of the axes, the axes colors and the specular coefficient
(= reflection factor for
ambient light) can vary dynamically by
providing appropriate expressions in the input fields of the
parameter menu.
</p>
</html>"));
  end FixedFrame;

  model FixedArrow
    "Visualizing an arrow with dynamically varying size in frame_a"

    import Modelica.Mechanics.MultiBody.Types;
    extends Modelica.Mechanics.MultiBody.Interfaces.PartialVisualizer;
    parameter Boolean animation=true "= true, if animation shall be enabled";
    input SI.Position r_tail[3]={0,0,0}
      "Vector from frame_a to arrow tail, resolved in frame_a"
      annotation (Dialog(group="if animation = true", enable=animation));
    input Types.Axis n={1,0,0} "Vector in arrow direction, resolved in frame_a"
      annotation (Dialog(group="if animation = true", enable=animation));
    input SI.Length length=0.1 "Length of complete arrow"
      annotation (Dialog(group="if animation = true", enable=animation));
    input SI.Diameter diameter=world.defaultArrowDiameter
      "Diameter of arrow line" annotation (Dialog(group="if animation = true", enable=animation));
    input Types.Color color={0,0,255} "Color of arrow"
      annotation (Dialog(colorSelector=true, group="if animation = true", enable=animation));
    input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient
      "Reflection of ambient light (= 0: light is completely absorbed)"
      annotation (Dialog(group="if animation = true", enable=animation));
  protected
    SI.Length headLength=min(length, diameter*Types.Defaults.
        ArrowHeadLengthFraction);
    SI.Length headWidth=diameter*Types.Defaults.
        ArrowHeadWidthFraction;
    SI.Length lineLength=max(0, length - headLength);
    Visualizers.Advanced.Shape arrowLine(
      shapeType="cylinder",
      length=lineLength,
      width=diameter,
      height=diameter,
      lengthDirection=n,
      widthDirection={0,1,0},
      color=color,
      specularCoefficient=specularCoefficient,
      r_shape=r_tail,
      r=frame_a.r_0,
      R=frame_a.R) if world.enableAnimation and animation;
    Visualizers.Advanced.Shape arrowHead(
      shapeType="cone",
      length=headLength,
      width=headWidth,
      height=headWidth,
      lengthDirection=n,
      widthDirection={0,1,0},
      color=color,
      specularCoefficient=specularCoefficient,
      r_shape=r_tail + Modelica.Math.Vectors.normalize(
                                        n)*lineLength,
      r=frame_a.r_0,
      R=frame_a.R) if world.enableAnimation and animation;

  equation
    frame_a.f = zeros(3);
    frame_a.t = zeros(3);

    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Rectangle(
            extent={{-100,28},{20,-28}},
            lineColor={128,128,128},
            fillColor={128,128,128},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{20,60},{100,0},{20,-60},{20,60}},
            lineColor={128,128,128},
            fillColor={128,128,128},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-150,105},{150,65}},
            textString="%name",
            textColor={0,0,255}),
          Text(
            extent={{-150,-75},{150,-105}},
            textString="%length")}),
      Documentation(info="<html>
<p>
Model <strong>FixedArrow</strong> defines an arrow that is
shown at the location of its frame_a.
<br>&nbsp;
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/Arrow.png\" alt=\"model Visualizers.FixedArrow\">
</p>

<p>
The direction of the arrow specified with vector
<strong>n</strong> is with respect to frame_a, i.e., the local frame to which the
arrow component is attached. The direction and length of the arrow, its diameter
and color can vary dynamically by
providing appropriate expressions in the input fields of the
parameter menu.
</p>
</html>"));
  end FixedArrow;

  model SignalArrow
    "Visualizing an arrow with dynamically varying size in frame_a based on input signal"

    import Modelica.Mechanics.MultiBody.Types;

    extends Modelica.Mechanics.MultiBody.Interfaces.PartialVisualizer;
    parameter Boolean animation=true "= true, if animation shall be enabled";
    input SI.Position r_tail[3]={0,0,0}
      "Vector from frame_a to arrow tail, resolved in frame_a"
      annotation (Dialog(group="if animation = true", enable=animation));
    input SI.Diameter diameter=world.defaultArrowDiameter
      "Diameter of arrow line"
      annotation (Dialog(group="if animation = true", enable=animation));
    input Modelica.Mechanics.MultiBody.Types.Color color={0,0,255}
      "Color of arrow"
      annotation (Dialog(colorSelector=true, group="if animation = true", enable=animation));
    input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient
      "Reflection of ambient light (= 0: light is completely absorbed)"
      annotation (Dialog(group="if animation = true", enable=animation));

    Modelica.Blocks.Interfaces.RealInput r_head[3](each final quantity="Length", each final unit="m")
      "Position vector from origin of frame_a to head of arrow, resolved in frame_a"
      annotation (Placement(transformation(
          origin={0,-120},
          extent={{-20,-20},{20,20}},
          rotation=90)));

  protected
    Visualizers.Advanced.Arrow arrow(
      R=frame_a.R,
      r=frame_a.r_0,
      r_tail=r_tail,
      r_head=r_head,
      diameter=diameter,
      color=color,
      specularCoefficient=specularCoefficient) if world.enableAnimation and animation;
  equation
    frame_a.f = zeros(3);
    frame_a.t = zeros(3);

    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Line(points={{0,-102},{0,-28}}, color={0,0,127}),
          Rectangle(
            extent={{-100,28},{20,-28}},
            lineColor={128,128,128},
            fillColor={128,128,128},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{20,60},{100,0},{20,-60},{20,60}},
            lineColor={128,128,128},
            fillColor={128,128,128},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-150,105},{150,65}},
            textString="%name",
            textColor={0,0,255})}),
      Documentation(info="<html>
<p>
Model <strong>SignalArrow</strong> defines an arrow that is dynamically visualized
at the location where its frame_a is attached. The
position vector from the tail to the head of the arrow,
resolved in frame_a, is defined via the signal vector of
the connector <strong>r_head</strong> (Real r_head[3]):<br>&nbsp;
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/Arrow.png\" alt=\"model Visualizers.SignalArrow\">
</p>
<p>
The tail of the arrow is defined with parameter <strong>r_tail</strong>
with respect to frame_a (vector from the origin of frame_a to the arrow tail).
</p>
</html>"));
  end SignalArrow;

   model Ground "Visualizing the ground (box in z=0)"
     extends Modelica.Icons.ObsoleteModel;
      parameter Boolean animation=true
      "= true, if animation of ground shall be enabled";
      parameter Modelica.SIunits.Position length = 10
      "Length and width of box (center is at x=y=0)" annotation (Dialog(enable=animation));
      parameter Modelica.SIunits.Position height = 0.02
      "Height of box (upper surface is at z=0, lower surface is at z=-height)"
                                                                        annotation (Dialog(enable=animation));
      parameter Modelica.Mechanics.MultiBody.Types.Color groundColor={0,255,0}
      "Color of box" annotation (Dialog(colorSelector=true, enable=animation));

      Modelica.Mechanics.MultiBody.Visualizers.FixedShape ground(
        lengthDirection={1,0,0},
        widthDirection={0,1,0},
        animation=animation,
        r_shape={-length/2,0,-height},
        length=length,
        height=height,
        color=groundColor,
        width=length)
        annotation (Placement(transformation(extent={{-20,0},{0,20}})));
      Modelica.Mechanics.MultiBody.Parts.Fixed fixed
        annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
   equation

      connect(fixed.frame_b, ground.frame_a) annotation (Line(
          points={{-40,10},{-20,10}},
          color={95,95,95},
          thickness=0.5));
      annotation (
        obsolete = "Obsolete model - use ground visualization feature in Modelica.Mechanics.MultiBody.World, or use model Modelica.Mechanics.MultiBody.Visualizers.Rectangle instead",
        Icon(
          coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}, initialScale = 0.1, grid = {10, 10}),
          graphics = {
            Polygon(lineColor = {255, 255, 255}, fillColor = {126, 181, 78}, fillPattern = FillPattern.Solid, points = {{-100, -30}, {20, -90}, {100, 0}, {-10, 40}}),
            Text(textColor = {64, 64, 64}, extent = {{20, 70}, {60, 100}}, textString = "z", horizontalAlignment = TextAlignment.Left),
            Polygon(lineColor = {255, 255, 255}, fillColor = {14, 111, 1}, fillPattern = FillPattern.Solid, points = {{100, -10}, {20, -100}, {20, -90}, {100, 0}}),
            Polygon(lineColor = {255, 255, 255}, fillColor = {14, 111, 1}, fillPattern = FillPattern.Solid, points = {{-100, -40}, {20, -100}, {20, -90}, {-100, -30}}), Line(origin = {6, -8}, points={{-6,-10},{-6,108}}),
            Polygon(origin = {6, 0}, points={{-6,102},{-14,72},{2,72},{-6,102}}, fillPattern=FillPattern.Solid),
            Text(textColor = {0,0,255}, extent = {{-150, -145}, {150, -105}}, textString = "%name")}),
        Documentation(info = "<html>
<p>
This shape visualizes the x-y plane by a box.
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/Ground.png\">
</blockquote>
</html>"));
   end Ground;

  model Torus "Visualizing a torus"
    extends Modelica.Mechanics.MultiBody.Interfaces.PartialVisualizer;

    parameter Boolean animation=true "= true, if animation shall be enabled";

    parameter Modelica.SIunits.Radius ri=0.5 "Inner radius of torus" annotation(Dialog(enable=animation));
    parameter Modelica.SIunits.Radius ro=0.1 "Outer radius of torus (=width/2)"
      annotation(Dialog(enable=animation));
    parameter Modelica.SIunits.Angle opening=0 "Opening angle of torus" annotation(Dialog(enable=animation));
    parameter Modelica.SIunits.Angle startAngle=-3.1415926535898
      "Start angle of torus slice" annotation(Dialog(enable=animation));
    parameter Modelica.SIunits.Angle stopAngle=3.1415926535898
      "End angle of torus slice" annotation(Dialog(enable=animation));
    parameter Boolean wireframe=false
      "= true: 3D model will be displayed without faces"
      annotation (Dialog(enable=animation, group="Material properties"),choices(checkBox=true));
    input Modelica.Mechanics.MultiBody.Types.RealColor color={0,128,255}
      "Color of surface" annotation(Dialog(enable=animation and not multiColoredSurface,colorSelector=true,group="Material properties"));
    input Types.SpecularCoefficient specularCoefficient = 0.7
      "Reflection of ambient light (= 0: light is completely absorbed)" annotation(Dialog(enable=animation,group="Material properties"));
    input Real transparency=0
      "Transparency of shape: 0 (= opaque) ... 1 (= fully transparent)"
                                 annotation(Dialog(enable=animation,group="Material properties"));
    parameter Integer n_ri=40 "Number of points along ri" annotation(Dialog(enable=animation,tab="Discretization"));
    parameter Integer n_ro=20 "Number of points along ro" annotation(Dialog(enable=animation,tab="Discretization"));

  protected
    Advanced.Surface surface(
      redeclare function surfaceCharacteristic =
        Modelica.Mechanics.MultiBody.Visualizers.Advanced.SurfaceCharacteristics.torus (
          ri=ri,
          ro=ro,
          opening=opening,
          startAngle=startAngle,
          stopAngle=stopAngle),
          nu=n_ri,
          nv=n_ro,
          multiColoredSurface=false,
          wireframe=wireframe,
          color=color,
          specularCoefficient=specularCoefficient,
          transparency=transparency,
          R=frame_a.R,
          r_0=frame_a.r_0) if world.enableAnimation and animation
      annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  equation
    // No forces and torques
    frame_a.f = zeros(3);
    frame_a.t = zeros(3);
    annotation(
      Icon(
        graphics={
          Text(textColor = {0,0,255}, extent = {{-150, 100}, {150, 140}}, textString = "%name"),
          Polygon(lineColor = {64, 64, 64}, fillColor = {71, 152, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-72.253, 64.182}, {-77.03, 59.04}, {-81.278, 53.499}, {-84.986, 47.602}, {-88.145, 41.392}, {-90.745, 34.911}, {-92.777, 28.202}, {-94.231, 21.307}, {-95.097, 14.269}, {-95.365, 7.13}, {-95.027, -0.067}, {-94.072, -7.28}, {-92.491, -14.465}, {-90.273, -21.582}, {-87.411, -28.586}, {-83.892, -35.437}, {-79.709, -42.09}, {-74.852, -48.503}, {-69.309, -54.635}, {-63.785, -59.814}, {-57.839, -64.586}, {-51.519, -68.938}, {-44.871, -72.858}, {-37.943, -76.332}, {-30.782, -79.348}, {-23.434, -81.894}, {-15.947, -83.956}, {-8.367, -85.523}, {-0.741, -86.581}, {6.884, -87.118}, {14.46, -87.121}, {21.941, -86.577}, {29.28, -85.475}, {36.431, -83.8}, {43.345, -81.541}, {49.976, -78.686}, {56.278, -75.22}, {62.203, -71.132}, {67.704, -66.409}, {73.446, -60.364}, {78.374, -54.029}, {82.506, -47.441}, {85.863, -40.637}, {88.462, -33.653}, {90.322, -26.526}, {91.461, -19.294}, {91.899, -11.992}, {91.654, -4.659}, {90.746, 2.669}, {89.192, 9.955}, {87.011, 17.163}, {84.222, 24.255}, {80.845, 31.194}, {76.896, 37.944}, {72.396, 44.468}, {67.363, 50.728}, {61.816, 56.688}, {56.232, 61.872}, {50.304, 66.615}, {44.07, 70.907}, {37.568, 74.735}, {30.835, 78.091}, {23.91, 80.962}, {16.828, 83.337}, {9.63, 85.207}, {2.351, 86.559}, {-4.971, 87.383}, {-12.297, 87.669}, {-19.591, 87.404}, {-26.815, 86.579}, {-33.93, 85.182}, {-40.901, 83.202}, {-47.688, 80.629}, {-54.254, 77.451}, {-60.562, 73.658}, {-66.574, 69.239}, {-72.253, 64.182}, {-42.048, 32.604}, {-36.102, 37.608}, {-29.329, 40.96}, {-21.973, 42.833}, {-14.275, 43.397}, {-6.477, 42.824}, {1.179, 41.286}, {8.45, 38.956}, {15.096, 36.005}, {20.873, 32.604}, {25.864, 28.942}, {31.126, 24.443}, {36.304, 19.198}, {41.044, 13.302}, {44.991, 6.847}, {47.79, -0.074}, {49.086, -7.367}, {48.525, -14.94}, {45.751, -22.698}, {40.409, -30.55}, {33.361, -37.212}, {25.834, -41.649}, {18.025, -44.139}, {10.129, -44.963}, {2.342, -44.4}, {-5.14, -42.728}, {-12.121, -40.228}, {-18.405, -37.179}, {-23.796, -33.86}, {-28.099, -30.55}, {-32.136, -26.889}, {-36.606, -22.388}, {-41.128, -17.142}, {-45.318, -11.244}, {-48.793, -4.788}, {-51.17, 2.134}, {-52.067, 9.427}, {-51.101, 16.999}, {-47.889, 24.756}, {-42.048, 32.604}}),
          Polygon(lineColor = {64, 64, 64}, fillColor = {71, 152, 255}, points = {{-72.253, 64.182}, {-66.574, 69.239}, {-60.562, 73.658}, {-54.254, 77.451}, {-47.688, 80.629}, {-40.901, 83.202}, {-33.93, 85.182}, {-26.815, 86.579}, {-19.591, 87.404}, {-12.297, 87.669}, {-4.971, 87.383}, {2.351, 86.559}, {9.63, 85.207}, {16.828, 83.337}, {23.91, 80.962}, {30.835, 78.091}, {37.568, 74.735}, {44.07, 70.907}, {50.304, 66.615}, {56.232, 61.872}, {61.816, 56.688}, {67.363, 50.728}, {72.396, 44.468}, {76.896, 37.944}, {80.845, 31.194}, {84.222, 24.255}, {87.011, 17.163}, {89.192, 9.955}, {90.746, 2.669}, {91.654, -4.659}, {91.899, -11.992}, {91.461, -19.294}, {90.322, -26.526}, {88.462, -33.653}, {85.863, -40.637}, {82.506, -47.441}, {78.374, -54.029}, {73.446, -60.364}, {67.704, -66.409}, {62.203, -71.132}, {56.278, -75.22}, {49.976, -78.686}, {43.345, -81.541}, {36.431, -83.8}, {29.28, -85.475}, {21.941, -86.577}, {14.46, -87.121}, {6.884, -87.118}, {-0.741, -86.581}, {-8.367, -85.523}, {-15.947, -83.956}, {-23.434, -81.894}, {-30.782, -79.348}, {-37.943, -76.332}, {-44.871, -72.858}, {-51.519, -68.938}, {-57.839, -64.586}, {-63.785, -59.814}, {-69.309, -54.635}, {-74.852, -48.503}, {-79.709, -42.09}, {-83.892, -35.437}, {-87.411, -28.586}, {-90.273, -21.582}, {-92.491, -14.465}, {-94.072, -7.28}, {-95.027, -0.067}, {-95.365, 7.13}, {-95.097, 14.269}, {-94.231, 21.307}, {-92.777, 28.202}, {-90.745, 34.911}, {-88.145, 41.392}, {-84.986, 47.602}, {-81.278, 53.499}, {-77.03, 59.04}, {-72.253, 64.182}}, smooth = Smooth.Bezier),
          Polygon(fillColor = {10, 90, 224}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-90.183, 4.774}, {-89.29, -2.507}, {-87.65, -9.672}, {-85.311, -16.688}, {-82.321, -23.518}, {-78.731, -30.128}, {-74.59, -36.482}, {-69.946, -42.545}, {-64.848, -48.282}, {-59.347, -53.657}, {-53.49, -58.634}, {-47.328, -63.18}, {-40.909, -67.257}, {-34.282, -70.832}, {-27.497, -73.868}, {-20.602, -76.331}, {-13.647, -78.185}, {-5.658, -79.626}, {2.34, -80.443}, {10.288, -80.644}, {18.126, -80.24}, {25.794, -79.24}, {33.233, -77.653}, {40.384, -75.488}, {47.186, -72.756}, {53.58, -69.465}, {59.505, -65.625}, {64.904, -61.246}, {69.715, -56.337}, {73.88, -50.907}, {77.338, -44.966}, {72.917, -49.023}, {67.981, -52.591}, {62.575, -55.671}, {56.742, -58.265}, {50.527, -60.374}, {43.974, -62}, {37.126, -63.144}, {30.029, -63.808}, {22.726, -63.992}, {15.26, -63.699}, {7.678, -62.93}, {0.022, -61.686}, {-7.664, -59.969}, {-15.335, -57.779}, {-22.947, -55.12}, {-30.456, -51.991}, {-37.819, -48.395}, {-44.99, -44.333}, {-51.925, -39.806}, {-58.582, -34.816}, {-64.915, -29.364}, {-70.88, -23.451}, {-76.433, -17.08}, {-81.531, -10.251}, {-86.129, -2.966}, {-90.183, 4.774}}, smooth = Smooth.Bezier),
          Polygon(fillColor = {156, 203, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{0.803, -51.958}, {11.03, -53.644}, {20.576, -54.192}, {29.425, -53.684}, {37.562, -52.2}, {44.974, -49.821}, {51.644, -46.628}, {57.559, -42.703}, {62.704, -38.126}, {67.064, -32.978}, {70.624, -27.34}, {73.369, -21.294}, {75.285, -14.92}, {76.358, -8.3}, {76.572, -1.513}, {75.912, 5.358}, {74.365, 12.233}, {71.914, 19.03}, {68.546, 25.669}, {64.246, 32.069}, {68.464, 23.809}, {71.022, 16.316}, {71.227, 10.492}, {68.389, 7.237}, {61.817, 7.45}, {63.346, 1.807}, {64.026, -4.042}, {63.843, -9.992}, {62.781, -15.937}, {60.828, -21.772}, {57.969, -27.392}, {54.19, -32.691}, {49.477, -37.563}, {43.817, -41.905}, {37.194, -45.61}, {29.595, -48.574}, {21.006, -50.69}, {11.414, -51.853}, {0.803, -51.958}}, smooth = Smooth.Bezier),
          Polygon(fillColor = {10, 90, 224}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-45.225, -15.029}, {-49.203, -8.642}, {-52.162, -1.742}, {-54.02, 5.476}, {-54.695, 12.821}, {-54.106, 20.097}, {-52.17, 27.112}, {-48.806, 33.671}, {-43.932, 39.581}, {-37.465, 44.648}, {-31.91, 47.581}, {-25.763, 49.807}, {-19.146, 51.3}, {-12.181, 52.031}, {-4.989, 51.974}, {2.308, 51.103}, {9.588, 49.389}, {16.73, 46.807}, {23.612, 43.33}, {30.112, 38.929}, {36.108, 33.579}, {41.479, 27.252}, {35.949, 35.695}, {30.184, 42.766}, {24.221, 48.561}, {18.099, 53.176}, {11.854, 56.706}, {5.525, 59.247}, {-0.853, 60.892}, {-7.24, 61.739}, {-13.601, 61.881}, {-19.897, 61.415}, {-26.091, 60.436}, {-34.854, 57.822}, {-42.105, 53.874}, {-47.925, 48.813}, {-52.395, 42.856}, {-55.596, 36.221}, {-57.609, 29.128}, {-58.514, 21.794}, {-58.393, 14.437}, {-57.327, 7.278}, {-55.396, 0.533}, {-52.681, -5.579}, {-49.264, -10.839}, {-45.225, -15.029}}, smooth = Smooth.Bezier),
          Polygon(fillColor = {156, 203, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-61.245, -15.029}, {-64.25, -7.37}, {-66.703, 0.324}, {-68.557, 7.994}, {-69.768, 15.582}, {-70.289, 23.03}, {-70.075, 30.28}, {-69.08, 37.274}, {-67.259, 43.954}, {-64.565, 50.261}, {-60.954, 56.138}, {-56.379, 61.526}, {-50.794, 66.368}, {-44.155, 70.605}, {-38.685, 73.337}, {-32.863, 75.726}, {-26.675, 77.722}, {-20.107, 79.277}, {-13.142, 80.344}, {-5.768, 80.876}, {2.031, 80.823}, {10.27, 80.138}, {18.963, 78.773}, {28.124, 76.68}, {17.648, 80.219}, {7.69, 82.637}, {-1.726, 84.047}, {-10.579, 84.565}, {-18.845, 84.302}, {-26.501, 83.375}, {-33.526, 81.896}, {-39.897, 79.98}, {-45.592, 77.74}, {-50.587, 75.291}, {-54.86, 72.746}, {-61.395, 67.72}, {-66.745, 62.054}, {-70.958, 55.843}, {-74.083, 49.184}, {-76.168, 42.174}, {-77.262, 34.908}, {-77.413, 27.483}, {-76.671, 19.994}, {-75.082, 12.539}, {-72.697, 5.213}, {-69.564, -1.888}, {-65.73, -8.667}, {-61.245, -15.029}}, smooth = Smooth.Bezier),
          Polygon(lineColor = {64, 64, 64}, fillColor = {255, 255, 255}, points = {{-42.048, 32.604}, {-36.102, 37.608}, {-29.329, 40.96}, {-21.973, 42.833}, {-14.275, 43.397}, {-6.477, 42.824}, {1.179, 41.286}, {8.45, 38.956}, {15.096, 36.005}, {20.873, 32.604}, {25.864, 28.942}, {31.126, 24.443}, {36.304, 19.198}, {41.044, 13.302}, {44.991, 6.847}, {47.79, -0.074}, {49.086, -7.367}, {48.525, -14.94}, {45.751, -22.698}, {40.409, -30.55}, {33.361, -37.212}, {25.834, -41.649}, {18.025, -44.139}, {10.129, -44.963}, {2.342, -44.4}, {-5.14, -42.728}, {-12.121, -40.228}, {-18.405, -37.179}, {-23.796, -33.86}, {-28.099, -30.55}, {-32.136, -26.889}, {-36.606, -22.388}, {-41.128, -17.142}, {-45.318, -11.244}, {-48.793, -4.788}, {-51.17, 2.134}, {-52.067, 9.427}, {-51.101, 16.999}, {-47.889, 24.756}, {-42.048, 32.604}})}, coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10})),
      Documentation(info = "<html> <p>
Model <strong>Torus</strong> visualizes a torus. The center of the torus is located at
connector frame_a (visualized by the red coordinate system in the figure below).
The left image below shows a torus with ri=0.5 m and ro = 0.2 m.
The right images below shows the torus with the additional parameter
settings:
</p>
<pre>
  opening    =   45 degree
  startAngle = -135 degree
  stopAngle  =  135 degree
</pre>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/Torus.png\">
</blockquote>

<p>
In the advanced menu the discretization of the surface visualization can be defined by
the number of points of the inner radius of the torus (n_ri) and by
the number of points of the outer radius of the torus (n_ro).
In case the torus is closed (that is, opening = 0 degree),
the actual number of points is one less (that is n_ri-1, n_ro-1), because the first and
the last point of the parametrization coincide in this case.
</p>
</html>", revisions="<html>
  <ul>
  <li> July 2010 by Martin Otter<br>
       Adapted to the new Surface model.</li>
  <li> July 2005 by Dirk Zimmer (practical training at DLR)<br>
       First version to visualize a multi-level tyre wheel model.</li>
  </ul>
</html>"));
  end Torus;

  model VoluminousWheel "Visualizing a voluminous wheel"
    extends Modelica.Mechanics.MultiBody.Interfaces.PartialVisualizer;

    parameter Boolean animation=true "= true, if animation shall be enabled";

    parameter SI.Radius rTire=0.25 "Radius of the tire";
    parameter SI.Radius rRim= 0.14 "Radius of the rim";
    parameter SI.Radius width=0.25 "Width of the tire";
    parameter SI.Radius rCurvature=0.30 "Radius of the curvature of the tire";

    parameter Modelica.Mechanics.MultiBody.Types.RealColor color={64,64,64}
      "Color of tire" annotation(Dialog(enable=animation, colorSelector=true, group="Material properties"));
    parameter Types.SpecularCoefficient specularCoefficient = 0.5
      "Reflection of ambient light (= 0: light is completely absorbed)" annotation(Dialog(enable=animation, group="Material properties"));
    parameter Integer n_rTire=40 "Number of points along rTire" annotation(Dialog(enable=animation, tab="Discretization"));
    parameter Integer n_rCurvature=20 "Number of points along rCurvature" annotation(Dialog(enable=animation, tab="Discretization"));

  protected
    parameter SI.Radius rw = (width/2);
    parameter SI.Radius rCurvature2 = if rCurvature > rw then rCurvature else rw;
    parameter SI.Radius h =     sqrt(1-(rw/rCurvature2)*(rw/rCurvature2))*rCurvature2;
    parameter SI.Radius ri =    rTire-rCurvature2;
    parameter SI.Radius rRim2 = if rRim < 0 then 0 else if rRim > ri+h then ri+h else rRim;

      Visualizers.Advanced.Shape pipe(
        shapeType="pipe",
        color=color,
        length= width,
        width=2*(ri+h),
        height=2*(ri+h),
        lengthDirection={0,1,0},
        widthDirection={0,0,1},
        extra=(rRim2)/(ri+h),
        r=frame_a.r_0,
        r_shape= -{0,1,0}*(width/2),
        R= frame_a.R,
        specularCoefficient = specularCoefficient) if world.enableAnimation and animation
            annotation (Placement(transformation(extent={{-20,-10},{0,10}})));

      Visualizers.Advanced.Surface torus(
        redeclare function surfaceCharacteristic =
          Modelica.Mechanics.MultiBody.Visualizers.Advanced.SurfaceCharacteristics.torus (
            ri=ri,
            ro=rCurvature2,
            opening=Modelica.Constants.pi - Modelica.Math.asin(rw/rCurvature2)),
            nu=n_rTire,
            nv=n_rCurvature,
            multiColoredSurface=false,
            wireframe=false,
            color=color,
            specularCoefficient=specularCoefficient,
            transparency=0,
            R=frame_a.R,
            r_0=frame_a.r_0) if world.enableAnimation and animation
      annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));

  equation
    // No forces and torques
    frame_a.f = zeros(3);
    frame_a.t = zeros(3);
    annotation(
      Icon(
        graphics = {
          Polygon(lineColor = {64, 64, 64}, fillColor = {191, 191, 191}, fillPattern = FillPattern.Sphere, points = {{-40, 80}, {-20, 90}, {15, 90}, {40, 85}, {58.776, 73.91}, {70.456, 56.568}, {74.951, 44.383}, {78.26, 30.614}, {80.302, 15.68}, {81, 0}, {81, 0}, {80.302, -15.68}, {78.26, -30.614}, {74.951, -44.383}, {70.456, -56.568}, {58.776, -73.91}, {40, -85}, {15, -90}, {-20, -90}, {-40, -80}, {-48.776, -73.91}, {-60.456, -56.568}, {-64.951, -44.383}, {-68.26, -30.614}, {-70.302, -15.68}, {-71, 0}, {-71, 0}, {-70.302, 15.68}, {-68.26, 30.614}, {-64.951, 44.383}, {-60.456, 56.568}, {-48.776, 73.91}}, smooth = Smooth.Bezier),
          Polygon(lineColor = {64, 64, 64}, fillColor = {64, 64, 64}, fillPattern = FillPattern.Solid, points = {{1, 0}, {0.302, 15.68}, {-1.74, 30.614}, {-5.049, 44.383}, {-9.544, 56.568}, {-21.224, 73.91}, {-35, 80}, {-48.776, 73.91}, {-60.456, 56.568}, {-64.951, 44.383}, {-68.26, 30.614}, {-70.302, 15.68}, {-71, 0}, {-70.302, -15.68}, {-68.26, -30.614}, {-64.951, -44.383}, {-60.456, -56.568}, {-48.776, -73.91}, {-35, -80}, {-21.224, -73.91}, {-9.544, -56.568}, {-5.049, -44.383}, {-1.74, -30.614}, {0.302, -15.68}, {1, 0}}, smooth = Smooth.Bezier),
          Polygon(lineColor = {64, 64, 64}, fillColor = {191, 191, 191}, fillPattern = FillPattern.HorizontalCylinder, points = {{-12.5, 0}, {-14.213, -19.134}, {-19.09, -35.355}, {-26.39, -46.194}, {-35, -50}, {-43.61, -46.194}, {-50.91, -35.355}, {-55.787, -19.134}, {-57.5, 0}, {-55.787, 19.134}, {-50.91, 35.355}, {-43.61, 46.194}, {-35, 50}, {-26.39, 46.194}, {-19.09, 35.355}, {-14.213, 19.134}, {-12.5, 0}}, smooth = Smooth.Bezier),
          Text(textColor = {0,0,255}, extent = {{-150, 100}, {150, 140}}, textString = "%name"),
          Rectangle(origin = {6.091, 0}, lineColor = {95, 95, 95}, fillColor = {215, 215, 215}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-102.091, -8}, {-19.142, 8}})},
        coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})),
      Documentation(info = "<html>
<p>
Model <strong>VoluminousWheel</strong> provides a simple visualization of a tire using
a torus and a pipe shape object. The center of the wheel is located at
connector frame_a (visualized by the red coordinate system in the figure below).
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/VoluminousWheel.png\">
</blockquote>
</html>",   revisions="<html>
  <ul>
  <li> July 2010 by Martin Otter<br>
       Adapted to the new Surface model.</li>
  <li> July 2005 by Dirk Zimmer (practical training at DLR)<br>
       First version to visualize a multi-level tyre wheel model.</li>
  </ul>
</html>"));
  end VoluminousWheel;

  model PipeWithScalarField
    "Visualizing a pipe with scalar field quantities along the pipe axis"
    extends Modelica.Mechanics.MultiBody.Interfaces.PartialVisualizer;

    parameter Boolean animation=true "= true, if animation shall be enabled";

    parameter Modelica.SIunits.Radius rOuter "Outer radius of pipe" annotation(Dialog(enable=animation));
    parameter Modelica.SIunits.Length length "Length of pipe" annotation(Dialog(enable=animation));

    parameter Real xsi[:](each min=0, each max=1)= Modelica.Math.Vectors.relNodePositions(12)
      "Vector of relative positions along the pipe with x[1] = 0, x[end] = 1"
      annotation(Dialog(enable=animation));
    input Real T[size(xsi,1)]
      "Vector of values at positions xsi*length (will be visualized by color)" annotation(Dialog(enable=animation));
    parameter Real T_min "Minimum value of T that corresponds to colorMap[1,:]" annotation(Dialog(enable=animation));
    parameter Real T_max
      "Maximum value of T that corresponds to colorMap[end,:]" annotation(Dialog(enable=animation));
    replaceable function colorMap =
      Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps.jet
      constrainedby Modelica.Mechanics.MultiBody.Interfaces.partialColorMap
      "Function defining the color map"
      annotation(choicesAllMatching=true, Dialog(enable=animation,group="Color coding"),
      Documentation(info="<html>
<p>This replaceable function defines a particular color map.</p>
<!--a placeholder to fulfill minimum documentation length-->
</html>"));

    parameter Integer n_colors=64 "Number of colors in the colorMap" annotation(Dialog(enable=animation,group="Color coding"));
    parameter Types.SpecularCoefficient specularCoefficient = 0.7
      "Reflection of ambient light (= 0: light is completely absorbed)" annotation(Dialog(enable=animation,group="Color coding"));
    parameter Real transparency=0
      "Transparency of shape: 0 (= opaque) ... 1 (= fully transparent)"
      annotation(Dialog(enable=animation,group="Color coding"));

    parameter Integer n_rOuter=30 "Number of points along outer radius" annotation(Dialog(enable=animation,tab="Discretization"));
    parameter Integer n_length=20 "Number of points along length" annotation(Dialog(enable=animation,tab="Discretization"));

  protected
    Advanced.PipeWithScalarField pipe(redeclare function colorMap = colorMap,
           rOuter=rOuter,
           length=length,
           xsi=xsi,
           T=T,
           T_min=T_min,
           T_max=T_max,
           n_colors=n_colors,
           n_rOuter=n_rOuter,
           n_length=n_length,
           specularCoefficient=specularCoefficient,
           transparency=transparency,
           R=frame_a.R,
           r_0=frame_a.r_0) if world.enableAnimation and animation
      annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  equation
    // No forces and torques
    frame_a.f = zeros(3);
    frame_a.t = zeros(3);

    annotation(
      Icon(
        graphics = {
          Text(textColor = {0,0,255}, extent = {{-150, 50}, {150, 90}}, textString = "%name"),
          Polygon(origin = {-5, 0}, fillColor = {0, 0, 163}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-70, -33.5}, {-70, -33.5}, {-76, -33.333}, {-82.378, -30.796}, {-87.785, -23.57}, {-90.44, -16.645}, {-92.096, -8.651}, {-92.667, 0}, {-92.096, 8.651}, {-90.44, 16.645}, {-87.785, 23.57}, {-82.378, 30.796}, {-76, 33.333}, {-70, 33.5}, {-70, 33.5}}, smooth = Smooth.Bezier),
          Polygon(origin = {-5, 0}, fillColor = {0, 56, 195}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-65.833, 33.5}, {-65.833, 33.5}, {-71.833, 33.333}, {-78.211, 30.796}, {-83.618, 23.57}, {-86.273, 16.645}, {-87.929, 8.651}, {-88.5, 0}, {-87.929, -8.651}, {-86.273, -16.645}, {-83.618, -23.57}, {-78.211, -30.796}, {-71.833, -33.333}, {-65.833, -33.5}, {-65.833, -33.5}}, smooth = Smooth.Bezier),
          Polygon(origin = {-5, 0}, fillColor = {0, 76, 210}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-61.667, 33.5}, {-61.667, 33.5}, {-67.667, 33.333}, {-74.045, 30.796}, {-79.452, 23.57}, {-82.106, 16.645}, {-83.762, 8.651}, {-84.333, 0}, {-83.762, -8.651}, {-82.106, -16.645}, {-79.452, -23.57}, {-74.045, -30.796}, {-67.667, -33.333}, {-61.667, -33.5}, {-61.667, -33.5}}, smooth = Smooth.Bezier),
          Polygon(origin = {-5, 0}, fillColor = {0, 95, 223}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-57.5, 33.5}, {-57.5, 33.5}, {-63.5, 33.333}, {-69.878, 30.796}, {-75.285, 23.57}, {-77.94, 16.645}, {-79.596, 8.651}, {-80.167, 0}, {-79.596, -8.651}, {-77.94, -16.645}, {-75.285, -23.57}, {-69.878, -30.796}, {-63.5, -33.333}, {-57.5, -33.5}, {-57.5, -33.5}}, smooth = Smooth.Bezier),
          Polygon(origin = {-5, 0}, fillColor = {0, 114, 234}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-53.333, 33.5}, {-53.333, 33.5}, {-59.333, 33.333}, {-65.711, 30.796}, {-71.118, 23.57}, {-73.773, 16.645}, {-75.429, 8.651}, {-76, 0}, {-75.429, -8.651}, {-73.773, -16.645}, {-71.118, -23.57}, {-65.711, -30.796}, {-59.333, -33.333}, {-53.333, -33.5}, {-53.333, -33.5}}, smooth = Smooth.Bezier),
          Polygon(origin = {-5, 0}, fillColor = {0, 132, 245}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-49.167, 33.5}, {-49.167, 33.5}, {-55.167, 33.333}, {-61.545, 30.796}, {-66.952, 23.57}, {-69.606, 16.645}, {-71.262, 8.651}, {-71.833, 0}, {-71.262, -8.651}, {-69.606, -16.645}, {-66.952, -23.57}, {-61.545, -30.796}, {-55.167, -33.333}, {-49.167, -33.5}, {-49.167, -33.5}}, smooth = Smooth.Bezier),
          Polygon(origin = {-5, 0}, fillColor = {18, 151, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-45, 33.5}, {-45, 33.5}, {-51, 33.333}, {-57.378, 30.796}, {-62.785, 23.57}, {-65.44, 16.645}, {-67.096, 8.651}, {-67.667, 0}, {-67.096, -8.651}, {-65.44, -16.645}, {-62.785, -23.57}, {-57.378, -30.796}, {-51, -33.333}, {-45, -33.5}, {-45, -33.5}}, smooth = Smooth.Bezier),
          Polygon(origin = {-5, 0}, fillColor = {0, 188, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-40.833, 33.5}, {-40.833, 33.5}, {-46.833, 33.333}, {-53.211, 30.796}, {-58.618, 23.57}, {-61.273, 16.645}, {-62.929, 8.651}, {-63.5, 0}, {-62.929, -8.651}, {-61.273, -16.645}, {-58.618, -23.57}, {-53.211, -30.796}, {-46.833, -33.333}, {-40.833, -33.5}, {-40.833, -33.5}}, smooth = Smooth.Bezier),
          Polygon(origin = {-5, 0}, fillColor = {0, 205, 253}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-36.667, 33.5}, {-36.667, 33.5}, {-42.667, 33.333}, {-49.045, 30.796}, {-54.452, 23.57}, {-57.106, 16.645}, {-58.762, 8.651}, {-59.333, 0}, {-58.762, -8.651}, {-57.106, -16.645}, {-54.452, -23.57}, {-49.045, -30.796}, {-42.667, -33.333}, {-36.667, -33.5}, {-36.667, -33.5}}, smooth = Smooth.Bezier),
          Polygon(origin = {-5, 0}, fillColor = {0, 220, 235}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-32.5, 33.5}, {-32.5, 33.5}, {-38.5, 33.333}, {-44.878, 30.796}, {-50.285, 23.57}, {-52.94, 16.645}, {-54.596, 8.651}, {-55.167, 0}, {-54.596, -8.651}, {-52.94, -16.645}, {-50.285, -23.57}, {-44.878, -30.796}, {-38.5, -33.333}, {-32.5, -33.5}, {-32.5, -33.5}}, smooth = Smooth.Bezier),
          Polygon(origin = {-5, 0}, fillColor = {0, 233, 211}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-28.333, 33.5}, {-28.333, 33.5}, {-34.333, 33.333}, {-40.711, 30.796}, {-46.118, 23.57}, {-48.773, 16.645}, {-50.429, 8.651}, {-51, 0}, {-50.429, -8.651}, {-48.773, -16.645}, {-46.118, -23.57}, {-40.711, -30.796}, {-34.333, -33.333}, {-28.333, -33.5}, {-28.333, -33.5}}, smooth = Smooth.Bezier),
          Polygon(origin = {-5, 0}, fillColor = {0, 245, 183}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-24.167, 33.5}, {-24.167, 33.5}, {-30.167, 33.333}, {-36.545, 30.796}, {-41.952, 23.57}, {-44.606, 16.645}, {-46.262, 8.651}, {-46.833, 0}, {-46.262, -8.651}, {-44.606, -16.645}, {-41.952, -23.57}, {-36.545, -30.796}, {-30.167, -33.333}, {-24.167, -33.5}, {-24.167, -33.5}}, smooth = Smooth.Bezier),
          Polygon(origin = {-5, 0}, fillColor = {34, 255, 154}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-20, 33.5}, {-20, 33.5}, {-26, 33.333}, {-32.378, 30.796}, {-37.785, 23.57}, {-40.44, 16.645}, {-42.096, 8.651}, {-42.667, 0}, {-42.096, -8.651}, {-40.44, -16.645}, {-37.785, -23.57}, {-32.378, -30.796}, {-26, -33.333}, {-20, -33.5}, {-20, -33.5}}, smooth = Smooth.Bezier),
          Polygon(origin = {-5, 0}, fillColor = {0, 255, 128}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-15.833, 33.5}, {-15.833, 33.5}, {-21.833, 33.333}, {-28.211, 30.796}, {-33.618, 23.57}, {-36.273, 16.645}, {-37.929, 8.651}, {-38.5, 0}, {-37.929, -8.651}, {-36.273, -16.645}, {-33.618, -23.57}, {-28.211, -30.796}, {-21.833, -33.333}, {-15.833, -33.5}, {-15.833, -33.5}}, smooth = Smooth.Bezier),
          Polygon(origin = {-5, 0}, fillColor = {0, 255, 113}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-11.667, 33.5}, {-11.667, 33.5}, {-17.667, 33.333}, {-24.045, 30.796}, {-29.452, 23.57}, {-32.106, 16.645}, {-33.762, 8.651}, {-34.333, 0}, {-33.762, -8.651}, {-32.106, -16.645}, {-29.452, -23.57}, {-24.045, -30.796}, {-17.667, -33.333}, {-11.667, -33.5}, {-11.667, -33.5}}, smooth = Smooth.Bezier),
          Polygon(origin = {-5, 0}, fillColor = {0, 255, 96}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-7.5, 33.5}, {-7.5, 33.5}, {-13.5, 33.333}, {-19.878, 30.796}, {-25.285, 23.57}, {-27.94, 16.645}, {-29.596, 8.651}, {-30.167, 0}, {-29.596, -8.651}, {-27.94, -16.645}, {-25.285, -23.57}, {-19.878, -30.796}, {-13.5, -33.333}, {-7.5, -33.5}, {-7.5, -33.5}}, smooth = Smooth.Bezier),
          Polygon(origin = {-5, 0}, fillColor = {0, 255, 77}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-3.333, 33.5}, {-3.333, 33.5}, {-9.333, 33.333}, {-15.711, 30.796}, {-21.118, 23.57}, {-23.773, 16.645}, {-25.429, 8.651}, {-26, 0}, {-25.429, -8.651}, {-23.773, -16.645}, {-21.118, -23.57}, {-15.711, -30.796}, {-9.333, -33.333}, {-3.333, -33.5}, {-3.333, -33.5}}, smooth = Smooth.Bezier),
          Polygon(origin = {-5, 0}, fillColor = {15, 255, 54}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{0.833, 33.5}, {0.833, 33.5}, {-5.167, 33.333}, {-11.545, 30.796}, {-16.952, 23.57}, {-19.607, 16.645}, {-21.262, 8.651}, {-21.833, 0}, {-21.262, -8.651}, {-19.607, -16.645}, {-16.952, -23.57}, {-11.545, -30.796}, {-5.167, -33.333}, {0.833, -33.5}, {0.833, -33.5}}, smooth = Smooth.Bezier),
          Polygon(origin = {-5, 0}, fillColor = {35, 255, 6}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{5, 33.5}, {5, 33.5}, {-1, 33.333}, {-7.378, 30.796}, {-12.785, 23.57}, {-15.44, 16.645}, {-17.096, 8.651}, {-17.667, 0}, {-17.096, -8.651}, {-15.44, -16.645}, {-12.785, -23.57}, {-7.378, -30.796}, {-1, -33.333}, {5, -33.5}, {5, -33.5}}, smooth = Smooth.Bezier),
          Polygon(origin = {-5, 0}, fillColor = {136, 255, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{9.167, 33.5}, {9.167, 33.5}, {3.167, 33.333}, {-3.211, 30.796}, {-8.618, 23.57}, {-11.273, 16.645}, {-12.929, 8.651}, {-13.5, 0}, {-12.929, -8.651}, {-11.273, -16.645}, {-8.618, -23.57}, {-3.211, -30.796}, {3.167, -33.333}, {9.167, -33.5}, {9.167, -33.5}}, smooth = Smooth.Bezier),
          Polygon(origin = {-5, 0}, fillColor = {165, 255, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{13.333, 33.5}, {13.333, 33.5}, {7.333, 33.333}, {0.955, 30.796}, {-4.452, 23.57}, {-7.106, 16.645}, {-8.762, 8.651}, {-9.333, 0}, {-8.762, -8.651}, {-7.106, -16.645}, {-4.452, -23.57}, {0.955, -30.796}, {7.333, -33.333}, {13.333, -33.5}, {13.333, -33.5}}, smooth = Smooth.Bezier),
          Polygon(origin = {-5, 0}, fillColor = {191, 255, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{17.5, 33.5}, {17.5, 33.5}, {11.5, 33.333}, {5.122, 30.796}, {-0.285, 23.57}, {-2.94, 16.645}, {-4.596, 8.651}, {-5.167, 0}, {-4.596, -8.651}, {-2.94, -16.645}, {-0.285, -23.57}, {5.122, -30.796}, {11.5, -33.333}, {17.5, -33.5}, {17.5, -33.5}}, smooth = Smooth.Bezier),
          Polygon(origin = {-5, 0}, fillColor = {214, 255, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{21.667, 33.5}, {21.667, 33.5}, {15.667, 33.333}, {9.289, 30.796}, {3.882, 23.57}, {1.227, 16.645}, {-0.429, 8.651}, {-1, 0}, {-0.429, -8.651}, {1.227, -16.645}, {3.882, -23.57}, {9.289, -30.796}, {15.667, -33.333}, {21.667, -33.5}, {21.667, -33.5}}, smooth = Smooth.Bezier),
          Polygon(origin = {-5, 0}, fillColor = {235, 255, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{25.833, 33.5}, {25.833, 33.5}, {19.833, 33.333}, {13.455, 30.796}, {8.048, 23.57}, {5.394, 16.645}, {3.738, 8.651}, {3.167, 0}, {3.738, -8.651}, {5.394, -16.645}, {8.048, -23.57}, {13.455, -30.796}, {19.833, -33.333}, {25.833, -33.5}, {25.833, -33.5}}, smooth = Smooth.Bezier),
          Polygon(origin = {-5, 0}, fillColor = {255, 255, 11}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{30, 33.5}, {30, 33.5}, {24, 33.333}, {17.622, 30.796}, {12.215, 23.57}, {9.56, 16.645}, {7.904, 8.651}, {7.333, 0}, {7.904, -8.651}, {9.56, -16.645}, {12.215, -23.57}, {17.622, -30.796}, {24, -33.333}, {30, -33.5}, {30, -33.5}}, smooth = Smooth.Bezier),
          Polygon(origin = {-5, 0}, fillColor = {255, 226, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{34.167, 33.5}, {34.167, 33.5}, {28.167, 33.333}, {21.789, 30.796}, {16.382, 23.57}, {13.727, 16.645}, {12.071, 8.651}, {11.5, 0}, {12.071, -8.651}, {13.727, -16.645}, {16.382, -23.57}, {21.789, -30.796}, {28.167, -33.333}, {34.167, -33.5}, {34.167, -33.5}}, smooth = Smooth.Bezier),
          Polygon(origin = {-5, 0}, fillColor = {255, 211, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{38.333, 33.5}, {38.333, 33.5}, {32.333, 33.333}, {25.955, 30.796}, {20.548, 23.57}, {17.893, 16.645}, {16.238, 8.651}, {15.667, 0}, {16.238, -8.651}, {17.893, -16.645}, {20.548, -23.57}, {25.955, -30.796}, {32.333, -33.333}, {38.333, -33.5}, {38.333, -33.5}}, smooth = Smooth.Bezier),
          Polygon(origin = {-5, 0}, fillColor = {255, 197, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{42.5, 33.5}, {42.5, 33.5}, {36.5, 33.333}, {30.122, 30.796}, {24.715, 23.57}, {22.06, 16.645}, {20.404, 8.651}, {19.833, 0}, {20.404, -8.651}, {22.06, -16.645}, {24.715, -23.57}, {30.122, -30.796}, {36.5, -33.333}, {42.5, -33.5}, {42.5, -33.5}}, smooth = Smooth.Bezier),
          Polygon(origin = {-5, 0}, fillColor = {255, 182, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{46.667, 33.5}, {46.667, 33.5}, {40.667, 33.333}, {34.289, 30.796}, {28.882, 23.57}, {26.227, 16.645}, {24.571, 8.651}, {24, 0}, {24.571, -8.651}, {26.227, -16.645}, {28.882, -23.57}, {34.289, -30.796}, {40.667, -33.333}, {46.667, -33.5}, {46.667, -33.5}}, smooth = Smooth.Bezier),
          Polygon(origin = {-5, 0}, fillColor = {255, 168, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{50.833, 33.5}, {50.833, 33.5}, {44.833, 33.333}, {38.455, 30.796}, {33.048, 23.57}, {30.393, 16.645}, {28.738, 8.651}, {28.167, 0}, {28.738, -8.651}, {30.393, -16.645}, {33.048, -23.57}, {38.455, -30.796}, {44.833, -33.333}, {50.833, -33.5}, {50.833, -33.5}}, smooth = Smooth.Bezier),
          Polygon(origin = {-5, 0}, fillColor = {253, 154, 9}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{55, 33.5}, {55, 33.5}, {49, 33.333}, {42.622, 30.796}, {37.215, 23.57}, {34.56, 16.645}, {32.904, 8.651}, {32.333, 0}, {32.904, -8.651}, {34.56, -16.645}, {37.215, -23.57}, {42.622, -30.796}, {49, -33.333}, {55, -33.5}, {55, -33.5}}, smooth = Smooth.Bezier),
          Polygon(origin = {-5, 0}, fillColor = {254, 127, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{59.167, 33.5}, {59.167, 33.5}, {53.167, 33.333}, {46.789, 30.796}, {41.382, 23.57}, {38.727, 16.645}, {37.071, 8.651}, {36.5, 0}, {37.071, -8.651}, {38.727, -16.645}, {41.382, -23.57}, {46.789, -30.796}, {53.167, -33.333}, {59.167, -33.5}, {59.167, -33.5}}, smooth = Smooth.Bezier),
          Polygon(origin = {-5, 0}, fillColor = {254, 112, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{63.333, 33.5}, {63.333, 33.5}, {57.333, 33.333}, {50.955, 30.796}, {45.548, 23.57}, {42.894, 16.645}, {41.238, 8.651}, {40.667, 0}, {41.238, -8.651}, {42.894, -16.645}, {45.548, -23.57}, {50.955, -30.796}, {57.333, -33.333}, {63.333, -33.5}, {63.333, -33.5}}, smooth = Smooth.Bezier),
          Polygon(origin = {-5, 0}, fillColor = {253, 96, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{67.5, 33.5}, {67.5, 33.5}, {61.5, 33.333}, {55.122, 30.796}, {49.715, 23.57}, {47.06, 16.645}, {45.404, 8.651}, {44.833, 0}, {45.404, -8.651}, {47.06, -16.645}, {49.715, -23.57}, {55.122, -30.796}, {61.5, -33.333}, {67.5, -33.5}, {67.5, -33.5}}, smooth = Smooth.Bezier),
          Polygon(origin = {-5, 0}, fillColor = {253, 77, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{71.667, 33.5}, {71.667, 33.5}, {65.667, 33.333}, {59.289, 30.796}, {53.882, 23.57}, {51.227, 16.645}, {49.571, 8.651}, {49, 0}, {49.571, -8.651}, {51.227, -16.645}, {53.882, -23.57}, {59.289, -30.796}, {65.667, -33.333}, {71.667, -33.5}, {71.667, -33.5}}, smooth = Smooth.Bezier),
          Polygon(origin = {-5, 0}, fillColor = {252, 52, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{74.5, 33.5}, {74.5, 33.5}, {69.833, 33.333}, {63.455, 30.796}, {58.048, 23.57}, {55.394, 16.645}, {53.738, 8.651}, {53.167, 0}, {53.738, -8.651}, {55.394, -16.645}, {58.048, -23.57}, {63.455, -30.796}, {69.833, -33.333}, {74, -33.5}, {74.5, -34}}, smooth = Smooth.Bezier),
          Polygon(origin = {-5, 0}, fillColor = {251, 0, 7}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{74, 33.333}, {67.622, 30.796}, {62.215, 23.57}, {59.56, 16.645}, {57.904, 8.651}, {57.333, 0}, {57.904, -8.651}, {59.56, -16.645}, {62.215, -23.57}, {67.622, -30.796}, {74, -33.333}}, smooth = Smooth.Bezier),
          Polygon(origin = {-5, 0}, lineColor = {107, 0, 4}, fillColor = {251, 0, 7}, fillPattern = FillPattern.Sphere, points = {{90.667, 0}, {90.096, 8.651}, {88.44, 16.645}, {85.785, 23.57}, {80.378, 30.796}, {74, 33.333}, {67.622, 30.796}, {62.215, 23.57}, {59.56, 16.645}, {57.904, 8.651}, {57.333, 0}, {57.904, -8.651}, {59.56, -16.645}, {62.215, -23.57}, {67.622, -30.796}, {74, -33.333}, {80.378, -30.796}, {85.785, -23.57}, {88.44, -16.645}, {90.096, -8.651}, {90.667, 0}}, smooth=Smooth.Bezier),                                                                                                                                                                                                        Line(origin = {-5, 0}, points = {{-76, 33.333}, {-76, 33.333}, {-82.378, 30.796}, {-87.785, 23.57}, {-90.44, 16.645}, {-92.096, 8.651}, {-92.667, 0}, {-92.096, -8.651}, {-90.44, -16.645}, {-87.785, -23.57}, {-82.378, -30.796}, {-76, -33.333}, {-76, -33.333}, {74, -33.333}, {74, -33.333}, {80.378, -30.796}, {85.785, -23.57}, {88.44, -16.645}, {90.096, -8.651}, {90.667, 0}, {90.096, 8.651}, {88.44, 16.645}, {85.785, 23.57}, {80.378, 30.796}, {74, 33.333}, {74, 33.333}, {-76, 33.333}}, color = {64, 64, 64}, arrowSize = 8, smooth = Smooth.Bezier)}, coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})),
    Documentation(info = "<html>
<p> 
Model <strong>PipeWithScalarField</strong> visualizes a pipe and a scalar
field along the pipe axis. The latter is shown by mapping the scalar
field to color values with a color map and utilizing this color
at the perimeter associated with the corresponding axis location.
Typically the scalar field value is a temperature, but might
be also another quantity.
Predefined color maps are available from
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps\">MultiBody.Visualizers.Colors.ColorMaps</a>
and can be selected via parameter \"colorMap\".
A color map with the corresponding scalar field values can be exported
as vector-graphics in svg-format with function
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.colorMapToSvg\">MultiBody.Visualizers.Colors.colorMapToSvg</a>.
Connector frame_a of this component is located in the center of the
circle at the left side of the pipe and the pipe axis is oriented
along the x-axis of frame_a, see figure below in which frame_a is visualized
with a coordinate system:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/PipeWithScalarField.png\">
</blockquote>

<p>
The color coding is shown in the next figure. It was generated with
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.colorMapToSvg\">MultiBody.Visualizers.Colors.colorMapToSvg</a>
using the following call:
</p>

<blockquote>
<pre>
colorMapToSvg(Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps.jet(),
              height=50, nScalars=6, T_max=100, caption=\"Temperature in C\");
</pre>
</blockquote>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/PipeWithScalarField-ColorMap.png\">
</blockquote>
</html>", revisions="<html>
  <ul>
  <li> July 2010 by Martin Otter<br>
       Adapted to the new Surface model.</li>
  <li> July 2005 by Dirk Zimmer (practical training at DLR)<br>
       First version to visualize a multi-level tyre wheel model.</li>
  </ul>
</html>"));
  end PipeWithScalarField;

  model Rectangle "Visualizing a planar rectangular surface"
    extends Modelica.Mechanics.MultiBody.Interfaces.PartialVisualizer;

    parameter Boolean animation=true "= true, if animation shall be enabled";
    parameter MultiBody.Types.Axis direction_u={1,0,0}
      "Vector along u-axis of rectangle resolved in frame_a"
      annotation(Evaluate=true, Dialog(enable=animation));
    parameter MultiBody.Types.Axis direction_v={0,1,0}
      "Vector along v-axis of rectangle resolved in frame_a"
      annotation(Evaluate=true, Dialog(enable=animation));

    parameter SI.Distance length_u=3 "Length of rectangle in direction u" annotation(Dialog(enable=animation));
    parameter SI.Distance length_v=1 "Length of rectangle in direction v" annotation(Dialog(enable=animation));
    parameter Integer nu(min=2)=3 "Number of points in direction u" annotation(Dialog(enable=animation,group="Discretization"));
    parameter Integer nv(min=2)=2 "Number of points in direction v" annotation(Dialog(enable=animation,group="Discretization"));

    parameter Boolean wireframe=false
      "= true: 3D model will be displayed without faces"
      annotation (Dialog(enable=animation, group="Material properties"),choices(checkBox=true));
    input Modelica.Mechanics.MultiBody.Types.RealColor color={0,128,255}
      "Color of surface" annotation(Dialog(enable=animation and not multiColoredSurface,colorSelector=true,group="Material properties"));
    input Types.SpecularCoefficient specularCoefficient = 0.7
      "Reflection of ambient light (= 0: light is completely absorbed)" annotation(Dialog(enable=animation,group="Material properties"));
    input Real transparency=0
      "Transparency of shape: 0 (= opaque) ... 1 (= fully transparent)"
      annotation(Dialog(enable=animation,group="Material properties"));

  protected
    Advanced.Surface surface(
      final multiColoredSurface=false,
      final wireframe=wireframe,
      final color=color,
      final specularCoefficient=specularCoefficient,
      final transparency=transparency,
      final R=Modelica.Mechanics.MultiBody.Frames.absoluteRotation(
          frame_a.R,Modelica.Mechanics.MultiBody.Frames.from_nxy(direction_u, direction_v)),
      final r_0=frame_a.r_0,
      final nu=nu,
      final nv=nv,
      redeclare function surfaceCharacteristic = Advanced.SurfaceCharacteristics.rectangle (
        lu=length_u, lv=length_v)) if world.enableAnimation and animation
      annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
    Modelica.Mechanics.MultiBody.Forces.Internal.ZeroForceAndTorque zeroForceAndTorque annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));

  equation
    connect(frame_a, zeroForceAndTorque.frame_a) annotation (Line(
        points={{-100,0},{-80,0}},
        color={95,95,95},
        thickness=0.5));
    annotation (
      Icon(graphics={
            Text(
            extent={{-150,80},{150,40}},
            textColor={0,0,255},
            textString="%name"),
          Polygon(
            points={{-50,20},{-90,-60},{70,-60},{90,20},{-50,20}},
            lineColor={95,95,95},
            fillColor={175,175,175},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-2,-18},{2,-22}},
            lineColor={95,95,95},
            fillColor={95,95,95},
            fillPattern=FillPattern.Solid),
          Line(points={{-100,0},{0,0},{0,-20}}, color={95,95,95}),
          Text(
            extent={{-140,-60},{140,-90}},
            lineThickness=0.5,
            fillColor={95,95,95},
            fillPattern=FillPattern.Solid,
            textString="%length_u x %length_v")}),
      Documentation(info="<html>
<p>
This model visualizes a planar rectangle. The center of the rectangle is located at
connector frame_a (visualized by the red coordinate system in the figure below).
The figure below shows two rectangles of the same parameters
</p>
<blockquote><pre>
nu = 8,
nv = 3,
length_u = 3,
length_v = 2.
</pre></blockquote>
<p>
The green rectangle on the right is visualized in wireframe thus highlighting the influence
of the discretization. Moreover, the u-axis of this rectangle is modified
so that the rectangle is rotated about the z-axis of frame_a.
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/Rectangle.png\">
</blockquote>
</html>"));
  end Rectangle;

  package Colors "Library of functions operating on color"
    extends Modelica.Icons.FunctionsPackage;
    package ColorMaps "Library of functions returning color maps"
      extends Modelica.Icons.FunctionsPackage;

      function jet "Returns the \"jet\" color map"
        extends Modelica.Mechanics.MultiBody.Interfaces.partialColorMap;
      protected
         Real    a=ceil(n_colors/4);
         Real    d=1/a;
         Integer b=integer(ceil(a/2));
         Integer c=integer(floor(a/2));
         Real    v1[:]={1-(b-i)*d for i in 1:b};
         Real    v2[:]=0+d:d:1;
         Real    v3[:]=1-d:-d:0;
         Real    v4[:]={0.5+(c-i)*d for i in 1:c};
         Real    cm[integer(ceil(n_colors/4))*4,3];
      algorithm
         cm:=255*[zeros(size(v1,1)),zeros(size(v1,1)),  v1;
                  zeros(size(v2,1)), v2,  fill(1., size(v2,1));
                  v2,              fill(1, size(v2,1)), v3;
                  fill(1, size(v3,1)),v3, fill(0.,size(v3,1));
                  v4, fill(0,size(v4,1)),fill(0.,size(v4,1))];
         colorMap:=cm[1:n_colors,:];

        annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
ColorMaps.<strong>jet</strong>();
ColorMaps.<strong>jet</strong>(n_colors=64);
</pre></blockquote>
<h4>Description</h4>
<p>
This function returns the color map \"jet.\" A color map
is a Real[:,3] array where every row represents a color.
With the optional argument \"n_colors\" the number of rows
of the returned array can be defined. The default value is
\"n_colors=64\" (it is usually best if n_colors is a multiple of 4).
Image of the \"jet\" color map:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/Colors/jet.png\">
</blockquote>

<h4>See also</h4>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps\">ColorMaps</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.colorMapToSvg\">colorMapToSvg</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.scalarToColor\">scalarToColor</a>.
</html>"));
      end jet;

      function hot "Returns the \"hot\" color map"
      extends Modelica.Mechanics.MultiBody.Interfaces.partialColorMap;
      protected
         Real a=ceil(n_colors/3);
         Real d=1/a;
         Real v1[:]=0+d:d:1;
         Real cm[integer(ceil(n_colors/3))*3,3];
      algorithm
       cm := 255*[v1, zeros(size(v1, 1)),zeros(size(v1, 1));
                                fill(1., size(v1, 1)), v1,zeros(size(v1, 1));
                                fill(1., size(v1, 1)),fill(1., size(v1, 1)),v1];
       colorMap:=cm[1:n_colors,:];

        annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
ColorMaps.<strong>hot</strong>();
ColorMaps.<strong>hot</strong>(n_colors=64);
</pre></blockquote>
<h4>Description</h4>
<p>
This function returns the color map \"hot.\" A color map
is a Real[:,3] array where every row represents a color.
With the optional argument \"n_colors\" the number of rows
of the returned array can be defined. The default value is
\"n_colors=64\" (it is usually best if n_colors is a multiple of 4).
Image of the \"hot\" color map:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/Colors/hot.png\">
</blockquote>

<h4>See also</h4>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps\">ColorMaps</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.colorMapToSvg\">colorMapToSvg</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.scalarToColor\">scalarToColor</a>.
</html>"));
      end hot;

      function gray "Returns the \"gray\" color map"
      extends Modelica.Mechanics.MultiBody.Interfaces.partialColorMap;
      algorithm
        if n_colors > 1 then
          colorMap := 255*[linspace(0,1.,n_colors),linspace(0,1.,n_colors),linspace(0,1.,n_colors)];
        else
          colorMap:=[0,0,0];
         end if;

        annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
ColorMaps.<strong>gray</strong>();
ColorMaps.<strong>gray</strong>(n_colors=64);
</pre></blockquote>
<h4>Description</h4>
<p>
This function returns the color map \"gray.\" A color map
is a Real[:,3] array where every row represents a color.
With the optional argument \"n_colors\" the number of rows
of the returned array can be defined. The default value is
\"n_colors=64\" (it is usually best if n_colors is a multiple of 4).
Image of the \"gray\" color map:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/Colors/gray.png\">
</blockquote>

<h4>See also</h4>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps\">ColorMaps</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.colorMapToSvg\">colorMapToSvg</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.scalarToColor\">scalarToColor</a>.
</html>"));
      end gray;

      function spring "Returns the \"spring\" color map"
      extends Modelica.Mechanics.MultiBody.Interfaces.partialColorMap;
      algorithm
        if n_colors > 1 then
           colorMap := 255*[fill(1,n_colors),linspace(0,1.,n_colors),linspace(1,0,n_colors)];
         else
          colorMap:=255*[1,0,1];
         end if;

        annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
ColorMaps.<strong>spring</strong>();
ColorMaps.<strong>spring</strong>(n_colors=64);
</pre></blockquote>
<h4>Description</h4>
<p>
This function returns the color map \"spring.\" A color map
is a Real[:,3] array where every row represents a color.
With the optional argument \"n_colors\" the number of rows
of the returned array can be defined. The default value is
\"n_colors=64\" (it is usually best if n_colors is a multiple of 4).
Image of the \"spring\" color map:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/Colors/spring.png\">
</blockquote>

<h4>See also</h4>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps\">ColorMaps</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.colorMapToSvg\">colorMapToSvg</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.scalarToColor\">scalarToColor</a>.
</html>"));
      end spring;

      function summer "Returns the \"summer\" color map"
      extends Modelica.Mechanics.MultiBody.Interfaces.partialColorMap;
      algorithm
        if n_colors > 1 then
           colorMap := 255*[linspace(0,1.,n_colors),linspace(0.5,1.,n_colors),fill(0.4,n_colors)];
         else
          colorMap:=255*[0,0.5,0.4];
         end if;

        annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
ColorMaps.<strong>summer</strong>();
ColorMaps.<strong>summer</strong>(n_colors=64);
</pre></blockquote>
<h4>Description</h4>
<p>
This function returns the color map \"summer.\" A color map
is a Real[:,3] array where every row represents a color.
With the optional argument \"n_colors\" the number of rows
of the returned array can be defined. The default value is
\"n_colors=64\" (it is usually best if n_colors is a multiple of 4).
Image of the \"summer\" color map:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/Colors/summer.png\">
</blockquote>

<h4>See also</h4>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps\">ColorMaps</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.colorMapToSvg\">colorMapToSvg</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.scalarToColor\">scalarToColor</a>.
</html>"));
      end summer;

      function autumn "Returns the \"autumn\" color map"
      extends Modelica.Mechanics.MultiBody.Interfaces.partialColorMap;
      algorithm
        if n_colors > 1 then
           colorMap := 255*[fill(1,n_colors),linspace(0,1.,n_colors),zeros(n_colors)];
         else
          colorMap:=255*[1,0,0];
         end if;

        annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
ColorMaps.<strong>autumn</strong>();
ColorMaps.<strong>autumn</strong>(n_colors=64);
</pre></blockquote>
<h4>Description</h4>
<p>
This function returns the color map \"autumn.\" A color map
is a Real[:,3] array where every row represents a color.
With the optional argument \"n_colors\" the number of rows
of the returned array can be defined. The default value is
\"n_colors=64\" (it is usually best if n_colors is a multiple of 4).
Image of the \"autumn\" color map:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/Colors/autumn.png\">
</blockquote>

<h4>See also</h4>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps\">ColorMaps</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.colorMapToSvg\">colorMapToSvg</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.scalarToColor\">scalarToColor</a>.
</html>"));
      end autumn;

      function winter "Returns the \"winter\" color map"
      extends Modelica.Mechanics.MultiBody.Interfaces.partialColorMap;
      algorithm
        if n_colors > 1 then
           colorMap := 255*[zeros(n_colors),linspace(0,1,n_colors),linspace(1,0.5,n_colors)];
         else
          colorMap:=[0,0,255];
         end if;

        annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
ColorMaps.<strong>winter</strong>();
ColorMaps.<strong>winter</strong>(n_colors=64);
</pre></blockquote>
<h4>Description</h4>
<p>
This function returns the color map \"winter.\" A color map
is a Real[:,3] array where every row represents a color.
With the optional argument \"n_colors\" the number of rows
of the returned array can be defined. The default value is
\"n_colors=64\" (it is usually best if n_colors is a multiple of 4).
Image of the \"winter\" color map:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/Colors/winter.png\">
</blockquote>

<h4>See also</h4>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps\">ColorMaps</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.colorMapToSvg\">colorMapToSvg</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.scalarToColor\">scalarToColor</a>.
</html>"));
      end winter;

      annotation (Documentation(info="<html>
<p>
This package contains functions that return color maps.
A color map is a Real[:,3] array where every row represents a color.
Currently the following color maps are returned from the
respective function:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/Colors/ColorMaps.png\">
</blockquote>
</html>"));
    end ColorMaps;

    function colorMapToSvg
      "Save a color map on file in svg (scalable vector graphics) format"
      extends Modelica.Icons.Function;
     encapsulated type HeaderType = enumeration(
          svgBeginAndEnd,
          svgBegin,
          svgEnd,
          noHeader);
      import Modelica.Utilities.Streams.print;
      input Real colorMap[:,3] "Color map to be stored in svg format"
        annotation(choices( choice=Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps.jet(),
                            choice=Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps.hot(),
                            choice=Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps.gray(),
                            choice=Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps.spring(),
                            choice=Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps.summer(),
                            choice=Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps.autumn(),
                            choice=Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps.winter()));
      input String fileName="colorMap.svg"
        "File where the svg representation shall be stored";
      input Real width(unit="mm")=10 "Width in svg-figure";
      input Real height(unit="mm")=100 "Height in svg-figure";
      input Real x(unit="mm")=20 "X-Coordinate of left upper corner";
      input Real y(unit="mm")=10 "Y-Coordinate of left upper corner";
      input Real T_min=0 "Value of scalar corresponding to colorMap[1,:]";
      input Real T_max=100 "Value of scalar corresponding to colorMap[end,:]";
      input Integer nScalars=11
        "Number of scalars to be displayed at the right side";
      input String format=".3g" "Format of the numbers";
      input Real fontSize=11 "Font size in [pt]";
      input Real textWidth(unit="mm")=8
        "Numbers are right justified starting at x+width+textWidth";
      input String caption="" "Caption above the map";
      input HeaderType headerType=Colors.colorMapToSvg.HeaderType.svgBeginAndEnd
        "Type of header";
    protected
      Integer nc = size(colorMap,1);
      Real dy=height/nc;
      Real yy=y-dy;
      String strWidth=String(width);
      String strHeight=String(dy);
      Real T;
      Integer ni;
      constant Real ptToMm=127/360 "1 Point = ptToMm mm";
      Real fontHeight(unit="mm") = fontSize*ptToMm;
      Real xx=x+width+textWidth;
      String strXX=String(xx);
      Real xHeading=x+width/2;
      Real yHeading=y-1.2*fontHeight;
    algorithm
      if headerType==HeaderType.svgBeginAndEnd or
         headerType==HeaderType.svgBegin then
         Modelica.Utilities.Files.remove(fileName);
         print("... generating svg-file: " + Modelica.Utilities.Files.fullPathName(fileName));
      end if;
      if caption<>"" then
         print("... " + caption);
      end if;

      if headerType==HeaderType.svgBeginAndEnd or
         headerType==HeaderType.svgBegin then
         print("<svg xmlns=\"http://www.w3.org/2000/svg\">", fileName);
      end if;

      print("  <g>", fileName);

      // Print colors
      for i in nc:-1:1 loop
         // print:  <rect x="XXmm" y="XXmm" width="YYmm" height="ZZmm" style="fill:rgb(100,128,255);stroke:none"/>
         yy :=yy + dy;
         print("    <rect x=\"" + String(x) +
               "mm\" y=\"" + String(yy) +
               "mm\" width=\"" + strWidth +
               "mm\" height=\"" + strHeight +
               "mm\" style=\"fill:rgb(" + String(integer(colorMap[i,1])) + ","
                                        + String(integer(colorMap[i,2])) + ","
                                        + String(integer(colorMap[i,3])) +
               ");stroke:none\"/>", fileName);
      end for;

      // Print numbers
      ni :=if nScalars == 1 then 2 else if nScalars < 1 then
                                 0 else nScalars;
      dy:=height/(ni-1);
      yy:=y - dy+0.3*fontHeight;
      for i in ni:-1:1 loop
        // print: <text x="22mm" y="12mm" font-family="Arial,sans-serif" font-size="11pt">1.2345</text>
        yy :=yy + dy;
        T := T_min + (T_max - T_min)*(i-1)/(ni-1);
        print("    <text x=\"" + strXX +
              "mm\" y=\"" + String(yy) +
              "mm\" font-family=\"Fixedsys\" font-size=\"" + String(fontSize) +
              "pt\" text-anchor=\"end\">" + String(T,format=format) +
              "</text>", fileName);
      end for;

      if caption <> "" then
         print("   <text x=\"" + String(xHeading) +
               "mm\" y=\"" + String(yHeading) +
               "mm\" font-family=\"Fixedsys\" font-size=\"" + String(fontSize) +
               "pt\" text-anchor=\"middle\">" + caption +
               "</text>", fileName);
      end if;

      print("  </g>", fileName);

      if headerType==HeaderType.svgBeginAndEnd or
         headerType==HeaderType.svgEnd then
         print("</svg>",fileName);
      end if;
      annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Colors.<strong>colorMapToSvg</strong>(colorMap);
Colors.<strong>colorMapToSvg</strong>(colorMap,
                     fileName   = \"colorMap.svg\",
                     width      =  10,  // [mm]
                     height     = 100,  // [mm]
                     x          =  20,  // [mm]
                     y          =  10,  // [mm]
                     T_min      =   0,
                     T_max      = 100,
                     nScalars   =  11,
                     format     = \".3g\",
                     fontSize   =  11,  // [pt]
                     textWidth  =   8,  // [mm]
                     caption    = \"\",
                     headerType = Colors.colorMapToSvg.Header.svgBeginAndEnd)
                                                           // svgBegin
                                                           // svgEnd
                                                           // svgNoHeader
</pre></blockquote>
<h4>Description</h4>
<p>
This function saves the color map \"Real colorMap[:,3]\" on file \"fileName\"
in svg format. The color map has a width of \"width\" and a height of \"height\" and
the upper left corner is placed at coordinates \"(x,y)\".
Over the color map, a caption \"caption\" is placed.
On the right side of the color map, a set of scalar field values T is
displayed where \"T_min\" is placed at colorMap[1,:],
\"T_max\" is placed at colorMap[end,:] and \"nScalars\" values between
\"T_min\" and \"T_max\" (including T_min and T_max) are shown.
The printing format of the numbers is defined with \"format\", see definition below.
With argument \"headerType\" it is defined whether \"svg\" begin and end
lines are printed. If the \"begin\" svg tag shall be printed, file \"fileName\"
is deleted, if it already exists. Otherwise, all output is appended to the
file \"fileName\".
</p>

<p>
A \"svg\" file can be displayed by a web browser, such as
<a href=\"http://www.mozilla.org/firefox\">Firefox</a> by dragging the
file in the browser window.
Alternatively, a svg-file can be loaded in a graphics program,
such as the free <a href=\"http://inkscape.org\">Inkscape</a>,
can be manipulated and can be exported in other graphic formats.
The following image was generated with a call to \"colorMapToSvg\", the
generated file was loaded in Inkscape and exported in \"png\" format:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/Colors/jet.png\">
</blockquote>

<p>
The \"format\" argument defines the string formatting according to
ANSI-C without \"%\" and \"*\" character<br>
(e.g., \".6g\", \"14.5e\", \"+6f\"). In particular:
</p>

<p>
format = \"[&lt;flags&gt;] [&lt;width&gt;] [.&lt;precision&gt;] &lt;conversion&gt;\"
with
</p>

<blockquote>
<table>
<tr>
  <td>&lt;flags&gt;</td>
  <td> zero, one or more of<br>
       \"-\": left adjustment of the converted number<br>
       \"+\": number will always be printed with a sign<br>
       \"0\": padding to the field width with leading zeros</td></tr>
<tr>
  <td>&lt;width&gt;</td>
  <td> Minimum field width. The converted number will be printed in a field at<br>
       least this wide and wider if necessary. If the converted number has<br>
       fewer characters it will be padded on the left (or the right depending<br>
       on &lt;flags&gt;) with blanks or 0 (depending on &lt;flags&gt;).</td></tr>
<tr>
  <td>&lt;precision&gt;</td>
  <td> The number of digits to be printed after the decimal point for<br>
       e, E, or f conversions, or the number of significant digits for<br>
       g or G conversions.</td></tr>
<tr>
  <td> &lt;conversion&gt;</td>
  <td> = \"e\": Exponential notation using a  lower case e<br>
       = \"E\": Exponential notation using an upper case E<br>
       = \"f\": Fixed point notation<br>
       = \"g\": Either \"e\" or \"f\"<br>
       = \"G\": Same as \"g\", but with upper case E</td></tr>
</table>
</blockquote>
</html>"));
    end colorMapToSvg;

    function scalarToColor "Map a scalar to a color using a color map"
      extends Modelica.Icons.Function;

      input Real T "Scalar value" annotation(Dialog);
      input Real T_min "T <= T_min is mapped to colorMap[1,:]" annotation(Dialog);
      input Real T_max "T >= T_max is mapped to colorMap[end,:]" annotation(Dialog);
      input Real colorMap[:,3] "Color map" annotation(Dialog);
      output Real color[3] "Color of scalar value T";
    algorithm
      /* old version, that could give an error
  color :=colorMap[integer((size(colorMap, 1) - 1)/(T_max - T_min)*
                            min((max(T,T_min) - T_min), T_max) + 1), :];
  */
      color := colorMap[1 + integer((size(colorMap,1)-1)*(max(T_min,min(T,T_max))-T_min)
                                  / (T_max-T_min)), :];
      annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
//Real T, T_min, T_max, colorMap[:,3];
Colors.<strong>scalarToColor</strong>(T, T_min, T_max, colorMap);
</pre></blockquote>
<h4>Description</h4>
<p>
This function returns an rgb color Real[3] that corresponds to the value of \"T\".
The color is selected from the colorMap by interpolation so that
\"T_min\" corresponds to \"colorMap[1,:]\" and
\"T_max\" corresponds to \"colorMap[end,:]\".
</p>

<h4>See also</h4>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps\">ColorMaps</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.colorMapToSvg\">colorMapToSvg</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.PipeWithScalarField\">PipeWithScalarField</a>.

</html>"));
    end scalarToColor;
    annotation (Documentation(info="<html>
<p>
This package contains functions to operate on colors.
Note, a color is represented as a Real array with 3 elements where
the elements are the red, green, blue values of the RGB color model.
Every element must be in the range 0&nbsp;&hellip;&nbsp;255.
The type of a color is Real and not Integer in order that a color
can be used with less problems in a model, since in a model an Integer
type could only be used in a when-clause. Typical declaration of a color value:
</p>

<blockquote>
<pre>
  Real color[3](each min=0, each max=255);
</pre>
</blockquote>

<p>
This definition is also available as type
<a href=\"modelica://Modelica.Mechanics.MultiBody.Types.RealColor\">Modelica.Mechanics.MultiBody.Types.RealColor</a>.
</p>
</html>"));
  end Colors;

  package Advanced
    "Visualizers that require basic knowledge about Modelica in order to use them"

    extends Modelica.Icons.Package;
    model Arrow
      "Visualizing an arrow with variable size; all data have to be set as modifiers (see info layer)"

      import Modelica.Mechanics.MultiBody.Types;
      import Modelica.Mechanics.MultiBody.Frames;
      import T = Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
      import Modelica.SIunits.Conversions.to_unit1;

      input Frames.Orientation R=Frames.nullRotation()
        "Orientation object to rotate the world frame into the arrow frame" annotation(Dialog);
      input SI.Position r[3]={0,0,0}
        "Position vector from origin of world frame to origin of arrow frame, resolved in world frame" annotation(Dialog);
      input SI.Position r_tail[3]={0,0,0}
        "Position vector from origin of arrow frame to arrow tail, resolved in arrow frame" annotation(Dialog);
      input SI.Position r_head[3]={0,0,0}
        "Position vector from arrow tail to the head of the arrow, resolved in arrow frame" annotation(Dialog);
      input SI.Diameter diameter=world.defaultArrowDiameter
        "Diameter of arrow line" annotation(Dialog);
      input Modelica.Mechanics.MultiBody.Types.Color color=Modelica.Mechanics.MultiBody.Types.Defaults.ArrowColor
        "Color of arrow" annotation(Dialog(colorSelector=true));
      input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient
        "Material property describing the reflecting of ambient light (= 0 means, that light is completely absorbed)"
                                                                                                            annotation(Dialog);

    protected
      outer Modelica.Mechanics.MultiBody.World world;
      SI.Length length=Modelica.Math.Vectors.length(r_head) "Length of arrow";
      Real e_x[3](each final unit="1", start={1,0,0}) = noEvent(if length < 1e-10 then {1,0,0} else r_head/length);
      Real rxvisobj[3](each final unit="1") = transpose(R.T)*e_x
        "X-axis unit vector of shape, resolved in world frame"
          annotation (HideResult=true);
      SI.Position rvisobj[3] = r + T.resolve1(R.T, r_tail)
        "Position vector from world frame to shape frame, resolved in world frame"
          annotation (HideResult=true);
      SI.Length arrowLength = noEvent(max(0, length - diameter*Types.Defaults.ArrowHeadLengthFraction))
          annotation(HideResult=true);
      Visualizers.Advanced.Shape arrowLine(
        length=arrowLength,
        width=diameter,
        height=diameter,
        lengthDirection = to_unit1(r_head),
        widthDirection={0,1,0},
        shapeType="cylinder",
        color=color,
        specularCoefficient=specularCoefficient,
        r_shape=r_tail,
        r=r,
        R=R) if world.enableAnimation;
      Visualizers.Advanced.Shape arrowHead(
        length=noEvent(max(0, min(length, diameter*Types.Defaults.
            ArrowHeadLengthFraction))),
        width=noEvent(max(0, diameter*MultiBody.Types.Defaults.
            ArrowHeadWidthFraction)),
        height=noEvent(max(0, diameter*MultiBody.Types.Defaults.
            ArrowHeadWidthFraction)),
        lengthDirection = to_unit1(r_head),
        widthDirection={0,1,0},
        shapeType="cone",
        color=color,
        specularCoefficient=specularCoefficient,
        r=rvisobj + rxvisobj*arrowLength,
        R=R) if world.enableAnimation;

      annotation (
        Documentation(info="<html>
<p>
Model <strong>Arrow</strong> defines an arrow that is dynamically
visualized at the defined location (see variables below).
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/Arrow.png\" alt=\"model Visualizers.Advanced.Arrow\">
</p>

<p>
The variables under heading <strong>Parameters</strong> below
are declared as (time varying) <strong>input</strong> variables.
If the default equation is not appropriate, a corresponding
modifier equation has to be provided in the
model where an <strong>Arrow</strong> instance is used, e.g., in the form
</p>
<pre>
    Visualizers.Advanced.Arrow arrow(diameter = sin(time));
</pre>

<p>
Variable <strong>color</strong> is an Integer vector with 3 elements,
{r, g, b}, and specifies the color of the shape.
{r, g, b} are the \"red\", \"green\" and \"blue\" color parts.
Note, r, g and b are given in the range 0&nbsp;&hellip;&nbsp;255.
The predefined type <strong>MultiBody.Types.Color</strong> contains
a menu definition of the colors used in the MultiBody
library (will be replaced by a color editor).
</p>
</html>"),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Rectangle(
              extent={{-100,28},{20,-28}},
              lineColor={128,128,128},
              fillColor={128,128,128},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{20,60},{100,0},{20,-60},{20,60}},
              lineColor={128,128,128},
              fillColor={128,128,128},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-150,105},{150,65}},
              textString="%name",
              textColor={0,0,255})}));
    end Arrow;

    model DoubleArrow
      "Visualizing a double arrow with variable size; all data have to be set as modifiers (see info layer)"

      import Modelica.Mechanics.MultiBody.Types;
      import Modelica.Mechanics.MultiBody.Frames;
      import T = Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
      import Modelica.SIunits.Conversions.to_unit1;

      input Frames.Orientation R=Frames.nullRotation()
        "Orientation object to rotate the world frame into the arrow frame" annotation(Dialog);
      input SI.Position r[3]={0,0,0}
        "Position vector from origin of world frame to origin of arrow frame, resolved in world frame" annotation(Dialog);
      input SI.Position r_tail[3]={0,0,0}
        "Position vector from origin of arrow frame to double arrow tail, resolved in arrow frame" annotation(Dialog);
      input SI.Position r_head[3]={0,0,0}
        "Position vector from double arrow tail to the head of the double arrow, resolved in arrow frame" annotation(Dialog);
      input SI.Diameter diameter=world.defaultArrowDiameter
        "Diameter of arrow line" annotation(Dialog);
      input Modelica.Mechanics.MultiBody.Types.Color color=Modelica.Mechanics.MultiBody.Types.Defaults.ArrowColor
        "Color of double arrow" annotation(Dialog(colorSelector=true));
      input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient
        "Material property describing the reflecting of ambient light (= 0 means, that light is completely absorbed)"
                                                                                                            annotation(Dialog);

    protected
      outer Modelica.Mechanics.MultiBody.World world;
      SI.Length length=Modelica.Math.Vectors.length(r_head) "Length of arrow";
      Real e_x[3](each final unit="1", start={1,0,0}) = noEvent(if length < 1e-10 then {1,0,0} else r_head/length);
      Real rxvisobj[3](each final unit="1") = transpose(R.T)*e_x
        "X-axis unit vector of shape, resolved in world frame"
          annotation (HideResult=true);
      SI.Position rvisobj[3] = r + T.resolve1(R.T, r_tail)
        "Position vector from world frame to shape frame, resolved in world frame"
          annotation (HideResult=true);

      SI.Length headLength=noEvent(max(0, min(length, diameter*MultiBody.Types.Defaults.ArrowHeadLengthFraction)));
      SI.Length headWidth=noEvent(max(0, diameter*MultiBody.Types.Defaults.ArrowHeadWidthFraction));
      SI.Length arrowLength = noEvent(max(0, length - 1.5*diameter*MultiBody.Types.Defaults.ArrowHeadLengthFraction));
      Visualizers.Advanced.Shape arrowLine(
        length=arrowLength,
        width=diameter,
        height=diameter,
        lengthDirection = to_unit1(r_head),
        widthDirection={0,1,0},
        shapeType="cylinder",
        color=color,
        specularCoefficient=specularCoefficient,
        r_shape=r_tail,
        r=r,
        R=R) if world.enableAnimation;
      Visualizers.Advanced.Shape arrowHead1(
        length=headLength,
        width=headWidth,
        height=headWidth,
        lengthDirection = to_unit1(r_head),
        widthDirection={0,1,0},
        shapeType="cone",
        color=color,
        specularCoefficient=specularCoefficient,
        r=rvisobj + rxvisobj*arrowLength,
        R=R) if world.enableAnimation;
      Visualizers.Advanced.Shape arrowHead2(
        length=headLength,
        width=headWidth,
        height=headWidth,
        lengthDirection = to_unit1(r_head),
        widthDirection={0,1,0},
        shapeType="cone",
        color=color,
        specularCoefficient=specularCoefficient,
        r=rvisobj + rxvisobj*(arrowLength + 0.5*headLength),
        R=R) if world.enableAnimation;

      annotation (
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Rectangle(
              extent={{-100,28},{0,-28}},
              lineColor={128,128,128},
              fillColor={128,128,128},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{40,60},{100,0},{40,-60},{40,60}},
              lineColor={128,128,128},
              fillColor={128,128,128},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-150,105},{150,65}},
              textString="%name",
              textColor={0,0,255}),
            Polygon(
              points={{0,60},{60,0},{0,-60},{0,60}},
              lineColor={128,128,128},
              fillColor={128,128,128},
              fillPattern=FillPattern.Solid)}),
        Documentation(info="<html>
<p>
Model <strong>DoubleArrow</strong> defines a double arrow that is dynamically
visualized at the defined location (see variables below).
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/DoubleArrow.png\" alt=\"model Visualizers.Advanced.DoubleArrow\">
</p>

<p>
The variables under heading <strong>Parameters</strong> below
are declared as (time varying) <strong>input</strong> variables.
If the default equation is not appropriate, a corresponding
modifier equation has to be provided in the
model where an <strong>Arrow</strong> instance is used, e.g., in the form
</p>
<pre>
    Visualizers.Advanced.DoubleArrow doubleArrow(diameter = sin(time));
</pre>
<p>
Variable <strong>color</strong> is an Integer vector with 3 elements,
{r, g, b}, and specifies the color of the shape.
{r, g, b} are the \"red\", \"green\" and \"blue\" color parts.
Note, r, g and b are given in the range 0&nbsp;&hellip;&nbsp;255.
The predefined type <strong>MultiBody.Types.Color</strong> contains
a menu definition of the colors used in the MultiBody
library (will be replaced by a color editor).
</p>
</html>"));
    end DoubleArrow;

    model Shape
      "Visualizing an elementary object with variable size; all data have to be set as modifiers (see info layer)"

       extends ModelicaServices.Animation.Shape;
       extends
        Modelica.Utilities.Internal.PartialModelicaServices.Animation.PartialShape;

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

<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Shape.png\" alt=\"model Visualizers.FixedShape\">
</p>

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
The variables under heading <strong>Parameters</strong> below
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

    model Surface
      "Visualizing a moveable, parameterized surface; the surface characteristic is provided by a function"
      extends Modelica.Mechanics.MultiBody.Icons.Surface;
      extends
        Modelica.Utilities.Internal.PartialModelicaServices.Animation.PartialSurface;
      extends ModelicaServices.Animation.Surface;
      annotation (Icon(graphics={Polygon(
              points={{-102,40},{-98,92},{28,-8},{96,146},{104,-118},{-18,-34},{-52,
                  -130},{-102,40}},
              lineColor={0,0,255},
              smooth=Smooth.Bezier,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-150,140},{150,100}},
              textColor={0,0,255},
              textString="%name")}), Documentation(info="<html>
<p>
Model <strong>Surface</strong> defines a moveable, parametrized surface in 3-dim. space
that is used for animation. This object is specified by:
</p>

<ul>
<li> The surface frame (orientation object \"R\" and origin \"r_0\")
     in which the data is specified.</li>
<li> A set of two parameters, one in u- and one in v-direction,
     that defines the control points.</li>
<li> A time-varying position of each control point with respect to
     the surface frame.</li>
</ul>

<p>
The parameter values (u,v) are given by the ordinal numbers of the
corresponding control point in u- or in v-direction, respectively.
The surface is then defined by the replaceable function \"surfaceCharacteristic\" with the
interface <a href=\"modelica://Modelica.Mechanics.MultiBody.Interfaces.partialSurfaceCharacteristic\">partialSurfaceCharacteristic</a>
that returns the x-, y-, z- coordinate of every control point in form of 3 arrays X, Y, Z, and an optional color array C, if every control point shall have a different color:
</p>

<pre>
  Real X[nu,nv], Y[nu,nv], Z[nu,nv], C[nu,nv,3];
</pre>

<p>
An example of a parameterized surface with color coding is shown in the next figure:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/Surface.png\">
</blockquote>

<p>
Models <a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Torus\">Torus</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.VoluminousWheel\">VoluminousWheel</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.PipeWithScalarField\">PipeWithScalarField</a>,
demonstrate how new visualizer objects can be constructed with the Surface model.<br>
The direct usage of the Surface model, as well as of the Torus and the VoluminousWheel models, are demonstrated with example
<a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.Surfaces\">Examples.Elementary.Surfaces</a>.
</p>
</html>"));
    end Surface;

    model PipeWithScalarField "Visualizing a pipe with a scalar field"
      input Frames.Orientation R=Frames.nullRotation()
        "Orientation object to rotate the world frame into the surface frame"
        annotation(Dialog(group="Surface frame"));
      input Modelica.SIunits.Position r_0[3]={0,0,0}
        "Position vector from origin of world frame to origin of surface frame, resolved in world frame"
        annotation(Dialog(group="Surface frame"));

      parameter Modelica.SIunits.Radius rOuter "Outer radius of pipe" annotation(Dialog(group="Surface properties"));
      parameter Modelica.SIunits.Length length "Length of pipe" annotation(Dialog(group="Surface properties"));
      parameter Integer n_rOuter=30 "Number of points along outer radius" annotation(Dialog(group="Surface properties"));
      parameter Integer n_length=10 "Number of points along length" annotation(Dialog(group="Surface properties"));
      parameter Types.SpecularCoefficient specularCoefficient = 0.7
        "Reflection of ambient light (= 0: light is completely absorbed)" annotation(Dialog(group="Surface properties"));
      parameter Real transparency=0
        "Transparency of shape: 0 (= opaque) ... 1 (= fully transparent)"
        annotation(Dialog(group="Surface properties"));

      parameter Real xsi[:](each min=0,each max=1)= Modelica.Math.Vectors.relNodePositions(12)
        "Vector of relative positions along the pipe with x[1] = 0, x[end] = 1"
        annotation(Dialog(group="Color coding"));
      input Real T[size(xsi,1)]
        "Vector of values at positions xsi*length (will be visualized by color)" annotation(Dialog(group="Color coding"));
      parameter Real T_min
        "Minimum value of T that corresponds to colorMap[1,:]" annotation(Dialog(group="Color coding"));
      parameter Real T_max
        "Maximum value of T that corresponds to colorMap[end,:]" annotation(Dialog(group="Color coding"));
      parameter Integer n_colors=64 "Number of colors in the colorMap" annotation(Dialog(group="Color coding"));
      replaceable function colorMap =
        Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps.jet
        constrainedby Modelica.Mechanics.MultiBody.Interfaces.partialColorMap
        "Function defining the color map"
        annotation(choicesAllMatching=true, Dialog(group="Color coding"),
        Documentation(info="<html>
<p>This replaceable function defines a particular color map.</p>
<!--a placeholder to fulfill minimum documentation length-->
</html>"));
    protected
      parameter Real colorMapData[n_colors,3] = colorMap(n_colors) annotation(HideResult=true);
      Surface surface(
        R=R,
        r_0=r_0,
        nu=n_length,
        nv=n_rOuter,
        wireframe=false,
        multiColoredSurface=true,
        specularCoefficient=specularCoefficient,
        transparency=transparency,
        redeclare function surfaceCharacteristic =
            Modelica.Mechanics.MultiBody.Visualizers.Advanced.SurfaceCharacteristics.pipeWithScalarField (
             rOuter=rOuter,
             length=length,
             xsi=xsi,
             T=T,
             T_min=T_min,
             T_max=T_max,
             colorMap=colorMapData))
        annotation (Placement(transformation(extent={{-20,2},{0,22}})));
      annotation(Icon(graphics = {
           Text(textColor = {0,0,255}, extent = {{-150, 54}, {150, 94}}, textString = "%name"),
           Polygon(fillColor = {0, 0, 163}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-70, -33.5}, {-70, -33.5}, {-76, -33.333}, {-82.378, -30.796}, {-87.785, -23.57}, {-90.44, -16.645}, {-92.096, -8.651}, {-92.667, 0}, {-92.096, 8.651}, {-90.44, 16.645}, {-87.785, 23.57}, {-82.378, 30.796}, {-76, 33.333}, {-70, 33.5}, {-70, 33.5}}, smooth = Smooth.Bezier),
           Polygon(fillColor = {0, 56, 195}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-65.833, 33.5}, {-65.833, 33.5}, {-71.833, 33.333}, {-78.211, 30.796}, {-83.618, 23.57}, {-86.273, 16.645}, {-87.929, 8.651}, {-88.5, 0}, {-87.929, -8.651}, {-86.273, -16.645}, {-83.618, -23.57}, {-78.211, -30.796}, {-71.833, -33.333}, {-65.833, -33.5}, {-65.833, -33.5}}, smooth = Smooth.Bezier),
           Polygon(fillColor = {0, 76, 210}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-61.667, 33.5}, {-61.667, 33.5}, {-67.667, 33.333}, {-74.045, 30.796}, {-79.452, 23.57}, {-82.106, 16.645}, {-83.762, 8.651}, {-84.333, 0}, {-83.762, -8.651}, {-82.106, -16.645}, {-79.452, -23.57}, {-74.045, -30.796}, {-67.667, -33.333}, {-61.667, -33.5}, {-61.667, -33.5}}, smooth = Smooth.Bezier),
           Polygon(fillColor = {0, 95, 223}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-57.5, 33.5}, {-57.5, 33.5}, {-63.5, 33.333}, {-69.878, 30.796}, {-75.285, 23.57}, {-77.94, 16.645}, {-79.596, 8.651}, {-80.167, 0}, {-79.596, -8.651}, {-77.94, -16.645}, {-75.285, -23.57}, {-69.878, -30.796}, {-63.5, -33.333}, {-57.5, -33.5}, {-57.5, -33.5}}, smooth = Smooth.Bezier),
           Polygon(fillColor = {0, 114, 234}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-53.333, 33.5}, {-53.333, 33.5}, {-59.333, 33.333}, {-65.711, 30.796}, {-71.118, 23.57}, {-73.773, 16.645}, {-75.429, 8.651}, {-76, 0}, {-75.429, -8.651}, {-73.773, -16.645}, {-71.118, -23.57}, {-65.711, -30.796}, {-59.333, -33.333}, {-53.333, -33.5}, {-53.333, -33.5}}, smooth = Smooth.Bezier),
           Polygon(fillColor = {0, 132, 245}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-49.167, 33.5}, {-49.167, 33.5}, {-55.167, 33.333}, {-61.545, 30.796}, {-66.952, 23.57}, {-69.606, 16.645}, {-71.262, 8.651}, {-71.833, 0}, {-71.262, -8.651}, {-69.606, -16.645}, {-66.952, -23.57}, {-61.545, -30.796}, {-55.167, -33.333}, {-49.167, -33.5}, {-49.167, -33.5}}, smooth = Smooth.Bezier),
           Polygon(fillColor = {18, 151, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-45, 33.5}, {-45, 33.5}, {-51, 33.333}, {-57.378, 30.796}, {-62.785, 23.57}, {-65.44, 16.645}, {-67.096, 8.651}, {-67.667, 0}, {-67.096, -8.651}, {-65.44, -16.645}, {-62.785, -23.57}, {-57.378, -30.796}, {-51, -33.333}, {-45, -33.5}, {-45, -33.5}}, smooth = Smooth.Bezier),
           Polygon(fillColor = {0, 188, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-40.833, 33.5}, {-40.833, 33.5}, {-46.833, 33.333}, {-53.211, 30.796}, {-58.618, 23.57}, {-61.273, 16.645}, {-62.929, 8.651}, {-63.5, 0}, {-62.929, -8.651}, {-61.273, -16.645}, {-58.618, -23.57}, {-53.211, -30.796}, {-46.833, -33.333}, {-40.833, -33.5}, {-40.833, -33.5}}, smooth = Smooth.Bezier),
           Polygon(fillColor = {0, 205, 253}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-36.667, 33.5}, {-36.667, 33.5}, {-42.667, 33.333}, {-49.045, 30.796}, {-54.452, 23.57}, {-57.106, 16.645}, {-58.762, 8.651}, {-59.333, 0}, {-58.762, -8.651}, {-57.106, -16.645}, {-54.452, -23.57}, {-49.045, -30.796}, {-42.667, -33.333}, {-36.667, -33.5}, {-36.667, -33.5}}, smooth = Smooth.Bezier),
           Polygon(fillColor = {0, 220, 235}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-32.5, 33.5}, {-32.5, 33.5}, {-38.5, 33.333}, {-44.878, 30.796}, {-50.285, 23.57}, {-52.94, 16.645}, {-54.596, 8.651}, {-55.167, 0}, {-54.596, -8.651}, {-52.94, -16.645}, {-50.285, -23.57}, {-44.878, -30.796}, {-38.5, -33.333}, {-32.5, -33.5}, {-32.5, -33.5}}, smooth = Smooth.Bezier),
           Polygon(fillColor = {0, 233, 211}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-28.333, 33.5}, {-28.333, 33.5}, {-34.333, 33.333}, {-40.711, 30.796}, {-46.118, 23.57}, {-48.773, 16.645}, {-50.429, 8.651}, {-51, 0}, {-50.429, -8.651}, {-48.773, -16.645}, {-46.118, -23.57}, {-40.711, -30.796}, {-34.333, -33.333}, {-28.333, -33.5}, {-28.333, -33.5}}, smooth = Smooth.Bezier),
           Polygon(fillColor = {0, 245, 183}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-24.167, 33.5}, {-24.167, 33.5}, {-30.167, 33.333}, {-36.545, 30.796}, {-41.952, 23.57}, {-44.606, 16.645}, {-46.262, 8.651}, {-46.833, 0}, {-46.262, -8.651}, {-44.606, -16.645}, {-41.952, -23.57}, {-36.545, -30.796}, {-30.167, -33.333}, {-24.167, -33.5}, {-24.167, -33.5}}, smooth = Smooth.Bezier),
           Polygon(fillColor = {34, 255, 154}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-20, 33.5}, {-20, 33.5}, {-26, 33.333}, {-32.378, 30.796}, {-37.785, 23.57}, {-40.44, 16.645}, {-42.096, 8.651}, {-42.667, 0}, {-42.096, -8.651}, {-40.44, -16.645}, {-37.785, -23.57}, {-32.378, -30.796}, {-26, -33.333}, {-20, -33.5}, {-20, -33.5}}, smooth = Smooth.Bezier),
           Polygon(fillColor = {0, 255, 128}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-15.833, 33.5}, {-15.833, 33.5}, {-21.833, 33.333}, {-28.211, 30.796}, {-33.618, 23.57}, {-36.273, 16.645}, {-37.929, 8.651}, {-38.5, 0}, {-37.929, -8.651}, {-36.273, -16.645}, {-33.618, -23.57}, {-28.211, -30.796}, {-21.833, -33.333}, {-15.833, -33.5}, {-15.833, -33.5}}, smooth = Smooth.Bezier),
           Polygon(fillColor = {0, 255, 113}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-11.667, 33.5}, {-11.667, 33.5}, {-17.667, 33.333}, {-24.045, 30.796}, {-29.452, 23.57}, {-32.106, 16.645}, {-33.762, 8.651}, {-34.333, 0}, {-33.762, -8.651}, {-32.106, -16.645}, {-29.452, -23.57}, {-24.045, -30.796}, {-17.667, -33.333}, {-11.667, -33.5}, {-11.667, -33.5}}, smooth = Smooth.Bezier),
           Polygon(fillColor = {0, 255, 96}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-7.5, 33.5}, {-7.5, 33.5}, {-13.5, 33.333}, {-19.878, 30.796}, {-25.285, 23.57}, {-27.94, 16.645}, {-29.596, 8.651}, {-30.167, 0}, {-29.596, -8.651}, {-27.94, -16.645}, {-25.285, -23.57}, {-19.878, -30.796}, {-13.5, -33.333}, {-7.5, -33.5}, {-7.5, -33.5}}, smooth = Smooth.Bezier),
           Polygon(fillColor = {0, 255, 77}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-3.333, 33.5}, {-3.333, 33.5}, {-9.333, 33.333}, {-15.711, 30.796}, {-21.118, 23.57}, {-23.773, 16.645}, {-25.429, 8.651}, {-26, 0}, {-25.429, -8.651}, {-23.773, -16.645}, {-21.118, -23.57}, {-15.711, -30.796}, {-9.333, -33.333}, {-3.333, -33.5}, {-3.333, -33.5}}, smooth = Smooth.Bezier),
           Polygon(fillColor = {15, 255, 54}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{0.833, 33.5}, {0.833, 33.5}, {-5.167, 33.333}, {-11.545, 30.796}, {-16.952, 23.57}, {-19.607, 16.645}, {-21.262, 8.651}, {-21.833, 0}, {-21.262, -8.651}, {-19.607, -16.645}, {-16.952, -23.57}, {-11.545, -30.796}, {-5.167, -33.333}, {0.833, -33.5}, {0.833, -33.5}}, smooth = Smooth.Bezier),
           Polygon(fillColor = {35, 255, 6}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{5, 33.5}, {5, 33.5}, {-1, 33.333}, {-7.378, 30.796}, {-12.785, 23.57}, {-15.44, 16.645}, {-17.096, 8.651}, {-17.667, 0}, {-17.096, -8.651}, {-15.44, -16.645}, {-12.785, -23.57}, {-7.378, -30.796}, {-1, -33.333}, {5, -33.5}, {5, -33.5}}, smooth = Smooth.Bezier),
           Polygon(fillColor = {136, 255, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{9.167, 33.5}, {9.167, 33.5}, {3.167, 33.333}, {-3.211, 30.796}, {-8.618, 23.57}, {-11.273, 16.645}, {-12.929, 8.651}, {-13.5, 0}, {-12.929, -8.651}, {-11.273, -16.645}, {-8.618, -23.57}, {-3.211, -30.796}, {3.167, -33.333}, {9.167, -33.5}, {9.167, -33.5}}, smooth = Smooth.Bezier),
           Polygon(fillColor = {165, 255, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{13.333, 33.5}, {13.333, 33.5}, {7.333, 33.333}, {0.955, 30.796}, {-4.452, 23.57}, {-7.106, 16.645}, {-8.762, 8.651}, {-9.333, 0}, {-8.762, -8.651}, {-7.106, -16.645}, {-4.452, -23.57}, {0.955, -30.796}, {7.333, -33.333}, {13.333, -33.5}, {13.333, -33.5}}, smooth = Smooth.Bezier),
           Polygon(fillColor = {191, 255, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{17.5, 33.5}, {17.5, 33.5}, {11.5, 33.333}, {5.122, 30.796}, {-0.285, 23.57}, {-2.94, 16.645}, {-4.596, 8.651}, {-5.167, 0}, {-4.596, -8.651}, {-2.94, -16.645}, {-0.285, -23.57}, {5.122, -30.796}, {11.5, -33.333}, {17.5, -33.5}, {17.5, -33.5}}, smooth = Smooth.Bezier),
           Polygon(fillColor = {214, 255, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{21.667, 33.5}, {21.667, 33.5}, {15.667, 33.333}, {9.289, 30.796}, {3.882, 23.57}, {1.227, 16.645}, {-0.429, 8.651}, {-1, 0}, {-0.429, -8.651}, {1.227, -16.645}, {3.882, -23.57}, {9.289, -30.796}, {15.667, -33.333}, {21.667, -33.5}, {21.667, -33.5}}, smooth = Smooth.Bezier),
           Polygon(fillColor = {235, 255, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{25.833, 33.5}, {25.833, 33.5}, {19.833, 33.333}, {13.455, 30.796}, {8.048, 23.57}, {5.394, 16.645}, {3.738, 8.651}, {3.167, 0}, {3.738, -8.651}, {5.394, -16.645}, {8.048, -23.57}, {13.455, -30.796}, {19.833, -33.333}, {25.833, -33.5}, {25.833, -33.5}}, smooth = Smooth.Bezier),
           Polygon(fillColor = {255, 255, 11}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{30, 33.5}, {30, 33.5}, {24, 33.333}, {17.622, 30.796}, {12.215, 23.57}, {9.56, 16.645}, {7.904, 8.651}, {7.333, 0}, {7.904, -8.651}, {9.56, -16.645}, {12.215, -23.57}, {17.622, -30.796}, {24, -33.333}, {30, -33.5}, {30, -33.5}}, smooth = Smooth.Bezier),
           Polygon(fillColor = {255, 226, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{34.167, 33.5}, {34.167, 33.5}, {28.167, 33.333}, {21.789, 30.796}, {16.382, 23.57}, {13.727, 16.645}, {12.071, 8.651}, {11.5, 0}, {12.071, -8.651}, {13.727, -16.645}, {16.382, -23.57}, {21.789, -30.796}, {28.167, -33.333}, {34.167, -33.5}, {34.167, -33.5}}, smooth = Smooth.Bezier),
           Polygon(fillColor = {255, 211, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{38.333, 33.5}, {38.333, 33.5}, {32.333, 33.333}, {25.955, 30.796}, {20.548, 23.57}, {17.893, 16.645}, {16.238, 8.651}, {15.667, 0}, {16.238, -8.651}, {17.893, -16.645}, {20.548, -23.57}, {25.955, -30.796}, {32.333, -33.333}, {38.333, -33.5}, {38.333, -33.5}}, smooth = Smooth.Bezier),
           Polygon(fillColor = {255, 197, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{42.5, 33.5}, {42.5, 33.5}, {36.5, 33.333}, {30.122, 30.796}, {24.715, 23.57}, {22.06, 16.645}, {20.404, 8.651}, {19.833, 0}, {20.404, -8.651}, {22.06, -16.645}, {24.715, -23.57}, {30.122, -30.796}, {36.5, -33.333}, {42.5, -33.5}, {42.5, -33.5}}, smooth = Smooth.Bezier),
           Polygon(fillColor = {255, 182, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{46.667, 33.5}, {46.667, 33.5}, {40.667, 33.333}, {34.289, 30.796}, {28.882, 23.57}, {26.227, 16.645}, {24.571, 8.651}, {24, 0}, {24.571, -8.651}, {26.227, -16.645}, {28.882, -23.57}, {34.289, -30.796}, {40.667, -33.333}, {46.667, -33.5}, {46.667, -33.5}}, smooth = Smooth.Bezier),
           Polygon(fillColor = {255, 168, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{50.833, 33.5}, {50.833, 33.5}, {44.833, 33.333}, {38.455, 30.796}, {33.048, 23.57}, {30.393, 16.645}, {28.738, 8.651}, {28.167, 0}, {28.738, -8.651}, {30.393, -16.645}, {33.048, -23.57}, {38.455, -30.796}, {44.833, -33.333}, {50.833, -33.5}, {50.833, -33.5}}, smooth = Smooth.Bezier),
           Polygon(fillColor = {253, 154, 9}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{55, 33.5}, {55, 33.5}, {49, 33.333}, {42.622, 30.796}, {37.215, 23.57}, {34.56, 16.645}, {32.904, 8.651}, {32.333, 0}, {32.904, -8.651}, {34.56, -16.645}, {37.215, -23.57}, {42.622, -30.796}, {49, -33.333}, {55, -33.5}, {55, -33.5}}, smooth = Smooth.Bezier),
           Polygon(fillColor = {254, 127, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{59.167, 33.5}, {59.167, 33.5}, {53.167, 33.333}, {46.789, 30.796}, {41.382, 23.57}, {38.727, 16.645}, {37.071, 8.651}, {36.5, 0}, {37.071, -8.651}, {38.727, -16.645}, {41.382, -23.57}, {46.789, -30.796}, {53.167, -33.333}, {59.167, -33.5}, {59.167, -33.5}}, smooth = Smooth.Bezier),
           Polygon(fillColor = {254, 112, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{63.333, 33.5}, {63.333, 33.5}, {57.333, 33.333}, {50.955, 30.796}, {45.548, 23.57}, {42.894, 16.645}, {41.238, 8.651}, {40.667, 0}, {41.238, -8.651}, {42.894, -16.645}, {45.548, -23.57}, {50.955, -30.796}, {57.333, -33.333}, {63.333, -33.5}, {63.333, -33.5}}, smooth = Smooth.Bezier),
           Polygon(fillColor = {253, 96, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{67.5, 33.5}, {67.5, 33.5}, {61.5, 33.333}, {55.122, 30.796}, {49.715, 23.57}, {47.06, 16.645}, {45.404, 8.651}, {44.833, 0}, {45.404, -8.651}, {47.06, -16.645}, {49.715, -23.57}, {55.122, -30.796}, {61.5, -33.333}, {67.5, -33.5}, {67.5, -33.5}}, smooth = Smooth.Bezier),
           Polygon(fillColor = {253, 77, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{71.667, 33.5}, {71.667, 33.5}, {65.667, 33.333}, {59.289, 30.796}, {53.882, 23.57}, {51.227, 16.645}, {49.571, 8.651}, {49, 0}, {49.571, -8.651}, {51.227, -16.645}, {53.882, -23.57}, {59.289, -30.796}, {65.667, -33.333}, {71.667, -33.5}, {71.667, -33.5}}, smooth = Smooth.Bezier),
           Polygon(fillColor = {252, 52, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{74.5, 33.5}, {74.5, 33.5}, {69.833, 33.333}, {63.455, 30.796}, {58.048, 23.57}, {55.394, 16.645}, {53.738, 8.651}, {53.167, 0}, {53.738, -8.651}, {55.394, -16.645}, {58.048, -23.57}, {63.455, -30.796}, {69.833, -33.333}, {74, -33.5}, {74.5, -34}}, smooth = Smooth.Bezier),
           Polygon(fillColor = {251, 0, 7}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{74, 33.333}, {67.622, 30.796}, {62.215, 23.57}, {59.56, 16.645}, {57.904, 8.651}, {57.333, 0}, {57.904, -8.651}, {59.56, -16.645}, {62.215, -23.57}, {67.622, -30.796}, {74, -33.333}}, smooth = Smooth.Bezier),
           Polygon(lineColor = {107, 0, 4}, fillColor = {251, 0, 7}, fillPattern = FillPattern.Sphere, points = {{90.667, 0}, {90.096, 8.651}, {88.44, 16.645}, {85.785, 23.57}, {80.378, 30.796}, {74, 33.333}, {67.622, 30.796}, {62.215, 23.57}, {59.56, 16.645}, {57.904, 8.651}, {57.333, 0}, {57.904, -8.651}, {59.56, -16.645}, {62.215, -23.57}, {67.622, -30.796}, {74, -33.333}, {80.378, -30.796}, {85.785, -23.57}, {88.44, -16.645}, {90.096, -8.651}, {90.667, 0}}, smooth=Smooth.Bezier),
           Line(points = {{-76, 33.333}, {-76, 33.333}, {-82.378, 30.796}, {-87.785, 23.57}, {-90.44, 16.645}, {-92.096, 8.651}, {-92.667, 0}, {-92.096, -8.651}, {-90.44, -16.645}, {-87.785, -23.57}, {-82.378, -30.796}, {-76, -33.333}, {-76, -33.333}, {74, -33.333}, {74, -33.333}, {80.378, -30.796}, {85.785, -23.57}, {88.44, -16.645}, {90.096, -8.651}, {90.667, 0}, {90.096, 8.651}, {88.44, 16.645}, {85.785, 23.57}, {80.378, 30.796}, {74, 33.333}, {74, 33.333}, {-76, 33.333}}, color = {64, 64, 64}, arrowSize = 8, smooth = Smooth.Bezier)},
         coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10})),
       Documentation(info = "<html>
<p>
Model <strong>PipeWithScalarField</strong> visualizes a pipe and a scalar
field along the pipe axis. The latter is shown by mapping scalar
field to color values with a color map and utilizing this color
at the perimeter associated with the corresponding axis location.
Typically the scalar field value is a temperature, but might
be also another quantity.
Predefined color maps are available from
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps\">MultiBody.Visualizers.Colors.ColorMaps</a>
and can be selected via parameter \"colorMap\".
A color map with the corresponding scalar field values can be exported
as vector-graphics in svg-format with function
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.colorMapToSvg\">MultiBody.Visualizers.Colors.colorMapToSvg</a>.
The position and orientation of the center of the
circle at the left end of the pipe is defined via parameters
\"r_0\" and \"R\", respectively. The pipe axis is oriented along
the x-axis of the local coordinate system described by \"R\",
see figure below:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/PipeWithScalarField.png\">
</blockquote>

<p>
The color coding is shown in the next figure. It was generated with
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.colorMapToSvg\">MultiBody.Visualizers.Colors.colorMapToSvg</a>
using the following call:
</p>

<blockquote>
<pre>
colorMapToSvg(Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps.jet(),
              height=50, nScalars=6, T_max=100, caption=\"Temperature in C\");
</pre>
</blockquote>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/PipeWithScalarField-ColorMap.png\">
</blockquote>
</html>"));
    end PipeWithScalarField;

    package SurfaceCharacteristics "Functions returning surface descriptions"
        extends Modelica.Icons.FunctionsPackage;
      function torus "Function defining the surface characteristic of a torus"
        extends Modelica.Mechanics.MultiBody.Interfaces.partialSurfaceCharacteristic(
          final multiColoredSurface=false);
        input Modelica.SIunits.Radius ri=1 "Inner radius of torus" annotation(Dialog);
        input Modelica.SIunits.Radius ro=0.2 "Outer radius of torus (=width/2)" annotation(Dialog);
        input Modelica.SIunits.Angle opening=0 "Opening angle of torus" annotation(Dialog);
        input Modelica.SIunits.Angle startAngle= -Modelica.Constants.pi
          "Start angle of torus slice" annotation(Dialog);
        input Modelica.SIunits.Angle stopAngle= Modelica.Constants.pi
          "End angle of torus slice" annotation(Dialog);
      protected
        Modelica.SIunits.Angle alpha;
        Modelica.SIunits.Angle beta;
        Modelica.SIunits.Angle phi_start;
        Modelica.SIunits.Angle phi_stop;
      algorithm
        phi_start :=-Modelica.Constants.pi + opening;
        phi_stop  :=Modelica.Constants.pi - opening;
        for i in 1:nu loop
          alpha := startAngle + (stopAngle-startAngle)*(i-1)/(nu-1);
          for j in 1:nv loop
            beta := phi_start + (phi_stop-phi_start)*(j-1)/(nv-1);
            X[i,j] := (ri + ro*Modelica.Math.cos(beta))*Modelica.Math.sin(alpha);
            Y[i,j] := ro*Modelica.Math.sin(beta);
            Z[i,j] := (ri + ro*Modelica.Math.cos(beta))*Modelica.Math.cos(alpha);
          end for;
        end for;

        annotation (Documentation(info="<html>
<p>
Function <strong>torus</strong> computes the X, Y and Z arrays to visualize a torus
with model <a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Torus\">Torus</a>.
The left image below shows a torus with ri=0.5 m and ro = 0.2 m.
The right images below shows the torus with the additional parameter
settings:
</p>
<blockquote><pre>
opening    =   45 degree
startAngle = -135 degree
stopAngle  =  135 degree
</pre></blockquote>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/Torus.png\">
</blockquote>
</html>"));
      end torus;

      function pipeWithScalarField
        "Function defining the surface characteristic of a pipe where a scalar field value is displayed with color along the pipe axis"
        extends Modelica.Mechanics.MultiBody.Interfaces.partialSurfaceCharacteristic(
          final multiColoredSurface=true);
        input Modelica.SIunits.Radius rOuter "Outer radius of cylinder" annotation(Dialog);
        input Modelica.SIunits.Length length "Length of cylinder" annotation(Dialog);
        input Modelica.SIunits.Position xsi[:]
          "Relative position along the pipe with x[1] = 0, x[end] = 1" annotation(Dialog);
        input Real T[size(xsi,1)] "Scalar field value at position xsi*length" annotation(Dialog);
        input Real T_min "T <= T_min is mapped to colorMap[1,:]" annotation(Dialog);
        input Real T_max "T >= T_max is mapped to colorMap[end,:]" annotation(Dialog);
        input Real colorMap[:,3]
          "Color map to map scalar T to a corresponding color" annotation(Dialog);
      protected
        Real beta;
        Real xsi_i;
        Real Ti;
        Real Ci[3];
        Integer k;
      algorithm
        k:=1;
        for i in 1:nu loop
          // Compute actual xsi-position along cylinder axis
          xsi_i := (i-1)/(nu-1);

          // Interpolate in xsi and T to determine the corresponding value of Ti(xsi_i)
          (Ti,k) := Modelica.Math.Vectors.interpolate(xsi, T, xsi_i, k);

          // Map the scalar field value Ti to a color value
          Ci := Modelica.Mechanics.MultiBody.Visualizers.Colors.scalarToColor(
                  Ti, T_min, T_max, colorMap);

          // Determine outputs
          for j in 1:nv loop
            beta := 2*Modelica.Constants.pi*(j-1)/(nv-1);
            X[i,j] := length*xsi_i;
            Y[i,j] := rOuter*Modelica.Math.sin(beta);
            Z[i,j] := rOuter*Modelica.Math.cos(beta);
            C[i,j,:] := Ci;
          end for;
        end for;
        annotation (Documentation(info="<html>
<p>
Function <strong>pipeWithScalarField</strong> computes the X, Y, Z and C arrays in order to
visualize a pipe and a scalar field along the pipe axis with model
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced.PipeWithScalarField\">PipeWithScalarField</a>.
The latter is shown by mapping scalar
field to color values with a color map and utilizing this color
at the perimeter associated with the corresponding axis location.
Typically the scalar field value is a temperature, but might
be also another quantity.
Predefined color maps are available from
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps\">MultiBody.Visualizers.Colors.ColorMaps</a>
and can be selected via input argument \"colorMap\".
A color map with the corresponding scalar field values can be exported
as vector-graphics in svg-format with function
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.colorMapToSvg\">MultiBody.Visualizers.Colors.colorMapToSvg</a>.
An example is shown in the next figure:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/PipeWithScalarField.png\">
</blockquote>

<p>
The color coding is shown in the next figure. It was generated with
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.colorMapToSvg\">Mechanics.MultiBody.Visualizers.Colors.colorMapToSvg</a>
using the following call:
</p>

<blockquote>
<pre>
colorMapToSvg(Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps.jet(),
              height=50, nScalars=6, T_max=100, heading=\"Temperature in C\");
</pre>
</blockquote>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/PipeWithScalarField-ColorMap.png\">
</blockquote>
</html>"));
      end pipeWithScalarField;

      function rectangle "Function defining the surface characteristic of a planar rectangle"
        extends Modelica.Mechanics.MultiBody.Interfaces.partialSurfaceCharacteristic(
          final multiColoredSurface=false);
        input SI.Distance lu=1 "Length in direction u" annotation(Dialog);
        input SI.Distance lv=3 "Length in direction v" annotation(Dialog);
      algorithm
        X[:,:] := lu/2 * transpose(fill(linspace(-1,1,nu), nv));
        Y[:,:] := lv/2 * fill(linspace(-1,1,nv), nu);
        Z[:,:] := fill(0, nu, nv);

        annotation (Documentation(info="<html>
<p>
Function <strong>rectangle</strong> computes the X, Y and Z arrays to visualize a rectangle
with model <a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Rectangle\">Rectangle</a>.
The image below shows two rectangles of
</p>
<blockquote><pre>
nu = 8,
nv = 3,
lu = 3,
lv = 2.
</pre></blockquote>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/Rectangle.png\">
</blockquote>
</html>"));
      end rectangle;

      annotation (Documentation(info="<html>
<p>
This package contains functions that are used to define
parameterized surfaces for use with the
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced.Surface\">Surface</a>
model.
</p>
</html>"));
    end SurfaceCharacteristics;
    annotation (Documentation(info="<html>
<p>
Package <strong>Visualizers.Advanced</strong> contains components to visualize
3-dimensional shapes with dynamical sizes. None of the components
has a frame connector. The position and orientation is set via
modifiers. Basic knowledge of Modelica
is needed in order to utilize the components of this package.
These components have also to be used for models,
where the forces and torques in the frame connector are set via
equations (in this case, the models of the Visualizers package cannot be used,
since they all have frame connectors).
</p>
<h4>Content</h4>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced.Arrow\">Arrow</a></td>
      <td>Visualizing an arrow where all parts of the arrow can vary dynamically:<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/Arrow.png\" alt=\"model Visualizers.Advanced.Arrow\">
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced.DoubleArrow\">DoubleArrow</a></td>
      <td>Visualizing a double arrow where all parts of the arrow can vary dynamically:<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/DoubleArrow.png\" alt=\"model Visualizers.Advanced.DoubleArrow\">
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape\">Shape</a></td>
      <td>Visualizing an elementary object with variable size.
      The following shape types are supported:<br>&nbsp;<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/FixedShape.png\" alt=\"model Visualizers.Advanced.Shape\">
      </td>
  </tr>

  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced.Surface\">Surface</a></td>
      <td>Visualizing a moveable parameterized surface:<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/Surface_small.png\">
      </td>
  </tr>

  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced.PipeWithScalarField\">PipeWithScalarField</a></td>
      <td>Visualizing a pipe with a scalar field represented by a color coding:<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/PipeWithScalarFieldIcon.png\">
      </td>
  </tr>
</table>
</html>"));
  end Advanced;

  package Internal
    "Visualizers that will be replaced by improved versions in the future (do not use them)"

    extends Modelica.Icons.InternalPackage;

    model FixedLines
      "Visualizing a set of lines as cylinders (e.g., used to display characters)"

      import Modelica.Mechanics.MultiBody;
      import Modelica.Mechanics.MultiBody.Types;
      extends Modelica.Mechanics.MultiBody.Interfaces.PartialVisualizer;

      parameter Boolean animation=true "= true, if animation shall be enabled";
      input Real scale(min=0) = 1
        "The 'lines' are visualized 'scale' times bigger"
        annotation (Dialog(group="if animation = true", enable=animation));
      input SI.Position lines[:,2,2]={[0,0; 1,1],[0,1; 1,0]}
        "List of start and end points of cylinders resolved along n_x and n_y"
        annotation (Dialog(group="if animation = true", enable=animation));
      input SI.Distance diameter(min=0) = 0.05
        "Diameter of the cylinders defined by lines"
        annotation (Dialog(group="if animation = true", enable=animation));
      input SI.Position r_lines[3]={0,0,0}
        "Position vector from origin of frame_a to the origin of the 'lines' frame, resolved in frame_a"
        annotation (Dialog(group="if animation = true", enable=animation));
      input Real n_x[3](each final unit="1")={1,0,0}
        "Vector in direction of x-axis of 'lines' frame, resolved in frame_a."
        annotation (Dialog(group="if animation = true", enable=animation));
      input Real n_y[3](each final unit="1")={0,1,0}
        "Vector in direction of y-axis of 'lines' frame, resolved in frame_a."
        annotation (Dialog(group="if animation = true", enable=animation));
      input MultiBody.Types.Color color={0,128,255} "Color of cylinders"
        annotation (Dialog(colorSelector=true, group="if animation = true", enable=animation));
      input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient
        "Reflection of ambient light (= 0: light is completely absorbed)"
        annotation (Dialog(group="if animation = true", enable=animation));

    protected
      Lines x_label(
        lines=scale*lines,
        diameter=scale*diameter,
        color=color,
        specularCoefficient = specularCoefficient,
        r_lines=r_lines,
        n_x=n_x,
        n_y=n_y,
        r=frame_a.r_0,
        R=frame_a.R) if world.enableAnimation and animation;
    equation
      frame_a.f = zeros(3);
      frame_a.t = zeros(3);
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={128,128,128},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-150,145},{150,105}},
              textString="%name",
              textColor={0,0,255}),
            Polygon(
              points={{-82,-24},{-20,46},{-10,38},{-72,-32},{-82,-24}},
              lineColor={0,127,255},
              fillColor={0,127,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-24,-34},{-82,40},{-72,46},{-14,-26},{-24,-34}},
              lineColor={0,127,255},
              fillColor={0,127,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{42,-18},{10,40},{20,48},{50,-6},{42,-18}},
              lineColor={0,127,255},
              fillColor={0,127,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{10,-68},{84,48},{96,42},{24,-72},{10,-68}},
              lineColor={0,127,255},
              fillColor={0,127,255},
              fillPattern=FillPattern.Solid)}),
        Documentation(info="<html>
<p>
With model <strong>FixedLines</strong> a set of lines is defined
that are located relatively to frame_a. Every line
is represented by a cylinder. This allows to define simple shaped
3-dimensional characters. An example is shown in the
following figure:<br>&nbsp;
</p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/FixedLines.png\" alt=\"model Visualizers.FixedLines\">
<p>&nbsp;<br>
The two letters \"x\" and \"y\" are constructed with 4 lines
by providing the following data for parameter <strong>lines</strong>
</p>
<pre>
   lines = {[0, 0; 1, 1],[0, 1; 1, 0],[1.5, -0.5; 2.5, 1],[1.5, 1; 2, 0.25]}
</pre>
<p>
Via parameter vectors <strong>n_x</strong> and <strong>n_y</strong> a two-dimensional
coordinate system is defined. The points defined with parameter
<strong>lines</strong> are with respect to this coordinate system. For example
\"[0, 0; 1, 1]\" defines a line that starts at {0,0} and ends at {1,1}.
The diameter and color of all line cylinders are identical.
</p>
</html>"));
    end FixedLines;

    model Lines
      "Visualizing a set of lines as cylinders with variable size, e.g., used to display characters (no Frame connector)"

      import Modelica.Mechanics.MultiBody;
      import Modelica.Mechanics.MultiBody.Types;
      import Modelica.Mechanics.MultiBody.Frames;
      import T = Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
      input Modelica.Mechanics.MultiBody.Frames.Orientation R=Frames.nullRotation()
        "Orientation object to rotate the world frame into the object frame" annotation(Dialog);
      input SI.Position r[3]={0,0,0}
        "Position vector from origin of world frame to origin of object frame, resolved in world frame"
         annotation(Dialog);
      input SI.Position r_lines[3]={0,0,0}
        "Position vector from origin of object frame to the origin of 'lines' frame, resolved in object frame"
         annotation(Dialog);
      input Real n_x[3](each final unit="1")={1,0,0}
        "Vector in direction of x-axis of 'lines' frame, resolved in object frame"
         annotation(Dialog);
      input Real n_y[3](each final unit="1")={0,1,0}
        "Vector in direction of y-axis of 'lines' frame, resolved in object frame"
       annotation(Dialog);
      input SI.Position lines[:, 2, 2]=zeros(0, 2, 2)
        "List of start and end points of cylinders resolved in an x-y frame defined by n_x, n_y, e.g., {[0,0;1,1], [0,1;1,0], [2,0; 3,1]}"
      annotation(Dialog);
      input SI.Length diameter(min=0) = 0.05
        "Diameter of the cylinders defined by lines"
      annotation(Dialog);
      input Modelica.Mechanics.MultiBody.Types.Color color={0,128,255}
        "Color of cylinders"
      annotation(Dialog(colorSelector=true));
      input Types.SpecularCoefficient specularCoefficient = 0.7
        "Reflection of ambient light (= 0: light is completely absorbed)"
        annotation (Dialog);
    protected
      parameter Integer n=size(lines, 1) "Number of cylinders";
      T.Orientation R_rel=T.from_nxy(n_x, n_y);
      T.Orientation R_lines=T.absoluteRotation(R.T, R_rel);
      Modelica.SIunits.Position r_abs[3]=r + T.resolve1(R.T, r_lines);
      Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape cylinders[n](
        each shapeType="cylinder",
        lengthDirection={T.resolve1(R_rel, vector([lines[i, 2, :] - lines[i, 1,
             :]; 0])) for i in 1:n},
        length={Modelica.Math.Vectors.length(
                                        lines[i, 2, :] - lines[i, 1, :]) for i in
                1:n},
        r={r_abs + T.resolve1(R_lines, vector([lines[i, 1, :]; 0])) for i in 1:
            n},
        each width=diameter,
        each height=diameter,
        each widthDirection={0,1,0},
        each color=color,
        each R=R,
        each specularCoefficient=specularCoefficient);
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={128,128,128},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-24,-34},{-82,40},{-72,46},{-14,-26},{-24,-34}},
              lineColor={0,127,255},
              fillColor={0,127,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-82,-24},{-20,46},{-10,38},{-72,-32},{-82,-24}},
              lineColor={0,127,255},
              fillColor={0,127,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{42,-18},{10,40},{20,48},{50,-6},{42,-18}},
              lineColor={0,127,255},
              fillColor={0,127,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{10,-68},{84,48},{96,42},{24,-72},{10,-68}},
              lineColor={0,127,255},
              fillColor={0,127,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-150,145},{150,105}},
              textString="%name",
              textColor={0,0,255})}),
        Documentation(info="<html>
<p>
With model <strong>Lines</strong> a set of dynamic lines is defined
that are located relatively to frame_a. Every line
is represented by a cylinder. This allows, e.g., to define simple shaped
3-dimensional characters. Note, if the lines are fixed relatively to frame_a,
it is more convenient to use model <strong>Visualizers.FixedLines</strong>.
An example for dynamic lines is shown in the following figure:<br>&nbsp;
</p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/FixedLines.png\" alt=\"model Visualizers.FixedLines\">
<p>&nbsp;<br>
The two letters \"x\" and \"y\" are constructed with 4 lines
by providing the following data for input variable <strong>lines</strong>
</p>
<pre>
   lines = {[0, 0; 1, 1],[0, 1; 1, 0],[1.5, -0.5; 2.5, 1],[1.5, 1; 2, 0.25]}
</pre>
<p>
Via vectors <strong>n_x</strong> and <strong>n_y</strong> a two-dimensional
coordinate system is defined. The points defined with variable
<strong>lines</strong> are with respect to this coordinate system. For example
\"[0, 0; 1, 1]\" defines a line that starts at {0,0} and ends at {1,1}.
The diameter and color of all line cylinders are identical
and are defined by parameters.
</p>

</html>"));

    end Lines;

    annotation (Documentation(info="<html>
<p>
This package contains components to construct 3-dim. fonts
with \"cylinder\" elements for the animation window.
This is just a temporary hack until 3-dim. fonts are supported in
Modelica tools. The components are used to construct the \"x\", \"y\",
\"z\" labels of coordinates systems in the animation.
</p>
</html>"));
  end Internal;
  annotation (Documentation(info="<html>
<p>
Package <strong>Visualizers</strong> contains components to visualize
3-dimensional shapes. These components are the basis for the
animation features of the MultiBody library.
</p>
<h4>Content</h4>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.FixedShape\">FixedShape</a><br>
             <a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.FixedShape2\">FixedShape2</a></td>
      <td>Visualizing an elementary shape with dynamically varying shape attributes.
      FixedShape has one connector frame_a, whereas FixedShape2 has additionally
          a frame_b for easier connection to further visual objects.
          The following shape types are supported:<br>&nbsp;<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/FixedShape.png\" alt=\"model Visualizers.FixedShape\">
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.FixedFrame\">FixedFrame</a></td>
      <td>Visualizing a coordinate system including axes labels with fixed sizes:<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/FixedFrame2.png\"
       alt=\"model Visualizers.FixedFrame\">
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.FixedArrow\">FixedArrow</a>,<br>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.SignalArrow\">SignalArrow</a></td>
      <td>Visualizing an arrow. Model \"FixedArrow\" provides
      a fixed sized arrow, model \"SignalArrow\" provides
      an arrow with dynamically varying length that is defined
      by an input signal vector:<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/Arrow.png\">
      </td>
  </tr>

  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Ground\">Ground</a></td>
      <td>Visualizing the ground by a plane:<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/GroundSmall.png\">
      </td>
  </tr>

  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Torus\">Torus</a></td>
      <td>Visualizing a torus:<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/TorusIcon.png\">
      </td>
  </tr>

  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.VoluminousWheel\">VoluminousWheel</a></td>
      <td>Visualizing a wheel:<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/VoluminousWheelIcon.png\">
      </td>
  </tr>

  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.PipeWithScalarField\">PipeWithScalarField</a></td>
      <td>Visualizing a pipe with a scalar field represented by a color coding:<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/PipeWithScalarFieldIcon.png\">
      </td>
  </tr>

<tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced\">Advanced</a></td>
      <td> <strong>Package</strong> that contains components to visualize
          3-dimensional shapes where all parts of the shape
          can vary dynamically. Basic knowledge of Modelica is
          needed in order to utilize the components of this package.
      </td>
  </tr>
</table>
<p>
The colors of the visualization components are declared with
the predefined type <strong>MultiBody.Types.Color</strong>.
This is a vector with 3 elements,
{r, g, b}, and specifies the color of the shape.
{r,g,b} are the \"red\", \"green\" and \"blue\" color parts.
Note, r g, b are given as Integer[3] in the ranges 0&nbsp;&hellip;&nbsp;255,
respectively.
</p>
</html>"), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, initialScale = 0.1, grid = {10, 10}), graphics={  Polygon(origin = {4.391, -1}, lineColor = {128, 128, 128}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid, points = {{-14.391, 86}, {75.609, 66}, {15.609, 26}, {-84.391, 56}}),
           Polygon(origin = {18.391, -30}, lineColor = {128, 128, 128}, fillColor = {128, 128, 128}, fillPattern = FillPattern.Solid, points = {{61.609, 95}, {1.609, 55}, {1.609, -55}, {61.609, -5}}),
           Polygon(origin = {-11.843, -48.757}, lineColor = {128, 128, 128}, fillColor = {191, 191, 191}, fillPattern = FillPattern.Solid, points = {{31.843, 73.757}, {31.843, -36.243}, {-68.157, 3.757}, {-68.157, 103.757}})}));
end Visualizers;
