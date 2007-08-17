within Modelica.Mechanics.MultiBody.Examples.Elementary;
model DoublePendulum 
  "Simple double pendulum with two revolute joints and two bodies" 
  
  extends Modelica.Icons.Example;
  annotation (
    experiment(StopTime=3),
    Coordsys(
      extent=[-100, -100; 100, 100],
      grid=[2, 2],
      component=[20, 20]),
    Window(
      x=0.29,
      y=0,
      width=0.71,
      height=0.85),
    Diagram,
    Documentation(info="<html>
<p>
This example demonstrates that by using joint and body
elements animation is automatically available. Also the revolute
joints are animated. Note, that animation of every component
can be switched of by setting the first parameter <b>animation</b>
to <b>false</b> or by setting <b>enableAnimation</b> in the <b>world</b>
object to <b>false</b> to switch off animation of all components.
</p>
<p align=\"center\">
<IMG SRC=\"../Images/MultiBody/Examples/Elementary/DoublePendulum.png\" 
ALT=\"model Examples.Elementary.DoublePendulum\">
</p>
</HTML>"));
  inner Modelica.Mechanics.MultiBody.World world annotation (extent=[-88, 0; -68, 20]);
  Modelica.Mechanics.MultiBody.Joints.ActuatedRevolute revolute1(initType=Modelica.Mechanics.MultiBody.Types.Init.
        PositionVelocity) annotation (extent=[-48, 0; -28, 20]);
  Modelica.Mechanics.Rotational.Damper damper(d=0.1) 
    annotation (extent=[-48, 40; -28, 60]);
  Modelica.Mechanics.MultiBody.Parts.BodyBox boxBody1(r={0.5,0,0}, width=0.06) 
    annotation (extent=[-10, 0; 10, 20]);
  Modelica.Mechanics.MultiBody.Joints.Revolute revolute2(initType=Modelica.Mechanics.MultiBody.Types.Init.
        PositionVelocity) annotation (extent=[32, 0; 52, 20]);
  Modelica.Mechanics.MultiBody.Parts.BodyBox boxBody2(r={0.5,0,0}, width=0.06) 
    annotation (extent=[74, 0; 94, 20]);
equation 
  
  connect(damper.flange_b, revolute1.axis) annotation (points=[-28, 50; -24, 50;
         -24, 28; -38, 28; -38, 20], style(color=0));
  connect(revolute1.bearing, damper.flange_a) annotation (points=[-44, 20; -44,
         28; -58, 28; -58, 50; -48, 50], style(color=0));
  connect(revolute1.frame_b, boxBody1.frame_a) 
    annotation (points=[-28,10; -10,10], style(
      color=10,
      rgbcolor={95,95,95},
      thickness=2));
  connect(revolute2.frame_b, boxBody2.frame_a) 
    annotation (points=[52,10; 74,10], style(
      color=10,
      rgbcolor={95,95,95},
      thickness=2));
  connect(boxBody1.frame_b, revolute2.frame_a) 
    annotation (points=[10,10; 32,10], style(
      color=10,
      rgbcolor={95,95,95},
      thickness=2));
  connect(world.frame_b, revolute1.frame_a) 
    annotation (points=[-68,10; -48,10], style(
      color=10,
      rgbcolor={95,95,95},
      thickness=2));
end DoublePendulum;
