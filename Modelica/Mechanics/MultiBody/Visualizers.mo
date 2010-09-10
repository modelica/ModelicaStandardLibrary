within Modelica.Mechanics.MultiBody;
package Visualizers "3-dimensional visual objects used for animation"
  extends Modelica.Icons.Package;

  model FixedShape
    "Visualizing an elementary shape with dynamically varying shape attributes (has one frame connector)"
    import SI = Modelica.SIunits;
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
      annotation (Evaluate=true, Dialog(group="if animation = true", enable=animation));
    input Types.Axis widthDirection={0,1,0}
      "Vector in width direction of shape, resolved in frame_a"
      annotation (Evaluate=true, Dialog(group="if animation = true", enable=animation));
    input SI.Distance length(start=1) "Length of shape"
      annotation (Dialog(group="if animation = true", enable=animation));
    input SI.Distance width(start=0.1) "Width of shape"
      annotation (Dialog(group="if animation = true", enable=animation));
    input SI.Distance height(start=0.1) "Height of shape"
      annotation (Dialog(group="if animation = true", enable=animation));
    input Modelica.Mechanics.MultiBody.Types.Color color={0,128,255}
      "Color of shape"
      annotation (Dialog(__Dymola_colorSelector=true, group="if animation = true", enable=animation));
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
      Documentation(info="<HTML>
<p>
Model <b>FixedShape</b> defines a visual shape that is
shown at the location of its frame_a.
All describing data such as size and color can vary dynamically by
providing appropriate expressions in the input fields of the
parameter menu. The only exception is parameter shapeType
that cannot be changed during simulation.
The following shapes are currently supported via
parameter <b>shapeType</b> (e.g., shapeType=\"box\"):<br>&nbsp;
</p>
<IMG src=\"modelica://Modelica/Resources/Images/MultiBody/Shape.png\" ALT=\"model Visualizers.FixedShape\">
<p>&nbsp;<br>
The dark blue arrows in the figure above are directed along
variable <b>lengthDirection</b>. The light blue arrows are directed
along variable <b>widthDirection</b>. The <b>coordinate systems</b>
in the figure represent frame_a of the FixedShape component.
</p>
<p>
Additionally external shapes are specified as DXF-files
(only 3-dim.Face is supported). External shapes must be named \"1\", \"2\"
etc.. The corresponding definitions should be in files \"1.dxf\",
\"2.dxf\" etc.Since the DXF-files contain color and dimensions for
the individual faces, the corresponding information in the model
is currently ignored. The DXF-files must be found in the current directory.
</p>
<p>
The sizes of any of the above components are specified by the
<b>length</b>, <b>width</b> and <b>height</b> variables.
Via variable <b>extra</b> additional data can be defined:
</p>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th><b>shapeType</b></th><th>Meaning of parameter <b>extra</b></th></tr>
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
  <td valign=\"top\">extra is the number of teeth of the (external) gear.
If extra &lt; 0, an internal gear is visualized with |extra| teeth.
The axis of the gearwheel is along \"lengthDirection\", and usually:
width = height = 2*radiusOfGearWheel.</td>
</tr>
<tr>
  <td valign=\"top\">\"spring\"</td>
  <td valign=\"top\">extra is the number of windings of the spring.
      Additionally, \"height\" is <b>not</b> the \"height\" but
      2*coil-width.</td>
</tr>
</table>
<p>
Parameter <b>color</b> is a vector with 3 elements,
{r, g, b}, and specifies the color of the shape.
{r,g,b} are the \"red\", \"green\" and \"blue\" color parts.
Note, r g, b are given as Integer[3] in the ranges 0 .. 255,
respectively. The predefined type
<b>MultiBody.Types.Color</b> contains a temporary menu
definition of the colors used in the MultiBody library
(this will be replaced by a color editor).
</p>
</HTML>
"),   Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Polygon(
            points={{-100,33},{-100,-61},{-10,-41},{50,-61},{50,33},{-10,11},{-100,
                33}},
            lineColor={0,127,255},
            fillColor={0,127,255},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-98,34},{-64,46},{0,30},{74,56},{50,32},{-10,12},{-98,34}},
            lineColor={255,255,255},
            fillColor={160,160,164},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{72,54},{50,32},{50,-60},{72,-32},{72,54}},
            lineColor={255,255,255},
            fillColor={160,160,164},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-150,-65},{150,-95}},
            lineColor={0,0,0},
            textString="%shapeType"),
          Text(
            extent={{-150,100},{150,60}},
            textString="%name",
            lineColor={0,0,255})}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics));
  end FixedShape;

  model FixedShape2
    "Visualizing an elementary shape with dynamically varying shape attributes (has two frame connectors)"

    import SI = Modelica.SIunits;
    import Modelica.Mechanics.MultiBody.Frames;
    import Modelica.Mechanics.MultiBody.Types;

    Interfaces.Frame_a frame_a
      "Coordinate system a (all shape definition vectors are resolved in this frame)"
       annotation (Placement(transformation(extent={{-116,-16},{-84,16}},
            rotation=0)));
    Interfaces.Frame_b frame_b "Coordinate system b"
       annotation (Placement(transformation(extent={{84,-16},{116,16}},
            rotation=0)));

    parameter Boolean animation=true "= true, if animation shall be enabled";
    parameter Types.ShapeType shapeType="box" "Type of shape"
      annotation (Dialog(group="if animation = true", enable=animation));
    input SI.Position r[3]={1,0,0}
      "Vector from frame_a to frame_b resolved in frame_a";
    input SI.Position r_shape[3]={0,0,0}
      "Vector from frame_a to shape origin, resolved in frame_a"
      annotation (Dialog(group="if animation = true", enable=animation));
    input Types.Axis lengthDirection=r - r_shape
      "Vector in length direction of shape, resolved in frame_a"
      annotation (Evaluate=true, Dialog(group="if animation = true", enable=animation));
    input Types.Axis widthDirection={0,1,0}
      "Vector in width direction of shape, resolved in frame_a"
      annotation (Evaluate=true, Dialog(group="if animation = true", enable=animation));
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
      annotation (Dialog(__Dymola_colorSelector=true, group="if animation = true", enable=animation));
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
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Text(
            extent={{-150,115},{150,75}},
            textString="%name",
            lineColor={0,0,255}),
          Text(
            extent={{150,-90},{-150,-60}},
            lineColor={0,0,0},
            textString="%=r"),
          Polygon(
            points={{-100,50},{-100,-44},{-10,-24},{79,-43},{80,49},{-10,28},{-100,
                50}},
            lineColor={0,127,255},
            fillColor={0,127,255},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-101,50},{-65,62},{-1,46},{100,70},{79,49},{-11,28},{-101,
                50}},
            lineColor={255,255,255},
            fillColor={160,160,164},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-86,15},{-50,-10}},
            lineColor={0,0,0},
            textString="a"),
          Text(
            extent={{37,15},{73,-10}},
            lineColor={0,0,0},
            textString="b"),
          Polygon(
            points={{100,70},{78,48},{78,-44},{100,-16},{100,70}},
            lineColor={255,255,255},
            fillColor={160,160,164},
            fillPattern=FillPattern.Solid)}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics),
      Documentation(info="<HTML>
<p>
Model <b>FixedShape2</b> defines a visual shape that is
shown at the location of its frame_a. This model is identical
to <b>FixedShape</b> with the only difference that an
additional frame_b is present which is parallel to frame_a.
This makes it more convenient to connect several visual
shapes together when building up more complex visual
objects. All describing data such as size and color can vary dynamically by
providing appropriate expressions in the input fields of the
parameter menu. The only exception is parameter shapeType
that cannot be changed during simulation.
The following shapes are currently supported via
parameter <b>shapeType</b> (e.g., shapeType=\"box\"):<br>&nbsp;
</p>
<IMG src=\"modelica://Modelica/Resources/Images/MultiBody/Shape.png\" ALT=\"model Visualizers.FixedShape2\">
<p>&nbsp;<br>
The dark blue arrows in the figure above are directed along
variable <b>lengthDirection</b>. The light blue arrows are directed
along variable <b>widthDirection</b>. The <b>coordinate systems</b>
in the figure represent frame_a of the FixedShape component.
</p>
<p>
Additionally external shapes are specified as DXF-files
(only 3-dim.Face is supported). External shapes must be named \"1\", \"2\"
etc.. The corresponding definitions should be in files \"1.dxf\",
\"2.dxf\" etc.Since the DXF-files contain color and dimensions for
the individual faces, the corresponding information in the model
is currently ignored. The DXF-files must be found in the current directory.
</p>
<p>
The sizes of any of the above components are specified by the
<b>length</b>, <b>width</b> and <b>height</b> variables.
Via variable <b>extra</b> additional data can be defined:
</p>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th><b>shapeType</b></th><th>Meaning of parameter <b>extra</b></th></tr>
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
  <td valign=\"top\">extra is the number of teeth of the (external) gear.
If extra &lt; 0, an internal gear is visualized with |extra| teeth.
The axis of the gearwheel is along \"lengthDirection\", and usually:
width = height = 2*radiusOfGearWheel.</td>
</tr>
<tr>
  <td valign=\"top\">\"spring\"</td>
  <td valign=\"top\">extra is the number of windings of the spring.
      Additionally, \"height\" is <b>not</b> the \"height\" but
      2*coil-width.</td>
</tr>
</table>
<p>
Parameter <b>color</b> is a vector with 3 elements,
{r, g, b}, and specifies the color of the shape.
{r,g,b} are the \"red\", \"green\" and \"blue\" color parts.
Note, r g, b are given as Integer[3] in the ranges 0 .. 255,
respectively. The predefined type
<b>MultiBody.Types.Color</b> contains a temporary menu
definition of the colors used in the MultiBody library
(this will be replaced by a color editor).
</p>
<p>
In the following figure the relationships between
frame_a and frame_b are shown. The origin of frame_b
with respect to frame_a is specified via parameter
vector <b>r</b>.
</p>
<IMG src=\"modelica://Modelica/Resources/Images/MultiBody/FixedTranslation.png\" ALT=\"Parts.FixedTranslation\">
</HTML>
"));
  end FixedShape2;

  model FixedFrame
    "Visualizing a coordinate system including axes labels (visualization data may vary dynamically)"

    import SI = Modelica.SIunits;
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
      annotation (Dialog(__Dymola_colorSelector=true,group="if animation = true", enable=animation));
    input Types.Color color_y=color_x "Color of y-arrow"
      annotation (Dialog(__Dymola_colorSelector=true,group="if animation = true", enable=animation));
    input Types.Color color_z=color_x "Color of z-arrow"
      annotation (Dialog(__Dymola_colorSelector=true,group="if animation = true", enable=animation));
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
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,127,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-2,92},{-14,52},{12,52},{-2,92},{-2,92}},
            lineColor={0,191,0},
            fillColor={0,191,0},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-2,-18},{-2,52}},
            color={0,191,0},
            thickness=0.5),
          Text(
            extent={{16,93},{67,43}},
            lineColor={0,191,0},
            textString="y"),
          Text(
            extent={{43,11},{92,-38}},
            lineColor={0,0,0},
            textString="x"),
          Polygon(
            points={{98,-70},{74,-44},{64,-60},{98,-70}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-2,-18},{72,-54}},
            color={0,0,0},
            thickness=0.5),
          Line(
            points={{-72,-54},{-2,-18}},
            thickness=0.5,
            color={0,0,255}),
          Polygon(points={{-98,-68},{-66,-60},{-78,-46},{-98,-68}}, lineColor={
                0,0,255}),
          Text(
            extent={{-87,13},{-38,-36}},
            textString="z",
            lineColor={0,0,255}),
          Text(
            extent={{-150,145},{150,105}},
            textString="%name",
            lineColor={0,0,255})}),
      Documentation(info="<HTML>
<p>
Model <b>FixedFrame</b> visualizes the three axes of
its coordinate system <b>frame_a</b> together with appropriate axes
labels. A typical example is shown in the following figure:
<br>&nbsp;
</p>
<IMG src=\"modelica://Modelica/Resources/Images/MultiBody/FixedFrame.png\" ALT=\"model Visualizers.FixedFrame\">
<p>
The sizes of the axes, the axes colors and the specular coefficient
(= reflection factor for
ambient light) can vary dynamically by
providing appropriate expressions in the input fields of the
parameter menu.
</p>
</HTML>"),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics));
  end FixedFrame;

  model FixedArrow
    "Visualizing an arrow with dynamically varying size in frame_a"

    import SI = Modelica.SIunits;
    import Modelica.Mechanics.MultiBody.Types;
    extends Modelica.Mechanics.MultiBody.Interfaces.PartialVisualizer;
    parameter Boolean animation=true "= true, if animation shall be enabled";
    input SI.Position r_tail[3]={0,0,0}
      " Vector from frame_a to arrow tail, resolved in frame_a"
      annotation (Dialog(group="if animation = true", enable=animation));
    input Types.Axis n={1,0,0}
      " Vector in arrow direction, resolved in frame_a"
      annotation (Dialog(group="if animation = true", enable=animation));
    input SI.Length length=0.1 " Length of complete arrow"
      annotation (Dialog(group="if animation = true", enable=animation));
    input SI.Diameter diameter=world.defaultArrowDiameter
      " Diameter of arrow line" annotation (Dialog(group="if animation = true", enable=animation));
    input Types.Color color={0,0,255} " Color of arrow"
      annotation (Dialog(__Dymola_colorSelector=true, group="if animation = true", enable=animation));
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
            extent={{-100,28},{20,-30}},
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
            lineColor={0,0,255}),
          Text(
            extent={{-150,-75},{150,-105}},
            lineColor={0,0,0},
            textString="%length")}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}),
              graphics),
      Documentation(info="<html>
<p>
Model <b>FixedArrow</b> defines an arrow that is
shown at the location of its frame_a.
<br>&nbsp;
</p>
<IMG src=\"modelica://Modelica/Resources/Images/MultiBody/Visualizers/Arrow.png\" ALT=\"model Visualizers.FixedArrow\">
<p>
The direction of the arrow specified with vector
<b>n</b> is with respect to frame_a, i.e., the local frame to which the
arrow component is attached. The direction and length of the arrow, its diameter
and color can vary dynamically by
providing appropriate expressions in the input fields of the
parameter menu.
</p>
</html>"));
  end FixedArrow;

  model SignalArrow
    "Visualizing an arrow with dynamically varying size in frame_a based on input signal"

    import SI = Modelica.SIunits;
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
      annotation (Dialog(__Dymola_colorSelector=true, group="if animation = true", enable=animation));
    input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient
      "Reflection of ambient light (= 0: light is completely absorbed)"
      annotation (Dialog(group="if animation = true", enable=animation));

    Modelica.Blocks.Interfaces.RealInput r_head[3](each final quantity="Position", each final
              unit =                                                                               "m")
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
          Rectangle(
            extent={{-100,28},{20,-30}},
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
            lineColor={0,0,255}),
          Line(points={{0,-102},{0,-30}}, color={0,0,255})}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}),
              graphics),
      Documentation(info="<HTML>
<p>
Model <b>SignalArrow</b> defines an arrow that is dynamically visualized
at the location where its frame_a is attached. The
position vector from the tail to the head of the arrow,
resolved in frame_a, is defined via the signal vector of
the connector <b>r_head</b> (Real r_head[3]):<br>&nbsp;
</p>
<IMG src=\"modelica://Modelica/Resources/Images/MultiBody/Visualizers/Arrow.png\" ALT=\"model Visualizers.SignalArrow\">
<p>
The tail of the arrow is defined with parameter <b>r_tail</b>
with respect to frame_a (vector from the origin of frame_a to the arrow tail).
</p>
</HTML>"));
  end SignalArrow;

   model Ground "Visualizing the ground (box in z=0)"
      parameter Boolean animation=true
      "= true, if animation of ground shall be enabled";
      parameter Modelica.SIunits.Position length = 10
      "Length and width of box (center is at x=y=0)"                  annotation (Dialog(enable=animation));
      parameter Modelica.SIunits.Position height = 0.02
      "Height of box (upper surface is at z=0, lower surface is at z=-height)"
                                                                        annotation (Dialog(enable=animation));
      parameter Modelica.Mechanics.MultiBody.Types.Color groundColor={0,255,0}
      "Color of box"    annotation (Dialog(__Dymola_colorSelector=true, enable=animation));

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
          thickness=0.5,
          smooth=Smooth.None));
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={
            Polygon(
              points={{-20,60},{-100,-32},{20,-92},{100,8},{-20,60}},
              lineColor={0,0,0},
              smooth=Smooth.None,
              fillColor={0,255,0},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{2,82},{44,54}},
              lineColor={0,0,0},
              textString="z"),
            Polygon(
              points={{100,8},{100,-4},{20,-104},{20,-92},{100,8}},
              lineColor={0,0,0},
              smooth=Smooth.None,
              fillColor={0,255,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-100,-32},{-100,-44},{20,-104},{20,-92},{-100,-32}},
              lineColor={0,0,0},
              smooth=Smooth.None,
              fillColor={0,255,0},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-11,-7},{-1,-12}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-6,-10},{-6,88}},
              color={0,0,0},
              smooth=Smooth.None),
            Polygon(
              points={{-6,102},{-14,72},{2,72},{-6,102}},
              lineColor={0,0,0},
              smooth=Smooth.None,
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Text(
            extent={{-150,-105},{150,-145}},
            textString="%name",
            lineColor={0,0,255})}),             Diagram(coordinateSystem(
              preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
            graphics),
        Documentation(info="<html>
<p>
This shape visualizes the x-y plane by a box
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/MultiBody/Visualizers/Ground.png\">
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
      "Color of surface"  annotation(Dialog(enable=animation,__Dymola_colorSelector=true,group="Material properties", enable=not multiColoredSurface));
    input Types.SpecularCoefficient specularCoefficient = 0.7
      "Reflection of ambient light (= 0: light is completely absorbed)" annotation(Dialog(enable=animation,group="Material properties"));
    input Real transparency=0
      "Transparency of shape: 0 (= opaque) ... 1 (= fully transparent)"
                                 annotation(Dialog(enable=animation,group="Material properties"));
    parameter Integer n_ri=40 "Number of points along ri" annotation(Dialog(enable=animation,tab="Discretization"));
    parameter Integer n_ro=20 "Number of points along ro" annotation(Dialog(enable=animation,tab="Discretization"));

  protected
    Advanced.Surface surface( redeclare function surfaceCharacteristic =
          Modelica.Mechanics.MultiBody.Visualizers.Advanced.SurfaceCharacteristics.torus
          (   ri=ri, ro=ro, opening=opening, startAngle=startAngle, stopAngle=stopAngle),
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
    annotation (Icon(graphics={Bitmap(extent={{-98,98},{98,-98}}, fileName=
                "modelica://Modelica/Resources/Images/MultiBody/Visualizers/TorusIcon.png"),
            Text(
            extent={{-150,100},{150,140}},
            lineColor={0,0,255},
            textString="%name")}), Documentation(info="<html>
<p>
Model <b>Torus</b> visualizes a torus. The center of the torus is located at
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
<img src=\"modelica://Modelica/Resources/Images/MultiBody/Visualizers/Torus.png\">
</blockquote>
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
    import SI = Modelica.SIunits;
    extends Modelica.Mechanics.MultiBody.Interfaces.PartialVisualizer;

    parameter Boolean animation=true "= true, if animation shall be enabled";

    parameter SI.Radius rTire=0.25 "Radius of the tire";
    parameter SI.Radius rRim= 0.14 "Radius of the rim";
    parameter SI.Radius width=0.25 "Width of the tire";
    parameter SI.Radius rCurvature=0.30 "Radius of the curvature of the tire";

    parameter Modelica.Mechanics.MultiBody.Types.RealColor color={64,64,64}
      "Color of tire"  annotation(Dialog(enable=animation,__Dymola_colorSelector=true,group="Material properties", enable=not multiColoredSurface));
    parameter Types.SpecularCoefficient specularCoefficient = 0.5
      "Reflection of ambient light (= 0: light is completely absorbed)" annotation(Dialog(enable=animation,group="Material properties"));
    parameter Integer n_rTire=40 "Number of points along rTire" annotation(Dialog(enable=animation,tab="Discretization"));
    parameter Integer n_rCurvature=20 "Number of points along rCurvature" annotation(Dialog(enable=animation,tab="Discretization"));

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

      Visualizers.Advanced.Surface torus(redeclare function
        surfaceCharacteristic =
          Modelica.Mechanics.MultiBody.Visualizers.Advanced.SurfaceCharacteristics.torus
          (     ri=ri,
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
    annotation (Icon(graphics={
            Text(
            extent={{-150,100},{150,140}},
            lineColor={0,0,255},
            textString="%name"),
          Bitmap(extent={{-96,96},{102,-96}}, fileName=
                "modelica://Modelica/Resources/Images/MultiBody/Visualizers/VoluminousWheelIcon.png"),
          Rectangle(
            extent={{-96,8},{-18,-8}},
            lineColor={95,95,95},
            fillColor={215,215,215},
            fillPattern=FillPattern.HorizontalCylinder)}),
                                   Documentation(info="<html>
<p>
Model <b>VoluminousWheel</b> provides a simple visualization of a tire using
a torus and a pipe shape object. The center of the wheel is located at
connector frame_a (visualized by the red coordinate system in the figure below).
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/MultiBody/Visualizers/VoluminousWheel.png\">
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

    parameter Real xsi[:](min=0,max=1)= Modelica.Math.Vectors.relNodePositions(12)
      "[:] Relative position along the pipe with x[1] = 0, x[end] = 1"
      annotation(Dialog(enable=animation));
    input Real T[size(xsi,1)]
      "[:] Scalar values at position xsi*length (will be visualized by color)" annotation(Dialog(enable=animation));
    parameter Real T_min "Minimum value of T that corresponds to colorMap[1,:]"
                                                                                    annotation(Dialog(enable=animation));
    parameter Real T_max
      "Maximum value of T that corresponds to colorMap[end,:]"                       annotation(Dialog(enable=animation));
    replaceable function colorMap =
        Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps.jet
          constrainedby Modelica.Mechanics.MultiBody.Interfaces.partialColorMap
      "Function defining the color map"
            annotation(__Dymola_choicesAllMatching=true, Dialog(enable=animation,group="Color coding"));

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

    annotation (Icon(graphics={
            Text(
            extent={{-150,50},{150,90}},
            lineColor={0,0,255},
            textString="%name"), Bitmap(extent={{-100,58},{98,-62}}, fileName=
                "modelica://Modelica/Resources/Images/MultiBody/Visualizers/PipeWithScalarFieldIcon.png")}),
                                   Documentation(info="<html>
<p>
Model <b>PipeWithScalarField</b> visualizes a pipe and a scalar
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
Connecter frame_a of this component is located in the center of the
circle at the left side of the pipe and the pipe axis is oriented
along the x-axis of frame_a, see figure below in which frame_a is visualized
with a coordinate system:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/MultiBody/Visualizers/PipeWithScalarField.png\">
</blockquote>

<p>
The color coding is shown in the next figure. It was generated with
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.colorMapToSvg\">MultiBody.Visualizers.Colors.colorMapToSvg</a>
using the following call:
</p>

<blockquote>
<pre>
colorMapToSvg(Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMap.jet(),
              height=50, nScalars=6, T_max=100, caption=\"Temperature in C\");
</pre>
</blockquote>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/MultiBody/Visualizers/PipeWithScalarField-ColorMap.png\">
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

  package Colors "Library of functions operating on color"
    extends Modelica.Icons.Package;
    package ColorMaps "Library of functions returning color maps"
      extends Modelica.Icons.Package;

      function jet "Returns the \"jet\" color map"
      extends Modelica.Mechanics.MultiBody.Interfaces.partialColorMap;
      protected
         Real a=ceil(n_colors/4);
         Real d=1/a;
         Real v1[:]=if d >= 0.5 then {1} else if d >= 0.25 then  1-d:d:1 else 0.5+d:d:1;
         Real v2[:]=0+d:d:1;
         Real v3[:]=1-d:-d:0;
         Real v4[:]=1-d:-d:0.5;
         Real cm[integer(a)*4,3];
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
ColorMaps.<b>jet</b>();
ColorMaps.<b>jet</b>(n_colors=64);
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
<img src=\"modelica://Modelica/Resources/Images/MultiBody/Visualizers/Colors/jet.png\">
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
         Real cm[integer(a)*3,3];
      algorithm
       cm := 255*[v1, zeros(size(v1, 1)),zeros(size(v1, 1));
                                fill(1., size(v1, 1)), v1,zeros(size(v1, 1));
                                fill(1., size(v1, 1)),fill(1., size(v1, 1)),v1];
       colorMap:=cm[1:n_colors,:];

        annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
ColorMaps.<b>hot</b>();
ColorMaps.<b>hot</b>(n_colors=64);
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
<img src=\"modelica://Modelica/Resources/Images/MultiBody/Visualizers/Colors/hot.png\">
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
ColorMaps.<b>gray</b>();
ColorMaps.<b>gray</b>(n_colors=64);
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
<img src=\"modelica://Modelica/Resources/Images/MultiBody/Visualizers/Colors/gray.png\">
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
ColorMaps.<b>spring</b>();
ColorMaps.<b>spring</b>(n_colors=64);
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
<img src=\"modelica://Modelica/Resources/Images/MultiBody/Visualizers/Colors/spring.png\">
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
ColorMaps.<b>summer</b>();
ColorMaps.<b>summer</b>(n_colors=64);
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
<img src=\"modelica://Modelica/Resources/Images/MultiBody/Visualizers/Colors/summer.png\">
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
ColorMaps.<b>autumn</b>();
ColorMaps.<b>autumn</b>(n_colors=64);
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
<img src=\"modelica://Modelica/Resources/Images/MultiBody/Visualizers/Colors/autumn.png\">
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
ColorMaps.<b>winter</b>();
ColorMaps.<b>winter</b>(n_colors=64);
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
<img src=\"modelica://Modelica/Resources/Images/MultiBody/Visualizers/Colors/winter.png\">
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
<img src=\"modelica://Modelica/Resources/Images/MultiBody/Visualizers/Colors/ColorMaps.png\">
</blockquote>
</html>"));
    end ColorMaps;

    function colorMapToSvg
      "Save a color map on file in svg (scalable vector graphics) format"
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
Colors.<b>colorMapToSvg</b>(colorMap);
Colors.<b>colorMapToSvg</b>(colorMap,
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
such as the free <a href=\"http://inkscape.org\">Incscape</a>,
can be manipulated and can be exported in other graphic formats.
The following image was generated with a call to \"colorMapToSvg\", the
generated file was loaded in Incscape and exported in \"png\" format:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/MultiBody/Visualizers/Colors/jet.png\">
</blockquote>

<p>
The \"format\" argument defines the string formating according to
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
       least this wide and wider if necessary. If the converted number has <br>
       fewer characters it will be padded on the left (or the right depending<br>
       on &lt;flags&gt;) with blanks or 0 (depending on &lt;flags&gt;).</td></tr>
<tr>
  <td>&lt;precision&gt;</td>
  <td> The number of digits to be printed after the decimal point for <br>
       e, E, or f conversions, or the number of significant digits for <br>
       g or G conversions.</td></tr>
<tr>
  <td> &lt;conversion&gt;</td>
  <td> = \"e\": Exponential notation using a  lower case e<br>
       = \"E\": Exponential notation using an upper case E<br>
       = \"f\": Fixed point notation<br>
       = \"g\": Either \"e\" or \"f\"<br>
       = \"G\": Same as \"g\", but with upper case E</td></tr></table>
</table>
</blockquote>
</html>"));
    end colorMapToSvg;

    function scalarToColor "Map a scalar to a color using a color map"
      input Real T "Scalar value" annotation(Dialog);
      input Real T_min "T <= T_min is mapped to colorMap[1,:]" annotation(Dialog);
      input Real T_max "T >= T_max is mapped to colorMap[end,:]" annotation(Dialog);
      input Real colorMap[:,3] "Color map" annotation(Dialog);
      output Real color[3] "Color of scalar value T";
    algorithm
      color :=colorMap[integer((size(colorMap, 1) - 1)/(T_max - T_min)*
                                min((max(T,T_min) - T_min), T_max) + 1), :];
      annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
//Real T, T_min, T_max, colorMap[:,3];
Colors.<b>scalarToColor</b>(T, T_min, T_max, colorMap);
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
Every element must be in the range 0..255.
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

      import SI = Modelica.SIunits;
      import Modelica.Mechanics.MultiBody.Types;
      import Modelica.Mechanics.MultiBody.Frames;
      import T = Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;

      input Frames.Orientation R=Frames.nullRotation()
        "Orientation object to rotate the world frame into the arrow frame." annotation(Dialog);
      input SI.Position r[3]={0,0,0}
        "Position vector from origin of world frame to origin of arrow frame, resolved in world frame"
                                                                                                       annotation(Dialog);
      input SI.Position r_tail[3]={0,0,0}
        "Position vector from origin of arrow frame to arrow tail, resolved in arrow frame"
                                                                                            annotation(Dialog);
      input SI.Position r_head[3]={0,0,0}
        "Position vector from arrow tail to the head of the arrow, resolved in arrow frame"
                                                                                            annotation(Dialog);
      input SI.Diameter diameter=world.defaultArrowDiameter
        "Diameter of arrow line" annotation(Dialog);
      input Modelica.Mechanics.MultiBody.Types.Color color=Modelica.Mechanics.MultiBody.Types.Defaults.ArrowColor
        "Color of arrow" annotation(Dialog(__Dymola_colorSelector=true));
      input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient
        "Material property describing the reflecting of ambient light (= 0 means, that light is completely absorbed)"
                                                                                                            annotation(Dialog);

    protected
      outer Modelica.Mechanics.MultiBody.World world;
      SI.Length length=Modelica.Math.Vectors.length(r_head) "Length of arrow";
      Real e_x[3](each final unit="1", start={1,0,0}) = noEvent(if length < 1.e-10 then {1,0,0} else r_head/length);
      Real rxvisobj[3](each final unit="1") = transpose(R.T)*e_x
        "X-axis unit vector of shape, resolved in world frame"
          annotation (HideResult=true);
      SI.Position rvisobj[3] = r + T.resolve1(R.T, r_tail)
        "Position vector from world frame to shape frame, resolved in world frame"
          annotation (HideResult=true);

      Visualizers.Advanced.Shape arrowLine(
        length=noEvent(max(0, length - diameter*Types.Defaults.
            ArrowHeadLengthFraction)),
        width=diameter,
        height=diameter,
        lengthDirection=r_head,
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
        lengthDirection=r_head,
        widthDirection={0,1,0},
        shapeType="cone",
        color=color,
        specularCoefficient=specularCoefficient,
        r=rvisobj + rxvisobj*arrowLine.length,
        R=R) if world.enableAnimation;

      annotation (
        Documentation(info="<HTML>
<p>
Model <b>Arrow</b> defines an arrow that is dynamically
visualized at the defined location (see variables below).
</p>
<IMG src=\"modelica://Modelica/Resources/Images/MultiBody/Visualizers/Arrow.png\" ALT=\"model Visualizers.Advanced.Arrow\">
<p>
The variables under heading <b>Parameters</b> below
are declared as (time varying) <b>input</b> variables.
If the default equation is not appropriate, a corresponding
modifier equation has to be provided in the
model where an <b>Arrow</b> instance is used, e.g., in the form
</p>
<pre>
    Visualizers.Advanced.Arrow arrow(diameter = sin(time));
</pre>

<p>
Variable <b>color</b> is an Integer vector with 3 elements,
{r, g, b}, and specifies the color of the shape.
{r,g,b} are the \"red\", \"green\" and \"blue\" color parts.
Note, r g, b are given in the range 0 .. 255.
The predefined type <b>MultiBody.Types.Color</b> contains
a menu definition of the colors used in the MultiBody
library (will be replaced by a color editor).
</p>
</HTML>"),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Rectangle(
              extent={{-100,28},{20,-30}},
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
              lineColor={0,0,255})}),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}),
                graphics));
    end Arrow;

    model DoubleArrow
      "Visualizing a double arrow with variable size; all data have to be set as modifiers (see info layer)"

      import SI = Modelica.SIunits;
      import Modelica.Mechanics.MultiBody.Types;
      import Modelica.Mechanics.MultiBody.Frames;
      import T = Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;

      input Frames.Orientation R=Frames.nullRotation()
        "Orientation object to rotate the world frame into the arrow frame." annotation(Dialog);
      input SI.Position r[3]={0,0,0}
        "Position vector from origin of world frame to origin of arrow frame, resolved in world frame"
                                                                                                       annotation(Dialog);
      input SI.Position r_tail[3]={0,0,0}
        "Position vector from origin of arrow frame to double arrow tail, resolved in arrow frame"
                                                                                                   annotation(Dialog);
      input SI.Position r_head[3]={0,0,0}
        "Position vector from double arrow tail to the head of the double arrow, resolved in arrow frame"
                                                                                                          annotation(Dialog);
      input SI.Diameter diameter=world.defaultArrowDiameter
        "Diameter of arrow line" annotation(Dialog);
      input Modelica.Mechanics.MultiBody.Types.Color color=Modelica.Mechanics.MultiBody.Types.Defaults.ArrowColor
        "Color of double arrow" annotation(Dialog(__Dymola_colorSelector=true));
      input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient
        "Material property describing the reflecting of ambient light (= 0 means, that light is completely absorbed)"
                                                                                                            annotation(Dialog);

    protected
      outer Modelica.Mechanics.MultiBody.World world;
      SI.Length length=Modelica.Math.Vectors.length(r_head) "Length of arrow";
      Real e_x[3](each final unit="1", start={1,0,0}) = noEvent(if length < 1.e-10 then {1,0,0} else r_head/length);
      Real rxvisobj[3](each final unit="1") = transpose(R.T)*e_x
        "X-axis unit vector of shape, resolved in world frame"
          annotation (HideResult=true);
      SI.Position rvisobj[3] = r + T.resolve1(R.T, r_tail)
        "Position vector from world frame to shape frame, resolved in world frame"
          annotation (HideResult=true);

      SI.Length headLength=noEvent(max(0, min(length, diameter*MultiBody.Types.
          Defaults.ArrowHeadLengthFraction)));
      SI.Length headWidth=noEvent(max(0, diameter*MultiBody.Types.Defaults.
          ArrowHeadWidthFraction));
      Visualizers.Advanced.Shape arrowLine(
        length=noEvent(max(0, length - 1.5*diameter*MultiBody.Types.Defaults.
            ArrowHeadLengthFraction)),
        width=diameter,
        height=diameter,
        lengthDirection=r_head,
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
        lengthDirection=r_head,
        widthDirection={0,1,0},
        shapeType="cone",
        color=color,
        specularCoefficient=specularCoefficient,
        r=rvisobj + rxvisobj*arrowLine.length,
        R=R) if world.enableAnimation;
      Visualizers.Advanced.Shape arrowHead2(
        length=headLength,
        width=headWidth,
        height=headWidth,
        lengthDirection=r_head,
        widthDirection={0,1,0},
        shapeType="cone",
        color=color,
        specularCoefficient=specularCoefficient,
        r=rvisobj + rxvisobj*(arrowLine.length + 0.5*arrowHead1.length),
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
              lineColor={0,0,255}),
            Polygon(
              points={{0,60},{60,0},{0,-60},{0,60}},
              lineColor={128,128,128},
              fillColor={128,128,128},
              fillPattern=FillPattern.Solid)}),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}),
                graphics),
        Documentation(info="<HTML>
<p>
Model <b>DoubleArrow</b> defines a double arrow that is dynamically
visualized at the defined location (see variables below).
</p>
<IMG src=\"modelica://Modelica/Resources/Images/MultiBody/Visualizers/DoubleArrow.png\" ALT=\"model Visualizers.Advanced.DoubleArrow\">
<p>
The variables under heading <b>Parameters</b> below
are declared as (time varying) <b>input</b> variables.
If the default equation is not appropriate, a corresponding
modifier equation has to be provided in the
model where an <b>Arrow</b> instance is used, e.g., in the form
</p>
<pre>
    Visualizers.Advanced.DoubleArrow doubleArrow(diameter = sin(time));
</pre>
<p>
Variable <b>color</b> is an Integer vector with 3 elements,
{r, g, b}, and specifies the color of the shape.
{r,g,b} are the \"red\", \"green\" and \"blue\" color parts.
Note, r g, b are given in the range 0 .. 255.
The predefined type <b>MultiBody.Types.Color</b> contains
a menu definition of the colors used in the MultiBody
library (will be replaced by a color editor).
</p>
</HTML>"));
    end DoubleArrow;

    model Shape
      "Visualizing an elementary object with variable size; all data have to be set as modifiers (see info layer)"

       extends ModelicaServices.Animation.Shape;
       extends
        Modelica.Utilities.Internal.PartialModelicaServices.Animation.PartialShape;

        annotation (
         Icon(coordinateSystem(
             preserveAspectRatio=true,
             extent={{-100,-100},{100,100}},
             grid={2,2}), graphics={
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
              lineColor={0,0,0},
              textString="%shapeType"),
            Text(
              extent={{-150,150},{150,110}},
              lineColor={0,0,255},
              textString="%name")}),
         Documentation(info="<HTML>
<p>
Model <b>Shape</b> defines a visual shape that is
shown at the location of its reference coordinate system, called
'object frame' below. All describing variables such
as size and color can vary dynamically (with the only exception
of parameter shapeType). The default equations in the
declarations should be modified by providing appropriate modifier
quations. Model <b>Shape</b> is usually used as a basic building block to
implement simpler to use graphical components.
</p>
<p>
The following shapes are supported via
parameter <b>shapeType</b> (e.g., shapeType=\"box\"):<br>&nbsp;
</p>

<p>
<IMG src=\"modelica://Modelica/Resources/Images/MultiBody/Shape.png\" ALT=\"model Visualizers.FixedShape\">
</p>

<p>&nbsp;<br>
The dark blue arrows in the figure above are directed along
variable <b>lengthDirection</b>. The light blue arrows are directed
along variable <b>widthDirection</b>. The <b>coordinate systems</b>
in the figure represent frame_a of the Shape component.
</p>
<p>
Additionally, external shapes are specified as DXF-files
(only 3-dim. Face is supported). External shapes must be named \"1\", \"2\", ... \"N\".
The corresponding definitions should be in files \"1.dxf\",
\"2.dxf\" etc. Since the DXF-files contain color and dimensions for
the individual faces, the corresponding information in the model
is currently ignored. The DXF-files must be found either in the current
directory or in the directory where the Shape instance is stored
that references the DXF file.
</p>

<p>
Via input variable <b>extra</b> additional sizing data is defined
according to:
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
  <td valign=\"top\">extra is the number of teeth of the (external) gear.
If extra &lt; 0, an internal gear is visualized with |extra| teeth.
The axis of the gearwheel is along \"lengthDirection\", and usually:
width = height = 2*radiusOfGearWheel.</td>
</tr>
<tr>
  <td valign=\"top\">\"spring\"</td>
  <td valign=\"top\">extra is the number of windings of the spring.
      Additionally, \"height\" is <b>not</b> the \"height\" but
      2*coil-width.</td>
</tr>
</table>

<p>
Parameter <b>color</b> is a Real vector with 3 elements,
{r, g, b}, and specifies the color of the shape.
{r,g,b} are the \"red\", \"green\" and \"blue\" color parts.
Note, r g, b are given in the range 0 .. 255.
The predefined type <b>MultiBody.Types.Color</b> contains
a menu definition of the colors used in the MultiBody
library.
</p>

<p>
The variables under heading <b>Parameters</b> below
are declared as (time varying) <b>input</b> variables.
If the default equation is not appropriate, a corresponding
modifier equation has to be provided in the
model where a <b>Shape</b> instance is used, e.g., in the form
</p>
<pre>
    Visualizers.Advanced.Shape shape(length = sin(time));
</pre>
</HTML>
"));
    end Shape;

    model Surface
      "Visualizing a moveable, parameterized surface; the surface characteristic is provided by a function"
      extends Modelica.Mechanics.MultiBody.Icons.Surface;
      extends
        Modelica.Utilities.Internal.PartialModelicaServices.Animation.PartialSurface;
      extends ModelicaServices.Animation.Surface;
    equation

      annotation (Icon(graphics={Polygon(
              points={{-102,40},{-98,92},{28,-8},{96,146},{104,-118},{-18,-34},{-52,
                  -130},{-102,40}},
              lineColor={0,0,255},
              smooth=Smooth.Bezier,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-150,140},{150,100}},
              lineColor={0,0,255},
              textString="%name")}), Documentation(info="<html>
<p>
Model <b>Surface</b> defines a moveable, parametrized surface in 3-dim. space
that is used for animation. This object is specified by:
</p>

<ul>
<li> The surface frame (orientation object \"R\" and origin \"r_0\")
     in which the data is specified.</li>
<li> A set of two parameters, one in u- and one in v-direction,
     that defines the control points. </li>
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
<img src=\"modelica://Modelica/Resources/Images/MultiBody/Visualizers/Surface.png\">
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

      parameter Real xsi[:](min=0,max=1)= Modelica.Math.Vectors.relNodePositions(12)
        "[:] Relative position along the pipe with x[1] = 0, x[end] = 1"
        annotation(Dialog(group="Color coding"));
      input Real T[size(xsi,1)]
        "[:] Scalar values at position xsi*length (will be visualized by color)"
                                                                                                       annotation(Dialog(group="Color coding"));
      parameter Real T_min
        "Minimum value of T that corresponds to colorMap[1,:]"                    annotation(Dialog(group="Color coding"));
      parameter Real T_max
        "Maximum value of T that corresponds to colorMap[end,:]"                       annotation(Dialog(group="Color coding"));
      parameter Integer n_colors=64 "Number of colors in the colorMap" annotation(Dialog(group="Color coding"));
      replaceable function colorMap =
          Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps.jet
            constrainedby
        Modelica.Mechanics.MultiBody.Interfaces.partialColorMap
        "Function defining the color map"
              annotation(__Dymola_choicesAllMatching=true, Dialog(group="Color coding"));
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
            Modelica.Mechanics.MultiBody.Visualizers.Advanced.SurfaceCharacteristics.pipeWithScalarField
            (rOuter=rOuter,
             length=length,
             xsi=xsi,
             T=T,
             T_min=T_min,
             T_max=T_max,
             colorMap=colorMapData))
        annotation (Placement(transformation(extent={{-20,2},{0,22}})));
      annotation (Icon(graphics={Bitmap(extent={{-99,60},{99,-60}}, fileName=
                  "modelica://Modelica/Resources/Images/MultiBody/Visualizers/PipeWithScalarFieldIcon.png"),
              Text(
              extent={{-150,54},{150,94}},
              lineColor={0,0,255},
              textString="%name")}), Documentation(info="<html>
<p>
Model <b>PipeWithScalarField</b> visualizes a pipe and a scalar
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
<img src=\"modelica://Modelica/Resources/Images/MultiBody/Visualizers/PipeWithScalarField.png\">
</blockquote>

<p>
The color coding is shown in the next figure. It was generated with
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.colorMapToSvg\">MultiBody.Visualizers.Colors.colorMapToSvg</a>
using the following call:
</p>

<blockquote>
<pre>
colorMapToSvg(Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMap.jet(),
              height=50, nScalars=6, T_max=100, caption=\"Temperature in C\");
</pre>
</blockquote>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/MultiBody/Visualizers/PipeWithScalarField-ColorMap.png\">
</blockquote>
</html>"));
    end PipeWithScalarField;

    package SurfaceCharacteristics "Functions returning surface descriptions"
        extends Modelica.Icons.Package;
      function torus "Function defining the surface characteristic of a torus"
        extends
          Modelica.Mechanics.MultiBody.Interfaces.partialSurfaceCharacteristic(
                  final multiColoredSurface=false);
        input Modelica.SIunits.Radius ri=1 "Inner radius of torus" annotation(Dialog);
        input Modelica.SIunits.Radius ro=0.2 "Outer radius of torus (=width/2)"
                                                                                annotation(Dialog);
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
                X[i,j] := (ri + ro*cos(beta))*sin(alpha);
                Y[i,j] := ro*sin(beta);
                Z[i,j] := (ri + ro*cos(beta))*cos(alpha);
            end for;
        end for;
        annotation (Documentation(info="<html>
<p>
Function <b>torus</b> computes the X,Y,Z arrays to visualize a torus
with model <a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Torus\">Torus</a>.
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
<img src=\"modelica://Modelica/Resources/Images/MultiBody/Visualizers/Torus.png\">
</blockquote>
</html>"));
      end torus;

      function pipeWithScalarField
        "Function defining the surface characteristic of a pipe where a scalar field value is displayed with color along the pipe axis"
        import C = Modelica.Constants;
        extends
          Modelica.Mechanics.MultiBody.Interfaces.partialSurfaceCharacteristic(
                  final multiColoredSurface=true);
        input Modelica.SIunits.Radius rOuter "Outer radius of cylinder" annotation(Dialog);
        input Modelica.SIunits.Length length "Length of cylinder"  annotation(Dialog);
        input Modelica.SIunits.Position xsi[:]
          "Relative position along the pipe with x[1] = 0, x[end] = 1"                                       annotation(Dialog);
        input Real T[size(xsi,1)] "Scalar field value at position xsi*length" annotation(Dialog);
        input Real T_min "T <= T_min is mapped to colorMap[1,:]" annotation(Dialog);
        input Real T_max "T >= T_max is mapped to colorMap[end,:]" annotation(Dialog);
        input Real colorMap[:,3]
          "Color map to map scalar T to a corresponding color"                                                annotation(Dialog);
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
              Y[i,j] := rOuter*sin(beta);
              Z[i,j] := rOuter*cos(beta);
              C[i,j,:] := Ci;
           end for;
        end for;
        annotation (Documentation(info="<html>
<p>
Function <b>pipeWithScalarField</b> computes the X,Y,Z,C arrays in order to
visualize a pipe and a scalar field along the pipe axis with model
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced.PipeWithScalarField\">PipeWithScalarField</a>.
The latter is shown by mapping scalar
field to color values with a color map and utilizing this color
at the perimeter associated with the corresponding axis location.
Typically the scalar field value is a temperature, but might
be also another quantity.
Predefined color maps are available from
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Color.ColorMaps\">MultiBody.Visualizers.Colors.ColorMaps</a>
and can be selected via input argument \"colorMap\".
A color map with the corresponding scalar field values can be exported
as vector-graphics in svg-format with function
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Color.colorMapToSvg\">MultiBody.Visualizers.Colors.colorMapToSvg</a>.
An example is shown in the next figure:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/MultiBody/Visualizers/PipeWithScalarField.png\">
</blockquote>

<p>
The color coding is shown in the next figure. It was generated with
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.colorMapToSvg\">Mechanics.MultiBody.Visualizers.Colors.colorMapToSvg</a>
using the following call:
</p>

<blockquote>
<pre>
colorMapToSvg(Modelica.Mechanics.MultiBody.Visualizer.Colors.ColorMap.jet(),
              height=50, nScalars=6, T_max=100, heading=\"Temperature in C\");
</pre>
</blockquote>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/MultiBody/Visualizers/PipeWithScalarField-ColorMap.png\">
</blockquote>
</html>"));
      end pipeWithScalarField;
      annotation (Documentation(info="<html>
<p>
This package contains functions that are used to define
parameterized surfaces for use with the
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced.Surface\">Surface</a>
model.
</p>
</html>"));
    end SurfaceCharacteristics;
    annotation ( Documentation(info="<HTML>
<p>
Package <b>Visualizers.Advanced</b> contains components to visualize
3-dimensional shapes with dynamical sizes. None of the components
has a frame connector. The position and orientation is set via
modifiers. Basic knowledge of Modelica
is needed in order to utilize the components of this package.
These components have also to be used for models,
where the forces and torques in the frame connector are set via
equations (in this case, the models of the Visualizers package cannot be used,
since they all have frame connectors).
<p>
<h4>Content</h4>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td valign=\"top\"><a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced.Arrow\">Arrow</a></td>
      <td valign=\"top\">Visualizing an arrow where all parts of the arrow can vary dynamically:<br>
      <IMG src=\"modelica://Modelica/Resources/Images/MultiBody/Visualizers/Arrow.png\" ALT=\"model Visualizers.Advanced.Arrow\">
      </td>
  </tr>
  <tr><td valign=\"top\"><a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced.DoubleArrow\">DoubleArrow</a></td>
      <td valign=\"top\">Visualizing a double arrow where all parts of the arrow can vary dynamically:<br>
      <IMG src=\"modelica://Modelica/Resources/Images/MultiBody/Visualizers/DoubleArrow.png\" ALT=\"model Visualizers.Advanced.DoubleArrow\">
      </td>
  </tr>
  <tr><td valign=\"top\"><a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape\">Shape</a></td>
      <td valign=\"top\">Visualizing an elementary object with variable size.
      The following shape types are supported:<br>&nbsp;<br>
      <IMG src=\"modelica://Modelica/Resources/Images/MultiBody/FixedShape.png\" ALT=\"model Visualizers.Advanced.Shape\">
      </td>
  </tr>

  <tr><td valign=\"top\"><a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced.Surface\">Surface</a></td>
      <td valign=\"top\">Visualizing a moveable parameterized surface:<br>
      <IMG src=\"modelica://Modelica/Resources/Images/MultiBody/Visualizers/Surface_small.png\">
      </td>
  </tr>

  <tr><td valign=\"top\"><a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced.PipeWithScalarField\">PipeWithScalarField</a></td>
      <td valign=\"top\">Visualizing a pipe with a scalar field represented by a color coding:<br>
      <IMG src=\"modelica://Modelica/Resources/Images/MultiBody/Visualizers/PipeWithScalarFieldIcon.png\">
      </td>
  </tr>
</table>
</HTML>"));
  end Advanced;

  package Internal
    "Visualizers that will be replaced by improved versions in the future (don't use them)"

    extends Modelica.Icons.Package;

    model FixedLines
      "Visualizing a set of lines as cylinders (e.g., used to display characters)"

      import SI = Modelica.SIunits;
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
      input MultiBody.Types.Color color={0,128,255} " Color of cylinders"
        annotation (Dialog(__Dymola_colorSelector=true, group="if animation = true", enable=animation));
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
              lineColor={0,0,255}),
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
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}),
                graphics),
        Documentation(info="<HTML>
<p>
With model <b>FixedLines</b> a set of lines is defined
that are located relatively to frame_a. Every line
is represented by a cylinder. This allows to define simple shaped
3-dimensional characters. An example is shown in the
following figure:<br>&nbsp;
</p>
<IMG src=\"modelica://Modelica/Resources/Images/MultiBody/FixedLines.png\" ALT=\"model Visualizers.FixedLines\">
<p>&nbsp;<br>
The two letters \"x\" and \"y\" are constructed with 4 lines
by providing the following data for parameter <b>lines</b>
</p>
<pre>
   lines = {[0, 0; 1, 1],[0, 1; 1, 0],[1.5, -0.5; 2.5, 1],[1.5, 1; 2, 0.25]}
</pre>
<p>
Via parameter vectors <b>n_x</b> and <b>n_y</b> a two-dimensional
coordinate system is defined. The points defined with parameter
<b>lines</b> are with respect to this coordinate system. For example
\"[0, 0; 1, 1]\" defines a line that starts at {0,0} and ends at {1,1}.
The diameter and color of all line cylinders are identical.
</p>
</HTML>"));
    end FixedLines;

    model Lines
      "Visualizing a set of lines as cylinders with variable size, e.g., used to display characters (no Frame connector)"

      import SI = Modelica.SIunits;
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
      annotation(Dialog(__Dymola_colorSelector=true));
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
              lineColor={0,0,255})}),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}),
                graphics),
        Documentation(info="<HTML>
<p>
With model <b>Lines</b> a set of dynamic lines is defined
that are located relatively to frame_a. Every line
is represented by a cylinder. This allows, e.g., to define simple shaped
3-dimensional characters. Note, if the lines are fixed relatively to frame_a,
it is more convenient to use model <b>Visualizers.FixedLines</b>.
An example for dynamic lines is shown in the following figure:<br>&nbsp;
</p>
<IMG src=\"modelica://Modelica/Resources/Images/MultiBody/FixedLines.png\" ALT=\"model Visualizers.FixedLines\">
<p>&nbsp;<br>
The two letters \"x\" and \"y\" are constructed with 4 lines
by providing the following data for input variable <b>lines</b>
</p>
<pre>
   lines = {[0, 0; 1, 1],[0, 1; 1, 0],[1.5, -0.5; 2.5, 1],[1.5, 1; 2, 0.25]}
</pre>
<p>
Via vectors <b>n_x</b> and <b>n_y</b> a two-dimensional
coordinate system is defined. The points defined with variable
<b>lines</b> are with respect to this coordinate system. For example
\"[0, 0; 1, 1]\" defines a line that starts at {0,0} and ends at {1,1}.
The diameter and color of all line cylinders are identical
and are defined by parameters.
</p>

</HTML>
"));

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
  annotation ( Documentation(info="<HTML>
<p>
Package <b>Visualizers</b> contains components to visualize
3-dimensional shapes. These components are the basis for the
animation features of the MultiBody library.
<p>
<h4>Content</h4>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td valign=\"top\"><a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.FixedShape\">FixedShape</a><br>
             <a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.FixedShape2\">FixedShape2</a></td>
      <td valign=\"top\">Visualizing an elementary shape with dynamically varying shape attributes.
      FixedShape has one connector frame_a, whereas FixedShape2 has additionally
          a frame_b for easier connection to further visual objects.
          The following shape types are supported:<br>&nbsp;<br>
      <IMG src=\"modelica://Modelica/Resources/Images/MultiBody/FixedShape.png\" ALT=\"model Visualizers.FixedShape\">
      </td>
  </tr>
  <tr><td valign=\"top\"><a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.FixedFrame\">FixedFrame</a></td>
      <td valign=\"top\">Visualizing a coordinate system including axes labels with fixed sizes:<br>
      <IMG src=\"modelica://Modelica/Resources/Images/MultiBody/FixedFrame2.png\"
       ALT=\"model Visualizers.FixedFrame\">
      </td>
  </tr>
  <tr><td valign=\"top\"><a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.FixedArrow\">FixedArrow</a>,<br>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.SignalArrow\">SignalArrow</a></td>
      <td valign=\"top\">Visualizing an arrow. Model \"FixedArrow\" provides
      a fixed sized arrow, model \"SignalArrow\" provides
      an arrow with dynamically varying length that is defined
      by an input signal vector:<br>
      <IMG src=\"modelica://Modelica/Resources/Images/MultiBody/Visualizers/Arrow.png\">
      </td>
  </tr>

  <tr><td valign=\"top\"><a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Ground\">Ground</a></td>
      <td valign=\"top\">Visualizing the x-y plane by a box:<br>
      <IMG src=\"modelica://Modelica/Resources/Images/MultiBody/Visualizers/GroundSmall.png\">
      </td>
  </tr>

  <tr><td valign=\"top\"><a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Torus\">Torus</a></td>
      <td valign=\"top\">Visualizing a torus:<br>
      <IMG src=\"modelica://Modelica/Resources/Images/MultiBody/Visualizers/TorusIcon.png\">
      </td>
  </tr>

  <tr><td valign=\"top\"><a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.VoluminousWheel\">VoluminousWheel</a></td>
      <td valign=\"top\">Visualizing a wheel:<br>
      <IMG src=\"modelica://Modelica/Resources/Images/MultiBody/Visualizers/VoluminousWheelIcon.png\">
      </td>
  </tr>

  <tr><td valign=\"top\"><a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.PipeWithScalarField\">PipeWithScalarField</a></td>
      <td valign=\"top\">Visualizing a pipe with a scalar field represented by a color coding:<br>
      <IMG src=\"modelica://Modelica/Resources/Images/MultiBody/Visualizers/PipeWithScalarFieldIcon.png\">
      </td>
  </tr>

<tr><td valign=\"top\"><a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced\">Advanced</a></td>
      <td valign=\"top\"> <b>Package</b> that contains components to visualize
          3-dimensional shapes where all parts of the shape
          can vary dynamically. Basic knowledge of Modelica is
          needed in order to utilize the components of this package.
      </td>
  </tr>
</table>
<p>
The colors of the visualization components are declared with
the predefined type <b>MultiBody.Types.Color</b>.
This is a vector with 3 elements,
{r, g, b}, and specifies the color of the shape.
{r,g,b} are the \"red\", \"green\" and \"blue\" color parts.
Note, r g, b are given as Integer[3] in the ranges 0 .. 255,
respectively.
</p>
</HTML>"));
end Visualizers;
