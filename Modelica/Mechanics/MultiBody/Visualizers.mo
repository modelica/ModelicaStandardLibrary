within Modelica.Mechanics.MultiBody;
package Visualizers "3-dimensional visual objects used for animation"
  extends Modelica.Icons.Library;

  model FixedShape
    "Animation shape of a part with fixed shape type and dynamically varying shape definition"
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
      annotation (Dialog(group="if animation = true", enable=animation));
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
<IMG SRC=\"../Images/MultiBody/Shape.png\" ALT=\"model Visualizers.FixedShape\">
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
  <td valign=\"top\">extra is the number of teeth of the gear.</td>
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
            extent={{-131,-65},{134,-104}},
            lineColor={0,0,0},
            textString="%shapeType"),
          Text(
            extent={{-131,118},{129,58}},
            textString="%name",
            lineColor={0,0,255})}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics));
  end FixedShape;

  model FixedShape2
    "Animation shape of a part with fixed shape type and dynamically varying shape definition with two frames"

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
      annotation (Dialog(group="if animation = true", enable=animation));
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
            extent={{-123,128},{137,68}},
            textString="%name",
            lineColor={0,0,255}),
          Text(
            extent={{129,-106},{-131,-56}},
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
<IMG SRC=\"../Images/MultiBody/Shape.png\" ALT=\"model Visualizers.FixedShape2\">
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
  <td valign=\"top\">extra is the number of teeth of the gear.</td>
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
<IMG SRC=\"../Images/MultiBody/FixedTranslation.png\" ALT=\"Parts.FixedTranslation\">
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
      annotation (Dialog(group="if animation = true", enable=animation));
    input Types.Color color_y=color_x "Color of y-arrow"
      annotation (Dialog(group="if animation = true", enable=animation));
    input Types.Color color_z=color_x "Color of z-arrow"
      annotation (Dialog(group="if animation = true", enable=animation));
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
            extent={{-138,164},{146,102}},
            textString="%name",
            lineColor={0,0,255})}),
      Documentation(info="<HTML>
<p>
Model <b>FixedFrame</b> visualizes the three axes of
its coordinate system <b>frame_a</b> together with appropriate axes
labels. A typical example is shown in the following figure:
<br>&nbsp;
</p>
<IMG SRC=\"../Images/MultiBody/FixedFrame.png\" ALT=\"model Visualizers.FixedFrame\">
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
      annotation (Dialog(group="if animation = true", enable=animation));
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
            extent={{-146,124},{142,62}},
            textString="%name",
            lineColor={0,0,255}),
          Text(
            extent={{-118,-74},{120,-112}},
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
<IMG SRC=\"../Images/MultiBody/Visualizers/Arrow.png\" ALT=\"model Visualizers.FixedArrow\">
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
      annotation (Dialog(group="if animation = true", enable=animation));
    input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient
      "Reflection of ambient light (= 0: light is completely absorbed)"
      annotation (Dialog(group="if animation = true", enable=animation));

    Modelica.Blocks.Interfaces.RealInput r_head[3](each final quantity="Position", each
        final unit =                                                                               "m")
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
            extent={{-146,124},{142,62}},
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
<IMG SRC=\"../Images/MultiBody/Visualizers/Arrow.png\" ALT=\"model Visualizers.SignalArrow\">
<p>
The tail of the arrow is defined with parameter <b>r_tail</b>
with respect to frame_a (vector from the origin of frame_a to the arrow tail).
</p>
</HTML>"));
  end SignalArrow;

   model Ground "Visualize ground (box in z=0)"
      parameter Boolean animation=true
      "= true, if animation of ground shall be enabled";
      parameter Modelica.SIunits.Position length = 10
      "Length and width of box (center is at x=y=0)"                  annotation (Dialog(enable=animation));
      parameter Modelica.SIunits.Position height = 0.02
      "Height of box (upper surface is at z=0, lower surface is at z=-height)"
                                                                        annotation (Dialog(enable=animation));
      parameter Modelica.Mechanics.MultiBody.Types.Color groundColor={0,255,0}
      "Color of box"    annotation (Dialog(enable=animation));

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
            extent={{-146,-96},{154,-136}},
            textString="%name",
            lineColor={0,0,255})}),             Diagram(coordinateSystem(
              preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
            graphics),
        Documentation(info="<html>
<p>
This shape visualizes the x-y plane by a box
</p>

</html>"));
   end Ground;

  package Advanced
    "Visualizers that require basic knowledge about Modelica in order to use them"

    extends Modelica.Icons.Library;
    model Arrow
      "Visualizing an arrow with variable size; all data have to be set as modifiers (see info layer)"

      import SI = Modelica.SIunits;
      import Modelica.Mechanics.MultiBody.Types;
      import Modelica.Mechanics.MultiBody.Frames;

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
        "Color of arrow" annotation(Dialog);
      input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient
        "Material property describing the reflecting of ambient light (= 0 means, that light is completely absorbed)"
                                                                                                            annotation(Dialog);

    protected
      outer Modelica.Mechanics.MultiBody.World world;
      SI.Length length=Modelica.Math.Vectors.length(
                                     r_head) "Length of arrow";
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
        r=arrowLine.rvisobj + arrowLine.rxvisobj*arrowLine.length,
        R=R) if world.enableAnimation;

      annotation (
        Documentation(info="<HTML>
<p>
Model <b>Arrow</b> defines an arrow that is dynamically
visualized at the defined location (see variables below).
</p>
<IMG SRC=\"../Images/MultiBody/Visualizers/Arrow.png\" ALT=\"model Visualizers.Advanced.Arrow\">
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
              extent={{-146,124},{142,62}},
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
        "Color of double arrow" annotation(Dialog);
      input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient
        "Material property describing the reflecting of ambient light (= 0 means, that light is completely absorbed)"
                                                                                                            annotation(Dialog);

    protected
      outer Modelica.Mechanics.MultiBody.World world;
      SI.Length length=Modelica.Math.Vectors.length(
                                     r_head) "Length of arrow";
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
        r=arrowLine.rvisobj + arrowLine.rxvisobj*arrowLine.length,
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
        r=arrowLine.rvisobj + arrowLine.rxvisobj*(arrowLine.length + 0.5*
            arrowHead1.length),
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
              extent={{-146,124},{142,62}},
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
<IMG SRC=\"../Images/MultiBody/Visualizers/DoubleArrow.png\" ALT=\"model Visualizers.Advanced.DoubleArrow\">
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
      "Different visual shapes with variable size; all data have to be set as modifiers (see info layer)"

       extends
        Modelica.Utilities.Internal.PartialModelicaServices.Animation.PartialShape;
       extends ModelicaServices.Animation.Shape;

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
              extent={{-100,-100},{80,60}},
              lineColor={0,0,0},
              textString="%shapeType"),
            Text(
              extent={{-132,160},{128,100}},
              textString="%name",
              lineColor={0,0,255})}),
         Documentation(info="<HTML>
<p>
Model <b>Shape</b> defines a visual shape that is
shown at the location of its reference coordinate system, called
'object frame' below. All describing variables such
as size and color can vary dynamically (with the only exception
of parameter shapeType). The default equations in the
declarations should be modified by providing appropriate equations.
Model <b>Shape</b> is usually used as a basic building block to
implement simpler to use graphical components.
</p>
<p>
The following shapes are supported via
parameter <b>shapeType</b> (e.g., shapeType=\"box\"):<br>&nbsp;
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
  <td valign=\"top\">extra is the number of teeth of the gear.</td>
</tr>
<tr>
  <td valign=\"top\">\"spring\"</td>
  <td valign=\"top\">extra is the number of windings of the spring.
      Additionally, \"height\" is <b>not</b> the \"height\" but
      2*coil-width.</td>
</tr>
</table>

<p>
Parameter <b>color</b> is an Integer vector with 3 elements,
{r, g, b}, and specifies the color of the shape.
{r,g,b} are the \"red\", \"green\" and \"blue\" color parts.
Note, r g, b are given in the range 0 .. 255.
The predefined type <b>MultiBody.Types.Color</b> contains
a menu definition of the colors used in the MultiBody
library (will be replaced by a color editor).
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
  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced.Arrow\">Arrow</a></td>
      <td valign=\"top\">Visualizing an arrow where all parts of the arrow can vary dynamically:<br>
      <IMG SRC=\"../Images/MultiBody/Visualizers/Arrow.png\" ALT=\"model Visualizers.Advanced.Arrow\">
      </td>
  </tr>
  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced.DoubleArrow\">DoubleArrow</a></td>
      <td valign=\"top\">Visualizing a double arrow where all parts of the arrow can vary dynamically:<br>
      <IMG SRC=\"../Images/MultiBody/Visualizers/DoubleArrow.png\" ALT=\"model Visualizers.Advanced.DoubleArrow\">
      </td>
  </tr>
  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape\">Shape</a></td>
      <td valign=\"top\">Animation shape of a part with dynamically varying sizes.
      The following shape types are supported:<br>&nbsp;<br>
      <IMG SRC=\"../Images/MultiBody/FixedShape.png\" ALT=\"model Visualizers.Advanced.Shape\">
      </td>
  </tr>
</table>
</HTML>"));
  end Advanced;

  package Internal
    "Visualizers that will be replaced by improved versions in the future (don't use them)"

    extends Modelica.Icons.Library;

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
        annotation (Dialog(group="if animation = true", enable=animation));
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
              extent={{-140,164},{148,102}},
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
<IMG SRC=\"../Images/MultiBody/FixedLines.png\" ALT=\"model Visualizers.FixedLines\">
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
      annotation(Dialog);
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
              extent={{-140,164},{148,102}},
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
<IMG SRC=\"../Images/MultiBody/FixedLines.png\" ALT=\"model Visualizers.FixedLines\">
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
  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Mechanics.MultiBody.Visualizers.FixedShape\">FixedShape</a><br>
             <a href=\"Modelica://Modelica.Mechanics.MultiBody.Visualizers.FixedShape2\">FixedShape2</a></td>
      <td valign=\"top\">Animation shape of a part with fixed sizes. FixedShape2 has additionally
          a frame_b for easier connection to further visual objects.
          The following shape types are supported:<br>&nbsp;<br>
      <IMG SRC=\"../Images/MultiBody/FixedShape.png\" ALT=\"model Visualizers.FixedShape\">
      </td>
  </tr>
  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Mechanics.MultiBody.Visualizers.FixedFrame\">FixedFrame</a></td>
      <td valign=\"top\">Visualizing a coordinate system including axes labels with fixed sizes:<br>
      <IMG SRC=\"../Images/MultiBody/FixedFrame2.png\"
       ALT=\"model Visualizers.FixedFrame\">
      </td>
  </tr>
  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Mechanics.MultiBody.Visualizers.FixedArrow\">FixedArrow</a>,<br>
<a href=\"Modelica://Modelica.Mechanics.MultiBody.Visualizers.SignalArrow\">SignalArrow</a></td>
      <td valign=\"top\">Visualizing an arrow. Model \"FixedArrow\" provides
      a fixed sized arrow, model \"SignalArrow\" provides
      an arrow with dynamically varying length that is defined
      by an input signal vector:<br>
      <IMG SRC=\"../Images/MultiBody/Visualizers/Arrow.png\" \">
      </td>
  </tr>
<tr><td valign=\"top\"><a href=\"Modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced\">Advanced</a></td>
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
