within Modelica.Mechanics.MultiBody.Visualizers;
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
