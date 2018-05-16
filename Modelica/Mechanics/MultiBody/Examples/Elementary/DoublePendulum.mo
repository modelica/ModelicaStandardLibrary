within Modelica.Mechanics.MultiBody.Examples.Elementary;
model DoublePendulum
  "Simple double pendulum with two revolute joints and two bodies"

  extends Modelica.Icons.Example;
  inner Modelica.Mechanics.MultiBody.World world annotation (Placement(
        transformation(extent={{-100,-10},{-80,10}})));
  Modelica.Mechanics.MultiBody.Joints.Revolute revolute1(useAxisFlange=true,phi(fixed=true),
      w(fixed=true)) annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Mechanics.Rotational.Components.Damper damper(
                                              d=0.1)
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
  Modelica.Mechanics.MultiBody.Parts.BodyBox boxBody1(r={0.5,0,0}, width=0.06)
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  Modelica.Mechanics.MultiBody.Joints.Revolute revolute2(phi(fixed=true), w(
        fixed=true)) annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Mechanics.MultiBody.Parts.BodyBox boxBody2(r={0.5,0,0}, width=0.06)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
equation

  connect(damper.flange_b, revolute1.axis) annotation (Line(points={{-40,40},{-40,20},{-50,20},{-50,10}}));
  connect(revolute1.support, damper.flange_a) annotation (Line(points={{-56,10},{-56,20},{-60,20},{-60,40}}));
  connect(revolute1.frame_b, boxBody1.frame_a)
    annotation (Line(
      points={{-40,0},{-20,0}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute2.frame_b, boxBody2.frame_a)
    annotation (Line(
      points={{40,0},{60,0}},
      color={95,95,95},
      thickness=0.5));
  connect(boxBody1.frame_b, revolute2.frame_a)
    annotation (Line(
      points={{0,0},{20,0}},
      color={95,95,95},
      thickness=0.5));
  connect(world.frame_b, revolute1.frame_a)
    annotation (Line(
      points={{-80,0},{-60,0}},
      color={95,95,95},
      thickness=0.5));
  annotation (
    experiment(StopTime=3),
    Documentation(info="<html>
<p>
This example demonstrates that by using joint and body
elements animation is automatically available. Also the revolute
joints are animated. Note, that animation of every component
can be switched of by setting the first parameter <strong>animation</strong>
to <strong>false</strong> or by setting <strong>enableAnimation</strong> in the <strong>world</strong>
object to <strong>false</strong> to switch off animation of all components.
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/DoublePendulum.png\"
alt=\"model Examples.Elementary.DoublePendulum\">
</blockquote>
</html>"));
end DoublePendulum;
