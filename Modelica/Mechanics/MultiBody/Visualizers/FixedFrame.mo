within Modelica.Mechanics.MultiBody.Visualizers;
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
    lines=scaledLabel*{[0,0; 1,1],[0,1; 1,0]},
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
    lines=scaledLabel*{[0,0; 1,1.5],[0,1.5; 0.5,0.75]},
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
    lines=scaledLabel*{[0,0; 1,0],[0,1; 1,1],[0,1; 1,0]},
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

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/FixedFrame.png\" alt=\"model Visualizers.FixedFrame\">
</div>

<p>
The sizes of the axes, the axes colors and the specular coefficient
(= reflection factor for
ambient light) can vary dynamically by
providing appropriate expressions in the input fields of the
parameter menu.
</p>
</html>"));
end FixedFrame;
