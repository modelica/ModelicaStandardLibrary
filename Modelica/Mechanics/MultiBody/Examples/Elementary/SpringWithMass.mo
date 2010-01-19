within Modelica.Mechanics.MultiBody.Examples.Elementary;
model SpringWithMass "Point mass hanging on a spring"
  extends Modelica.Icons.Example;
  inner Modelica.Mechanics.MultiBody.World world(animateGravity=false)
    annotation (Placement(transformation(extent={{-40,40},{-20,60}}, rotation=0)));
  Modelica.Mechanics.MultiBody.Forces.Spring spring(
    s_unstretched=0.2,
    m=0.5,
    c=40,
    width=0.1,
    massDiameter=0.07) annotation (Placement(transformation(
        origin={10,30},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Mechanics.MultiBody.Parts.Body body(
    r_0(start={0,-0.3,0}, fixed=true),
    v_0(fixed=true),
    angles_fixed=true,
    w_0_fixed=true,
    r_CM={0,0,0},
    m=1)                    annotation (Placement(transformation(
        origin={10,-10},
        extent={{-10,-10},{10,10}},
        rotation=270)));
equation
  connect(world.frame_b, spring.frame_a)
    annotation (Line(
      points={{-20,50},{10,50},{10,40}},
      color={95,95,95},
      thickness=0.5));
  connect(body.frame_a, spring.frame_b)
    annotation (Line(
      points={{10,0},{10,10},{10,20}},
      color={95,95,95},
      thickness=0.5));
  annotation (experiment(StopTime=5), Documentation(info="<html>
<p>
This example shows that a force component may have a mass.
The 3-dimensional spring as used in this example, has an optional
point mass between the two points where the spring is attached.
In the animation, this point mass is represented by a small,
light blue, sphere.
</p>
<p align=\"center\">
<IMG SRC=\"../Images/MultiBody/Examples/Elementary/SpringWithMass.png\"
ALT=\"model Examples.Elementary.SpringWithMass\">
</p>
</html>"));
end SpringWithMass;
