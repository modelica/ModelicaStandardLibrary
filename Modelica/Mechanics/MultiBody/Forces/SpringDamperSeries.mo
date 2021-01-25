within Modelica.Mechanics.MultiBody.Forces;
model SpringDamperSeries
  "Linear spring and linear damper in series connection"
  import Modelica.Mechanics.MultiBody.Types;
  parameter Boolean animation=true "= true, if animation shall be enabled";
  parameter SI.TranslationalSpringConstant c(final min=0) "Spring constant";
  parameter SI.Length s_unstretched=0 "Unstretched spring length";
  parameter SI.TranslationalDampingConstant d(final min=0) = 0
    "Damping constant";
  parameter SI.Length s_damper_start=0 "Initial length of damper";
  SI.Position s_damper(start=s_damper_start, fixed=true)
    "Actual length of damper (frame_a - damper - spring - frame_b)";
  parameter SI.Distance length_a=world.defaultForceLength
    "Length of damper cylinder at frame_a side"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
  input SI.Diameter diameter_a=world.defaultForceWidth
    "Diameter of damper cylinder at frame_a side"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
  input SI.Diameter diameter_b=0.6*diameter_a
    "Diameter of damper cylinder at damper-spring side"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
  input Types.Color color_a={100,100,100} "Color of damper cylinder at frame_a"
    annotation (Dialog(colorSelector=true, tab="Animation", group="if animation = true", enable=animation));
  input Types.Color color_b={155,155,155} "Color of damper cylinder at damper-spring frame"
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
  Visualizers.Advanced.Shape shape_a(
    shapeType="cylinder",
    color=color_a,
    specularCoefficient=specularCoefficient,
    length=noEvent(min(length_a, s_damper)),
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
    length=noEvent(max(s_damper - length_a, 0)),
    width=diameter_b,
    height=diameter_b,
    lengthDirection=e_a,
    widthDirection={0,1,0},
    r_shape=e_a*noEvent(min(length_a, s_damper)),
    r=frame_a.r_0,
    R=frame_a.R) if world.enableAnimation and animation;
  Visualizers.Advanced.Shape shape(
    shapeType="spring",
    color=color,
    specularCoefficient=specularCoefficient,
    length=s - s_damper,
    width=width,
    height=coilWidth*2,
    lengthDirection=e_a,
    widthDirection={0,1,0},
    extra=numberOfWindings,
    r_shape=e_a*s_damper,
    r=frame_a.r_0,
    R=frame_a.R) if world.enableAnimation and animation;
equation
  f = c*(s - s_unstretched - s_damper);
  d*der(s_damper) = f;
  lossPower = f*der(s_damper);
  annotation (
    Documentation(info="<html>
<p>
<strong>Linear spring</strong> and <strong>linear damper</strong> in series connection
acting as line force between frame_a and frame_b:
</p>
<blockquote><pre>
frame_a --> damper ----> spring --> frame_b
        |              |
        |-- s_damper --|  (s_damper is the state variable of this system)
</pre></blockquote>
<p>
A <strong>force f</strong> is exerted on the origin of frame_b and with opposite sign
on the origin of frame_a along the line from the origin of frame_a to the origin
of frame_b according to the equations:
</p>
<blockquote><pre>
f = c*(s - s_unstretched - s_damper);
f = d*der(s_damper);
</pre></blockquote>
<p>
where \"c\", \"s_unstretched\" and \"d\" are parameters, \"s\" is the
distance between the origin of frame_a and the origin of frame_b.
\"s_damper\" is the length of the damper (= an internal state of this
force element) and der(s_damper) is the time derivative of s_damper.
</p>
</html>"),
         Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-100,0},{-15,0}}),
        Rectangle(
          extent={{-60,30},{-30,-30}},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-60,-30},{-15,-30}}),
        Line(points={{-60,30},{-15,30}}),
        Line(points={{-15,0},{-5,0},{5,-30},{25,30},{45,-30},{65,30},{75,0},{
              100,0}}),
        Text(
          extent={{-150,90},{150,50}},
          textString="%name",
          textColor={0,0,255}),
        Text(
          extent={{-150,-35},{150,-65}},
          textString="c=%c"),
        Line(visible=useHeatPort,
          points={{-100,-99},{-100,-24},{-45,-24}},
          color={191,0,0},
          pattern=LinePattern.Dot),
        Text(
          extent={{-150,-70},{150,-100}},
          textString="d=%d")}));
end SpringDamperSeries;
