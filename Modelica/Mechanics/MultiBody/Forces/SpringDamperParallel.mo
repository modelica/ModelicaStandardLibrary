within Modelica.Mechanics.MultiBody.Forces;
model SpringDamperParallel "Linear spring and linear damper in parallel"
  import Modelica.Mechanics.MultiBody.Types;
  parameter Boolean animation=true "= true, if animation shall be enabled";
  parameter SI.TranslationalSpringConstant c(final min=0) "Spring constant";
  parameter SI.Length s_unstretched=0 "Unstretched spring length";
  parameter SI.TranslationalDampingConstant d(final min=0) = 0
    "Damping constant";
  parameter SI.Distance length_a=world.defaultForceLength
    "Length of damper cylinder at frame_a side"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
  input SI.Diameter diameter_a=world.defaultForceWidth
    "Diameter of damper cylinder at frame_a side"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
  input SI.Diameter diameter_b=0.6*diameter_a
    "Diameter of damper cylinder at frame_b side"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
  input Types.Color color_a={100,100,100} "Color of damper cylinder at frame_a"
    annotation (Dialog(colorSelector=true, tab="Animation", group="if animation = true", enable=animation));
  input Types.Color color_b={155,155,155} "Color of damper cylinder at frame_b"
    annotation (Dialog(colorSelector=true, tab="Animation", group="if animation = true", enable=animation));
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
  input SI.Distance width=world.defaultForceWidth "Width of spring"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
  input SI.Distance coilWidth=width/10 "Width of spring coil"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
  parameter Integer numberOfWindings=5 "Number of spring windings"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
  input Types.Color color=Modelica.Mechanics.MultiBody.Types.Defaults.SpringColor
    "Color of spring"
    annotation (Dialog(colorSelector=true, tab="Animation", group="if animation = true", enable=animation));
  extends Interfaces.PartialLineForce;
  extends Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPort(
     final T=293.15);

protected
  SI.Force f_d "Damping force";
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
    r_shape=e_a*noEvent(min(length_a, s)),
    r=frame_a.r_0,
    R=frame_a.R) if world.enableAnimation and animation;
  Visualizers.Advanced.Shape shape(
    shapeType="spring",
    color=color,
    specularCoefficient=specularCoefficient,
    length=s,
    width=width,
    height=coilWidth*2,
    lengthDirection=e_a,
    widthDirection={0,1,0},
    extra=numberOfWindings,
    r=frame_a.r_0,
    R=frame_a.R) if world.enableAnimation and animation;
equation
  f_d = d*der(s);
  f = c*(s - s_unstretched) + f_d;
  lossPower = f_d*der(s);
  annotation (
    Documentation(info="<html>
<p>
<strong>Linear spring</strong> and <strong>linear damper</strong>
in parallel acting as line force between frame_a and frame_b.
A <strong>force f</strong> is exerted on the origin of frame_b and with opposite sign
on the origin of frame_a along the line from the origin of frame_a to the origin
of frame_b according to the equation:
</p>
<blockquote><pre>
f = c*(s - s_unstretched) + d*<strong>der</strong>(s);
</pre></blockquote>
<p>
where \"c\", \"s_unstretched\" and \"d\" are parameters, \"s\" is the
distance between the origin of frame_a and the origin of frame_b
and der(s) is the time derivative of s.
</p>
</html>"),
         Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-150,120},{150,80}},
          textString="%name",
          textColor={0,0,255}),
        Line(points={{-80,40},{-60,40},{-45,10},{-15,70},{15,10},{45,70},{60,
              40},{80,40}}),
        Line(points={{-80,40},{-80,-40}}),
        Line(points={{-80,-40},{80,-40}}),
        Rectangle(
          extent={{-50,-14},{40,-66}},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-50,-14},{68,-14}}),
        Line(points={{-50,-66},{70,-66}}),
        Line(points={{80,40},{80,-40}}),
        Line(points={{-100,0},{-80,0}}),
        Line(points={{80,0},{100,0}}),
        Text(
          extent={{-150,-105},{150,-135}},
          textString="d=%d"),
        Line(
          visible=useHeatPort,
          points={{-100,-110},{-100,-60},{0,-60}},
          color={191,0,0},
          pattern=LinePattern.Dot),
        Text(
          extent={{-150,-70},{150,-100}},
          textString="c=%c")}));
end SpringDamperParallel;
