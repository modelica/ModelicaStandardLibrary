within Modelica.Mechanics.MultiBody.Examples.Elementary;
model DoublePendulum
  "Simple double pendulum with two revolute joints and two bodies"

  extends Modelica.Icons.Example;
  inner Modelica.Mechanics.MultiBody.World world annotation (Placement(
        transformation(extent={{-88,0},{-68,20}}, rotation=0)));
  Modelica.Mechanics.MultiBody.Joints.Revolute revolute1(useAxisFlange=true,phi(fixed=true),
      w(fixed=true))                                             annotation (Placement(transformation(extent={{-48,0},
            {-28,20}}, rotation=0)));
  Modelica.Mechanics.Rotational.Components.Damper damper(
                                              d=0.1)
    annotation (Placement(transformation(extent={{-48,40},{-28,60}}, rotation=0)));
  Modelica.Mechanics.MultiBody.Parts.BodyBox boxBody1(r={0.5,0,0}, width=0.06)
    annotation (Placement(transformation(extent={{-10,0},{10,20}}, rotation=0)));
  Modelica.Mechanics.MultiBody.Joints.Revolute revolute2(phi(fixed=true), w(
        fixed=true))                                     annotation (Placement(transformation(extent={{32,0},{
            52,20}}, rotation=0)));
  Modelica.Mechanics.MultiBody.Parts.BodyBox boxBody2(r={0.5,0,0}, width=0.06)
    annotation (Placement(transformation(extent={{74,0},{94,20}}, rotation=0)));
equation

  connect(damper.flange_b, revolute1.axis) annotation (Line(points={{-28,50},{
          -24,50},{-24,28},{-38,28},{-38,20}}, color={0,0,0}));
  connect(revolute1.support, damper.flange_a) annotation (Line(points={{-44,20},
          {-44,28},{-58,28},{-58,50},{-48,50}}, color={0,0,0}));
  connect(revolute1.frame_b, boxBody1.frame_a)
    annotation (Line(
      points={{-28,10},{-10,10}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute2.frame_b, boxBody2.frame_a)
    annotation (Line(
      points={{52,10},{74,10}},
      color={95,95,95},
      thickness=0.5));
  connect(boxBody1.frame_b, revolute2.frame_a)
    annotation (Line(
      points={{10,10},{32,10}},
      color={95,95,95},
      thickness=0.5));
  connect(world.frame_b, revolute1.frame_a)
    annotation (Line(
      points={{-68,10},{-48,10}},
      color={95,95,95},
      thickness=0.5));
  annotation (
    experiment(StopTime=3),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics),
    Documentation(info="<html>
<p>
This example demonstrates that by using joint and body
elements animation is automatically available. Also the revolute
joints are animated. Note, that animation of every component
can be switched of by setting the first parameter <b>animation</b>
to <b>false</b> or by setting <b>enableAnimation</b> in the <b>world</b>
object to <b>false</b> to switch off animation of all components.
</p>

<table border=0 cellspacing=0 cellpadding=0><tr><td valign=\"top\">
<IMG SRC=\"../Images/MultiBody/Examples/Elementary/DoublePendulum.png\"
ALT=\"model Examples.Elementary.DoublePendulum\">
</td></tr></table>

</HTML>"));
end DoublePendulum;
