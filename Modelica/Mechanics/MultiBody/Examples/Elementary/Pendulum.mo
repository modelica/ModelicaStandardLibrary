within Modelica.Mechanics.MultiBody.Examples.Elementary;
model Pendulum "Simple pendulum with one revolute joint and one body"
  extends Modelica.Icons.Example;
  inner Modelica.Mechanics.MultiBody.World world(gravityType=Modelica.Mechanics.MultiBody.Types.GravityTypes.
        UniformGravity) annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Mechanics.MultiBody.Joints.Revolute rev(n={0,0,1},useAxisFlange=true,
    phi(fixed=true),
    w(fixed=true)) annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  Modelica.Mechanics.Rotational.Components.Damper damper(
                                              d=0.1)
    annotation (Placement(transformation(extent={{-20,30},{0,50}})));
  Modelica.Mechanics.MultiBody.Parts.Body body(m=1.0, r_CM={0.5,0,0})
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
equation
  connect(world.frame_b, rev.frame_a)
    annotation (Line(
      points={{-40,0},{-20,0}},
      color={95,95,95},
      thickness=0.5));
  connect(damper.flange_b, rev.axis) annotation (Line(points={{0,40},{0,20},{-10,20},{-10,10}}));
  connect(rev.support, damper.flange_a) annotation (Line(points={{-16,10},{-16,20},{-20,20},{-20,40}}));
  connect(body.frame_a, rev.frame_b) annotation (Line(
      points={{20,0},{0,0}},
      color={95,95,95},
      thickness=0.5));
  annotation (
    experiment(StopTime=5),
    Documentation(info="<html>
<p>
This simple model demonstrates that by just dragging components
default animation is defined that shows the structure of the
assembled system.
</p>
<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/Pendulum.png\"
alt=\"model Examples.Elementary.Pendulum\">
</blockquote>
</html>"));
end Pendulum;
