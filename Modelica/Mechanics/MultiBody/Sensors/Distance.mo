within Modelica.Mechanics.MultiBody.Sensors;
model Distance
  "Measure the distance between the origins of two frame connectors"

  import Modelica.Mechanics.MultiBody.Frames;
  import Modelica.Mechanics.MultiBody.Types;

  extends Interfaces.PartialTwoFrames;
  extends Modelica.Icons.RectangularSensor;
  Modelica.Blocks.Interfaces.RealOutput distance
    "Distance between the origin of frame_a and the origin of frame_b"
    annotation (Placement(transformation(
        origin={0,-110},
        extent={{10,-10},{-10,10}},
        rotation=90)));

  parameter Boolean animation=true
    "= true, if animation shall be enabled (show arrow)";
  input Types.Color arrowColor=Modelica.Mechanics.MultiBody.Types.Defaults.SensorColor
    "Color of relative arrow from frame_a to frame_b"
    annotation (Dialog(colorSelector=true, group="if animation = true", enable=animation));
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (Dialog(group="if animation = true", enable=animation));
  input SI.Position s_small(min=sqrt(Modelica.Constants.small))=1e-10
    "Prevent zero-division if distance between frame_a and frame_b is zero"
    annotation (Dialog(tab="Advanced"));
protected
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Arrow arrow(
    r=frame_a.r_0,
    r_head=frame_b.r_0 - frame_a.r_0,
    color=arrowColor,
    specularCoefficient=specularCoefficient) if world.enableAnimation and animation;

protected
  SI.Position r_rel_0[3] = frame_b.r_0 - frame_a.r_0
    "Position vector from frame_a to frame_b resolved in world frame";
  SI.Area L2 = r_rel_0*r_rel_0;
  SI.Area s_small2 = s_small^2;
equation
  frame_a.f = zeros(3);
  frame_b.f = zeros(3);
  frame_a.t = zeros(3);
  frame_b.t = zeros(3);

  distance =  smooth(1,if noEvent(L2 > s_small2) then sqrt(L2) else L2/(2*s_small)*(3-L2/s_small2));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
        Line(points={{0,-60},{0,-100}}, color={0,0,127}),
        Line(points={{-70,0},{-101,0}}),
        Line(points={{70,0},{100,0}}),
        Text(
          extent={{-128,30},{133,78}},
          textString="%name",
          textColor={0,0,255}),
        Text(
          extent={{-30,10},{70,-30}},
          textColor={64,64,64},
          textString="m")}),
    Documentation(info="<html>
<p>
The <strong>distance</strong> between the origins of frame_a
and of frame_b are determined and provided at the
output signal connector <strong>distance</strong>. This
distance is always positive. <strong>Derivatives</strong> of this
signal can be easily obtained by connecting the
block
<a href=\"modelica://Modelica.Blocks.Continuous.Der\">Modelica.Blocks.Continuous.Der</a>
to \"distance\" (this block performs analytic differentiation
of the input signal using the der(&hellip;) operator).
</p>
<p>
In the following figure the animation of a Distance
sensor is shown. The light blue coordinate system is
frame_a, the dark blue coordinate system is frame_b, and
the yellow arrow is the animated sensor.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Sensors/Distance.png\">
</div>

<p>
If the distance is smaller as parameter <strong>s_small</strong> (in the \"advanced\" menu),
it is approximated such that its derivative is
finite for zero distance. Without such an approximation, the derivative would
be infinite and a division by zero would occur. The approximation is performed
in the following way: If distance > s_small, it is computed as sqrt(r*r) where
r is the position vector from the origin of frame_a to the origin of frame_b.
If the distance becomes smaller as s_small, the \"sqrt()\" function is approximated
by a second order polynomial, such that the function value and its first derivative
are identical for sqrt() and the polynomial at s_small. Furthermore, the polynomial
passes through zero. The effect is, that the distance function is continuous and
differentiable everywhere. The derivative at zero distance is 3/(2*s_small).
</p>
</html>"));
end Distance;
