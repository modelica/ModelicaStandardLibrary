within Modelica.Mechanics.MultiBody.Forces;
model Damper "Linear (velocity dependent) damper"
  import Modelica.Mechanics.MultiBody.Types;
  parameter Boolean animation=true "= true, if animation shall be enabled";
  parameter SI.TranslationalDampingConstant d(final min=0, start = 0)
    "Damping constant";
  parameter SI.Distance length_a=world.defaultForceLength
    "Length of cylinder at frame_a side"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
  input SI.Diameter diameter_a=world.defaultForceWidth
    "Diameter of cylinder at frame_a side"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
  input SI.Diameter diameter_b=0.6*diameter_a
    "Diameter of cylinder at frame_b side"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
  input Types.Color color_a={100,100,100} "Color at frame_a"
    annotation (Dialog(colorSelector=true, tab="Animation", group="if animation = true", enable=animation));
  input Types.Color color_b={155,155,155} "Color at frame_b"
    annotation (Dialog(colorSelector=true, tab="Animation", group="if animation = true", enable=animation));
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
  extends Interfaces.PartialLineForce;
  extends Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPort(
     final T=293.15);
protected
  SI.Position r0_b[3]=e_a*noEvent(min(length_a, s));
  Visualizers.Advanced.Shape shape_a(
    shapeType="cylinder",
    color=color_a,
    specularCoefficient=specularCoefficient,
    length=noEvent(min(length_a, s)),
    width=diameter_a,
    height=diameter_a,
    lengthDirection=e_a,
    widthDirection={0,1,0},
    r=frame_a.r_0,
    R=frame_a.R) if world.enableAnimation and animation;
  Visualizers.Advanced.Shape shape_b(
    shapeType="cylinder",
    color=color_b,
    specularCoefficient=specularCoefficient,
    length=noEvent(max(s - length_a, 0)),
    width=diameter_b,
    height=diameter_b,
    lengthDirection=e_a,
    widthDirection={0,1,0},
    r_shape=r0_b,
    r=frame_a.r_0,
    R=frame_a.R) if world.enableAnimation and animation;
equation
  f = d*der(s);
  lossPower = f*der(s);
  annotation (
    Documentation(info="<html>
<p>
<strong>Linear damper</strong> acting as line force between frame_a and frame_b.
A <strong>force f</strong> is exerted on the origin of frame_b and with opposite sign
on the origin of frame_a along the line from the origin of frame_a to the origin
of frame_b according to the equation:
</p>
<blockquote><pre>
f = d*<strong>der</strong>(s);
</pre></blockquote>
<p>
where \"d\" is a parameter, \"s\" is the
distance between the origin of frame_a and the origin of frame_b
and der(s) is the time derivative of \"s\".
</p>
<p>
In the following figure a typical animation is shown
where a mass is hanging on a damper.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Forces/Damper.png\">
</div>

</html>"),
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-101,0},{-60,0}}),
        Line(points={{-60,-30},{-60,30}}),
        Line(points={{-60,-30},{60,-30}}),
        Line(points={{-60,30},{60,30}}),
        Rectangle(
          extent={{-60,30},{30,-30}},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{30,0},{100,0}}),
        Text(
          extent={{-150,50},{150,90}},
          textString="%name",
          textColor={0,0,255}),
        Text(
          extent={{-150,-75},{150,-45}},
          textString="d=%d"),
        Line(visible=useHeatPort,
          points={{-100,-99},{-100,-25},{-10,-25}},
          color={191,0,0},
          pattern=LinePattern.Dot)}));
end Damper;
