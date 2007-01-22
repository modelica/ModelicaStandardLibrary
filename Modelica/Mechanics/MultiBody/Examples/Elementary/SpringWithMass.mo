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
  inner Modelica.Mechanics.MultiBody.World world(animateGravity=false) 
    annotation (extent=[-40, 40; -20, 60]);
  Modelica.Mechanics.MultiBody.Forces.Spring spring(
    s_unstretched=0.2,
    m=0.5,
    c=40,
    width=0.1,
    massDiameter=0.07) annotation (extent=[0, 20; 20, 40], rotation=-90);
  Modelica.Mechanics.MultiBody.Parts.Body body(initType=Modelica.Mechanics.MultiBody.Types.Init.PositionVelocity,
      r_0_start={0,-0.3,0}) annotation (extent=[0, -20; 20, 0], rotation=-90);
equation 
  connect(world.frame_b, spring.frame_a) 
    annotation (points=[-20,50; 10,50; 10,40], style(
      color=10,
      rgbcolor={95,95,95},
      thickness=2));
  connect(body.frame_a, spring.frame_b) 
    annotation (points=[10,0; 10,20], style(
      color=10,
      rgbcolor={95,95,95},
      thickness=2));
end SpringWithMass;
