model SpringWithMass "Point mass hanging on a spring"
  extends Modelica.Icons.Example;
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
  inner MultiBody.World world(animateGravity=false)
    annotation (extent=[-40, 40; -20, 60]);
  MultiBody.Forces.Spring spring(
    s_unstretched=0.2,
    m=0.5,
    c=40,
    width=0.1,
    massDiameter=0.07) annotation (extent=[0, 20; 20, 40], rotation=-90);
  MultiBody.Parts.Body body(initType=MultiBody.Types.Init.PositionVelocity,
      r_0_start={0,-0.3,0}) annotation (extent=[0, -20; 20, 0], rotation=-90);
equation
  connect(world.frame_b, spring.frame_a)
    annotation (points=[-19, 50; 10, 50; 10, 41], style(color=0));
  connect(body.frame_a, spring.frame_b)
    annotation (points=[10, 1; 10, 19], style(color=0));
end SpringWithMass;
