within Modelica.Mechanics.MultiBody.Parts;
model Fixed "Frame fixed in the world frame at a given position"
  import Modelica.Mechanics.MultiBody.Types;
  import Modelica.Units.Conversions.to_unit1;

  Interfaces.Frame_b frame_b "Coordinate system fixed in the world frame"
    annotation (Placement(transformation(extent={{84,-16},{116,16}})));

  parameter Boolean animation=true "= true, if animation shall be enabled";
  parameter SI.Position r[3]={0,0,0}
    "Position vector from world frame to frame_b, resolved in world frame";
  parameter Types.ShapeType shapeType="cylinder" "Type of shape" annotation (
     Dialog(
      tab="Animation",
      group="if animation = true",
      enable=animation));
  parameter SI.Position r_shape[3]={0,0,0}
    "Vector from world frame to shape origin, resolved in world frame"
    annotation (Dialog(
      tab="Animation",
      group="if animation = true",
      enable=animation));
  parameter Types.Axis lengthDirection = to_unit1(r - r_shape)
    "Vector in length direction of shape, resolved in world frame"
    annotation (Dialog(
      tab="Animation",
      group="if animation = true",
      enable=animation));
  parameter Types.Axis widthDirection={0,1,0}
    "Vector in width direction of shape, resolved in world frame"
    annotation (Dialog(
      tab="Animation",
      group="if animation = true",
      enable=animation));
  parameter SI.Length length=Modelica.Math.Vectors.length(r - r_shape)
    "Length of shape" annotation (Dialog(
      tab="Animation",
      group="if animation = true",
      enable=animation));
  parameter SI.Distance width=length/world.defaultWidthFraction
    "Width of shape" annotation (Dialog(
      tab="Animation",
      group="if animation = true",
      enable=animation));
  parameter SI.Distance height=width "Height of shape" annotation (Dialog(
      tab="Animation",
      group="if animation = true",
      enable=animation));
  parameter Types.ShapeExtra extra=0.0
    "Additional parameter for cone, pipe etc. (see docu of Visualizers.Advanced.Shape)"
    annotation (Dialog(
      tab="Animation",
      group="if animation = true",
      enable=animation));
  input Types.Color color=Modelica.Mechanics.MultiBody.Types.Defaults.RodColor
    "Color of shape" annotation (Dialog(
      colorSelector=true,
      tab="Animation",
      group="if animation = true",
      enable=animation));
  input Types.SpecularCoefficient specularCoefficient=world.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (Dialog(
      tab="Animation",
      group="if animation = true",
      enable=animation));

protected
  outer Modelica.Mechanics.MultiBody.World world;
  Visualizers.Advanced.Shape shape(
    shapeType=shapeType,
    color=color,
    specularCoefficient=specularCoefficient,
    length=length,
    width=width,
    height=height,
    lengthDirection=lengthDirection,
    widthDirection=widthDirection,
    extra=extra,
    r_shape=r_shape,
    r=zeros(3),
    R=Frames.nullRotation()) if world.enableAnimation and animation;
equation
  Connections.root(frame_b.R);
  frame_b.r_0 = r;
  frame_b.R = Frames.nullRotation();
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-90,90},{90,-90}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{150,145},{-150,105}},
          textString="%name",
          textColor={0,0,255}),
        Line(points={{0,100},{0,-100}}),
        Line(points={{0,-80},{-100,-20}}),
        Line(points={{0,-40},{-100,20}}),
        Line(points={{0,0},{-100,60}}),
        Line(points={{0,40},{-100,100}}),
        Line(points={{0,0},{100,0}}),
        Text(
          extent={{-150,-105},{150,-135}},
          textString="r=%r")}),
    Documentation(info="<html>
<p>
Element consisting of a frame (frame_b) that is fixed in the world
frame at a given position defined by parameter vector <strong>r</strong>
(vector from origin of world frame to frame_b, resolved in the
world frame).
</p>
<p>
By default, this component is visualized by a cylinder connecting the
world frame and frame_b of this components, as shown in the figure below.
Note, that the visualized world frame on the left side and
Fixed.frame_b on the right side are not part of the
component animation and that the animation may be switched off via parameter
animation = <strong>false</strong>.
</p>
<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Parts/Fixed.png\" alt=\"Parts.Fixed\">
</div>

</html>"));
end Fixed;
