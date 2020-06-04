within Modelica.Mechanics.MultiBody.Forces;
model Spring "Linear translational spring with optional mass"
  import Modelica.Mechanics.MultiBody.Types;
  extends Interfaces.PartialTwoFrames;
  parameter Boolean animation=true "= true, if animation shall be enabled";
  parameter Boolean showMass=true
    "= true, if point mass shall be visualized as sphere if animation=true and m>0";

  parameter SI.TranslationalSpringConstant c(final min=0) "Spring constant";
  parameter SI.Length s_unstretched=0 "Unstretched spring length";
  parameter SI.Mass m(min=0)=0
    "Spring mass located on the connection line between the origin of frame_a and the origin of frame_b";
  parameter Real lengthFraction(
    min=0,
    max=1) = 0.5
    "Location of spring mass with respect to frame_a as a fraction of the distance from frame_a to frame_b (=0: at frame_a; =1: at frame_b)";
  input SI.Distance width=world.defaultForceWidth "Width of spring"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
  input SI.Distance coilWidth=width/10 "Width of spring coil"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
  parameter Integer numberOfWindings=5 "Number of spring windings"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
  input Types.Color color=Modelica.Mechanics.MultiBody.Types.Defaults.SpringColor
    "Color of spring"
    annotation (Dialog(colorSelector=true, tab="Animation", group="if animation = true", enable=animation));
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
  input SI.Diameter massDiameter=max(0, (width - 2*coilWidth)*0.9)
    "Diameter of mass point sphere" annotation (Dialog(tab="Animation", group=
          "if animation = true and showMass = true", enable=animation and showMass));
  input Types.Color massColor=Modelica.Mechanics.MultiBody.Types.Defaults.BodyColor
    "Color of mass point" annotation (Dialog(colorSelector=true, tab="Animation", group=
          "if animation = true and showMass = true", enable=animation and showMass));
  parameter SI.Distance s_small=1e-10
    "Prevent zero-division if distance between frame_a and frame_b is zero"
    annotation (Dialog(tab="Advanced"));
  parameter Boolean fixedRotationAtFrame_a=false
    "= true, if rotation frame_a.R is fixed (to directly connect line forces)"
     annotation (Evaluate=true, choices(checkBox=true),Dialog(tab="Advanced", group="If enabled, can give wrong results, see MultiBody.UsersGuide.Tutorial.ConnectionOfLineForces"));
  parameter Boolean fixedRotationAtFrame_b=false
    "= true, if rotation frame_b.R is fixed (to directly connect line forces)"
     annotation (Evaluate=true, choices(checkBox=true),Dialog(tab="Advanced", group="If enabled, can give wrong results, see MultiBody.UsersGuide.Tutorial.ConnectionOfLineForces"));

  SI.Position r_rel_a[3]
    "Position vector from origin of frame_a to origin of frame_b, resolved in frame_a";
  Real e_a[3](each final unit="1")
    "Unit vector on the line connecting the origin of frame_a with the origin of frame_b resolved in frame_a (directed from frame_a to frame_b)";
  SI.Force f
    "Line force acting on frame_a and on frame_b (positive, if acting on frame_b and directed from frame_a to frame_b)";
  SI.Distance length
    "Distance between the origin of frame_a and the origin of frame_b";
  SI.Position s
    "(Guarded) distance between the origin of frame_a and the origin of frame_b (>= s_small))";
  SI.Position r_rel_0[3]
    "Position vector from frame_a to frame_b resolved in world frame";
  Real e_rel_0[3](each final unit="1")
    "Unit vector in direction from frame_a to frame_b, resolved in world frame";

  Forces.LineForceWithMass lineForce(
    animateLine=animation,
    animateMass=showMass,
    m=m,
    lengthFraction=lengthFraction,
    lineShapeType="spring",
    lineShapeHeight=coilWidth*2,
    lineShapeWidth=width,
    lineShapeExtra=numberOfWindings,
    lineShapeColor=color,
    specularCoefficient=specularCoefficient,
    massDiameter=massDiameter,
    massColor=massColor,
    s_small=s_small,
    fixedRotationAtFrame_a=fixedRotationAtFrame_a,
    fixedRotationAtFrame_b=fixedRotationAtFrame_b) annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
  Modelica.Mechanics.Translational.Components.Spring spring(
     s_rel0=s_unstretched,
     c=c) annotation (Placement(transformation(extent={{-8,40},{12,60}})));

equation
  // Results
  r_rel_a = Frames.resolve2(frame_a.R, r_rel_0);
  e_a = r_rel_a/s;
  f = spring.f;
  length = lineForce.length;
  s = lineForce.s;
  r_rel_0 = lineForce.r_rel_0;
  e_rel_0 = lineForce.e_rel_0;

  connect(lineForce.frame_a, frame_a)
    annotation (Line(
      points={{-20,0},{-100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(lineForce.frame_b, frame_b)
    annotation (Line(
      points={{20,0},{100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(spring.flange_b, lineForce.flange_b)
    annotation (Line(points={{12,50},{12,20}}, color={0,191,0}));
  connect(spring.flange_a, lineForce.flange_a)
    annotation (Line(points={{-8,50},{-12,50},{-12,20}}, color={0,191,0}));

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
                    graphics={
        Line(
          points={{-100,0},{-58,0},{-43,-30},{-13,30},{17,-30},{47,30},{62,0},
              {100,0}}),
        Text(
          extent={{-150,56},{150,96}},
          textString="%name",
          textColor={0,0,255}),
        Text(
          extent={{-150,-80},{150,-50}},
          textString="c=%c"),
        Ellipse(
          extent={{-8,8},{8,-8}},
          fillPattern=FillPattern.Solid),
        Ellipse(visible=fixedRotationAtFrame_a, extent={{-70,30},{-130,-30}}, lineColor={255,0,0}),
        Text(visible=fixedRotationAtFrame_a,
          extent={{-62,50},{-140,30}},
          textColor={255,0,0},
          textString="R=0"),
        Ellipse(visible=fixedRotationAtFrame_b, extent={{70,30},{130,-30}}, lineColor={255,0,0}),
        Text(visible=fixedRotationAtFrame_b,
          extent={{62,50},{140,30}},
          textColor={255,0,0},
          textString="R=0")}),
    Documentation(info="<html>
<p>
<strong>Linear spring</strong> acting as line force between frame_a and frame_b.
A <strong>force f</strong> is exerted on the origin of frame_b and with opposite sign
on the origin of frame_a along the line from the origin of frame_a to the origin
of frame_b according to the equation:
</p>
<blockquote><pre>
f = c*(s - s_unstretched);
</pre></blockquote>
<p>
where \"c\" and \"s_unstretched\" are parameters and \"s\" is the
distance between the origin of frame_a and the origin of frame_b.
</p>
<p>
Optionally, the mass of the spring is taken into account by a
point mass located on the line between frame_a and frame_b
(default: middle of the line). If the spring mass is zero, the
additional equations to handle the mass are removed.
</p>
<p>
In the following figure a typical animation of the
spring is shown. The blue sphere in the middle of the
spring characterizes the location of the point mass.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/SpringWithMass.png\"
alt=\"model Examples.Elementary.SpringWithMass\">
</div>

</html>"));
end Spring;
