encapsulated model Pendulum
  "Simple pendulum with one revolute joint and one body"
  import Modelica;
  import Modelica.Mechanics.MultiBody;
  extends Modelica.Icons.Example;
  annotation (
    experiment(StopTime=5),
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
This simple model demonstrates that by just dragging components
default animation is defined that shows the structure of the
assembled system.
<p align=\"center\">
<IMG SRC=\"../Images/MultiBody/Examples/Elementary/Pendulum.png\"
ALT=\"model Examples.Elementary.Pendulum\">
</p>
</html>"));
  inner MultiBody.World world(gravityType=MultiBody.Types.GravityTypes.
        UniformGravity) annotation (extent=[-60, 0; -40, 20]);
  MultiBody.Joints.ActuatedRevolute rev(n={0,0,1}, initType=MultiBody.Types.
        Init.PositionVelocity) annotation (extent=[-20, 0; 0, 20]);
  Modelica.Mechanics.Rotational.Damper damper(d=0.1)
    annotation (extent=[-20, 40; 0, 60]);
  MultiBody.Parts.Body body(m=1.0, r_CM={0.5,0,0})
    annotation (extent=[20, 0; 40, 20]);
equation
  connect(world.frame_b, rev.frame_a)
    annotation (points=[-39, 10; -21, 10], style(color=0, thickness=2));
  connect(damper.flange_b, rev.axis) annotation (points=[0, 50; 4, 50; 4, 26; -10,
         26; -10, 20], style(color=0));
  connect(rev.bearing, damper.flange_a) annotation (points=[-16, 20; -16, 26; -28,
         26; -28, 50; -20, 50], style(color=0));
  connect(body.frame_a, rev.frame_b) annotation (points=[19, 10; 1, 10], style(
      color=0,
      thickness=2,
      gradient=2));
end Pendulum;
