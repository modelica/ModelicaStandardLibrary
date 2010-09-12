within Modelica.Mechanics.MultiBody.Examples.Elementary;
model Pendulum "Simple pendulum with one revolute joint and one body"
  extends Modelica.Icons.Example;
  inner Modelica.Mechanics.MultiBody.World world(gravityType=Modelica.Mechanics.MultiBody.Types.GravityTypes.
        UniformGravity) annotation (Placement(transformation(extent={{-60,0},{
            -40,20}}, rotation=0)));
  Modelica.Mechanics.MultiBody.Joints.Revolute rev(n={0,0,1},useAxisFlange=true,
    phi(fixed=true),
    w(fixed=true))             annotation (Placement(transformation(extent={{
            -20,0},{0,20}}, rotation=0)));
  Modelica.Mechanics.Rotational.Components.Damper damper(
                                              d=0.1)
    annotation (Placement(transformation(extent={{-20,40},{0,60}}, rotation=0)));
  Modelica.Mechanics.MultiBody.Parts.Body body(m=1.0, r_CM={0.5,0,0})
    annotation (Placement(transformation(extent={{20,0},{40,20}}, rotation=0)));
equation
  connect(world.frame_b, rev.frame_a)
    annotation (Line(
      points={{-40,10},{-20,10}},
      color={95,95,95},
      thickness=0.5));
  connect(damper.flange_b, rev.axis) annotation (Line(points={{0,50},{4,50},{4,
          26},{-10,26},{-10,20}}, color={0,0,0}));
  connect(rev.support, damper.flange_a) annotation (Line(points={{-16,20},{-16,
          26},{-28,26},{-28,50},{-20,50}}, color={0,0,0}));
  connect(body.frame_a, rev.frame_b) annotation (Line(
      points={{20,10},{0,10}},
      color={95,95,95},
      thickness=0.5));
  annotation (
    experiment(StopTime=5),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics),
    Documentation(info="<html>
<p>
This simple model demonstrates that by just dragging components
default animation is defined that shows the structure of the
assembled system.

<IMG src=\"modelica://Modelica/Resources/Images/MultiBody/Examples/Elementary/Pendulum.png\"
ALT=\"model Examples.Elementary.Pendulum\">
</html>"));
end Pendulum;
