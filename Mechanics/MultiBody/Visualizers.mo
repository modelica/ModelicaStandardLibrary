package Visualizers "3-dimensional visual objects" 
  extends Modelica.Icons.Library;
  
  annotation (preferedView="info", Documentation(info="<HTML>
<p>
Package <b>Visualizers</b> contains components to visualize
3-dimensional shapes. These components are the basis for the
animation features of the MultiBody library.
<p>
<h4>Content</h4>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td><b><a href=\"Modelica://Modelica.Mechanics.MultiBody.Visualizers.FixedShape\">FixedShape</a><br>
             <a href=\"Modelica://Modelica.Mechanics.MultiBody.Visualizers.FixedShape2\">FixedShape2</a></b></td>
      <td>Animation shape of a part with fixed sizes. FixedShape2 has additionally
          a frame_b for easier connection to further visual objects.
          The following shape types are supported:<br>&nbsp;<br>
      <IMG SRC=\"../Images/MultiBody/FixedShape.png\" ALT=\"model Visualizers.FixedShape\">
      </td>
  </tr>
  <tr><td><b><a href=\"Modelica://Modelica.Mechanics.MultiBody.Visualizers.FixedFrame\">FixedFrame</a></b></td>
      <td>Visualizing a coordinate system including axes labels with fixed sizes:<br>
      <IMG SRC=\"../Images/MultiBody/FixedFrame2.png\"
       ALT=\"model Visualizers.FixedFrame\">
      </td>
  </tr>
  <tr><td><b><a href=\"Modelica://Modelica.Mechanics.MultiBody.Visualizers.FixedArrow\">FixedArrow</a>,<br>
<a href=\"Modelica://Modelica.Mechanics.MultiBody.Visualizers.SignalArrow\">SignalArrow</a></b></td>
      <td>Visualizing an arrow. Model \"FixedArrow\" provides
      a fixed sized arrow, model \"SignalArrow\" provides
      an arrow with dynamically varying length that is defined
      by an input signal vector:<br>
      <IMG SRC=\"../Images/MultiBody/Visualizers/Arrow.png\" \">
      </td>
  </tr>
<tr><td><b><a href=\"Modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced\">Advanced</a></b></td>
      <td> <b>Package</b> that contains components to visualize
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
  
  model FixedShape "Fixed animation shape of a part" 
    import SI = Modelica.SIunits;
    extends Modelica.Mechanics.MultiBody.Interfaces.PartialVisualizer;
    
    annotation (
      preferedView="info",
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.02,
        y=0,
        width=0.79,
        height=0.89),
      Documentation(info="<HTML>
<p>
Model <b>FixedShape</b> defines a visual shape that is
shown at the location of its frame_a.
The following shapes are currently supported via
parameter <b>shapeType</b> (e.g., shapeType=\"box\"):<br>&nbsp;
</p>
<IMG SRC=\"../Images/MultiBody/Shape.png\" ALT=\"model Visualizers.FixedShape\">
<p>&nbsp;<br>
The dark blue arrows in the figure above are directed along
parameter <b>lengthDirection</b>. The light blue arrows are directed
along parameter <b>widthDirection</b>. The <b>coordinate systems</b> 
in the figure represent frame_a of the FixedShape component.
</p>
<p>
Additionally external shapes are specified as DXF-files
(only 3DFace is supported). External shapes must be named \"1\", \"2\"
etc.. The corresponding definitions should be in files \"1.dxf\",
\"2.dxf\" etc.Since the DXF-files contain color and dimensions for
the individual faces, the corresponding information in the model
is currently ignored. The DXF-files must be found in the current directory.
</p>
<p>
The sizes of any of the above components are specified by the
<b>length</b>, <b>width</b> and <b>height</b> parameters.
Via parameter <b>extra</b> additional data can be defined:
</p>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th><b>shapeType</b></th><th>Meaning of parameter <b>extra</b></th></tr>
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
"),   Icon(
        Polygon(points=[-100, 33; -100, -61; -10, -41; 50, -61; 50, 33; -10, 11;
               -100, 33], style(
            color=69,
            fillColor=69,
            fillPattern=1)),
        Polygon(points=[-98, 34; -64, 46; 0, 30; 74, 56; 50, 32; -10, 12; -98,
              34], style(
            color=7,
            fillColor=9,
            fillPattern=1)),
        Polygon(points=[72, 54; 50, 32; 50, -60; 72, -32; 72, 54], style(
            color=7,
            fillColor=9,
            fillPattern=1)),
        Text(
          extent=[-131, -65; 134, -104],
          style(color=0),
          string="%shapeType"),
        Text(extent=[-131, 118; 129, 58], string="%name")),
      Diagram);
    
    parameter Boolean animation=true "= true, if animation shall be enabled";
    parameter Modelica.Mechanics.MultiBody.Types.ShapeType shapeType="box" 
      "|if animation = true| Type of shape";
    parameter SI.Position r_shape[3]={0,0,0} 
      "|if animation = true| Vector from frame_a to shape origin, resolved in frame_a.";
    parameter Modelica.Mechanics.MultiBody.Types.Axis lengthDirection={1,0,0} 
      "|if animation = true| Vector in length direction of shape, resolved in frame_a"
      annotation (Evaluate=true);
    parameter Modelica.Mechanics.MultiBody.Types.Axis widthDirection={0,1,0} 
      "|if animation = true| Vector in width direction of shape, resolved in frame_a"
      annotation (Evaluate=true);
    parameter SI.Distance length=1 "|if animation = true| Length of shape";
    parameter SI.Distance width=0.1 "|if animation = true| Width of shape";
    parameter SI.Distance height=0.1 "|if animation = true| Height of shape";
    parameter Modelica.Mechanics.MultiBody.Types.Color color={0,128,255} 
      "|if animation = true| Color of shape.";
    parameter Real extra=0.0 
      "|if animation = true| Additional parameter for cylinder, cone, pipe, gearwheel and spring (see docu)";
    
  protected 
    parameter Integer ndim=if world.enableAnimation and animation then 1 else 0;
    Visualizers.Advanced.Shape vis[ndim](
      each r_shape=r_shape,
      each length=length,
      each width=width,
      each height=height,
      each lengthDirection=lengthDirection,
      each widthDirection=widthDirection,
      each shapeType=shapeType,
      each color=color,
      each extra=extra,
      each r=frame_a.r_0,
      each R=frame_a.R);
  equation 
    // No forces and torques
    frame_a.f = zeros(3);
    frame_a.t = zeros(3);
  end FixedShape;
  
  model FixedShape2 
    "Fixed animation shape of a part and fixed translation of frame_b with respect to frame_a" 
    
    import SI = Modelica.SIunits;
    Interfaces.Frame_a frame_a annotation (extent=[-120, -15; -100, 15]);
    Interfaces.Frame_b frame_b annotation (extent=[100, -15; 120, 15]);
    
    parameter Boolean animation=true "= true, if animation shall be enabled";
    parameter SI.Position r[3]={1,0,0} 
      "Vector from frame_a to frame_b resolved in frame_a";
    parameter Modelica.Mechanics.MultiBody.Types.ShapeType shapeType="box" 
      "|if animation = true| Type of shape";
    parameter SI.Position r_shape[3]={0,0,0} 
      "|if animation = true| Vector from frame_a to shape origin, resolved in frame_a";
    parameter Modelica.Mechanics.MultiBody.Types.Axis lengthDirection=r - r_shape 
      "|if animation = true| Vector in length direction of shape, resolved in frame_a"
      annotation (Evaluate=true);
    parameter Modelica.Mechanics.MultiBody.Types.Axis widthDirection={0,1,0} 
      "|if animation = true| Vector in width direction of shape, resolved in frame_a"
      annotation (Evaluate=true);
    parameter SI.Length length=Frames.length(r - r_shape) 
      "|if animation = true| Length of shape";
    parameter SI.Distance width=0.1 "|if animation = true| Width of shape";
    parameter SI.Distance height=width "|if animation = true| Height of shape.";
    parameter Real extra=0.0 
      "|if animation = true| Additional parameter for cylinder, cone, pipe, gearwheel and spring (see docu)";
    parameter Modelica.Mechanics.MultiBody.Types.Color color={0,128,255} 
      "|if animation = true| Color of shape";
    annotation (
      preferedView="info",
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.25,
        y=0.04,
        width=0.67,
        height=0.69),
      Icon(
        Text(extent=[-123, 128; 137, 68], string="%name"),
        Text(
          extent=[129, -106; -131, -56],
          string="%=r",
          style(color=0)),
        Polygon(points=[-100, 50; -100, -44; -10, -24; 79, -43; 80, 49; -10, 28;
               -100, 50], style(
            color=69,
            fillColor=69,
            fillPattern=1)),
        Polygon(points=[-101, 50; -65, 62; -1, 46; 100, 70; 79, 49; -11, 28; -101,
               50], style(
            color=7,
            fillColor=9,
            fillPattern=1)),
        Text(
          extent=[-99, 15; -63, -10],
          string="a",
          style(color=0)),
        Text(
          extent=[45, 16; 81, -9],
          string="b",
          style(color=0)),
        Polygon(points=[100, 70; 78, 48; 78, -44; 100, -16; 100, 70], style(
            color=7,
            fillColor=9,
            fillPattern=1))),
      Diagram(Line(points=[-100, -4; -100, -69], style(color=10)), Line(points=
              [100, -3; 100, -68], style(color=10))),
      Documentation(info="<HTML>
<p>
Model <b>FixedShape2</b> defines a visual shape that is
shown at the location of its frame_a. This model is identical
to <b>FixedShape</b> with the only difference that an 
additional frame_b is present which is parallel to frame_a.
This makes it more convenient to connect several visual 
shapes together when building up more complex visual
objects. The following shapes are currently supported via
parameter <b>shapeType</b> (e.g., shapeType=\"box\"):<br>&nbsp;
</p>
<IMG SRC=\"../Images/MultiBody/Shape.png\" ALT=\"model Visualizers.FixedShape2\">
<p>&nbsp;<br>
The dark blue arrows in the figure above are directed along
parameter <b>lengthDirection</b>. The light blue arrows are directed
along parameter <b>widthDirection</b>. The <b>coordinate systems</b> 
in the figure represent frame_a of the FixedShape component.
</p>
<p>
Additionally external shapes are specified as DXF-files
(only 3DFace is supported). External shapes must be named \"1\", \"2\"
etc.. The corresponding definitions should be in files \"1.dxf\",
\"2.dxf\" etc.Since the DXF-files contain color and dimensions for
the individual faces, the corresponding information in the model
is currently ignored. The DXF-files must be found in the current directory.
</p>
<p>
The sizes of any of the above components are specified by the
<b>length</b>, <b>width</b> and <b>height</b> parameters.
Via parameter <b>extra</b> additional data can be defined:
</p>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th><b>shapeType</b></th><th>Meaning of parameter <b>extra</b></th></tr>
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
  protected 
    outer Modelica.Mechanics.MultiBody.World world;
    parameter Integer ndim=if world.enableAnimation and animation then 1 else 0;
    Visualizers.Advanced.Shape shape[ndim](
      each shapeType=shapeType,
      each color=color,
      each r_shape=r_shape,
      each lengthDirection=lengthDirection,
      each widthDirection=widthDirection,
      each length=length,
      each width=width,
      each height=height,
      each extra=extra,
      each r=frame_a.r_0,
      each R=frame_a.R);
  equation 
    defineBranch(frame_a.R, frame_b.R);
    assert(cardinality(frame_a) > 0 or cardinality(frame_b) > 0, "Neither connector frame_a nor frame_b of 
MultiBody.Visualizers.FixedShape2 object is connected");
    
    frame_b.r_0 = frame_a.r_0 + Frames.resolve1(frame_a.R, r);
    frame_b.R = frame_a.R;
    
    /* Force and torque balance */
    zeros(3) = frame_a.f + frame_b.f;
    zeros(3) = frame_a.t + frame_b.t + cross(r, frame_b.f);
  end FixedShape2;
  
  model FixedFrame "Visualizing a coordinate system including axes labels" 
    
    import SI = Modelica.SIunits;
    extends Modelica.Mechanics.MultiBody.Interfaces.PartialVisualizer;
    parameter Boolean animation=true "= true, if animation shall be enabled";
    parameter Boolean showLabels=true 
      "|if animation = true| = true, if labels shall be shown";
    parameter SI.Distance length=0.5 
      "|if animation = true| Length of axes arrows";
    parameter SI.Distance diameter=length/world.defaultFrameDiameterFraction 
      "|if animation = true| Diameter of axes arrows";
    parameter Modelica.Mechanics.MultiBody.Types.Color color_x=Modelica.Mechanics.MultiBody.Types.Defaults.FrameColor 
      "|if animation = true| Color of x-arrow";
    parameter Modelica.Mechanics.MultiBody.Types.Color color_y=color_x 
      "|if animation = true| Color of y-arrow";
    parameter Modelica.Mechanics.MultiBody.Types.Color color_z=color_x 
      "|if animation = true| Color of z-arrow";
    
  protected 
    parameter Integer ndim=if world.enableAnimation and animation then 1 else 0;
    parameter Integer ndim2=if world.enableAnimation and animation and 
        showLabels then 1 else 0;
    
    // Parameters to define axes
    parameter SI.Length headLength=min(length, diameter*Types.Defaults.
        FrameHeadLengthFraction);
    parameter SI.Length headWidth=diameter*Types.Defaults.
        FrameHeadWidthFraction;
    parameter SI.Length lineLength=max(0, length - headLength);
    parameter SI.Length lineWidth=diameter;
    
    // Parameters to define axes labels
    parameter SI.Length scaledLabel=Types.Defaults.FrameLabelHeightFraction*
        diameter;
    parameter SI.Length labelStart=1.05*length;
    
    // x-axis
    Visualizers.Advanced.Shape x_arrowLine[ndim](
      each shapeType="cylinder",
      each length=lineLength,
      each width=lineWidth,
      each height=lineWidth,
      each lengthDirection={1,0,0},
      each widthDirection={0,1,0},
      each color=color_x,
      each r=frame_a.r_0,
      each R=frame_a.R,
      each specularCoefficient=0);
    Visualizers.Advanced.Shape x_arrowHead[ndim](
      each shapeType="cone",
      each length=headLength,
      each width=headWidth,
      each height=headWidth,
      each lengthDirection={1,0,0},
      each widthDirection={0,1,0},
      each color=color_x,
      each r=frame_a.r_0 + Frames.resolve1(frame_a.R, {lineLength,0,0}),
      each R=frame_a.R,
      each specularCoefficient=0);
    Visualizers.Internal.Lines x_label[ndim2](
      each lines=scaledLabel*{[0, 0; 1, 1],[0, 1; 1, 0]},
      each diameter=diameter,
      each color=color_x,
      each r_lines={labelStart,0,0},
      each n_x={1,0,0},
      each n_y={0,1,0},
      each r=frame_a.r_0,
      each R=frame_a.R,
      each specularCoefficient=0);
    
    // y-axis
    Visualizers.Advanced.Shape y_arrowLine[ndim](
      each shapeType="cylinder",
      each length=lineLength,
      each width=lineWidth,
      each height=lineWidth,
      each lengthDirection={0,1,0},
      each widthDirection={1,0,0},
      each color=color_y,
      each r=frame_a.r_0,
      each R=frame_a.R,
      each specularCoefficient=0);
    Visualizers.Advanced.Shape y_arrowHead[ndim](
      each shapeType="cone",
      each length=headLength,
      each width=headWidth,
      each height=headWidth,
      each lengthDirection={0,1,0},
      each widthDirection={1,0,0},
      each color=color_y,
      each r=frame_a.r_0 + Frames.resolve1(frame_a.R, {0,lineLength,0}),
      each R=frame_a.R,
      each specularCoefficient=0);
    Visualizers.Internal.Lines y_label[ndim2](
      each lines=scaledLabel*{[0, 0; 1, 1.5],[0, 1.5; 0.5, 0.75]},
      each diameter=diameter,
      each color=color_y,
      each r_lines={0,labelStart,0},
      each n_x={0,1,0},
      each n_y={-1,0,0},
      each r=frame_a.r_0,
      each R=frame_a.R,
      each specularCoefficient=0);
    
    // z-axis
    Visualizers.Advanced.Shape z_arrowLine[ndim](
      each shapeType="cylinder",
      each length=lineLength,
      each width=lineWidth,
      each height=lineWidth,
      each lengthDirection={0,0,1},
      each widthDirection={0,1,0},
      each color=color_z,
      each r=frame_a.r_0,
      each R=frame_a.R,
      each specularCoefficient=0);
    Visualizers.Advanced.Shape z_arrowHead[ndim](
      each shapeType="cone",
      each length=headLength,
      each width=headWidth,
      each height=headWidth,
      each lengthDirection={0,0,1},
      each widthDirection={0,1,0},
      each color=color_z,
      each r=frame_a.r_0 + Frames.resolve1(frame_a.R, {0,0,lineLength}),
      each R=frame_a.R,
      each specularCoefficient=0);
    Visualizers.Internal.Lines z_label[ndim2](
      each lines=scaledLabel*{[0, 0; 1, 0],[0, 1; 1, 1],[0, 1; 1, 0]},
      each diameter=diameter,
      each color=color_z,
      each r_lines={0,0,labelStart},
      each n_x={0,0,1},
      each n_y={0,1,0},
      each r=frame_a.r_0,
      each R=frame_a.R,
      each specularCoefficient=0);
  equation 
    
    frame_a.f = zeros(3);
    frame_a.t = zeros(3);
    annotation (
      preferedView="info",
      Icon(
        Rectangle(extent=[-100, 100; 100, -100], style(color=69, fillColor=7)),
        Polygon(points=[-2, 92; -14, 52; 12, 52; -2, 92; -2, 92], style(
            color=58,
            fillColor=58,
            fillPattern=1)),
        Line(points=[-2, -18; -2, 52], style(
            color=58,
            thickness=2,
            fillColor=58)),
        Text(
          extent=[16, 93; 67, 43],
          string="y",
          style(color=58, fillColor=58)),
        Text(
          extent=[43, 11; 92, -38],
          style(color=0),
          string="x"),
        Polygon(points=[98, -70; 74, -44; 64, -60; 98, -70], style(
            color=0,
            fillColor=0,
            fillPattern=1)),
        Line(points=[-2, -18; 72, -54], style(color=0, thickness=2)),
        Line(points=[-72, -54; -2, -18], style(thickness=2)),
        Polygon(points=[-98, -68; -66, -60; -78, -46; -98, -68], style(
              fillPattern=1)),
        Text(extent=[-87, 13; -38, -36], string="z"),
        Text(
          extent=[-138, 164; 146, 102],
          string="%name",
          style(fillColor=7))),
      Documentation(info="<HTML>
<p>
Model <b>FixedFrame</b> visualizes the three axes of
its coordinate system <b>frame_a</b> together with appropriate axes
labels. A typical example is shown in the following figure:
<br>&nbsp;
</p>
<IMG SRC=\"../Images/MultiBody/FixedFrame.png\" ALT=\"model Visualizers.FixedFrame\">
<p>
The sizes of the axes and the labels as well as their colors
can be set by parameters.
</p>
</HTML>"),
      Diagram,
      Coordsys(grid=[1, 1], component=[20, 20]));
    
  end FixedFrame;
  
  model FixedArrow "Visualizing an arrow with constant size in frame_a" 
    
    import SI = Modelica.SIunits;
    extends Modelica.Mechanics.MultiBody.Interfaces.PartialVisualizer;
    parameter Boolean animation=true "= true, if animation shall be enabled";
    parameter SI.Position r_tail[3]={0,0,0} 
      "|if animation = true| Vector from frame_a to arrow tail, resolved in frame_a";
    parameter Modelica.Mechanics.MultiBody.Types.Axis n={1,0,0} 
      "|if animation = true| Vector in arrow direction, resolved in frame_a";
    parameter SI.Length length=0.1 
      "|if animation = true| Length of complete arrow";
    parameter SI.Diameter diameter=world.defaultArrowDiameter 
      "|if animation = true| Diameter of arrow line";
    parameter Modelica.Mechanics.MultiBody.Types.Color color={0,0,255} 
      "|if animation = true| Color of arrow";
  protected 
    parameter Integer ndim=if world.enableAnimation and animation then 1 else 0;
    parameter SI.Length headLength=min(length, diameter*Types.Defaults.
        ArrowHeadLengthFraction);
    parameter SI.Length headWidth=diameter*Types.Defaults.
        ArrowHeadWidthFraction;
    parameter SI.Length lineLength=max(0, length - headLength);
    Visualizers.Advanced.Shape arrowLine[ndim](
      each shapeType="cylinder",
      each length=lineLength,
      each width=diameter,
      each height=diameter,
      each lengthDirection=n,
      each widthDirection={0,1,0},
      each color=color,
      each r_shape=r_tail,
      each r=frame_a.r_0,
      each R=frame_a.R);
    Visualizers.Advanced.Shape arrowHead[ndim](
      each shapeType="cone",
      each length=headLength,
      each width=headWidth,
      each height=headWidth,
      each lengthDirection=n,
      each widthDirection={0,1,0},
      each color=color,
      each r_shape=r_tail + Frames.normalize(n)*lineLength,
      each r=frame_a.r_0,
      each R=frame_a.R);
  equation 
    frame_a.f = zeros(3);
    frame_a.t = zeros(3);
    annotation (
      preferedView="info",
      Icon(
        Rectangle(extent=[-100, 28; 20, -30], style(color=10, fillColor=10)),
        Polygon(points=[20, 60; 100, 0; 20, -60; 20, 60], style(color=10,
              fillColor=10)),
        Text(extent=[-146, 124; 142, 62], string="%name"),
        Text(
          extent=[-118, -74; 120, -112],
          string="%length",
          style(color=0))),
      Diagram,
      Documentation(info="<HTML>
<p>
Model <b>FixedArrow</b> defines an arrow that is
shown at the location of its frame_a.
<br>&nbsp;
</p>
<IMG SRC=\"../Images/MultiBody/Visualizers/Arrow.png\" ALT=\"model Visualizers.FixedArrow\">
<p>
The direction of the arrow specified with parameter vector
<b>n</b> is with respect to frame_a, i.e., the local frame to which the
arrow component is attached. The length of the arrow, its diameter
and color are defined as parameters.
If the length of the arrow shall be dynamic, use model
<b>SignalArrow</b> instead.
</HTML>"));
    
  end FixedArrow;
  
  model SignalArrow 
    "Visualizing an arrow with dynamic size in frame_a based on input signal" 
    
    import SI = Modelica.SIunits;
    extends Modelica.Mechanics.MultiBody.Interfaces.PartialVisualizer;
    parameter Boolean animation=true "= true, if animation shall be enabled";
    parameter SI.Position r_tail[3]={0,0,0} 
      "|if animation = true| Vector from frame_a to arrow tail, resolved in frame_a";
    parameter SI.Diameter diameter=world.defaultArrowDiameter 
      "|if animation = true| Diameter of arrow line";
    parameter Modelica.Mechanics.MultiBody.Types.Color color={0,0,255} 
      "|if animation = true| Color of arrow";
    Modelica.Blocks.Interfaces.RealInput r_head[3](redeclare each type 
        SignalType = SI.Position) 
      "Position vector from origin of frame_a to head of arrow, resolved in frame_a"
      annotation (extent=[-20, -140; 20, -100], rotation=90);
  protected 
    parameter Integer ndim=if world.enableAnimation and animation then 1 else 0;
    Visualizers.Advanced.Arrow arrow[ndim](
      each R=frame_a.R,
      each r=frame_a.r_0,
      each r_tail=r_tail,
      each r_head=r_head,
      each diameter=diameter,
      each color=color);
  equation 
    frame_a.f = zeros(3);
    frame_a.t = zeros(3);
    annotation (
      preferedView="info",
      Icon(
        Rectangle(extent=[-100, 28; 20, -30], style(color=10, fillColor=10)),
        Polygon(points=[20, 60; 100, 0; 20, -60; 20, 60], style(color=10,
              fillColor=10)),
        Text(extent=[-146, 124; 142, 62], string="%name"),
        Line(points=[0, -102; 0, -30])),
      Diagram,
      Documentation(info="<HTML>
<p>
Model <b>SignalArrow</b> defines an arrow that is dynamically visualized
at the location where its frame_a is attached. The
position vector from the tail to the head of the arrow,
resolved in frame_a, is defined via the signal vector of
the InPort connector <b>r_head</b> (r_head.signal[1:3]):<br>&nbsp;
</p>
<IMG SRC=\"../Images/MultiBody/Visualizers/Arrow.png\" ALT=\"model Visualizers.SignalArrow\">
<p>
The tail of the arrow is defined with parameter <b>r_tail</b> 
with respect to frame_a (vector from the origin of frame_a to the arrow tail).
</p>
</HTML>"));
    
  end SignalArrow;
  
  package Advanced 
    "Visualizers that require basic knowledge about Modelica in order to use them" 
    
    extends Modelica.Icons.Library;
    annotation (preferedView="info", Documentation(info="<HTML>
<p>
Package <b>Visualizers.Advanced</b> contains components to visualize
3-dimensional shapes with dynamical sizes. Basic knowledge of Modelica
is needed in order to utilize the components of this package.
These components have also to be used for models,
where the forces and torques in the frame connector are set via
equations (in this case, the models of the Visualizers package cannot be used,
since they all have frame connectors).
<p>
<h4>Content</h4>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td><b><a href=\"Modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced.Arrow\">Arrow</a></b></td>
      <td>Visualizing an arrow where all parts of the arrow can vary dynamically:<br>
      <IMG SRC=\"../Images/MultiBody/Visualizers/Arrow.png\" ALT=\"model Visualizers.Advanced.Arrow\">
      </td>
  </tr>  
  <tr><td><b><a href=\"Modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced.DoubleArrow\">DoubleArrow</a></b></td>
      <td>Visualizing a double arrow where all parts of the arrow can vary dynamically:<br>
      <IMG SRC=\"../Images/MultiBody/Visualizers/DoubleArrow.png\" ALT=\"model Visualizers.Advanced.DoubleArrow\">
      </td>
  </tr>  
  <tr><td><b><a href=\"Modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape\">Shape</a></b></td>
      <td>Animation shape of a part with dynamically varying sizes. 
      The following shape types are supported:<br>&nbsp;<br>
      <IMG SRC=\"../Images/MultiBody/FixedShape.png\" ALT=\"model Visualizers.Advanced.Shape\">
      </td>
  </tr>
</table>
</HTML>"));
    model Arrow 
      "Visualizing an arrow with variable size; all data have to be set as modifiers (see info layer)" 
      
      import SI = Modelica.SIunits;
      
      input Frames.Orientation R=Modelica.Mechanics.MultiBody.Frames.nullRotation() 
        "Orientation object to rotate the world frame into the arrow frame.";
      input SI.Position r[3]={0,0,0} 
        "Position vector from origin of world frame to origin of arrow frame, resolved in world frame";
      input SI.Position r_tail[3]={0,0,0} 
        "Position vector from origin of arrow frame to arrow tail, resolved in arrow frame";
      input SI.Position r_head[3]={0,0,0} 
        "Position vector from arrow tail to the head of the arrow, resolved in arrow frame";
      input SI.Diameter diameter=world.defaultArrowDiameter 
        "Diameter of arrow line";
      input Modelica.Mechanics.MultiBody.Types.Color color=Modelica.Mechanics.MultiBody.Types.Defaults.ArrowColor 
        "Color of arrow";
      input Real specularCoefficient(min=0) = 0.7 
        "Material property describing the reflecting of ambient light (= 0 means, that light is completely absorbed)";
    protected 
      outer Modelica.Mechanics.MultiBody.World world;
      SI.Length length=Frames.length(r_head) "Length of arrow";
      Visualizers.Advanced.Shape arrowLine(
        length=noEvent(max(0, length - diameter*Types.Defaults.
            ArrowHeadLengthFraction)),
        width=diameter,
        height=diameter,
        lengthDirection=r_head,
        widthDirection={0,1,0},
        shapeType="cylinder",
        color=color,
        r_shape=r_tail,
        r=r,
        R=R,
        specularCoefficient=specularCoefficient);
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
        r=arrowLine.rvisobj + arrowLine.rxvisobj*arrowLine.length,
        R=R);
      
      annotation(structurallyIncomplete,
        preferedView="info",
        Documentation(info="<HTML>
<p>
Model <b>Arrow</b> defines an arrow that is dynamically
visualized at the defined location (see variables below).
</p>
<IMG SRC=\"../Images/MultiBody/Visualizers/Arrow.png\" ALT=\"model Visualizers.Advanced.Arrow\">
<p>
The following variables are declared as <b>input</b>.
Furthermore the definition <b>import SI = Modelica.SIunits</b>
is used.
If the default equation is not appropriate, a corresponding
modifier equation has to be provided in the
model where an <b>Arrow</b> instance is used, e.g., in the form
</p>
<pre>
    Visualizers.Advanced.Arrow arrow(diameter = sin(time));
</pre>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th><b>Declaration</b></th>
    <th><b>Meaning</th></tr>
<tr>
  <td>Frames.Orientation <b>R</b> = Frames.nullRotation()</td>
  <td>Orientation object to rotate the world frame into the arrow frame.</td>
</tr>
<tr>
  <td>SI.Position[3] <b>r</b> = {0,0,0}</td>
  <td>Position vector from origin of world frame to origin of
      arrow frame,<br> resolved in world frame</td>
</tr>
<tr>
  <td>SI.Position[3] <b>r_tail</b> = {0,0,0}</td>
  <td>Position vector from origin of arrow frame to arrow tail, 
      resolved in arrow frame</td>
</tr>
<tr>
  <td>SI.Position[3] <b>r_head</b> = {0,0,0}</td>
  <td>Position vector from origin of arrow frame to the head of
      the arrow,<br> resolved in arrow frame</td>
</tr>
<tr>
  <td>SI.Diameter <b>diameter</b> = world.defaultArrowDiameter</td>
  <td>Diameter of arrow line</td>
</tr>
<tr>
  <td>Integer[3] <b>color</b> = {0,0,255} // blue </td>
  <td>Color (see below)</td>
</tr>
<tr>
  <td>Real <b>specularCoefficient</b> = 0.7</td>
  <td>Material property describing the reflecting of ambient light <br>
      (= 0 means, that light is completely absorbed)</td>
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
</HTML>"),
        Icon(
          Rectangle(extent=[-100, 28; 20, -30], style(color=10, fillColor=10)),
          Polygon(points=[20, 60; 100, 0; 20, -60; 20, 60], style(color=10,
                fillColor=10)),
          Text(extent=[-146, 124; 142, 62], string="%name")),
        Diagram);
      
    end Arrow;
    
    model DoubleArrow 
      "Visualizing a double arrow with variable size; all data have to be set as modifiers (see info layer)" 
      
      import SI = Modelica.SIunits;
      input Frames.Orientation R=Modelica.Mechanics.MultiBody.Frames.nullRotation() 
        "Orientation object to rotate the world frame into the arrow frame.";
      input SI.Position r[3]={0,0,0} 
        "Position vector from origin of world frame to origin of arrow frame, resolved in world frame";
      input SI.Position r_tail[3]={0,0,0} 
        "Position vector from origin of arrow frame to double arrow tail, resolved in arrow frame";
      input SI.Position r_head[3]={0,0,0} 
        "Position vector from double arrow tail to the head of the double arrow, resolved in arrow frame";
      input SI.Diameter diameter=world.defaultArrowDiameter 
        "Diameter of arrow line";
      input Modelica.Mechanics.MultiBody.Types.Color color=Modelica.Mechanics.MultiBody.Types.Defaults.ArrowColor 
        "Color of double arrow";
      input Real specularCoefficient(min=0) = 0.7 
        "Material property describing the reflecting of ambient light (= 0 means, that light is completely absorbed)";
    protected 
      outer Modelica.Mechanics.MultiBody.World world;
      SI.Length length=Frames.length(r_head) "Length of arrow";
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
        r_shape=r_tail,
        r=r,
        R=R,
        specularCoefficient=specularCoefficient);
      Visualizers.Advanced.Shape arrowHead1(
        length=headLength,
        width=headWidth,
        height=headWidth,
        lengthDirection=r_head,
        widthDirection={0,1,0},
        shapeType="cone",
        color=color,
        r=arrowLine.rvisobj + arrowLine.rxvisobj*arrowLine.length,
        R=R);
      Visualizers.Advanced.Shape arrowHead2(
        length=headLength,
        width=headWidth,
        height=headWidth,
        lengthDirection=r_head,
        widthDirection={0,1,0},
        shapeType="cone",
        color=color,
        r=arrowLine.rvisobj + arrowLine.rxvisobj*(arrowLine.length + 0.5*
            arrowHead1.length),
        R=R);
      annotation(structurallyIncomplete,
        preferedView="info",
        Icon(
          Rectangle(extent=[-100, 28; 0, -28], style(color=10, fillColor=10)),
          Polygon(points=[40, 60; 100, 0; 40, -60; 40, 60], style(color=10,
                fillColor=10)),
          Text(extent=[-146, 124; 142, 62], string="%name"),
          Polygon(points=[0, 60; 60, 0; 0, -60; 0, 60], style(color=10,
                fillColor=10))),
        Diagram,
        Documentation(info="<HTML>
<p>
Model <b>DoubleArrow</b> defines a double arrow that is dynamically
visualized at the defined location (see variables below).
</p>
<IMG SRC=\"../Images/MultiBody/Visualizers/DoubleArrow.png\" ALT=\"model Visualizers.Advanced.DoubleArrow\">
<p>
The following variables are declared as <b>input</b>.
Furthermore the definition <b>import SI = Modelica.SIunits</b>
is used.
If the default equation is not appropriate, a corresponding
modifier equation has to be provided in the
model where a <b>DoubleArrow</b> instance is used, e.g., in the form
</p>
<pre>
    Visualizers.Advanced.DoubleArrow doubleArrow(diameter = sin(time));
</pre>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th><b>Declaration</b></th>
    <th><b>Meaning</th></tr>
<tr>
  <td>Frames.Orientation <b>R</b> = Frames.nullRotation()</td>
  <td>Orientation object to rotate the world frame into the arrow frame.</td>
</tr>
<tr>
  <td>SI.Position[3] <b>r</b> = {0,0,0}</td>
  <td>Position vector from origin of world frame to origin of
      arrow frame,<br> resolved in world frame</td>
</tr>
<tr>
  <td>SI.Position[3] <b>r_tail</b> = {0,0,0}</td>
  <td>Position vector from origin of arrow frame to arrow tail, 
      resolved in arrow frame</td>
</tr>
<tr>
  <td>SI.Position[3] <b>r_head</b> = {0,0,0}</td>
  <td>Position vector from origin of arrow frame to the head of
      the arrow,<br> resolved in arrow frame</td>
</tr>
<tr>
  <td>SI.Diameter <b>diameter</b> = world.defaultArrowDiameter</td>
  <td>Diameter of arrow line</td>
</tr>
<tr>
  <td>Integer[3] <b>color</b> = {0,0,255} // blue </td>
  <td>Color (see below)</td>
</tr>
<tr>
  <td>Real <b>specularCoefficient</b> = 0.7</td>
  <td>Material property describing the reflecting of ambient light <br>
      (= 0 means, that light is completely absorbed)</td>
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
</HTML>"));
      
    end DoubleArrow;
    
    model Shape 
      "Different visual shapes with variable size; all data have to be set as modifiers (see info layer)" 
      
      import T = Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
      import SI = Modelica.SIunits;
      parameter String shapeType="box" 
        "Type of shape (box, sphere, cylinder, pipecylinder, cone, pipe, beam, gearwheel, spring)";
      input Frames.Orientation R=Modelica.Mechanics.MultiBody.Frames.nullRotation() 
        "Orientation object to rotate the world frame into the object frame.";
      input SI.Position r[3]={0,0,0} 
        "Position vector from origin of world frame to origin of object frame, resolved in world frame";
      input SI.Position r_shape[3]={0,0,0} 
        "Position vector from origin of object frame to shape origin, resolved in object frame";
      input Real lengthDirection[3]={1,0,0} 
        "Vector in length direction, resolved in object frame.";
      input Real widthDirection[3]={0,1,0} 
        "Vector in width direction, resolved in object frame.";
      input SI.Length length=0 "Length of visual object.";
      input SI.Length width=0 "Width of visual object.";
      input SI.Length height=0 "Height of visual object.";
      input Real extra=0.0 
        "Additional size data for some of the shape types (details see docu).";
      input Real color[3]={255,0,0} "Color (details see docu).";
      input Real specularCoefficient(min=0) = 0.7 
        "Material property describing the reflecting of ambient light (= 0 means, that light is completely absorbed)";
      // Real rxry[3, 2];
    protected 
      Real abs_n_x=Frames.length(lengthDirection) annotation (Hide=true);
      Real e_x[3]=noEvent(if abs_n_x < 1.e-10 then {1,0,0} else lengthDirection
          /abs_n_x) annotation (Hide=true);
      Real n_z_aux[3]=cross(e_x, widthDirection) annotation (Hide=true);
      Real e_y[3]=noEvent(cross(Frames.normalize(cross(e_x, if n_z_aux*n_z_aux
           > 1.0e-6 then widthDirection else (if abs(e_x[1]) > 1.0e-6 then {0,1,
          0} else {1,0,0}))), e_x)) annotation (Hide=true);
      output Real Form annotation (Hide=false);
    public 
      output Real rxvisobj[3] 
        "x-axis unit vector of shape, resolved in world frame" 
        annotation (Hide=false);
      output Real ryvisobj[3] 
        "y-axis unit vector of shape, resolved in world frame" 
        annotation (Hide=false);
      output SI.Position rvisobj[3] 
        "position vector from world frame to shape frame, resolved in world frame"
        annotation (Hide=false);
    protected 
      output SI.Length size[3] "{length,width,height} of shape" 
        annotation (Hide=false);
      output Real Material annotation (Hide=false);
      output Real Extra annotation (Hide=false);
      annotation (structurallyIncomplete,
        preferedView="info",
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon(
          Rectangle(extent=[-100, -100; 80, 60], style(color=3, fillColor=7)),
          Polygon(points=[-100, 60; -80, 100; 100, 100; 80, 60; -100, 60],
              style(color=3, fillColor=8)),
          Polygon(points=[100, 100; 100, -60; 80, -100; 80, 60; 100, 100],
              style(color=3, fillColor=9)),
          Text(
            extent=[-100, -100; 80, 60],
            style(color=0),
            string="%shapeType"),
          Text(extent=[-132, 160; 128, 100], string="%name")),
        Window(
          x=0.28,
          y=0.06,
          width=0.6,
          height=0.69),
        Documentation(info="<HTML>
<p>
Model <b>Shape</b> defines a visual shape that is
shown at the location of its reference coordinate system, called
'object frame' below. All describing variables such
as size and color can vary dynamically. The default equations in the
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
(only 3DFace is supported). External shapes must be named \"1\", \"2\"
etc.. The corresponding definitions should be in files \"1.dxf\",
\"2.dxf\" etc.Since the DXF-files contain color and dimensions for
the individual faces, the corresponding information in the model
is currently ignored. The DXF-files must be found either in the current 
directory or in the directory where the Shape instance is stored
that references the DXF file.
</p>
<p>
The following variables are declared as <b>input</b>.
If the default equation is not appropriate, a corresponding
modifier equations has to be provided in the
model where a <b>Shape</b> instance is used, e.g., in the form
</p>
<pre>
    Visualizers.Advanced.Shape shape(length = sin(time));
</pre>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th><b>Declaration</b></th>
    <th><b>Meaning</th></tr>
<tr>
  <td>Frames.Orientation <b>R</b> = Frames.nullRotation()</td>
  <td>Orientation object to rotate the world frame into the object frame.</td>
</tr>
<tr>
  <td>Real[3] <b>r</b> = {0,0,0}</td>
  <td>Position vector from origin of world frame to origin of
      object frame, resolved in world frame</td>
</tr>
<tr>
  <td>Real[3] <b>r_shape</b> = {0,0,0}</td>
  <td>Position vector from origin of object frame to shape origin, resolved in object frame</td>
</tr>
<tr>
  <td>Real[3] <b>lengthDirection</b> = {1,0,0}</td>
  <td>Vector in length direction, resolved in object frame</td>
</tr>
<tr>
  <td>Real[3] <b>widthDirection</b> = {0,1,0}</td>
  <td>Vector in width direction, resolved in object frame. When needed,<br> this
      vector is modified such that it is orthogonal to vector lengthDirection </td>
</tr>
<tr>
  <td>Real <b>length</b> = 0</td>
  <td>Length of visual object</td>
</tr>
<tr>
  <td>Real <b>width</b> = 0</td>
  <td>Width of visual object</td>
</tr>
<tr>
  <td>Real <b>height</b> = 0</td>
  <td>Height of visual object</td>
</tr>
<tr>
  <td>Real <b>extra</b> = 0</td>
  <td>Additional size data for some of the shape types (see below)</td>
</tr>
<tr>
  <td>Integer[3] <b>color</b> = {255,0,0} (red)</td>
  <td>Color (see below)</td>
</tr>
<tr>
  <td>Real <b>specularCoefficient</b> = 0.7</td>
  <td>Material property describing the reflecting of ambient light <br>
      (= 0 means, that light is completely absorbed)</td>
</tr>
</table>
<p>
Via parameter <b>extra</b> additional sizing data is defined
according to:
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
<p>
Parameter <b>color</b> is an Integer vector with 3 elements,
{r, g, b}, and specifies the color of the shape.
{r,g,b} are the \"red\", \"green\" and \"blue\" color parts.
Note, r g, b are given in the range 0 .. 255.
The predefined type <b>MultiBody.Types.Color</b> contains
a menu definition of the colors used in the MultiBody
library (will be replaced by a color editor).
</p>
</HTML>
"));
    equation 
      /* Outputs to file. */
      Form = (987000 + PackShape(shapeType))*1E20;
      /*
  rxry = Frames.TransformationMatrices.to_exy(
    Frames.TransformationMatrices.absoluteRotation(R.T, 
    Frames.TransformationMatrices.from_nxy(lengthDirection, widthDirection)));
  rxvisobj = rxry[:, 1];
  ryvisobj = rxry[:, 2];
*/
      rxvisobj = transpose(R.T)*e_x;
      ryvisobj = transpose(R.T)*e_y;
      rvisobj = r + T.resolve1(R.T, r_shape);
      size = {length,width,height};
      Material = PackMaterial(color[1]/255.0, color[2]/255.0, color[3]/255.0,
        specularCoefficient);
      Extra = extra;
    end Shape;
    
  end Advanced;
  
  encapsulated package Internal 
    "Visualizers that will be replaced by improved versions in the future (don't use them)" 
    
    import Modelica;
    extends Modelica.Icons.Library;
    
    model FixedLines 
      "Visualizing a set of lines as cylinders (e.g., used to display characters)" 
      
      import SI = Modelica.SIunits;
      import Modelica.Mechanics.MultiBody;
      extends Modelica.Mechanics.MultiBody.Interfaces.PartialVisualizer;
      
      parameter Boolean animation=true "= true, if animation shall be enabled";
      parameter Real scale(min=0) = 1 
        "|if animation = true| The 'lines' are visualized 'scale' times bigger";
      parameter SI.Position lines[:, 2, 2]={[0, 0; 1, 1],[0, 1; 1, 0]} 
        "|if animation = true| List of start and end points of cylinders resolved along n_x and n_y";
      parameter SI.Distance diameter(min=0) = 0.05 
        "|if animation = true| Diameter of the cylinders defined by lines";
      parameter SI.Position r_lines[3]={0,0,0} 
        "|if animation = true| Position vector from origin of frame_a to the origin of the 'lines' frame, resolved in frame_a";
      parameter Real n_x[3]={1,0,0} 
        "|if animation = true| Vector in direction of x-axis of 'lines' frame, resolved in frame_a.";
      
      parameter Real n_y[3]={0,1,0} 
        "|if animation = true| Vector in direction of y-axis of 'lines' frame, resolved in frame_a.";
      
      parameter Modelica.Mechanics.MultiBody.Types.Color color={0,128,255} 
        "|if animation = true| Color of cylinders";
      annotation(structurallyIncomplete,
        preferedView="info",
        Icon(
          Rectangle(extent=[-100, 100; 100, -100], style(color=10, fillColor=7)),
          Text(extent=[-140, 164; 148, 102], string="%name"),
          Polygon(points=[-82, -24; -20, 46; -10, 38; -72, -32; -82, -24],
              style(color=69, fillColor=69)),
          Polygon(points=[-24, -34; -82, 40; -72, 46; -14, -26; -24, -34],
              style(color=69, fillColor=69)),
          Polygon(points=[42, -18; 10, 40; 20, 48; 50, -6; 42, -18], style(
                color=69, fillColor=69)),
          Polygon(points=[10, -68; 84, 48; 96, 42; 24, -72; 10, -68], style(
                color=69, fillColor=69))),
        Diagram,
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
The diameter and color of all line cylinders are identical
and are defined by parameters.
</p>
</HTML>"));
      
    protected 
      parameter Integer ndim=if world.enableAnimation and animation then 1 else 
                0;
      Lines x_label[ndim](
        each lines=scale*lines,
        each diameter=scale*diameter,
        each color=color,
        each r_lines=r_lines,
        each n_x=n_x,
        each n_y=n_y,
        each r=frame_a.r_0,
        each R=frame_a.R);
    equation 
      frame_a.f = zeros(3);
      frame_a.t = zeros(3);
    end FixedLines;
    
    model Lines 
      "Visualizing a set of lines as cylinders with variable size, e.g., used to display characters (no Frame connector)" 
      
      import SI = Modelica.SIunits;
      import Modelica.Mechanics.MultiBody;
      import T = Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
      input Modelica.Mechanics.MultiBody.Frames.Orientation R=Modelica.Mechanics.MultiBody.Frames.nullRotation() 
        "Orientation object to rotate the world frame into the object frame.";
      input SI.Position r[3]={0,0,0} 
        "Position vector from origin of world frame to origin of object frame, resolved in world frame";
      input SI.Position r_lines[3]={0,0,0} 
        "Position vector from origin of object frame to the origin of 'lines' frame, resolved in object frame";
      input Real n_x[3]={1,0,0} 
        "Vector in direction of x-axis of 'lines' frame, resolved in object frame.";
      input Real n_y[3]={0,1,0} 
        "Vector in direction of y-axis of 'lines' frame, resolved in object frame.";
      input SI.Position lines[:, 2, 2]=zeros(0, 2, 2) 
        "List of start and end points of cylinders resolved in an x-y frame defined by n_x, n_y, e.g., {[0,0;1,1], [0,1;1,0], [2,0; 3,1]}";
      input SI.Length diameter(min=0) = 0.05 
        "Diameter of the cylinders defined by lines";
      input Modelica.Mechanics.MultiBody.Types.Color color={0,128,255} 
        "Color of cylinders";
      input Real specularCoefficient(min=0) = 0 
        "Material property describing the reflecting of ambient light (= 0 means, that light is completely absorbed)";
    protected 
      parameter Integer n=size(lines, 1) "Number of cylinders";
      T.Orientation R_rel=T.from_nxy(n_x, n_y);
      T.Orientation R_lines=T.absoluteRotation(R.T, R_rel);
      Real r_abs[3]=r + T.resolve1(R.T, r_lines);
      Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape cylinders[n](
        each shapeType="cylinder",
        lengthDirection={T.resolve1(R_rel, vector([lines[i, 2, :] - lines[i, 1,
             :]; 0])) for i in 1:n},
        length={MultiBody.Frames.length(lines[i, 2, :] - lines[i, 1, :]) for i in 
                1:n},
        r={r_abs + T.resolve1(R_lines, vector([lines[i, 1, :]; 0])) for i in 1:
            n},
        each width=diameter,
        each height=diameter,
        each widthDirection={0,1,0},
        each color=color,
        each R=R,
        each specularCoefficient=specularCoefficient);
      annotation(structurallyIncomplete,
        preferedView="info",
        Icon(
          Rectangle(extent=[-100, 100; 100, -100], style(color=10, fillColor=7)),
          Polygon(points=[-24, -34; -82, 40; -72, 46; -14, -26; -24, -34],
              style(color=69, fillColor=69)),
          Polygon(points=[-82, -24; -20, 46; -10, 38; -72, -32; -82, -24],
              style(color=69, fillColor=69)),
          Polygon(points=[42, -18; 10, 40; 20, 48; 50, -6; 42, -18], style(
                color=69, fillColor=69)),
          Polygon(points=[10, -68; 84, 48; 96, 42; 24, -72; 10, -68], style(
                color=69, fillColor=69)),
          Text(extent=[-140, 164; 148, 102], string="%name")),
        Diagram,
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
<p>
The following variables are declared as <b>input Real</b>.
If the default equation is not appropriate, a corresponding
modifier equation has to be provided in the
model where a <b>Lines</b> instance is used, e.g., in the form
</p>
<pre>
    Visualizers.Lines lines(n_x = {0,1,0});
</pre>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th><b>Declaration</b></th>
    <th><b>Meaning</th></tr>
<tr>
  <td>Real[3,3] <b>T</b> = identity(3)</td>
  <td>Transformation matrix from object to world frame (r_world = T*r_object)</td>
</tr>
<tr>
  <td>Real[3] <b>r</b> = {0,0,0}</td>
  <td>Position vector from origin of world frame to origin of
      object frame, resolved in world frame</td>
</tr>
<tr>
  <td>Real[3] <b>r_lines</b> = {0,0,0}</td>
  <td>Position vector from origin of object frame to the origin of 'lines' frame, resolved in object frame</td>
</tr>
<tr>
  <td>Real[3] <b>n_x</b> = {1,0,0}</td>
  <td>Vector in direction of x-axis of 'lines' frame, resolved in object frame</td>
</tr>
<tr>
  <td>Real[3] <b>n_y</b> = {0,1,0}</td>
  <td>Vector in direction of y-axis of 'lines' frame, resolved in object frame</td>
</tr>
<tr>
  <td>Real[:, 2, 2] <b>lines</b> </td>
  <td>List of start and end points of cylinders resolved in an x-y frame,<br>
  defined by n_x, n_y, e.g., {[0,0;1,1], [0,1;1,0], [2,0; 3,1]}</td>
</tr>
<tr>
  <td>Real <b>diameter</b> = 0.05</td>
  <td>Diameter of the cylinders defined by 'lines'</td>
</tr>
<tr>
  <td>Integer[3] <b>color</b> = {255,0,0} (red)</td>
  <td>Color (see below)</td>
</tr>
<tr>
  <td>Real <b>specularCoefficient</b> = 0</td>
  <td>Material property describing the reflecting of ambient light <br>
      (= 0 means, that light is completely absorbed)</td>
</tr>
</table>
<p>
Variable <b>color</b> is an Integer vector with 3 elements,
{r, g, b}, and specifies the color of the shape.
{r,g,b} are the \"red\", \"green\" and \"blue\" color parts.
Note, r g, b are given in the range 0 .. 255.
The predefined type <b>MultiBody.Types.Color</b> defines this
Integer vector together with a menue for the colors used in the
MultiBody library (the menu will be replaced by a color editor).
</p>
</HTML>
"));
      
    end Lines;
    
  end Internal;
end Visualizers;
